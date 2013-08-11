all: genetic

win32: genetic.exe

CXXFLAGS=-O3 `sdl-config --cflags`
LDFLAGS=`sdl-config --libs` -s --strip-unneeded
OBJECTS=genetic.o serializer.o streamer.o image.o
CROSSOBJECTS=$(patsubst %.o, %.w, $(OBJECTS))
CROSSDIR = /usr/i586-mingw32msvc
CROSSCFLAGS = -O3  -I$(CROSSDIR)/include/SDL
CROSSLIBS = -s  -mno-cygwin -lcomdlg32 -lmingw32 -lSDLmain -lSDL 
CROSSCC = $(CROSSDIR)/bin/gcc
CROSSCXX = $(CROSSDIR)/bin/g++

%.w: %.cpp
	$(CROSSCXX) $(CROSSCFLAGS) -o $@ -c $<

genetic: $(OBJECTS)
	$(CXX) -o $@ $(CXXFLAGS) $(OBJECTS) $(LDFLAGS)

genetic.exe: $(CROSSOBJECTS)
	$(CROSSCXX) -o $@ $(CROSSCFLAGS) $(CROSSOBJECTS) $(CROSSLIBS)
	
clean:
	rm -f genetic.exe genetic $(OBJECTS) $(CROSSOBJECTS)
	 

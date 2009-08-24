Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2009 15:15:14 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: bluez-4.49 does not build for me.
Message-ID: <20090824151514.6eb4f1f6@stoetzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

tried to build the tarball release:

seife@stoetzler:~/tmp> tar xf bluez-4.49.tar.gz 
seife@stoetzler:~/tmp> cd bluez-4.49/           
seife@stoetzler:~/tmp/bluez-4.49> ./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --libdir=/usr/lib64 --libexecdir=/lib --localstatedir=/var --enable-alsa --enable-usb --enable-netlink --enable-tools --enable-bccmd --enable-hid2hci --enable-dfutool --enable-cups --enable-test --enable-pand --enable-dund --enable-configfiles --enable-pcmcia                   
checking for a BSD-compatible install... /usr/bin/install -c                                                      
checking whether build environment is sane... yes                                                                 
checking for a thread-safe mkdir -p... /bin/mkdir -p                                                              
checking for gawk... gawk                                                                                         
checking whether make sets $(MAKE)... yes                                                                         
checking whether to enable maintainer-specific portions of Makefiles... no                                        
checking for pkg-config... /usr/bin/pkg-config                                                                    
checking pkg-config is at least version 0.9.0... yes                                                              
checking for gcc... gcc                                                                                           
checking for C compiler default output file name... a.out                                                         
checking whether the C compiler works... yes                                                                      
checking whether we are cross compiling... no                                                                     
checking for suffix of executables...                                                                             
checking for suffix of object files... o                                                                          
checking whether we are using the GNU C compiler... yes                                                           
checking whether gcc accepts -g... yes                                                                            
checking for gcc option to accept ISO C89... none needed                                                          
checking for style of include used by make... GNU                                                                 
checking dependency style of gcc... gcc3                                                                          
checking whether gcc and cc understand -c and -o together... yes                                                  
checking whether gcc accepts -fPIE... yes                                                                         
checking for a BSD-compatible install... /usr/bin/install -c                                                      
checking for bison... bison -y                                                                                    
checking for flex... flex                                                                                         
checking lex output file root... lex.yy                                                                           
checking lex library... -lfl                                                                                      
checking whether yytext is a pointer... yes                                                                       
checking build system type... x86_64-unknown-linux-gnu                                                            
checking host system type... x86_64-unknown-linux-gnu                                                             
checking for a sed that does not truncate output... /usr/bin/sed                                                  
checking for grep that handles long lines and -e... /usr/bin/grep                                                 
checking for egrep... /usr/bin/grep -E                                                                            
checking for fgrep... /usr/bin/grep -F                                                                            
checking for ld used by gcc... /usr/x86_64-suse-linux/bin/ld                                                      
checking if the linker (/usr/x86_64-suse-linux/bin/ld) is GNU ld... yes                                           
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B                                             
checking the name lister (/usr/bin/nm -B) interface... BSD nm                                                     
checking whether ln -s works... yes                                                                               
checking the maximum length of command line arguments... 1572864                                                  
checking whether the shell understands some XSI constructs... yes                                                 
checking whether the shell understands "+="... yes                                                                
checking for /usr/x86_64-suse-linux/bin/ld option to reload object files... -r                                    
checking for objdump... objdump                                                                                   
checking how to recognize dependent libraries... pass_all                                                         
checking for ar... ar                                                                                             
checking for strip... strip                                                                                       
checking for ranlib... ranlib                                                                                     
checking command to parse /usr/bin/nm -B output from gcc object... ok                                             
checking how to run the C preprocessor... gcc -E                                                                  
checking for ANSI C header files... yes                                                                           
checking for sys/types.h... yes                                                                                   
checking for sys/stat.h... yes                                                                                    
checking for stdlib.h... yes                                                                                      
checking for string.h... yes                                                                                      
checking for memory.h... yes                                                                                      
checking for strings.h... yes                                                                                     
checking for inttypes.h... yes                                                                                    
checking for stdint.h... yes                                                                                      
checking for unistd.h... yes                                                                                      
checking for dlfcn.h... yes                                                                                       
checking for objdir... .libs                                                                                      
checking if gcc supports -fno-rtti -fno-exceptions... no                                                          
checking for gcc option to produce PIC... -fPIC -DPIC                                                             
checking if gcc PIC flag -fPIC -DPIC works... yes                                                                 
checking if gcc static flag -static works... yes                                                                  
checking if gcc supports -c -o file.o... yes                                                                      
checking if gcc supports -c -o file.o... (cached) yes                                                             
checking whether the gcc linker (/usr/x86_64-suse-linux/bin/ld -m elf_x86_64) supports shared libraries... yes    
checking whether -lc should be explicitly linked in... no                                                         
checking dynamic linker characteristics... GNU/Linux ld.so                                                        
checking how to hardcode library paths into programs... immediate                                                 
checking whether stripping libraries is possible... yes                                                           
checking if libtool supports shared libraries... yes                                                              
checking whether to build shared libraries... yes                                                                 
checking whether to build static libraries... no                                                                  
checking for ppoll... yes                                                                                         
checking for dlopen in -ldl... yes                                                                                
checking for DBUS... yes                                                                                          
checking for dbus_watch_get_unix_fd in -ldbus-1... yes                                                            
checking for GLIB... yes                                                                                          
checking for ALSA... yes                                                                                          
checking for clock_gettime in -lrt... yes                                                                         
checking for GSTREAMER... no
checking for USB... yes
checking for usb_get_busses in -lusb... yes
checking for usb_interrupt_read in -lusb... yes
checking for NETLINK... yes
checking for SNDFILE... no
configure: creating ./config.status
config.status: creating Makefile
config.status: creating scripts/bluetooth.rules
config.status: creating doc/version.xml
config.status: creating src/bluetoothd.8
config.status: creating bluez.pc
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands
seife@stoetzler:~/tmp/bluez-4.49> make
make --no-print-directory all-am
  CC     audio/audio_libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo
  CC     audio/audio_libasound_module_pcm_bluetooth_la-ipc.lo
  CC     sbc/sbc_libsbc_la-sbc.lo
  CC     sbc/sbc_libsbc_la-sbc_primitives.lo
  CC     sbc/sbc_libsbc_la-sbc_primitives_mmx.lo
  CC     sbc/sbc_libsbc_la-sbc_primitives_neon.lo
  CCLD   sbc/libsbc.la
  CC     lib/bluetooth.lo
  CC     lib/hci.lo
  CC     lib/sdp.lo
In file included from lib/sdp.c:50:
lib/sdp_lib.h:31:33: error: bluetooth/bluetooth.h: No such file or directory
lib/sdp_lib.h:32:27: error: bluetooth/hci.h: No such file or directory
make[1]: *** [lib/sdp.lo] Error 1
make: *** [all] Error 2


a following "make clean" or "make distclean" is also interesting:

[...]
rm -rf src/.libs src/_libs
rm -rf test/.libs test/_libs
rm -rf tools/.libs tools/_libs
gcc -Wall -O2 -D_FORTIFY_SOURCE=2 -fPIC  -pie  lib/bluetooth.c   -o lib/bluetooth
/usr/lib64/gcc/x86_64-suse-linux/4.4/../../../../lib64/Scrt1.o: In function `_start':
/usr/src/packages/BUILD/glibc-2.10.1/csu/../sysdeps/x86_64/elf/start.S:99: undefined reference to `main'
collect2: ld returned 1 exit status
make: *** [lib/bluetooth] Error 1

I'll start looking into it.

Best regards,

	Stefan
-- 
Stefan Seyfried
R&D Preload Department             |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)

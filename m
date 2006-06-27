Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 27 Jun 2006 11:56:53 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6297d67c0606270126k2217235fwbc7fd3b56b1007dc@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0606271146090.6782@redbean.intranet.gw-instruments.de>
References: <6297d67c0606262242q11b6e769r15a48f1edffaa759@mail.gmail.com>
	<1151393851.25011.7.camel@localhost>
	<6297d67c0606270126k2217235fwbc7fd3b56b1007dc@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Kernel Modules for ARM
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi Manyak,

> I already have a 2.4.21 kernel running, but I cannot see any of the kernel
> modules for BlueZ, e.g. bluez.o, l2cap.o, rfcomm.o in the directory
> /lib/modules/kernel.
> 
> So does that mean that my kernel was compiled without Bluetooth support?
> - If yes, is there any way with which I can enable Bluetooth support? (Will
> I have to recompile the kernel?)
> - Or can I directly apply some patch by which I can get those kernel
> modules?
Have you tried to compile the kernel Modules as build in ?? This avoids 
all possible module path problems and stuff in the first place. 

I also would recommend using a 2.6 kernel. We do not have any problems 
with it (at least not with the BlueZ part). 

Below is my build script for cross compiling bluez libs and utils. Maybe 
this helps.
TARGET is set to arm-linux and XPREFIX is the path to the target device 
root on the build machine. Maybe this helps. 

Ciao, 

Peter 
 
#!/bin/sh
# build bluez libs / tools for WPC 

export BUILD_ARCH=arm

. build-config.env

#export target cross tools 
export AR="$TARGET-ar"
export LD="$TARGET-ld"
export CC="$TARGET-gcc"
export GCC="$TARGET-gcc"

export LINUX_DIR=$PWD/$KERNEL_SRC

# configure and make bluez libs 
pushd bluez/bluez-libs-2.25
./configure --host=$TARGET --build=i686-pc-linux-gnu \
            --with-kernel=$LINUX_DIR \
            --libdir=/lib --includedir=/include
make
echo
echo "Installing Bluez Libs in $XPREFIX"
echo 
make install DESTDIR=$XPREFIX
popd

# configure and make bluez utils
# export PKG_CONFIG_PATH="$XPREFIX/lib/pkgconfig"
pushd bluez/bluez-utils-2.25
./configure --enable-bccmd --prefix=$XPREFIX --host=$TARGET 
--build=i686-pc-linux-gnu \
            --with-kernel=$LINUX_DIR \
            --libdir=$XPREFIX/lib --includedir=$XPREFIX/include
#            --sysconfdir=/etc 
#            --without-glib
# can't figure out how to get this right .......... so... 
echo "#undef CONFIGDIR" >> config.h 
echo "#define CONFIGDIR \"/etc/bluetooth\"" >> config.h 
make
make install
popd



|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

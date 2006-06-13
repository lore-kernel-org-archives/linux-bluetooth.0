Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 13 Jun 2006 11:22:38 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.63.0606131103210.23334@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Subject: [Bluez-devel] bluez-utils-3.0 cross compile broken
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


Dear all, 

somewhere on the road from 2.25 (last working for me) and 3.0 (not 
working) the configure script for bluez utils seems to get broken if the 
bluez libs are not in the standard place. Neither setting --libdir=.... 
nor setting environment variable BLUEZ_LIB works. The configure script 
always stops because it doesn't find the BLUEZ libs (error: Bluetooth 
library is required). The library is definitly where it should be. 
My build script looks like this: 

# configure and make bluez utils
export BLUEZ_LIB="$XPREFIX/lib"
pushd bluez/bluez-utils-3.0
./configure --prefix=$XPREFIX --host=$TARGET --build=i686-pc-linux-gnu \
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

Does anybody know how to get this working again ?? 

Thank you and best regards, 

Peter  

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

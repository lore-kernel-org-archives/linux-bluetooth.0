Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Dirk Vornheder <DVornheder@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404182321.55431.dvornheder@t-online.de>
References: <200404182321.55431.dvornheder@t-online.de>
Content-Type: text/plain
Message-Id: <1082325338.4403.27.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 18 Apr 2004 23:55:38 +0200

Hi Dirk,

> Compile bluez-bluefw-1.0 fails:
> 
> make[1]: Leaving directory `/privat/bluetooth/bluez-bluefw-1.0/hotplug'
> make[1]: Entering directory `/privat/bluetooth/bluez-bluefw-1.0'
> source='bluefw.c' object='bluefw.o' libtool=no \
> depfile='.deps/bluefw.Po' tmpdepfile='.deps/bluefw.TPo' \
> depmode=gcc3 /bin/sh ./depcomp \
> gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" 
> -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"bluez-bluefw\" 
> -DVERSION=\"1.0\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 
> -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 
> -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DBT3C_SUPPORT=1  -I. 
> -I. -I/usr/src/linux/include    -Wall -g -O2 -c `test -f 'bluefw.c' || echo 
> './'`bluefw.c
> In file included from usblib.h:30,
>                  from bluefw.c:39:
> /usr/src/linux/include/linux/usbdevice_fs.h:49: error: variable or field 
> `__user' declared void
> /usr/src/linux/include/linux/usbdevice_fs.h:49: warning: no semicolon at end 
> of struct or union
> /usr/src/linux/include/linux/usbdevice_fs.h:49: error: parse error before '*' 
> token
> /usr/src/linux/include/linux/usbdevice_fs.h:56: error: variable or field 
> `__user' declared void
> /usr/src/linux/include/linux/usbdevice_fs.h:56: warning: no semicolon at end 
> of struct or union
> /usr/src/linux/include/linux/usbdevice_fs.h:56: error: parse error before '*' 
> token
> /usr/src/linux/include/linux/usbdevice_fs.h:100: error: variable or field 
> `__user' declared void
> /usr/src/linux/include/linux/usbdevice_fs.h:100: warning: no semicolon at end 
> of struct or union
> /usr/src/linux/include/linux/usbdevice_fs.h:100: error: parse error before '*' 
> token
> /usr/src/linux/include/linux/usbdevice_fs.h:109: error: parse error before '}' 
> token
> /usr/src/linux/include/linux/usbdevice_fs.h:116: error: variable or field 
> `__user' declared void
> /usr/src/linux/include/linux/usbdevice_fs.h:116: warning: no semicolon at end 
> of struct or union
> /usr/src/linux/include/linux/usbdevice_fs.h:116: error: parse error before '*' 
> token
> make[1]: *** [bluefw.o] Error 1
> 
> I use kernel 2.6.6-rc1-bk2 !

we include kernel headers, which is really not a good idea. This must be
fixed, but actually I don't have much time for looking into it.

Use the bcm203x kernel driver instead for loading the firmware into a
Broadcom based USB dongle.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

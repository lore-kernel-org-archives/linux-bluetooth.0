Return-Path: <skronenberger@web.de>
Date: Fri, 13 Aug 2004 21:47:54 +0200
From: Sigrid Kronenberger <skronenberger@web.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
Message-Id: <20040813214754.2a937199@localhost>
In-Reply-To: <1092425535.4501.34.camel@pegasus>
References: <20040811231204.18574a27@localhost>
	<1092262417.4564.259.camel@pegasus>
	<20040812194818.7d3d1ce6@localhost>
	<1092334021.28711.169.camel@pegasus>
	<20040812203428.0bd25290@localhost>
	<1092336801.28711.172.camel@pegasus>
	<20040813210346.6c40aed3@localhost>
	<1092424207.4501.27.camel@pegasus>
	<20040813212742.404662f2@localhost>
	<1092425535.4501.34.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: skronenberger@web.de
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 13 Aug 2004 21:32:15 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

Hi Marcel,=20

>=20
> check the permissions of both. What does these two commands say?
>=20
> 	ls -la /etc/hotplug
> 	ls -la /usr/lib/hotplug/firmware

OK, here are the results:=20

[root@localhost sigrid]# ls -la /etc/hotplug
insgesamt 268
drwxr-xr-x   5 root root   4096 Aug  5 22:49 ./
drwxr-xr-x  73 root root   4096 Aug 13 20:46 ../
-rw-r--r--   1 root root    695 M=E4r 25 10:52 blacklist
-rwxr-xr-x   1 root root   6369 M=E4r 25 10:52 dasd.agent*
-rwxr-xr-x   1 root root   1124 M=E4r 25 10:52 firmware.agent*
-rwxr-xr-x   1 root root   5521 M=E4r 25 10:52 hotplug.functions*
drwxr-xr-x   2 root root   4096 Aug  5 22:49 ieee1394/
-rwxr-xr-x   1 root root   2904 M=E4r 25 10:52 ieee1394.agent*
-rwxr-xr-x   1 root root   6830 M=E4r 25 10:52 input.agent*
-rwxr-xr-x   1 root root   3148 M=E4r 25 10:52 input.rc*
-rwxr-xr-x   1 root root   2283 M=E4r 25 10:52 net.agent*
drwxr-xr-x   2 root root   4096 M=E4r 25 10:52 pci/
-rwxr-xr-x   1 root root   3978 M=E4r 25 10:52 pci.agent*
-rwxr-xr-x   1 root root   2031 M=E4r 25 10:52 pci.rc*
-rwxr-xr-x   1 root root   2323 M=E4r 25 10:52 scsi.agent*
-rwxr-xr-x   1 root root   6967 M=E4r 25 10:52 tape.agent*
drwxr-xr-x   2 root root   4096 Aug 11 20:06 usb/
-rwxr-xr-x   1 root root  13544 M=E4r 25 10:52 usb.agent*
-rw-r--r--   1 root root  38952 M=E4r 25 10:52 usb.distmap
-rw-r--r--   1 root root   4364 M=E4r 25 10:52 usb.handmap
-rwxr-xr-x   1 root root  13355 M=E4r 25 10:52 usb.rc*
-rw-r--r--   1 root root 102230 Aug  5 22:52 usb.usermap
[root@localhost sigrid]#


and=20

[root@localhost sigrid]# ls -la /usr/lib/hotplug/firmware
insgesamt 424
drwxr-xr-x  2 root   root     4096 Aug  9 22:13 ./
drwxr-xr-x  6 root   root     4096 Aug  6 20:31 ../
-rw-------  1 sigrid sigrid 418352 Aug 13 21:28 bfubase.frm
[root@localhost sigrid]#


>=20
> Attach the firmware.agent script so we can look inside.

Done ;)


#!/bin/sh
#
# Firmware-specific hotplug policy agent.
#
# Kernel firmware hotplug params include:
#
#       ACTION=3D%s [add or remove]
#       DEVPATH=3D%s [in 2.5 kernels, /sys/$DEVPATH]
#       FIRMWARE=3D%s
#
# HISTORY:
#
# 24-Jul-2003   Initial version of "new" hotplug agent.
#
# $Id: firmware.agent,v 1.1 2003/10/07 19:34:19 kroah Exp $
#

cd /etc/hotplug
. hotplug.functions
# DEBUG=3Dyes export DEBUG

# directory of the firmware files
FIRMWARE_DIR=3D/usr/lib/hotplug/firmware

# mountpoint of sysfs
SYSFS=3D$(sed -n 's/^.* \([^ ]*\) sysfs .*$/\1/p' /proc/mounts)

# use /proc for 2.4 kernels
if [ "$SYSFS" =3D "" ]; then
    SYSFS=3D/proc
fi

#
# What to do with this firmware hotplug event?
#
case "$ACTION" in

add)
    if [ ! -e $SYSFS/$DEVPATH/loading ]; then
        sleep 1
    fi

    if [ -f $FIRMWARE_DIR/$FIRMWARE ]; then
        echo 1 > $SYSFS/$DEVPATH/loading
        cp $FIRMWARE_DIR/$FIRMWARE $SYSFS/$DEVPATH/data
        echo 0 > $SYSFS/$DEVPATH/loading
    else
        echo -1 > $SYSFS/$DEVPATH/loading
    fi

    ;;

remove)
    ;;

*)
    mesg "Firmware '$ACTION' event not supported"
    exit 1
    ;;

esac





Greetings

Sigrid

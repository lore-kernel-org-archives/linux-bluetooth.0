Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alex Holland <ah160@student.cs.york.ac.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
References: <200404182321.55431.dvornheder@t-online.de> <200404191441.53945.ah160@student.cs.york.ac.uk> <1082382899.4403.46.camel@pegasus>
In-Reply-To: <1082382899.4403.46.camel@pegasus>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EL/gASKSp5No1cc"
Message-Id: <200404191639.48612.ah160@student.cs.york.ac.uk>
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
Date: Mon, 19 Apr 2004 16:39:48 +0100


--Boundary-00=_EL/gASKSp5No1cc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 19 Apr 2004 14:54, Marcel Holtmann wrote:

> check the path for the firmware files in the firmware.agent script.
> Is the script is executable? Is /sys mounted? What are the
> permissions of your firmware files?

firmware.agent is executable. The firmware permissions are as follows:

-rw-r--r--    1 root     root       114688 Apr 19 12:29 BCM2033-FW.bin
-rw-r--r--    1 root     root         3245 Apr 19 12:29 BCM2033-MD.hex

This should be okay, I'd imagine - no need to execute or write to them. 
For the other questions, I've attached firmware.agent, but everything 
looks correct to me.

> You need CONFIG_FW_LOADER, but this should be done automaticly by the
> bcm203x driver and lsmod must show you a firmware_class module.

Yup, this seems to be working; lsmod has the following:

firmware_class          7616  1 bcm203x

Thanks,

Alex Holland

--Boundary-00=_EL/gASKSp5No1cc
Content-Type: application/x-shellscript;
  name="firmware.agent"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="firmware.agent"

#!/bin/sh
#
# Firmware-specific hotplug policy agent.
#
# Kernel firmware hotplug params include:
#
#       ACTION=%s [add or remove]
#       DEVPATH=%s [in 2.5 kernels, /sys/$DEVPATH]
#       FIRMWARE=%s
#
# HISTORY:
#
# 24-Jul-2003   Initial version of "new" hotplug agent.
#
# $Id: firmware.agent,v 1.3 2004/03/14 15:52:56 ukai Exp $
#

cd /etc/hotplug
. ./hotplug.functions
# DEBUG=yes export DEBUG

# directory of the firmware files
FIRMWARE_DIR=/usr/lib/hotplug/firmware

# mountpoint of sysfs
SYSFS=$(sed -n 's/^.* \([^ ]*\) sysfs .*$/\1/p' /proc/mounts)

# use /proc for 2.4 kernels
if [ "$SYSFS" = "" ]; then
    SYSFS=/proc
fi

#
# What to do with this firmware hotplug event?
#
case "$ACTION" in

add)
    if [ ! -e $SYSFS/$DEVPATH/loading ]; then
        sleep 1
    fi

    if [ -f "$FIRMWARE_DIR/$FIRMWARE" ]; then
        echo 1 > $SYSFS/$DEVPATH/loading
        cp "$FIRMWARE_DIR/$FIRMWARE" $SYSFS/$DEVPATH/data
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

--Boundary-00=_EL/gASKSp5No1cc--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

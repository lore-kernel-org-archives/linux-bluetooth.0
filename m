Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Foster <rfoster@mountainvisions.com.au>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-e3LWmZST2EI/iomIuE/b"
Message-Id: <1084180758.3145.10.camel@rover.mountainvisions.com.au>
Mime-Version: 1.0
Subject: [Bluez-devel] [Fwd: Re: [Bluez-users] bluez-utils 2.7 and bthid]
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 10 May 2004 19:19:18 +1000


--=-e3LWmZST2EI/iomIuE/b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry, should have sent this to the list :-|

Rob.

--=-e3LWmZST2EI/iomIuE/b
Content-Disposition: inline
Content-Description: Forwarded message - Re: [Bluez-users] bluez-utils 2.7
	and bthid
Content-Type: message/rfc822

Subject: Re: [Bluez-users] bluez-utils 2.7 and bthid
From: Robert Foster <rfoster@mountainvisions.com.au>
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1084177906.9269.129.camel@pegasus>
References: <1084160685.3287.2.camel@rover.mountainvisions.com.au>
	 <1084177906.9269.129.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-p0nQjz89gRGQ6Ty1kca9"
Organization: Mountain Visions P/L
Message-Id: <1084180461.3145.8.camel@rover.mountainvisions.com.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 May 2004 19:14:21 +1000


--=-p0nQjz89gRGQ6Ty1kca9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

hi Marcel,
I've attached a couple of files.  

bthid1.txt has the commands I executed to install the libs and utils v.
2.7; the bthid commands i executed, as well as the hcidump and system
log entries related to the connection to the mouse.

Interesting to note that I wasn't prompted for a PIN this time, it
simply failed.

Note also that this was working perfectly before the reboot, using the
old 2.6 libs and utils.

I have also set up a rather simple script - /etc/init.d/bluetooth-hid to
automatically connect to the mouse at startup, which gets it's options
from a config file in /etc/bluetooth/hid.conf

Also attached is my hcid.conf file.

Any help greatly appreciated :)

I'm quite happy reverting back to 2.6 (for now), but to satisfy my
curiosity, etc, I'd like to figure out what's going on here :)

Thanks,
Rob.

On Mon, 2004-05-10 at 18:31, Marcel Holtmann wrote:
> Hi Robert,
> 
> > bthid does not seem to play nicely with the recently released
> > bluez-utils 2.7.  Every time I tried to connect to my MS mouse, it would
> > ask for a pin code.  I had to uninstall bluez-{utils|libs} 2.7 and
> > revert back to the 2.6 release before this problem would go away again.
> 
> I haven't seen such problem. Do you enabled auth or encrypt in your
> hcid.conf? Look with hcidump at the connection setup and show it to us.
> 
> Regards
> 
> Marcel
> 
> 

--=-p0nQjz89gRGQ6Ty1kca9
Content-Disposition: attachment; filename=bthid1.txt
Content-Type: text/plain; name=bthid1.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

[rfoster@rover bluez-libs-2.7]$ ./configure

[rfoster@rover bluez-libs-2.7]$ make

[rfoster@rover bluez-libs-2.7]$ su -c 'make install'

[rfoster@rover bluez-libs-2.7]$ cd ../bluez-utils-2.7/

[rfoster@rover bluez-utils-2.7]$ ./configure

[rfoster@rover bluez-utils-2.7]$ make

[rfoster@rover bluez-utils-2.7]$ su -c 'make install'

<reboot>

[rfoster@rover eClient]$ su -
Password:
[root@rover root]# /opt/bluetooth/sbin/bthid --daemon
[root@rover root]# /opt/bluetooth/sbin/bthid --connect 00:50:F2:E5:B5:57

output from hcidump:
HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> HCI Event: Role Change(0x12) plen 8
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: PIN Code Request(0x16) plen 6
< HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Connect Complete(0x03) plen 11
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> HCI Event: Role Change(0x12) plen 8
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: PIN Code Request(0x16) plen 6
< HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11

Output from /var/log/messages:
May 10 18:58:19 rover bthid[3374]: Bluetooth HID service started
May 10 18:59:08 rover hcid[2098]: link_key_request (sba=00:20:E0:85:06:49, dba=00:50:F2:E5:B5:57)
May 10 18:59:08 rover hcid[2098]: pin_code_request (sba=00:20:E0:85:06:49, dba=00:50:F2:E5:B5:57)
May 10 18:59:10 rover hcid[2098]: link_key_request (sba=00:20:E0:85:06:49, dba=00:50:F2:E5:B5:57)
May 10 18:59:10 rover hcid[2098]: pin_code_request (sba=00:20:E0:85:06:49, dba=00:50:F2:E5:B5:57)
May 10 18:59:40 rover bthid[3374]: Connection failed: Host is down (112)
May 10 18:59:40 rover bthid[3374]: Connection failed: Host is down (112)


--=-p0nQjz89gRGQ6Ty1kca9
Content-Disposition: attachment; filename=bluetooth-hid
Content-Type: application/x-shellscript; name=bluetooth-hid
Content-Transfer-Encoding: 7bit

#!/bin/sh
#
# bluetooth-hid    Bluetooth HID starting and stopping
#
# Copyright 2004 Robert Foster <rfoster@mountainvisions.com.au>
#
# chkconfig: 345 50 50
# description: Bluetooth HID
#

# Source function library.
. /etc/rc.d/init.d/functions

# Source Bluetooth HID configuration.
#. /etc/sysconfig/bluetooth-hid

prog="Bluetooth-HID"
#progfile="/usr/bin/hidd"
progfile="/opt/bluetooth/sbin/bthid"
hidconfig="/etc/bluetooth/hid.conf"
lockfile="/var/lock/subsys/bluetooth-hid"

[ -e $hidconfig ] && . $hidconfig

start()
{
        echo -n $"Starting $prog: "

	# Make sure the uinput module is loaded...
	/sbin/modprobe uinput

	# start up the hci0 device...
	/usr/sbin/hciconfig hci0 up

	# start up the bthid service...
	$progfile --daemon

	# Connect to the Bluetooth Mouse
	$progfile --connect $MOUSE_DEV
	echo "$progfile --connect $MOUSE_DEV"
	# Connect to the Bluetooth Keyboard
	$progfile --connect $KEYBD_DEV
        echo
}

stop()
{
        echo -n $"Shutting down $prog: "
	$progfile --kill $MOUSE_DEV
	$progfile --kill $KEYBD_DEV

        rm -f $lockfile

        echo
}

status()
{
	echo "Listing current connections... "
	$progfile --show

	echo
}
[ -f $progfile ] || exit 0

# See how we were called.
case "$1" in
  start)
	start
        ;;
  stop)
	stop
        ;;
  restart|reload)
	stop
	start
	;;
  condrestart)
        [ -e $lockfile ] && (stop; start)
        ;;
  status)
	status
	;;
  *)
        echo $"Usage: $0 {start|stop|restart|reload|condrestart|status}"
        exit 1
esac

exit 0

--=-p0nQjz89gRGQ6Ty1kca9
Content-Disposition: attachment; filename=hcid.conf
Content-Type: text/plain; name=hcid.conf; charset=utf-8
Content-Transfer-Encoding: 7bit

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.3 2002/07/18 18:12:46 maxk Exp $
#

# HCId options
options {
	# Automatically initialize new devices
	autoinit yes;

	# Security Manager mode
	#   none - Security manager disabled
	#   auto - Use local PIN for incoming connections
	#   user - Always ask user for a PIN
	#
	#security user;
	security auto;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# PIN helper
	pin_helper /usr/bin/bluepin;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "Rob's Laptop"; # ( %h - BlueZ (%d) )";

	# Local device class
	#class 0x100;
	class 0x120104;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	#
	#lm accept,master;
	#
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	#
	#lp hold,sniff;
	#
	lp hold,sniff,park,rswitch;

	# Authentication and Encryption
	auth enable;
	encrypt enable;
}

--=-p0nQjz89gRGQ6Ty1kca9--


--=-e3LWmZST2EI/iomIuE/b--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

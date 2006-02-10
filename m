Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: bluez and dbus
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <d8545cc00602091209qdbbbc14oee676e900fa75ece@mail.gmail.com>
References: <d8545cc00602091209qdbbbc14oee676e900fa75ece@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1139533180.17280.38.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 10 Feb 2006 01:59:40 +0100

Hi Doug,

> Installing dbus-0.35 worked as far as that problem goes. Now on to my
> other problem's. :)
> 
> $hidd --search
> Searching ...
>         Connecting to device 00:50:F2:E6:FF:46
> this is the microsoft keyboard.
> no pin required, just connected
> 
> #
> # HCI daemon configuration file.
> #
> 
> # HCId options
> options {
> 	# Automatically initialize new devices
> 	autoinit yes;
> 
> 	# Security Manager mode
> 	#   none - Security manager disabled
> 	#   auto - Use local PIN for incoming connections
> 	#   user - Always ask user for a PIN
> 	#
> 	security user;
> 
> 	# Pairing mode
> 	#   none  - Pairing disabled
> 	#   multi - Allow pairing with already paired devices
> 	#   once  - Pair once and deny successive attempts
> 	pairing multi;
> 
> 	# PIN helper
> 	#pin_helper /usr/bin/bluepin;
>         pin_helper /opt/kde/lib/kdebluetooth/kbluepin
> 	# D-Bus PIN helper
> 	#dbus_pin_helper;
> }
> 
> # Default settings for HCI devices
> device {
> 	# Local device name
> 	#   %d - device id
> 	#   %h - host name
> 	name "BlueZ (%d)";
> 
> 	# Local device class
> 	class 0x3e0100;
> 
> 	# Default packet type
> 	#pkt_type DH1,DM1,HV1;
> 
> 	# Inquiry and Page scan
> 	iscan enable; pscan enable;
> 
> 	# Default link mode
> 	#   none   - no specific policy
> 	#   accept - always accept incoming connections
> 	#   master - become master on incoming connections,
> 	#            deny role switch on outgoing connections
> 	lm accept;
> 
> 	# Default link policy
> 	#   none    - no specific policy
> 	#   rswitch - allow role switch
> 	#   hold    - allow hold mode
> 	#   sniff   - allow sniff mode
> 	#   park    - allow park mode
> 	lp rswitch,hold,sniff,park;
> 
> 	# Authentication and Encryption (Security Mode 3)
> 	#auth enable;
> 	#encrypt enable;
> }
> 
> $hciconfig hci0 reset
> $hciconfig hci0 auth
> nothing changes, mic$ keyboard still work's.
> 
> why does it not ask me for a pin?

use "hcidump -X -V" to check what is going on.

> let me get this authentication stuff straight. With security
> user;:When a device first
> connect's it will need a pin to pair with my dongle correct? after it
> is paired can't
> something like "hciconfig hci0 putkey xx:xx:xx:xx:xx:xx" be done so it
> won't ask for a pin again?

This will store the link key on the chip. However you need a link key
first and in general you only wanna do this if your Bluetooth adapter is
built in.

> I have three bluetooth devices here, but let me get this all figured
> out before I move on from the
> keyboard problem's.
> 
> With the way everything is working right now, I can't reboot and
> regain the connection without "hidd --search"

You connect the keyboard only once. After that the keyboard will
reconnect to you. So you need to run "hidd --server".

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

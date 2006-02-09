Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <d8545cc00602091209qdbbbc14oee676e900fa75ece@mail.gmail.com>
From: Doug Chalmers <nix4me@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Re: bluez and dbus
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
Date: Thu, 9 Feb 2006 13:09:31 -0700

Claudio,
Installing dbus-0.35 worked as far as that problem goes. Now on to my
other problem's. :)

$hidd --search
Searching ...
        Connecting to device 00:50:F2:E6:FF:46
this is the microsoft keyboard.
no pin required, just connected

#
# HCI daemon configuration file.
#

# HCId options
options {
=09# Automatically initialize new devices
=09autoinit yes;

=09# Security Manager mode
=09#   none - Security manager disabled
=09#   auto - Use local PIN for incoming connections
=09#   user - Always ask user for a PIN
=09#
=09security user;

=09# Pairing mode
=09#   none  - Pairing disabled
=09#   multi - Allow pairing with already paired devices
=09#   once  - Pair once and deny successive attempts
=09pairing multi;

=09# PIN helper
=09#pin_helper /usr/bin/bluepin;
        pin_helper /opt/kde/lib/kdebluetooth/kbluepin
=09# D-Bus PIN helper
=09#dbus_pin_helper;
}

# Default settings for HCI devices
device {
=09# Local device name
=09#   %d - device id
=09#   %h - host name
=09name "BlueZ (%d)";

=09# Local device class
=09class 0x3e0100;

=09# Default packet type
=09#pkt_type DH1,DM1,HV1;

=09# Inquiry and Page scan
=09iscan enable; pscan enable;

=09# Default link mode
=09#   none   - no specific policy
=09#   accept - always accept incoming connections
=09#   master - become master on incoming connections,
=09#            deny role switch on outgoing connections
=09lm accept;

=09# Default link policy
=09#   none    - no specific policy
=09#   rswitch - allow role switch
=09#   hold    - allow hold mode
=09#   sniff   - allow sniff mode
=09#   park    - allow park mode
=09lp rswitch,hold,sniff,park;

=09# Authentication and Encryption (Security Mode 3)
=09#auth enable;
=09#encrypt enable;
}

$hciconfig hci0 reset
$hciconfig hci0 auth
nothing changes, mic$ keyboard still work's.

why does it not ask me for a pin?

let me get this authentication stuff straight. With security
user;:When a device first
connect's it will need a pin to pair with my dongle correct? after it
is paired can't
something like "hciconfig hci0 putkey xx:xx:xx:xx:xx:xx" be done so it
won't ask for a pin again?

I have three bluetooth devices here, but let me get this all figured
out before I move on from the
keyboard problem's.

With the way everything is working right now, I can't reboot and
regain the connection without "hidd --search"

thanks for the help thus far

Regard's
Doug


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

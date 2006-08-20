Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
To: bluez-users@lists.sourceforge.net
Date: Sat, 19 Aug 2006 22:03:34 -0600
MIME-Version: 1.0
Message-Id: <200608192203.34883.Linux@feline-soul.com>
Subject: [Bluez-users] Logitech Traveler Headset. Progress but not there
	yet. Advice wanted.
Reply-To: Linux@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Folks,

I just upgraded to versions 3.2 of bluez-utils and bluez-libs and things are 
looking better for getting my headset working.

An "hcitool scan" gives me:
Scanning ...
        00:0D:44:4F:37:72       Logitech HS03  V04

This is a Logitech Mobile Traveler. I turn on the headset and holding down the 
on button to get it to start paring. Then i issue a "hidd --connect 
00:0D:44:4F:37:72" After awhile the headset stops blinking and "Can't get 
device information: Function not implemented" is returned for the 
hidd --connect.

hcidump reports the following:
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
> HCI Event: Connect Complete (0x03) plen 11


Any ideas would be appreciated!

Bearcat M. Sandor

My config files:
#
# HCI daemon configuration file.
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
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # Default PIN code for incoming connections
        passkey "0000";
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "BlueZ (%d)";

        # Local device class
        class 0x3e0100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        lp rswitch,hold,sniff,park;
}

rfcomm.conf:
#
# RFCOMM configuration file.
#

rfcomm0 {
        # Automatically bind the device at startup
        bind no;

        # Bluetooth address of the device
        device 00:0D:44:4F:37:72;

        # RFCOMM channel for the connection
        channel 1;

        # Description of the connection
        comment "Example Bluetooth device";
}








-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

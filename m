Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040901183311.1763.qmail@web11601.mail.yahoo.com>
From: David Zhu <saki96@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] newbie fedora2 & bluez questions
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
Date: Wed, 1 Sep 2004 11:33:11 -0700 (PDT)

Hi All,

I tried following the many howto guides on the web but
I always seem to have problems after a certain step. 
So I hope I'm not offending anyone with what may be a
really simple issue.  Here we go...

I have a DLink DBT-120 Rev 4 USB Bluetooth adapter,
which I have confirmed is supported on the hardware
page.

I've installed the necessary packages from the fedora
core 2:

bluez-libs-2.5-2.1
bluez-utils-2.4-3
gnome-bluetooth-0.4.1-7
bluez-sdp-1.5-2.1

I'm running kernel 2.6.8

so when I do a "hcitool scan" I am able to find:
00:02:EE:E0:2A:E6       Nokia 6820

but when I do a "sdptool browse" I always get 
Inquiring ...
Failed to connect to SDP server on 00:02:EE:E0:2A:E6:
Function not implemented

Now I have a ThinkPad T30 which also has bluetooth,
and again the same thing happens.  But if I try to
browse for bluetooth services from the thinkpad, I get
the PIN request, which I enter what I found in
/et/bluetooth/pin.  So after the two devices are
paired, now when I run sdptool browse I can see the
services offered by the thinkpad but still not the
nokia.  

Does it seem weird that I have to pair before I can
browse for services?  Or is something else
fundamentally wrong?  The other thing is I can't use
the nokia to browse so I can't get it paired with the
Dlink bluetooth adapter.  Please help!

Below is my hcid.conf file:

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
        #   auto - Use local PIN for incoming
connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired
devices
        #   once  - Pair once and deny successive
attempts
        pairing multi;

        # PIN helper
        pin_helper /usr/bin/bluepin;
        #dbus_pin_helper;

        # A dbus PIN daemon can be found at
        #
ftp://ftp.handhelds.org/pub/projects/gpe/source/bluez-pin-0.20.tar.gz
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "%h-%d";

        # Local device class
        class 0x120104;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy 
        #   accept - always accept incoming
connections
        #   master - become master on incoming
connections,
        #            deny role switch on outgoing
connections
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
        lp hold,sniff,park;

        # Authentication and Encryption
        auth enable;
        encrypt enable;
}


Thanks in advance!
David


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

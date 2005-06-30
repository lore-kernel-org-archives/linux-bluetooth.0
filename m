Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Linux@thedragonsedge.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200506301139.37624.Linux@thedragonsedge.com>
Subject: [Bluez-users] Help getting hidd (keyboard and mouse working) in and out of X
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
Date: Thu, 30 Jun 2005 11:39:37 -0600

Hello all,

I've been working all night to try and get my Microsoft Keyboard Elite for 
bluetooth and my Microsoft Intellimouse Explorer for bluetooth working under 
linux.  So far i have been able to get the system to recognise the mouse and 
keyboard.  The mouse works, but the keyboard does not.

I am have the folowing installed:
linux: 2.6.12
bluez-libs and bluez-utils: 2.15

Everything is compiled from source (Sourcemage distro (like Gentoo)  on my AMD 
64 300, in 64-bit mode.

relevent modules loaded (from kernel) are:

rfcomm
hidp
l2cap
hci_usb
bluetooth              52164  16 rfcomm,hidp,l2cap,hci_usb

Relevent config files:
cat /etc/bluetooth/hcid.conf
#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
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

        # PIN helper
        pin_helper /usr/bin/bluepin;

        # D-Bus PIN helper
        #dbus_pin_helper;
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

        # Authentication and Encryption (Security Mode 3)
        #auth enable;
        #encrypt enable;
}

The bloutooh usb dongle seems to be operating just fine.

When enabled the devices are:
        00:50:F2:E7:C9:80       Microsoft Mouse
        00:50:F2:E7:B9:1F       Microsoft Keyboard

My problems are the following:

1. I can get the system to recognize the mouse and keyboard by doing 
combinations of 'hcitool scan' and hidd search.  I seem to have to hit the 
button on the bottom of the mouse and actually reintroduce a battery from the 
keyboard to reestablish the connection with the bluetooth usb dongle.  I'm 
not sure in what combonation these two comands are doing the job as sometimes 
one works and sometimes the other does.  I don't think that the 'hidd 
---server' command i have executing in runlevel 3 actually connects the 
devices.   

2. I need to find out what commands to run so that when i boot up this machine 
the mouse and keyboard are availalble for use.  The mouse is assigned 
to /dev/input/mouse0. I am using /dev/mice in xorg.conf.   I'm not sure were 
the keyboard is in /dev/. Right now i have a ps/2 keyboard plugged in . 

3. Does having a ps/2 keyboard plugged in stop my system from recognising the 
bluetooth one?  

4. How can i get X (my whole system actually) to recognise the keyboard?

5. Am i right that this keyboard will not work ever, for runlevels where the 
bluetooth mods are not loaded, so that i have to keep an extra around to work 
in them and pass kernel options in lilo?

6. Acording http://www.fam-lindeman.nl/content/view/11/34/ and 
http://www.bueche.ch/comp/mx900/mx900.html there is some way to tell a bluez 
config file that you want to use the hidd stack so that you don;t have to run 
all these commands at boot up or get them in the right order etc.  Apparently 
" The trick is to edit /etc/default/bluez-utils and turn on 
HIDD_ENABLED." (to quote the first link) so that your mouse and keyboard come 
back to life with jsut a jiggle and a keypress. That is the goal!!!.    
However i have no such file and i'm not sure how/where to put it 
in /etc/bluetooth/hcid.conf or wether it's actually an environment variable.  
I have looked through the steps of http://klausler.com/msbtkb-linux.html  but 
that's largely opsolete and my kernel is set up properly anyway.  That page 
does reference this setting in all caps, making me think it may be an envar 
of some kind.


Has anyone gotten this keyboard mouse set to work (i know it's been done).  If 
so i could use a little help.

I"ll be glad to provide any aditional information needed.
Thank you. 

Bearcat M. Sandor


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <6ae1569005031012043d7842d8@mail.gmail.com>
From: Adis Beglerovic <emerge.gentoo@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DBT-120 and Siemens S65
In-Reply-To: <422BA06E.6020700@debiancolombia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <6ae1569005030604105d08a56e@mail.gmail.com>
	 <422BA06E.6020700@debiancolombia.org>
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
Date: Thu, 10 Mar 2005 21:04:09 +0100

Hi all

Lets try again ... 
I have fully working bluetooth setup except
when I try to send files to my Siemens S65 with obexftp
It asks to type in pass for Bluez(0) and no mather what I type 
it just not giving me access. 
Pass in /etc/bluetooth/pin is 12345 and phonecode is the same.
Here is the out put what happends when I run :
 /usr/local/bin/obexftp -b 00:01:E3:3C:79:45 -B 5 -p wireless_script
Browsing 00:01:E3:3C:79:45 ...
Channel: 5
No custom transport
Connecting...bt: -1
failed: connect
Still trying to connect
Connecting...bt: -1
failed: connect
Still trying to connect
Connecting...bt: -1
failed: connect
Still trying to connect

After 3 tryes it stops.
Here is my hcdi.conf

# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
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
        security user;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi; # PIN helper
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
        class 0x100;

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
        lp rswitch,hold,sniff,park;

        # Authentication and Encryption
        #auth enable;
        #encrypt enable;
}
------------------------------------------------------------------------------------------------------------



And this is my pin >>>> 12345



-----------------------------------------------------------------------------------------------------------
pin-helper file has this stuff 

#!/bin/sh
echo -n "PIN:"
cat /etc/bluetooth/pin
----------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
And finaly rfcomm.conf
#
# RFCOMM configuration file.
#
# $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
#

rfcomm0 {
        # Automatically bind the device at startup
        bind no;

        # Bluetooth address of the device
        device 11:22:33:44:55:66;

        # RFCOMM channel for the connection
        channel 1;

        # Description of the connection
        comment "Example Bluetooth device";
}
-----------------------------------------------------------------------------------------------


Need to get pass that password issue ....

Thanks


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

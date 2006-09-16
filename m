Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <450C04B0.3040308@fuckaround.org>
Date: Sat, 16 Sep 2006 16:05:36 +0200
From: Pol Hallen <bluez@fuckaround.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Problem send bt files
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Hi all,

I installed bluez-utils (and relative dependence and programs) on my 
debian stable (sarge):

ii  bluez-firmware 1.0-2          Firmware for Bluetooth devices
ii  bluez-hcidump  1.17-1sarge1   Analyses Bluetooth HCI packets
ii  bluez-pin      0.25-1         Bluetooth PIN helper with D-BUS support
ii  bluez-utils    2.15-1.1       Bluetooth tools and daemons

I do a paring from my mobile to my server and is it ok.

I try use obexftp to send a file to my mobile:

obexftp -v -b 00:12:62:E3:B1:DE -B 10 -p file.jpg

but I see:

Browsing 00:12:62:E3:B1:DE ...
Channel: 10
No custom transport
Connecting...bt: 1
done
Sending file.jpg... failed: file.jpg
Disconnetting...done

If i try send a file from my mobile to server (using obexserver) is it ok.


/etc/bluetooth/rfcomm.conf is whole commented, pin file contain only pin 
code..

Here there is my config file:

/etc/bluetooth/hcid.conf

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
         pin_helper /usr/bin/bluez-pin;

         # D-Bus PIN helper
         dbus_pin_helper;
}

# Default settings for HCI devices
device {
         # Local device name
         #   %d - device id
         #   %h - host name
         name "%h-%d";


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

I tried several different configs in /etc/bluetooth/hcid.conf and kill 
hcid  and restart, i also tried /etc/init.d/bluez-utils restart, i also 
tried init 6 but nothing..

I don't understand why can't send any files from my server.. :-((

in /var/log/syslog I see:

hcid[26398]: link_key_request (sba=00:0F:3D:05:99:B7, dba=00:12:62:E3:B1:DE)

Can anyone help me pls?!
Thanks!

Pol

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

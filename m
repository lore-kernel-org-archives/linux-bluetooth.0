Return-Path: <cyrus@holtmann.org>
From: bluez@tjworld.net
To: bluez-devel@lists.sourceforge.net
Cc: 
Message-Id: <1198290096.23921@tjworld.net>
Date: Sat, 22 Dec 2007 02:21:36 +0000 (GMT)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bound1198290096"
Subject: [Bluez-devel] Problems with Service Discovery?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--bound1198290096
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

I'm having some issues getting SDP to list enabled services with Bluez-Utils v3.19 on Ubuntu Gutsy x86_64. I wondered if you could give me some examples of what to expect?

The main issue is that remote devices, when doing service discovery of the PC, report no services. I was expecting to see Network services (NAP or NG) as well as Audio (I wanted to test using the PC as the Internet gateway for bluetooth devices).

Bluetooth itself seems perfectly okay. I'm using a bluetooth mouse, printing to a bluetooth printer, transferring files to and from bluetooth devices, and connecting to bluetooth internet service on the telephone.

hcid is started with options "-c -s" (I've also added -d whilst debugging) and I've set /etc/bluetooth/hcid.conf "device { class 0xFF0100; }" to test it.

I've tried to discover services with a telephone and a PDA. On the PC, using the bluetooth-properties control applet Services tab, after enabling all services none are visible remotely but, strangely, using "sdptool browse local" reports the Audio services.

If gnome-obex-server is running "OBEX Object Push" is reported to remote devices as well as 'sdptool browse local'.

The PDA has a set of Bluetooth Utilities that allows me to manually do a device and then service discovery. All other bluetooth devices report their services correctly. When discovering services provided by the PC the only one ever reported is the OBEX Object Push, if gnome-obex-server is running.

If (Gnome) bluetooth-properties is used to disable the Audio service 'sdptool brose local' stops reporting the audio services, which indicates a service record is being added/deleted correctly.

After looking through the source-code the issue seems to be that only the Audio service in ./audio/manager.c implements add_service_record() which looks to be mapped to the D-Bus command AddServiceRecord. Serial service, Network service and Input service don't appear to implement/use the D-Bus AddServiceRecord mapping.

Maybe this has been addressed in later versions of the bluez-utils code? I've looked at the latest Ubuntu Hardy code (v3.22) but there doesn't seem to be any relevant additions there.

Thanks in advance.

TJ.

----

$ ps -ef | egrep 'blue|hci|obex'
root     18165     1  0 Dec21 ?        00:00:00 /usr/sbin/hcid -x -s -d
root     18175 18165  0 Dec21 ?        00:00:00 /usr/lib/bluetooth/bluetoothd-service-serial
root     18177 18165  0 Dec21 ?        00:00:00 /usr/lib/bluetooth/bluetoothd-service-network
root     18178 18165  0 Dec21 ?        00:00:00 /usr/lib/bluetooth/bluetoothd-service-input
tj       24020 23808  0 Dec21 ?        00:00:00 bluetooth-applet
tj       24074 23808  0 Dec21 ?        00:00:00 gnome-obex-server
root     26722 18165  0 02:07 ?        00:00:00 /usr/lib/bluetooth/bluetoothd-service-audio

~$ sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: Headset Audio Gateway
Service RecHandle: 0x10000
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 12
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: Audio Source
Service RecHandle: 0x10001
Service Class ID List:
  "Audio Source" (0x110a)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 25
  "AVDTP" (0x0019)
    uint16: 0x100
Profile Descriptor List:
  "Advanced Audio" (0x110d)
    Version: 0x0100

Service Name: OBEX Object Push
Service RecHandle: 0x10002
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

$ cat /etc/bluetooth/hcid.conf
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
        security user;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # Default PIN code for incoming connections
        passkey "1234";
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "%h-%d";

        # Local device class
        # class 0x000100;
        class 0xff0100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;
        discovto 0;

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

--bound1198290096
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--bound1198290096
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--bound1198290096--

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46227438.5070800@gmail.com>
Date: Sun, 15 Apr 2007 20:51:36 +0200
From: None <hujumuju@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Problem with dialup connection after bluez update
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

Hello.

I updated bluez packages (bluetooth 3.7-1ubuntu4, bluez-utils 
3.7-1ubuntu4, libbluetooth 3.7-1) on my ubuntu box, and now dialup 
connection with my Pocket Pc device cannot be established. It was 
working like a charm before.

After many problems i have found a way to make my box discoverable and 
pairable, so i can pair my pocket pc and linux box.

Anyway, i cannot established dialup connection - dund is not responding 
at all, but it is running and listening(?)

root@abc:/etc/ppp/peers# ps aux|grep dund
root      2952  0.0  0.4   1660   484 ?        Ss   20:34   0:00 
/usr/bin/dund --listen call dun-mda-bt

dun-mda-bt is located in /etc/ppp/peers/dun-mda-bt and contains:

root@pajonk:/etc/ppp/peers# cat /etc/ppp/peers/dun-mda-bt
115200
local
noipdefault
connect "/etc/ppp/at-cmd.pl -v"
noauth
nodefaultroute
192.168.1.1:192.168.1.10
ms-dns 192.168.1.1
debug

Pocket pc tries to connect but gives an error after 5 seconds. There are 
no syslog and messages log entries when trying to establish connection 
so i don't have any info for debuging.

SDPD is offering dun profile:

Browsing FF:FF:FF:00:00:00 ...
Service Name: LAN Access Point
Service RecHandle: 0x10000
Service Class ID List:
   "LAN Access Using PPP" (0x1102)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 1
Profile Descriptor List:
   "LAN Access Using PPP" (0x1102)
     Version: 0x0100

Service Name: Dial-Up Networking
Service RecHandle: 0x10001
Service Class ID List:
   "Dialup Networking" (0x1103)
   "Generic Networking" (0x1201)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 2
Profile Descriptor List:
   "Dialup Networking" (0x1103)
     Version: 0x0100


My dongle is configures this way:

hci0:   Type: USB
         BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 192:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:323041 acl:507 sco:0 events:30529 errors:0
         TX bytes:17719 acl:494 sco:0 commands:410 errors:0

hcid.conf:

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
         passkey "1234";
}

# Default settings for HCI devices
device {

         discovto 0;

         # Local device name
         #   %d - device id
         #   %h - host name
         name "%h-%d";

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
         lm accept,master;

         # Default link policy
         #   none    - no specific policy
         #   rswitch - allow role switch
         #   hold    - allow hold mode
         #   sniff   - allow sniff mode
         #   park    - allow park mode
         lp rswitch,hold,sniff,park;
}


Thanks for any help!




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

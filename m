Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 18 Dec 2006 02:38:08 -0500
From: zippo <zippo@oppiz.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061218023808.6ca4c27e@zippo01>
Mime-Version: 1.0
Subject: [Bluez-users] BLUETOOTH ERRER: call_passkey_agent
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

Hello, I'm having issues using rfcomm i and getting

Can't connect RFCOMM channel: Connection refused

i have bluex-pin and bluepin installed, both simply return PIN:0000 and
have tried both, also just using passkey "0000" but am lost. here is the
output i have to work with:

using:
bluez-utils 3.7
bluez-libs 3.7
linux-2.6.18.2
I have severl other bluetooth items working a mouse and keyboard.
All modules are loaded that should be loaded
$ lsmod
rfcomm                 36776  0 
snd_bt_sco             14220  0
bnep                   13568  0 
bfusb                  11844  0
hci_usb                17116  4
crc32                   4672  1 bnep
hidp                   14080  2 
l2cap                  21760  15 rfcomm,bnep,hidp

$ hcitool scan
Scanning ...
00:16:8F:41:47:FE       Motorola H700

$ l2ping 00:16:8F:41:47:FE
Ping: 00:16:8F:41:47:FE from 00:07:61:19:61:FD (data size 44) ...
4 bytes from 00:16:8F:41:47:FE id 0 time 28.96ms
4 bytes from 00:16:8F:41:47:FE id 1 time 48.53ms
2 sent, 2 received, 0% loss

$ rfcomm connect 0 00:16:8F:41:47:FE 1
Can't connect RFCOMM socket: Connection refused

$ btsco -v 00:16:8F:41:47:FE
btsco v0.42
Device is 1:0
Voice setting: 0x0060
Can't connect RFCOMM channel: Connection refused

SYSLOG output
Dec 18 02:18:51 zippo01 hcid[22383]: pin_code_request
(sba=00:07:61:19:61:FD, dba=00:16:8F:41:47:FE)
Dec 18 02:18:51 zippo01 hcid[22383]: call_passkey_agent(): no agent
registered

/etc/bluetooth/hcid.conf

options {

        autoinit yes;
        security auto;
        pairing multi;
        passkey "0000";
        pin_helper /usr/bin/bluepin;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "BlueZ at %h (%d)";

        # Local device class
        class 0x3e0100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        lm accept;

        # Default link policy
        lp rswitch,hold,sniff,park;


}

/etc/bluetooth/rfcomm.conf

#
# RFCOMM configuration file.
#

rfcomm0 {
#       # Automatically bind the device at startup
        bind yes;
        device 00:16:8F:41:47:FE;
        channel 1;
        comment "Mototrala H700 Wireless Headset";
}

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

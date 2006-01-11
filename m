Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C581DE.6030205@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-users] headset wont work <sdp?>
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
Date: Thu, 12 Jan 2006 00:08:30 +0200

Thanks to all how helped port bluetooth to linux,
I have joined the mailin-list about a week ago. I notice that Brad and 
Marchel answer ppl, so,let me try to make this a good question:

I am running Gentoo 2005.1 with ck-sources kernel 2.6.14-ck8. I had 
bt_sco working for a while. here is my dongle:
hci0:   Type: USB
        BD Address: 00:10:60:A8:86:A3 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:4112 acl:0 sco:0 events:392 errors:0
        TX bytes:4094 acl:0 sco:0 commands:214 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'blacky does BT device (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 
0x33c
        Manufacturer: Cambridge Silicon Radio (10)

I am tring to use a logitech mobile freedom :
# hcitool info 00:0D:44:33:E1:63
Requesting information ...
        BD Address:  00:0D:44:33:E1:63
        Device Name: Logitech HS02-V07

yet when I try to find the channel:
# sdptool search --bdaddr 00:0D:44:33:E1:63 0x1108
Class 0x1108
Failed to connect to SDP server on 00:0D:44:33:E1:63: Permission denied

my probelm is that I follow the guide at bluetooth-alsa.sourceforge.net 
and when I:
# esdctl stop
blacky niv # hciconfig hci0 voice 0x0060
blacky niv # btsco2 00:0D:44:33:E1:63
Device is 2:0
Voice setting: 0x0060
Can't connect RFCOMM channelCan't connect RFCOMM channelCan't connect 
RFCOMM channelCan't connect RFCOMM channelCan't connect RFCOMM 
channelCan't connect RFCOMM channelCan't connect RFCOMM channelCan't 
connect RFCOMM channelCan't connect RFCOMM channelCan't connect RFCOMM 
channelCan't connect RFCOMM channelCan't connect RFCOMM channelCan't 
connect RFCOMM channet

I also tried it with btsco and even with "1" as it uses channel 1. still 
same response.
I tried restarting both alsa deamon and the bluetooth. same thing.
I think I m using the current version - as I emerged it two days ago, 
how can I tell what version I use?

Thanks a lot,
Niv


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

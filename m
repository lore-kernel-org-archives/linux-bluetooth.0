Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060113090337.27122.qmail@webmaild.fe1.aruba.it>
From: "Peppe Colicchia" <bluez.list@pc-labs.org>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Subject: [Bluez-users] cannot cat /dev/bluetooth/rfcomm/0
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
Date: Fri, 13 Jan 2006 10:03:37 +0100

Hi all,
my ipaq 3870 (with a built-in bluetooth device) is running Familiar Linux 
0.8.2 with OPIE, i would like to use it with a GPS device (Nemerix BT77 
chipset). I was able to get NMEA output time ago, now i'm trying again but 
maybe i'm missing something - so please tell me where i'm wrong: 

root@h3600:~# hciconfig -a
hci0:   Type: UART
       BD Address: 00:02:C7:0C:AA:B5 ACL MTU: 128:8 SCO MTU: 64:8
       UP RUNNING PSCAN ISCAN AUTH ENCRYPT
       RX bytes:929 acl:13 sco:0 events:34 errors:0
       TX bytes:985 acl:12 sco:0 commands:16 errors:0
       Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy: RSWITCH HOLD SNIFF PARK
       Link mode: SLAVE ACCEPT
       Name: 'No name'
       Class: 0x120112
       Service Classes: Networking
       Device Class: Computer, Handheld
       HCI Ver: 1.1 (0x1) HCI Rev: 0x72 LMP Ver: 1.1 (0x1) LMP Subver: 0x72
       Manufacturer: Cambridge Silicon Radio (10)
root@h3600:~# cat /etc/bluetooth/rfcomm.conf
rfcomm0 {
       bind yes;
       device 00:08:1B:8C:3F:A2;
       channel 1;
       comment "BT device";
}
root@h3600:~# cat /etc/bluetooth/pin
0000
root@h3600:~# rfcomm
rfcomm0: 00:08:1B:8C:3F:A2 channel 1 clean
root@h3600:~# hcitool scan
Scanning ...
       00:08:1B:8C:3F:A2       BT GPS
root@h3600:~# ps aux
 -cut-
 788 root        584 S   hcid: processing events
 794 root        532 S   /sbin/sdpd
 988 root        368 S   hciattach -p /dev/ttySB0 bcsp 230400
 -cut-
root@h3600:~# cat /dev/bluetooth/rfcomm/0 

blank. nothing, no output. Time ago with the same O.S. version i was able to 
see the NMEA output, so i used gpsd and a navigator. CTRL-C and... 

root@h3600:~# rfcomm
rfcomm0: 00:08:1B:8C:3F:A2 channel 1 closed 

where is the mistake? any help is appreciated. I have not the hcidump tool 
for my PDA (StrongARM cpu). 

Regards,
Peppe Colicchia 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

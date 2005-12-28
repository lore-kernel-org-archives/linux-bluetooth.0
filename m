Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Prew <r.prewitt@gazeta.pl>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512281907.56522.r.prewitt@gazeta.pl>
Subject: [Bluez-users] pand connection problem
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
Date: Wed, 28 Dec 2005 19:07:56 +0100

Hi.

I have a problem with pand connection beetwen 2 linux boxes.
When I establish connection ping command works, ftp connection works too. But 
when i want list files on ftp server, connection crashes (after that ping 
don't work, pand -l still show connection).
Connection crashes also on other services like internet sharing, samba etc.


hci0:   Type: USB
        BD Address: 00:11:67:1B:14:76 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:3460 acl:55 sco:0 events:102 errors:0
        TX bytes:16018 acl:74 sco:0 commands:21 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: MASTER
        Name: 'BlueZ lukidom'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver: 0x1f4
        Manufacturer: Integrated System Solution Corp. (57)





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

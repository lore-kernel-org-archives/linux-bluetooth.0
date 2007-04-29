Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46352605.1030600@lijer.nl>
Date: Mon, 30 Apr 2007 01:11:01 +0200
From: Henkie <henkie_bluez@lijer.nl>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Nokia 6230i / ipaq h2200
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

Hello,

i have an ipaq h2200 with linux installed on it. This device isnt able
to pair with my nokia 6230i phone (for "security reasons").

I understand this has something to do with the bluetooth chipset.
Is there a workaround available? In winCE this problem was fixed by an
update.

http://h20000.www2.hp.com/bizsupport/TechSupport/SoftwareDescription.jsp?lang=en&cc=us&prodTypeId=215348&prodSeriesId=322908&swItem=PSG_I21093-105126&prodNameId=100773&swEnvOID=1087&swLang=8&taskId=135&mode=4&idx=2

I tested this update today, and it worked, my phone was able to pair
with winCE.



$ hciconfig -a
hci0:   Type: UART
        BD Address: 00:04:3E:83:58:72 ACL MTU: 678:8 SCO MTU: 120:1
        UP RUNNING PSCAN
        RX bytes:3855 acl:27 sco:0 events:111 errors:0
        TX bytes:1378 acl:25 sco:0 commands:48 errors:0
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x120112
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Handheld
        HCI Ver: 1.1 (0x1) HCI Rev: 0x8d LMP Ver: 1.1 (0x1) LMP Subver: 0x8d
        Manufacturer: Zeevo, Inc. (18)


	gr. Henkie

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

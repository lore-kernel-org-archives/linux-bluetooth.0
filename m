Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061118110247.10397.qmail@web52105.mail.yahoo.com>
Date: Sat, 18 Nov 2006 03:02:47 -0800 (PST)
From: Paolo Casaschi <kazavsky67-news@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Errors pairing with headset
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

Trying to connect to my bluetooth headset on a new Ubuntu Edgy install (have'nt touched any of the /etc/bluetooth/*.conf files)





I looked at https://help.ubuntu.com/community/BluetoothSetup for guidance





When my headseat is in pairing mode, if try  




    sudo hidd --search





I get totally no output, not even the "No devices in range or visible" that I get when the headset is off.





But if I try 


      sudo hcitool scan


then my headest is recognized


      aa:bb:cc:dd:ee:ff       BT Headset-12





If I try then


      sudo hidd --connect  aa:bb:cc:dd:ee:ff


I get the error message

    Can't get device information: Permission denied



Tried also
    sudo hcitool cc aa:bb:cc:dd:ee:ff
but got error message
    Can't create connection: Input/output error


Output of sudo hciconfig -a is:

    hci0:   Type: USB

        BD Address: 00:09:DD:50:12:FA ACL MTU: 384:8 SCO MTU: 64:8

        UP RUNNING PSCAN ISCAN 

        RX bytes:1694 acl:0 sco:0 events:62 errors:0

        TX bytes:432 acl:0 sco:0 commands:32 errors:0

        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80

        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 

        Link policy: RSWITCH HOLD SNIFF PARK 

        Link mode: SLAVE ACCEPT 

        Name: 'paolo-laptwo-0'

        Class: 0x3e0100

        Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio

        Device Class: Computer, Uncategorized

        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver: 0x7a6

        Manufacturer: Cambridge Silicon Radio (10)



Tried to search the mailing list, but could not spot anything useful. Any help?



-- Paolo


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

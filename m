Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41B91658.2020103@avantwave.com>
From: mike <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Problem with using HCI_UART driver
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
Date: Fri, 10 Dec 2004 11:22:00 +0800

Dear all
    I have a strange problem with using hciattach to a uart bluetooth 
device . I use a script to attach the device , but i need to attach two 
times to get the build ID.

hciconfig -a :
hci0:   Type: UART
        BD Address: 00:08:E0:01:49:6A ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:189 acl:0 sco:0 events:21 errors:0
        TX bytes:351 acl:0 sco:0 commands:21 errors:0
        Features: 0xff 0xff 0x8b 0x78 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'mike'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x490 LMP Ver: 1.2 (0x2) LMP Subver: 
0x490
        Manufacturer: Cambridge Silicon Radio (10)

script :
hciattach -s 921600 /dev/ttyS1 csr 921600 flow
hciattach -s 921600 /dev/ttyS1 csr 921600 flow


Mike,Lee


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

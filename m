Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Kai Haberzettl <kai@khaberz.net>
Message-ID: <87r7mqidhb.fsf@khaberz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] problems using rfcomm device
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
Date: Fri, 19 Nov 2004 07:01:36 +0100

Trying to get bluetooth running under Debian Testing here. Connecting
to my device (Nokia 6600 cell) works fine, but whenever I try to
access the device using pppd or minicom I get something like this:

Nov 19 06:18:01 arthur pppd[1382]: Failed to open /dev/rfcomm0:
Invalid argument

Yes, I did see the FAQ, but the rfcomm connect doesn't help either.

Here's what I do have working:

arthur:/home/khaberz# rfcomm show
rfcomm0: 00:0E:6D:56:44:FA channel 0 clean


arthur:/home/khaberz# hciconfig -a 
hci0:   Type: USB
        BD Address: 00:0F:3D:5F:6C:FD ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:99 acl:0 sco:0 events:13 errors:0
        TX bytes:296 acl:0 sco:0 commands:12 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'arthur-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
        Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)


Any help is greatly appreciated.

Thanks,
Kai



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

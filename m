Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Varat  Chaikasetsin <varat_c@hotmail.com>
Message-ID: <loom.20040409T190414-277@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] hciconfig option problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 9 Apr 2004 17:22:44 +0000 (UTC)

Hi ,
  I have a problem with hciconfig option "name" as following

[root@localhost bluez-utils-2.4]# hciemu localhost:1
[root@localhost bluez-utils-2.4]# hciconfig -a
hci0:   Type: VHCI
        BD Address: 7F:00:00:01:00:01 ACL MTU: 1000:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:0 acl:0 sco:0 events:12 errors:0
        TX bytes:308 acl:0 sco:0 commands:12 errors:0
        Features: 0xff 0xff 0xff 0xff 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
Can't read local name on hci0. Input/output error(5)
[root@localhost bluez-utils-2.4]# hciconfig hci0 name laptop
[root@localhost bluez-utils-2.4]# hciconfig hci0 name
Can't read local name on hci0. Input/output error(5)
[root@localhost bluez-utils-2.4]#
 
   Why can't I use option "name" to name the hciemu device.Would you give me 
some solutions.

Thank you 
Varat



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41F0F4FE.6050703@nm.ru>
From: George Kibardin <george_kibardin@nm.ru>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Tekram TM-304
References: <41EF5879.7090005@nm.ru> <1106224337.8190.168.camel@pegasus>	 <41F007D0.5060606@nm.ru> <1106252193.7955.7.camel@pegasus>
In-Reply-To: <1106252193.7955.7.camel@pegasus>
Content-Type: text/plain; charset=windows-1251; format=flowed
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
Date: Fri, 21 Jan 2005 15:26:38 +0300

Hi Marcel,

Here we have problem, it seems like hciconfig does not see my dongle

hciconfig -a output:
hci0:    Type: USB
    BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
    DOWN
    RX bytes:0 acl:0 sco:0 events:0 errors:0
    TX bytes:0 acl:0 sco:0 commands:0 errors:0
    Features: 0x00 0x00 0x00 0x00
    Packet type: DM1 DH1 HV1
    Link policy:
    Link mode: SLAVE ACCEPT
 
I think that BD Address should not consist of zeroes only ;)

Best regards.
George



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jason Van Patten <jvp@lateapex.net>
Message-Id: <200309130612.h8D6CKs06276@localhost.lateapex.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
To: bluez-users@lists.sourceforge.net
Reply-To: jvp@lateapex.net
In-Reply-To: <no.id> from "jvp" at Sep 13, 2003 01:15:17 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 13 Sep 2003 02:12:20 -0400 (EDT)

At Sat Sep 13 01:15:17 2003, jvp wrote:
> laptop# hciconfig -a
> hci0:   Type: USB 
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN 
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>         Features: 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 

I was successful in getting the Palm and laptop to find one another via BT;
thanks a bunch for all the help.  Now, is there any way to get an
application like jpilot to sync over BT?  I need to point it at a /dev
device; typically a serial or usb connection.  Does hci0 have a /dev
representation of some sort?

Thanks, and again I'm sorry about the newbie questions.

jas
-- 
Jason Van Patten
AOL IM: Jason VP 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

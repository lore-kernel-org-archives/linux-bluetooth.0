Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jason Van Patten <jvp@lateapex.net>
Message-Id: <200309130515.h8D5FHU06171@localhost.lateapex.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
To: bluez-users@lists.sourceforge.net
Reply-To: jvp@lateapex.net
In-Reply-To: <1063407456.28890.369.camel@pegasus> from "Marcel Holtmann" at Sep 13, 2003 12:57:30 AM
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
Date: Sat, 13 Sep 2003 01:15:17 -0400 (EDT)

At Fri Sep 12 18:57:30 2003, Marcel Holtmann wrote:
> this can be a problem, but I after searching a little bit I find some
> texts that say such a switch must be there and that Bluetooth is working
> with your notebook:

> No Bluetooth device attached to the USB bus. You have to switch it on ;)

I found the tiny button just now, after staring straight at it for the last
couple of days.  Duh.

laptop# hciconfig -a
hci0:   Type: USB 
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN 
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0
        Features: 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1 
        Link policy: 
        Link mode: SLAVE ACCEPT 

Better.

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

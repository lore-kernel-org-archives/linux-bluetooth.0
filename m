Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Przemek Hausman <aquamala@o2.pl>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problems with RS232 and BT - Can't init device hci0
Message-ID: <20040302183742.GA12057@mech.pw.edu.pl>
References: <200403021801.11637.zubiwat@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <200403021801.11637.zubiwat@poczta.onet.pl>
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
Date: Tue, 2 Mar 2004 19:37:42 +0100

> When try to use hciattach /dev/ttyS0 any 921600 flow I always get:
[...]

try this:
$ strace -eopen hciattach /dev/ttyS0 any 921600

and watch, what's wrong.

Best regards, 
Przemek Hausman

-- 
unsigned int gg = 2627828;


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <cyrus@holtmann.org>
Message-ID: <12404.62.140.137.157.1228902324.squirrel@webmail.xs4all.nl>
Date: Wed, 10 Dec 2008 10:45:24 +0100 (CET)
From: "menno" <jongerenchaos@zonnet.nl>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Bluez 4.20/4.21/4.22
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

I use Bluez incombination with asterisk (chan_mobile.c module). The
chan_mobile module accepts calls from bluetooth enabled cell-phones.

When i use bluez < 4.19 this works but there is an audio delay from
asterisk to the connected mobile phone. But the connection is stable and
the cellphone doesn't discconnect from asterisk.

When i use bluez > 4.20 (& 4.21 & 4.22) this works better (with audio) and
there is an short delay when the call is begin. After some seconds (i
think between 5 & 10 seconds) the delay is away. But after 15 seconds the
audio is dropped and asterisk disconnect the bluetooth phone.
Only when i restart the mobile phone he is connected again.

My Question: Is it possible to develop a version that the mobile
connection don't disconnect from the asterisk pabx and also with good (no
delayed) audio capabilties??


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

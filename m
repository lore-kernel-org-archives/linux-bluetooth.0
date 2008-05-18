Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300805172222o51bcc456q55df259facc1c156@mail.gmail.com>
Date: Sat, 17 May 2008 23:22:43 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <599220.56466.qm@web52910.mail.re2.yahoo.com>
MIME-Version: 1.0
References: <599220.56466.qm@web52910.mail.re2.yahoo.com>
Subject: Re: [Bluez-users] USB dongle cannot pair with A2DP speakers
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
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Chris

I had a pairing & timing problem like this with an at&t tilt. It might
work for you to log out of the machine and from the console, run

 passkey-agent --default 0000 &

then attempt the connection using command-line tools (like aplay in your case).

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

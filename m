Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Selection of PtP connection type
From: Simi Winiker <simi@winiker.ch>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <200402230026.24596.pavouk@pavouk.org>
References: <200402230026.24596.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1077521957.1788.7.camel@kant.winiker.ch>
Mime-Version: 1.0
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
Date: Mon, 23 Feb 2004 08:39:17 +0100

On Mon, 2004-02-23 at 00:26, Pavel Ruzicka wrote:
> Hello,

Hello.

> I want to connect my Desktop Mandrake linux with my Sharp Zaurus.
> On desktop side I want automatic solution. Only insert USB dongle.

[snip]

> What is the preferred way of connecting two devices today?

In my opinion you should use the PAN Profile to connect the devices. If
you don't want to share the internet connection of your mandrake box,
you do not need to worry about bridging. As a rough summary:

1) Install bluez-pan on both sides
2) Issue "pand -s -r NAP" on the mandrake box
3) make "pand -c aa:bb:cc:dd:ee:00" on the zaurus (replace the part
after -c with the bluetooth address of the mandrake box

And you should be connected. But still read the documentation. And by
the way, PPP over BNEP does not make sense. 

[snip]

Simi



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

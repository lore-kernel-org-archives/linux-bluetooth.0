Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jul 2008 13:32:58 +0200
From: Martin Mueller <lists@sig21.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20080707113258.GR8715@caesar.sig21.net>
References: <200807030237.57723.bluez-users-mlist@malte-wetz.de>
	<20080704163313.GN8715@caesar.sig21.net>
	<alpine.LNX.1.10.0807060641520.7069@nge2.ngu.pk>
	<200807071255.06344.bluez-users-mlist@malte-wetz.de>
MIME-Version: 1.0
In-Reply-To: <200807071255.06344.bluez-users-mlist@malte-wetz.de>
Subject: Re: [Bluez-users] Headset not working
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

On Mon, Jul 07, 2008 at 12:55:06PM +0200, Malte J. Wetz wrote:
>
> Well, as I wrote before, I'm already using the SCO/ESCO patch and it
> does not work.

Hmm, do you have the bluetooth dongle connected via an USB-hub? If
yes, try plugging the dongle directly into the mainboard. In my setup
I can't use bt-dongles connected to hub for SCO, even though the rest
like rfcomm, l2ping, etc work.

> The patch proposed by Martin does apply to current kernel (you just
> have to add =BB-F10=AB to your patch command as some line have moved
> beyond the default fuzz). But it does no good. Now, whenever I play
> back something via the headset, the entire kernel freezes and even
> Magic SysRq won't anymore. Only a hard reset gets me out of there.

What a luck I wasn't able to apply it. ;-)

bye
  MM
--
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Deresch <aderesch@fs.tum.de>
Reply-To: Andreas Deresch <aderesch@fs.tum.de>
To: =?iso-8859-1?q?Gary=20Martin?= <gary_martin_au@yahoo.com.au>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Desperate newbie
In-Reply-To: <20040331100100.43642.qmail@web21001.mail.yahoo.com>
Message-ID: <Pine.LNX.4.56L0.0403311318140.9869@localhost>
References: <20040331100100.43642.qmail@web21001.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 31 Mar 2004 13:37:15 +0200 (CEST)

On Wed, 31 Mar 2004, [iso-8859-1] Gary Martin wrote:

> 4 - It seems to be a lot of work to find a class code that might
> not even be the problem
Correct. What I meant was, that *any* of the three should work. BTW, "Mobile
Phone" is the class value returned by your T628 by hcitool inq (0x520204).

> I have spent too much time on this problem already. I'm beginning
> to lose faith in Linux for "users" like me
Don't. It can take some time to get used to, but it's worth it. :-)
Anyhow, I would really be interested in solving your problem (or at least
determining the cause), if you are willing to keep trying a little longer:

What is the output of sdptool browse?
What exactly did you mean by "multisync cannot find the phone"? You can
select "IrMC Mobile Device" as plugin, "Bluetooth" as connection type, and
can "search for units", but do not get a response? (Phone was discoverable?)

ad


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

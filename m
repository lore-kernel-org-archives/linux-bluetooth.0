Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: Paul Rushworth <paul@rushworth.co.nz>
Date: Sun, 6 Jan 2008 04:28:25 +0000 (UTC)
Message-ID: <loom.20080106T042630-278@post.gmane.org>
References: <loom.20080105T181918-303@post.gmane.org>
	<loom.20080105T191502-7@post.gmane.org>
	<loom.20080105T192949-442@post.gmane.org>
	<loom.20080105T195122-398@post.gmane.org>
	<d89ddf300801051234i45d2d574s65fd7954a9cbaa82@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users]
	=?utf-8?q?Updated_to_bluez_3=2E24_from_Ubuntu_repo?=
	=?utf-8?q?=27s=2E=09Headphones_still_disconnect_after_2-3_mins=2E?=
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

Brad Midgley <bmidgley <at> gmail.com> writes:

> 
> Paul
> 
> If you'll let someone else get a word in... :)
> 
> You'll get a lot of data, but if you run this while playing audio,
> near the end it might say something interesting about the disconnect:
> 
> sudo hcidump -XV >log
> 
> aplay from the console might print a decent error message.
> 
> Brad

thanks for the tip. I'm now trying to tightly define when it works or doesn't
and what steps i take. It is not working 100% of the time, but perhaps 80% of
the time. Xmoto doesn't seem to be a relevant factor.

I think ill try and map out a set of conditions over 2-3 days and see what i
come up with.

The net change does seem to be the 3.24 libs update?

Paul


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

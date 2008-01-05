Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801051234i45d2d574s65fd7954a9cbaa82@mail.gmail.com>
Date: Sat, 5 Jan 2008 13:34:56 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20080105T195122-398@post.gmane.org>
MIME-Version: 1.0
References: <loom.20080105T181918-303@post.gmane.org>
	<loom.20080105T191502-7@post.gmane.org>
	<loom.20080105T192949-442@post.gmane.org>
	<loom.20080105T195122-398@post.gmane.org>
Subject: Re: [Bluez-users] Updated to bluez 3.24 from Ubuntu repo's.
	Headphones still disconnect after 2-3 mins.
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

Paul

If you'll let someone else get a word in... :)

You'll get a lot of data, but if you run this while playing audio,
near the end it might say something interesting about the disconnect:

sudo hcidump -XV >log

aplay from the console might print a decent error message.

Brad

On Jan 5, 2008 12:53 PM, Paul Rushworth <paul@rushworth.co.nz> wrote:
> Paul Rushworth <paul <at> rushworth.co.nz> writes:
> > Paul Rushworth <paul <at> rushworth.co.nz> writes:
> > > Perhaps vlc with audio sink is the cause of the problem?

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

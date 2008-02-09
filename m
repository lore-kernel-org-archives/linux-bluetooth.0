Return-Path: <cyrus@holtmann.org>
From: Brian Sammon <bluez-users@brisammon.fastmail.fm>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-reply-to: <alpine.LNX.1.00.0802082340390.12621@nge2.ngu.pk> 
References: <200802090347.m193lOJq023253@alumnus.caltech.edu>
	<alpine.LNX.1.00.0802082340390.12621@nge2.ngu.pk>
Mime-Version: 1.0
Date: Sat, 09 Feb 2008 15:52:51 -0500
Message-Id: <E1JNwgu-0004gE-DI@necz1>
Subject: Re: [Bluez-users] failed PIN Code Request
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

> -> 	'Kill all these processes and simply log into the GNOME or KDE
> -> desktop and use their Bluetooth applet.'
> -> 	These require X, which I don't use except under duress.  I
> -> just want to listen to files on my wireless headset.
> 
> Same here, X isn't mandatory, only if you use a graphical bluetooth tool in 
> GNOME or KDE, which I don't. The bluez-utils command line tools work fine for 
> me. There's two which I use for my headset. I posted a full description of it 
> a few issues back, but the pass/PIN part consists of starting
> 
> passkey-agent --default <PIN> <bt address of remote device> &
> auth-agent &

I was of the impression that passkey-agent and auth-agent were 
unsupported/sample programs.  Am I correct?
As far as I can tell, they are undocumented, neither in the tarball, nor in 
the wiki (aside from a few brief mentions)
I don't have a full build system up right now, but judging from the various 
Makefile.in files in the tarball, it appears they are not built by default.
Debian does not distribute them-- does any distribution?

When I set up my bluetooth headphones back in December, the only way I could 
figure out to do it was to switch window managers to something compatible with 
the gnome bluetooth-applet.  I'd be very happy to hear that there is now a 
supported command-line app for this.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <cyrus@holtmann.org>
Date: Sat, 31 Aug 2013 12:42:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 3.11-rc7: unpriviledged user crashes kernel using bluetooth
Message-ID: <20130831104238.GA7767@amd.pavel.ucw.cz>
References: <20130831100127.GA6711@amd.pavel.ucw.cz>
 <20130831100933.GA7029@amd.pavel.ucw.cz>
 <20130831101451.GC7029@amd.pavel.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130831101451.GC7029@amd.pavel.ucw.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat 2013-08-31 12:14:51, Pavel Machek wrote:
> On Sat 2013-08-31 12:09:33, Pavel Machek wrote:
> > Hi!
> > 
> > > . Python sources for client/server are at 
> > > 
> > > http://tui.cvs.sourceforge.net/viewvc/tui/tui/liveview/
> > > 
> > > . My kernels like to warn about
> > System is debian stable with gnome2.
> 
> And no, it is not fixed in 3.11-rc7.

2.6.32-5-686 from debian seems to work.

Notice that I probably have modemmanager fighting with my own
server, that is experiencing problem described in
http://ubuntuforums.org/showthread.php?t=2056285 . That still should
not allow me to crash the kernel.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

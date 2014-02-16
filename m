Return-Path: <cyrus@holtmann.org>
Message-ID: <1392577563.18051.140.camel@belkin5>
Subject: Re: Some patches applied on Fedora that maybe should be considered
 for being applied upstream
From: Pacho Ramos <pacho@gentoo.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Sun, 16 Feb 2014 20:06:03 +0100
In-Reply-To: <1392125277.22732.1.camel@nuvo>
References: <1391935987.4666.5.camel@belkin5>
	 <1392039609.4417.14.camel@nuvo> <1392062509.4911.0.camel@belkin5>
	 <1392125277.22732.1.camel@nuvo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El mar, 11-02-2014 a las 14:27 +0100, Bastien Nocera escribió:
> On Mon, 2014-02-10 at 21:01 +0100, Pacho Ramos wrote:
> > El lun, 10-02-2014 a las 14:40 +0100, Bastien Nocera escribió:
> > > On Sun, 2014-02-09 at 09:53 +0100, Pacho Ramos wrote:
> > > > Hello
> > > > 
> > > > I was looking at bluez package and found some patches that maybe could
> > > > be upstreamed. Also, I would like to know the reasons for not accepting
> > > > them to ensure they are safe to be applied downstream by us too :)
> > > > 
> > > > http://pkgs.fedoraproject.org/cgit/bluez.git/tree/0001-Allow-using-obexd-without-systemd-in-the-user-sessio.patch -> Does this cause any issues with systemd --user setups?
> > > 
> > > Giovanni already posted this patch earlier. There's no distribution
> > > using systemd sessions, so this doesn't work yet.
> > > 
> > > > http://pkgs.fedoraproject.org/cgit/bluez.git/tree/0001-obex-Use-GLib-helper-function-to-manipulate-paths.patch
> > > > http://pkgs.fedoraproject.org/cgit/bluez.git/tree/0002-autopair-Don-t-handle-the-iCade.patch
> > > > http://pkgs.fedoraproject.org/cgit/bluez.git/tree/0004-agent-Assert-possible-infinite-loop.patch
> > > > -> Any reason for not applying it upstream too?
> > > 
> > > I've posted those patches to the list as well.
> > 
> > And, do you know why they weren't accepted? (it's for trying to get them
> > merged and not needing to carry them forever)
> 
> Read the threads for the various patches?
> 
> Mailing-lists, awful at tracking patches since forever...
> 

But, for example for the patch allowing to run without systemd --user:
http://marc.info/?t=138159296100001&r=1&w=2

What is the point in providing a "--disable-systemd" configure flag that
needs this patches to be applied to be really working? Looks like
"--enable-systemd" will be needed if we don't apply that patches
downstream...


Also:
http://www.spinics.net/lists/linux-bluetooth/msg40136.html
http://www.spinics.net/lists/linux-bluetooth/msg41264.html

Look to have no reply at all

And for 0004-agent-Assert-possible-infinite-loop.patch I can't find the
relevant thread :(



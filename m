Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add udev mode to bluetoothd
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stefan Seyfried <seife@suse.de>, linux-bluetooth@vger.kernel.org
In-Reply-To: <1244820498.5536.7.camel@violet>
References: <1244741895.11069.1319.camel@cookie.hadess.net>
	 <1244742638.27363.51.camel@violet>  <4A320683.7000103@suse.de>
	 <1244796020.3280.13.camel@snoogens.fab.redhat.com>
	 <1244820498.5536.7.camel@violet>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 18:58:57 +0100
Message-Id: <1244829538.11069.2800.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-06-12 at 17:28 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > >> As discussed on IRC.
> > > >>
> > > >> Still needed:
> > > >> - patch to wait for the bus to startup in udev mode
> > > 
> > > Should we really do that? (What if the bus never appears?, how long should we
> > > wait?)
> > > The alternative (not overwhelmingly nice, I admit) would be to record
> > > somewhere in the system that bluetoothd tried to start but could not due to
> > > the missing bus and then start it "manually" by an init script that is
> > > guaranteed to run after DBus is started.
> > 
> > Under normal conditions, we'd exit(1) if started and the bus isn't
> > available, and udev would pick that up, marking our job as failed, and
> > relaunching us later in the boot process, under coldplug.
> > 
> > Marcel didn't like the idea though.
> 
> so how does udev handle this exactly. We try bluetoothd and it fails,
> then it tries again later? What time exactly? How often? Does this
> affect the fast-boot effort?

It will try to start up bluetooth as soon as it sees the device on
startup. bluetoothd will fail to start, as D-Bus isn't started, with an
exit code of 1.

udev notes the failure, and saves the rules to /dev/.udev/*.

The initscripts carry on, filesystems are mounted rw, D-Bus is started,
then a udev "coldplug" is started (still part of the initscripts), and
bluetoothd is started as expected.

I built some test packages yesterday, and Petr tested those, and it
seems to work as expected.

If you fancy trying out on an F-12 system (the SRPM can be re-used on
F-11, just remove the libgudev-devel BuildRequires line):
http://koji.fedoraproject.org/koji/buildinfo?buildID=105952

So as far as I'm concerned, the only thing missing is getting the rules
into bluez.

Marcel, do you want the udev rules installed by default? The cost would
be an attempted run at bluetoothd on each adapter insertion, but it
would still work as expected if bluetoothd was started from an
initscript.

Cheers

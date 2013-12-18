Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 0/4] android: Permanent storage support
Date: Wed, 18 Dec 2013 13:39:18 +0100
Message-ID: <1818951.puoPfgUXXZ@uw000953>
In-Reply-To: <20131218123111.GE26311@aemeltch-MOBL1>
References: <1387365660-25281-1-git-send-email-szymon.janc@tieto.com> <1743761.bXhrtg3e4W@uw000953> <20131218123111.GE26311@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Hi Szymon,
> 
> On Wed, Dec 18, 2013 at 01:23:40PM +0100, Szymon Janc wrote:
> > Hi Marcel,
> > 
> > > Hi Szymon,
> > > 
> > > > This is first RFC for storage format for Android daemon.
> > > > 
> > > > Some highlights:
> > > > - storage is much simple in format than Linux daemon (no addresses in paths
> > > >  or filenames, only 1 adapter support etc)
> > > > - only info that requires persistency  over daemon lifetime from Framework
> > > >  perspective is stored
> > > > - settings file for adapter config
> > > > - devices file for remote device info (groups are remote devices addresses)
> > > > - Android storage path is /data/misc/bluez (I've decided to not use
> > > >  /data/misc/bluetooth to avoid any clashes as there still seems to be
> > > >  leftovers available in Android tree eg. there are still references to that
> > > >  directory in CTS testcases and init files of Android 4.4)
> > > 
> > > I would use /data/misc/bluetooth actually. Especially since the daemon is also called bluetoothd and not bluezd.
> > > 
> > > What is the impact on just using /data/misc/bluetooth and see if anything really breaks.
> > 
> > OK, this will require proper chown in device init.rc (as it is set to system/system
> > in system/core/rootdir/init.rc), but that would be needed for /data/misc/bluez path
> > anyway...
> 
> I wonder can we find place without need to add extra chown... like using
> Bluedroid configuration location?

I would avoid touching bluedroid configs (other than converting storage, but
this is future anyway). And anyone integrating BlueZ into product will need to
modify init.rc anyway so this is not that much of a problem.

-- 
BR
Szymon Janc

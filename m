Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in
 the kernel
From: Bastien Nocera <hadess@hadess.net>
To: Jiri Kosina <jkosina@suse.cz>
Cc: "Gunn, Brian" <bgunn@solekai.com>, Marcel Holtmann <marcel@holtmann.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Ping <pinglinux@gmail.com>
In-Reply-To: <alpine.LRH.2.00.1001291039350.15694@twin.jikos.cz>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>
	 <1263897015.20565.3988.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
	 <1264037759.1735.5008.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C0F@EXMBXSD.dm.solekai.com>
	 <1264719198.29532.3149.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C1E@EXMBXSD.dm.solekai.com>
	 <alpine.LRH.2.00.1001291039350.15694@twin.jikos.cz>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Fri, 29 Jan 2010 13:45:13 +0000
Message-ID: <1264772713.29532.4943.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2010-01-29 at 10:39 +0100, Jiri Kosina wrote:
> On Thu, 28 Jan 2010, Gunn, Brian wrote:
> 
> > > > > I sent a new version of the patch, which uses "HIDP_TRANS_SET_REPORT |
> > > > > HIDP_DATA_RTYPE_FEATURE" for the first byte. Would that work?
> > > >
> > > > Actually for my application it doesn't.  I use HIDP_TRANS_DATA |
> > > HIDP_DATA_RTYPE_OUTPUT.
> > > >
> > > > Perhaps allowing the user the choice of what do to here is more flexible.
> > >
> > > Except that it would mean different code for USB and Bluetooth
> > > versions...
> > 
> > So do we need a method of setting which device reports we're sending before writing them?
> 
> Having separate methods for feature and output reports should be 
> sufficient and general enough, right?

Most likely, yes. Feature is enough for the 2 devices I provided patches
for. Could you please comment on what you'd like the implementation of
this to look like? This simple bug fix is turning into a lot more
to-and-fro than I would have anticipated.

Cheers

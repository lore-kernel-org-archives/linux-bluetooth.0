Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jan 2010 10:39:59 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: "Gunn, Brian" <bgunn@solekai.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input <linux-input@vger.kernel.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Ping <pinglinux@gmail.com>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
In-Reply-To: <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C1E@EXMBXSD.dm.solekai.com>
Message-ID: <alpine.LRH.2.00.1001291039350.15694@twin.jikos.cz>
References: <1263833399.20565.2905.camel@localhost.localdomain>  <1263886149.5591.166.camel@localhost.localdomain>  <1263897015.20565.3988.camel@localhost.localdomain>  <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
 <1264037759.1735.5008.camel@localhost.localdomain>  <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C0F@EXMBXSD.dm.solekai.com> <1264719198.29532.3149.camel@localhost.localdomain> <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C1E@EXMBXSD.dm.solekai.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 28 Jan 2010, Gunn, Brian wrote:

> > > > I sent a new version of the patch, which uses "HIDP_TRANS_SET_REPORT |
> > > > HIDP_DATA_RTYPE_FEATURE" for the first byte. Would that work?
> > >
> > > Actually for my application it doesn't.  I use HIDP_TRANS_DATA |
> > HIDP_DATA_RTYPE_OUTPUT.
> > >
> > > Perhaps allowing the user the choice of what do to here is more flexible.
> >
> > Except that it would mean different code for USB and Bluetooth
> > versions...
> 
> So do we need a method of setting which device reports we're sending before writing them?

Having separate methods for feature and output reports should be 
sufficient and general enough, right?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 May 2014 17:41:37 +0800
From: Adam Lee <adam.lee@canonical.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: "An, Tedd" <tedd.an@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"Fry, Don" <don.fry@intel.com>
Subject: Re: linux-firmware: Update Intel BT devices firmware patch files
 (7260/3160)
Message-ID: <20140512094137.GB3503@adam-laptop>
References: <20140314135254.2edf9d2e@han1-desk-dev>
 <1395003913.15764.118.camel@deadeye.wl.decadent.org.uk>
 <BB52B9B497F0EE4EB05C192A0408F6602F27F4AD@ORSMSX104.amr.corp.intel.com>
 <1396829760.13361.19.camel@deadeye.wl.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396829760.13361.19.camel@deadeye.wl.decadent.org.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 07, 2014 at 01:16:00AM +0100, Ben Hutchings wrote:
> On Thu, 2014-03-20 at 17:44 +0000, An, Tedd wrote:
> > Hi Ben
> > 
> > Due to our internal change of build system, the version format needs
> > to be updated so I can track it more easily.
> [...]
> > > > --- a/WHENCE
> > > > +++ b/WHENCE
> > > > @@ -2254,9 +2254,9 @@ Driver: btusb - Bluetooth USB driver
> > > >  File: intel/ibt-hw-37.7.bseq
> > > >  Version: 1316.02.00
> > > >  File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> > > > -Version: 1344.01.33
> > > > +Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
> > > >  File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
> > > > -Version: 1344.01.33
> > > > +Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
> > > [...]
> > > 
> > > Why has the version format changed?  Are all the different parts actually
> > > significant?
> [...]
> 
> That doesn't answer the second question.
> 
> I really have a hard time believing that all of 'auto.WP', '1303_02',
> 'patch', '0.1.54.1' and '0x36' are all significant.  No-one else seems
> to need more than 4 components in a version number; what's so special
> about this firmware?
> 
> And another question: can an outside observer compare version strings
> and get any sense of which is newer?  Are the components in the right
> order (most significant first)?
> 
> Ben.

Hi, all

This firmware also fixes another EHCI HSP/HFP profile not working issue,
could you guys please reach a consensus about the version string and get
it upstreamed?

Thanks.

-- 
Adam Lee

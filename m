Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Feb 2010 13:48:34 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Bastien Nocera <hadess@hadess.net>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: Michael Poole <mdpoole@troilus.org>,
	"Gunn, Brian" <bgunn@solekai.com>, Ping <pinglinux@gmail.com>,
	linux-kernel@vger.kernel.org,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/3] HID: make raw output callback more flexible
In-Reply-To: <alpine.LNX.2.00.1002031202040.15395@pobox.suse.cz>
Message-ID: <alpine.LNX.2.00.1002031343500.15395@pobox.suse.cz>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>  <1264783166.29532.5302.camel@localhost.localdomain>  <87iqakifm8.fsf@troilus.org>  <1264860663.29532.7887.camel@localhost.localdomain>  <87bpg7glf7.fsf@troilus.org> <1265190440.32444.8417.camel@localhost.localdomain>
 <alpine.LNX.2.00.1002031202040.15395@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 3 Feb 2010, Jiri Kosina wrote:

> > > The USB HID core sends a GET_DESCRIPTOR request for the Report 
> > > descriptor, which isn't practical here because that descriptor is only 
> > > available through SDP.
> > 
> > And we only do SDP queries in user-space...
> > 
> > If you're not going to work on it shortly, I can take a look at cooking
> > a patch by the end of the week. Otherwise, I'd be happy testing your
> > patches.

I have now rebased the three patches on top of 6bf8268f9a91f1 
("Bluetooth: Use the control channel for raw HID reports") which has 
already landed in Linus' tree. I will send them as a followup to this 
mail.

If you have any changes/acks/nacks, please let me know.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 15:23:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC BlueZ v0 2/5] Use defines instead of magic numbers
Message-ID: <20120718122328.GB28815@x220.ger.corp.intel.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1337009584-17181-3-git-send-email-mikel.astiz.oss@gmail.com>
 <CANT-zCVAm80TqiVy=mnW0j4jMYDaitFR6GZ7qBWLAvuH+BQ2PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANT-zCVAm80TqiVy=mnW0j4jMYDaitFR6GZ7qBWLAvuH+BQ2PQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Jul 18, 2012, Mikel Astiz wrote:
> On Mon, May 14, 2012 at 5:33 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> > From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> >
> > The error-handling code should use the defines instead of magic numbers.
> > ---
> >  src/device.c |   42 +++++++++++++++++++++---------------------
> >  1 files changed, 21 insertions(+), 21 deletions(-)
> 
> Ping.
> 
> This was included inside a RFC series but has actually no dependency.

Thanks for the reminder. The patch has now been applied.

The usefulness of the patch is quite short-lived though since we've
pretty much stopped using HCI related values in userspace with the
introduction of mgmt. Looking at the code base it seems like several
places need fixing as the status value passed from mgmt.c to core is not
an HCI status but MGMT_STATUS_*. All places in the kernel should be
converting HCI status values with mgmt_status() before putting them into
a mgmt event. If you find some place that doesn't do that send a patch
please.

Johan

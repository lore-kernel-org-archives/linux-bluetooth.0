Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Oct 2012 15:33:26 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mgmt: Fix dereference after NULL check
Message-ID: <20121004123325.GC12229@aemeltch-MOBL1>
References: <1349348218-676-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20121004121702.GA31328@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121004121702.GA31328@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Oct 04, 2012 at 03:17:02PM +0300, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Thu, Oct 04, 2012, Andrei Emeltchenko wrote:
> > hdev might be NULL, so we need to avoid possible NULL derefernce in
> > handler->func functions.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/mgmt.c |   14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> Nack. Some of the handlers actually should be getting a NULL hdev and
> there's code higher up in the function you're changing that ensures that
> NULL is allowed for those handlers but not for any others (which should
> safely be able to skip NULL checks).

True, BTW: this would be nice to put this explanation as comment there.

Best regards 
Andrei Emeltchenko 


Return-Path: <cyrus@holtmann.org>
From: Gordon <kernel@gkr.i24.cc>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4] hid2hci add CSR 8510 A10 support
Date: Wed, 07 Jan 2015 21:52:24 +0100
Message-ID: <5132302.8WZblHb45u@g-vpcf13z1e>
In-Reply-To: <20150107203159.GA4571@t440s.P-661HNU-F1>
References: <20150107091248.GA11467@t440s.lan> <1420625417-9282-1-git-send-email-kernel@gkr.i24.cc> <20150107203159.GA4571@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch, 7. Januar 2015, 22:31:59 schrieb Johan Hedberg:
> Hi Gordon,
> 
> On Wed, Jan 07, 2015, kernel@gkr.i24.cc wrote:
> > add a new method "csr2" to hid2hci that sends a control message
> > to the usb device which switches the Cambridge Silicon Radio 8510 A10
> > as used in Sitecom CNT-524
> > 
> > fixes: https://bugzilla.kernel.org/show_bug.cgi?id=69181
> > ---
> > 
> > Notes:
> >     4th version, coding style corrections from Johan Hedberg and Anderson
> >     Lizardo, resend>  
> >  tools/hid2hci.1 |  2 +-
> >  tools/hid2hci.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 51 insertions(+), 2 deletions(-)
> 
> I was about to apply this but it doesn't compile:
> 

sorry, i didn't test after rebasing, last year the compiler wasn't 
complaining, and now i even need a new glib. is there a recommended developer 
platform/OS distribution ?

Thanks,

Gordon

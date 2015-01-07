Return-Path: <cyrus@holtmann.org>
From: Gordon <kernel@gkr.i24.cc>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4] hid2hci add CSR 8510 A10 support
Date: Wed, 07 Jan 2015 22:21:16 +0100
Message-ID: <7984819.RkGvNTDEQb@g-vpcf13z1e>
In-Reply-To: <20150107203159.GA4571@t440s.P-661HNU-F1>
References: <20150107091248.GA11467@t440s.lan> <1420625417-9282-1-git-send-email-kernel@gkr.i24.cc> <20150107203159.GA4571@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

forget my earlier mail, this was due to using a different system.

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
> make --no-print-directory all-am
>   CC       tools/hid2hci.o
> tools/hid2hci.c: In function ‘usb_switch_csr2’:
> tools/hid2hci.c:152:14: error: pointer targets in passing argument 6 of
> ‘control_message’ differ in signedness [-Werror=pointer-sign] 0, report,
> sizeof(report), 5000);
>               ^
> tools/hid2hci.c:78:12: note: expected ‘char *’ but argument is of type
> ‘uint8_t *’ static int control_message(int fd, int requesttype, int
> request,
>             ^

what do you prefer? char * or uint_8 * in the function declaration ? when 
switching to unit_8 there will be changes in other functions as well.


> tools/hid2hci.c:124:6: error: ‘err’ may be used uninitialized in this
> function [-Werror=maybe-uninitialized] int err;
>       ^
> cc1: all warnings being treated as errors

ok easy

> 
> Please use ./configure --enable-maintainer-mode to verify that the build
> is clean (or ./bootstrap-configure && make).
> 
> > +	uint8_t report[] = {
> > +		0x01, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> > +	};
> 
> Minor improvement: you might want to declare this as const.

const also means a change to the method declaration or an extra cast. What do 
you prefer ?

Thanks,

Gordon


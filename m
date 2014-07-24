Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Jul 2014 18:32:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Murat Kilivan <Murat.Kilivan@csr.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth Low Energy service crash report - when trying read a
 HID feature report
Message-ID: <20140724153227.GA27134@t440s.P-661HNU-F1>
References: <45F17F5803927D43967AFEED068E781E0879A30E@CAMEUREXM02.EUROPE.ROOT.PRI>
 <20140724083116.GB9891@t440s.lan>
 <45F17F5803927D43967AFEED068E781E0879ACDB@CAMEUREXM02.EUROPE.ROOT.PRI>
 <20140724100820.GA13332@t440s.lan>
 <CANq1E4QBGf68iHuhLX8SX4A=Rokg4p6OWpgY1hMKhnJvze4PGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANq1E4QBGf68iHuhLX8SX4A=Rokg4p6OWpgY1hMKhnJvze4PGA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Thu, Jul 24, 2014, David Herrmann wrote:
> > This helps a lot. Thanks. I'd bet the following code from forward_report() is
> > responsible:
> >
> >         if (hogdev->has_report_id) {
> >                 data = ev->u.output.data + 1;
> >                 size = ev->u.output.size - 1;
> >         } else {
> >                 data = ev->u.output.data;
> >                 size = ev->u.output.size;
> >         }
> 
> The kernel bails out if size==0, so this never happens. The bt_uhid_*
> helpers are fine, however, hog.c forward_report() is totally broken.
> You use:
> 
> bt_uhid_register(hogdev->uhid, UHID_OUTPUT, forward_report, hogdev);
> bt_uhid_register(hogdev->uhid, UHID_FEATURE, forward_report, hogdev);
> 
> Therefore, you register *THE SAME* handler for UHID_OUTPUT *AND*
> UHID_FEATURE. However, in forward_report() you access ev->u.output,
> but this is only valid for UHID_OUTPUT. If you get a UHID_FEATURE
> report you must never access anything but ev->u.feature!
> 
> Furthermore, if you receive UHID_FEATURE, the kernel blocks until you
> send the answer as UHID_FEATURE_ANSWER. I really recommend dropping
> this line:
>     bt_uhid_register(hogdev->uhid, UHID_FEATURE, forward_report, hogdev);
> 
> Add it again once you implemented UHID_FEATURE properly. Currently,
> it's totally broken.

Thanks a lot for the analysis! I've now pushed a patch to remove the
broken attempt at UHID_FEATURE support.

Johan

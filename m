Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Nov 2010 17:23:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Wade Brown <BrownW@us.panasonic.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Add command line option to change BCSP rate
Message-ID: <20101119152346.GA28815@jh-x301>
References: <6EBC2ED6C3CFDC428167C1FF4764F0710A96D8BE9A1A@SJEXBEC1.research.us.panasonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6EBC2ED6C3CFDC428167C1FF4764F0710A96D8BE9A1A@SJEXBEC1.research.us.panasonic.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 18, 2010, Wade Brown wrote:
> Currently when using bccmd to do any communication, the UART is always
> opened at 38.4kbps.  Once the CSR has been initialized to any other
> speed, bccmd can no longer communicate with with the radio (unless by
> resetting it through rfkill).  This patch adds a -b option allowing a
> user to manually set a different speed, with the default 38400 still in
> place.
> 
> Usage example:
> $bccmd -t BCSP -b 921600 -d /dev/ttyHS1 chiprev
> 
> ---
>  tools/bccmd.c    |   45 ++++++++++++++++++++++++++++++++++++++++-----
>  tools/csr.h      |    3 ++-
>  tools/csr_bcsp.c |    4 ++--
>  3 files changed, 44 insertions(+), 8 deletions(-)

The patch seems fine to me but I can't figure out how to apply it either
due to your mail client or your mail server. It's not sent inline and
the attachment isn't a complete git patch as such. Additionally there's
some strange winmail.dat attachment in the mail. Could you try resending
e.g. using git send-email?

Johan

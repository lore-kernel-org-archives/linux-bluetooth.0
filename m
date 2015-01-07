Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Jan 2015 22:31:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: kernel@gkr.i24.cc
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4] hid2hci add CSR 8510 A10 support
Message-ID: <20150107203159.GA4571@t440s.P-661HNU-F1>
References: <20150107091248.GA11467@t440s.lan>
 <1420625417-9282-1-git-send-email-kernel@gkr.i24.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1420625417-9282-1-git-send-email-kernel@gkr.i24.cc>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gordon,

On Wed, Jan 07, 2015, kernel@gkr.i24.cc wrote:
> add a new method "csr2" to hid2hci that sends a control message
> to the usb device which switches the Cambridge Silicon Radio 8510 A10
> as used in Sitecom CNT-524
> 
> fixes: https://bugzilla.kernel.org/show_bug.cgi?id=69181
> ---
> 
> Notes:
>     4th version, coding style corrections from Johan Hedberg and Anderson Lizardo, resend
> 
>  tools/hid2hci.1 |  2 +-
>  tools/hid2hci.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 51 insertions(+), 2 deletions(-)

I was about to apply this but it doesn't compile:

make --no-print-directory all-am
  CC       tools/hid2hci.o
tools/hid2hci.c: In function ‘usb_switch_csr2’:
tools/hid2hci.c:152:14: error: pointer targets in passing argument 6 of ‘control_message’ differ in signedness [-Werror=pointer-sign]
           0, report, sizeof(report), 5000);
              ^
tools/hid2hci.c:78:12: note: expected ‘char *’ but argument is of type ‘uint8_t *’
 static int control_message(int fd, int requesttype, int request,
            ^
tools/hid2hci.c:124:6: error: ‘err’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  int err;
      ^
cc1: all warnings being treated as errors

Please use ./configure --enable-maintainer-mode to verify that the build
is clean (or ./bootstrap-configure && make).

> +	uint8_t report[] = {
> +		0x01, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +	};

Minor improvement: you might want to declare this as const.

Johan

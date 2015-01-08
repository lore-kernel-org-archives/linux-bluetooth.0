Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Jan 2015 12:02:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: kernel@gkr.i24.cc
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] hid2hci add CSR 8510 A10 support
Message-ID: <20150108100216.GA14772@t440s.lan>
References: <20150107203159.GA4571@t440s.P-661HNU-F1>
 <1420668240-5100-1-git-send-email-kernel@gkr.i24.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420668240-5100-1-git-send-email-kernel@gkr.i24.cc>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gordon,

On Wed, Jan 07, 2015, kernel@gkr.i24.cc wrote:
> fixed the compilation bug. using following config
> configure --enable-maintainer-mode --disable-systemd --disable-cups  --disable-monitor
> 
> i also only compile with
> make tools/hid2hci
> 
> added a second patch that implements your suggestions with const uint_8 * 
> 
> Thanks!
> 
> Gordon Kramer (2):
>   hid2hci add CSR 8510 A10 support
>   use const uint_8* for pointer in control_message
> 
>  tools/hid2hci.1 |  2 +-
>  tools/hid2hci.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 54 insertions(+), 5 deletions(-)

I applied both of these patches now, however the first one still wasn't
completely clean and needed auto-fixing from git:

Applying: hid2hci add CSR 8510 A10 support
/home/jh/src/bluez/.git/rebase-apply/patch:52: trailing whitespace.
		/* Set_report request with 
/home/jh/src/bluez/.git/rebase-apply/patch:53: trailing whitespace.
		 * report id: 0x01, report type: feature (0x03) 
/home/jh/src/bluez/.git/rebase-apply/patch:62: trailing whitespace.
		/* unable to detect whether the previous state 
/home/jh/src/bluez/.git/rebase-apply/patch:63: trailing whitespace.
		 * already was HCI (EALREADY)  
warning: 4 lines applied after fixing whitespace errors.

Johan

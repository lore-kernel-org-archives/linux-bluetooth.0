Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Dec 2014 09:49:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] Bluetooth: Add support for self testing framework
Message-ID: <20141230074912.GA27230@t440s.P-661HNU-F1>
References: <1419914916-27051-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419914916-27051-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Dec 29, 2014, Marcel Holtmann wrote:
> This add support for the Bluetooth self testing framework that allows
> running certain test cases of sample data to ensure correctness of its
> basic functionality.
> 
> With this patch only the basic framework will be added. It contains
> the build magic that allows running this at module loading time or
> at late_initcall stage when built into the kernel image.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/Kconfig        | 13 ++++++++++
>  net/bluetooth/Makefile       |  2 ++
>  net/bluetooth/af_bluetooth.c |  6 +++++
>  net/bluetooth/selftest.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/selftest.h     | 45 ++++++++++++++++++++++++++++++++
>  5 files changed, 128 insertions(+)
>  create mode 100644 net/bluetooth/selftest.c
>  create mode 100644 net/bluetooth/selftest.h

Both of these patches have been applied to bluetooth-next. Thanks.

Johan

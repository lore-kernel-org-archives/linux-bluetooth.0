Return-Path: <cyrus@holtmann.org>
Message-ID: <1337044988.5970.244.camel@aeonflux>
Subject: Re: [PATCH] hciattach: Add support for Intel Bluetooth device
From: Marcel Holtmann <marcel@holtmann.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 14 May 2012 18:23:08 -0700
In-Reply-To: <32612923.A9jgX3dogm@tedd-ubuntu>
References: <32612923.A9jgX3dogm@tedd-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch enables the Intel Bluetooth device (UART sku) over the H4 protocol.
> It is responsible for bring up the device into known state by configuring
> the baudrate and applying the patches, if required.
> 
> ---
>  Makefile.tools          |    3 +-
>  tools/hciattach.8       |    3 +
>  tools/hciattach.c       |   13 ++
>  tools/hciattach.h       |    1 +
>  tools/hciattach_intel.c |  596 
> +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 615 insertions(+), 1 deletion(-)
>  create mode 100644 tools/hciattach_intel.c

looks good to me.

Johan, feel free to apply this patch.

Regards

Marcel



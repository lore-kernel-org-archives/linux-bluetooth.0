Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 10:41:29 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hciattach: Add support for Intel Bluetooth device
Message-ID: <20120516074129.GA17339@x220>
References: <1337102609-7922-1-git-send-email-tedd.an@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337102609-7922-1-git-send-email-tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

On Tue, May 15, 2012, Tedd Ho-Jeong An wrote:
> This patch enables the Intel Bluetooth device (UART sku) over the H4
> protocol. It is responsible for bring up the device into known state
> by configuring the baudrate and applying the patches, if required.
> 
> ---
>  Makefile.tools          |    3 +-
>  tools/hciattach.8       |    3 +
>  tools/hciattach.c       |   13 ++
>  tools/hciattach.h       |    1 +
>  tools/hciattach_intel.c |  596 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 615 insertions(+), 1 deletion(-)
>  create mode 100644 tools/hciattach_intel.c

Applied. Thanks.

Johan

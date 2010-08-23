Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Aug 2010 23:41:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Matthew Wilson <mtwilson@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [PATCH v4] Firmware download for Qualcomm Bluetooth devices
Message-ID: <20100823204107.GA7225@jh-x301>
References: <20100820223757.GA23924@jh-x301>
 <1282580267-2146-1-git-send-email-mtwilson@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282580267-2146-1-git-send-email-mtwilson@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matt,

On Mon, Aug 23, 2010, Matthew Wilson wrote:
> Configures device address from hciattach parameter.
> UART speed limited to 115200.
> Requires separate device specific firmware.
> ---
>  Makefile.tools             |    3 +-
>  tools/hciattach.c          |   10 ++
>  tools/hciattach.h          |    1 +
>  tools/hciattach_qualcomm.c |  279 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 292 insertions(+), 1 deletions(-)
>  create mode 100644 tools/hciattach_qualcomm.c

Thanks. The patch is now pushed upstream with a few more cosmetic
(coding style) changes. Take a look at the upstream tree if you're
interested in the details.

Johan

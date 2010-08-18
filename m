Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Aug 2010 13:30:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: host level Support for Atheros AR300x
 device
Message-ID: <20100818103027.GA31410@jh-x301>
References: <1282123768-27981-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282123768-27981-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

On Wed, Aug 18, 2010, Suraj Sumangala wrote:
> Implements support for Atheros AR300x Bluetooth chip in
> hciattach application. Supports configuration download
> and power management configure feature.
> ---
>  Makefile.tools          |    3 +-
>  tools/hciattach.8       |    3 +
>  tools/hciattach.c       |   12 +
>  tools/hciattach.h       |    3 +
>  tools/hciattach_ath3k.c |  953 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 973 insertions(+), 1 deletions(-)
>  create mode 100644 tools/hciattach_ath3k.c

Thanks. The patch is now pushed upstream with a minor cleanup of the
commit message as well as the following coding style issue:

> +static void update_tag_data(struct ps_cfg_entry *tag,
> +			    struct tag_info *info, const char *ptr)

The second line uses mixed tabs and spaces for indentation (it should
only be tabs).

Johan

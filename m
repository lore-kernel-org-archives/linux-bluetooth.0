Return-Path: <cyrus@holtmann.org>
Message-ID: <1355938892.29264.1.camel@aeonflux>
Subject: Re: [PATCH v5 11/16] sbc: Add SBC_MSBC flag to enable 15 block
 encoding
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 19 Dec 2012 18:41:32 +0100
In-Reply-To: <1355497417-10357-12-git-send-email-frederic.dalleau@linux.intel.com>
References: <1355497417-10357-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1355497417-10357-12-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> The sbc API provides a flag parameter which is currently unused. This patch
> defines the SBC_MSBC flag. The meaning of this flag is to encode 15 blocks.
> ---
>  sbc/sbc.c |   35 +++++++++++++++++++++++++++--------
>  sbc/sbc.h |    3 +++
>  2 files changed, 30 insertions(+), 8 deletions(-)

I rather have it done with

	sbc_init_msbc(sbc_t *sbc, unsigned long flags);

Regards

Marcel



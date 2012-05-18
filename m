Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 May 2012 20:52:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: joohi.rastogi@stericsson.com
Cc: User Name <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] AVRCP: Refactor the code using constants
Message-ID: <20120518175253.GB11492@x220.P-661HNU-F1>
References: <1337318710-28710-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337318710-28710-1-git-send-email-joohi.rastogi@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joohi,

On Fri, May 18, 2012, joohi.rastogi@stericsson.com wrote:
> ---
>  audio/avrcp.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)

You'll need to rebase this patch latest git since it doesn't apply
anymore. Additionally there were some issues:

> +	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
> +	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
> +			AVRCP_FEATURE_CATEGORY_2 |
> +			AVRCP_FEATURE_CATEGORY_3 |
> +			AVRCP_FEATURE_CATEGORY_4 );

This doesn't look like it's correctly indented. Split lines should be
indented as much as possible while staying under 80 characters.

> -	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103, feat = 0x000f;
> +	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103;
> +	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
> +                        AVRCP_FEATURE_CATEGORY_2 |
> +                        AVRCP_FEATURE_CATEGORY_3 |
> +                        AVRCP_FEATURE_CATEGORY_4 );

Same here.

Johan

Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Sheldon Demario <sheldon.demario@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 17 Nov 2010 06:25:23 -0800
Subject: RE: [PATCH] Adding a new option to specify security level for
 gatttool
Message-ID: <35B17FE5076C7040809188FBE7913F98406D465C43@SC1EXMB-MBCL.global.atheros.com>
References: <1289913613-3717-1-git-send-email-sheldon.demario@openbossa.org>
 <20101116153648.GA2710@jh-x301>
In-Reply-To: <20101116153648.GA2710@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Johan Hedberg
Sent: Tuesday, November 16, 2010 7:37 AM
To: Sheldon Demario
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adding a new option to specify security level for gatttool

Hi Sheldon,

On Tue, Nov 16, 2010, Sheldon Demario wrote:
> ---
>  TODO              |    6 ------
>  attrib/gatttool.c |   15 +++++++++++++--
>  2 files changed, 13 insertions(+), 8 deletions(-)

In general the patch seems fine, but:

> +	if (strncmp(opt_sec_level, "medium", 6) == 0)
> +		sec_level = BT_IO_SEC_MEDIUM;
> +	else if (strncmp(opt_sec_level, "high", 4) == 0)
> +		sec_level = BT_IO_SEC_HIGH;
> +	else
> +		sec_level = BT_IO_SEC_LOW;

Why do you use strncmp instead of strcmp (or even g_str_equal)? I don't
think there's any need to map e.g. "mediumfoobar" to BT_IO_SEC_MEDIUM ;)

[Mtsai] I am not sure what are the definition of "low", "medium" or "high". By the spec of Core 4.0, LE has 2 security modes and different security levels based on the method of pairing (or bonding). It may be appeal to end user with "low", "medium" and "high" definition, but it can't be reference with LE spec. I would suggest, instead, following terms,

	"No security",
	"unauthenticated encryption",
	"authenticated encryption",
	"unauthenticated data signing",
	"authenticated data signing,

Mike


Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

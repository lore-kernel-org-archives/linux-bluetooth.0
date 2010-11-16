Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 15:36:48 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adding a new option to specify security level for
 gatttool
Message-ID: <20101116153648.GA2710@jh-x301>
References: <1289913613-3717-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289913613-3717-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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

Johan

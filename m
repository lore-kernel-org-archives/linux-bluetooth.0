Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Nov 2010 14:21:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Extend discover characteristic by UUID in gatttool to
 fetch all values
Message-ID: <20101125122110.GA20559@jh-x301>
References: <1290515839-11867-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290515839-11867-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Tue, Nov 23, 2010, Sheldon Demario wrote:
> If the number of characteristics returned exceeds the MTU size, it will
> be needed to ask for more data until the handle range is entirely
> searched.
> ---
>  attrib/gatttool.c |   24 +++++++++++++++++++++++-
>  1 files changed, 23 insertions(+), 1 deletions(-)

Thanks.

> +	if ((status == ATT_ECODE_ATTR_NOT_FOUND) &&
> +			(char_data->start != opt_start))
> +		goto done;

No need for the extra () here. However, since it was the only issue I
found I fixed it myself and pushed the patch upstream.

Johan

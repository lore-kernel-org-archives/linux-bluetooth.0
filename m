Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Oct 2010 15:30:44 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix suspend stream on opening if no data
Message-ID: <20101013123044.GA2821@jh-x301>
References: <1286972456-6168-1-git-send-email-dmitriy.paliy@nokia.com>
 <1286972456-6168-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286972456-6168-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Oct 13, 2010, Dmitriy Paliy wrote:
> Fix write to stream and suspend it immidiately if there is no data
> available.
> ---
>  src/obex.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)

Looks good. The patch has been pushed upstream. Do pay attention to
whitespace issues in the future though. I got this when applying it:

Applying: Fix suspend stream on opening if no data
/home/jh/src/obexd/.git/rebase-apply/patch:18: trailing whitespace.
warning: 1 line applied after fixing whitespace errors.

This came from the empty line with two tabs after the AddHeader call:

>  		OBEX_ObjectAddHeader (obex, obj, OBEX_HDR_BODY,
>  				hd, 0, OBEX_FL_STREAM_START);
> +		

Johan

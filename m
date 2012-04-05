Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 12:52:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: joohi.rastogi@stericsson.com
Cc: User Name <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] AVRCP: Fixed response length for Unit Info command
Message-ID: <20120405095258.GA30695@x220>
References: <1333604469-18883-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333604469-18883-1-git-send-email-joohi.rastogi@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joohi,

On Thu, Apr 05, 2012, joohi.rastogi@stericsson.com wrote:
> From: Joohi Rastogi <joohi.rastogi@stericsson.com>
> 
> This affect PTS Test Case TC_TG_ICC_BV_01_I
> ---
>  audio/avctp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 009b94c..91a7886 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -271,7 +271,7 @@ static size_t handle_unit_info(struct avctp *session,
>  
>  	DBG("reply to AVC_OP_UNITINFO");
>  
> -	return 0;
> +	return operand_count;
>  }
>  
>  static size_t handle_subunit_info(struct avctp *session,

Applied. Thanks.

Johan

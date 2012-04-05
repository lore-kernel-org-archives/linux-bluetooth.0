Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 12:53:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: joohi.rastogi@stericsson.com
Cc: User Name <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] AVRCP: Fixed response length for Subunit Info command
Message-ID: <20120405095312.GB30695@x220>
References: <1333605488-23543-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333605488-23543-1-git-send-email-joohi.rastogi@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joohi,

On Thu, Apr 05, 2012, joohi.rastogi@stericsson.com wrote:
> From: Joohi Rastogi <joohi.rastogi@stericsson.com>
> 
> This affect PTS Test Case TC_TG_ICC_BV_02_I
> ---
>  audio/avctp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 009b94c..d8f740a 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -295,7 +295,7 @@ static size_t handle_subunit_info(struct avctp *session,
>  
>  	DBG("reply to AVC_OP_SUBUNITINFO");
>  
> -	return 0;
> +	return operand_count;
>  }
>  
>  static struct avctp_pdu_handler *find_handler(GSList *list, uint8_t opcode)

Applied. Thanks.

Johan

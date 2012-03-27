Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 15:04:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Joohi RASTOGI <joohi.rastogi@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH Bluez V2] avcrp: Fix response length for unit info
 command.
Message-ID: <20120327120424.GL14481@x220>
References: <3176460F0F455A44B2E93431E34FC86C1F884413AE@EXDCVYMBSTM005.EQ1STM.local>
 <3176460F0F455A44B2E93431E34FC86C1F884A643D@EXDCVYMBSTM005.EQ1STM.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3176460F0F455A44B2E93431E34FC86C1F884A643D@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 27, 2012, Joohi RASTOGI wrote:
> Hi,
> 
> Fixed response length for Unit Info command. This affect PTS Test Case TC_TG_ICC_BV_01_I.
> Changed the acronym AVRCP to uppercase.
> 
> From c4b1ac44ca4b608c550e8cb0b12c3b04d65aa05d Mon Sep 17 00:00:00 2001
> From: Joohi Rastogi <joohi.rastogi@stericsson.com>
> Date: Mon, 26 Mar 2012 11:53:19 +0530
> Subject: [PATCH] AVRCP: Fix response length for unit info command.
> 
> ---
>  audio/avctp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/avctp.c b/audio/avctp.c
> index dfad9fd..5b84977 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -268,7 +268,7 @@ static size_t handle_unit_info(struct avctp *session,
> 
>         DBG("reply to AVC_OP_UNITINFO");
> 
> -       return 0;
> +       return operand_count;
>  }
> 
>  static size_t handle_subunit_info(struct avctp *session,

Could you please resend both of your patches with git send-email (or if
you really are unable to use git send-email send them as attachments).
As they are right now I'm failing to pass them to "git am" from your
emails. Also, please include the references to the PTS test cases in the
commit message instead of having that somewhere external.

Johan

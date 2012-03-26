Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3176460F0F455A44B2E93431E34FC86C1F884413AE@EXDCVYMBSTM005.EQ1STM.local>
References: <3176460F0F455A44B2E93431E34FC86C1F884413AE@EXDCVYMBSTM005.EQ1STM.local>
Date: Mon, 26 Mar 2012 11:19:27 -0300
Message-ID: <CABBYNZ+pAfh=HbTYc8aBArbquqQK3DdZKTwCPo-LJ5C_+ZAwAQ@mail.gmail.com>
Subject: Re: [PATCH Bluez] avcrp: Fix response length for unit info command.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Joohi RASTOGI <joohi.rastogi@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joohi,

On Mon, Mar 26, 2012 at 3:44 AM, Joohi RASTOGI
<joohi.rastogi@stericsson.com> wrote:
> Hi,
>
> Fixed response length for Unit Info command. This affect PTS Test Case for TC_TG_ICC_BV_01_I.
>
> From f03c6037836bf8ef5253f8d87edb8ec2db0742af Mon Sep 17 00:00:00 2001
> From: Joohi Rastogi <joohi.rastogi@stericsson.com>
> Date: Mon, 26 Mar 2012 11:53:19 +0530
> Subject: [PATCH Bluez] avcrp: Fix response length for unit info command.
>
> ---
>  audio/avctp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index dfad9fd..5b84977 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -268,7 +268,7 @@ static size_t handle_unit_info(struct avctp *session,
>
>        DBG("reply to AVC_OP_UNITINFO");
>
> -       return 0;
> +       return operand_count;
>  }
>
>  static size_t handle_subunit_info(struct avctp *session,
> --
> 1.7.5.4
>
> -Joohi Rastogi

Looks correct, ack. Btw please use uppercase for acronyms such as AVRCP.

-- 
Luiz Augusto von Dentz

Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 May 2011 14:03:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] AVRCP TG now return REJECTED response
Message-ID: <20110527110342.GA14479@dell.amr.corp.intel.com>
References: <AC090B9732AB2B4DB7FF476E907FE6600130F70785@dnce02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC090B9732AB2B4DB7FF476E907FE6600130F70785@dnce02.ent.ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

On Sun, May 22, 2011, Ilia, Kolominsky wrote:
> From 1db53842d930c84d381401e44a9c340adfc5a411 Mon Sep 17 00:00:00 2001
> From: Ilia Kolomisnky <iliak@ti.com>
> Date: Sun, 22 May 2011 11:49:30 +0300
> Subject: [PATCH] AVRCP TG now return REJECTED response
>  AVRCP TG now return REJECTED response with error code==Invalid command for command with VENDOR-DEPENDED oper. code ( fix for PTS certification )
> 
> ---
>  audio/control.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)

Thanks for the patch, however it doesn't apply with git am. Could you
try to resend with git send-email after fixing the following coding
style issues:

> @@ -493,6 +514,8 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
>         unsigned char buf[1024], *operands;
>         struct avctp_header *avctp;
>         struct avrcp_header *avrcp;
> +       struct avrcp_spec_avc_pdu *pdu_spec;
> +
>         int ret, packet_size, operand_count, sock;
>  
>         if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> @@ -569,6 +592,16 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
>                         operands[1] = SUBUNIT_PANEL << 3;
>                 DBG("reply to %s", avrcp->opcode == OP_UNITINFO ?
>                                 "OP_UNITINFO" : "OP_SUBUNITINFO");
> +       } else if ( avrcp->opcode == OP_VENDORDEP ) {

Since pdu_spec is only used within this else if scope could you move the
definition here?

> +               /* reply with REJECT msg with err. code == 0x0 ( Invalid Command ) as defined in AVRCP spec ( 6.15.1 ) */
> +               pdu_spec = ( struct avrcp_spec_avc_pdu* ) ( buf + sizeof(struct avctp_header) + sizeof(struct avrcp_header) );

No line should be longer than 79 characters. Please split this up. The
proper format of the cast is (<type> *), i.e. the asterix has a space
before it. You could use a (void *) cast here to make it shorter.

Also, please fix your commit message. The summary line should not be
much more than 50 characters and the lines in the message body should
not be over 74 characters.

Johan

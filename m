Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 18:04:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] AVRCP TG now return REJECTED response
Message-ID: <20110529150406.GA26920@dell.ger.corp.intel.com>
References: <AC090B9732AB2B4DB7FF476E907FE66001310E5C72@dnce02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC090B9732AB2B4DB7FF476E907FE66001310E5C72@dnce02.ent.ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

On Sun, May 29, 2011, Ilia, Kolominsky wrote:
> AVRCP TG now return REJECTED response with error code==Invalid
> command for command with VENDOR-DEPENDED oper. code
> ( fix for PTS certification )
> ---
>  audio/control.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)

The patch looks better now, but it still doesn't apply with "git am".
Could you try sending it with git send-email and see if that helps? Also
try to apply it by to your own tree with "git am" before sending so we
avoid more unnecessary feedback rounds due this (if this still doesn't
help the fault might be in your outgoing mail server in which case
you'll need to ask your system admin to fix it or use another server).

There are also a couple more (minor) things to fix in the patch. Firstly
please fix your git author name to be "Firstname Lastname", i.e. without
the comma. Secondly, the following issues in the actual patch:

> @@ -493,6 +514,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
>         unsigned char buf[1024], *operands;
>         struct avctp_header *avctp;
>         struct avrcp_header *avrcp;
> +
>         int ret, packet_size, operand_count, sock;

Why are you adding an extra empty line here? Please don't do that.

> +       } else if ( avrcp->opcode == OP_VENDORDEP ) {

There should be no space after ( and before )

> +               /* reply with REJECT msg with err. code == 0x0 

There's an extra space character before the end of the line. Please
remove it.

> +               pdu_spec = (void *) ( buf + sizeof(struct avctp_header) 

Same here (extra space before newline). Also, I think I'd prefer not to
have a space after ( and before ).

Johan

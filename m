Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 May 2011 16:52:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ilia Kolomisnky <ilia.kolominsky@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Subject: Re: [PATCH v3] AVRCP TG now return REJECTED response
Message-ID: <20110530135229.GA23208@dell.amr.corp.intel.com>
References: <1306742598-3291-1-git-send-email-iliak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306742598-3291-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

On Mon, May 30, 2011, Ilia Kolomisnky wrote:
> AVRCP TG now return REJECTED response with error code==Invalid
> command for command with VENDOR-DEPENDED oper. code
> ( fix for PTS certification )
> ---
>  audio/control.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)

Now the patch applies cleanly! :)

However, some more improvements to make. Firstly to make the commit
message and its summary line readable and consistent with the rest of
the git history could you have it something like:

---
Fix response for vendor dependent AVRCP commands

AVRCP TG now returns a REJECTED response with the "Invalid command"
error code for VENDOR DEPENDENT commands. This fixes test cases with
recent PTS versions.
---

>  /* opcodes */
> +#define OP_VENDORDEP	0x0
>  #define OP_UNITINFO		0x30
>  #define OP_SUBUNITINFO		0x31
>  #define OP_PASSTHROUGH		0x7c

Use 0x00 instead of 0x0 and align it with the other values properly
(right now it's not aligned).

> @@ -493,6 +514,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
>  	unsigned char buf[1024], *operands;
>  	struct avctp_header *avctp;
>  	struct avrcp_header *avrcp;
> +
>  	int ret, packet_size, operand_count, sock;

Still this extra empty line. Seems that you forgot to remove it.

>  	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> @@ -569,6 +591,19 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
>  			operands[1] = SUBUNIT_PANEL << 3;
>  		DBG("reply to %s", avrcp->opcode == OP_UNITINFO ?
>  				"OP_UNITINFO" : "OP_SUBUNITINFO");
> +	} else if ( avrcp->opcode == OP_VENDORDEP ) {

Still spaces after ( and before ). Seems you forgot to remove them.

> +		/* reply with REJECT msg with err. code == 0x0
> +		 * ( Invalid Command ) as defined in AVRCP spec ( 6.15.1 ) */
> +		struct avrcp_spec_avc_pdu *pdu_spec;

Call this variable simply pdu.

> +		pdu_spec = (void *) ( buf + sizeof(struct avctp_header)
> +					+ sizeof(struct avrcp_header) );

There's already a variable in the function called operands which points
at the right place in buffer so you could just do:

struct avrcp_spec_avc_pdu *pdu = (void *) operands;

> +		pdu_spec->packet_type = 0;
> +		pdu_spec->rsvd = 0;
> +		pdu_spec->params[0] = 0; /* invalid command */
> +		pdu_spec->params_len = htons(1);

Later in the control_cb function there seems to be the assumption that
the response size matches the command size (packet_size comes from the
return value of the initial read system call):

	ret = write(sock, buf, packet_size);

AFAIK this is not always true and especially not in the vendor dependent
pdu case. So I think you'll need to fix other parts of the function as
well. Have you actually verified that your code does the right thing in
practice?

Johan

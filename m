Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Oct 2011 16:33:45 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Add parsing of A2MP signals
Message-ID: <20111026133343.GE11385@aemeltch-MOBL1>
References: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
 <1319239802-22457-3-git-send-email-pkrystad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319239802-22457-3-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Oct 21, 2011 at 04:30:00PM -0700, Peter Krystad wrote:
...
> @@ -923,6 +1004,240 @@ static inline void move_cfm_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm
>  	printf("Move cfm rsp: icid 0x%4.4x\n", icid);
>  }
>  
> +static inline void amp_command_rej(int level, struct frame *frm)
> +{
> +	amp_cmd_rej_parms *h = frm->ptr;
> +	uint16_t reason = btohs(h->reason);
> +
> +	if (p_filter(FILT_A2MP))
> +		return;
> +
> +	printf("Command Reject: reason (%d)- ", reason);
> +	p_indent(level + 1, frm);

This doesn't make sense to use p_indent if you print on the same line.
Maybe you forgot "\n" ?

> +	printf("%s\n", ampreason2str(reason));
> +}
> +

Best regards 
Andrei Emeltchenko 

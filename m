Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 11:12:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [hcidump PATCHv2 2/2] Decode A2MP Get AMP Assoc rsp
Message-ID: <20120516081203.GB28189@x220>
References: <1336637333-20723-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1336637333-20723-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336637333-20723-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, May 10, 2012, Andrei Emeltchenko wrote:
> +	printf("Country code: %c%c%c\n", chan_list->country_code[0],
> +	       chan_list->country_code[1], chan_list->country_code[2]);

We still use tabs-only indentation in user space. The above line is
violating this.

> +			printf("Reg ext id %d reg class %d coverage class %d\n",
> +			       triplet->ext.reg_extension_id,
> +			       triplet->ext.reg_class,
> +			       triplet->ext.coverage_class);

Same here.

> +			if (triplet->chans.num_channels == 1)
> +			printf("MAC: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
> +			       tlv->val[0], tlv->val[1], tlv->val[2],
> +			       tlv->val[3], tlv->val[4], tlv->val[5]);

And here. Btw, it also looks like the printf is incorrectly indented
(same indentation as the if).

> +			printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
> +			       tlv->val[0], tlv->val[1], tlv->val[2],
> +			       tlv->val[3]);

Tabs + spaces here again.

> +			printf("PAL VER: %2.2x Comp ID: %4.4x SubVer: %4.4x\n",
> +			       ver->ver, btohs(ver->company_id),
> +			       btohs(ver->sub_ver));

And here.

Johan

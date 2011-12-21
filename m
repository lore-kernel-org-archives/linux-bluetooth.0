Return-Path: <cyrus@holtmann.org>
Message-ID: <1324511576.1965.186.camel@aeonflux>
Subject: Re: [PATCH-v8 1/2] Bluetooth: Add MITM mechanism to LE-SMP
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 21 Dec 2011 15:52:56 -0800
In-Reply-To: <1324505319-3881-2-git-send-email-bgix@codeaurora.org>
References: <1324505319-3881-1-git-send-email-bgix@codeaurora.org>
	 <1324505319-3881-2-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> +static const u8	gen_method[5][5] = {

can the tab between u8 and gen_method please go away.

> +	{ JUST_WORKS, JUST_CFM, REQ_PASSKEY, JUST_WORKS, REQ_PASSKEY     },
> +	{ JUST_WORKS, JUST_CFM, REQ_PASSKEY, JUST_WORKS, REQ_PASSKEY     },
> +	{ CFM_PASSKEY, CFM_PASSKEY, REQ_PASSKEY, JUST_WORKS, CFM_PASSKEY },
> +	{ JUST_WORKS, JUST_CFM, JUST_WORKS, JUST_WORKS, JUST_CFM         },
> +	{ CFM_PASSKEY, CFM_PASSKEY, REQ_PASSKEY, JUST_WORKS, OVERLAP     },
> +};

Can you make sure all elements are aligned like you had it before. So
the table becomes readable. If you go over 80 chars here then that is
fine. So be it.

For the rest I am happy with it.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel



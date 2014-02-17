Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 13:26:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/6] emulator/bthost: Add function to send RFCOMM UIH
 frames from bthost
Message-ID: <20140217112623.GA4004@x220.p-661hnu-f1>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
 <1392205301-4204-5-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392205301-4204-5-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Feb 12, 2014, Marcin Kraglak wrote:
> This will make RFCOMM UIH frame and fill with data passed by user.
> ---
>  emulator/bthost.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  emulator/bthost.h |  3 +++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/emulator/bthost.c b/emulator/bthost.c
> index 92ae08a..6f3e538 100644
> --- a/emulator/bthost.c
> +++ b/emulator/bthost.c
> @@ -2174,6 +2174,49 @@ void bthost_add_channel_hook(struct bthost *bthost, uint16_t handle,
>  	conn->channel_hooks = hook;
>  }
>  
> +void bthost_send_uih(struct bthost *bthost, uint16_t handle, uint16_t cid,
> +			uint8_t channel, const void *data, uint16_t len)

Could we call this something like bthost_send_rfcomm() or
bthost_send_rfcomm_data() for clarity?

I also don't like the fact that you have to pass both cid and channel to
this function. Would it not be better to store enough RFCOMM specific
context and be able to lookup the necessary info just based on the
channel?

> +	hdr = (struct rfcomm_hdr *)uih_frame;

Coding style here (space before the variable name).

Johan

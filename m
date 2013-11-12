Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 19:06:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 3/4] android/pan: Add notify method to PAN
 notifications
Message-ID: <20131112170623.GA5058@x220.p-661hnu-f1>
References: <1384266042-6344-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1384266042-6344-4-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384266042-6344-4-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 12, 2013, Ravi kumar Veeramally wrote:
> ---
>  android/hal-pan.c | 6 ++++++
>  android/hal.h     | 1 +
>  2 files changed, 7 insertions(+)

I've applied the first two patches, but there's one issue with this one:

> +void bt_notify_pan(uint16_t opcode, void *buf, uint16_t len)
> +{
> +	if (!interface_ready())
> +		return;
> +}

Why is opcode uint16_t instead of uint8_t? Haven't we defined it as
uint8_t in our IPC document?

Johan

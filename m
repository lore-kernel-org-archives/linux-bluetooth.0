Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] doc/btsnoop: Add nop opcode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170901080744.11544-1-andrzej.kaczmarek@codecoup.pl>
Date: Fri, 1 Sep 2017 14:29:59 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <47E39EED-4F96-4128-BAD1-09CDE4FC7A2E@holtmann.org>
References: <20170901080744.11544-1-andrzej.kaczmarek@codecoup.pl>
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> This adds 'no operation' opcode for the cases where we do not want to
> include any particular payload, just the header is valid.
> 
> For example, when some packets are dropped over TTY implementation can
> pass this information only in some other packet and this won't happen
> until there's actually something to send. With this addition it can
> just send nop after some time to indicate there were packets dropped.
> ---
> doc/btsnoop.txt | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/doc/btsnoop.txt b/doc/btsnoop.txt
> index 975a53f6d..865b81554 100644
> --- a/doc/btsnoop.txt
> +++ b/doc/btsnoop.txt
> @@ -115,6 +115,13 @@ User Logging
> 
> 	User logging information.
> 
> +NOP
> +-----------
> +
> +	Code:        0xffff
> +
> +	No operation.
> +

Hmmm. I am not a huge fan of this. Then I see that we defined the ext_hdr that allows to deal with the dropped packets.

I need to think about this a bit since there are some other opcode extensions we have to do for certain cases where we have unexpected packets. Right now I would propose to use vendor diagnostic or system note with empty payload.

Regards

Marcel


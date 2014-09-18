Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Sep 2014 12:12:25 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] emulator/btdev: Add iovec support
Message-ID: <20140918091224.GB3505@aemeltch-MOBL1>
References: <1410958185-3878-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410958185-3878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Sep 17, 2014 at 03:49:44PM +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This convert btdev_set_send_handler to take struct iovec for doing
> scatter io.

...

> --- +	iov2[1].iov_base = &hdr;
> +	iov2[1].iov_len = sizeof(hdr);
>  
> -	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, pkt_data, pkt_len))
> -		send_packet(btdev, pkt_data, pkt_len);
> +	for (i = 0; i < iovlen; i++) {
> +		hdr.plen += iov[i].iov_len;
> +		iov2[2 + i].iov_base = iov[i].iov_base;
> +		iov2[2 + i].iov_len = iov[i].iov_len;
> +	}
>  
> -	free(pkt_data);
> +	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, iov[i].iov_base,
> +
> iov[i].iov_len))

This is wrong memory access. i == iovlen here.

Best regards 
Andrei Emeltchenko 


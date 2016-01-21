Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 21 Jan 2016 09:43:10 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Fugang Duan <b38611@freescale.com>
Cc: marcel@holtmann.org, johannes.berg@intel.com, jslaby@suse.cz,
	linux-bluetooth@vger.kernel.org, fugang.duan@nxp.com
Subject: Re: [PATCH] Bluetooth: add hdev check to avoid passing null pointer
Message-ID: <20160121084310.GA4046@t440s>
References: <1453351558-7726-1-git-send-email-b38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453351558-7726-1-git-send-email-b38611@freescale.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fuang,

On Thu, Jan 21, 2016, Fugang Duan wrote:
> Function hci_mgmt_cmd() may pass hdev with null pointer to hci_mgmt_handler->func()
> like below code:
> 	err = handler->func(sk, hdev, cp, len);
> 
> Add hdev check to avoid passing null pointer.
> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> ---
>  net/bluetooth/hci_sock.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 1298d72..7fdfc80 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1186,6 +1186,8 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
>  
>  	if (hdev && chan->hdev_init)
>  		chan->hdev_init(sk, hdev);
> +	else if (!hdev)
> +		goto done;

Why are you resending this? Did you see my response to your earlier
submission?

Johan

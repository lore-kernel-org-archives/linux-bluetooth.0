Return-Path: <johan.hedberg@gmail.com>
Date: Tue, 19 Jan 2016 14:04:04 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Fugang Duan <b38611@freescale.com>
Cc: gustavo@padovan.org, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: add hdev check to avoid passing null pointer
Message-ID: <20160119130404.GA27411@t440s.ice.intel.com>
References: <1453199661-7918-1-git-send-email-b38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453199661-7918-1-git-send-email-b38611@freescale.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fuang,

On Tue, Jan 19, 2016, Fugang Duan wrote:
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
>  
>  	cp = buf + sizeof(*hdr);

Nack. There are handlers which are not hci-dev specific, such as reading
version number, supported commands, or the index list. There's a special
flag HCI_MGMT_NO_HDEV that handlers can set to say that they expect to
be called without a hdev. The code in hci_mgmt_cmd() already makes sure
that any handler that doesn't set it will not be called with NULL hdev.

Johan

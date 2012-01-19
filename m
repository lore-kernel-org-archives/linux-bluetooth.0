Return-Path: <cyrus@holtmann.org>
Message-ID: <1326966663.1955.1.camel@aeonflux>
Subject: Re: [RFCv3 02/34] Bluetooth: trivial: clean up of l2cap_chan_connect
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Jan 2012 10:51:03 +0100
In-Reply-To: <1326964823-26747-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1326964823-26747-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 48b5c0d..5ace149 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1128,10 +1128,9 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>  	struct hci_conn *hcon;
>  	struct hci_dev *hdev;
>  	__u8 auth_type;
> -	int err;
> +	int err = 0;

NAK here. I do not consider this a cleanup. This might just hide some
errors along the way in the future. I rather have the compile tell if it
thinks that variable is used unassigned.

Regards

Marcel



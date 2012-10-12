Return-Path: <cyrus@holtmann.org>
Message-ID: <1350086005.19673.14.camel@aeonflux>
Subject: Re: [RFCv1 5/7] Bluetooth: AMP: Get amp_mgr reference in HS hci_conn
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 13 Oct 2012 01:53:25 +0200
In-Reply-To: <1350051005-6015-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1350051005-6015-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When assigning amp_mgr in hci_conn (type AMP_LINK) get also reference.
> In hci_conn_del those references would be put for both types.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/amp.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
> index 59da0f1..e525e23 100644
> --- a/net/bluetooth/amp.c
> +++ b/net/bluetooth/amp.c
> @@ -123,9 +123,11 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
>  	hcon->attempt++;
>  	hcon->handle = __next_handle(mgr);
>  	hcon->remote_id = remote_id;
> -	hcon->amp_mgr = mgr;
>  	hcon->out = out;
>  
> +	hcon->amp_mgr = mgr;
> +	amp_mgr_get(mgr);
> +

We could discuss that amp_mgt_get(mgr) should just return mgr and you
can write this like this:

	hcon->amp_mgr = amp_mgr_get(mgr);

Regards

Marcel



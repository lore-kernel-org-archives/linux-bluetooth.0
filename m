Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Nov 2012 19:28:12 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/4] Bluetooth: Set local_amp_id after getting Phylink
 Completed evt
Message-ID: <20121119212812.GB14006@joana>
References: <1352996096-27374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1352996096-27374-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352996096-27374-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-11-15 18:14:56 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> local_amp_id is used in l2cap_physical_cfm and shall be set up
> before calling it.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/amp.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
> index eb61aaa..ac9e8fe 100644
> --- a/net/bluetooth/amp.c
> +++ b/net/bluetooth/amp.c
> @@ -392,6 +392,7 @@ void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon)
>  
>  	set_bit(FLAG_EFS_ENABLE, &bredr_chan->flags);
>  	bredr_chan->remote_amp_id = hs_hcon->remote_id;
> +	bredr_chan->local_amp_id = hs_hcon->hdev->id;
>  	bredr_chan->hs_hcon = hs_hcon;
>  	bredr_chan->conn->mtu = hs_hcon->hdev->block_mtu;

I was able to apply patches 1 and 3 to bluetooth-next. The other 2 doesn't
apply for some reason, please rebase. Thanks.

	Gustavo

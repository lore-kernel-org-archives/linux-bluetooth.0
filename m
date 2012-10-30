Return-Path: <cyrus@holtmann.org>
Message-ID: <1351616002.1828.9.camel@aeonflux>
Subject: Re: [RFCv2 12/12] Bluetooth: Process Create Chan Request
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 30 Oct 2012 09:53:22 -0700
In-Reply-To: <1351612384-12392-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351612384-12392-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351612384-12392-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Add processing L2CAP Create Chan Request. When channel is created
> save associated high speed link hs_hcon.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index bdffc4c..0e14a1a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4238,6 +4238,7 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
>  {
>  	struct l2cap_create_chan_req *req = data;
>  	struct l2cap_chan *chan;
> +	struct hci_dev *hdev = NULL;
>  	u16 psm, scid;
>  
>  	if (cmd_len != sizeof(*req))
> @@ -4252,8 +4253,6 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
>  	BT_DBG("psm 0x%2.2x, scid 0x%4.4x, amp_id %d", psm, scid, req->amp_id);
>  
>  	if (req->amp_id) {
> -		struct hci_dev *hdev;
> -
>  		/* Validate AMP controller id */
>  		hdev = hci_dev_get(req->amp_id);
>  		if (!hdev || hdev->dev_type != HCI_AMP ||
> @@ -4267,19 +4266,33 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
>  
>  			l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
>  				       sizeof(rsp), &rsp);
> -
> -			if (hdev)
> -				hci_dev_put(hdev);
> -
> -			return 0;
> +			goto done;
>  		}
> -
> -		hci_dev_put(hdev);
>  	}
>  
>  	chan = l2cap_connect(conn, cmd, data, L2CAP_CREATE_CHAN_RSP,
>  			     req->amp_id);
>  
> +	if (chan && hdev) {
> +		struct amp_mgr *mgr = conn->hcon->amp_mgr;
> +		struct hci_conn *hs_hcon;
> +
> +		hs_hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK, conn->dst);
> +		if (!hs_hcon)
> +			goto done;
> +
> +		BT_DBG("mgr %p bredr_chan %p hs_hcon %p", mgr, chan, hs_hcon);
> +
> +		chan->local_amp_id = req->amp_id;
> +		mgr->bredr_chan = chan;
> +		chan->hs_hcon = hs_hcon;
> +		conn->mtu = hdev->block_mtu;
> +	}
> +
> +done:
> +	if (hdev)
> +		hci_dev_put(hdev);
> +

same comment that I gave Mat, I do not like these unbalanced locking or
in your case reference counting. That is just hacking it together.

Regards

Marcel



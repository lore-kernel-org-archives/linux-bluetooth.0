Return-Path: <cyrus@holtmann.org>
Message-ID: <1323093094.26198.49.camel@aeonflux>
Subject: Re: [RFCv1 2/3] Bluetooth: Simplify num_comp_pkts_evt function
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 05 Dec 2011 14:51:34 +0100
In-Reply-To: <1323089704-1005-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323089704-1005-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1323089704-1005-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Simplify function and remove fourth level of indentation.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c |   43 +++++++++++++++++++++++++------------------
>  1 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 273e1cb..fd7e6b5 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2288,28 +2288,35 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
>  		count  = get_unaligned_le16(ptr++);

actually we first need a cleanup of this function. This part is
horrible. It works because of our ptr cast to uint16, but we should
actually use a proper struct here. Maybe an info struct like we use for
inquiry result might be helpful here.

It also needs a check that we are in packet based flow control. If not,
we need to just ignore this event and print an error message.

>  		conn = hci_conn_hash_lookup_handle(hdev, handle);
> -		if (conn) {
> -			conn->sent -= count;
> -
> -			if (conn->type == ACL_LINK) {
> +		if (!conn)
> +			continue;
> +
> +		conn->sent -= count;
> +
> +		switch (conn->type) {
> +		case ACL_LINK:
> +			hdev->acl_cnt += count;
> +			if (hdev->acl_cnt > hdev->acl_pkts)
> +				hdev->acl_cnt = hdev->acl_pkts;
> +			break;
> +
> +		case LE_LINK:
> +			if (hdev->le_pkts) {
> +				hdev->le_cnt += count;
> +				if (hdev->le_cnt > hdev->le_pkts)
> +					hdev->le_cnt = hdev->le_pkts;
> +			} else {
>  				hdev->acl_cnt += count;
>  				if (hdev->acl_cnt > hdev->acl_pkts)
>  					hdev->acl_cnt = hdev->acl_pkts;
> -			} else if (conn->type == LE_LINK) {
> -				if (hdev->le_pkts) {
> -					hdev->le_cnt += count;
> -					if (hdev->le_cnt > hdev->le_pkts)
> -						hdev->le_cnt = hdev->le_pkts;
> -				} else {
> -					hdev->acl_cnt += count;
> -					if (hdev->acl_cnt > hdev->acl_pkts)
> -						hdev->acl_cnt = hdev->acl_pkts;
> -				}
> -			} else {
> -				hdev->sco_cnt += count;
> -				if (hdev->sco_cnt > hdev->sco_pkts)
> -					hdev->sco_cnt = hdev->sco_pkts;
>  			}
> +			break;
> +
> +		default:
> +			hdev->sco_cnt += count;
> +			if (hdev->sco_cnt > hdev->sco_pkts)
> +				hdev->sco_cnt = hdev->sco_pkts;
> +			break;

And this should be under SCO_LINK and default should print an error.

>  		}
>  	}
>  

Regards

Marcel



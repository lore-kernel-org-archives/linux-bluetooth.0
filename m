Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 10:11:50 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: ramm@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Device Scan and connection collision fix
Message-ID: <20120718071148.GC18697@aemeltch-MOBL1>
References: <1342542094-13486-1-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342542094-13486-1-git-send-email-ramm@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ram,

On Tue, Jul 17, 2012 at 07:21:34PM +0300, ramm@ti.com wrote:
> From: Ram Malovany <ramm@ti.com>
> 
> During search of devices, HCI Remote Name Request Command is sent for
> every device which name was not included in inquiry result. But the
> same command is also sent during incoming connection establishing
> procedure. Function hci_check_pending_name() was fixed in order to
> handle this situation which led to a kernel crash when initiating
> an incoming connection from a device that was not found in the
> inquiry while doing a search. There is no need to continue resolving
> the next name if we get the request from the incoming connection
> procedure as it will be done upon receiving another remote name
> request complete event
> 
> Signed-off-by: Ram Malovany <ramm@ti.com>
> ---
>  net/bluetooth/hci_event.c |   23 +++++++++++++++--------
>  1 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 41ff978..7a4f9e8 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1365,7 +1365,7 @@ static bool hci_resolve_next_name(struct hci_dev *hdev)
>  		return false;
>  
>  	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
> -	if (hci_resolve_name(hdev, e) == 0) {
> +	if (e && hci_resolve_name(hdev, e) == 0) {
>  		e->name_state = NAME_PENDING;
>  		return true;
>  	}
> @@ -1379,6 +1379,9 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
>  	struct discovery_state *discov = &hdev->discovery;
>  	struct inquiry_entry *e;
>  
> +	BT_DBG("name %p, name_len %d, discov->state %d",
> +		name, name_len, discov->state);
> +
>  	if (conn && !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
>  		mgmt_device_connected(hdev, bdaddr, ACL_LINK, 0x00, 0, name,
>  				      name_len, conn->dev_class);
> @@ -1393,13 +1396,17 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
>  		return;
>  
>  	e = hci_inquiry_cache_lookup_resolve(hdev, bdaddr, NAME_PENDING);
> -	if (e) {
> +

no space here

> +	if (!e)
> +		return;
> +
> +	list_del(&e->list);
> +	if (name) {
>  		e->name_state = NAME_KNOWN;
> -		list_del(&e->list);
> -		if (name)
> -			mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00,
> -					 e->data.rssi, name, name_len);
> -	}
> +		mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00,
> +				 e->data.rssi, name, name_len);
> +	} else

and braces here (this is coding style)

Otherwise

Reviewed-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>	

> +		e->name_state = NAME_NOT_KNOWN;
>  
>  	if (hci_resolve_next_name(hdev))
>  		return;
> @@ -1996,7 +2003,7 @@ static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  	struct hci_ev_remote_name *ev = (void *) skb->data;
>  	struct hci_conn *conn;
>  
> -	BT_DBG("%s", hdev->name);
> +	BT_DBG("%s, status 0x%2.2x", hdev->name, ev->status);
>  
>  	hci_conn_check_pending(hdev);
>  
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jul 2012 18:00:53 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: ramm@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Device Scan and connection collision fix
Message-ID: <20120717150046.GD5330@aemeltch-MOBL1>
References: <1342535940-11900-1-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342535940-11900-1-git-send-email-ramm@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ram,

On Tue, Jul 17, 2012 at 05:39:00PM +0300, ramm@ti.com wrote:
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
>  net/bluetooth/hci_event.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
>  mode change 100644 => 100755 net/bluetooth/hci_event.c
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> old mode 100644
> new mode 100755
> index 41ff978..11ff62a
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
> @@ -1394,11 +1397,16 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
>  
>  	e = hci_inquiry_cache_lookup_resolve(hdev, bdaddr, NAME_PENDING);
>  	if (e) {
> -		e->name_state = NAME_KNOWN;
>  		list_del(&e->list);
> -		if (name)
> +		if (name) {
> +			e->name_state = NAME_KNOWN;
>  			mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00,
>  					 e->data.rssi, name, name_len);
> +		} else {
> +			e->name_state = NAME_NOT_KNOWN;
> +		}
> +	} else {
> +	     return;

Sorry that didn't see that first time, but wouldn't it be better if you
use 

if (!e)
	return;

Otherwise there are way too much if-else.

Best regards 
Andrei Emeltchenko 


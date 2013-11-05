Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 10:09:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Remove unneeded check in
 hci_disconn_complete_evt()
Message-ID: <20131105080920.GA20765@x220.p-661hnu-f1>
References: <1383587847-16523-1-git-send-email-andre.guedes@openbossa.org>
 <1383587847-16523-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383587847-16523-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Nov 04, 2013, Andre Guedes wrote:
> According to b644ba336 (patch that introduced HCI_CONN_MGMT_CONNECTED
> flag), the HCI_CONN_MGMT_CONNECTED flag tracks when mgmt has been
> notified about the connection.
> 
> That being said, there is no point in checking this flag in hci_
> disconn_complete_evt() since neither mgmt_disconnect_failed() nor
> mgmt_device_disconnected() depend on it. Below follows more details:
>   * mgmt_disconnect_failed() removes pending MGMT_OP_DISCONNECT
>     commands, it doesn't matter if that connection was notified or not.
>   * mgmt_device_disconnected() sends the mgmt event only if the link
>     type is ACL_LINK or LE_LINK. For those connection type, the flag is
>     always set.
> 
> So this patch removes the HCI_CONN_MGMT_CONNECTED check.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 142aa61..560296d 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1792,16 +1792,14 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  	if (ev->status == 0)
>  		conn->state = BT_CLOSED;
>  
> -	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
> -		if (ev->status) {
> -			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
> -					       conn->dst_type, ev->status);
> -		} else {
> -			u8 reason = hci_to_mgmt_reason(ev->reason);
> +	if (ev->status) {
> +		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
> +				       conn->dst_type, ev->status);
> +	} else {
> +		u8 reason = hci_to_mgmt_reason(ev->reason);
>  
> -			mgmt_device_disconnected(hdev, &conn->dst, conn->type,
> -						 conn->dst_type, reason);
> -		}
> +		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
> +					 conn->dst_type, reason);
>  	}
>  
>  	if (ev->status == 0) {

It looks to me like this would cause an invalid mgmt_device_disconnected
event to be sent of the ACL goes down before we notify over mgmt that
it's connected. This could e.g. happen if the ACL disconnection happens
before we complete the implicit name resolving (which is the main reason
why this flag exists to begin with). Am I missing something here?

Johan

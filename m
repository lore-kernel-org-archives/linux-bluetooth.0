Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 1/1 v1] Bluetooth: Fix ACL alive for long in case of non pariable devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1372414472-15854-1-git-send-email-s.syam@samsung.com>
Date: Fri, 28 Jun 2013 09:23:27 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Sang-Ki Park <sangki79.park@samsung.com>
Message-Id: <2DF36CCC-A852-48C4-9CA7-208406E7AE8A@holtmann.org>
References: <1372414472-15854-1-git-send-email-s.syam@samsung.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> For certain devices (ex: HID mouse), support for authentication,
> pairing and bonding is optional. For such devices, the ACL alive
> for too long after the l2cap disconnection.
> 
> To avoid keep ACL alive for too long, set the ACL timeout back to
> HCI_DISCONN_TIMEOUT when l2cap is connected.
> 
> While merging the commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422
> this issue might have introduce.
> 
> Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
> net/bluetooth/l2cap_core.c |    4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9af3a76..80df756 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1383,6 +1383,10 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
> 
> 	BT_DBG("conn %p", conn);
> 

might be a good idea to add a comment here on why we are resetting the disc_timeout back to the original value.

> +	hci_conn_hold(conn->hcon);
> +	conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
> +	hci_conn_drop(conn->hcon);
> +
> 	/* For outgoing pairing which doesn't necessarily have an
> 	 * associated socket (e.g. mgmt_pair_device).
> 	 */

Regards

Marcel


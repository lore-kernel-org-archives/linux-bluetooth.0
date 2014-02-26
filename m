Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 03/17] Bluetooth: Stop scanning on LE connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393362104-12175-4-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 25 Feb 2014 22:23:19 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C16121F0-C942-4E45-9D4A-089D22195D12@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org> <1393362104-12175-4-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Some LE controllers don't support scanning and creating a connection
> at the same time. So we should always stop scanning in order to
> establish the connection.
> 
> Since we may prematurely stop the discovery procedure in favor of
> the connection establishment, we should also cancel hdev->le_scan_
> disable delayed work and set the discovery state to DISCOVERY_STOPPED.
> 
> This change does a small improvement since it is not mandatory the
> user stops scanning before connecting anymore. Moreover, this change
> is required by upcoming LE auto connection mechanism in order to work
> properly with controllers that don't support background scanning and
> connection establishment at the same time.
> 
> In future, we might want to do a small optimization by checking if
> controller is able to scan and connect at the same time. For now,
> we want the simplest approach so we always stop scanning (even if
> the controller is able to carry out both operations).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_conn.c    | 89 ++++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1bb45a4..c3834d3 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -356,6 +356,7 @@ enum {
> 
> /* ---- HCI Error Codes ---- */
> #define HCI_ERROR_AUTH_FAILURE		0x05
> +#define HCI_ERROR_MEMORY_EXCEEDED	0x07
> #define HCI_ERROR_CONNECTION_TIMEOUT	0x08
> #define HCI_ERROR_REJ_BAD_ADDR		0x0f
> #define HCI_ERROR_REMOTE_USER_TERM	0x13
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index dc8aad9..ae2c3e1 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -594,12 +594,83 @@ static int hci_create_le_conn(struct hci_conn *conn)
> 	return 0;
> }
> 
> +static void hci_req_add_le_create_conn(struct hci_request *req,
> +				       struct hci_conn *conn)
> +{
> +	struct hci_cp_le_create_conn cp;
> +	struct hci_dev *hdev = conn->hdev;
> +	u8 own_addr_type;
> +
> +	memset(&cp, 0, sizeof(cp));
> +
> +	/* Update random address, but set require_privacy to false so
> +	 * that we never connect with an unresolvable address.
> +	 */
> +	if (hci_update_random_address(req, false, &own_addr_type))
> +		return;
> +
> +	conn->src_type = own_addr_type;
> +
> +	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
> +	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
> +	bacpy(&cp.peer_addr, &conn->dst);
> +	cp.peer_addr_type = conn->dst_type;
> +	cp.own_address_type = conn->src_type;

the reason why you get the own_addr_type when setting the random address is to actually use it here.

This is important since in cases where LE Privacy is enabled and we are using RPA, we want the random address used.

Regards

Marcel


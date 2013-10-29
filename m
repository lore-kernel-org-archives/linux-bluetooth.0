Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 03/15] Bluetooth: Stop scanning on connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-4-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 29 Oct 2013 23:58:33 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <6E5A3838-07C3-48E8-8B9D-6A0225214FDC@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-4-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Some LE controllers don't support scanning and creating a connection
> at the same time. So, for those controllers, we should stop scanning
> in order to establish the connection.
> 
> Since we may prematurely stop the discovery procedure in favor of
> the connection establishment, we should also cancel hdev->le_scan_
> disable delayed work and set the discovery state to DISCOVERY_STOPPED.
> 
> This change does a small improvement since it is not mandatory user
> stops scanning before connecting anymore. Moreover, this change is
> required by upcoming LE auto connection mechanism in order to work
> properly with controllers that don't support background scanning and
> connection establishment at the same time.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c | 30 +++++++++++++++++++++++++++++-
> 1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 9fb7b44..195b78f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -518,8 +518,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
> {
> 	struct hci_conn *conn;
> 
> -	if (status == 0)
> +	if (status == 0) {
> +		cancel_delayed_work(&hdev->le_scan_disable);
> +		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> 		return;
> +	}
> 
> 	BT_ERR("HCI request failed to create LE connection: status 0x%2.2x",
> 	       status);
> @@ -543,6 +546,17 @@ done:
> 	hci_dev_unlock(hdev);
> }
> 
> +/* Check if controller supports creating a connection while scanning is
> + * runnning.
> + */
> +static bool is_scan_and_conn_supported(struct hci_dev *hdev)
> +{
> +	u8 mask = BIT(6) | BIT(7);
> +
> +	/* Return true if both bits are set */
> +	return (hdev->le_states[2] & mask) == mask;
> +}
> +
> static int hci_create_le_conn(struct hci_conn *conn)
> {
> 	struct hci_dev *hdev = conn->hdev;
> @@ -552,6 +566,20 @@ static int hci_create_le_conn(struct hci_conn *conn)
> 
> 	hci_req_init(&req, hdev);
> 
> +	/* If controller is scanning but it doesn't support scanning and
> +	 * creating a connection at the same time, we stop scanning.
> +	 * Otherwise, LE Create Connection command fails.
> +	 */
> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
> +	    !is_scan_and_conn_supported(hdev)) {
> +		struct hci_cp_le_set_scan_enable enable_cp;
> +
> +		memset(&enable_cp, 0, sizeof(enable_cp));
> +		enable_cp.enable = LE_SCAN_DISABLE;
> +		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
> +			    &enable_cp);
> +	}
> +

can we just start with that we always stop scanning before we try to connect something. I would like to get the really simple case working first.

We can figure out on how to deal with the LE supported states later on. Since that has more impact on all kinds of things anyway.

Regards

Marcel


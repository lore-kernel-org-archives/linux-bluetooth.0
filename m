Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Dec 2013 15:21:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v4 05/12] Bluetooth: Stop scanning on LE connection
Message-ID: <20131210132131.GA10392@x220.p-661hnu-f1>
References: <1386367549-29136-1-git-send-email-andre.guedes@openbossa.org>
 <1386367549-29136-6-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386367549-29136-6-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Dec 06, 2013, Andre Guedes wrote:
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
>  net/bluetooth/hci_conn.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b5c3ebff..750a39d 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -518,8 +518,17 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
>  {
>  	struct hci_conn *conn;
>  
> -	if (status == 0)
> +	if (status == 0) {
> +		/* If the discovery procedure was running, we prematurely
> +		 * stopped it. So we have to change the discovery state.
> +		 */
> +		if (hdev->discovery.state == DISCOVERY_FINDING) {
> +			cancel_delayed_work(&hdev->le_scan_disable);
> +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		}
> +
>  		return;
> +	}
>  
>  	BT_ERR("HCI request failed to create LE connection: status 0x%2.2x",
>  	       status);
> @@ -552,6 +561,18 @@ static int hci_create_le_conn(struct hci_conn *conn)
>  
>  	hci_req_init(&req, hdev);
>  
> +	/* If controller is scanning, we stop it since some controllers are
> +	 * not able to scan and connect at the same time.
> +	 */
> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
> +		struct hci_cp_le_set_scan_enable enable_cp;
> +
> +		memset(&enable_cp, 0, sizeof(enable_cp));
> +		enable_cp.enable = LE_SCAN_DISABLE;
> +		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
> +			    &enable_cp);
> +	}
> +
>  	memset(&cp, 0, sizeof(cp));
>  	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
>  	cp.scan_window = cpu_to_le16(hdev->le_scan_window);

The way this all hangs together with a discovery process started through
mgmt_start_discovery feels a bit flimsy to me. Particularly, have you
ensured that everything is fine if you've got inquiry ongoing when you
do hci_discovery_set_state(hdev, DISCOVERY_STOPPED). Also, are there any
risks of race conditions here, e.g. is it fine to let the
cancel_delayed_work() call be in create_le_conn_complete() instead of
doing it in hci_create_le_conn()?

What also makes this hard to track is that the condition you're testing
for first is the HCI_LE_SCAN bit, but then later you look at
discovery.state == DISCOVERY_FINDING. For the casual reader there's no
direct indication of how these two are releated for the various types of
discovery that are possible (LE-only, BR/EDR-only and interleaved).

I don't mean to say that this is a nack for the patch, but I'd like to
know that you've considered and tested this kind of cases. I had to
spend quite some time looking through the existing code and this patch
and still couldn't arrive at absolute confidence of its correctness,
meaning there should hopefully be some room for simplification.

Johan

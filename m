Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 11/15] Bluetooth: Temporarily stop background scanning on connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381965485-9159-12-git-send-email-andre.guedes@openbossa.org>
Date: Thu, 17 Oct 2013 11:43:32 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A1459AED-62FA-4042-B021-7A3157823952@holtmann.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org> <1381965485-9159-12-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Some LE controllers don't support scanning and initiating a connection
> at the same time. So, for those controllers, we should temporarily
> stop the background scanning and start it again once the connection
> attempt is finished (successfully or not).
> 
> So this patch introduces the hci_check_background_scan() which checks
> if the background scanning should be started.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_conn.c         | 25 +++++++++++++++++++++++++
> net/bluetooth/hci_core.c         | 18 ++++++++++++++++++
> net/bluetooth/hci_event.c        |  6 ++++++
> 4 files changed, 50 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index db39eca..017decc 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1201,5 +1201,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> 
> int hci_trigger_background_scan(struct hci_dev *hdev);
> int hci_untrigger_background_scan(struct hci_dev *hdev);
> +void hci_check_background_scan(struct hci_dev *hdev);
> 
> #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d64000e..6ae42c2 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -541,6 +541,18 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
> 
> done:
> 	hci_dev_unlock(hdev);
> +
> +	/* Check the background scanning since it may have been temporarily
> +	 * stopped if the controller doesn't support scanning and initiate
> +	 * state combination.
> +	 */
> +	hci_check_background_scan(hdev);
> +}

so what I would do first is assume the controller can not scan while being in initiating state or being connected. Make the dead simple only a single connection at a time work perfectly. Get the basic infrastructure in place.

> +
> +/* Check if controller supports scanning and initiating states combination */
> +static bool is_state_combination_supported(struct hci_dev *hdev)
> +{
> +        return (hdev->le_states[2] & BIT(6)) ? true : false;
> }
> 

Worst function name ever. Also this should use !!(hdev->le_states & x) style.

Also we need this more generic anyway. So get the simple part working for dumb controllers and we deal with the rest when that part works.

Regards

Marcel


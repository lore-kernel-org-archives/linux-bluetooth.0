Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v3 4/4] Bluetooth: Add directed advertising support through connect()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1394817753-7430-4-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 15 Mar 2014 09:22:03 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6B7CE848-2DD5-465B-85DB-132F0ACA105F@holtmann.org>
References: <1394817753-7430-1-git-send-email-johan.hedberg@gmail.com> <1394817753-7430-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're in peripheral mode (HCI_ADVERTISING flag is set) the most
> natural mapping of connect() is to perform directed advertising to the
> peer device.
> 
> This patch does the necessary changes to enable directed advertising and
> keeps the hci_conn state as BT_CONNECT in a similar way as is done for
> central or BR/EDR connection initiation.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_conn.c    | 75 ++++++++++++++++++++++++++++++++++++++++-----
> net/bluetooth/hci_event.c   | 17 ++++++++--
> 3 files changed, 83 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index be150cf8cd43..4261a67682c0 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -367,6 +367,7 @@ enum {
> #define HCI_ERROR_REMOTE_POWER_OFF	0x15
> #define HCI_ERROR_LOCAL_HOST_TERM	0x16
> #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
> +#define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
> 
> /* Flow control modes */
> #define HCI_FLOW_CTL_MODE_PACKET_BASED	0x00
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 1a025b953f19..088ee49097bc 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -367,9 +367,18 @@ static void le_conn_timeout(struct work_struct *work)
> {
> 	struct hci_conn *conn = container_of(work, struct hci_conn,
> 					     le_conn_timeout.work);
> +	struct hci_dev *hdev = conn->hdev;
> 
> 	BT_DBG("");
> 
> +	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
> +		u8 enable = 0x00;
> +		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
> +			     &enable);
> +		hci_le_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
> +		return;

you need to add a comment why just disabling advertising is the right thing here. And that we later on will actually re-enable it using undirected advertising.

Does it really need to be disabled first. The connection timeout error is not automatically disabling advertising anyway?

Regards

Marcel


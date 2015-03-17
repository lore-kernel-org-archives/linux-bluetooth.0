Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v4 3/7] Bluetooth: Split triggering le and interleaved scan into separate cases
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426556254-1480-3-git-send-email-jpawlowski@google.com>
Date: Mon, 16 Mar 2015 19:18:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <56E2E9D1-66A2-4D64-95B9-94B9CB604486@holtmann.org>
References: <1426556254-1480-1-git-send-email-jpawlowski@google.com> <1426556254-1480-3-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> This patch splits triggering of le and interleaved scan into
> separate cases.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/mgmt.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 92fa8e88..9d3c7a1 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4009,9 +4009,13 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
> 		break;
> 
> 	case DISCOV_TYPE_LE:
> +		if (!trigger_le_scan(req, status,
> +				     cpu_to_le16(DISCOV_LE_SCAN_INT)))
> +			return false;
> +		break;
> +
> 	case DISCOV_TYPE_INTERLEAVED:
> -		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
> -		    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
> +		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
> 			*status = MGMT_STATUS_NOT_SUPPORTED;
> 			return false;
> 		}

see my re-ordering with a fall through statement from my previous comment. Lets split them out properly first and then the sequence on how things evolve will make more sense. And I think this patch is then no longer needed.

Regards

Marcel


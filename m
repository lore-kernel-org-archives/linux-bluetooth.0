Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:34:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 06/13] Bluetooth: Use HCI request in interleaved
 discovery
Message-ID: <20130430083408.GH777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-7-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-7-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> +	case DISCOV_TYPE_INTERLEAVED:
> +		hci_dev_lock(hdev);
> +		hci_inquiry_cache_flush(hdev);
> +		hci_dev_unlock(hdev);
> +
> +		hci_req_init(&req, hdev);
> +
> +		memset(&cp, 0, sizeof(cp));
> +		memcpy(&cp.lap, lap, sizeof(cp.lap));
> +		cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
> +		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(cp), &cp);
> +
> +		err = hci_req_run(&req, inquiry_complete);
> +		if (err) {
> +			BT_ERR("Inquiry request failed: err %d", err);
> +			hci_dev_lock(hdev);
> +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +			hci_dev_unlock(hdev);
> +		}
> +		break;

The locking here seems a bit needlessly fine grained. I know hci_req_run
doesn't strictly speaking need the hdev lock but you could simplify this
a bit by moving the inquiry cache flush right before hci_req_run and
doing

	hci_dev_lock(hdev);

	hci_inquiry_cache_flush(hdev);

	err = hci_req_run(..);
	if (err) {
		...
	}

	hci_dev_unlock(hdev);

Johan

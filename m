Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Jan 2015 12:53:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 2/2] Bluetooth: Add restarting to service discovery
Message-ID: <20150116105342.GB1630@t440s.lan>
References: <1421240985-28944-1-git-send-email-jpawlowski@google.com>
 <1421240985-28944-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421240985-28944-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Jan 14, 2015, Jakub Pawlowski wrote:
> +static void restart_le_scan(struct hci_dev *hdev)
> +{
> +	/* If controller is not scanning we are done. */
> +	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		return;

Since this function is only called from mgmt_device_found() can this
condition actually ever be true?

> +
> +	queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
> +			   msecs_to_jiffies(DISCOV_LE_RESTART_DELAY));
> +}

What you should probably be checking for however is that scan_end <
jiffies + msecs_to_jiffies(DISCOV_LE_RESTART_DELAY) since then you know
that the scanning will have stopped by the tame the restart work gets
activated. Or am I thinking wrong here?

>  	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
> -	    (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
> +	    (rssi == HCI_RSSI_INVALID ||
> +	    (rssi < hdev->discovery.rssi && !test_bit(
> +			HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))

What I meant by splitting this is that the !test_bit would start on a
new line. That way you wouldn't need to break the line right after (

Johan

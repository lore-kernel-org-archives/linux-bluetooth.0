Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Dec 2014 15:14:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2 v1] Bluetooth: Fix missing hci_dev_lock/unlock in
 hci_event
Message-ID: <20141211131415.GA4060@t440s.P-661HNU-F1>
References: <1418278393-26981-1-git-send-email-jaganath.k@samsung.com>
 <1418278393-26981-2-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418278393-26981-2-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Dec 11, 2014, Jaganath Kanakkassery wrote:
>  static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -1172,11 +1184,14 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
>  		 * re-enable it again if necessary.
>  		 */
>  		if (test_and_clear_bit(HCI_LE_SCAN_INTERRUPTED,
> -				       &hdev->dev_flags))
> +				       &hdev->dev_flags)) {
> +			hci_dev_lock(hdev);
>  			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> -		else if (!test_bit(HCI_LE_ADV, &hdev->dev_flags) &&
> -			 hdev->discovery.state == DISCOVERY_FINDING)
> +			hci_dev_unlock(hdev);
> +		} else if (!test_bit(HCI_LE_ADV, &hdev->dev_flags) &&
> +			   hdev->discovery.state == DISCOVERY_FINDING) {
>  			mgmt_reenable_advertising(hdev);
> +		}
>  
>  		break;

Both patches look good to me, except for this part. It seems to me this
function is doing lots of things which should be under the hdev lock.
I'd put the lock() before the switch statement and the unlock after it.

Johan

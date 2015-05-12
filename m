Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 May 2015 15:18:48 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: wesley.kuo@intel.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix remote name event return directly.
Message-ID: <20150512121848.GA4613@t440s.lan>
References: <1431425837-25244-1-git-send-email-wesley.kuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431425837-25244-1-git-send-email-wesley.kuo@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wesley,

On Tue, May 12, 2015, wesley.kuo@intel.com wrote:
> From: wesleyku <wesley.kuo@intel.com>

You probably want to fix up your git author name to be of "First Last"
format. I don't think something like the above is acceptable to the git
history.

> @@ -2855,7 +2855,8 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
>  			 * finished, stop discovery, otherwise BR/EDR inquiry
>  			 * will stop discovery when finished.
>  			 */
> -			if (!test_bit(HCI_INQUIRY, &hdev->flags))
> +			if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
> +			    hdev->discovery.state != DISCOVERY_RESOLVING)
>  				hci_discovery_set_state(hdev,
>  							DISCOVERY_STOPPED);

Does the code comment above this if-statement also need additions or
clarifying? If so, please add that.

Johan

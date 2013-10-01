Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix workqueue synchronization in hci_dev_open
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380625828-19538-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Oct 2013 14:57:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <766D2125-676D-4E8A-B3B8-8892872D96EA@holtmann.org>
References: <1380625828-19538-1-git-send-email-johan.hedberg@gmail.com> <1380625828-19538-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When hci_sock.c calls hci_dev_open it needs to ensure that there isn't
> pending work in progress, such as that which is scheduled for the
> initial setup procedure or the one for automatically powering off after
> the setup procedure. This adds the necessary calls to ensure that any
> previously scheduled work is completed before attempting to call
> hci_dev_do_open.
> 
> This patch fixes a race with old user space versions where we might
> receive a HCIDEVUP ioctl before the setup procedure has been completed.
> When that happens the setup procedures callback may fail early and leave
> the device in an inconsistent state, causing e.g. the setup callback to
> be (incorrectly) called more than once.
> ---
> net/bluetooth/hci_core.c | 5 +++++
> 1 file changed, 5 insertions(+)

you might want to sign off your patch ;)

> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fc63e78..a216dcf 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1227,6 +1227,11 @@ int hci_dev_open(__u16 dev)
> 	if (!hdev)
> 		return -ENODEV;
> 
> +	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
> +		cancel_delayed_work(&hdev->power_off);
> +
> +	flush_workqueue(hdev->req_workqueue);
> +
> 	err = hci_dev_do_open(hdev);

And I think we should have a comment here on why we are doing this. Just to remind ourselves.

Regards

Marcel


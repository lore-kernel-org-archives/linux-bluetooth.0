Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 1/2] Bluetooth: Add reset_resume function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433207682-15064-1-git-send-email-labbott@fedoraproject.org>
Date: Tue, 2 Jun 2015 03:28:14 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Takashi Iwai <tiwai@suse.de>, Oliver Neukum <oneukum@suse.com>,
	Ming Lei <ming.lei@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>
Message-Id: <BB3BCC01-8BF0-4A17-B8E6-F17B875F1997@holtmann.org>
References: <1433207682-15064-1-git-send-email-labbott@fedoraproject.org>
To: Laura Abbott <labbott@fedoraproject.org>
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Laura,

> Bluetooth devices off of some buses such as USB may lose power across
> suspend/resume. When this happens, drivers may need to have the setup
> function called again and behave differently than a cold power on.
> Add a reset_resume function for drivers to call. During the
> reset_resume case, the flag HCI_RESET_RESUME will be set to allow
> drivers to differentate.
> 
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
> This matches with what hci_reset_dev does and also ensures
> the setup function gets called again.
> ---
> include/net/bluetooth/hci.h      |  1 +
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         | 16 ++++++++++++++++
> 3 files changed, 18 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index d95da83..6285410 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -185,6 +185,7 @@ enum {
> 	HCI_RAW,
> 
> 	HCI_RESET,
> +	HCI_RESET_RESUME,
> };

no more addition to this list of flags please. These are userspace exposed flags and with that ABI that we are never ever touching again. If you need flags on a per device basis, then use the second list.

> /* HCI socket flags */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a056c2b..14f9c72 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -941,6 +941,7 @@ int hci_register_dev(struct hci_dev *hdev);
> void hci_unregister_dev(struct hci_dev *hdev);
> int hci_suspend_dev(struct hci_dev *hdev);
> int hci_resume_dev(struct hci_dev *hdev);
> +int hci_reset_resume_dev(struct hci_dev *hdev);
> int hci_reset_dev(struct hci_dev *hdev);
> int hci_dev_open(__u16 dev);
> int hci_dev_close(__u16 dev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c4802f3..090762b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1558,6 +1558,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> 	BT_DBG("%s %p", hdev->name, hdev);
> 
> 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> +	    !test_bit(HCI_RESET_RESUME, &hdev->flags) &&
> 	    test_bit(HCI_UP, &hdev->flags)) {
> 		/* Execute vendor specific shutdown routine */
> 		if (hdev->shutdown)
> @@ -2110,6 +2111,7 @@ static void hci_power_on(struct work_struct *work)
> 		 */
> 		mgmt_index_added(hdev);
> 	}
> +	hci_dev_test_and_clear_flag(hdev, HCI_RESET_RESUME);

If you do not use the result of the test, why bother testing at all. Also you realize that you are a now clearing the flag on hdev->dev_flags and not hdev->flags.

It also means that this code is not tested when you actually have had a reset resume and then get a clean power down. Not running the shutdown procedure would be actually wrong in that case.

> }
> 
> static void hci_power_off(struct work_struct *work)
> @@ -3298,6 +3300,20 @@ int hci_reset_dev(struct hci_dev *hdev)
> }
> EXPORT_SYMBOL(hci_reset_dev);
> 
> +/*
> + * For USB reset_resume callbacks
> + */
> +int hci_reset_resume_dev(struct hci_dev *hdev)
> +{
> +	set_bit(HCI_RESET_RESUME, &hdev->flags);
> +	hci_dev_do_close(hdev);
> +	hci_dev_set_flag(hdev, HCI_SETUP);
> +
> +	queue_work(hdev->req_workqueue, &hdev->power_on);
> +	return 0;
> +}
> +EXPORT_SYMBOL(hci_reset_resume_dev);
> +

When we are reacting to a hardware error, we do hci_dev_do_close followed hci_dev_do_open. Why would you queue the power on work here. It sounds more like that this should be actually similar to hci_error_reset that gets queued.

And this is where I said the really tricky part comes in. Is the device keeping the firmware or not. We really need to know that one first. If it keeps its firmware, then we do not need to run through hdev->setup again.

>From a driver point of view, the current guarantee is that hdev->setup is only executed once. And this means really only once. It does not need to protect itself against being run again. So it should only be run again if the device looses all its states.

Regards

Marcel


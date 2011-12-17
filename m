Return-Path: <cyrus@holtmann.org>
Message-ID: <1324160017.1965.90.camel@aeonflux>
Subject: Re: [RFC 17/22] Bluetooth: remove power_on work_struct
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 17 Dec 2011 14:13:37 -0800
In-Reply-To: <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-17-git-send-email-padovan@profusion.mobi>
	 <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Since now we run in process context, we can now call hci_power_on
> directly.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_core.c         |    7 ++-----
>  net/bluetooth/mgmt.c             |    2 +-
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5d1bb51..662877a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -187,7 +187,6 @@ struct hci_dev {
>  
>  	struct workqueue_struct	*workqueue;
>  
> -	struct work_struct	power_on;
>  	struct delayed_work	power_off;
>  
>  	__u16			discov_timeout;
> @@ -597,6 +596,7 @@ int hci_register_dev(struct hci_dev *hdev);
>  void hci_unregister_dev(struct hci_dev *hdev);
>  int hci_suspend_dev(struct hci_dev *hdev);
>  int hci_resume_dev(struct hci_dev *hdev);
> +void hci_power_on(struct hci_dev *hdev);
>  int hci_dev_open(__u16 dev);
>  int hci_dev_close(__u16 dev);
>  int hci_dev_reset(__u16 dev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fbc7968..5c7fec8 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -928,10 +928,8 @@ void hci_free_dev(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL(hci_free_dev);
>  
> -static void hci_power_on(struct work_struct *work)
> +void hci_power_on(struct hci_dev *hdev)
>  {
> -	struct hci_dev *hdev = container_of(work, struct hci_dev, power_on);
> -
>  	BT_DBG("%s", hdev->name);
>  
>  	if (hci_dev_open(hdev->id) < 0)
> @@ -1490,7 +1488,6 @@ int hci_register_dev(struct hci_dev *hdev)
>  	INIT_LIST_HEAD(&hdev->adv_entries);
>  
>  	INIT_DELAYED_WORK(&hdev->adv_work, hci_clear_adv_cache);
> -	INIT_WORK(&hdev->power_on, hci_power_on);
>  	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
>  
>  	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
> @@ -1522,7 +1519,7 @@ int hci_register_dev(struct hci_dev *hdev)
>  
>  	set_bit(HCI_AUTO_OFF, &hdev->flags);
>  	set_bit(HCI_SETUP, &hdev->flags);
> -	queue_work(hdev->workqueue, &hdev->power_on);
> +	hci_power_on(hdev);
>  
>  	hci_notify(hdev, HCI_DEV_REG);
>  
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index ad4817c..30cbdd7 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -415,7 +415,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
>  	}
>  
>  	if (cp->val)
> -		queue_work(hdev->workqueue, &hdev->power_on);
> +		hci_power_on(hdev);
>  	else
>  		queue_work(hdev->workqueue, &hdev->power_off.work);

this is a bad idea. We are running with the hdev->workqueue now here we
do not wanna interrupt this. So I would rather leave this one out for
now. At least until we figured out on what is the best solution.

Obviously we should push it onto the system workqueue instead of
hdev->workqueue.

Regards

Marcel



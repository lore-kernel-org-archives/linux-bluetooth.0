Return-Path: <cyrus@holtmann.org>
Message-ID: <1323900964.1965.66.camel@aeonflux>
Subject: Re: [PATCH 5/7] Bluetooth: Add timer for automatically disabling
 the service cache
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Dec 2011 23:16:04 +0100
In-Reply-To: <1323899524-13653-6-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
	 <1323899524-13653-6-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We do not want the service cache to be enabled indefinitely after
> mgmt_read_info is called. The solve this a timer is added which will
> automaticall disable the cache if mgmt_set_dev_class isn't called within

it is "automatically".

> 5 seconds of calling mgmt_read_info.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +
>  net/bluetooth/hci_core.c         |    3 ++
>  net/bluetooth/mgmt.c             |   40 +++++++++++++++++++++++++++++++++----
>  3 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 4e67bb8..a5d7e42 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -200,6 +200,8 @@ struct hci_dev {
>  	__u16			discov_timeout;
>  	struct delayed_work	discov_off;
>  
> +	struct delayed_work	service_cache;
> +
>  	struct timer_list	cmd_timer;
>  	struct tasklet_struct	cmd_task;
>  	struct tasklet_struct	rx_task;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index ce3727e..323be52 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -597,6 +597,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>  	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
>  		cancel_delayed_work(&hdev->power_off);
>  
> +	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags))
> +		cancel_delayed_work(&hdev->service_cache);
> +
>  	hci_dev_lock_bh(hdev);
>  	inquiry_cache_flush(hdev);
>  	hci_conn_hash_flush(hdev);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 696e585..4d531b9 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -35,6 +35,8 @@
>  
>  #define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
>  
> +#define SERVICE_CACHE_TIMEOUT (5 * 1000)
> +
>  struct pending_cmd {
>  	struct list_head list;
>  	u16 opcode;
> @@ -472,6 +474,32 @@ static int update_class(struct hci_dev *hdev)
>  	return hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
>  }
>  
> +static void service_cache_off(struct work_struct *work)
> +{
> +	struct hci_dev *hdev = container_of(work, struct hci_dev,
> +							service_cache.work);
> +
> +	if (!test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags))
> +		return;
> +
> +	hci_dev_lock_bh(hdev);
> +
> +	update_eir(hdev);
> +	update_class(hdev);
> +
> +	hci_dev_unlock_bh(hdev);
> +}
> +
> +static void mgmt_init_hdev(struct hci_dev *hdev)
> +{
> +	if (!test_and_set_bit(HCI_MGMT, &hdev->flags))
> +		INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);

Why does this depend on MGMT being enabled? Why do we bother here? Why
not just always initialize it when registering the controller.

> +	if (!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->flags))
> +		queue_delayed_work(hdev->workqueue, &hdev->service_cache,
> +				msecs_to_jiffies(SERVICE_CACHE_TIMEOUT));
> +}
> +
>  static int read_controller_info(struct sock *sk, u16 index)
>  {
>  	struct mgmt_rp_read_info rp;
> @@ -489,10 +517,8 @@ static int read_controller_info(struct sock *sk, u16 index)
>  
>  	hci_dev_lock_bh(hdev);
>  
> -	if (test_and_clear_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags)) {
> -		set_bit(HCI_MGMT, &hdev->flags);
> -		set_bit(HCI_SERVICE_CACHE, &hdev->flags);
> -	}
> +	if (test_and_clear_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags))
> +		mgmt_init_hdev(hdev);
>  
>  	memset(&rp, 0, sizeof(rp));
>  
> @@ -992,8 +1018,12 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
>  	hdev->major_class = cp->major;
>  	hdev->minor_class = cp->minor;
>  
> -	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags))
> +	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags)) {
> +		hci_dev_unlock_bh(hdev);
> +		cancel_delayed_work_sync(&hdev->service_cache);
> +		hci_dev_lock_bh(hdev);
>  		update_eir(hdev);
> +	}

We have to be a bit careful here since essentially the service cache
(actually UUID cache to be precise) is a per mgmt socket feature and not
a per hdev feature.

I have nothing against merging this first, but keep in mind that this
needs to be updated since we can have two concurrent applications
opening a mgmt socket.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel



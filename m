Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: vhci: Fix race at creating hci device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1460647939-15637-1-git-send-email-tiwai@suse.de>
Date: Wed, 20 Apr 2016 15:16:57 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Message-Id: <7E72955A-1706-4F32-9568-FEE2565365BA@holtmann.org>
References: <1460647939-15637-1-git-send-email-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Takashi,

> hci_vhci driver creates a hci device object dynamically upon each
> HCI_VENDOR_PKT write.  Although it checks the already created object
> and returns an error, it's still racy and may build multiple hci_dev
> objects concurrently when parallel writes are performed, as the device
> tracks only a single hci_dev object.
> 
> This patch introduces a mutex to protect against the concurrent device
> creations.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> drivers/bluetooth/hci_vhci.c | 22 ++++++++++++++++------
> 1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index f67ea1c090cb..39230f30f544 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -50,6 +50,7 @@ struct vhci_data {
> 	wait_queue_head_t read_wait;
> 	struct sk_buff_head readq;
> 
> +	struct mutex open_mutex;
> 	struct delayed_work open_timeout;
> };
> 
> @@ -87,7 +88,7 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	return 0;
> }
> 
> -static int vhci_create_device(struct vhci_data *data, __u8 opcode)
> +static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> {
> 	struct hci_dev *hdev;
> 	struct sk_buff *skb;
> @@ -151,6 +152,19 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
> 	return 0;
> }
> 
> +static int vhci_create_device(struct vhci_data *data, __u8 opcode)
> +{
> +	int err;
> +
> +	mutex_lock(&data->open_mutex);
> +	if (data->hdev)
> +		err = -EBADFD;
> +	else
> +		err = __vhci_create_device(data, opcode);
> +	mutex_unlock(&data->open_mutex);
> +	return err;
> +}
> +
> static inline ssize_t vhci_get_user(struct vhci_data *data,
> 				    struct iov_iter *from)
> {
> @@ -191,11 +205,6 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
> 	case HCI_VENDOR_PKT:
> 		cancel_delayed_work_sync(&data->open_timeout);
> 
> -		if (data->hdev) {
> -			kfree_skb(skb);
> -			return -EBADFD;
> -		}
> -

why not just have the mutex around this block and the vhci_create_device in the timeout. Wouldn't that achieve exactly the same.

Since when you actually remove this check, then you still can create another hci_dev by just writing another vendor packet. That is actually something we want to avoid.

> 		opcode = *((__u8 *) skb->data);
> 		skb_pull(skb, 1);
> 
> @@ -320,6 +329,7 @@ static int vhci_open(struct inode *inode, struct file *file)
> 	skb_queue_head_init(&data->readq);
> 	init_waitqueue_head(&data->read_wait);
> 
> +	mutex_init(&data->open_mutex);
> 	INIT_DELAYED_WORK(&data->open_timeout, vhci_open_timeout);
> 
> 	file->private_data = data;

Regards

Marcel

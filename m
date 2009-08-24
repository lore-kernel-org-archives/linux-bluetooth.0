Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2009 15:49:24 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	linux-usb@vger.kernel.org, Arjan Van De Ven <arjan@linux.intel.com>,
	saharabeara@gmail.com
Subject: Re: btusb autosuspend and circular lock dep
Message-ID: <20090824224924.GA30024@gamba.jf.intel.com>
References: <20090615175435.GA4772@gamba.jf.intel.com> <200908242326.01149.oliver@neukum.org> <1251149817.2950.72.camel@localhost.localdomain> <200908242344.59861.oliver@neukum.org> <20090824215838.GA9991@gamba.jf.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
In-Reply-To: <20090824215838.GA9991@gamba.jf.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2009 at 02:58:38PM -0700, Sarah Sharp wrote:
> Hi Oliver,
> 
> I just tested this patch (against 2.6.31-rc7) on my X200s laptop, and it
> works fine with the Broadcom USB bluetooth device with VID:PID
> 0a5c:2145.  I tested transmitting audio to a bluetooth headset, so the
> isoc transfers to work fine.  ISTR you were concerned about them.
> 
> I'm still testing on my T61 (Broadcom 0a5c:2110).  The autosuspend patch
> seems to work fine, but I'm getting a circular lock dependency warning.
> I'm recompiling a vanilla 2.6.31-rc7 to see if the lock warning is still
> there.

The lock dep warning is still present in 2.6.31-rc7, so it's not your
auto-suspend patch.  The dmesg is attached.  The warning came right
after I stopped mplayer streaming audio to the bluetooth headset (with
CTRL+c).  I'm running an older gnome bluetooth stack from June 14
(from commit 7b1f2782).  I haven't tested whether updating the userspace
bits makes the lock dep warning go way.

Sarah

> On Mon, Aug 24, 2009 at 11:44:59PM +0200, Oliver Neukum wrote:
> > This patch adds support of USB autosuspend to the btusb driver
> > 
> > If the device doesn't support remote wakeup, simple support based
> > on up/down is provided. If the device supports remote wakeup,
> > additional support for autosuspend while the interface is up is provided.
> > This is done by queueing URBs in an anchor structure and waking the
> > device up from a work queue on sending. Reception triggers remote
> > wakeup.
> > The last busy facility of the USB autosuspend code is used and
> > to close a race between autosuspend and transmission a counter
> > of ongoing transmissions is maintained.
> > #ifdefs for CONFIG_PM are added as necessary.
> > 
> > Signed-off-by: Oliver Neukum <oliver@neukum.org>
> > 
> > --
> > 
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -35,7 +35,7 @@
> >  #include <net/bluetooth/bluetooth.h>
> >  #include <net/bluetooth/hci_core.h>
> >  
> > -#define VERSION "0.5"
> > +#define VERSION "0.6"
> >  
> >  static int ignore_dga;
> >  static int ignore_csr;
> > @@ -145,6 +145,7 @@ static struct usb_device_id blacklist_table[] = {
> >  #define BTUSB_INTR_RUNNING	0
> >  #define BTUSB_BULK_RUNNING	1
> >  #define BTUSB_ISOC_RUNNING	2
> > +#define BTUSB_SUSPENDING	3
> >  
> >  struct btusb_data {
> >  	struct hci_dev       *hdev;
> > @@ -157,11 +158,15 @@ struct btusb_data {
> >  	unsigned long flags;
> >  
> >  	struct work_struct work;
> > +	struct work_struct waker;
> >  
> >  	struct usb_anchor tx_anchor;
> >  	struct usb_anchor intr_anchor;
> >  	struct usb_anchor bulk_anchor;
> >  	struct usb_anchor isoc_anchor;
> > +	struct usb_anchor deferred;
> > +	int tx_in_flight;
> > +	spinlock_t txlock;
> >  
> >  	struct usb_endpoint_descriptor *intr_ep;
> >  	struct usb_endpoint_descriptor *bulk_tx_ep;
> > @@ -174,8 +179,23 @@ struct btusb_data {
> >  	unsigned int sco_num;
> >  	int isoc_altsetting;
> >  	int suspend_count;
> > +	int did_iso_resume:1;
> >  };
> >  
> > +static int inc_tx(struct btusb_data *data)
> > +{
> > +	unsigned long flags;
> > +	int rv;
> > +
> > +	spin_lock_irqsave(&data->txlock, flags);
> > +	rv = test_bit(BTUSB_SUSPENDING, &data->flags);
> > +	if (!rv)
> > +		data->tx_in_flight++;
> > +	spin_unlock_irqrestore(&data->txlock, flags);
> > +
> > +	return rv;
> > +}
> > +
> >  static void btusb_intr_complete(struct urb *urb)
> >  {
> >  	struct hci_dev *hdev = urb->context;
> > @@ -202,6 +222,7 @@ static void btusb_intr_complete(struct urb *urb)
> >  	if (!test_bit(BTUSB_INTR_RUNNING, &data->flags))
> >  		return;
> >  
> > +	usb_mark_last_busy(data->udev);
> >  	usb_anchor_urb(urb, &data->intr_anchor);
> >  
> >  	err = usb_submit_urb(urb, GFP_ATOMIC);
> > @@ -327,6 +348,7 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
> >  
> >  	urb->transfer_flags |= URB_FREE_BUFFER;
> >  
> > +	usb_mark_last_busy(data->udev);
> >  	usb_anchor_urb(urb, &data->bulk_anchor);
> >  
> >  	err = usb_submit_urb(urb, mem_flags);
> > @@ -465,6 +487,33 @@ static void btusb_tx_complete(struct urb *urb)
> >  {
> >  	struct sk_buff *skb = urb->context;
> >  	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
> > +	struct btusb_data *data = hdev->driver_data;
> > +
> > +	BT_DBG("%s urb %p status %d count %d", hdev->name,
> > +					urb, urb->status, urb->actual_length);
> > +
> > +	if (!test_bit(HCI_RUNNING, &hdev->flags))
> > +		goto done;
> > +
> > +	if (!urb->status)
> > +		hdev->stat.byte_tx += urb->transfer_buffer_length;
> > +	else
> > +		hdev->stat.err_tx++;
> > +
> > +done:
> > +	spin_lock(&data->txlock);
> > +	data->tx_in_flight--;
> > +	spin_unlock(&data->txlock);
> > +
> > +	kfree(urb->setup_packet);
> > +
> > +	kfree_skb(skb);
> > +}
> > +
> > +static void btusb_isoc_tx_complete(struct urb *urb)
> > +{
> > +	struct sk_buff *skb = urb->context;
> > +	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
> >  
> >  	BT_DBG("%s urb %p status %d count %d", hdev->name,
> >  					urb, urb->status, urb->actual_length);
> > @@ -490,11 +539,17 @@ static int btusb_open(struct hci_dev *hdev)
> >  
> >  	BT_DBG("%s", hdev->name);
> >  
> > +	err = usb_autopm_get_interface(data->intf);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	data->intf->needs_remote_wakeup = 1;
> > +
> >  	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
> > -		return 0;
> > +		goto done;
> >  
> >  	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
> > -		return 0;
> > +		goto done;
> >  
> >  	err = btusb_submit_intr_urb(hdev, GFP_KERNEL);
> >  	if (err < 0)
> > @@ -509,17 +564,28 @@ static int btusb_open(struct hci_dev *hdev)
> >  	set_bit(BTUSB_BULK_RUNNING, &data->flags);
> >  	btusb_submit_bulk_urb(hdev, GFP_KERNEL);
> >  
> > +done:
> > +	usb_autopm_put_interface(data->intf);
> >  	return 0;
> >  
> >  failed:
> >  	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> >  	clear_bit(HCI_RUNNING, &hdev->flags);
> > +	usb_autopm_put_interface(data->intf);
> >  	return err;
> >  }
> >  
> > +static void btusb_stop_traffic(struct btusb_data *data)
> > +{
> > +	usb_kill_anchored_urbs(&data->intr_anchor);
> > +	usb_kill_anchored_urbs(&data->bulk_anchor);
> > +	usb_kill_anchored_urbs(&data->isoc_anchor);
> > +}
> > +
> >  static int btusb_close(struct hci_dev *hdev)
> >  {
> >  	struct btusb_data *data = hdev->driver_data;
> > +	int err;
> >  
> >  	BT_DBG("%s", hdev->name);
> >  
> > @@ -529,13 +595,16 @@ static int btusb_close(struct hci_dev *hdev)
> >  	cancel_work_sync(&data->work);
> >  
> >  	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > -	usb_kill_anchored_urbs(&data->isoc_anchor);
> > -
> >  	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> > -	usb_kill_anchored_urbs(&data->bulk_anchor);
> > -
> >  	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > -	usb_kill_anchored_urbs(&data->intr_anchor);
> > +
> > +	btusb_stop_traffic(data);
> > +	err = usb_autopm_get_interface(data->intf);
> > +	if (err < 0)
> > +		return 0;
> > +
> > +	data->intf->needs_remote_wakeup = 0;
> > +	usb_autopm_put_interface(data->intf);
> >  
> >  	return 0;
> >  }
> > @@ -622,7 +691,7 @@ static int btusb_send_frame(struct sk_buff *skb)
> >  		urb->dev      = data->udev;
> >  		urb->pipe     = pipe;
> >  		urb->context  = skb;
> > -		urb->complete = btusb_tx_complete;
> > +		urb->complete = btusb_isoc_tx_complete;
> >  		urb->interval = data->isoc_tx_ep->bInterval;
> >  
> >  		urb->transfer_flags  = URB_ISO_ASAP;
> > @@ -633,12 +702,21 @@ static int btusb_send_frame(struct sk_buff *skb)
> >  				le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
> >  
> >  		hdev->stat.sco_tx++;
> > -		break;
> > +		goto skip_waking;
> >  
> >  	default:
> >  		return -EILSEQ;
> >  	}
> >  
> > +	err = inc_tx(data);
> > +	if (err) {
> > +		usb_anchor_urb(urb, &data->deferred);
> > +		schedule_work(&data->waker);
> > +		err = 0;
> > +		goto done;
> > +	}
> > +
> > +skip_waking:
> >  	usb_anchor_urb(urb, &data->tx_anchor);
> >  
> >  	err = usb_submit_urb(urb, GFP_ATOMIC);
> > @@ -646,10 +724,13 @@ static int btusb_send_frame(struct sk_buff *skb)
> >  		BT_ERR("%s urb %p submission failed", hdev->name, urb);
> >  		kfree(urb->setup_packet);
> >  		usb_unanchor_urb(urb);
> > +	} else {
> > +		usb_mark_last_busy(data->udev);
> >  	}
> >  
> >  	usb_free_urb(urb);
> >  
> > +done:
> >  	return err;
> >  }
> >  
> > @@ -721,8 +802,19 @@ static void btusb_work(struct work_struct *work)
> >  {
> >  	struct btusb_data *data = container_of(work, struct btusb_data, work);
> >  	struct hci_dev *hdev = data->hdev;
> > +	int err;
> >  
> >  	if (hdev->conn_hash.sco_num > 0) {
> > +		if (!data->did_iso_resume) {
> > +			err = usb_autopm_get_interface(data->isoc);
> > +			if (err < 0) {
> > +				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > +				usb_kill_anchored_urbs(&data->isoc_anchor);
> > +				return;
> > +			}
> > +
> > +			data->did_iso_resume = 1;
> > +		}
> >  		if (data->isoc_altsetting != 2) {
> >  			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> >  			usb_kill_anchored_urbs(&data->isoc_anchor);
> > @@ -742,9 +834,25 @@ static void btusb_work(struct work_struct *work)
> >  		usb_kill_anchored_urbs(&data->isoc_anchor);
> >  
> >  		__set_isoc_interface(hdev, 0);
> > +		if (data->did_iso_resume) {
> > +			data->did_iso_resume = 0;
> > +			usb_autopm_put_interface(data->isoc);
> > +		}
> >  	}
> >  }
> >  
> > +static void btusb_waker(struct work_struct *work)
> > +{
> > +	struct btusb_data *data = container_of(work, struct btusb_data, waker);
> > +	int err;
> > +
> > +	err = usb_autopm_get_interface(data->intf);
> > +	if (err < 0)
> > +		return;
> > +
> > +	usb_autopm_put_interface(data->intf);
> > +}
> > +
> >  static int btusb_probe(struct usb_interface *intf,
> >  				const struct usb_device_id *id)
> >  {
> > @@ -814,11 +922,14 @@ static int btusb_probe(struct usb_interface *intf,
> >  	spin_lock_init(&data->lock);
> >  
> >  	INIT_WORK(&data->work, btusb_work);
> > +	INIT_WORK(&data->waker, btusb_waker);
> > +	spin_lock_init(&data->txlock);
> >  
> >  	init_usb_anchor(&data->tx_anchor);
> >  	init_usb_anchor(&data->intr_anchor);
> >  	init_usb_anchor(&data->bulk_anchor);
> >  	init_usb_anchor(&data->isoc_anchor);
> > +	init_usb_anchor(&data->deferred);
> >  
> >  	hdev = hci_alloc_dev();
> >  	if (!hdev) {
> > @@ -943,6 +1054,7 @@ static void btusb_disconnect(struct usb_interface *intf)
> >  	hci_free_dev(hdev);
> >  }
> >  
> > +#ifdef CONFIG_PM
> >  static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
> >  {
> >  	struct btusb_data *data = usb_get_intfdata(intf);
> > @@ -952,22 +1064,44 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
> >  	if (data->suspend_count++)
> >  		return 0;
> >  
> > +	spin_lock_irq(&data->txlock);
> > +	if (!(interface_to_usbdev(intf)->auto_pm && data->tx_in_flight)) {
> > +		set_bit(BTUSB_SUSPENDING, &data->flags);
> > +		spin_unlock_irq(&data->txlock);
> > +	} else {
> > +		spin_unlock_irq(&data->txlock);
> > +		data->suspend_count--;
> > +		return -EBUSY;
> > +	}
> > +
> >  	cancel_work_sync(&data->work);
> >  
> > +	btusb_stop_traffic(data);
> >  	usb_kill_anchored_urbs(&data->tx_anchor);
> >  
> > -	usb_kill_anchored_urbs(&data->isoc_anchor);
> > -	usb_kill_anchored_urbs(&data->bulk_anchor);
> > -	usb_kill_anchored_urbs(&data->intr_anchor);
> > -
> >  	return 0;
> >  }
> >  
> > +static void play_deferred(struct btusb_data *data)
> > +{
> > +	struct urb *urb;
> > +	int err;
> > +
> > +	while ((urb = usb_get_from_anchor(&data->deferred))) {
> > +		err = usb_submit_urb(urb, GFP_ATOMIC);
> > +		if (err < 0)
> > +			break;
> > +
> > +		data->tx_in_flight++;	
> > +	}
> > +	usb_scuttle_anchored_urbs(&data->deferred);
> > +}
> > +
> >  static int btusb_resume(struct usb_interface *intf)
> >  {
> >  	struct btusb_data *data = usb_get_intfdata(intf);
> >  	struct hci_dev *hdev = data->hdev;
> > -	int err;
> > +	int err = 0;
> >  
> >  	BT_DBG("intf %p", intf);
> >  
> > @@ -975,13 +1109,13 @@ static int btusb_resume(struct usb_interface *intf)
> >  		return 0;
> >  
> >  	if (!test_bit(HCI_RUNNING, &hdev->flags))
> > -		return 0;
> > +		goto done;
> >  
> >  	if (test_bit(BTUSB_INTR_RUNNING, &data->flags)) {
> >  		err = btusb_submit_intr_urb(hdev, GFP_NOIO);
> >  		if (err < 0) {
> >  			clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > -			return err;
> > +			goto failed;
> >  		}
> >  	}
> >  
> > @@ -989,9 +1123,10 @@ static int btusb_resume(struct usb_interface *intf)
> >  		err = btusb_submit_bulk_urb(hdev, GFP_NOIO);
> >  		if (err < 0) {
> >  			clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> > -			return err;
> > -		} else
> > -			btusb_submit_bulk_urb(hdev, GFP_NOIO);
> > +			goto failed;
> > +		}
> > +
> > +		btusb_submit_bulk_urb(hdev, GFP_NOIO);
> >  	}
> >  
> >  	if (test_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
> > @@ -1001,16 +1136,35 @@ static int btusb_resume(struct usb_interface *intf)
> >  			btusb_submit_isoc_urb(hdev, GFP_NOIO);
> >  	}
> >  
> > +	spin_lock_irq(&data->txlock);
> > +	play_deferred(data);
> > +	clear_bit(BTUSB_SUSPENDING, &data->flags);
> > +	spin_unlock_irq(&data->txlock);
> > +	schedule_work(&data->work);
> > +
> >  	return 0;
> > +
> > +failed:
> > +	usb_scuttle_anchored_urbs(&data->deferred);
> > +done:
> > +	spin_lock_irq(&data->txlock);
> > +	clear_bit(BTUSB_SUSPENDING, &data->flags);
> > +	spin_unlock_irq(&data->txlock);
> > +
> > +	return err;
> >  }
> > +#endif
> >  
> >  static struct usb_driver btusb_driver = {
> >  	.name		= "btusb",
> >  	.probe		= btusb_probe,
> >  	.disconnect	= btusb_disconnect,
> > +#ifdef CONFIG_PM
> >  	.suspend	= btusb_suspend,
> >  	.resume		= btusb_resume,
> > +#endif
> >  	.id_table	= btusb_table,
> > +	.supports_autosuspend = 1,
> >  };
> >  
> >  static int __init btusb_init(void)
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="btusb-lockdep-warn-vanilla-2.6.31-rc7.txt"

Aug 24 15:03:20 gamba kernel: [   26.019531] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
Aug 24 15:03:20 gamba kernel: [   26.019664] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
Aug 24 15:03:21 gamba kernel: [   27.264963] e1000e: eth7 NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
Aug 24 15:03:21 gamba kernel: [   27.264968] 0000:00:19.0: eth7: 10/100 speed: disabling TSO
Aug 24 15:03:21 gamba kernel: [   27.265305] ADDRCONF(NETDEV_CHANGE): eth7: link becomes ready
Aug 24 15:03:22 gamba kernel: [   27.940256] usb 1-4.2: link qh8-0601/c1c9c480 start 5 [1/2 us]
Aug 24 15:03:22 gamba kernel: [   27.956306] usb 1-4.2: unlink qh8-0601/c1c9c480 start 5 [1/2 us]
Aug 24 15:03:22 gamba kernel: [   28.164102] ehci_hcd 0000:00:1a.7: reused qh c1c9c480 schedule
Aug 24 15:03:22 gamba kernel: [   28.164108] usb 1-4.2: link qh8-0601/c1c9c480 start 5 [1/2 us]
Aug 24 15:03:31 gamba kernel: [   37.420073] eth7: no IPv6 routers present
Aug 24 15:06:28 gamba kernel: [  213.996576] uhci_hcd 0000:00:1a.0: reserve dev 2 ep83-ISO, period 1, phase 0, 22 us
Aug 24 15:06:31 gamba kernel: [  216.748416] uhci_hcd 0000:00:1a.0: reserve dev 2 ep03-ISO, period 1, phase 0, 21 us
Aug 24 15:06:31 gamba kernel: [  216.970478] btusb_send_frame: hci0 urb ed858800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.970793] btusb_send_frame: hci0 urb ed858600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.971431] btusb_send_frame: hci0 urb ed858400 submission failed
Aug 24 15:06:31 gamba kernel: [  216.971740] btusb_send_frame: hci0 urb ed858200 submission failed
Aug 24 15:06:31 gamba kernel: [  216.972056] btusb_send_frame: hci0 urb ed858000 submission failed
Aug 24 15:06:31 gamba kernel: [  216.972379] btusb_send_frame: hci0 urb ed859e00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.972686] btusb_send_frame: hci0 urb ed859c00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.972991] btusb_send_frame: hci0 urb ed859a00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.974356] btusb_send_frame: hci0 urb ed85be00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.974658] btusb_send_frame: hci0 urb ed859000 submission failed
Aug 24 15:06:31 gamba kernel: [  216.974960] btusb_send_frame: hci0 urb ed859200 submission failed
Aug 24 15:06:31 gamba kernel: [  216.975261] btusb_send_frame: hci0 urb ed859400 submission failed
Aug 24 15:06:31 gamba kernel: [  216.975558] btusb_send_frame: hci0 urb ed859600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.975855] btusb_send_frame: hci0 urb ed859800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.976181] btusb_send_frame: hci0 urb ed859a00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.976475] btusb_send_frame: hci0 urb ed85ba00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.976770] btusb_send_frame: hci0 urb ed85b800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.978171] btusb_send_frame: hci0 urb ed85ce00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.978464] btusb_send_frame: hci0 urb ed85b000 submission failed
Aug 24 15:06:31 gamba kernel: [  216.978755] btusb_send_frame: hci0 urb ed85b200 submission failed
Aug 24 15:06:31 gamba kernel: [  216.979043] btusb_send_frame: hci0 urb ed85b400 submission failed
Aug 24 15:06:31 gamba kernel: [  216.979332] btusb_send_frame: hci0 urb ed85b600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.979618] btusb_send_frame: hci0 urb ed85b800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.979905] btusb_send_frame: hci0 urb ed85c600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.980506] btusb_send_frame: hci0 urb ed85c400 submission failed
Aug 24 15:06:31 gamba kernel: [  216.980790] btusb_send_frame: hci0 urb ed85c200 submission failed
Aug 24 15:06:31 gamba kernel: [  216.981914] btusb_send_frame: hci0 urb ed85d400 submission failed
Aug 24 15:06:31 gamba kernel: [  216.982197] btusb_send_frame: hci0 urb ed85d600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.982477] btusb_send_frame: hci0 urb ed85d800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.982756] btusb_send_frame: hci0 urb ed85da00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.983328] btusb_send_frame: hci0 urb ed85dc00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.983605] btusb_send_frame: hci0 urb ed85de00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.983878] btusb_send_frame: hci0 urb ed85c000 submission failed
Aug 24 15:06:31 gamba kernel: [  216.984172] btusb_send_frame: hci0 urb ed85c200 submission failed
Aug 24 15:06:31 gamba kernel: [  216.984445] btusb_send_frame: hci0 urb ed85d000 submission failed
Aug 24 15:06:31 gamba kernel: [  216.984720] btusb_send_frame: hci0 urb ed860e00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.984989] btusb_send_frame: hci0 urb ed860c00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.986571] btusb_send_frame: hci0 urb ed860200 submission failed
Aug 24 15:06:31 gamba kernel: [  216.986838] btusb_send_frame: hci0 urb ed860400 submission failed
Aug 24 15:06:31 gamba kernel: [  216.987103] btusb_send_frame: hci0 urb ed860600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.987366] btusb_send_frame: hci0 urb ed860800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.987629] btusb_send_frame: hci0 urb ed860a00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.987892] btusb_send_frame: hci0 urb ed860c00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.988172] btusb_send_frame: hci0 urb ed861600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.988433] btusb_send_frame: hci0 urb ed861400 submission failed
Aug 24 15:06:31 gamba kernel: [  216.988693] btusb_send_frame: hci0 urb ed861200 submission failed
Aug 24 15:06:31 gamba kernel: [  216.988968] btusb_send_frame: hci0 urb ed861000 submission failed
Aug 24 15:06:31 gamba kernel: [  216.990362] btusb_send_frame: hci0 urb ed863800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.990619] btusb_send_frame: hci0 urb ed863a00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.990874] btusb_send_frame: hci0 urb ed863c00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.991128] btusb_send_frame: hci0 urb ed863e00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.991379] btusb_send_frame: hci0 urb c1ea6400 submission failed
Aug 24 15:06:31 gamba kernel: [  216.991629] btusb_send_frame: hci0 urb c1ea6200 submission failed
Aug 24 15:06:31 gamba kernel: [  216.991880] btusb_send_frame: hci0 urb ed861000 submission failed
Aug 24 15:06:31 gamba kernel: [  216.992400] btusb_send_frame: hci0 urb ed864c00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.992647] btusb_send_frame: hci0 urb ed864a00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.992894] btusb_send_frame: hci0 urb ed864800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.994020] btusb_send_frame: hci0 urb ed865800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.994263] btusb_send_frame: hci0 urb ed865a00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.994507] btusb_send_frame: hci0 urb ed865c00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.994749] btusb_send_frame: hci0 urb ed865e00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.995249] btusb_send_frame: hci0 urb ed864400 submission failed
Aug 24 15:06:31 gamba kernel: [  216.995486] btusb_send_frame: hci0 urb ed864600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.995724] btusb_send_frame: hci0 urb ed864800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.995993] btusb_send_frame: hci0 urb ed868e00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.996260] btusb_send_frame: hci0 urb ed868c00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.996493] btusb_send_frame: hci0 urb ed868a00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.996725] btusb_send_frame: hci0 urb ed868800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.996955] btusb_send_frame: hci0 urb ed868600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.998514] btusb_send_frame: hci0 urb c1802600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.998744] btusb_send_frame: hci0 urb c1802800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.998971] btusb_send_frame: hci0 urb ed869600 submission failed
Aug 24 15:06:31 gamba kernel: [  216.999199] btusb_send_frame: hci0 urb ed869800 submission failed
Aug 24 15:06:31 gamba kernel: [  216.999426] btusb_send_frame: hci0 urb ed869a00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.999651] btusb_send_frame: hci0 urb ed869c00 submission failed
Aug 24 15:06:31 gamba kernel: [  216.999876] btusb_send_frame: hci0 urb ed869e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.000117] btusb_send_frame: hci0 urb ed868000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.000339] btusb_send_frame: hci0 urb ed868200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.000560] btusb_send_frame: hci0 urb ed868400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.000779] btusb_send_frame: hci0 urb ed868600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.002246] btusb_send_frame: hci0 urb ed86ce00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.002465] btusb_send_frame: hci0 urb ed86a000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.002680] btusb_send_frame: hci0 urb ed86a200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.002893] btusb_send_frame: hci0 urb ed86a400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.003106] btusb_send_frame: hci0 urb ed86a600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.003319] btusb_send_frame: hci0 urb ed86a800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.003528] btusb_send_frame: hci0 urb ed86aa00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.003736] btusb_send_frame: hci0 urb ed86ac00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.003943] btusb_send_frame: hci0 urb ed86ae00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.004380] btusb_send_frame: hci0 urb ed86c800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.004586] btusb_send_frame: hci0 urb ed86c600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.004791] btusb_send_frame: hci0 urb ed86c400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.004995] btusb_send_frame: hci0 urb ed86c200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.006374] btusb_send_frame: hci0 urb ed86fc00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.006577] btusb_send_frame: hci0 urb ed86d000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.006778] btusb_send_frame: hci0 urb ed86d200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.007182] btusb_send_frame: hci0 urb ed86d400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.007379] btusb_send_frame: hci0 urb ed86d600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.007576] btusb_send_frame: hci0 urb ed86d800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.007771] btusb_send_frame: hci0 urb ed86da00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.007963] btusb_send_frame: hci0 urb ed86dc00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.008174] btusb_send_frame: hci0 urb ed86de00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.008366] btusb_send_frame: hci0 urb ed86c000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.008557] btusb_send_frame: hci0 urb ed86c200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.008747] btusb_send_frame: hci0 urb ed86fa00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.008936] btusb_send_frame: hci0 urb ed86f800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.010490] btusb_send_frame: hci0 urb ee2f2600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.010677] btusb_send_frame: hci0 urb ee2f2800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.010860] btusb_send_frame: hci0 urb ed870800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.011043] btusb_send_frame: hci0 urb ed870a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.011226] btusb_send_frame: hci0 urb ed870c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.011407] btusb_send_frame: hci0 urb ed870e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.011586] btusb_send_frame: hci0 urb ed86f000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.011766] btusb_send_frame: hci0 urb ed86f200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.011944] btusb_send_frame: hci0 urb ed86f400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.012141] btusb_send_frame: hci0 urb ed86f600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.012317] btusb_send_frame: hci0 urb ed86f800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.012490] btusb_send_frame: hci0 urb ed870000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.012667] btusb_send_frame: hci0 urb ed871e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.012840] btusb_send_frame: hci0 urb ed871c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.014448] btusb_send_frame: hci0 urb ed871000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.014619] btusb_send_frame: hci0 urb ed871200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.014788] btusb_send_frame: hci0 urb ed871400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.014955] btusb_send_frame: hci0 urb ed871600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.015120] btusb_send_frame: hci0 urb ed871800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.015285] btusb_send_frame: hci0 urb ed871a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.015450] btusb_send_frame: hci0 urb ed871c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.015613] btusb_send_frame: hci0 urb ee2f2400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.015775] btusb_send_frame: hci0 urb ee2f2200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.015937] btusb_send_frame: hci0 urb ed873800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.016282] btusb_send_frame: hci0 urb ed873200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.016440] btusb_send_frame: hci0 urb ed873000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.016600] btusb_send_frame: hci0 urb ed874e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.016756] btusb_send_frame: hci0 urb ed874c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.016911] btusb_send_frame: hci0 urb ed874a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.018375] btusb_send_frame: hci0 urb ed876800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.018527] btusb_send_frame: hci0 urb ed876600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.018679] btusb_send_frame: hci0 urb ed876400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.018830] btusb_send_frame: hci0 urb ed876c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.018996] btusb_send_frame: hci0 urb ed876e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.019300] btusb_send_frame: hci0 urb ed874400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.019446] btusb_send_frame: hci0 urb ed874600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.019591] btusb_send_frame: hci0 urb ed874800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.019733] btusb_send_frame: hci0 urb ed874a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.019876] btusb_send_frame: hci0 urb ed876200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.020029] btusb_send_frame: hci0 urb ed876000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.020185] btusb_send_frame: hci0 urb ed877e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.020324] btusb_send_frame: hci0 urb ed877c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.020462] btusb_send_frame: hci0 urb ed877a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.020601] btusb_send_frame: hci0 urb ed877800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.020736] btusb_send_frame: hci0 urb ed877600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.020872] btusb_send_frame: hci0 urb ed877400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.021005] btusb_send_frame: hci0 urb ed877200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.022881] btusb_send_frame: hci0 urb ed878200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.023009] btusb_send_frame: hci0 urb ed878000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.023140] btusb_send_frame: hci0 urb ed87be00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.023269] btusb_send_frame: hci0 urb ed87bc00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.023396] btusb_send_frame: hci0 urb ed878a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.023523] btusb_send_frame: hci0 urb ed878c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.023649] btusb_send_frame: hci0 urb ed878e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.023774] btusb_send_frame: hci0 urb ed877000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.023897] btusb_send_frame: hci0 urb ed877200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.024029] btusb_send_frame: hci0 urb ed87ba00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.024163] btusb_send_frame: hci0 urb ed87b800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.024284] btusb_send_frame: hci0 urb ed87b600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.024404] btusb_send_frame: hci0 urb ed87b400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.024523] btusb_send_frame: hci0 urb ed87b200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.024640] btusb_send_frame: hci0 urb ed87b000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.024758] btusb_send_frame: hci0 urb ed87ce00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.024874] btusb_send_frame: hci0 urb ed87cc00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.026661] btusb_send_frame: hci0 urb ed87da00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.026773] btusb_send_frame: hci0 urb ed87d800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.026885] btusb_send_frame: hci0 urb ed87d600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.026994] btusb_send_frame: hci0 urb ed87d400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.027103] btusb_send_frame: hci0 urb ed87d200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.027211] btusb_send_frame: hci0 urb ed87c400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.027315] btusb_send_frame: hci0 urb ed87c600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.027421] btusb_send_frame: hci0 urb ed87c800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.027526] btusb_send_frame: hci0 urb ed87d000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.027632] btusb_send_frame: hci0 urb ed87fe00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.027732] btusb_send_frame: hci0 urb ed87fc00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.027833] btusb_send_frame: hci0 urb ed87fa00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.027932] btusb_send_frame: hci0 urb ed87f800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028149] btusb_send_frame: hci0 urb ed87f200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028247] btusb_send_frame: hci0 urb ed87f000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028346] btusb_send_frame: hci0 urb ed880e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028441] btusb_send_frame: hci0 urb ed880c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028535] btusb_send_frame: hci0 urb ed880a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028628] btusb_send_frame: hci0 urb ed880800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028720] btusb_send_frame: hci0 urb ed880600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028811] btusb_send_frame: hci0 urb ed880400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028901] btusb_send_frame: hci0 urb ed880200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.028987] btusb_send_frame: hci0 urb ed880000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031180] btusb_send_frame: hci0 urb ed882a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031265] btusb_send_frame: hci0 urb ed882800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031350] btusb_send_frame: hci0 urb ed882600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031433] btusb_send_frame: hci0 urb ed882400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031513] btusb_send_frame: hci0 urb ed882200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031595] btusb_send_frame: hci0 urb ed882000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031675] btusb_send_frame: hci0 urb ed883e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031754] btusb_send_frame: hci0 urb ed883c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031831] btusb_send_frame: hci0 urb ed883a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031908] btusb_send_frame: hci0 urb ed883800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.031983] btusb_send_frame: hci0 urb ed883600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032070] btusb_send_frame: hci0 urb ed883400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032153] btusb_send_frame: hci0 urb ed883200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032224] btusb_send_frame: hci0 urb ed883000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032298] btusb_send_frame: hci0 urb ed884e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032370] btusb_send_frame: hci0 urb ed884c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032439] btusb_send_frame: hci0 urb ed884a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032506] btusb_send_frame: hci0 urb ed884800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032573] btusb_send_frame: hci0 urb ed884600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032640] btusb_send_frame: hci0 urb ed884400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032706] btusb_send_frame: hci0 urb ed884200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032768] btusb_send_frame: hci0 urb ed884000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032834] btusb_send_frame: hci0 urb ed886e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032896] btusb_send_frame: hci0 urb ed886c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.032958] btusb_send_frame: hci0 urb ed886a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.033016] btusb_send_frame: hci0 urb ed886800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035388] btusb_send_frame: hci0 urb ed886800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035446] btusb_send_frame: hci0 urb ed886000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035502] btusb_send_frame: hci0 urb ed887e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035556] btusb_send_frame: hci0 urb ed887c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035609] btusb_send_frame: hci0 urb ed887a00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035661] btusb_send_frame: hci0 urb ed887800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035712] btusb_send_frame: hci0 urb ed887600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035763] btusb_send_frame: hci0 urb ed887400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035812] btusb_send_frame: hci0 urb ed887200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035858] btusb_send_frame: hci0 urb ed887000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035908] btusb_send_frame: hci0 urb ed888e00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.035999] btusb_send_frame: hci0 urb ed888c00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036069] btusb_send_frame: hci0 urb ed888400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036122] btusb_send_frame: hci0 urb ed888200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036163] btusb_send_frame: hci0 urb ed888000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036208] btusb_send_frame: hci0 urb ed88ae00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036249] btusb_send_frame: hci0 urb ed88ac00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036287] btusb_send_frame: hci0 urb ed88aa00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036325] btusb_send_frame: hci0 urb ed88a800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036363] btusb_send_frame: hci0 urb ed88a600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036399] btusb_send_frame: hci0 urb ed88a400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036435] btusb_send_frame: hci0 urb ed88a200 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036470] btusb_send_frame: hci0 urb ed88a000 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036504] btusb_send_frame: hci0 urb ed88be00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036534] btusb_send_frame: hci0 urb ed88bc00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036563] btusb_send_frame: hci0 urb ed88ba00 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036593] btusb_send_frame: hci0 urb ed88b800 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036622] btusb_send_frame: hci0 urb ed88b600 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036650] btusb_send_frame: hci0 urb ed88b400 submission failed
Aug 24 15:06:31 gamba kernel: [  217.036677] btusb_send_frame: hci0 urb ed88b200 submission failed
Aug 24 15:07:07 gamba kernel: [  253.032744] 
Aug 24 15:07:07 gamba kernel: [  253.032745] =================================
Aug 24 15:07:07 gamba kernel: [  253.032749] [ INFO: inconsistent lock state ]
Aug 24 15:07:07 gamba kernel: [  253.032752] 2.6.31-rc7 #47
Aug 24 15:07:07 gamba kernel: [  253.032754] ---------------------------------
Aug 24 15:07:07 gamba kernel: [  253.032756] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
Aug 24 15:07:07 gamba kernel: [  253.032760] bluetoothd/3863 [HC0[0]:SC0[0]:HE1:SE1] takes:
Aug 24 15:07:07 gamba kernel: [  253.032762]  (&conn->lock#2){+.?...}, at: [<f9b4d084>] sco_chan_del+0x22/0xb3 [sco]
Aug 24 15:07:07 gamba kernel: [  253.032774] {IN-SOFTIRQ-W} state was registered at:
Aug 24 15:07:07 gamba kernel: [  253.032776]   [<c014877e>] __lock_acquire+0x4af/0x713
Aug 24 15:07:07 gamba kernel: [  253.032784]   [<c0148a72>] lock_acquire+0x90/0xad
Aug 24 15:07:07 gamba kernel: [  253.032788]   [<c031c2d7>] _spin_lock+0x1b/0x2a
Aug 24 15:07:07 gamba kernel: [  253.032794]   [<f9b4d443>] sco_connect_cfm+0x40/0x1c5 [sco]
Aug 24 15:07:07 gamba kernel: [  253.032800]   [<f8754f06>] hci_event_packet+0x1bc1/0x1e53 [bluetooth]
Aug 24 15:07:07 gamba kernel: [  253.032816]   [<f87505c5>] hci_rx_task+0x7c/0x1ed [bluetooth]
Aug 24 15:07:07 gamba kernel: [  253.032826]   [<c012d011>] tasklet_action+0x5f/0xa6
Aug 24 15:07:07 gamba kernel: [  253.032831]   [<c012c1ee>] __do_softirq+0xb9/0x16a
Aug 24 15:07:07 gamba kernel: [  253.032835]   [<c012c2ca>] do_softirq+0x2b/0x43
Aug 24 15:07:07 gamba kernel: [  253.032839]   [<c012cca5>] irq_exit+0x35/0x63
Aug 24 15:07:07 gamba kernel: [  253.032843]   [<c01044e9>] do_IRQ+0x80/0x96
Aug 24 15:07:07 gamba kernel: [  253.032847]   [<c0102f6e>] common_interrupt+0x2e/0x34
Aug 24 15:07:07 gamba kernel: [  253.032851]   [<c0297c17>] cpuidle_idle_call+0x60/0x95
Aug 24 15:07:07 gamba kernel: [  253.032856]   [<c0101a1d>] cpu_idle+0x51/0x68
Aug 24 15:07:07 gamba kernel: [  253.032860]   [<c030c20b>] rest_init+0x53/0x55
Aug 24 15:07:07 gamba kernel: [  253.032864]   [<c047f817>] start_kernel+0x2b4/0x2b9
Aug 24 15:07:07 gamba kernel: [  253.032870]   [<c047f06a>] __init_begin+0x6a/0x6f
Aug 24 15:07:07 gamba kernel: [  253.032874]   [<ffffffff>] 0xffffffff
Aug 24 15:07:07 gamba kernel: [  253.032886] irq event stamp: 24631
Aug 24 15:07:07 gamba kernel: [  253.032888] hardirqs last  enabled at (24631): [<c012d196>] local_bh_enable+0x98/0x9e
Aug 24 15:07:07 gamba kernel: [  253.032893] hardirqs last disabled at (24629): [<c012d144>] local_bh_enable+0x46/0x9e
Aug 24 15:07:07 gamba kernel: [  253.032897] softirqs last  enabled at (24630): [<c02a2d7e>] lock_sock_nested+0xb0/0xbb
Aug 24 15:07:07 gamba kernel: [  253.032903] softirqs last disabled at (24628): [<c031c2f1>] _spin_lock_bh+0xb/0x2f
Aug 24 15:07:07 gamba kernel: [  253.032907] 
Aug 24 15:07:07 gamba kernel: [  253.032908] other info that might help us debug this:
Aug 24 15:07:07 gamba kernel: [  253.032911] 1 lock held by bluetoothd/3863:
Aug 24 15:07:07 gamba kernel: [  253.032913]  #0:  (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.+.}, at: [<f9b4d655>] sco_sock_close+0x15/0x7c [sco]
Aug 24 15:07:07 gamba kernel: [  253.032922] 
Aug 24 15:07:07 gamba kernel: [  253.032923] stack backtrace:
Aug 24 15:07:07 gamba kernel: [  253.032926] Pid: 3863, comm: bluetoothd Not tainted 2.6.31-rc7 #47
Aug 24 15:07:07 gamba kernel: [  253.032929] Call Trace:
Aug 24 15:07:07 gamba kernel: [  253.032934]  [<c0145dbe>] print_usage_bug+0x14d/0x159
Aug 24 15:07:07 gamba kernel: [  253.032939]  [<c0146056>] mark_lock+0x28c/0x4a9
Aug 24 15:07:07 gamba kernel: [  253.032943]  [<c014720b>] ? check_usage_backwards+0x0/0x7f
Aug 24 15:07:07 gamba kernel: [  253.032948]  [<c01487ed>] __lock_acquire+0x51e/0x713
Aug 24 15:07:07 gamba kernel: [  253.032953]  [<c01462b6>] ? mark_held_locks+0x43/0x5b
Aug 24 15:07:07 gamba kernel: [  253.032957]  [<c0148a72>] lock_acquire+0x90/0xad
Aug 24 15:07:07 gamba kernel: [  253.032963]  [<f9b4d084>] ? sco_chan_del+0x22/0xb3 [sco]
Aug 24 15:07:07 gamba kernel: [  253.032968]  [<c031c2d7>] _spin_lock+0x1b/0x2a
Aug 24 15:07:07 gamba kernel: [  253.032973]  [<f9b4d084>] ? sco_chan_del+0x22/0xb3 [sco]
Aug 24 15:07:07 gamba kernel: [  253.032979]  [<f9b4d084>] sco_chan_del+0x22/0xb3 [sco]
Aug 24 15:07:07 gamba kernel: [  253.032985]  [<f9b4d6a0>] sco_sock_close+0x60/0x7c [sco]
Aug 24 15:07:07 gamba kernel: [  253.032991]  [<f9b4d6d2>] sco_sock_release+0x16/0x8e [sco]
Aug 24 15:07:07 gamba kernel: [  253.032995]  [<c02a1677>] sock_release+0x14/0x59
Aug 24 15:07:07 gamba kernel: [  253.032999]  [<c02a1aa9>] sock_close+0x1c/0x20
Aug 24 15:07:07 gamba kernel: [  253.033010]  [<c018e982>] __fput+0xe9/0x18d
Aug 24 15:07:07 gamba kernel: [  253.033015]  [<c018ecd4>] fput+0x17/0x19
Aug 24 15:07:07 gamba kernel: [  253.033019]  [<c018c4be>] filp_close+0x51/0x5b
Aug 24 15:07:07 gamba kernel: [  253.033024]  [<c018c530>] sys_close+0x68/0xa1
Aug 24 15:07:07 gamba kernel: [  253.033029]  [<c01028d8>] sysenter_do_call+0x12/0x36
Aug 24 15:07:07 gamba kernel: [  253.075323] mplayer used greatest stack depth: 5296 bytes left
Aug 24 15:07:07 gamba kernel: [  253.649979] uhci_hcd 0000:00:1a.0: release dev 2 ep83-ISO, period 1, phase 0, 22 us
Aug 24 15:07:08 gamba kernel: [  253.652063] uhci_hcd 0000:00:1a.0: shutdown urb ed833400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652071] uhci_hcd 0000:00:1a.0: shutdown urb c18bb400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652079] uhci_hcd 0000:00:1a.0: shutdown urb ee375c00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652087] uhci_hcd 0000:00:1a.0: shutdown urb ee065400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652093] uhci_hcd 0000:00:1a.0: shutdown urb ee35fc00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652102] uhci_hcd 0000:00:1a.0: shutdown urb ed817200 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652109] uhci_hcd 0000:00:1a.0: shutdown urb ed8a2e00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652115] uhci_hcd 0000:00:1a.0: shutdown urb ee3d1400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652123] uhci_hcd 0000:00:1a.0: shutdown urb eef70000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652129] uhci_hcd 0000:00:1a.0: shutdown urb ee3d2e00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652135] uhci_hcd 0000:00:1a.0: shutdown urb ed828400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652144] uhci_hcd 0000:00:1a.0: shutdown urb ed8b2c00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652152] uhci_hcd 0000:00:1a.0: shutdown urb ed821c00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652160] uhci_hcd 0000:00:1a.0: shutdown urb ed831800 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652166] uhci_hcd 0000:00:1a.0: shutdown urb ed897a00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652174] uhci_hcd 0000:00:1a.0: shutdown urb ed8b9c00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652182] uhci_hcd 0000:00:1a.0: shutdown urb ed89b800 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652190] uhci_hcd 0000:00:1a.0: shutdown urb ed89bc00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652196] uhci_hcd 0000:00:1a.0: shutdown urb ed817600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652204] uhci_hcd 0000:00:1a.0: shutdown urb ed895000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652212] uhci_hcd 0000:00:1a.0: shutdown urb c1ea6800 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652218] uhci_hcd 0000:00:1a.0: shutdown urb c1802400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652226] uhci_hcd 0000:00:1a.0: shutdown urb ed83f800 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652233] uhci_hcd 0000:00:1a.0: shutdown urb ed852400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652239] uhci_hcd 0000:00:1a.0: shutdown urb ed823a00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652247] uhci_hcd 0000:00:1a.0: shutdown urb ed828200 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652253] uhci_hcd 0000:00:1a.0: shutdown urb ee3d3c00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652259] uhci_hcd 0000:00:1a.0: shutdown urb ed80ce00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652268] uhci_hcd 0000:00:1a.0: shutdown urb c1fae600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652276] uhci_hcd 0000:00:1a.0: shutdown urb ed8cb600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652282] uhci_hcd 0000:00:1a.0: shutdown urb ed847c00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652288] uhci_hcd 0000:00:1a.0: shutdown urb ed821a00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652297] uhci_hcd 0000:00:1a.0: shutdown urb ed826600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652305] uhci_hcd 0000:00:1a.0: shutdown urb ed8b7000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652314] uhci_hcd 0000:00:1a.0: shutdown urb ed8b7c00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652320] uhci_hcd 0000:00:1a.0: shutdown urb ee362e00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652328] uhci_hcd 0000:00:1a.0: shutdown urb ee362a00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652336] uhci_hcd 0000:00:1a.0: shutdown urb ed8afe00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652345] uhci_hcd 0000:00:1a.0: shutdown urb ee379000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652354] uhci_hcd 0000:00:1a.0: shutdown urb ed816e00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652360] uhci_hcd 0000:00:1a.0: shutdown urb ee3cd400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652369] uhci_hcd 0000:00:1a.0: shutdown urb eead4400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652378] uhci_hcd 0000:00:1a.0: shutdown urb ed81b600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652387] uhci_hcd 0000:00:1a.0: shutdown urb ee2e5000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652396] uhci_hcd 0000:00:1a.0: shutdown urb ed80fc00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652405] uhci_hcd 0000:00:1a.0: shutdown urb ee2da600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652413] uhci_hcd 0000:00:1a.0: shutdown urb ed8b2600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652420] uhci_hcd 0000:00:1a.0: shutdown urb ed808200 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652430] uhci_hcd 0000:00:1a.0: shutdown urb ed8b5200 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652440] uhci_hcd 0000:00:1a.0: shutdown urb f713d800 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652450] uhci_hcd 0000:00:1a.0: shutdown urb ed822400 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652461] uhci_hcd 0000:00:1a.0: shutdown urb ed8a9800 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652471] uhci_hcd 0000:00:1a.0: shutdown urb ed83a000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652481] uhci_hcd 0000:00:1a.0: shutdown urb ed843e00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652491] uhci_hcd 0000:00:1a.0: shutdown urb ed817000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652502] uhci_hcd 0000:00:1a.0: shutdown urb ed897000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652512] uhci_hcd 0000:00:1a.0: shutdown urb f713d600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652523] uhci_hcd 0000:00:1a.0: shutdown urb ee065e00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652535] uhci_hcd 0000:00:1a.0: shutdown urb ed80c200 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652546] uhci_hcd 0000:00:1a.0: shutdown urb ed8a8200 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652558] uhci_hcd 0000:00:1a.0: shutdown urb ed8a8c00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652567] uhci_hcd 0000:00:1a.0: shutdown urb ed87f600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652579] uhci_hcd 0000:00:1a.0: shutdown urb ed8aba00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652591] uhci_hcd 0000:00:1a.0: shutdown urb ed8caa00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652602] uhci_hcd 0000:00:1a.0: shutdown urb ed858c00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652614] uhci_hcd 0000:00:1a.0: shutdown urb ed8cd200 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652625] uhci_hcd 0000:00:1a.0: shutdown urb ed8c7600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652636] uhci_hcd 0000:00:1a.0: shutdown urb ed8cd000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652648] uhci_hcd 0000:00:1a.0: shutdown urb ed80fe00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652660] uhci_hcd 0000:00:1a.0: shutdown urb ed880000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652671] uhci_hcd 0000:00:1a.0: shutdown urb ed838a00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652683] uhci_hcd 0000:00:1a.0: shutdown urb ed806e00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652695] uhci_hcd 0000:00:1a.0: shutdown urb ed89cc00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652707] uhci_hcd 0000:00:1a.0: shutdown urb ed8ad600 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652719] uhci_hcd 0000:00:1a.0: shutdown urb ed855000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652731] uhci_hcd 0000:00:1a.0: shutdown urb ed80a200 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652742] uhci_hcd 0000:00:1a.0: shutdown urb f713de00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652755] uhci_hcd 0000:00:1a.0: shutdown urb ee3d2800 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652768] uhci_hcd 0000:00:1a.0: shutdown urb ed853a00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652780] uhci_hcd 0000:00:1a.0: shutdown urb ed891800 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652796] uhci_hcd 0000:00:1a.0: shutdown urb ed893000 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.652809] uhci_hcd 0000:00:1a.0: shutdown urb ed80ca00 ep3out-iso
Aug 24 15:07:08 gamba kernel: [  253.653205] uhci_hcd 0000:00:1a.0: release dev 2 ep03-ISO, period 1, phase 0, 21 us

--W/nzBZO5zC0uMSeA--

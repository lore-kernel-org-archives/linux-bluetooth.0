Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <462E02FB.8000600@vasmac.com>
Date: Tue, 24 Apr 2007 07:15:39 -0600
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <fc27e74b0704240413v5b6e2e80h7b2feb40d27de686@mail.gmail.com>
In-Reply-To: <fc27e74b0704240413v5b6e2e80h7b2feb40d27de686@mail.gmail.com>
Subject: Re: [Bluez-devel] [PATCH]Dynamic Alternate Setting patch (hci_usb.c)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Alok,

This is a good start. There are a few other things to consider:

* Are there error conditions in hci_usb_tx_complete that need to be handled?
* How do you make sure data for different channels is interleaved?

Jose

list subscribe wrote:
> Hi,
>
> As per the discussion on #bluez channel , I am attaching a patch which 
> dynamically manages the the alternate settings for SCO channels.
> The patch includes the following :
>
> 1. It declares a work queue(config_work), which is scheduled when
>              1. There is a change in number of SCO channels OR
>              2. There is a change in the Voice setting.
>
> 2. On invocation it determines the alternate setting based on the 
> table given in HCI - usb spec docs. The  table is also mentioned  in 
> the patch.
>
> 3. It then empties all the queued isochronous URBs , except those 
> which are already submitted.
>
> 4. It then sets the alternate setting by calling   usb_set_interface().
>
> I have tested this patch using "scotest".
> I am using 2.6.21-rc7 with sco-flowcontrol-v4.2.diff patch.
>
> Let me know if  any changes are necessary.
> Any suggestions are welcome.
>
>
>
> Alok. 
>
>
> --- hci_usb.c.orig    2007-04-16 19:37:41.000000000 +0530
> +++ hci_usb.c    2007-04-24 01:41:31.000000000 +0530
> @@ -47,6 +47,8 @@
>  
>  #include <linux/usb.h>
>  
> +#include <linux/workqueue.h>
> +
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  
> @@ -57,6 +59,21 @@
>  #define BT_DBG(D...)
>  #endif
>  
> +/* The number of SCO channels  */
> +int NoSco=0;
> +/* The  Voice setting  */
> +__u16 VocSetting=0;
> +/* if bit=0,its 8bit encoding else its 16bit */
> +__u16 bit = 0x20;
> +
> +struct hci_usb *hUSB;
> +struct usb_device *usbdevice;
> +struct usb_interface *isocIface;
> +/* The Workque Function */
> +static void set_alternate_config(struct work_struct *work);
> +static DECLARE_WORK(config_work, set_alternate_config);
> +
> +
>  #ifndef CONFIG_BT_HCIUSB_ZERO_PACKET
>  #undef  URB_ZERO_PACKET
>  #define URB_ZERO_PACKET 0
> @@ -840,6 +857,10 @@
>  static void hci_usb_notify(struct hci_dev *hdev, unsigned int evt)
>  {
>      BT_DBG("%s evt %d", hdev->name, evt);
> +    NoSco = hdev->conn_hash.sco_num;
> +    VocSetting = hdev->voice_setting;
> +    hUSB = (struct hci_usb *) hdev->driver_data;
> +    schedule_work(&config_work);
>  }
>  
>  static int hci_usb_probe(struct usb_interface *intf, const struct 
> usb_device_id *id)
> @@ -854,7 +875,7 @@
>      struct hci_usb *husb;
>      struct hci_dev *hdev;
>      int i, e, size, isoc_ifnum, isoc_alts;
> -
> +    usbdevice = interface_to_usbdev(intf);
>      BT_DBG("udev %p intf %p", udev, intf);
>  
>      if (!id->driver_info) {
> @@ -926,9 +947,11 @@
>      isoc_ifnum = 1;
>  
>  #ifdef CONFIG_BT_HCIUSB_SCO
> -    if (isoc && !(id->driver_info & (HCI_BROKEN_ISOC | HCI_SNIFFER)))
> +    if (isoc && !(id->driver_info & (HCI_BROKEN_ISOC | HCI_SNIFFER))){
>          isoc_iface = usb_ifnum_to_if(udev, isoc_ifnum);
> -
> +            isocIface = usb_ifnum_to_if(udev, isoc_ifnum);
> +    }
> +   
>      if (isoc_iface) {
>          int a;
>          struct usb_host_endpoint *isoc_out_ep = NULL;
> @@ -1142,6 +1165,121 @@
>      return 0;
>  }
>  
> +
> +/*Set the alternate setting based on the number of SCO channels and the
> +  voice setting.This function is invoked when there is a change in 
> Number of
> +  SCO channels or when the voice encoding changes.*/
> +static void set_alternate_config(struct work_struct *work)
> +{
> +    int isocIfnum=1, isocAlt=0;
> +    struct usb_host_endpoint  *ep;
> +    struct usb_host_interface *uif;
> +    struct _urb *_urb,*_tmp;
> +    struct _urb_queue *q = &hUSB->pending_q[isoc];
> +    unsigned long flags;
> +    atomic_t temp;/*Holds the number of URBs we need to skip(which 
> are submitted)*/
> +    struct list_head inprocess;/*This list holds the already 
> submitted URBs */
> +   
> +    /*Change the alternate setting only if the number of SCO channels 
> are more than 1 */
> +    if(NoSco > 0){
> +        /* The alternate setting selection is based on the following 
> table */
> +        /*   No. of SCO channels    Bit-Encoding    Alternate 
> Setting   Max. Packet Size */
> +        /*           1                 8bit                 
> 1                  9 */
> +        /*           1                16bit                 
> 2                 17 */
> +        /*           2                 8bit                 
> 2                 17 */
> +        /*           2                16bit                 
> 4                 33 */
> +        /*           3                 8bit                 
> 3                 25 */
> +        /*           3                16bit                 
> 5                 49 */
> +        switch(NoSco)
> +        {
> +        case 1:
> +            if(VocSetting && bit)
> +                isocAlt=2;
> +            else
> +                isocAlt=1;
> +            break;
> +        case 2:
> +            if(VocSetting && bit)
> +                isocAlt=4;
> +            else
> +                isocAlt=2;
> +            break;
> +        case 3:
> +            if(VocSetting && bit)
> +                isocAlt=5;
> +            else
> +                isocAlt=3;
> +            break;
> +        }
> +
> +        /*Stop Current TX */
> +        clear_bit(HCI_USB_TX_WAKEUP, &hUSB->state);
> +        INIT_LIST_HEAD(&inprocess);
> +        temp = hUSB->pending_tx[isoc];
> +        /*  We cannot purge URBs which have been submitted. inprocess 
> is a */
> +        /*  temporary list which holds the currently submitted URBs. */
> +        /*  This list is later merged with the emptyed pending queue.  */
> +  
> +        while ((_urb = _urb_dequeue(q))) {
> +            /*Dequeue all the submitted URBs and put them in the 
> temporary list*/ 
> +            if(!atomic_dec_and_test(&temp)){
> +                _urb->queue = q;
> +                list_add(&_urb->list, &inprocess);
> +            }
> +            else{
> +                /*Unlink all the rest of URBs and put them into the 
> completed queue.*/
> +                _urb_unlink(_urb);
> +                _urb_queue_tail(__completed_q(hUSB,HCI_SCODATA_PKT), 
> _urb);
> +            }
> +        }
> +        /*merge the inprocess queue with the pending queue*/
> +        spin_lock_irqsave(&q->lock, flags);
> +        list_for_each_entry_safe(_urb, _tmp, &inprocess, list) {
> +            list_move_tail(&_urb->list, &q->head);
> +        }
> +        spin_unlock_irqrestore(&q->lock, flags);
> +   
> +        /* Set the setting and the in/out endpoints */
> +        if (isocIface) {
> +            int e;
> +            struct usb_host_endpoint *out = NULL;
> +            struct usb_host_endpoint *in = NULL;
> +            uif = &isocIface->altsetting[isocAlt];
> +            for (e = 0; e < uif->desc.bNumEndpoints; e++) {
> +                ep = &uif->endpoint[e];
> +                switch (ep->desc.bmAttributes & 
> USB_ENDPOINT_XFERTYPE_MASK) {
> +                case USB_ENDPOINT_XFER_ISOC:
> +                    if (ep->desc.bEndpointAddress & USB_DIR_IN)
> +                        in  = ep;
> +                    else
> +                        out = ep;
> +                    break;
> +                }
> +            }
> +       
> +            if (!in || !out)
> +                BT_DBG("Isoc endpoints not found");
> +            else {
> +                BT_DBG("isoc ifnum %d alts %d", isocIfnum, isocAlt);
> +                if (usb_set_interface(usbdevice, isocIfnum, isocAlt)) {
> +                    BT_ERR("Can't set isoc interface settings");
> +                    hUSB->isoc_iface = isocIface;
> +                    usb_driver_release_interface(&hci_usb_driver, 
> isocIface);
> +                    hUSB->isoc_iface = NULL;
> +                } else {
> +                    hUSB->isoc_iface  = isocIface;
> +                    hUSB->isoc_in_ep  = in;
> +                    hUSB->isoc_out_ep  = out;
> +                }
> +            }
> +        }
> +        set_bit(HCI_USB_TX_WAKEUP, &hUSB->state);
> +    }
> +
> +}
> + 
> +
> +
>  static struct usb_driver hci_usb_driver = {
>      .name        = "hci_usb",
>      .probe        = hci_usb_probe,
> ------------------------------------------------------------------------

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

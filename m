Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: BCM43341B0  Frame reassembly failed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1521668904.13274.10.camel@deako.com>
Date: Thu, 22 Mar 2018 06:21:42 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <81374C63-9B4D-4CDE-922B-95F15C10CB97@holtmann.org>
References: <1521668904.13274.10.camel@deako.com>
To: Brennan Ashton <brn@deako.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brennan,

> I recently brought an Intel Edison board with a BCM43341B0 chip up from
> 4.9 to 4.16.0-rc6 but I am having reliability issues when using
> btattach instead of the previous brcm_patchram_plus utility to attach
> the device.
> 
> 
> The hci communication with the bluetooth chip gets corrupted almost
> always when creating a GATT connection.  Thowing "Bluetooth: hci0:
> Frame reassembly failed (-84)" and then requiring the device to be
> reset to communicate again.
> 
> Kernel logs interleaved with attaching the device:
> # /usr/bin/btattach --bredr /dev/ttyS0 -P bcm -S 3000000 &
> # Attaching Primary controller to /dev/ttyS0
> [   53.148206] Bluetooth: HCI UART driver ver 2.3
> [   53.152758] Bluetooth: HCI UART protocol H4 registered
> [   53.157970] Bluetooth: HCI UART protocol Three-wire (H5) registered
> [   53.164512] hci_bcm hci_bcm: hci_bcm device registered.
> [   53.170445] Bluetooth: HCI UART protocol Broadcom registered
> Switched line discipline from 0 to 15
> Device index 0 attached
> [   53.333220] Bluetooth: hci0: BCM: chip id 82
> [   53.340184] Bluetooth: hci0: BCM: features 0x2f
> [   53.368421] Bluetooth: hci0: BCM43341B0
> [   53.372338] Bluetooth: hci0: BCM43341B0 (002.001.014) build 0000
> [   57.843684] Bluetooth: hci0: BCM (002.001.014) build 0166

if you have a chance, I like to see the complete binary btmon -w trace.log.

However I think we need to figure out what is causing the -EILSEQ error in the h4_recv_buf() in hci_h4.c. There are more than one in it and you have to do some printk debugging to figure out which one it is.

So if you do something like this, then we might be able to debug what is going on in the H:4 stream.

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index fb97a3bf069b..ba9b293f4948 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -201,8 +201,13 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
                        }
 
                        /* Check for invalid packet type */
-                       if (!skb)
+                       if (!skb) {
+                               printk(KERN_INFO "H4: Invalid packet type\n");
+                               print_hex_dump(KERN_INFO, "  ",
+                                              DUMP_PREFIX_OFFSET, 16, 1,
+                                              buffer, count, true);
                                return ERR_PTR(-EILSEQ);
+                       }
 
                        count -= 1;
                        buffer += 1;
@@ -224,6 +229,9 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
                }
 
                if (i >= pkts_count) {
+                       printk(KERN_INFO "H4: Corrupted packet type\n");
+                       print_hex_dump(KERN_INFO, "  ", DUMP_PREFIX_OFFSET,
+                                      16, 1, skb->data, skb->len, true);
                        kfree_skb(skb);
                        return ERR_PTR(-EILSEQ);
                }
@@ -259,6 +267,10 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
                                break;
                        default:
                                /* Unsupported variable length */
+                               printk(KERN_INFO "H4: Invalid variable len\n");
+                               print_hex_dump(KERN_INFO, "  ",
+                                              DUMP_PREFIX_OFFSET, 16, 1,
+                                              skb->data, skb->len, true);
                                kfree_skb(skb);
                                return ERR_PTR(-EILSEQ);
                        }

If the H:4 stream fails for whatever reason, then that is pretty bad since there is no recovery.

In addition there are at least two fixes in net stable tree meant for 4.16 that might be affecting you as well.

commit e07c99b07ae85255d5c5bc2480fbd4c4e77f71bc
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Wed Mar 14 23:06:03 2018 +0100

    Bluetooth: hci_bcm: Set pulsed_host_wake flag in sleep parameters

commit b09c61522c81886c34966825f9e5afcbfafac446
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Wed Mar 14 23:06:02 2018 +0100

    Revert "Bluetooth: hci_bcm: Streamline runtime PM code"

You could cherry-pick these two and see if they make a difference.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: BCM43341B0  Frame reassembly failed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1521759228.7136.6.camel@deako.com>
Date: Fri, 23 Mar 2018 00:06:59 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <D4216F60-512D-4F87-9820-7178A2742140@holtmann.org>
References: <1521668904.13274.10.camel@deako.com>
 <81374C63-9B4D-4CDE-922B-95F15C10CB97@holtmann.org>
 <1521759228.7136.6.camel@deako.com>
To: Brennan Ashton <brn@deako.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brennan,

>>> I recently brought an Intel Edison board with a BCM43341B0 chip up
>>> from
>>> 4.9 to 4.16.0-rc6 but I am having reliability issues when using
>>> btattach instead of the previous brcm_patchram_plus utility to
>>> attach
>>> the device.
>>> 
>>> 
>>> The hci communication with the bluetooth chip gets corrupted almost
>>> always when creating a GATT connection.  Thowing "Bluetooth: hci0:
>>> Frame reassembly failed (-84)" and then requiring the device to be
>>> reset to communicate again.
>>> 
>>> Kernel logs interleaved with attaching the device:
>>> # /usr/bin/btattach --bredr /dev/ttyS0 -P bcm -S 3000000 &
>>> # Attaching Primary controller to /dev/ttyS0
>>> [   53.148206] Bluetooth: HCI UART driver ver 2.3
>>> [   53.152758] Bluetooth: HCI UART protocol H4 registered
>>> [   53.157970] Bluetooth: HCI UART protocol Three-wire (H5)
>>> registered
>>> [   53.164512] hci_bcm hci_bcm: hci_bcm device registered.
>>> [   53.170445] Bluetooth: HCI UART protocol Broadcom registered
>>> Switched line discipline from 0 to 15
>>> Device index 0 attached
>>> [   53.333220] Bluetooth: hci0: BCM: chip id 82
>>> [   53.340184] Bluetooth: hci0: BCM: features 0x2f
>>> [   53.368421] Bluetooth: hci0: BCM43341B0
>>> [   53.372338] Bluetooth: hci0: BCM43341B0 (002.001.014) build 0000
>>> [   57.843684] Bluetooth: hci0: BCM (002.001.014) build 0166
>> 
>> if you have a chance, I like to see the complete binary btmon -w
>> trace.log.
> 
> I have attached two traces starting the monitoring and then attaching
> the bluetooth device, first with btattach and second with the patchram.
> 
> btattach-trace.log  patchram-trace.log
> 
> The with btattach you can see the failure on connect, with patchram the
> full connection is successful as is the disconnect.
> 
>> 
>> However I think we need to figure out what is causing the -EILSEQ
>> error in the h4_recv_buf() in hci_h4.c. There are more than one in it
>> and you have to do some printk debugging to figure out which one it
>> is.
>> 
>> So if you do something like this, then we might be able to debug what
>> is going on in the H:4 stream.
>> 
>> diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
>> index fb97a3bf069b..ba9b293f4948 100644
>> --- a/drivers/bluetooth/hci_h4.c
>> +++ b/drivers/bluetooth/hci_h4.c
>> @@ -201,8 +201,13 @@ struct sk_buff *h4_recv_buf(struct hci_dev
>> *hdev, struct sk_buff *skb,
>>                        }
>> 
>>                        /* Check for invalid packet type */
>> -                       if (!skb)
>> +                       if (!skb) {
>> +                               printk(KERN_INFO "H4: Invalid packet
>> type\n");
>> +                               print_hex_dump(KERN_INFO, "  ",
>> +                                              DUMP_PREFIX_OFFSET,
>> 16, 1,
>> +                                              buffer, count, true);
>>                                return ERR_PTR(-EILSEQ);
>> +                       }
>> 
>>                        count -= 1;
>>                        buffer += 1;
>> @@ -224,6 +229,9 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
>> struct sk_buff *skb,
>>                }
>> 
>>                if (i >= pkts_count) {
>> +                       printk(KERN_INFO "H4: Corrupted packet
>> type\n");
>> +                       print_hex_dump(KERN_INFO, "  ",
>> DUMP_PREFIX_OFFSET,
>> +                                      16, 1, skb->data, skb->len,
>> true);
>>                        kfree_skb(skb);
>>                        return ERR_PTR(-EILSEQ);
>>                }
>> @@ -259,6 +267,10 @@ struct sk_buff *h4_recv_buf(struct hci_dev
>> *hdev, struct sk_buff *skb,
>>                                break;
>>                        default:
>>                                /* Unsupported variable length */
>> +                               printk(KERN_INFO "H4: Invalid
>> variable len\n");
>> +                               print_hex_dump(KERN_INFO, "  ",
>> +                                              DUMP_PREFIX_OFFSET,
>> 16, 1,
>> +                                              skb->data, skb->len,
>> true);
>>                                kfree_skb(skb);
>>                                return ERR_PTR(-EILSEQ);
>>                        }
>> 
>> If the H:4 stream fails for whatever reason, then that is pretty bad
>> since there is no recovery.
> 
> 
> Here are the results with the printk patch:
> Kernel (btattach)
> 
> [   73.192554] Bluetooth: HCI UART driver ver 2.3
> [   73.197063] Bluetooth: HCI UART protocol H4 registered
> [   73.202268] Bluetooth: HCI UART protocol Three-wire (H5) registered
> [   73.208744] hci_bcm hci_bcm: hci_bcm device registered.
> [   73.214382] Bluetooth: HCI UART protocol Broadcom registered
> [   73.393060] Bluetooth: hci0: BCM: chip id 82
> [   73.398965] Bluetooth: hci0: BCM: features 0x2f
> [   73.624991] Bluetooth: hci0: BCM43341B0
> [   73.747834] Bluetooth: hci0: BCM43341B0 (002.001.014) build 0000
> [   74.317254] random: crng init done
> [   78.234907] Bluetooth: hci0: BCM (002.001.014) build 0166
> [  124.797242] H4: Invalid packet type
> [  124.800808]   00000000: 90 9a 01 00 40 00 01 01 3e 54 00 18 45 69 24
> 00  ....@...>T..Ei$.
> [  124.809049]   00000010: 00 00 f4 01
> 00                                   .....
> [  124.816332] Bluetooth: hci0: Frame reassembly failed (-84)

so here is the problem, we detect a 0x90 packet type in the stream. If we detect that, we would need to re-synchronize to a H:4 valid packet type. Can you compare timestamps and see what the packet before and after of this is. btmon and dmesg can print absolute timestamps.

Regards

Marcel


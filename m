Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: BCM43341B0  Frame reassembly failed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1521762522.7136.11.camel@deako.com>
Date: Fri, 23 Mar 2018 09:15:24 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <C43496BC-05A7-4502-83A8-535782578878@holtmann.org>
References: <1521668904.13274.10.camel@deako.com>
 <81374C63-9B4D-4CDE-922B-95F15C10CB97@holtmann.org>
 <1521759228.7136.6.camel@deako.com>
 <D4216F60-512D-4F87-9820-7178A2742140@holtmann.org>
 <1521762522.7136.11.camel@deako.com>
To: Brennan Ashton <brn@deako.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brennan,

>>>>> I recently brought an Intel Edison board with a BCM43341B0 chip
>>>>> up
>>>>> from
>>>>> 4.9 to 4.16.0-rc6 but I am having reliability issues when using
>>>>> btattach instead of the previous brcm_patchram_plus utility to
>>>>> attach
>>>>> the device.
>>>>> 
>>>>> 
>>>>> The hci communication with the bluetooth chip gets corrupted
>>>>> almost
>>>>> always when creating a GATT connection.  Thowing "Bluetooth:
>>>>> hci0:
>>>>> Frame reassembly failed (-84)" and then requiring the device to
>>>>> be
>>>>> reset to communicate again.
>>>>> 
>>>>> Kernel logs interleaved with attaching the device:
>>>>> # /usr/bin/btattach --bredr /dev/ttyS0 -P bcm -S 3000000 &
>>>>> # Attaching Primary controller to /dev/ttyS0
>>>>> [   53.148206] Bluetooth: HCI UART driver ver 2.3
>>>>> [   53.152758] Bluetooth: HCI UART protocol H4 registered
>>>>> [   53.157970] Bluetooth: HCI UART protocol Three-wire (H5)
>>>>> registered
>>>>> [   53.164512] hci_bcm hci_bcm: hci_bcm device registered.
>>>>> [   53.170445] Bluetooth: HCI UART protocol Broadcom registered
>>>>> Switched line discipline from 0 to 15
>>>>> Device index 0 attached
>>>>> [   53.333220] Bluetooth: hci0: BCM: chip id 82
>>>>> [   53.340184] Bluetooth: hci0: BCM: features 0x2f
>>>>> [   53.368421] Bluetooth: hci0: BCM43341B0
>>>>> [   53.372338] Bluetooth: hci0: BCM43341B0 (002.001.014) build
>>>>> 0000
>>>>> [   57.843684] Bluetooth: hci0: BCM (002.001.014) build 0166
>>>> 
>>>> if you have a chance, I like to see the complete binary btmon -w
>>>> trace.log.
>>> 
>>> I have attached two traces starting the monitoring and then
>>> attaching
>>> the bluetooth device, first with btattach and second with the
>>> patchram.
>>> 
>>> btattach-trace.log  patchram-trace.log
>>> 
>>> The with btattach you can see the failure on connect, with patchram
>>> the
>>> full connection is successful as is the disconnect.
>>> 
>>>> 
>>>> However I think we need to figure out what is causing the -EILSEQ
>>>> error in the h4_recv_buf() in hci_h4.c. There are more than one
>>>> in it
>>>> and you have to do some printk debugging to figure out which one
>>>> it
>>>> is.
>>>> 
>>>> So if you do something like this, then we might be able to debug
>>>> what
>>>> is going on in the H:4 stream.
>>>> 
>>>> diff --git a/drivers/bluetooth/hci_h4.c
>>>> b/drivers/bluetooth/hci_h4.c
>>>> index fb97a3bf069b..ba9b293f4948 100644
>>>> --- a/drivers/bluetooth/hci_h4.c
>>>> +++ b/drivers/bluetooth/hci_h4.c
>>>> @@ -201,8 +201,13 @@ struct sk_buff *h4_recv_buf(struct hci_dev
>>>> *hdev, struct sk_buff *skb,
>>>>                       }
>>>> 
>>>>                       /* Check for invalid packet type */
>>>> -                       if (!skb)
>>>> +                       if (!skb) {
>>>> +                               printk(KERN_INFO "H4: Invalid
>>>> packet
>>>> type\n");
>>>> +                               print_hex_dump(KERN_INFO, "  ",
>>>> +                                              DUMP_PREFIX_OFFSET
>>>> ,
>>>> 16, 1,
>>>> +                                              buffer, count,
>>>> true);
>>>>                               return ERR_PTR(-EILSEQ);
>>>> +                       }
>>>> 
>>>>                       count -= 1;
>>>>                       buffer += 1;
>>>> @@ -224,6 +229,9 @@ struct sk_buff *h4_recv_buf(struct hci_dev
>>>> *hdev,
>>>> struct sk_buff *skb,
>>>>               }
>>>> 
>>>>               if (i >= pkts_count) {
>>>> +                       printk(KERN_INFO "H4: Corrupted packet
>>>> type\n");
>>>> +                       print_hex_dump(KERN_INFO, "  ",
>>>> DUMP_PREFIX_OFFSET,
>>>> +                                      16, 1, skb->data, skb-
>>>>> len,
>>>> true);
>>>>                       kfree_skb(skb);
>>>>                       return ERR_PTR(-EILSEQ);
>>>>               }
>>>> @@ -259,6 +267,10 @@ struct sk_buff *h4_recv_buf(struct hci_dev
>>>> *hdev, struct sk_buff *skb,
>>>>                               break;
>>>>                       default:
>>>>                               /* Unsupported variable length */
>>>> +                               printk(KERN_INFO "H4: Invalid
>>>> variable len\n");
>>>> +                               print_hex_dump(KERN_INFO, "  ",
>>>> +                                              DUMP_PREFIX_OFFSET
>>>> ,
>>>> 16, 1,
>>>> +                                              skb->data, skb-
>>>>> len,
>>>> true);
>>>>                               kfree_skb(skb);
>>>>                               return ERR_PTR(-EILSEQ);
>>>>                       }
>>>> 
>>>> If the H:4 stream fails for whatever reason, then that is pretty
>>>> bad
>>>> since there is no recovery.
>>> 
>>> 
>>> Here are the results with the printk patch:
>>> Kernel (btattach)
>>> 
>>> [   73.192554] Bluetooth: HCI UART driver ver 2.3
>>> [   73.197063] Bluetooth: HCI UART protocol H4 registered
>>> [   73.202268] Bluetooth: HCI UART protocol Three-wire (H5)
>>> registered
>>> [   73.208744] hci_bcm hci_bcm: hci_bcm device registered.
>>> [   73.214382] Bluetooth: HCI UART protocol Broadcom registered
>>> [   73.393060] Bluetooth: hci0: BCM: chip id 82
>>> [   73.398965] Bluetooth: hci0: BCM: features 0x2f
>>> [   73.624991] Bluetooth: hci0: BCM43341B0
>>> [   73.747834] Bluetooth: hci0: BCM43341B0 (002.001.014) build 0000
>>> [   74.317254] random: crng init done
>>> [   78.234907] Bluetooth: hci0: BCM (002.001.014) build 0166
>>> [  124.797242] H4: Invalid packet type
>>> [  124.800808]   00000000: 90 9a 01 00 40 00 01 01 3e 54 00 18 45
>>> 69 24
>>> 00  ....@...>T..Ei$.
>>> [  124.809049]   00000010: 00 00 f4 01
>>> 00                                   .....
>>> [  124.816332] Bluetooth: hci0: Frame reassembly failed (-84)
>> 
>> so here is the problem, we detect a 0x90 packet type in the stream.
>> If we detect that, we would need to re-synchronize to a H:4 valid
>> packet type. Can you compare timestamps and see what the packet
>> before and after of this is. btmon and dmesg can print absolute
>> timestamps.
>> 
> 
> I am worried we are going to far away looking at this, since attaching
> to the device differently seems to be triggering this. Maybe the serial
> interface is being configured differently here:
> https://github.com/01org/edison-firmware/blob/master/broadcom_cws/bluet
> ooth/firmware/brcm_patchram_plus.c
> 
> 
> 
> I think this is what you are asking for though.  I aligned the time-
> stamps of the kernel and btmon messages:
> 
> 
> < HCI Command: LE Set Adve.. (0x08|0x0006) plen 15  #312 [hci0]
> 23:35:24.170102
>        Min advertising interval: 1280.000 msec (0x0800)
>        Max advertising interval: 1280.000 msec (0x0800)
>        Type: Connectable undirected - ADV_IND (0x00)
>        Own address type: Public (0x00)
>        Direct address type: Public (0x00)
>        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>        Channel map: 37, 38, 39 (0x07)
>        Filter policy: Allow Scan Request from Any, Allow Connect
> Request from Any (0x00)
>> HCI Event: Command Complete (0x0e) plen 4         #313 [hci0]
> 23:35:24.173680
>      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Set Adver.. (0x08|0x000a) plen 1  #314 [hci0]
> 23:35:24.173990
>        Advertising: Enabled (0x01)
>> HCI Event: Command Complete (0x0e) plen 4         #315 [hci0]
> 23:35:24.176283
>      LE Set Advertise Enable (0x08|0x000a) ncmd 1
>        Status: Success (0x00)
> @ Control Event: 0xffff                         {0x0003} [hci0]
> 23:35:24.176434
>        01 00 3e 00 00 01            
> 
> 
> 2018-03-22T23:35:34,770131+0000 H4: Invalid packet type
> 2018-03-22T23:35:34,773701+0000   00000000: 90 9a 01 00 40 00 01 01 0e
> e7 86 49 6f 4d 24 00  ....@......IoM$.
> 2018-03-22T23:35:34,781939+0000   00000010: 00 00 f4 01
> 00                                   .....
> 2018-03-22T23:35:34,789248+0000 Bluetooth: hci0: Frame reassembly
> failed (-84)
> 2018-03-22T23:35:35,025555+0000 Bluetooth: hci0: ACL packet for unknown
> connection handle 64

so this packet is your LE Connection Complete event, but it is for some reason garbled up.

struct bt_hci_evt_hdr {                                                          
        uint8_t  evt;                               = 0x90
        uint8_t  plen;                              = 0x9a
} __attribute__ ((packed));

#define BT_HCI_EVT_LE_CONN_COMPLETE                 = 0x01
struct bt_hci_evt_le_conn_complete {
        uint8_t  status;                            = 0x00
        uint16_t handle;                            = 0x40 0x00
        uint8_t  role;                              = 0x01
        uint8_t  peer_addr_type;                    = 0x01
        uint8_t  peer_addr[6];                      = 0x0e 0xe7 0x86 0x49 0x6f 0x4d
        uint16_t interval;                          = 0x24 0x00
        uint16_t latency;                           = 0x00 0x00
        uint16_t supv_timeout;                      = 0xf4 0x01
        uint8_t  clock_accuracy;                    = 0x00
} __attribute__ ((packed));

The header part of that is totally garbage and also one octet short since it is missing the 0x04 in front of it. This accidentally doesn’t make the whole stream fall flat on its face, because we drop the whole SKB and don’t try to re-synchronize.

So I assume you have an incoming connection and you are trying to act as peripheral.

Maybe the hu->padding and hu->alignment is causing some issue in h4_recv_buf. So you might want remove this part and see if that makes any difference.

                /* remove padding bytes from buffer */
                for (; hu->padding && count > 0; hu->padding--) {
                        count--;
                        buffer++;
                }

Other than that it will be most likely some issue in the transport. Maybe it is as simple as having the operational speed configured. I saw in the trace that for the Edison board, we seem to skip it.

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ff8435ce163c..5f8d78cb7e64 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1024,6 +1024,8 @@ static int bcm_probe(struct platform_device *pdev)
                        return ret;
        }
 
+       dev->oper_speed = 115200;
+
        ret = bcm_get_resources(dev);
        if (ret)
                return ret;

If I am not mistaken, then the above should do that for the Edison platform device. You can set it higher, but I would try with the default one and then check if it shows up in the btmon trace. It could be well that it needs to be faster so that the ACL packets and HCI event packets can leave the controller as fast as possible. So by all means try to set it to 3000000 as well.

My main problem with Edison is that the platform is not yet serdev enabled. Nobody wants to spend any time in making it done properly. So if the dev->oper_speed does not result in the HCI UART speed change command as first command, we need to figure out where to put this information.

Regards

Marcel


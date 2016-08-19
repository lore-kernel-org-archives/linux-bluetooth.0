Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Memory (skb) leak in kernel 4.8-rc2
Message-ID: <a62119eb-28d2-7b4d-acbb-6ca8d3a0c91d@lwfinger.net>
Date: Fri, 19 Aug 2016 16:02:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

I am seeing two skb leaks in the BT sub-system for kernel 4.8-rc2. I only 
recently re-enabled kmemleak, but I do not think I saw these leaks in 4.7.

The first leak is at btusb_recv_intr+0x12b/0x170 [btusb]. This address refers to 
the call to bt_skb_alloc() in routine btusb_recv_intr().

The second leak is at hci_event_packet+0xb8/0x30b0 [bluetooth]. The backtrace 
for this address is

0x13d38 is in hci_event_packet (net/bluetooth/hci_event.c:5254).
5249             * various handlers may modify the original one through
5250             * skb_pull() calls, etc.
5251             */
5252            if (req_complete_skb || event == HCI_EV_CMD_STATUS ||
5253                event == HCI_EV_CMD_COMPLETE)
5254                    orig_skb = skb_clone(skb, GFP_KERNEL);
5255
5256            skb_pull(skb, HCI_EVENT_HDR_SIZE);
5257
5258            switch (event) {

I am unable to unload module bluetooth to verify that the second leak is not a 
false positive; however, the one in btusb is a real memory leak.

As always, I will be happy to test any patches.

Larry

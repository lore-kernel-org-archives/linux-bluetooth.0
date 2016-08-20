Return-Path: <johan.hedberg@gmail.com>
Date: Sat, 20 Aug 2016 10:15:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Memory (skb) leak in kernel 4.8-rc2
Message-ID: <20160820071504.GA9663@t440s.P-661HNU-F1>
References: <a62119eb-28d2-7b4d-acbb-6ca8d3a0c91d@lwfinger.net>
 <A07D8003-F1EB-4408-A3F2-E043DF678296@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A07D8003-F1EB-4408-A3F2-E043DF678296@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Aug 20, 2016, Marcel Holtmann wrote:
> > I am seeing two skb leaks in the BT sub-system for kernel 4.8-rc2. I
> > only recently re-enabled kmemleak, but I do not think I saw these
> > leaks in 4.7.
> > 
> > The first leak is at btusb_recv_intr+0x12b/0x170 [btusb]. This
> > address refers to the call to bt_skb_alloc() in routine
> > btusb_recv_intr().
> 
> do you have a backtrace for this one? Also which hardware is this?
> 
> > The second leak is at hci_event_packet+0xb8/0x30b0 [bluetooth]. The
> > backtrace for this address is
> > 
> > 0x13d38 is in hci_event_packet (net/bluetooth/hci_event.c:5254).
> > 5249             * various handlers may modify the original one through
> > 5250             * skb_pull() calls, etc.
> > 5251             */
> > 5252            if (req_complete_skb || event == HCI_EV_CMD_STATUS ||
> > 5253                event == HCI_EV_CMD_COMPLETE)
> > 5254                    orig_skb = skb_clone(skb, GFP_KERNEL);
> > 5255
> > 5256            skb_pull(skb, HCI_EVENT_HDR_SIZE);
> > 5257
> > 5258            switch (event) {
> > 
> > I am unable to unload module bluetooth to verify that the second
> > leak is not a false positive; however, the one in btusb is a real
> > memory leak.
> 
> I can not see a leak. Maybe Johan has an idea.

Unfortunately I don't have any ideas either - there is no exit path from
hci_event_packet() after orig_skb has been allocated that would not
result in kfree_skb(orig_skb) being called first.

Johan

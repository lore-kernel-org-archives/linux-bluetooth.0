Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <55733607.30108@lwfinger.net>
Date: Sat, 06 Jun 2015 13:03:51 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Memory leak in btusb
References: <55638D99.5000704@lwfinger.net> <CF543FED-6CEE-4821-A0E1-9EC751026C24@holtmann.org>
In-Reply-To: <CF543FED-6CEE-4821-A0E1-9EC751026C24@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/06/2015 11:37 AM, Marcel Holtmann wrote:
> Hi Larry,
>
>> While using kmemleak to check for memory leaks in a wireless driver, I noticed the following stack traceback for a leak in btusb:
>>
>> <ffffffff8160257e>] __alloc_skb+0x7e/0x2b0
>> [<ffffffffa06029d6>] btusb_recv_intr+0x136/0x180 [btusb]
>> [<ffffffffa0602ad8>] btusb_intr_complete+0xb8/0x150 [btusb]
>> [<ffffffff8156ccb2>] __usb_hcd_giveback_urb+0x72/0x120
>>
>> To eliminate a false positive, I unloaded the driver and got the following for the virtual address:
>>
>> [<ffffffff8160257e>] __alloc_skb+0x7e/0x2b0
>> [<ffffffffa06029d6>] 0xffffffffa06029d6
>> [<ffffffffa0602ad8>] 0xffffffffa0602ad8
>> [<ffffffff8156ccb2>] __usb_hcd_giveback_urb+0x72/0x120
>
> if this is really an alloc_skb from btusb_recv_intr, then it is the HCI event reassembly handling. Meaning this is data->evt_skb since that is the only one that is ever allocated there.
>
> All the SKBs allocated in that function are consumed by the core or later on freed by btusb_free_frags. Is this some rare case on suspend/resume where we forget to free the frags when we get disconnected and re-enumerate via probe?
>
> When the core consumes this SKB via hci_recv_frame it really consumes it. If for some reason this function returns an error, it still frees the SKB. So for all intense in purposes it could be even void.
>
> So I need some more info on what is causing this memory leak. The one in the Intel setup routine was obvious. If that does not fix it, then this is not obvious. You might need to check which alloc_skb this really is. As I said, if it is the one in btusb_recv_intr, then it is the data->evt_skb that is leaking in some corner case.

Yes, it is the alloc_skb from btusb_recv_intr() and data->evt_skb is leaking, 
but it is not due to a suspend/resume. I have no clue as to what corner case I 
might be triggering. I have two Bluetooth mice, but neither appears to be 
working. To test, I have connected to a cell phone, but that does not allow for 
much data exchange. Even so, I now have 5 of these leaks from btusb_recv_intr(). 
As before, all of them are real leaks.

Larry

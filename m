Return-Path: <jeffy.chen@rock-chips.com>
Message-ID: <594C8F0D.4000100@rock-chips.com>
Date: Fri, 23 Jun 2017 11:46:21 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: LKML <linux-kernel@vger.kernel.org>, xiyou.wangcong@gmail.com,
	Brian Norris <briannorris@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, open@263.net,
	list@263.net:BLUETOOTH DRIVERS <linux-bluetooth@vger.kernel.org>,
	Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC PATCH] Bluetooth: btusb: Fix memory leak in play_deferred
References: <1498126243-4771-1-git-send-email-jeffy.chen@rock-chips.com> <65CF80EF-EA58-4126-889D-07A8FF9D52DB@holtmann.org>
In-Reply-To: <65CF80EF-EA58-4126-889D-07A8FF9D52DB@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

thanx for your comments.

On 06/22/2017 06:21 PM, Marcel Holtmann wrote:
> Hi Jeffy,
>
>> Currently in play_deferred, we are calling usb_submit_urb directly to
>> submit deferred tx urb after unanchor it.
>>
>> So the usb_giveback_urb_bh would failed to unref it in usb_unanchor_urb
>> and cause memory leak:
>> unreferenced object 0xffffffc0ce0fa400 (size 256):
>> ...
>>   backtrace:
>>     [<ffffffc00034a9a8>] __save_stack_trace+0x48/0x6c
>>     [<ffffffc00034b088>] create_object+0x138/0x254
>>     [<ffffffc0009d5504>] kmemleak_alloc+0x58/0x8c
>>     [<ffffffc000345f78>] __kmalloc+0x1d4/0x2a0
>>     [<ffffffc0006765bc>] usb_alloc_urb+0x30/0x60
>>     [<ffffffbffc128598>] alloc_ctrl_urb+0x38/0x120 [btusb]
>>     [<ffffffbffc129e7c>] btusb_send_frame+0x64/0xf8 [btusb]
>>
>> Use submit_tx_urb instead for better error handling and avoid the leak.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> drivers/bluetooth/btusb.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 278e811..b469f9b 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -3254,11 +3254,12 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>>
>> static void play_deferred(struct btusb_data *data)
>> {
>> +	struct hci_dev *hdev = data->hdev;
>> 	struct urb *urb;
>> 	int err;
>>
>> 	while ((urb = usb_get_from_anchor(&data->deferred))) {
>> -		err = usb_submit_urb(urb, GFP_ATOMIC);
>> +		err = submit_tx_urb(hdev, urb);
>> 		if (err < 0)
>> 			break;
>
> so why not just fix the memory leak here and instead call submit_tx_urb. I am not sure that is actually the right approach. Why anchor this URB now to the TX anchor now? Is that actually safe?
>
the current flow is:
   submit_or_queue_tx_urb
     if (!suspending)
       submit_tx_urb
     else
       put into deferred anchor
       wake btusb

   retry the deferred urbs in deferred anchor(using usb_submit_urb) 
after resumed

so i think there are 2 problems here:
1/ error handling, compare submit_tx_urb to usb_submit_urb, it freed 
urb->setup_packet when failed to submit
2/ memory leak:
in usb_submit_urb, we ref that urb
in __usb_hcd_giveback_urb, we unanchor it, and then unref it.

so i think the usb_submit_urb expected the urb not just be referenced, 
but also anchored? or referenced, but the caller would unref it himself 
later?

and for tx_anchor, we put urb in it, and kill them all during suspending 
to prevent transfer. so i guess it would be safe to put deferred urb in 
to it after resume too?
but i don't know much about usb/btusb, so i could be wrong all about that :)

> Regards
>
> Marcel
>
>
>
>

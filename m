Return-Path: <jeffy.chen@rock-chips.com>
Message-ID: <596DC200.1080006@rock-chips.com>
Date: Tue, 18 Jul 2017 16:08:32 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Oliver Neukum <oneukum@suse.com>,
 Marcel Holtmann <marcel@holtmann.org>
CC: linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com,
 briannorris@chromium.org, dianders@chromium.org,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [RFC PATCH v2] Bluetooth: btusb: Fix memory leak in play_deferred
References: <1500343579-9831-1-git-send-email-jeffy.chen@rock-chips.com>  <6E21F79E-93AA-4461-BA6B-67715501714F@holtmann.org> <1500363015.16072.5.camel@suse.com>
In-Reply-To: <1500363015.16072.5.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

On 07/18/2017 03:30 PM, Oliver Neukum wrote:
> Am Dienstag, den 18.07.2017, 08:44 +0200 schrieb Marcel Holtmann:
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 0d533b2..a22a08b 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -3260,19 +3260,33 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>>>         return 0;
>>> }
>>>
>>> +static void btusb_deferred_tx_complete(struct urb *urb)
>>> +{
>>> +     btusb_tx_complete(urb);
>>> +     usb_free_urb(urb);
>>> +}
>>> +
>>> static void play_deferred(struct btusb_data *data)
>>> {
>>>         struct urb *urb;
>>>         int err;
>>>
>>>         while ((urb = usb_get_from_anchor(&data->deferred))) {
>>> +             /* Add a hook to free urb after completed */
>>> +             urb->complete = btusb_deferred_tx_complete;
>>> +
>>>                 err = usb_submit_urb(urb, GFP_ATOMIC);
>>> -             if (err < 0)
>>> -                     break;
>>> +             if (err < 0) {
>>> +                     if (err != -EPERM && err != -ENODEV)
>>> +                             BT_ERR("%s urb %p submission failed (%d)",
>>> +                                    data->hdev->name, urb, -err);
>>> +                     kfree(urb->setup_packet);
>>> +                     usb_free_urb(urb);
>>> +                     continue;
>>> +             }
>>>
>>>                 data->tx_in_flight++;
>>>         }
>>> -     usb_scuttle_anchored_urbs(&data->deferred);
>>> }
>>
>> can I get an ack from you on this one?
>
> Hi,
>
> I am afraid not. We cannot silently drop one part of a transmission.
> I am afraid that the correct algorithm, if we encounter an error at
> that stage, is to abort the operation and report an error.
>
so i should break the loop when error happens right?

and i uploaded 2 version of patches, which one do you prefer to go on?
> 	Regards
> 		Oliver
>
>
>
>

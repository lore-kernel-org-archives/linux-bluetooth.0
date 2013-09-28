Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 3/8] Bluetooth: Test for HCI_SETUP and HCI_USER_CHANNEL in mgmt_valid_hdev()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130927114506.GA19210@x220.p-661hnu-f1>
Date: Sat, 28 Sep 2013 10:06:57 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8F3048F3-3CE4-4257-912C-325A78F2DD6E@holtmann.org>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com> <1380031363-1266-4-git-send-email-johan.hedberg@gmail.com> <DFCF34C2-5AA9-4644-BB4B-3D6073DA9D42@holtmann.org> <20130925100353.GA3158@x220.p-661hnu-f1> <C7C45B32-4EF9-4FD7-B774-E88917DFAC75@holtmann.org> <20130927114506.GA19210@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>>> If either one of the HCI_SETUP or HCI_USER_CHANNEL flags is set the
>>>>> device is not considered valid for mgmt. By having these checks inside
>>>>> the mgmt_valid_hdev function the a couple of places using it can be
>>>>> simplified.
>>>> 
>>>> I looked at doing this and decided not to. Reason was that the device
>>>> gets removed from mgmt anyway.
>>> 
>>> I'm not sure what significance you think "device gets removed from mgmt"
>>> has. All that is is a mgmt event saying that index has been removed. In
>>> addition to that we need to ensure that we don't send any more mgmt
>>> events for such devices and that we don't include such devices in the
>>> response to mgmt_read_index list.
>>> 
>>> These are the two places of the code that my patch simplifies, one is
>>> the check for whether to send a "power on" mgmt event and the other the
>>> response handling of read_index_list.
>> 
>> I have taken care of that part. It is done inside mgmt_control() and
>> in case of a controller in user channel mode it returns invalid index.
> 
> That's great, but it doesn't cover the read_index_list command which we
> were talking about here since the command doesn't target any specific
> controller (as per our mgmt-api.txt it has the value <non-controller> as
> the controller index). The command handler will in this case be invoked
> that that's where it'd be convenient to rely on mgmt_valid_hdev() for
> constructing the response.

the read index list command has a special check for user channel. As I said, I looked into this and opted against extending valid hdev macro since we only need it in a few specific cases. Adding it there resulted in simpler code then some magic macro that is used in more places.

When I wrote the patches for user channel this felt cleaner. I had patches for both ways, but decided to go this route.

>> For the events, I have no idea on how we would generate events if we
>> are not going through hci_event.c when the user channel is active.
> 
> The "powered on" event in question doesn't come from hci_event.c but
> from the hci_dev_open() function, so again this is not covered by the
> existing user channel checks.

How would you trigger a power on event. When user channel is active everything else is blocked. So every other operation will fail. That is taken care of.

In addition you can only activate user channel on a controller that is powered off. That was a conscious design decision. Keep it really simple. User channel mode is exclusive and exclusive to one user at a time.

Regards

Marcel


Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5460C0A8.6090400@linux.intel.com>
References: <1415619477-2358-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1415619477-2358-2-git-send-email-ravikumar.veeramally@linux.intel.com>
	<CABBYNZLArffoj1Ggf9O=yvd=UFnJGTQUK+UZV=VkMjTeaeg-_g@mail.gmail.com>
	<5460C0A8.6090400@linux.intel.com>
Date: Mon, 10 Nov 2014 15:55:41 +0200
Message-ID: <CABBYNZJvH-_6i3jePA6pr9EDMWiQ3OPp6XNiHLaUe3v--82b+g@mail.gmail.com>
Subject: Re: [PATCH 1/4] android/hal-ipc-txt: Add support for new AVRCP CTRL interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Mon, Nov 10, 2014 at 3:42 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> Hi Luiz,
>
>
> On 11/10/2014 03:32 PM, Luiz Augusto von Dentz wrote:
>>
>> Hi Ravi,
>>
>> On Mon, Nov 10, 2014 at 1:37 PM, Ravi kumar Veeramally
>> <ravikumar.veeramally@linux.intel.com> wrote:
>>>
>>> AVRCP controller interface added in Android Lollipop. Update it's
>>> commands and notifications.
>>> ---
>>>   android/hal-ipc-api.txt | 49
>>> +++++++++++++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 45 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
>>> index 666e27f..fc78244 100644
>>> --- a/android/hal-ipc-api.txt
>>> +++ b/android/hal-ipc-api.txt
>>> @@ -1241,7 +1241,7 @@ Notifications:
>>>                                        0x04 = Destroyed
>>>
>>>
>>> -Bluetooth Remote Control HAL (ID 8)
>>> +Bluetooth Remote Control Target HAL (ID 8)
>>>   ===================================
>>>
>>>   Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
>>> @@ -1470,8 +1470,49 @@ Notifications:
>>>                  Notification parameters: ID (1 octet)
>>>                                           State (1 octet)
>>>
>>> +Bluetooth Remote Control Controller HAL (ID 9)
>>> +===================================
>>> +
>>> +Android HAL name: "avrcp-ctrl" (BT_PROFILE_AV_RC_CTRL_ID)
>>> +
>>> +Commands and responses:
>>> +
>>> +       Opcode 0x00 - Error response
>>> +
>>> +               Response parameters: Status (1 octet)
>>> +
>>> +               Valid status values: 0x01 = Fail
>>> +                                    0x02 = Not ready
>>> +                                    0x03 = No memory
>>> +                                    0x04 = Busy
>>> +                                    0x05 = Done (already completed)
>>> +                                    0x06 = Unsupported
>>> +                                    0x07 = Parameter invalid
>>> +                                    0x08 = Unhandled
>>> +                                    0x09 = Authentication failure
>>> +                                    0x0a = Remote device down
>>> +
>>> +       Opcode 0x01 - Send Pass Through command/response
>>> +
>>> +               Command parameters: Remote Address (6 octets)
>>> +                                   Key Code (1 octet)
>>> +                                   Key State (1 octet)
>>> +
>>> +               In case of an error, the error response will be returned.
>>> +
>>> +Notifications:
>>> +
>>> +       Opcode 0x81 - Passthrough Response Notification
>>> +
>>> +               Notification parameters: ID (1 octet)
>>> +                                        Key State (1 octet)
>>> +
>>> +       Opcode 0x82 - Connection State Notification
>>> +
>>> +               Notification parameters: State (1 octet)
>>> +                                        Remote Address (6 octets)
>>
>> This should probably be added to the bottom as we did with other new
>> HAL.
>
>   Sure, I will add at bottom in both hal-ipc-txt and hal-msg.h.
>>
>>   Btw, perhaps we should keep a history of API changes e.g. since:
>> 5.0 per opcode so it become easier to identify changes in the future.
>
>   So where should we keep changes related 5.0?


I was thinking in something like this:

Opcode 0x82 - Connection State Notification

               Notification parameters: State (1 octet)
                                        Remote Address (6 octets)
               since: 5.0

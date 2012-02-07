Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACJA=fURLb2RrD_P+gbFG=KXfniSpmB7a4xWmE43dAUgycQWHA@mail.gmail.com>
References: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
	<1328588997-25029-4-git-send-email-aguedespe@gmail.com>
	<CAJdJm_OdPCzJaBSkPx8E0ZS+TqVJV943+t8Npj+x=U8B4XRZ5w@mail.gmail.com>
	<CACJA=fUdhynSn=YkRnL4Xc3HVnh0fo_NeBxp5SzCizv0bivohA@mail.gmail.com>
	<CAA37ikYZjOXUQfYAEZh2fYPWWwTCoNZh201tFCAqcZ4_oiwUWQ@mail.gmail.com>
	<CACJA=fURLb2RrD_P+gbFG=KXfniSpmB7a4xWmE43dAUgycQWHA@mail.gmail.com>
Date: Tue, 7 Feb 2012 13:20:09 -0200
Message-ID: <CAA37ikagyceFEAkcKmcZ3uPthUTOBkZR3nmwRLoQazj6pA22Aw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Use advertising cache thread-safe functions
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Andre Guedes <aguedespe@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Feb 7, 2012 at 12:46 PM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> Hi Ulisses,
>
> On Tue, Feb 7, 2012 at 10:26 AM, Ulisses Furquim <ulisses@profusion.mobi> wrote:
>> Hi Andre,
>>
>> On Tue, Feb 7, 2012 at 10:20 AM, Andre Guedes
>> <andre.guedes@openbossa.org> wrote:
>>> Hi Lizardo,
>>>
>>> On Tue, Feb 7, 2012 at 7:48 AM, Anderson Lizardo
>>> <anderson.lizardo@openbossa.org> wrote:
>>>> Hi Andre,
>>>>
>>>> On Tue, Feb 7, 2012 at 12:29 AM, Andre Guedes <aguedespe@gmail.com> wrote:
>>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>>>> index 6808069..3933ccd 100644
>>>>> --- a/net/bluetooth/hci_event.c
>>>>> +++ b/net/bluetooth/hci_event.c
>>>>> @@ -3255,12 +3255,10 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
>>>>>        void *ptr = &skb->data[1];
>>>>>        s8 rssi;
>>>>>
>>>>> -       hci_dev_lock(hdev);
>>>>> -
>>>>
>>>> So there is no need to lock hdev between the hci_add_adv_entry() and
>>>> mgmt_device_found() calls? This looks different from what is done for
>>>> BR/EDR for the inquiry cache.
>>>
>>> Yes, mgmt_device_found() does not require locking hdev->lock.
>>
>> We could then move the lock and unlock calls to inside the loop. But
>> as we might have more than one call to hci_add_adv_entry() it'd be
>> good to lock and unlock only once, no? Any problems I don't see?
>
> Yes, that's right. For this particular case, it may be better to lock
> hdev outside while() and call the thread-unsafe version here.
>
> This way, it may be better we just drop patches 02/03 and 03/03.
>
>>>>>        while (num_reports--) {
>>>>>                struct hci_ev_le_advertising_info *ev = ptr;
>>>>>
>>>>> -               __hci_add_adv_entry(hdev, ev);
>>>>> +               hci_add_adv_entry(hdev, ev);
>>>>>
>>>>>                rssi = ev->data[ev->length];
>>>>>                mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
>>>>> @@ -3268,8 +3266,6 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
>>>>>
>>>>>                ptr += sizeof(*ev) + ev->length + 1;
>>>>>        }
>>>>> -
>>>>> -       hci_dev_unlock(hdev);
>>>>>  }
>>>>>
>>>>>  static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
>>>>> --
>>>>> 1.7.9
>>
>> While I don't see anything wrong with your changes I don't think we
>> really need it. All the other functions that need to be called with
>> hdev->lock held don't have "__" prefix so it'll be different than the
>> others. And you added 3 new locked functions but your last patch only
>> uses 2 of them and only in 2 places. Unless I'm missing something here
>> we don't really need this refactoring at all. Do you have any other
>> reason to do that? Are you gonna use those functions in other
>> patchset?
>
> Yes, some other functions don't have the prefix "__" and that fact
> makes a bit painful and error-prone since we always have to dig in
> the "call chain" to know if we need to hold hdev->lock or not.
> Prefixing a function with "__" is just a standard way to indicate
> that.

I understand that. I just don't know if Marcel will want to change
them all to have "__" prefixes, though. Having only one subset with
this prefix can make things even more confusing, don't you agree?

And have you been working with these functions or is this just a
cleanup you thought it'd be good to do?

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

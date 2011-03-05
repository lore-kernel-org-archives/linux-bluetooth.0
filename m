Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTing8htA_TSLQ7ScxC0+KGAo+nHZ+6Amiyet7d5-@mail.gmail.com>
References: <AANLkTi=yuqTG1MiqN3FHM+2m0OX9QNajq8+xJG_D1-EG@mail.gmail.com>
	<AANLkTi=qB6WcjkQcp0teuL5DTKKBSSK0ydWD1EtwCh=n@mail.gmail.com>
	<AANLkTinsnjed16owx=JqCCPa3AMC3P_Z9qLNd8AZ4jyf@mail.gmail.com>
	<AANLkTi=Z0jaFfeLsNzx9SDJvz-2XCzzTJ++L56rLGZt3@mail.gmail.com>
	<AANLkTikW1upXoEX05vVepE+GFHoFk4_X6m0ur1PYEHFz@mail.gmail.com>
	<AANLkTing8htA_TSLQ7ScxC0+KGAo+nHZ+6Amiyet7d5-@mail.gmail.com>
Date: Sat, 5 Mar 2011 04:03:51 -0600
Message-ID: <AANLkTi=VQjpPsLQAbFwRwFLcTJvpfcza4dK_khfoK4vT@mail.gmail.com>
Subject: Re: HCI core error recovery.
From: Andrei Warkentin <andreiw@motorola.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Feb 27, 2011 at 5:30 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Fri, Feb 18, 2011 at 2:21 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
>> On Mon, Feb 14, 2011 at 4:23 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
>>> On Sat, Feb 12, 2011 at 12:47 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
>>>> On Fri, Feb 11, 2011 at 5:07 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
>>>>> Dear List,
>>>>>
>>>>> I've run into an interesting problem. Excuse me in advance if this was
>>>>> already covered here, or for my explanations, since I'm not too
>>>>> familiar with overall flow within BlueZ or Bluetooth specifics...
>>>>> We've had some hardware config issues that resulted in garbage/malformed
>>>>> messages arriving via H4 into the HCI layer. We've since resolved
>>>>> these, but it got me thinking. The issues would result in certain HCI
>>>>> messages being missed, including occasionally disconnect events being
>>>>> missed, and a subsequent connect event would result in a double add.
>>>>>
>>>>> I was thinking about how to fix at the very least the crash. The sysfs
>>>>> object is created as a last step after getting a "connection
>>>>> completed" HCI message, I think. What I am unsure about is if it's
>>>>> safe to just ignore the add if there is already a sysfs entry...
>>>>>
>>>>> So I would think the HCI core needs some resiliency against
>>>>> bad/malignant bluetooth controllers, and perform error
>>>>> recovery/resynchronization. Perhaps maybe there is room for a virtual
>>>>> hci controller that just injects various message types to see how well
>>>>> the core can cope?
>>>>>
>>>>> Thanks in advance,
>>>>> A
>>>>
>>>> To further explain the issue, here is what was happening -
>>>>
>>>> 0) A BT device is paired.
>>>> 1) Host goes into sleep mode.
>>>> 2) BT device turns off.
>>>> 3) Host wakes up due to BT waking the host. Due to UART resume issues,
>>>> HCI message corrupted. hci_disconn_complete_evt never gets called.
>>>> 4) BT device turns on.
>>>> 5) devref gets incremented in  hci_conn_complete_evt, and is now 2.
>>>> 6) BT device turns off. hci_disconn_complete_evt is called, conn hash
>>>> is deleted, but sysfs entry not cleaned up since
>>>> atomic_dec_and_test(&conn->devref) != 0.
>>>> 7) BT device turns on. sysfs add fails since it never was cleaned up.
>>>>
>>>> The attached patch takes care of that. I'm not too familiar with BlueZ
>>>> (or bluetooth :-(), so I would like your feedback. In particular, I am
>>>> unsure about sync connections.
>>>> The primary issue overall is that HCI core doesn't handle HCI issues
>>>> (whether caused by transport issues, or bad/malicious BT controller).
>>>> I am curious if there are other ways to break the core.
>>>>
>>>> Thanks,
>>>> A
>>>>
>>>
>>> Anyone?
>>>
>>
>> Anyone? Who should I talk to about HCI?
>>
>
> Anyone pretty please :)? I'm positive what I'm doing isn't necessarily
> right, but I do think this is a real issue in current BlueZ code that
> needs work. HCI core should be more resilient to HCI transport issues,
> after all, the BT HCI spec does mandate specific behavior.
>
> A
>

Anyone? I mean anyone can literally craft a malicious usb device that
will act like a bluetooth controller and crash the OS... Nobody is at
all interested?

A

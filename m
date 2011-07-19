Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBcgkTqSb63dHSwMnfw2tp_uwQPvgMZZe+=cEGSmmOLifg@mail.gmail.com>
References: <1311010504-15060-1-git-send-email-claudio.takahasi@openbossa.org>
	<CALJ2SBLju51yhOuK+nMrXBoyLs23SCdD+SN7kup0f+kzvEmcqQ@mail.gmail.com>
	<CAKT1EBcgkTqSb63dHSwMnfw2tp_uwQPvgMZZe+=cEGSmmOLifg@mail.gmail.com>
Date: Tue, 19 Jul 2011 14:59:59 -0300
Message-ID: <CAKT1EBepAMrUzRvOMMiEyr5Zmist-rzD55pfnkSe+hRMdtM26A@mail.gmail.com>
Subject: Re: [RFC BlueZ] Proximity API simplification
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

On Tue, Jul 19, 2011 at 12:11 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Briglia,
>
> On Tue, Jul 19, 2011 at 11:34 AM, Anderson Briglia
> <anderson.briglia@openbossa.org> wrote:
>> Hi Claudio,
>>
>> On Mon, Jul 18, 2011 at 2:35 PM, Claudio Takahasi
>> <claudio.takahasi@openbossa.org> wrote:
>>> Delegates the Immediate Alert Level control to the caller(client).
>>> Immediate Alert Service is shared between Path Loss and Find Me.
>>>
>>> Cons: distributed actions may impact qualification. Client needs to
>>> control when to write the Immediate Alert based on the received
>>> SignalLevel received.
>>> ---
>>>
>>>  I'd like to collect feedbacks before proceeding with this change.
>>>  Does it look more clear than the previous API version?
>>>
>>>  The ideia is to move to the kernel the RSSI value polling. The
>>>  userspace will receive notifications when one of the SignalLevel
>>>  threshold is triggered: "good", "regular", "week".
>>
>> How about simplify more and have just two alert levels? Is there any
>> reason to have three? It could simplify the RSSI Monitor in the
>> kernel.
>>
>> Regards,
>>
>> Anderson Briglia
>
> Choosing two levels only, clients will not be able to map directly the
> 3 alert levels values of the Immediate Alert Characteristic: none,
> mild, high.
> My suggestion is to implement the following mapping:
> good->none
> regular->mild
> weak->high
>
> Of course, based on the proposal of delegating the write
> operation(SetProperty) to the client, it up to the client to choose
> when and which alert level to use.
> Clients could also consider the selected phone profile(eg: silent,
> meeting, normal) also to choose the alert level.
>
> Resuming, I don't have a strong argument to have 3 levels, I defined 3
> to simplify the mapping of immediate alert level characteristic. But
> this is implementation specific.
>
> Regards,
> Claudio.
>

We had a small misunderstanding about thresholds and alerts. 2
thresholds should be mapped into 3 states/intervals. The changes that
I proposed is aligned with your RSSI monitor(in the kernel) proposal.
Please send the Management API RFC.

SignalLevel in the Proximity API doesn't need to be mapped directly in
the RSSI monitor states, we are aligning it to expose to the clients
all transitions.


Regards,
Claudio

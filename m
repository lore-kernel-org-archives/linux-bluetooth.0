Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC6CB33.5060405@codeaurora.org>
Date: Fri, 18 Nov 2011 13:16:35 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] LE: Low Latency GATT Write-Sign-Cmd
References: <4EC6A13B.5030805@codeaurora.org>	<1321643339.15441.622.camel@aeonflux>	<CAJdJm_MHBsEER01OsgdhzYM8WyKuGfxHUZwDv-oYQjJtR9N_ww@mail.gmail.com>	<4EC6C48D.6070609@codeaurora.org> <CAJdJm_Maz=4Wh2qq=+502NivoZT6BxyW==t7J4shnL96kn2Ovg@mail.gmail.com>
In-Reply-To: <CAJdJm_Maz=4Wh2qq=+502NivoZT6BxyW==t7J4shnL96kn2Ovg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 11/18/2011 12:58 PM, Anderson Lizardo wrote:
> On Fri, Nov 18, 2011 at 4:48 PM, Brian Gix<bgix@codeaurora.org>  wrote:
>> On 11/18/2011 12:36 PM, Anderson Lizardo wrote:
>>> On Fri, Nov 18, 2011 at 3:08 PM, Marcel Holtmann<marcel@holtmann.org>
>>>   wrote:
>>>>
>>>> I think one of the most important questions that we have to ask
>>>> ourselves at some point is if we wanna put ATT into the kernel.
>>>>
>>>> The potential candidate that forces us to think about this is HID over
>>>> Low Energy. However I like to see numbers on how the context switches
>>>> with keeping ATT in userspace will effect our latency.
>>>
>>> I still fail to see how ATT handling in kernel would reduce context
>>> switches. A GATT operation is composed of one or more (possibly many,
>>> see e.g. discovery procedures) ATT PDUs.
>>>
>>> Unless you are proposing GATT on kernel as well?
>>
>> I don't think having GATT in the kernel is necessarily the logical
>> conclusion to an ATT-to-kernel migration.
>
> I was actually referring only to the context switch topic. You still
> need to send the ATT request parameters from userspace, which is not
> different from building the PDU on userspace (vs. building on kernel).
>
> Unless I'm not understanding what Marcel meant with "ATT on kernel"
> (which is most probably the case).
>
>> Remember that the focus of LE is *not* the discovery process.  Discovery (of
>> Devices, Services and Characteristics) is important, but what makes LE "Low
>> Energy" is what happens *after* pairing and discovery have been completed,
>> which ideally would happen One Time Only.
>
> The discovery procedure was only an example of multiple PDU operation.
> Take e.g. "read long". If only ATT is on kernel, it still need
> multiple context switches for the multiple PDUs involved for the GATT
> operation.
>
>> The LE profiles and services are being spec'd so that they can be highly
>> efficient over the lifetime of the Low Energy device.  The Linux side of the
>> equation will rarely be an actual Low Energy device:  It will just know how
>> to talk to an LE device in such a way as to make that Button-cell battery
>> driven device last a couple years if possible.
>>
>> For that reason MOST day-to-day communication between a Linux based
>> "Central" device will in fact be single-ATT procedures.  If it takes more
>> energy and context switches to do discovery using many compound procedures,
>> then we pay that price, because it should only happens Once.
>
> ... and for this reason I don't see much gain in reducing context
> switches if *only* ATT is on kernel. (note: I'm not defending GATT on
> kernel).
>
>> HID devices in particular, will almost certainly NOT use compound GATT
>> procedures to communicate after the pairing and discovery point in time has
>> past.
>
> Yes, and also I don't see why LE HID is an example of "many context
> switches". For sure, you will need a bunch of them for setting up the
> HID device (discovery + pairing), but after that it will "talk" HID
> with the kernel input subsystem (If I understood the basics of this
> profile).

I don't know about everyone else, but most of the context switching that 
I would like to see avoided is for single ATT-procedures that:
Connect-DoSomething-Disconnect

That is the case for any Write-Signed-Command type of operations.

Perhaps HID is different, although I think the idea for HID is to not 
require the round trip of:

Baseband --> Kernel --> UserSpace --> Kernel --> HIDQueue

Would the Context switching make significant difference?  I suspect that 
on some platforms it would be hardly noticeable, but I would rather 
design something that we *know* requires low latency, to assume it is 
operating in an environment that might be hostile to latency concerns.

I personally think a fully feature rich GATT is too heavy to include in 
the kernel, but that perhaps a specialized HID server (recognized by a 
kernel resident ATT driver as being in the proper ATT Handle range) 
might make some sense.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

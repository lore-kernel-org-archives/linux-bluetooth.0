Return-Path: <cyrus@holtmann.org>
Message-ID: <527858A5.2080801@canonical.com>
Date: Tue, 05 Nov 2013 10:32:05 +0800
From: Hui Wang <hui.wang@canonical.com>
MIME-Version: 1.0
To: Stevie Trujillo <stevie.trujillo@gmail.com>
CC: marcel@holtmann.org, tedd.an@intel.com,
 linux-bluetooth@vger.kernel.org
Subject: Re: Intel 7260 bluetooth malfunction when it is connected to EHCI
 bus
References: <526F8804.9060906@canonical.com> <A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org> <52707428.9070908@canonical.com> <6091DDC7-7B00-4457-82A0-F8CC9B4EE9DD@holtmann.org> <5271EAA2.1030705@canonical.com> <D0B840E3-36C4-4751-A757-1ADDAC0707B9@holtmann.org> <5273147E.4040004@canonical.com> <C3BBD7E9-6D91-430E-96DF-2D4885F89DCC@holtmann.org> <527371D4.1010305@canonical.com> <9DFD9618-158E-41C4-8183-134A3FC4E61F@holtmann.org> <527737C7.40208@canonical.com> <20131104141539.772e1636@localhost>
In-Reply-To: <20131104141539.772e1636@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/04/2013 09:15 PM, Stevie Trujillo wrote:
> Hello, I've been trying to use my computer as "handsfree" with
> "Hands-Free Profile" using "Intel Corporation Centrino Wireless-N
> 1030". I accept() the BTPROTO_SCO socket, but never recv() any
> data. Your post looked similar!
>
> When googling I found this:
>
> http://www.netbsd.org/docs/guide/en/chap-bluetooth.html#chap-bluetooth-audio
>     SCO Audio will not work with ehci(4) USB controllers, since support
>     for Isochronous data over EHCI is missing in NetBSD.
>
> Does Linux support this? (I have no idea what it means)

Hi Stevie,

Thanks for your input, I don't know the answer of your question, but at 
least the camera works well on the EHCI bus, and camera transfers the 
ISO packets over EHCI bus.

Regards,
Hui.
>
> I'm sorry if this mail is somewhat broken. I could only find your email
> on "gmane" and it had encrypted all your email addresses!
>
> On Mon, 04 Nov 2013 13:59:35 +0800
> Hui Wang <hui.wang-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org> wrote:
>
>> On 11/03/2013 03:05 AM, Marcel Holtmann wrote:
>>> Hi Hui,
>>>
>> <snip>
>>>> The attachment lenovo-k4450-btmon-v1.log is the log of intel 7260
>>>> init procedure + scan headset + connect headset + play sound.
>>> I looked through the logs and the controller init is just fine. So
>>> in theory this should route the SCO audio frames over HCI. For some
>>> reason it does not and I have no idea why not.
>>>
>>> That it makes a different between EHCI and XHCI is strange. I can
>>> not explain this. Maybe Tedd can help you since I have no further
>>> insights in our chips at this moment.
>> Thanks Marcel for your kind help and analysis.
>>
>> Tedd, did you reproduce this issue on the machines with intel 7260 BT
>> module connected to the EHCI bus? Did you have any idea on this issue?
>

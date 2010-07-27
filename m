Return-Path: <cyrus@holtmann.org>
Message-ID: <4C4EFCF2.6090108@Atheros.com>
Date: Tue, 27 Jul 2010 21:06:18 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC v2] Bluetooth: Provide access to reassembled Rx packets
References: <1280126094-18004-1-git-send-email-suraj@atheros.com>	 <1280157203.2621.48.camel@localhost.localdomain>	 <4C4DD292.60001@Atheros.com>	 <1280184169.2621.63.camel@localhost.localdomain>	 <4C4E650D.4080806@Atheros.com> <1280207657.2621.74.camel@localhost.localdomain>
In-Reply-To: <1280207657.2621.74.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 7/27/2010 10:44 AM, Marcel Holtmann wrote:
> Hi Suraj,
>
>>> So first of all, lets make something perfectly clear. All Bluetooth
>>> drivers are _transport_ drivers. They don't need to know what they are
>>> transporting. And in addition you should not look into the packets that
>>> you are sending or receiving. The Bluetooth core does that HCI packet
>>> parsing.
>>>
>>> This is how I want it and how this is going to stay. Everything else is
>>> an insane approach and cost every single driver overhead. In addition
>>> the lifetime rules of SKBs become more and more complicated. That is a
>>> pretty bad thing. It will result in excessive memory usage and will
>>> cause problems.
>>
>> I understand the point that you are making. But If I am not mistaken,
>> HCI transport driver is the only part of the system that could be vendor
>> specific ( HCI ATH3K, HCI LL etc). So a vendor specific command or event
>> makes more sense to a transport driver than anybody else.
>>
>> Is there anyway this requirement can be sufficed without causing the
>> issues you have mentioned above?
>
> so you might be able to convince me if you implement something proper
> for handling vendor commands. The basic assumption is still that a HCI
> driver is a pure transport driver.

My requirement is basically to use the command complete event of 
HCI_RESET to trigger a vendor specific command and verify its status by 
checking the status of the VSC.

So, does it makes sense to register a callback with HCI core with 
required Event ID so that HCI core can call the callback when it 
receives the corresponding Event? This would still make sure that HCI 
packets are handled by HCI core and "driver/whoever registers the 
callback" will be notified by the HCI core as and when required.

Not sure this would address the concern you have raised.

>
> However you have access to hci_dev. So if you create some functions to
> execute vendor commands and retrieve the results then this might be a
> way. The core already processes vendor commands and events. But keep in
> mind that there is no requirement to get a command status or command
> complete event for vendor commands. For example CSR doesn't send them
> for their vendor commands.

Thanks,

>
> Regards
>
> Marcel
>
>

Regards
Suraj

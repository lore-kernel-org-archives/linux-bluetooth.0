Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Memory (skb) leak in kernel 4.8-rc2
To: Frederic Dalleau <frederic.dalleau@collabora.co.uk>,
 Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <a62119eb-28d2-7b4d-acbb-6ca8d3a0c91d@lwfinger.net>
 <A07D8003-F1EB-4408-A3F2-E043DF678296@holtmann.org>
 <20160820071504.GA9663@t440s.P-661HNU-F1>
 <dd63c403-f35e-2543-e5ba-af40b263ea75@collabora.co.uk>
 <2be4b143-4f0f-c688-87c3-8056ecc43dfb@lwfinger.net>
 <9484caf9-bc5a-9968-d786-fc7d40f0a720@collabora.co.uk>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <60c6f1ed-8ee1-133e-93cc-872f40fb73cd@lwfinger.net>
Date: Thu, 25 Aug 2016 10:27:23 -0500
MIME-Version: 1.0
In-Reply-To: <9484caf9-bc5a-9968-d786-fc7d40f0a720@collabora.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/25/2016 01:22 AM, Frederic Dalleau wrote:
> Hi Larry,
>
> On 24/08/2016 22:02, Larry Finger wrote:
>> On 08/21/2016 07:09 AM, Frederic Dalleau wrote:
>>>>>> I am unable to unload module bluetooth to verify that the second
>>>>>> leak is not a false positive; however, the one in btusb is a real
>>>>>> memory leak.
>
>>> I have a patch on the grill.
>
>> Any progress on this patch?
>
> Yes, it is in bluetooth-stable.
> http://marc.info/?l=linux-bluetooth&m=147205068529234&w=2

Fred,

Thanks for the link. That patch fixes the leaks that I was seeing from 
bluetooth. It also seems to have fixed the leaks that were attributed to btusb. 
At least, none have shown up in my preliminary testing.

Larry

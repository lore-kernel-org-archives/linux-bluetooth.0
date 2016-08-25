Return-Path: <frederic.dalleau@collabora.co.uk>
Subject: Re: Memory (skb) leak in kernel 4.8-rc2
To: Larry Finger <Larry.Finger@lwfinger.net>,
 Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <a62119eb-28d2-7b4d-acbb-6ca8d3a0c91d@lwfinger.net>
 <A07D8003-F1EB-4408-A3F2-E043DF678296@holtmann.org>
 <20160820071504.GA9663@t440s.P-661HNU-F1>
 <dd63c403-f35e-2543-e5ba-af40b263ea75@collabora.co.uk>
 <2be4b143-4f0f-c688-87c3-8056ecc43dfb@lwfinger.net>
From: Frederic Dalleau <frederic.dalleau@collabora.co.uk>
Message-ID: <9484caf9-bc5a-9968-d786-fc7d40f0a720@collabora.co.uk>
Date: Thu, 25 Aug 2016 08:22:03 +0200
MIME-Version: 1.0
In-Reply-To: <2be4b143-4f0f-c688-87c3-8056ecc43dfb@lwfinger.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

On 24/08/2016 22:02, Larry Finger wrote:
> On 08/21/2016 07:09 AM, Frederic Dalleau wrote:
>>>>> I am unable to unload module bluetooth to verify that the second
>>>>> leak is not a false positive; however, the one in btusb is a real
>>>>> memory leak.

>> I have a patch on the grill.

> Any progress on this patch?

Yes, it is in bluetooth-stable.
http://marc.info/?l=linux-bluetooth&m=147205068529234&w=2

Regards
Fred

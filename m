Return-Path: <cyrus@holtmann.org>
Message-ID: <558D4746.5020200@gmail.com>
Date: Fri, 26 Jun 2015 14:36:22 +0200
From: "jerico.dev" <jerico.dev@gmail.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Unreliable LE advertisement registration through BlueZ advertising
 API
References: <CAPyD+=CwiwARGqT-tKomaJ+o9O6tAiMJ25TiqxFuT2DDS+VKxQ@mail.gmail.com>	<20150625111827.6196924d@tedd-fedora-vm>	<CAPyD+=Ao6bc4o=sDDxZ9sb4hbVShXtWTfVFzOChw4k4iGoBSJQ@mail.gmail.com>	<CABBYNZKLS-9pLxNLCJfb2OnapcX1rCqHgGoRg9gvkjnR0YcNHw@mail.gmail.com>	<558D4404.6020500@gmail.com> <CABBYNZJWbtVT30M0EN6mScZQvkzU6JcoHTNPRQoTaR1URnX9vA@mail.gmail.com>
In-Reply-To: <CABBYNZJWbtVT30M0EN6mScZQvkzU6JcoHTNPRQoTaR1URnX9vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 06/26/2015 02:28 PM, Luiz Augusto von Dentz wrote:
> Hi Florian,
>
> On Fri, Jun 26, 2015 at 3:22 PM, jerico.dev <jerico.dev@gmail.com> wrote:
>> Hi Luiz,
>>
>>>>> Any way, once I run the example-advertisement script, I cannot run it
>>>>> again until I restart the bleutooth daemon.
>>>>> This is known issue.
>>>>
>>>>
>>>> Okay, I'll keep digging.
>>>
>>>
>>> That is something in the kernel Im afraid, it doesn't seems to remove
>>> the instances properly.
>>
>>
>> is it possible to reproduce this bad behavior with the btmgmt tool? I'd like
>> to have a look at it to find out the reason.
>
> Check the patch I just sent.

Nice. So in fact it was just invalid instance ids being used. What about 
the instance removal issue, did that materialize somehow?

Florian

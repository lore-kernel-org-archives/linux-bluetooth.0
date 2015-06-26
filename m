Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <558D4746.5020200@gmail.com>
References: <CAPyD+=CwiwARGqT-tKomaJ+o9O6tAiMJ25TiqxFuT2DDS+VKxQ@mail.gmail.com>
	<20150625111827.6196924d@tedd-fedora-vm>
	<CAPyD+=Ao6bc4o=sDDxZ9sb4hbVShXtWTfVFzOChw4k4iGoBSJQ@mail.gmail.com>
	<CABBYNZKLS-9pLxNLCJfb2OnapcX1rCqHgGoRg9gvkjnR0YcNHw@mail.gmail.com>
	<558D4404.6020500@gmail.com>
	<CABBYNZJWbtVT30M0EN6mScZQvkzU6JcoHTNPRQoTaR1URnX9vA@mail.gmail.com>
	<558D4746.5020200@gmail.com>
Date: Fri, 26 Jun 2015 15:40:51 +0300
Message-ID: <CABBYNZJmkeUXgv+FbWcygheiGAq5jaduqKfbfFS6OTAfucnz5A@mail.gmail.com>
Subject: Re: Unreliable LE advertisement registration through BlueZ
 advertising API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "jerico.dev" <jerico.dev@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

On Fri, Jun 26, 2015 at 3:36 PM, jerico.dev <jerico.dev@gmail.com> wrote:
>
>
> On 06/26/2015 02:28 PM, Luiz Augusto von Dentz wrote:
>>
>> Hi Florian,
>>
>> On Fri, Jun 26, 2015 at 3:22 PM, jerico.dev <jerico.dev@gmail.com> wrote:
>>>
>>> Hi Luiz,
>>>
>>>>>> Any way, once I run the example-advertisement script, I cannot run it
>>>>>> again until I restart the bleutooth daemon.
>>>>>> This is known issue.
>>>>>
>>>>>
>>>>>
>>>>> Okay, I'll keep digging.
>>>>
>>>>
>>>>
>>>> That is something in the kernel Im afraid, it doesn't seems to remove
>>>> the instances properly.
>>>
>>>
>>>
>>> is it possible to reproduce this bad behavior with the btmgmt tool? I'd
>>> like
>>> to have a look at it to find out the reason.
>>
>>
>> Check the patch I just sent.
>
>
> Nice. So in fact it was just invalid instance ids being used. What about the
> instance removal issue, did that materialize somehow?

It was not an issue actually, the instance is removed it just that the
userspace has to remember which id are available, Im not sure this is
a good idea though, it seems anyone can overwrite the instance id
adding its own data provided it has access to mgmt socket.


-- 
Luiz Augusto von Dentz

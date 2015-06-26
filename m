Return-Path: <cyrus@holtmann.org>
Message-ID: <558D4404.6020500@gmail.com>
Date: Fri, 26 Jun 2015 14:22:28 +0200
From: "jerico.dev" <jerico.dev@gmail.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Unreliable LE advertisement registration through BlueZ advertising
 API
References: <CAPyD+=CwiwARGqT-tKomaJ+o9O6tAiMJ25TiqxFuT2DDS+VKxQ@mail.gmail.com>	<20150625111827.6196924d@tedd-fedora-vm>	<CAPyD+=Ao6bc4o=sDDxZ9sb4hbVShXtWTfVFzOChw4k4iGoBSJQ@mail.gmail.com> <CABBYNZKLS-9pLxNLCJfb2OnapcX1rCqHgGoRg9gvkjnR0YcNHw@mail.gmail.com>
In-Reply-To: <CABBYNZKLS-9pLxNLCJfb2OnapcX1rCqHgGoRg9gvkjnR0YcNHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>> Any way, once I run the example-advertisement script, I cannot run it again until I restart the bleutooth daemon.
>>> This is known issue.
>>
>> Okay, I'll keep digging.
>
> That is something in the kernel Im afraid, it doesn't seems to remove
> the instances properly.

is it possible to reproduce this bad behavior with the btmgmt tool? I'd 
like to have a look at it to find out the reason.

Florian

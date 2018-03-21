Return-Path: <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20180321010527.GA16616@embeddedor.com>
 <8448C1B0-A2A9-4376-9CC3-7643F0FFC0FB@holtmann.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <7a8174a6-4f36-abf8-b15b-44c1f65b15f1@embeddedor.com>
Date: Wed, 21 Mar 2018 08:49:44 -0500
MIME-Version: 1.0
In-Reply-To: <8448C1B0-A2A9-4376-9CC3-7643F0FFC0FB@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>



On 03/21/2018 08:45 AM, Marcel Holtmann wrote:
> Hi Gustavo,
> 
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with dynamic memory allocation instead.
>>
>> The use of stack Variable Length Arrays needs to be avoided, as they
>> can be a vector for stack exhaustion, which can be both a runtime bug
>> or a security flaw. Also, in general, as code evolves it is easy to
>> lose track of how big a VLA can get. Thus, we can end up having runtime
>> failures that are hard to debug.
>>
>> Also, fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>> Changes in v2:
>> - Fix memory leak in previous patch.
>>
>> net/bluetooth/smp.c | 17 ++++++++++++-----
>> 1 file changed, 12 insertions(+), 5 deletions(-)
> 
> patch has been applied to bluetooth-next tree.
> 
> Regards
> 
> Marcel
> 

Awesome.

Thanks, Marcel.
--
Gustavo

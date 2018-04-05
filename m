Return-Path: <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20180321010527.GA16616@embeddedor.com>
 <3BD15121-532A-45E2-B62E-1008C0289500@holtmann.org>
 <2af25866-4e8a-7f9c-9298-e45abfab20c7@embeddedor.com>
 <347FC7F5-4BB3-4477-9EF1-BAAA98F1D107@holtmann.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b6336234-7eaa-27d6-3424-665f78033d9b@embeddedor.com>
Date: Thu, 5 Apr 2018 04:51:36 -0500
MIME-Version: 1.0
In-Reply-To: <347FC7F5-4BB3-4477-9EF1-BAAA98F1D107@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>



On 04/05/2018 03:46 AM, Marcel Holtmann wrote:

>> By the way, what is you opinion on replacing crypto_shash_descsize(ctx) with PAGE_SIZE / 8 in SHASH_DESC_ON_STACK?
>>
>> Does it work for you?
> 
> isn’t that just waste?
> 

Agree.

> The macro itself is this.
> 
> #define SHASH_DESC_ON_STACK(shash, ctx)                           \
>          char __##shash##_desc[sizeof(struct shash_desc) +         \
>                  crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
>          struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
> 
> For AES-CMAC, we could always do this with a manual macro that gives us the right size. However that is error prone if any internals change. I think what has to happened that crypto_shash_decsize becomes something the compiler can evaluate at compile time.
> 

Yeah. That would imply an analysis of the algorithm each of the callers 
use. In the case of AES-CMAC, what is the maximum digest size?

I tried to find a fixed-length value for AES-CMAC but I didn't get any 
output with git grep -n _DIGEST_SIZE | grep AES

Thanks
--
Gustavo

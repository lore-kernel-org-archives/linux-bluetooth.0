Return-Path: <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20180321010527.GA16616@embeddedor.com>
 <3BD15121-532A-45E2-B62E-1008C0289500@holtmann.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <2af25866-4e8a-7f9c-9298-e45abfab20c7@embeddedor.com>
Date: Thu, 5 Apr 2018 03:35:55 -0500
MIME-Version: 1.0
In-Reply-To: <3BD15121-532A-45E2-B62E-1008C0289500@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 04/05/2018 02:23 AM, Marcel Holtmann wrote:

> so I took this patch back out of bluetooth-next before sending the pull request. I think the discussion on how to fix SHASH_DESC_ON_STACK macro needs to complete first. Once that has concluded we can revisit if this patch is still needed or if another solution has been found. Same as with WiFi, these are not just one-shot calls where a memory allocation doesn’t matter. We need this for random address resolution and thus there can be many of the aes_cmac calls when seeing neighboring devices.
> 

Yeah. I agree.

Based on Herbert's response to the discussion about SHASH_DESC_ON_STACK 
https://lkml.org/lkml/2018/3/27/300

it seems it is feasible to fix that macro very easily. I will follow up 
on this.

By the way, what is you opinion on replacing crypto_shash_descsize(ctx) 
with PAGE_SIZE / 8 in SHASH_DESC_ON_STACK?

Does it work for you?

Thanks
--
Gustavo

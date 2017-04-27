Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: allocate data for kpp on heap
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1899161.UMzm0Rcsma@ix>
Date: Thu, 27 Apr 2017 12:30:32 +0200
Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <60E99099-4EB9-4DB6-AF06-22354A875D6B@holtmann.org>
References: <1493135987-2618-1-git-send-email-salvatore.benedetto@intel.com>
 <1899161.UMzm0Rcsma@ix>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>> Bluetooth would crash when computing ECDH keys with kpp
>> if VMAP_STACK is enabled. Fix by allocating data passed
>> to kpp on heap.
>> 
>> Fixes: 58771c1c ("Bluetooth: convert smp and selftest to crypto kpp
>> API")
>> Signed-off-by: Salvatore Benedetto <salvatore.benedetto@intel.com>
>> ---
>> net/bluetooth/ecdh_helper.c |  6 ++++--
>> net/bluetooth/selftest.c    | 16 +++++++++++-----
>> 2 files changed, 15 insertions(+), 7 deletions(-)
>> 
>> diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
>> index b6d9aa1..8018447 100644
>> --- a/net/bluetooth/ecdh_helper.c
>> +++ b/net/bluetooth/ecdh_helper.c
>> @@ -59,7 +59,7 @@ bool compute_ecdh_secret(const u8 public_key[64], const u8
>> private_key[32], struct ecdh p;
>> 	struct ecdh_completion result;
>> 	struct scatterlist src, dst;
>> -	u8 tmp[64];
>> +	u8 *tmp = kmalloc(64, GFP_KERNEL);
> 
> Should this be checked for null?

possible yes, how do other crypto users did this when they converted to VMAP_STACK support. We should do exactly the same as others did.

Regards

Marcel


Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423410E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637858; cv=none; b=QIODOxtopejERB2dPpaREbQIO6FuGxl9vjFU2YtE4t9o7pNeinFAs3FHX8dK2IF1mWQjGBHv9RSCIU6hTbcD1skOIFeZZwQD859YPH5ABK5V8/Trh43gHiX/hRydVdvYOotjzEXSQ0gvdz+ISpBNrwY6BSAiBczrPpR0TiG9458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637858; c=relaxed/simple;
	bh=iMquVi9choIkJjLf1YAvCgElQDRqj32XPrIJupcdXEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js9W1InUAOhY8nlQ3fW2AL5JPwNHmwyV0lPG0zQ8/RyagY/RxBz2jY1IrGzeF3HUU5/DVI3fiuk7/oJm/fW3lmLhx/0SeBP4s5UyVPpjFoShPkGeLtm252wk4EX+4rMWDqY1uKFXXxHu5XAu6aT3W/ZgatKvcTvwvsjTqmf0oHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CvmGgETw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CvmGgETw"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so951503a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 18:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1731637855; x=1732242655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaXOpBj87loeZ2zsjL0hh+1z03QAQErfUtdqSTsxwMw=;
        b=CvmGgETwE1drhJUsqitmh0rAGCQXdjKczqGt80h9QsZXT+RHmI47HoFUXQzKHJ67at
         vlnmNWpC8K3CdtRO7pZNcy2RpJhFyYov1WuEjzH43QHhVUn1Prg9c6SMKf6g6feeMnFF
         fgXYiH5pduzY6jvKK8YxtqzClzJt+LR9K4XCvad1CLtCuNq4+8wVhq6uo0dNshKAH2Vr
         AkpAJFRgCQUJeBNHjtK1H5OJFKVl20rrZnyyE131EXJyoLUeS6LKs1cUS+jg16TZQUN8
         nBi4EPbYVjmAX2LHMoJg4DxKEpb41XNJSAidl4EF5wZLhP0TbJ7yFRcJ2vqqCBG21pTm
         Vafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731637855; x=1732242655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaXOpBj87loeZ2zsjL0hh+1z03QAQErfUtdqSTsxwMw=;
        b=wnMATeoprFa4XtZxX6zSKAZH/2rsI4XqGW2OYVEcLBh+7xN/5gZYNMD/GpiyA8XMVk
         LuMS7ggBUy7k4G11rhwcSqePCuuTXeL9psq3PTmOQVpZOpuYqNwFCGHTGZwDENQieIc1
         0A1Pdt6hoopbylGHZGU8qqST1Ht1VDeWVi7QS8ja5y+Hs2h3pbu+LLOF2+ZN3ZO/K14o
         8J9fRgbABbaQrRLuJ8HdEaaasWO6vwSLMdRPaSMbm9ShJfU1FVo6mOUyKBs2F+HsBNPw
         uhNZC03T7+P/llDcPcrYq3n7EXdrVEju1x/4NFdHgEUB34F4wjQCnt6IMsiALMn5wnua
         8dAw==
X-Forwarded-Encrypted: i=1; AJvYcCUfqeWNpqBlG+shPLpBTShsI7KNFT2TFR2Mei6HSpLV+uXzGtxJ53eaD3umdr/8HEwJnj2jLVPrVt9uvKGdI8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRyLuclEB8aexl9K0M8QD90hZcbvwpa8KJpKylcTMCU/gSmkY
	0dDBCqeoQEloAG0J+Tm5aUKJ8cP/qrlmIVUjtVN9dlWoVADHGox7Jcik3VhZhsE=
X-Google-Smtp-Source: AGHT+IGmYzDpWpA2GVCwMs7w1OReL4VK06XcHWAw3RQaVC4cjRvbZKrqDaz2HxQ13e5u9Hy4V+/1eg==
X-Received: by 2002:a05:6a20:6a1a:b0:1db:f0e0:cfd with SMTP id adf61e73a8af0-1dc90c08d8dmr1481512637.44.1731637855560;
        Thu, 14 Nov 2024 18:30:55 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::5:db2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477139130sm341454b3a.85.2024.11.14.18.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 18:30:55 -0800 (PST)
Message-ID: <970c7945-3dc4-4f07-94d5-19080efb2f21@davidwei.uk>
Date: Thu, 14 Nov 2024 18:30:53 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] bluetooth: Improve setsockopt() handling of
 malformed user input
Content-Language: en-GB
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
 <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
 <156ce25b-4344-40cd-9c72-1a45e8f77b38@davidwei.uk>
 <CABBYNZLbR22cWaXA4YNwtE8=+VfdGYR5oN6TSJ-MwXCuP3=6hw@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CABBYNZLbR22cWaXA4YNwtE8=+VfdGYR5oN6TSJ-MwXCuP3=6hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-14 18:15, Luiz Augusto von Dentz wrote:
> Hi David,
> 
> On Thu, Nov 14, 2024 at 7:42 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-11-14 15:27, Michal Luczaj wrote:
>>> The bt_copy_from_sockptr() return value is being misinterpreted by most
>>> users: a non-zero result is mistakenly assumed to represent an error code,
>>> but actually indicates the number of bytes that could not be copied.
>>>
>>> Remove bt_copy_from_sockptr() and adapt callers to use
>>> copy_safe_from_sockptr().
>>>
>>> For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockptr() to
>>> scrub parts of uninitialized buffer.
>>>
>>> Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_old()
>>> and hci_sock_setsockopt().
>>>
>>> Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt user input")
>>> Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockopt user input")
>>> Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt user input")
>>> Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt user input")
>>> Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsockopt user input")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>>  include/net/bluetooth/bluetooth.h |  9 ---------
>>>  net/bluetooth/hci_sock.c          | 14 +++++++-------
>>>  net/bluetooth/iso.c               | 10 +++++-----
>>>  net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
>>>  net/bluetooth/rfcomm/sock.c       |  9 ++++-----
>>>  net/bluetooth/sco.c               | 11 ++++++-----
>>>  6 files changed, 33 insertions(+), 40 deletions(-)
>>>
>> ...
>>> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
>>> index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3ea9041770ede4f27b8 100644
>>> --- a/net/bluetooth/rfcomm/sock.c
>>> +++ b/net/bluetooth/rfcomm/sock.c
>>> @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
>>>
>>>       switch (optname) {
>>>       case RFCOMM_LM:
>>> -             if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
>>> -                     err = -EFAULT;
>>> +             err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
>>> +             if (err)
>>>                       break;
>>> -             }
>>
>> This will return a positive integer if copy_safe_from_sockptr() fails.
> 
> What are you talking about copy_safe_from_sockptr never returns a
> positive value:
> 
>  * Returns:
>  *  * -EINVAL: @optlen < @ksize
>  *  * -EFAULT: access to userspace failed.
>  *  * 0 : @ksize bytes were copied

Isn't this what this series is about? copy_from_sockptr() returns 0 on
success, or a positive integer for number of bytes NOT copied on error.
Patch 4 even updates the docs for copy_from_sockptr().

copy_safe_from_sockptr()
	-> copy_from_sockptr()
	-> copy_from_sockptr_offset()
	-> memcpy() for kernel to kernel OR
	-> copy_from_user() otherwise

And copy_from_user() follows the same 0 for success or N > 0 for
failure. It does not EFAULT on its own AFAIK.

The docs for copy_safe_from_sockptr() that you've linked contains the
exact misunderstanding that Michal is correcting.

> 
>> Shouldn't this be:
>>
>> err = -EFAULT;
>> if (copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen))
>>         break;
> 
> 
> 

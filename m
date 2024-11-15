Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD73D966
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639890; cv=none; b=sQwFsAjkMMSSSZqZHE+eAAHGayHrTXxqMsXWIFQziMLI7888jkJdjwcXFY//kbB0iOigyI/W5MjGph2/VdbqyExjBGvEEtHcm+UsdS0TRNN0xXUpjD/doEOUKHdjaVK4CPwsSgajrg99NCrJ2Iulg9uINSdnLciN5CTExK3Z8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639890; c=relaxed/simple;
	bh=V716P8zZ//kv1B/yK/7tTukzKZaPZtXLXcL6pNiw8MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T921qxtprAYx5u9YOyK3lp33tUFJZ5wp68KRNJFkr15B5PQSXPirC59cJTSOurXU6F9M4LKyh+o/SRlVyMxDZWqxQNujbSMcegmlJIviXu2jg7CSxFl3dlJaYHGv31vTilV88zYMp1KYcLLfChG9CA4P1gLWCSqaxLIXPF6ZQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=UHWJELLh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="UHWJELLh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdda5cfb6so2066535ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 19:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1731639888; x=1732244688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8MqYZvSWZEzxTRKfOnM5EWeCJU1PM/6TpfvqTM2kCbM=;
        b=UHWJELLhh3DSkQ3pLA70WuwlCX0aIxqn1qL/t6dpBQ6tcOVXGUGX+XwB83JTO3kiyS
         93KagMVx/SVaSHw1KT2cjvXCQwvVaiOO9GPy0wxBIf093eon45aCyF6uweSnGYgvKhuw
         6J7IqoIloUi0TrD4+9ozqsrYHy+dW/4urb8EqrAx5L3UbRGz0PVVGA1X2UuGtHeYctAR
         +tm3GAeRqZ3bCarX7QuLKDmABWftt+DDC0y6p7wVVqWqzE/SAYehGpM4pk/rU10Wjsdj
         usJP0tqv9JEshmA3ixROU1lPriBXhNtvTiITFOWrpq/qHjhb8gnTgmLPDQWNpdsU+8sd
         DPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731639888; x=1732244688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MqYZvSWZEzxTRKfOnM5EWeCJU1PM/6TpfvqTM2kCbM=;
        b=KRVFq3bXc+O1TvuwcqrnM8CKRxkEt6bJk4LdWkUIT2OcUhJW2Pm+cuFiy41T7XH5DP
         Jl6GPxQLTO6Heq+1MLIlKV9GYwCQmgOjr56E2ScIpIN5yywfmeXK8h9lFzeJq1Sqb/eS
         eIQiRzt2sFYGkHv0Kmy+fCcdZpqj41EPBJo4G98V3OuRQuq70tPmIp8n8O4eyVPdR9ac
         q3LyegiOweg/XTcBkqcDJT4LCIKKamhwupJaGpnjioPG1ytz3zzqXzju2yLJE140DyhS
         apbPmD3K34HXdQyGeV1ZAZQJnGUSvHejmxPr+eoBS7gY1HFUh/s/uSjGpozTfVWTpzGP
         8YjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqeoUBbnzUD2lEpoUemg9TDA2Y7l1IHbfCDlL+t/5eDhzMOYRq17AsYu8z3EWOUmEGGLTdp5LbVE9PNSzCU1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVzB0snnvE3sWUVAqhd9IRcOkKbirYyQWOUDH3vKIlejFiEvC
	jlnzCtzHrE6/7XoxwlFjaBXRvnAqzgC66Ig97PnjOm46e2+1g7ot2/Aw/phghEY=
X-Google-Smtp-Source: AGHT+IGDq3TWintd3l7M/xrk1/Sdmp0H5dtDcPw5jhWZ/Cpp3whK9v98+GiYtk80xIdMvVwCNhZ/OQ==
X-Received: by 2002:a17:902:da92:b0:20c:5c6b:2eac with SMTP id d9443c01a7336-211d0ecfb07mr14912765ad.49.1731639888546;
        Thu, 14 Nov 2024 19:04:48 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::5:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f54d5bsm3360945ad.241.2024.11.14.19.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 19:04:48 -0800 (PST)
Message-ID: <4292b59f-7956-4c37-8909-ecb2261687b1@davidwei.uk>
Date: Thu, 14 Nov 2024 19:04:46 -0800
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
 <970c7945-3dc4-4f07-94d5-19080efb2f21@davidwei.uk>
 <CABBYNZL_awaZOKpsAyOaAbtnJLobJ1bQpF_9JNxpiyQg5P5q1Q@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CABBYNZL_awaZOKpsAyOaAbtnJLobJ1bQpF_9JNxpiyQg5P5q1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-14 18:50, Luiz Augusto von Dentz wrote:
> Hi David,
> 
> On Thu, Nov 14, 2024 at 9:30 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-11-14 18:15, Luiz Augusto von Dentz wrote:
>>> Hi David,
>>>
>>> On Thu, Nov 14, 2024 at 7:42 PM David Wei <dw@davidwei.uk> wrote:
>>>>
>>>> On 2024-11-14 15:27, Michal Luczaj wrote:
>>>>> The bt_copy_from_sockptr() return value is being misinterpreted by most
>>>>> users: a non-zero result is mistakenly assumed to represent an error code,
>>>>> but actually indicates the number of bytes that could not be copied.
>>>>>
>>>>> Remove bt_copy_from_sockptr() and adapt callers to use
>>>>> copy_safe_from_sockptr().
>>>>>
>>>>> For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockptr() to
>>>>> scrub parts of uninitialized buffer.
>>>>>
>>>>> Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_old()
>>>>> and hci_sock_setsockopt().
>>>>>
>>>>> Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt user input")
>>>>> Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockopt user input")
>>>>> Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt user input")
>>>>> Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt user input")
>>>>> Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsockopt user input")
>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>> ---
>>>>>  include/net/bluetooth/bluetooth.h |  9 ---------
>>>>>  net/bluetooth/hci_sock.c          | 14 +++++++-------
>>>>>  net/bluetooth/iso.c               | 10 +++++-----
>>>>>  net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
>>>>>  net/bluetooth/rfcomm/sock.c       |  9 ++++-----
>>>>>  net/bluetooth/sco.c               | 11 ++++++-----
>>>>>  6 files changed, 33 insertions(+), 40 deletions(-)
>>>>>
>>>> ...
>>>>> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
>>>>> index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3ea9041770ede4f27b8 100644
>>>>> --- a/net/bluetooth/rfcomm/sock.c
>>>>> +++ b/net/bluetooth/rfcomm/sock.c
>>>>> @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
>>>>>
>>>>>       switch (optname) {
>>>>>       case RFCOMM_LM:
>>>>> -             if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
>>>>> -                     err = -EFAULT;
>>>>> +             err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
>>>>> +             if (err)
>>>>>                       break;
>>>>> -             }
>>>>
>>>> This will return a positive integer if copy_safe_from_sockptr() fails.
>>>
>>> What are you talking about copy_safe_from_sockptr never returns a
>>> positive value:
>>>
>>>  * Returns:
>>>  *  * -EINVAL: @optlen < @ksize
>>>  *  * -EFAULT: access to userspace failed.
>>>  *  * 0 : @ksize bytes were copied
>>
>> Isn't this what this series is about? copy_from_sockptr() returns 0 on
>> success, or a positive integer for number of bytes NOT copied on error.
>> Patch 4 even updates the docs for copy_from_sockptr().
>>
>> copy_safe_from_sockptr()
>>         -> copy_from_sockptr()
>>         -> copy_from_sockptr_offset()
>>         -> memcpy() for kernel to kernel OR
>>         -> copy_from_user() otherwise
> 
> Well except the safe version does check what would otherwise cause a
> positive return by the likes of copy_from_user and returns -EINVAL
> instead, otherwise the documentation of copy_safe_from_sockptr is just
> wrong and shall state that it could return positive as well but I
> guess that would just make it as inconvenient so we might as well
> detect when a positive value would be returned just return -EFAULT
> instead.

Yes it checks and returns EINVAL, but not EFAULT which is what my
comment on the original patch is about. Most of the calls to
bt_copy_from_sockptr() that Michal replaced with
copy_safe_from_sockptr() remain incorrect because it is assumed that
EFAULT is returned. Only rfcomm_sock_setsockopt_old() was vaguely doing
the right thing and the patch changed it back to the incorrect pattern:

err = copy_safe_from_sockptr(...);
if (err)
	break;

But I do agree that making copy_safe_from_sockptr() do the right thing
and EFAULT will be easier and prevent future problems given that
copy_from_sockptr() is meant to be deprecated anyhow.

> 
>> And copy_from_user() follows the same 0 for success or N > 0 for
>> failure. It does not EFAULT on its own AFAIK.
>>
>> The docs for copy_safe_from_sockptr() that you've linked contains the
>> exact misunderstanding that Michal is correcting.
>>
>>>
>>>> Shouldn't this be:
>>>>
>>>> err = -EFAULT;
>>>> if (copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen))
>>>>         break;
>>>
>>>
>>>
> 
> 
> 

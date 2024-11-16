Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD75227
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Nov 2024 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716616; cv=none; b=cfIfY2PSBzeWbkgfQjstRojxN8JTKy7KTLVTGE73ZwZ/Z39L07Z3TL4vbveuaCc5lBgDQiKn48bOg6Cf547yYURIMmr/MzxbcZKpeChRXomw0ZUlcMDkxtR4GhsCzWO0r0/xNcHFGnJrrqMHFKNSnteSl5BuRqbLxsBCYENgIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716616; c=relaxed/simple;
	bh=JHjYbyuXvlHLZZewgCnEEwRmKMcy0SlmUIcpWHs0BPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrhsbsF9g8jCzkuNRTXnPfWkjB58Udw6pHmrdT9GIeNa5K45nLaI9pLxkVs1xwFRvqzWGetfU2lmdDaE+YJLjc0acG4Wsn+2n1tfbaCLOZhtXywfReQag1g2+IFvuRXQxpneFJeyAZZqAZjVNd3xrFyKXLlpKPqagllP10lr+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=giStubcr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="giStubcr"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7240d93fffdso1092976b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 16:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1731716612; x=1732321412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ULbS/hpYsvRo0TIPldUC1cfxLOZl+GUWBs9UxV2jrCE=;
        b=giStubcrHYVTCCv8c8ZxfNmPFKOOG01OEVVKfGRLapmnYvswQ3NOtpGuY8qUKvfT1i
         YpikA2nL0W8WvCPK5j8Sv2N5fZcr45ItHMQb48AqTJUqku4bsKcODWUjyaHegu6JbBTi
         rCS9887dmFZddlFYGT5KQCXOftSDm8iM1cGKjdwfnjJSVZaNx3kypgvL4lm3goWhZ8Y/
         JyeP72Ngbu+CH65NKyi9r9xWlBI+7D+1XNEiJEm8decYK1VbmhZW1BmFwIs3sLMBPDTp
         R6dB0vb1NCBCP2c7/lfNPP8iV72ApUSPlzGFeJqe4cwIiQVP9ygwC4HTKstZr+c9f8BA
         aUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731716612; x=1732321412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULbS/hpYsvRo0TIPldUC1cfxLOZl+GUWBs9UxV2jrCE=;
        b=Psgt5ShvUjUxJboCBsiyjlS89iuzAAqDAuCoTL32spfLGDnm9cjW9RUms0K7jEsXxw
         EjWOVvGfQvG7ovgMsaOBNLX2ZYjDTI2Ry7wQJFixmcPjUEobQgOSuCGCUeagPgB5p5qB
         4l/B9YyisebCn13/WyOvupYEneS0GNqxKpYFRCmubIKccnGxdIxC+IWVaZ+FB08yLKj1
         I4B/WGnLBPxX7IifY0VvMZMbNZu37V8n4wWeeJTvU1B2TVk5QbK5sKE1R0YGuSU+70Kj
         USY8Ws1kwfRQeAJdGNiipp7QZtcJDZnJTSwmId2L+aEHLD/+JmqD+svgv29byfGSFDhA
         V+lA==
X-Forwarded-Encrypted: i=1; AJvYcCXkVo8mdNdzfkrKTa6CfFjcJaIKXeXb7StDcNgUOI2hvMAaf42Y1NamDU8AKQHaoistKJ4wRv3mAuc2DMRHp7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhbVgk7kjIx1szFhwi0ZPgTGZNJcL6CJiSSIq+LQdBJb4+Eg5Q
	tCGXB+CYJgh+jbo97TtmHfdv3Q7/bP3b7FAnWYpGjVwUDtaoktHARgXBMmVTdSo=
X-Google-Smtp-Source: AGHT+IGS+OSUkrh/ZOU7NJRo8z/Ff9XeU5b3tiqT/w306XrjbJk+iIYeORLW8IwMPXBfl3KSdX4PiQ==
X-Received: by 2002:a05:6a00:238b:b0:71e:8049:4730 with SMTP id d2e1a72fcca58-72476b72171mr6448191b3a.3.1731716611056;
        Fri, 15 Nov 2024 16:23:31 -0800 (PST)
Received: from [192.168.1.10] (71-212-14-56.tukw.qwest.net. [71.212.14.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247713517csm1992167b3a.82.2024.11.15.16.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 16:23:30 -0800 (PST)
Message-ID: <5d852741-0514-49c2-9c00-ec46860bbaf6@davidwei.uk>
Date: Fri, 15 Nov 2024 16:23:29 -0800
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
To: Michal Luczaj <mhal@rbox.co>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
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
 <4292b59f-7956-4c37-8909-ecb2261687b1@davidwei.uk>
 <02c01b54-ad82-4ae0-b4fd-db1b7687efa0@rbox.co>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <02c01b54-ad82-4ae0-b4fd-db1b7687efa0@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-15 00:31, Michal Luczaj wrote:
> On 11/15/24 04:04, David Wei wrote:
>> On 2024-11-14 18:50, Luiz Augusto von Dentz wrote:
>>> Hi David,
>>> On Thu, Nov 14, 2024 at 9:30 PM David Wei <dw@davidwei.uk> wrote:
>>>> On 2024-11-14 18:15, Luiz Augusto von Dentz wrote:
>>>>> Hi David,
>>>>> On Thu, Nov 14, 2024 at 7:42 PM David Wei <dw@davidwei.uk> wrote:
>>>>>> On 2024-11-14 15:27, Michal Luczaj wrote:
>>>>>> ...
>>>>>>> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
>>>>>>> index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3ea9041770ede4f27b8 100644
>>>>>>> --- a/net/bluetooth/rfcomm/sock.c
>>>>>>> +++ b/net/bluetooth/rfcomm/sock.c
>>>>>>> @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
>>>>>>>
>>>>>>>       switch (optname) {
>>>>>>>       case RFCOMM_LM:
>>>>>>> -             if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
>>>>>>> -                     err = -EFAULT;
>>>>>>> +             err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
>>>>>>> +             if (err)
>>>>>>>                       break;
>>>>>>> -             }
>>>>>>
>>>>>> This will return a positive integer if copy_safe_from_sockptr() fails.
>>>>>
>>>>> What are you talking about copy_safe_from_sockptr never returns a
>>>>> positive value:
>>>>>
>>>>>  * Returns:
>>>>>  *  * -EINVAL: @optlen < @ksize
>>>>>  *  * -EFAULT: access to userspace failed.
>>>>>  *  * 0 : @ksize bytes were copied
>>>>
>>>> Isn't this what this series is about? copy_from_sockptr() returns 0 on
>>>> success, or a positive integer for number of bytes NOT copied on error.
>>>> Patch 4 even updates the docs for copy_from_sockptr().
>>>>
>>>> copy_safe_from_sockptr()
>>>>         -> copy_from_sockptr()
>>>>         -> copy_from_sockptr_offset()
>>>>         -> memcpy() for kernel to kernel OR
>>>>         -> copy_from_user() otherwise
>>>
>>> Well except the safe version does check what would otherwise cause a
>>> positive return by the likes of copy_from_user and returns -EINVAL
>>> instead, otherwise the documentation of copy_safe_from_sockptr is just
>>> wrong and shall state that it could return positive as well but I
>>> guess that would just make it as inconvenient so we might as well
>>> detect when a positive value would be returned just return -EFAULT
>>> instead.
>>
>> Yes it checks and returns EINVAL, but not EFAULT which is what my
>> comment on the original patch is about. Most of the calls to
>> bt_copy_from_sockptr() that Michal replaced with
>> copy_safe_from_sockptr() remain incorrect because it is assumed that
>> EFAULT is returned. Only rfcomm_sock_setsockopt_old() was vaguely doing
>> the right thing and the patch changed it back to the incorrect pattern:
>>
>> err = copy_safe_from_sockptr(...);
>> if (err)
>> 	break;
>>
>> But I do agree that making copy_safe_from_sockptr() do the right thing
>> and EFAULT will be easier and prevent future problems given that
>> copy_from_sockptr() is meant to be deprecated anyhow.
> 
> Just to be clear: copy_safe_from_sockptr() was recently fixed to return
> EFAULT:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eb94b7bb1010
> Sorry, I should have mentioned this series is a follow up to that patch.

I missed that, sorry. In which case this patch looks good.

Reviewed-by: David Wei <dw@davidwei.uk>

> 
> Thanks,
> Michal
> 

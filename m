Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412571CF8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731638621; cv=none; b=bYsh0AY9oem3Vm4tmmcftyTZJV3T/E5EpW+UWGMgTEupTtrR1VDzIczHCxlxhDtaXPwVkzlnglfCJYpwzkvRwEMK3HuVgkj2mHc/NKAT+IB50AiRi9Uf63YedLqzlvfrqn/1rDBrhvt3JNw3ZcyzMiJwWsWyeqZoJJZtBVlaK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731638621; c=relaxed/simple;
	bh=0Jz8XKYskX+2p0e/euVme6pdahK2zNMLc9N16Rpb7x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgNkMVtdA3HZJd/MJCvpM+6I5jYgxJeMMqKGfK5SWWkbY05xVSwKX3bb4mZTcnk2PlPkoC3qLnpwWcdhnc72SZ9zJhq7A+Q1I5yU5suXDi6w2Un5YruZlxv74CBpty9kUidYaHcX3h32PDoJs37oaoHOhB4a4h+WouvCtSjWthc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=cxSOglwu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="cxSOglwu"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so1024399b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 18:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1731638619; x=1732243419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1Lhh0DpW4WR6Dx6ZPrJHJSg0IKOPZ7IXqU4uvUXc7s=;
        b=cxSOglwui5QeWUzpncgiAYcszO0bdpIaNTFoupjwmoa2rwmlkuJIC+KED35sT0gJt6
         bjzugXWyjkWsTqHUyPg45Smr7MLETxmQie5YumaAM4EdpNHb4zRTdNkqbhFs7mEuLk5H
         LAFBpBTrYDSryOAv9oDBzGtFNNJHbjpTM3uZVss8tJt9X6mUUVCxXlPqYAG+nY8VFbhj
         0KvHAEDSYJSZsXXagD45KFemug3Ro3jhKHjx+BiKDGP4zAtaSa621+mYavJC+TG7stXy
         GahCqx0kRdwuKBQTzyvlHHjSnbXAO6x/gQvA5/ZtEIApW5Zier6SmXVJrucfDZlvA2GU
         nc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731638619; x=1732243419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1Lhh0DpW4WR6Dx6ZPrJHJSg0IKOPZ7IXqU4uvUXc7s=;
        b=Exjjn+L5XJ1MF4ZrfHC3zU7rmbWTOKXfKUngZ1hFdbIeNmR8aEiw40g2HtxV1YcP6x
         IQBzG6bvIa6KCDDg7ib8eIXvL206wa6ThC0QMJwwnY+UpxhztDvLy/Dr2BeGxFwDTBRV
         8snigjgdhnK7yEf5OO2U/mwKjjaGfl91Dz/66T037ROTkjxKGQ3JgLmB0tIUaU/TNjBO
         wwJHkspNHlO/IsVsVcqabfhr4+7aqVwcvYGWZAYkYEvz49ACUS/dy1VQA4BgPadtP5fO
         4oG/bzkmpDBPN34dRgUx4LqKU8AXUkBGXKMF4qsrr8enHwX008RGYVm8anrhIY+hNvgf
         8t2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU35DpTcp6muPZOALrKB5FgZKaBQvltXq5bKZLa+Vjzk34B+dO6//dQSgDVMgpYzC0mzePcEn8PvtSWpEBW5zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfHplU8urC0FhyZw4Qm5PeBdDeMcHIoZSt9W9RJOIpnyZMZWrP
	rxBNNwtEnZJrb7ddG6XlXGS26Jhelh9LnabywoxS7YLTqcRtwNKkrsYKV/1dgsg=
X-Google-Smtp-Source: AGHT+IGF90XZC7tXrmioO0CbsJ457UP9v3N7eyd59x6hjEcyJ4D+fOWs4xD42yc5ly4Xbhg3q8oVrw==
X-Received: by 2002:a05:6a00:cc2:b0:70d:265a:eec6 with SMTP id d2e1a72fcca58-72476bb89bemr1691745b3a.13.1731638619412;
        Thu, 14 Nov 2024 18:43:39 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::5:db2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee82asm363559b3a.30.2024.11.14.18.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 18:43:38 -0800 (PST)
Message-ID: <f8d09aa1-b83d-4eaa-8202-b8cb6979d85f@davidwei.uk>
Date: Thu, 14 Nov 2024 18:43:37 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net: Comment copy_from_sockptr() explaining its
 behaviour
Content-Language: en-GB
To: Michal Luczaj <mhal@rbox.co>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 David Wei <dw@davidwei.uk>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
 <20241115-sockptr-copy-fixes-v1-4-d183c87fcbd5@rbox.co>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-4-d183c87fcbd5@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-14 15:27, Michal Luczaj wrote:
> copy_from_sockptr() has a history of misuse. Add a comment explaining that
> the function follows API of copy_from_user(), i.e. returns 0 for success,
> or number of bytes not copied on error.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  include/linux/sockptr.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
> index 195debe2b1dbc5abf768aa806eb6c73b99421e27..3e6c8e9d67aef66e8ac5a4e474c278ac08244163 100644
> --- a/include/linux/sockptr.h
> +++ b/include/linux/sockptr.h
> @@ -53,6 +53,8 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
>  /* Deprecated.
>   * This is unsafe, unless caller checked user provided optlen.
>   * Prefer copy_safe_from_sockptr() instead.
> + *
> + * Returns 0 for success, or number of bytes not copied on error.
>   */
>  static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
>  {
> 

In addition to this, please update the docs for copy_safe_from_sockptr()
that calls into copy_from_sockptr() which also contains the
misunderstanding of what copy_from_sockptr() returns.

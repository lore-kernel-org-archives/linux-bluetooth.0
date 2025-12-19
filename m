Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB422E8DEF
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135470; cv=none; b=LGEFFmWYiDdRA6DkyUGexLSRO4ePooTY3DxeexzDHxsA6FBaEg9C+VkUkt8Nf6VsvyqDZIKcP6mzVZCG9Vv5IEbp4xbMSgxn7k8nUbXmxiDNbnGOv9okr4ehHdnKp2veWq7psSZSoFhzDXmFCBKNxKe7nY+7juwfgk8FmICIqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135470; c=relaxed/simple;
	bh=0yATwB01TFt/wQCHC804x0H6IbpC3LjdC/VK8/8pC7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fk4XNMG7Tna/vs3OPa44nfEqvwkwxRUSQzKDJd/mxOBWY5YKgf2XTciPv6IYF2Q7Itrg6Hzy5MvOJvspNHMPGMfXJewa86ge8GORnnF3BAh3Rv9Q9TQv5Wmc7Ry6mCre+Gv4WUDIg45KK8UQmH4fCY7gWqVzgBAhty3HyUhPqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgMaCIdc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oLiC8hJw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgMaCIdc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oLiC8hJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766135466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Om6/72JV9hfGA/7FLAPjcSWYj9oKZvBkTHrUaiBphM=;
	b=BgMaCIdcwn7nwfedTK22QKKoaWl6V1aRjseXqTS+tO8rofaIoSWsoLlgsrWADCsHFNzEQg
	XjCHb1bXREuohC8P0t69y3UZVvOFZLYyvjn21hMGmK/LCq/ITwWxXLZPonBpGJBuznuXyQ
	QD63NuWySWC8znbuzkjv8ExdoyRTdds=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-Cxp94vdfN4e2e4-0m_2QLA-1; Fri, 19 Dec 2025 04:11:05 -0500
X-MC-Unique: Cxp94vdfN4e2e4-0m_2QLA-1
X-Mimecast-MFC-AGG-ID: Cxp94vdfN4e2e4-0m_2QLA_1766135464
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-37a2d8cc3d3so12416211fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 01:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766135464; x=1766740264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Om6/72JV9hfGA/7FLAPjcSWYj9oKZvBkTHrUaiBphM=;
        b=oLiC8hJwZVhel5VbdjemoCntx7qj9sWvBAjpLRrh51wlgmCMfsS26HLsyNwKNYBMqe
         dIe9URxcvbrcTA3cc5tK9qErqagucwsWRJoWUoQlKU6WxlVsTAicMe3ZJZu0eInYWefs
         n81jjDuW9Cs8lNxWBrPdFkQrUqvDztn7Tv+/8LVvDwzS4CNA2NCiQTBXV4sks05ZyOfZ
         nshMRGoAsSKIucwaXogLX1XK9Bx6TE+OKv1BtR0+mcYw6bB04tFsZWczuCa0XkrUjrEH
         lRl0SA7cl1wbHCa2lzcW5dFKmpsJfJ8DZVPBufZC3ONMnu3h1lkL/rgzR4hR5Kj9MbPM
         duSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135464; x=1766740264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Om6/72JV9hfGA/7FLAPjcSWYj9oKZvBkTHrUaiBphM=;
        b=iVTCFUUnj8rBWd05Nb2L2zP1UhlVpnWbYfR5Y8tpUf2ELHd+riHki/CRT5j/5woh9K
         7qKUCMqu2U6B5CjGd0jUkaxWUbvM2inlOh7zmVKix76ZWZJ9BzJTfE7B+sauCgFwWlJz
         Wiz6c5aK6GhujrwPMvVKit5mzyTcnFKSnmnIJ91Vg3dJBm5T26sAeXNurca8ICWSPIrx
         AZ5zocb6leMOnru5p7nsTKlw27TaOPa7WTkTNJWdWX8J1HWz8bKSR3zkFitQSav/r+ry
         QrEDXUVVqSc4P8sfvn540YO/HRXjNB4dpa/J6aBWzJqNGKfhgDykExsGhUijJFSI1ZsN
         1zbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpBBgIhE2vzY3/h2zhy+NkdAWEzRJSEdm5A3NPY206rbhxQb+nS8BXt9z4OX2MNlKdNgxJbeMRL7thotZsClw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHRyfIJ+lCN6AkL3NXINuJSbrQPq5Yh1GcBaUy69ETmNR/RE1
	RAf/Uq2v7UZaNmDbM3G1AdpadugFDbb+9ZXWTa8i4t2/u4usmao4sAhI2RD8HWaNVG6wz30XlBb
	tVFbqiNeUGuvwxMgw2WLoExhIYFdefKzPwz7lcI85yxQv6kT31y3URoDWPiNzTHc70/tkciCfmv
	V1YA==
X-Gm-Gg: AY/fxX6RLkJRj9kZjxH1hrMa4NkhKnHRkexf1dRu+v9hzgeJ+EGB6toh54vLr4rxuDQ
	EEnXS4PxJ2jGT9MUZZu39L4XB0iFkfUoELgHCIgIOsIdaGzR+Nvt/RIZnOlPp1zlVm3R5fDStVz
	6OYkSi7xhhNuUwtMTzO6jKy89nE7udAYAD+fA1jFVKwNlawpM2xAkx8DKxv/dpyJ1b+WPdfclWi
	cGoIz4pcHnKKTHy3unyQmHbEqLNEafN43IafjkbS8lab5LXbw/0ZP+fji8dY0iDYRuRlVemLX4H
	Gfj66u4I9P98JZusBXZ+kpNr0LnPswchUXyAH6IHR09WWDM2lVCphvmr3S/n/cGT3KhZ5rg5FFu
	IcOmtEJ+HrVO3
X-Received: by 2002:a05:6512:e9c:b0:59a:1880:be02 with SMTP id 2adb3069b0e04-59a1880bebbmr746542e87.18.1766135462396;
        Fri, 19 Dec 2025 01:11:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOHKupkXY6JdkumSJGECsgvNJ/mF/3IBCldRikCxb80MSF0D+ZFew9zj5JSimCQjivA2qIDQ==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47d18be89d5mr26503065e9.17.1766135043549;
        Fri, 19 Dec 2025 01:04:03 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm85354455e9.4.2025.12.19.01.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:04:03 -0800 (PST)
Message-ID: <e1f053a7-791d-4433-b7ba-ea17a03ddfa7@redhat.com>
Date: Fri, 19 Dec 2025 10:04:01 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Add LE Channel Sounding HCI
 Command/event structures
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: anubhavg@qti.qualcomm.com, mohamull@qti.qualcomm.com,
 hbandi@qti.qualcomm.com, Simon Horman <horms@kernel.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251217112523.2671279-1-naga.akella@oss.qualcomm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251217112523.2671279-1-naga.akella@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 12:25 PM, Naga Bhavani Akella wrote:
> 1. Implement LE Event Mask to include events required for
>    LE Channel Sounding
> 2. Enable Channel Sounding feature bit in the
>    LE Host Supported Features command
> 3. Define HCI command and event structures necessary for
>    LE Channel Sounding functionality
> 
> Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>

FYI, Jakub enabled automated AI review on the netdev CI, and the bot
found something suspicious in this patch, see:

https://netdev-ai.bots.linux.dev/ai-review.html?id=999e331e-1161-4eec-ad26-fafc3fea6cfd

I'm blindly forwarding the info, please have a look and evaluate it. Any
feedback in case of false positive would be useful!

Thanks,

Paolo


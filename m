Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818D20485B
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747462; cv=none; b=r+EkZxJe+Owa6Zg1qbTuxH+r72nmDLe25ZOpbfQnsoVggf4EIz/qUvOiqoVbiQrCga8Mneu3ARBcNeWOA2PvrZS6AvSnKhqeWZUcTZtvM+u3byZjGeinFnlospdrGBSCZBnZRnOb8G3NV40q2InHZpO4PT9F0/kdsjiu+dPjEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747462; c=relaxed/simple;
	bh=NBt8jkLPn4GumDkHjCWKpe0G2W6zlI3FqivQA32cb7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GugCTPwOR9nOYwyo0IqU43PXPoKwD68xNFIv3ruOIKBv2xIjMIMJoE6pXk8cKjpIQhGvSOSQXxw/ceIJt6DPoTZMIts5MQWZ1YccLSscnB4k7LKl91zDl1gCG/KwW0pKjMKgpDlO6gPcM41hVnOc0WgAwzB9cmtV338T9KpPE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoWr7Etb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoWr7Etb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752747459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dA83DHVfeNFVTjWP8lzcP6NpqW8OSKmbcKpzsEz/UVw=;
	b=LoWr7Etb227m8Ag/NHj8RMpOH6HtH8xCs58wZjtkxXAIzc3+HlC24cqabZ2UesySeIYzeT
	AqQ9V9y91ISqkTsBiFQK4cB2eqQR5EZTMcuvqOsRR0L3/PQl0bu3DhRaY6ZPKuSg7IRkVG
	iMMQC91Y4vHMWlHYTv0HaLmnzQCP0Bo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-dflr5g7AMx23NdjlNobfRg-1; Thu, 17 Jul 2025 06:17:38 -0400
X-MC-Unique: dflr5g7AMx23NdjlNobfRg-1
X-Mimecast-MFC-AGG-ID: dflr5g7AMx23NdjlNobfRg_1752747457
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a503f28b09so470119f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 03:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752747457; x=1753352257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA83DHVfeNFVTjWP8lzcP6NpqW8OSKmbcKpzsEz/UVw=;
        b=WMjsHpMHXfQK2qbJyWoEMQIhXDy+9UQqf8dlTvGa0zhxKqD4ZUg53cw55yJtP6GKvE
         BNuzdpjKe90hhQKfxmd4U45LbtF18IazT6hZoj3RY97TVmI7yCwkFmHyFa9fFPttM8oh
         ZXeFcNqhIWG9B7AmdDUTPk9MtLTsaR44lyfksUtfBe73IKihDZOC8EXSyrmQV78O+Pig
         SPXs/OAyQhjJbkRP09Z082MmUaQaPlOv5sBXNY5iH7ptw3F5Z7H74bZUkpgmgzTG130M
         pTAstddKTmYM9kkRmj3Bh+vjkwJ0f8zGr6naKPqedqYEUwu/hgmKp7lVeiOAInwLrmu2
         0qEw==
X-Gm-Message-State: AOJu0YxzbUxEns3iRMOHz7WDXIrLFLBxLKSgetKban60Hocva7SEfSGq
	FV8wdSF1zf7ObBALsQ+GQb/jrc3nAal4vedBudPTrimVZTEpfzPxk3FC9cafp3VEE0Mjjr5aGo1
	DXeVCXu6hL5ii2V4Uw5kJf5sO/SzGYCSC1fHlKTkyGEKzFtUUT6ytBYJtg8IgeCJFu8l1POXk80
	3Htw==
X-Gm-Gg: ASbGncvrITA1ptv0US0jLF0EjKc5amzb0j1sQeXaK5xBz+wHrW6OB7MobvX7sNbOZTn
	R8LR8S+Be9wMkYhZ0aU6V7/SQAio67DQ5JGpmrkVsuj3S5t1h5+PGfW1OzW7nIozbtb985Zc1z8
	dPl1KHpwqmNguzd8CixUW2G5bQPy/tYAXGPYguvQaBkcEI4nf2Eivz3W5mGfJUj3CqzHuqWxVzh
	xmFoXZSny9NZc9FlRv4LTEmbrtoKtjsXY6dJ5oxO7n6HSwO9x4O09WvlEXp2xAyvtnDM8WYJ77D
	3IorPL6vIM3nDNQ5WL3GKdVM71McaIlWPQW0qkToMDDQuqkabhPs1KdqTsowjH/MCQ67Srh2YAC
	up2mqsymziqM=
X-Received: by 2002:a05:6000:2dc3:b0:3b6:d6c:efb6 with SMTP id ffacd0b85a97d-3b6139c9ff4mr2311896f8f.2.1752747456989;
        Thu, 17 Jul 2025 03:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ4nb+S2fBLt8jwcH+8MZT/7FPHYdOWtKr0hVaFs8ec14pMlJS9OgTkny4GDrN/HFFLoToFw==
X-Received: by 2002:a05:6000:2dc3:b0:3b6:d6c:efb6 with SMTP id ffacd0b85a97d-3b6139c9ff4mr2311876f8f.2.1752747456571;
        Thu, 17 Jul 2025 03:17:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1833sm19831179f8f.8.2025.07.17.03.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:17:36 -0700 (PDT)
Message-ID: <7d445ce0-bf96-441d-8fd9-2ed6b0206b4f@redhat.com>
Date: Thu, 17 Jul 2025 12:17:34 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2025-07-16
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20250716195124.414683-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250716195124.414683-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 9:51 PM, Luiz Augusto von Dentz wrote:
> The following changes since commit dae7f9cbd1909de2b0bccc30afef95c23f93e477:
> 
>   Merge branch 'mptcp-fix-fallback-related-races' (2025-07-15 17:31:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-07-16
> 
> for you to fetch changes up to c76d958c3a42de72b3ec1813b5a5fd4206f9f350:
> 
>   Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU (2025-07-16 15:38:31 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - hci_sync: fix connectable extended advertising when using static random address
>  - hci_core: fix typos in macros
>  - hci_core: add missing braces when using macro parameters
>  - hci_core: replace 'quirks' integer by 'quirk_flags' bitmap
>  - SMP: If an unallowed command is received consider it a failure
>  - SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
>  - L2CAP: Fix null-ptr-deref in l2cap_sock_resume_cb()
>  - L2CAP: Fix attempting to adjust outgoing MTU

This has issue with fixes tag, the hash looks wrong:

Fixes tag: Fixes: d5c2d5e0f1d3 ("Bluetooth: L2CAP: Fix L2CAP MTU
negotiation")
	Has these problem(s):
		- Target SHA1 does not exist

Could you please adjust that and send a pull v2?

Thanks,

Paolo


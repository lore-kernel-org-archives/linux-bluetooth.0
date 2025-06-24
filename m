Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93D28851E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762226; cv=none; b=OHAmgA5YV5ntOtZcou/CuyBlgZUJbEdk2QfJhqm1p82l9k67Py3qkHeWn0NN1z7UxqHw72NRWzdb3cXhVKxqqq3S00/oYYOxLuHxQtH8CdNE7mzuR1PMpdQfKKuZFGPexWg3x3iatP6ggyEPnVgpNXDGUcsobW+Zuf8zsSKbulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762226; c=relaxed/simple;
	bh=qBq+f4c3Nls8l4McJnGhK8BgYcP656yzeWu177jOtf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqlNHCm3qpuM9pEkSFKpFiNtV9rVq4P2MyjrgS0bnc9yqxrDSKh6P6sQh8Xly9wMXq9PIggQThAoasbmDDYg+uSRPbdDxp76Lu5uYyxfy2LhCN3N/ksrEnagZY5y5Vywi+LxSWfHLelO2n+0n3hYlzRc6DAWssNEYnkViLi+Shg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heEgj3Sz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heEgj3Sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750762223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5WrQDajdq88YXiVGmKcCyKustSvwPWWJwlqVUa4+2I=;
	b=heEgj3SzV1zFrBXZqfvgA1veOVQYqx/MnllcsMt+me8bBPJvz1RMNVVqMV6CQqOS9y1B+r
	Wh0KEH4WRw9l0CF7AC0nGVt3Td54XhcIrrIRA72wbhsD8QbLX0dYoxq0DxNCjnQTpUMERr
	qLmQzQMkN9vpTGQP+jhhKgEoG/JM4rY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-GDNsWMH2PWmxfDNzhEfmzQ-1; Tue, 24 Jun 2025 06:50:22 -0400
X-MC-Unique: GDNsWMH2PWmxfDNzhEfmzQ-1
X-Mimecast-MFC-AGG-ID: GDNsWMH2PWmxfDNzhEfmzQ_1750762221
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so162024f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 03:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762221; x=1751367021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5WrQDajdq88YXiVGmKcCyKustSvwPWWJwlqVUa4+2I=;
        b=TT4+Fbs4zs5qSrbmkLikpm0oKhUoJ3fab3OB6qqEL5g5raxyRWV1ZZBoEUiIZB1wps
         ylDPphh0A+H/dAVfNxFT0Z7+d5L+nrhju0vbYCaWbAAPx1RdG99WDMTrRExXYaZEeYGK
         9lt6dSnT4BVTqk3YqQOfH5uZLYpNSmijpDRhyjBfYitTEU+SmfCPAdsxW5Xx9Pw6xfQn
         CN6s5hUybYtgkSF82s48S/dag4nxhJVhOd0tToeP3lYx7UKsXQpy/Vm1w/RJiWPsuU1c
         xZd57ZeDh7iSsMJbDdWOqlS5W+RARidn7b6/JbKqyN4nZRb78+9I430St1W6fbocsJNK
         t9bQ==
X-Gm-Message-State: AOJu0YwCIB1Oceejv7YDLAqYI+4D8M5CJ48nEN+q0EDl0IKdrEZAAtdS
	nQ9Bg/5aG82cWpVXWvYRXTAQOVD5Rq5kG9zRK3YKEQd9Pyb64UjqZlk5P1bvZ9T/UzU8Y7biVWX
	m9spTXvPtQ82AE8OJIgynSqUqkuIt5M8mtDsgZOb3tNKTJYSoBC1a9Srwb9JdZklj2c+5jw==
X-Gm-Gg: ASbGnctIbHPO4y65HCoMheG+xVcyNzQ/vH6eV6uJoHAaUUR/TG+tqZLwvMVKDo61eWk
	/l3VpOklTljUoBTT8Nyg54N//VYU8R47zZhCqCczICJKvyQDVrnDQVrj+mCZhnndBSEGBVtw1M8
	g3MxjWrPefp55/SnGUasZXmKh3rPA5UqPhXK5Bq+J3at1sj9sYRsGwEhVAGlUXQ624WXB0o4nQc
	BgTIUZXd0vuU+SofFGDosHxyxyZEobnr+WhTl66euw9O+Lb7DeBSjAMedO1y2skS8C94jH+3Zr5
	LLN6ccUZMB1aWaVOW0nPu4nRnOoiJQ==
X-Received: by 2002:a05:6000:1ac8:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3a6d130168fmr15603613f8f.14.1750762220932;
        Tue, 24 Jun 2025 03:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDS860fadNu+orhJGcSV1eJbxh/1Ft7AuU95vjWZvGq5lkPoCoIOGs7Wx4N7UeVznb/3cy/Q==
X-Received: by 2002:a05:6000:1ac8:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3a6d130168fmr15603585f8f.14.1750762220419;
        Tue, 24 Jun 2025 03:50:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805dc00sm1703276f8f.31.2025.06.24.03.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:50:19 -0700 (PDT)
Message-ID: <99bea528-ca04-4f90-a05c-16bb06a4f431@redhat.com>
Date: Tue, 24 Jun 2025 12:50:18 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2025-06-23
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20250623165405.227619-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250623165405.227619-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/23/25 6:54 PM, Luiz Augusto von Dentz wrote:
> The following changes since commit e0fca6f2cebff539e9317a15a37dcf432e3b851a:
> 
>   net: mana: Record doorbell physical address in PF mode (2025-06-19 15:55:22 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-23
> 
> for you to fetch changes up to 1d6123102e9fbedc8d25bf4731da6d513173e49e:
> 
>   Bluetooth: hci_core: Fix use-after-free in vhci_flush() (2025-06-23 10:59:29 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - L2CAP: Fix L2CAP MTU negotiation
>  - hci_core: Fix use-after-free in vhci_flush()

I think this could use a net-next follow-up adding sparse annotation for
the newly introduced helpers:

./net/bluetooth/hci_core.c:85:9: warning: context imbalance in
'__hci_dev_get' - different lock contexts for basic block
../net/bluetooth/hci_core.c: note: in included file (through
../include/linux/notifier.h, ../arch/x86/include/asm/uprobes.h,
../include/linux/uprobes.h, ../include/linux/mm_types.h,
../include/linux/mmzone.h, ../include/linux/gfp.h, ...):
../include/linux/srcu.h:400:9: warning: context imbalance in
'hci_dev_put_srcu' - unexpected unlock

(not intended to block this PR!)

Thanks,

Paolo


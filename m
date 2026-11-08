Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143663;
	b=mpzjfEyM+7xsdKqG5WqUYi5xxGbE5AcFD3yMiD/HEnCARxDfi4YzWJVUMV9tZkh33UK2
	 Lj1ILKJqROoZeQXH7s6kjVPkqD9cLxpXaq0lH82pMBdA3DvqMegMitTjyqcWJJqpZEWG8
	 scBLGm6xiTiSfwjbhd63CM+uu7XWBzCnSD3UgEVALm6cy+u4kcmZd58QcjkiC/4eaVHoD
	 xKmeaMwflM8Ydjy3ugH8IYKTmwXFhQ6U5AYWs8B0IT72FLPrUw5iyHiAyTy9Ns2EBRO9v
	 ejt6JFEOsXagcG6f7Zcmx85m+Cfe9itPkFS62QAFKToAjMNqajHSx8AzJY3OoFadm7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143663;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fg4uIh/MG2OfipaWGWYSlCru/4Mi+6sgfqQg3WGOEHs=;
	b=pwutTdizE6ZgAvw/C+ensWf8dCtIh/vmtroj4Jr039tN97XHVz3jwqd6KQ4lOYXpYruy
	 CdxSf6fQ6GJhHn7qbC7MeJOFIxk1sCtllDVxwe0tMZovsEwxJu4BmwgnzDjfNwQXb7I5m
	 qyprP5qog4LdsfQiFlxlZLKuKVSlgOQySu5OL3v+M8sOazG3SSs8Z/QqYelpi41pquSma
	 A2E75cazx6S9n3Oo6yvAQVhQ1ZlrdMp7uUs57biNzAIRC+7UWhfuKSD8OgKpOHqhl7Nhj
	 vY5sc5Ta30gv0rbRJS108L3ck2+6QEjrt2R1LSkxjQYr78UUsJYukte4KPt99j8KZeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nak5s6JX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49132606A31C;
	Sun,  8 Nov 2026 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nak5s6JX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A2E1F0089F;
	Sun,  8 Nov 2026 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143662;
	bh=fg4uIh/MG2OfipaWGWYSlCru/4Mi+6sgfqQg3WGOEHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nak5s6JXIINDfcpzUQw7iu5+QUcMc5Dqn0XKcOFvQcc9WDYKHEBOtoI2wgekh3BLP
	 J+eH1Gb1VFqVNix5WdY/f4UXeC5i69yF08Uqst8gqOD5YwRPi+ym099YTgbIYpt7OR
	 h1TO4pxaT7Nmy13A8mQr9f9Rwi9kLZbKalvTJw0xVrQMPVTf0ufJ+BpZPdYOvV/axy
	 D3bz57nIX2McRLxqb0f28bIMTEznkldEZ5tLK23ShzpnunNdmFv76qNACTCGvcGMxq
	 xX3XiK6Z3Ib2l8CaAO5w4U0g50EKcl0hO7ovwqxqLXNvfWxbnHU5px0X6UbLXmS5c9
	 z1QdSFNQ7Z3iw==
Message-ID: <98867385-b28c-4eeb-9301-8c284ee8a089@kernel.org>
Date: Sun, 8 Nov 2026 14:14:19 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm4377: treat only negative
 hci_register_dev() returns as errors
To: Andre Eikmeyer <dev@deq.rocks>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261107154839.89941-1-dev@deq.rocks>
 <20261107154839.89941-2-dev@deq.rocks>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20261107154839.89941-2-dev@deq.rocks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/26 16:48, Andre Eikmeyer wrote:
> If another controller already holds hci0, a USB Bluetooth dongle for
> example, the BCM4377 is registered as hci1 and probe returns 1. The PCI
> core takes that as success, but the devm action that unregisters the
> controller is never added, so it stays registered after unbind while
> its driver data is freed.
>
> hci_register_dev() returns the index of the new controller on success.
> Check for a negative return, as the other drivers do.
>
> Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---

ouch.. good catch!

Reviewed-by: Sven Peter <sven@kernel.org>


Thanks,

Sven

Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB97330642;
	Mon,  9 Feb 2026 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670021; cv=none; b=XuHSIWhiiMsyeGx2Ayr+PjdsvXFY8fF0xaIpYwW2UEi9LWmVfI4wMGZIwNVH6qBXsEezAX46Fhn0PeHibSteErspVYgJD/cz0acV6wnevw+81aEvkw2ZGoTZV2JKnLaWtm+4QP1RLcowHgxsiDratq534eQwEjoTtgnElh/pMFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670021; c=relaxed/simple;
	bh=E3QxQed1HKltKQiCDwcxMXDo4f6+z8VypXXMyMcjo7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftzWLBK9/5AAP98hizJZutnuKlcJqF1Wk5dAuf3EpMFNKwsO84OPj0kLjlCAdgHlyghSxcrHnULCElFMaxjHCB+82sa7O8dTjCu3vlAT9/o4kioEx1ukrG9njCEnzpd3A/TlVDPEraLV5e+gzI9/fUPYO22KBCJR5i5ng/FGvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=TAEbQihp; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="TAEbQihp"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFDF011039C;
	Mon,  9 Feb 2026 21:46:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770670017;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rJc2Iu6e1A8Sm9CEp/mEGiYxIK+xeCJ1+e5YyKIumiw=;
	b=TAEbQihpfpuVQdw+mY8QmbYpugMr/aD64rSEJfXJP0hJtE2Zyzsm/2+mpGLj6ICUVtrcfE
	dJjkUzmekE17gkcZYfDkayhZBc7uhbcdSNgksbKCgt0T+FkffC3iFY0xoEo/WGSqiqvHk/
	WxC8Jk813tbC8RNFGuCWUO0+7Ka04Jv/XelhYE76KvMTpUFUjkHd9IAmjn7v3za39m48fB
	K04iEY0PlYnozh1+apWEhL6uDYDvt0gMW2P1oLNneeuv9+5qqKPLPfxI2Mn08updNt9Yya
	Lc7peGC+q/6ymxYRTH1Up78S9msOtO8EFX4HpzPifEQ6MfK/YGnVnmyyyoeQig==
Message-ID: <7598a919-e42f-4f0a-92f7-1203ec5facf0@nabladev.com>
Date: Mon, 9 Feb 2026 21:34:40 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4343A2 UART Bluetooth
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org
References: <20260209171158.22641-1-marex@nabladev.com>
 <5225311e-4cd6-4227-9d0e-8c5f6676cdb8@molgen.mpg.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <5225311e-4cd6-4227-9d0e-8c5f6676cdb8@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 2/9/26 7:19 PM, Paul Menzel wrote:

Hello Paul,

>> This patch adds the device ID for the BCM4343A2 module, found e.g.
>> in the muRata 1YN WiFi+BT combined device. The required firmware
>> file is named 'BCM4343A2.hcd'.
> 
> Where can this file be found? In the linux-firmare archive [1], I only see:
> 
>      brcm/bcm43xx_hdr-0.fw
>      brcm/bcm43xx-0.fw

Those patch files are distributed e.g. by muRata:

https://github.com/murata-wireless/cyw-bt-patch

> Should you resend, could you paste the related log messages to the 
> commit message?
Which log messages would those be ?

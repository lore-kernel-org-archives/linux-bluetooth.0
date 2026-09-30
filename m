Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F883D47A0
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795937; cv=none; b=hBDbACHzyWexSqF6cGwTqBcelz9S1aWW0XEbxr0u9x6VA7cIIMYJ+caus7MkVBQFQd4XnNeRuZyqu92fu8QlE3h+AIhxW7ryMHgRCHa6nMVLwSRPdhsEA/nq42GNRy6hXzVG1P2sTPsIJwnBhA/Z9bkAAUBy2Hj70E2VFEhzGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795937; c=relaxed/simple;
	bh=eX9TtBllmCyIZ0O8Pa1CHGXLav0s39iWyvD52Oi6rrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcohWpfZPwNyzJj8QoQHObw7SvnD/Bti/lf5wTFRDPwmgUuhw7Y8ILYnDE7GwUtSsavh83KQkVvEoypHTQgtqPi9S5KyY3+npbnoQEX2R4YfnBfXnyiwLu97i/cot+t96EJCqt7oPbDak+5vuOwX3q6U/Ffgy1z+EBHqPwnfIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+0stosp; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+0stosp"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba42939bfeso461122e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790795934; x=1791400734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eX9TtBllmCyIZ0O8Pa1CHGXLav0s39iWyvD52Oi6rrg=;
        b=l+0stospN8B934lkRUkLj9xd6JsECHdRpf+0rV6USZPPbJIRurjZZicq9YVDVDWIYx
         G5ek5DiseqF6Hbm8w40hVrNPE03NdyLnp8aR8uU7UBqJtoklgPJdwLuO0EL8Wdtd7w6s
         mD8pZMJA2r+XQkQzDqLP/FqkVa2gr/PwEzx5OUIJHmEVnvvBdmqYTddaIL/Uu+hBJciw
         LAskc+dcBRT18GuZmLlkrPQzG/tjm2lxRTsxoApwznXjyUD3RxtVct8zIhQ/UNBFYHfq
         304lT7v6eaL1vlMC6kOXwLD4J6hTUh6osZf7nsXwwyCOPvsR2bkFd03fBhOL4O0QPzHn
         D87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795934; x=1791400734;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eX9TtBllmCyIZ0O8Pa1CHGXLav0s39iWyvD52Oi6rrg=;
        b=l9RHfPho0wCEV8KtEjuAgOZLa+Htc0h9YzlbmlMPyMMBu5wQjj6JVbzVm5V+Z//Ajb
         7lmVwsgDtUvDlHRGBR9nIWu6lI4tJtrBIoZZVY+LN/Z0MDo1PyQMwx8yWA0EbGuNwl4k
         iUF68TPoPfOfUlOcRe3Jx87au80JCFLClaty1RxDAF55b6ujTPoEz9HU2wUT9Jbip7Do
         KA/K+s3hOJy2bfzKCn9wZ4dRKx9iARKrqUJmhgqbLJVu+0j0ImaSUiycoZVxjznl7ULV
         oj9+UTBTcabOHOni81TqgO6kl00gOkKRR4R7pPbt5mdelvcNN0adlgGMOfcGZWPvpSKD
         8Hrw==
X-Gm-Message-State: AFq9FYInqNIB0He/xaOcghkXaRX+qT3fhxSU6RZjUSsL+ZcCLfA5P5SG
	3LTiBImzJvLL82/H4K3SGWW/erLs3iIpAiPhUAUDjmlbgx09KzfHPfT5
X-Gm-Gg: AYBFou2CuzgOUf4zNsQwZFvCltlAyzumN2F1f1PZkBMkLxKFxqiSTkJzCnzrJilOGFc
	pGU0y3eWBaysYuGH/+LOOekPt7vnUjkUk/3Z9Rn/xidmZjnBuQnRGemRgdS0StGv54FZ4NXtOYY
	YzlMdu8xLXZc85jVpPu0C8RfyXPxBx9VtJSWq8Z3dh065yKafGxiL1KfWFy89z18O15cFhEk/d8
	eVGCFydysHJxHqmfJe1FKCCagLBKC1wsGx9qig9zufbjtM4vvc9T9lNzoaJAAwjvdZ004pW7fC+
	bDn2XB66HjofTGRqLU+AcnzzzLkCNIFlsqhRIeKWzUUtcjy1racfGDci2Y+hHaghIxY9eqz6Umi
	/c6kGSsPdlRPNddvMMpdBmi6gUmgDjY0Qqbf2jgP92+F8fMuuEU9HEZsRQ28HOmwFHGh/G+Q5Vf
	uehfHqW+eiY/7V/yhBeqhJuvVeZsp+J7fR+Ezvv9q02jC3QPLh3JvH62HPPG6c6BU5SfL8F0LSQ
	vQeZ2iyMEJLPj8z6Peob+KzGo8mkUY=
X-Received: by 2002:a05:6512:39ce:b0:5b8:bc5e:b57e with SMTP id 2adb3069b0e04-5ba4061991emr1049016e87.54.1790795933835;
        Wed, 30 Sep 2026 12:18:53 -0700 (PDT)
Received: from [192.168.1.123] ([95.31.11.153])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fb2095sm176712e87.36.2026.09.30.12.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 12:18:51 -0700 (PDT)
Message-ID: <43209187-780e-4e09-a648-a4eef4a12d8f@gmail.com>
Date: Wed, 30 Sep 2026 22:18:46 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260930181104.3375-1-qwertyuiopyyy@gmail.com>
Content-Language: ru
From: Konstantin Nazarov <qwertyuiopyyy@gmail.com>
In-Reply-To: <20260930181104.3375-1-qwertyuiopyyy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please ignore this patch, it was based on the wrong tree.
I will send v2 shortly.


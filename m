Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8957EEFD;
	Thu, 30 May 2024 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105796; cv=none; b=GhgxlV5Paps9O6kTGDv3wuYZuLnYLbHCK+g2gPSkMA+odezrs/NIK7SjYL3Ary46M0UjQPygu2DLWJLGfB+Jo9BxJ5W+B2bzrVhSqilpXeYZmrxWqhQYsP0Z+2JkqQnhXx+7g5qR7UT1AS1jAURwsLtQb4puQXiyszmmMY1wVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105796; c=relaxed/simple;
	bh=f/fW0zdBbzo6W1x0NePO3Pdd4EwO2/UxhM7Z8Y0hb/4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lmhIJlFEj+Rm0zkyFc5Ol3cggHDTLH8FosareF9oVnzhWiY8SCLSxVTGkmymEWRNgYZbJeVA9G2Y+zxe3k4mV26Q7MPSZCJ9CoefkEZ0oKw+UTAR1u9o1YzYPyvbSx+1IIEr9sSHTCwSyQsNjy4FVqrw5azPzC7UF0wGJEYDhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2nHP67P; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2nHP67P"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7930504b2e2so68640985a.3;
        Thu, 30 May 2024 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717105793; x=1717710593; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BvXcUI2/ZA1mL53Sma0yFBjzwk4mG3KgVKAtFhZrbI=;
        b=A2nHP67PJR7xmzOyccYCrUYB6Pmuxx+a/yVCW07TSl+0KkQrRYmH+PxAGwmBof2p4+
         iu8MIJqYzkpq/JYB3L95cEiVlXIx4iQSMlHcRL4NVGWbz/kVywFPdxsO1jpuRSjBm+dr
         +ZBtIdLjnc6A5nQ68Z/Il2VZ8ZdJeXCm2H0HF2J8gpQcpR9Wie3Tg3FRbeX0uqocN+PS
         NnzEnShtvsR3Zbc70Bt/8TWRhBb1Bk1+0p1Fc/tMFhv/XpECaO+ZAmhBiRzS34cW6YIX
         dLYbfl6RPPe5fWowEG/5O2mdpYQBmibOA9EKgkMPzUmPPYz8tyfskafS2DtlSv4xFdMx
         7o0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105793; x=1717710593;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9BvXcUI2/ZA1mL53Sma0yFBjzwk4mG3KgVKAtFhZrbI=;
        b=lyKj5XQOidAoYLvpIyNst5USBl6DD4HhrOwYA/chKCPgamnwAhfmA0d4tXGLuTZP+U
         LDs7W5JA8p8TN7ZmPm4uNFlO4Gi1sC8581Vjun4Lip3gGkj2cmMUgdmrMuW0HDv4QOWO
         0IplxlPLm9zZxwFvuDcvUCDKUFtj06qzSQECQGTxf8jm2jAltMa/eNvQa14HPxiDphRc
         5QqB5OfGhQ/A+orvPkUYIONmdKJ2oNDb8qs4YYD8KACU8tkF9aSE571PsiSixXjheYek
         cd6pwtx8UAAsSS5hhdMBEbUTy/XQzLw4lSksfpJMaKqbElS0WFQvS0mDogXvsya8Bt37
         v0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU6RMwhvxtXTJAMk7kNlw6iKLPD/ZHpcLwxiOz7SiDiwXcYNB8b6xersG+Wv0s93qfZwnAN0j6vOgXgxhMp6RAS0xE8Dk3Onfzx8iMSI5P6
X-Gm-Message-State: AOJu0Yx3RAXBXVInHAOTnIW1wNZeUBimdfVAqlu2w6a1vwTTbSPxZVkw
	ETT0jziSgAjpb/AFZQpZZwOEKr/IucU67rmTU3Bp9KKo+L5W4WT5m+Bkm23Q
X-Google-Smtp-Source: AGHT+IG6qFoattV8jBj2PaP9TutFh3X3DjNscdjl1+wUZwNW5AMFm0+Lhsbh/ryMHTl+5CLzDOWQpA==
X-Received: by 2002:a05:620a:12e7:b0:792:c199:d318 with SMTP id af79cd13be357-794e9d95e01mr338982385a.12.1717105793270;
        Thu, 30 May 2024 14:49:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-794f329148esm14086285a.127.2024.05.30.14.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 14:49:52 -0700 (PDT)
Message-ID: <e92ecd6b-ce05-41fc-8c8a-588edef551ca@gmail.com>
Date: Thu, 30 May 2024 14:49:49 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Flood of "Unexpected continuation frame (len 0)" messages
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hiya,

My Sony MDR-ZX770BN headset connected to an USB Bluetooth adapter with 
the following characteristics:

         ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of 
BCM2046 Bluetooth)
         |__ Port 1: Dev 10, If 0, Class=Wireless, Driver=btusb, 12M
             ID 0a5c:2111 Broadcom Corp. ANYCOM Blue USB-UHE 200/250
         |__ Port 1: Dev 10, If 1, Class=Wireless, Driver=btusb, 12M
             ID 0a5c:2111 Broadcom Corp. ANYCOM Blue USB-UHE 200/250
         |__ Port 1: Dev 10, If 2, Class=Vendor Specific Class, Driver=, 12M
             ID 0a5c:2111 Broadcom Corp. ANYCOM Blue USB-UHE 200/250
         |__ Port 1: Dev 10, If 3, Class=Application Specific Interface, 
Driver=, 12M
             ID 0a5c:2111 Broadcom Corp. ANYCOM Blue USB-UHE 200/250

keeps flooding my kernel log with:

[2413092.567730] Bluetooth: Unexpected continuation frame (len 0)

Is there a quirk that should be set for this adapter? Audio playback 
over Bluetooth A2DP works just fine.

Thanks!
-- 
Florian

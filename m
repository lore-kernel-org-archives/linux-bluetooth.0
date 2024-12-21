Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF31EC4F6;
	Sat, 21 Dec 2024 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774780; cv=none; b=ptusGSoHJNIzeTIdrlcUmBJLoeI/tZcfm9XrMQCpmU0eHkVt1uwzRJmlsxbeh1wOgI+VKokuA1J+AiUg6vucsrb73fUE5poDW5I9+jU0mSDf2k7EhkdvY1clMIPGzzGfrOIVuthGFGXduqjb4iTgn2z/rvhtzBs1w8BUOOcogc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774780; c=relaxed/simple;
	bh=DeopnxgzWv0Cqe0zQdIGhe7mTeKy3V4rGekfmmHMBXM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qnfX0XkvSU7iwlMuSTCwUMKqN+slCiuUyyhXD8ZtUZKUAX5UnqArtbWhPiHMff0QRQf3hZukcW7/jOhOTL8LQCr4n42p40KFAo4i50r/SebngWLF4u3DHv77XN91yRVldJS40oeuQifNMrsjJLPjjTVcQRM/VH1Y3d6Rxtj24qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqzpcw9C; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqzpcw9C"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43626213fffso23370145e9.1;
        Sat, 21 Dec 2024 01:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734774777; x=1735379577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F7wU5N3Rc+yxdkSrB3ZsiwvxSqXteUyf9TiI9dS8GWc=;
        b=Mqzpcw9CdvMjFpE/G5r9M1ktPznUabNySmuFi0LkOcwxxbb7PF/7+vCdPpaTrZpiMZ
         SsHvHjuTp1Rp16EgjX58SBQHD7El9+dbOvQfRe1DdP2PaPvb4DgrTHWPTaFenQjshNO/
         PTWVmmMsYj+AFr7BRCiPdYXs0wqoiXQNCkx6bp4VeQhtnJvNsO+V6vArhNlRDOP3vOJq
         kpD+Mu3wV3KGRw7c6+tviQ4IYhb3Z3DoM+XM0g4l6OZbMqCkr6BcRnSVztCYUMY0xXsW
         Ztk9zwralBnQdbaD0DOq16YT3qEvbOG/8QDNqfGwOTVZU8tMfdxIuKLtUSn8VaEZQRMM
         4Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734774777; x=1735379577;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7wU5N3Rc+yxdkSrB3ZsiwvxSqXteUyf9TiI9dS8GWc=;
        b=IfT4xZrgpQg5Fn88cfc1TxSYH+TFlf/8EKfQQzQirgRq2iXtnnFQ+yK9K54+z6u/i5
         uhsk8WScTdXl6NW10Wj+z7fzUQrdJnJrizMjUQilOx61HW0iJUkKSBndgKJxwP51pu2x
         5jzqQo5b7zkawVr8p1i0PZ9bISpTIdu2c8TI7U35nnrjPde/Uo3qmNY5eqoE7CsavpNZ
         s+1NPUCSt6T7o4T3JxIZKB4iRo9VT4RgPbnqufruUpoCf6RKnB30MBnoRIfUQAloojPS
         OwiJCCtpTtfPD8+mJik8/1roobFzMsCvs39bn3OVuxYKVlGBNqqjTtN39HkLKjQdzZX9
         p4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGEAqBtbg64T3jibZxtwzh81NSok/aLLbNxnR9sIKZW99XYHht4zVjP3VU7PxJam0VVZnKYwWUOsP1CeuY@vger.kernel.org, AJvYcCXBxQYeTG196jnoIAIJdcOYnR9ovOHOVJ6KdSXhl4v2N5fBSbXLoFaNnyN19ZHoaVN0aZHtt2nw+pq20FUMX8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjb2tkC/I2w3MxbNs1vzmHIyOlwVpBmylxF+Z/cV0bWcSgNYOz
	z+DCqZ7yYpCdijgx2yNAHHI6E3YMr9GPXw3H5w4Rg9edk4vDOz2o
X-Gm-Gg: ASbGncviIQLc12Pws0sokw5tOSKvNyosNc++KPWgOOgwHRgnCvBFGcOoEuzqjyW3gAm
	nGrCSQTLUFnqamaaqngNWONQO4ktj1kgL246AQCDzv1hYsrv6jUXf3Rh1WLcAl8Bcn/6I4g4uYh
	C+b/8RdUpF2vlSef0LUqlcuHc9ltXhYq3pJfXTRBqeBu3zkzvNhHsc17ZrGBIFtbDUkqbrfPd59
	TF+o38AwMFwP7HhulbBr8xsK6brdaqHtirlFFj7rictOnO0NuY2s4ioHugEnml79NorKlzr4Yz8
	ooMB/PIHcJDPzr+2nuSSDQojCGkwt/cMzLmfPcg=
X-Google-Smtp-Source: AGHT+IHjxLdXW8mbGjkft5APD+lMWkYg/9/MWVjfMYYRs7EuMja17eWwm0wb+Q5Gfbj7nNRta4GP2Q==
X-Received: by 2002:a05:600c:4f89:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-4365fc09731mr81614135e9.16.1734774776704;
        Sat, 21 Dec 2024 01:52:56 -0800 (PST)
Received: from [192.168.10.194] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612899f0sm70967715e9.38.2024.12.21.01.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 01:52:56 -0800 (PST)
Message-ID: <1eeecc68-be5f-46e6-aed6-594c4b32df21@gmail.com>
Date: Sat, 21 Dec 2024 10:52:54 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] bluetooth: mt7921: Crash on Resume From Suspend And
 Hibernate
From: Sergio Callegari <sergio.callegari@gmail.com>
To: jglotzer@gmail.com
Cc: Aaron.Hou@mediatek.com, Chris.Lu@mediatek.com, Deren.Wu@mediatek.com,
 Hao.Qin@mediatek.com, Sean.Wang@mediatek.com, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, luiz.dentz@gmail.com,
 marc.payne@mdpsys.co.uk, marcel@holtmann.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, steve.lee@mediatek.com, tiwai@suse.de
References: <20241127231432.8112-1-jglotzer@gmail.com>
 <ad78ad62-ebd2-40d7-8a6d-623ae947584c@gmail.com>
Content-Language: en-US, it-IT
In-Reply-To: <ad78ad62-ebd2-40d7-8a6d-623ae947584c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/12/2024 03:29, John Glotzer wrote:
 > Sergio,
 >
 > My apologies, I neglected to mention that my setup is PCI, and not USB.
 >
Thanks for confirming, good to see that the issue can be reliably 
reproduced with a setup similar to mine!

 >
 > What I am struggling to understand is given how easy this issue is to 
reproduce -  an AMD CPU, Mediatek MT7922 wifi/bluetooth chip,
 > and a 6.11 kernel, you suspend, and then wake up, kernel panics -  I 
would have thought that the interested parties would
 > make this a priority.
 >
I wonder it it might be possible to revert back to the code in kernel 
6.10 (that worked fine), until the current issue can be triaged and fixed.

The other way round, I am getting the impression that other changes are 
getting stacked on top of the faulty ones, further complicating the picture.

As of today, with kernel 6.11.11, the issue has /worsened/ for me. On 
6.11.4 I could hibernate/resume by kfkilling bluetooth only, which was 
not so bad, since I only use bluetooth rarely. With 6.11.11 I need to 
rfkill the wlan too.

Can this be confirmed too?

Sergio


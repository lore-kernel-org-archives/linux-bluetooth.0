Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BF218E83;
	Thu,  5 Dec 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403600; cv=none; b=PGl+LhG2vdJwiNcWA8e7PSx3YnbJOPtITDoYp5cxkbWXiyKw5J0P9dMfkAwIsvKSmy85rwRyhodRVQYP8vYdNilJjFSlYs42GrLZ6syG1ig3p+cEjnOiPpEupfHKHeHInD98iX3cFynN9rTxHjLPnpHgvtCSZfLIgFLOnnzZkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403600; c=relaxed/simple;
	bh=3OLFaKBgiFhJWCsDnLEuwFuf20ClzJ0AMK/6ux9BfP4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FwS7fvAbLrhjwG+oXenPSbMbxMVEP5w5PMgLhxTIMhsieTS70YqyQvhuq5co6UySMEcLY8qPFKNXfFUshtEd+6rQAqBvQcBjB4Gaq3hJ5bSbjk0oJqtqBA1MuhLLZTTyzjUkTzGARnNwlydVnJdhXReiHFvV75XDcisfNtqUWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvzljZLX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvzljZLX"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so1398288a12.2;
        Thu, 05 Dec 2024 04:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733403597; x=1734008397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gj8VFVjPSZEkv+oUvBeuosT9Pxl2p7BzaNCPNYLTVfQ=;
        b=CvzljZLXWMIQuLduEiaHgmdBBsYlvs+EqCCvVlmwOux2wk/Pc82ZETup+iqSKqjr7k
         HbTBU4j8KGCFXigT6wK+PvQ30yErQu0RKh41GViO5YEyM12EMmI0vtr2oin3svNCt5bt
         bqqu+N9s/9Q3vjzrpwEnyOi4jd6KKgy1SlAFkYcN4DaujyUJ9WEL3YM5vIQj/9NXrFsu
         1IFuIH+C5jGit3h2NqlrT+l3kSE1CZuN3fb0G3sYdAPjfzYlDUnJjDjkksMKDhR8KBGC
         FNbfDBAXILk4layEi3/enLl0i7NP9mw9tU3C4yelygcPGNNjOoFYJ7Q7p8+nXl38nO3m
         HD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403597; x=1734008397;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gj8VFVjPSZEkv+oUvBeuosT9Pxl2p7BzaNCPNYLTVfQ=;
        b=weKOQH4jvnEaIzUa6F8rejb1KjzRzHrK/7GGytw6/doiGtICHhyeqsTmLGOWb+Q5Ve
         khslEiQ/QdTLMd9Y6XROit1rqEdlBaN0WcNVKw9zugDtBSN+sGlw12ro2oo3X0WthoSV
         EbuIj3rRI2PhTX8E9+W+nrl1rUp6YQsPJO4en+u8I22y21x9GAsiV8TuwNHcb33J/yJg
         67mMVbfn74K69wUf3F+a4HyLd4334/jJTLr5/oiUWcIbmdoa0eR1zDaUGly1ecD35EFJ
         baZpvSfadKIQmEzlLpGdoJ8sO++UdKofukYPN/Dj8NzVcyM8SbXZnsAVxaIG61Kz2bF5
         8ovg==
X-Forwarded-Encrypted: i=1; AJvYcCVdV5Mvd3aOGym0tCeBiNE+1iMqCiUKRb/O0H1LiUVgRcvBzvApKuBrZ6y0ohAqC/uMvHSX42nSlMe/fjVJiMo=@vger.kernel.org, AJvYcCXfeWMZbCC9zGnXfacIV9u5UfrqRgjMjOltlh2t9jELXfoTeVgseKlRAgpD19jzlQx2+mGARxATIEylfB4P@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVHjXxwpmx09y3zEhibpYCnqnqmPEBnTzAc0/pN15HHr9ZA0H
	5N3uAPNd3cw7AQpz4UyoqP3OhZGA5ojqnDdEzENGjYd1LKwoY1KC
X-Gm-Gg: ASbGncupKz9gGotuXf71nRph5zZ74wm0QrJRphetfsgl9nIZ/E74sY+j2cnTaJEiBaC
	xPDvB54rqgYpOxIbnfG/uUzVz6o4WIk2XmlLIUH/hEYiAOn6moOhblhaDwttSKsSrqs+xLnDX+l
	MQuFk50GposaSJneFCD+cqj6O/KGwQkaWtpTwnkrS7BSpnniDVg+WlxhW/8TKx1pFhIl2im9BXw
	PwRsDGACT3J7LKgcM1IsX53xE0KyWyyf/9qFDAWwSWR6d5Kuh+pVs9/PF2HjkJblgdKlbzY7GpD
	QYtsSV551pjwraT4iHareLzAw9rkRkNlwg==
X-Google-Smtp-Source: AGHT+IEF+6FFvVmIuxk1MISOcv5BF4xk0eVILKN9vM5sXj6JFuPJooKQkMvDCoXx5Oq1Cpz44ra8Kw==
X-Received: by 2002:a17:906:9a95:b0:aa6:c55:739a with SMTP id a640c23a62f3a-aa60c5574a7mr571964266b.50.1733403596420;
        Thu, 05 Dec 2024 04:59:56 -0800 (PST)
Received: from [155.185.125.95] (wifi-125-dhcprange-125-95.wifi.unimo.it. [155.185.125.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dc95sm88774466b.38.2024.12.05.04.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 04:59:56 -0800 (PST)
Message-ID: <ad78ad62-ebd2-40d7-8a6d-623ae947584c@gmail.com>
Date: Thu, 5 Dec 2024 13:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: [REGRESSION] bluetooth: mt7921: Crash on Resume From Suspend And
 Hibernate
To: jglotzer@gmail.com
Cc: Aaron.Hou@mediatek.com, Chris.Lu@mediatek.com, Deren.Wu@mediatek.com,
 Hao.Qin@mediatek.com, Sean.Wang@mediatek.com, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, luiz.dentz@gmail.com,
 marc.payne@mdpsys.co.uk, marcel@holtmann.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, steve.lee@mediatek.com, tiwai@suse.de
References: <20241127231432.8112-1-jglotzer@gmail.com>
Content-Language: it, en-US-large
In-Reply-To: <20241127231432.8112-1-jglotzer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

John Glotzer <jglotzer@gmail.com> wrote

> In following the related email threads it seems that this particular email thread has
> not had any activity since 10/21/2024. Now the focus seems to be on firmware download which
> in my admittedly non-expert opinion seems to be not clearly related.

Since then, it has become apparent that

- The issue affects many laptops that fail to resume from hibernation 
with recent kernels. It is not just about wifi/bt mt7922 combos attached 
via USB, but also and most important those attached via PCIe, e.g.

MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter

- The new firmware (241106...) does not seem to solve the issue on all 
the affected systems.

- it is relatively easy to script actions to kill BT before 
sleep/hibernation and unkill it after resume, but they are suboptimal. 
Users will typically set them up after multiple failures to resume, 
which often means after data loss.

Would it be possible to (at least temporarily) revert the changes 
occurred from 6.10 to 6.11 that triggered this problem?

Sergio


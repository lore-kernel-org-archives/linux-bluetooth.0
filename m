Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF2369979
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929751; cv=none; b=hIXNJoAcFTkjqW0nmoidO1c0asSPIIX+LSSDKY8z2Z+nxtCYXWfx1eDZc2epPlKn1QCeE47T9NyoXhI3VJ8W9UDeqk//l1UVO6W0JKaAL4FjyvByKb31HdJjBgF9KEnfS+zIAZBWjZs2m4pEB4wwVgF4EcHLi/yMzxx/vNhKANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929751; c=relaxed/simple;
	bh=I78N8rF/8LWc6Qzb3UH/ZZLbo+X1Ls6YEQsdCGS5oXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz3Nj9faIhDcI6T4rdIHbpogNhFS8biM1QNzB+FQKgN+I8X732q0XbWdYcLGTrBI1FpdC/Y8bszlsR932JvCkJO1LqCPDa+R2J/LrLiIURRJ4EgIY8GzkercjdCXlucpouYWSb76x5lD0XYCBujbDm1MawuZzKWRmcZyNbhsJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnFJifrN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnFJifrN"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so46520625e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 02:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771929748; x=1772534548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxrFOhSYsYdjcEEIX+fNlQR1m8DAMHVbt1nhl3XPkLg=;
        b=lnFJifrNvf/Ng+Q1sE0tfvX7m/7WgS8yYXxRHBY9myu/V5f9vHFx8pmduK2QOWhXKg
         t/noJToEi1kc3L8nbgvq3PJOp92rYP9QnYZeE2C7DBenpPsFUaavlDyb+cnSIjCbycRw
         tTYV7bYnKPwE27a7JDrlTsB56xudACyd3lB+t7OMYqKrP+D9ZDKPRRMrDG2NZ6GwpG4D
         OXgLnHntI7hxEv4YRit5k/X8Pp5NPnQdBkEWUqw7Pwjp7Yq7nzt0gdfdGQ3kQJ6MWhnx
         Rw00kSCpltobMFk1IoeEZxBXy+xyRCGknje2FT2ZSBX/rJxL3AV7NCnl1cA5CwdKlX51
         gF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929748; x=1772534548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxrFOhSYsYdjcEEIX+fNlQR1m8DAMHVbt1nhl3XPkLg=;
        b=MbStgGpdZeMHSmhFy9CGLHiIBhidWugboj2zB+x9PFpTuzQc8XOIlmL0fdSSrKU2ad
         dksgWNSVU6Zh5SA6qbxMgPkpw6miO4Q4zJupLKtV4IXssramFj2K57xNGuvpSEsrZcXs
         I9dWDnBEzhFBZ5T1mOS3M9mK0iZuVp+KVr1aPC8lHnlVx/awQOKYe9w0OGp2bKKSS2/7
         Pxoe6G3Q7Pt02E0pSmnDKe8pcaQgSiFIi2uURc82ZYWL6ONglMempKuEqitocniivPW1
         SvGRiBM4eSeE7A8ROLZ6xVnUVM1Wj3zHZhnEz7jgAdL6eQGhZW6Y1hydBdlBgkME3GUg
         0Wiw==
X-Forwarded-Encrypted: i=1; AJvYcCXbU1G5sf/pTTXn2C63eL+SIKWa5CGqnY8RH7Ia9XcgwLrZlH7cDfVjS1+NNlHAY0daWP8u54dqc9VxpcDLil4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzF2KgzWFW304dtVCFeAuIbDsyqYdNXgdPkpjkVGZ+EWOvETEj
	H4FGdTUCxNi/+6n/6MQBi61bgI00gq6avaUbQIADaQITjVcnW86aN3YT
X-Gm-Gg: AZuq6aI3k0xfCavT65UofDejwqbGBhxbCIWbj3BtOHe4tZD9NJkW7r5ZRTbpEKNSpSz
	7JpuGKcYhauVqbcxj0xy+iYsU7v//AvT4blB1tX9KxVqfdzq60ROAif0YlGuHrcZ6JeujRxckjL
	0gbhKo13Zgjnve04JaiNLi0QrNSi97y2NiHDiKLPKXb3B9kukVHQE8nC3a8FTPHun2vVqv70tgQ
	pff4cmEod88vzGyprorVvWVLOMdNgWNe/T1lT63PGg+IvyA4WhtEwMy7hywxamn7gqvN9kxRl5b
	c6XNkABGCFCMigOS8/j+JY8vDUvAQiKQAmw0fHV4jZsf8EaNi3JMXq5MgMte0fyxbLKlaClXUNI
	IeTNV8PCArk7aYGXMAb8BP9wkIN0gncJdyfz8aEkyElqIh8Bq0gVfplnwMWh6CJ1HrU2R87N3Ie
	5fLVvD2Un/1giOs1Ttx74aDkfO2APZ760281JdJ5OMQNWsjqlOOCfDuC7sCAOZDpLUF+0PBXCUD
	eVx6V2Bo68Eexl1aCAL1eQ7R0o7nojeZIiwuBZnx+ZQW1s=
X-Received: by 2002:a05:600c:818c:b0:47e:e414:b915 with SMTP id 5b1f17b1804b1-483a95a8578mr191677775e9.2.1771929748112;
        Tue, 24 Feb 2026 02:42:28 -0800 (PST)
Received: from Lord-Beerus.station (net-188-152-100-94.cust.vodafonedsl.it. [188.152.100.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b82203c0sm17115775e9.7.2026.02.24.02.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:42:27 -0800 (PST)
Date: Tue, 24 Feb 2026 11:42:25 +0100
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <david@lechnology.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: net: bluetooth: ti: Add property for
 enhanced SCO setup erratum
Message-ID: <aZ2AkZSBou1hTMF6@Lord-Beerus.station>
References: <cover.1771847350.git.stefano.r@variscite.com>
 <db4c7eab9d0c2f71eb61baff240957596f099401.1771847350.git.stefano.r@variscite.com>
 <a5d4ebf0-9d99-494c-b46b-a6140610c9e2@kernel.org>
 <aZxE__Ybg5p2DaFM@Lord-Beerus.station>
 <20260224-ancient-herring-of-debate-c3b5f8@quoll>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-ancient-herring-of-debate-c3b5f8@quoll>

Hi Krzysztof,

On Tue, Feb 24, 2026 at 08:35:30AM +0100, Krzysztof Kozlowski wrote:
> > 
> > However, since this may be considered deducible from the compatible,
> > would you prefer enabling
> > HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN automatically for
> > "ti,wl1831-st" instead of using a DT property?
> 
> Yes
> 

We have now tested the WL183x family and observed the same behaviour
across WL1831, WL1835 and WL1837 modules.

Since this affects the WL183x family and is therefore deducible from
the compatible, I will respin the patch to enable
HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN automatically for:
- "ti,wl1831-st"
- "ti,wl1835-st"
- "ti,wl1837-st"

Thanks for the guidance.

Best regards,
Stefano

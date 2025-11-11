Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4F3254AE
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889088; cv=none; b=K656tU3CGfNVadn3/vWuhR6LR3wqoo9/GqspztgBy+v0et2FzE5UXBuP+wQzHhcBiz46z8eAVv9/Wi2n3NMZwSLwqOywHotLZ7ObswmMJX167t9tn0lOQEtaM7Z2GRzBUXQxmm+4z5pFqqKhDYzYhuG9zGPCVmZM9iOFUFGaFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889088; c=relaxed/simple;
	bh=iJKyFPECo64eUR06RMG0TkcDNLbwtXHh5KNPHopTJZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toSPnuhls7GE17N0Jf2bjHOe7VFCbypbupTRh5HSOnIx9mxx8iiPGOFX8Ov99/J0NUkJudtgPpX8np+aL5hIoRrB96n543HfXDt+f0TxEtDLeCsyfzLJnmiL8zfxcT2hSCpw2A9gs2cWwgsePVR8xSgoKSv7UHq46pN97sO3QXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjlfhBsF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjlfhBsF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso65092b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889086; x=1763493886; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPUMq1BlXvI7sTTUCmbc0/1bPWnGjc16A18UxHcvcsU=;
        b=TjlfhBsFNFNESXl48RmOvokHzAqcfqZugEilWoL3cJ7jNVClDc3OiGyRn3biOmD+uG
         dQwqXACOvqfQce34R8DbYM4Kr+pcsul9OongOuNTIDKPEBpVHwd9L6ucOTGU3K/cAW9d
         9xeKBuld/yV8Wm6rAkJbXnUlv+RoNnIxeQ2UHr+/Wh7LNwyXUK27eE3qnICzbbOY7Q3f
         HTxAZIpHJsZKqXiCSrvCy0dkrG0FIZts2n0l55gEIxz/NMmQuxY1F0h/r4ACQEtYzye7
         Sa0Jrpjy1JYezsKSuwiB/syHOS9Y4vyEJqrbfPXZqdN83tIZgNWq2U0fQV1BF04DrXIk
         vr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889086; x=1763493886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPUMq1BlXvI7sTTUCmbc0/1bPWnGjc16A18UxHcvcsU=;
        b=DBCrm0wtUgKlkpnaQ5giZ/E5ar6C+hfWcPyUaFht/cv8Y5ToDq7p7/V3wZiIqqUdso
         xqDB+MBjoXVgKfyG1p5tkgb6/Y3kRYCg0uURd/dZtZDFAj6MpY3Jg1UymNjXX0P8iO7P
         tkooeRtTiU8Q3oL3MxR+yLBPwLHrTHmym4S+3ua8cU/0GNpphwj86iWq88QHi9UZdzeU
         OMwUsxY9LB9tIYfzXmTgbC5CtSEIVrA+si+5ezOIQDNx6ZW5EQ5Mqbt4tkbHKdrIarKr
         9rWPXxvZJKkN+hREqts3+hQMyx6Gs3pf3zcMrXv0SXGPZ0oT+dFUgkZ9o16uwqURNhWh
         hEew==
X-Forwarded-Encrypted: i=1; AJvYcCUmd6BE1ijcIRupNC6xjzo3HYS6SQjtOOTpSpCMDUooP3mG7hCaR1o1Hcpbn+RdYGrKRnJna59PmADR+8r02jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5cH8kBuF9XC5ijiiQLwUlMbr8d4kabEmA5Py+EmZ445NKY1R
	HjcBMa/juaf7IeAL79gpo/ISti073p/sh5zXo2+J/r2mIpR1v3w5PWrR
X-Gm-Gg: ASbGnctmTZdx1sAdQv6FcxLJ+3i+Rp4f3ZR3PdEmcMVn0fKHbvEpkO7R8DhUWxtIgeJ
	aKyQ7Mjpk6C72Vecybz9vvPwB5/Rc9k1HXaGD/oR0ABNZbkPsEdnqVjV17js/Z8R2M71DcRO5wW
	fd8pROLWAFlTwgNpMbXNASrF0wWWGfIwxRfYMduRbzBrgf9YSYiu5UUhX4vCTYzf6CkvzLcp6MB
	+ggxxJqOnlQWCRF9/rlA3PVaYgUWh5sXE8/Pp3pEWV5TIbTkAHsrgZuS1ijR+Z2cOxdbEJWLXFZ
	d4dOs+sDzrVaA05tz6BaPreO8oB8jXkk4J6Xfp7WjXeGYuLAcS/kDihxvlLH5yCkJkHrhwKaJ77
	lZ3byAj7iGO7xikt/q548wjoMTnazT6/LrwwvQxjAp5gnsVqt4MF66QL43olt+Jdh6ZjBsubIgf
	aw3LFIRqz7nyU4cPs22Z9sLoI=
X-Google-Smtp-Source: AGHT+IFiP+HZzgDCZ0mJvjh/UrjcWQLcyz9QMbPwJxuroa4LZQ3i4g5228Iliab0QSgx+eqIPV6dWg==
X-Received: by 2002:a05:6a00:3a0b:b0:77f:4a83:8f9 with SMTP id d2e1a72fcca58-7b7a27a4772mr185401b3a.2.1762889085737;
        Tue, 11 Nov 2025 11:24:45 -0800 (PST)
Received: from ideapad ([139.5.199.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953de38sm16300898b3a.9.2025.11.11.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:24:45 -0800 (PST)
Date: Wed, 12 Nov 2025 00:54:41 +0530
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] drivers/bluetooth: btbcm: Use kmalloc_array() to prevent
 overflow
Message-ID: <aRONeQcfWA_YvzTe@ideapad>
References: <20251111142041.229145-1-ayaanmirzabaig85@gmail.com>
 <78ccae43-731d-4cee-868d-50d3c5842ea8@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78ccae43-731d-4cee-868d-50d3c5842ea8@molgen.mpg.de>

On Tue, Nov 11, 2025 at 04:20:14PM +0100, Paul Menzel wrote:
> > Replace the open-coded multiplication in kmalloc() with a call
> > to kmalloc_array() to prevent potential integer overflows.
> 
> Excuse my ignorance, how would that overflow happen? How is the generated
> code different?

Hi Paul,

The compiler firstly calculates the size then calles kmalloc().
If BCM_FW_NAME_COUNT_MAX and BCM_FW_NAME_LEN are two large unsigned numbers,
their product can le larget than SIZE_T_MAX, this then leads to it wrapping
to a modulo of SIZE_T_MAX.

kmalloc() then gets called with this tiny, wrapped size.
It allocates a small buffer, and the when the code is executed further,
believing it has a large buffer, writes past the end of the tiny buffer
causing a heap buffer overflow.


> I’d add a dot/period at the end of the sentence.

Thanks! I'll keep that in mind for the future.

Regards,
Ayaan Mirza Baig

---
P.S. By the way, I'm a second year engineering student and
I apologize for any stupid-ish thing I might have done.
Also I would love to learn from my mistakes, any tips and pointers are highly appreciated.

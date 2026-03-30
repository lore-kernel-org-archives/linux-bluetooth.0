Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9534403E
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907967; cv=none; b=N2QQFvyn5IVkng8wRPSy4mKzIueF0y6fwSb8gFWVWjXTBWCR9ZghFZA1YMQ3pDQoykgps+RMMkms36+VVWRdzTgxK/BwK9saLCLlyYoUDkfL2sBCL74G4jSe63wybyNKJKy41UzAFXu3SFxjReISXSpb9txpadup0sBQLGEoYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907967; c=relaxed/simple;
	bh=SBWSxewzIQwhen+jJUBIrBv0xhTKh8I6gDcppggIFx8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=Bd2hHXkFEOKvwTvRGcxiiVrQuv2nKJakuEF+iEIOyjBFSeDPiP3+g48JYNvnPDDh5xIoTTSaHNleq7/l9P9c7WPCey744XPT9OPhjCdCFXiBMA9BPhIe3aTtGeKNa/m1+7Fm3drpQNwhTxxnj0bTBH60Kmw6LhkvlPBdRGz8I3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDrqU7k/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDrqU7k/"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfc1aced74so864296285a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774907965; x=1775512765; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBWSxewzIQwhen+jJUBIrBv0xhTKh8I6gDcppggIFx8=;
        b=GDrqU7k/Isj8n2TjtzMg3MS+VJ+aKYlDl9RBBhsgE5DPkV0DdrNIuSp3BZTEDTfJ1V
         ozX9wW3OvKCIv02DPQ6R1BqYiuOe0edkKq3r9jtULL3n4rMHVxBCmyR0ENOQfc1kAWpb
         AwliD3qUm7E9nLdxZX+zf7K9PkNDp1RTeRa0l/xzLWsQHM2H5xGC1j+5BNdZUMBkfMh8
         ugsb3B3eORBtugiJNOFaRdfqdzk6D7hJ/LjB4sJbg1mXgN+3babHzxEVRELHQ7flfx2I
         QQqaJpDLrBzujkaltaqh6rVjqeckYLFGiIGlc/7tiPyJE2vWLqnmdZ5peSJIWS4VJdM7
         zxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907965; x=1775512765;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBWSxewzIQwhen+jJUBIrBv0xhTKh8I6gDcppggIFx8=;
        b=RHEaxU/EvpekQx2kwySGCs3F3RNyLSQ+bMMdtc5gpRZIGMGU35rFxJ70Fp8ZO8l5VF
         vfo+b15H594rgiq/ajBFgzu71ou/uX9WvdWS22DyyNB2hNo5XD+uBfUJkxZuNvKiCnfO
         p1E8R+mTM6fHJOV9DLcOJo3C2Pj7hc4RyFE4zlm27S7aMEBI6ql6jLosBqRqHqN8m6o0
         8RGz0bQWkfjrZFIg1kqKnLKnEx3ip2NYzTKldRDcA+c4lwcqZ19u/kN6FXk63mfY7yi2
         0AsNEBEvXqlPSzU0NQdNgTXnoZ21GYgiODgL1sLEq0eKNW3asP9v45rrKS3Nl+bqkVrP
         a1iA==
X-Gm-Message-State: AOJu0YxN3DFEQc17OjuiCmqGmQX3oN9Zk+sDFQD+B33HiSkf8oFWJf+7
	i62Q8mEOhIEa/E1beqfc6zy/rYwvzix+4o91iXHO+nh1/iApc+105h4ddZUEVWz8
X-Gm-Gg: ATEYQzyzT7UH/TitkT4AHY5dSnK+AbADew6mS6cvEsKJnL5H0m4ru9uQhvsJb92w82x
	fbyXR5Y7FmjZmwXYcy5HBAFG69pC3Ixr7Dfv4g8wfCrhtmfDwPXXXc37SORIc7XwCRMfLq5XEZl
	ewfukC+HAhn8D+jL2MuNmWDdUdzqTI44Y34CqHRg/Wn9DvtP0W32yADAIRrrm6+35CqMcBRhztK
	36U+86S1pH9u7N1Qjk+wxVWla6UHOXL9ONEULuvxzhWZ8Ag58duVx22X0DS0lEyrZa6h1kd6cen
	tYde6KwArqDevmHMF9ukcTjUtBU7ffxml8Bhz4OL8mslar4+ivuQvEQj1negvxe/ekKtYxpX232
	rDWITjf1d2y01eQQTU+TQi62LR9W1JoxVajomylIfnM5mXm1Q15II3PxBF05Palq4jTv2zd2eI5
	nnn+ngAZIRX3YTZJO8x+NEcVXLqFxeJo5U9k4s5qdTzIZhnGkyhmCe9HrAKWSlKp9HHdWzx65Vm
	mBo7a7Wi/tm68/kpqOkl4IwURBJXiRB
X-Received: by 2002:a05:622a:248d:b0:50b:7d38:9453 with SMTP id d75a77b69052e-50ba38ca481mr194978361cf.39.1774907964565;
        Mon, 30 Mar 2026 14:59:24 -0700 (PDT)
Received: from localhost6.localdomain6 ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2e1121fsm70810041cf.21.2026.03.30.14.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:59:24 -0700 (PDT)
Message-ID: <69caf23c.050a0220.1dc7f1.f386@mx.google.com>
Date: Mon, 30 Mar 2026 14:59:24 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, xiaoguai0992@gmail.com, kyungtae.kim@dartmouth.edu
Subject: Re: [PATCH] Bluetooth: ISO: validate ISO_END fragments
In-Reply-To: <20260328200938.140528-1-xiaoguai0992@gmail.com>
References: <20260328200938.140528-1-xiaoguai0992@gmail.com>

Hi,

I submitted a fix for this same issue earlier on March 28th [1], and
have since sent a v2 addressing Luiz's feedback on the end fragment
check [2].

[1] https://lore.kernel.org/linux-bluetooth/20260328035813.296410-1-nathan.c.rebello@gmail.com/
[2] https://lore.kernel.org/linux-bluetooth/20260330212129.319339-1-nathan.c.rebello@gmail.com/

Thanks,
Nathan Rebello

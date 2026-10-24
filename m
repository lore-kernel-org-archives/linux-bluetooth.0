Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860572;
	b=Jfs8LjRZDOINVZBWVH2DERn9s4oQjFDJQYLwO6VKiduOGoJK5mWtfaQNslZ7K6WAOmri
	 1LPc55V7Hroj6ODofrSmJQxk6Ac9Oprow19Ib/vuAaVFceTibbJldPz+h0B8dGBX/RXPp
	 OKrOoRWgqKF0L6nYqKLD90g2YRSISRla5ESxgJdEBEOABMO+rhuzZsVw0AePCZisdqBRI
	 jcq5IUlDKbFKfuPJCi+iYem0yTcTv6fsJcZgR4gCJpLyz/7HBU8KWwXeWiEQxoHbU3aUm
	 cyBqUbjV/ja6dNVT9B4dNobkRrhOXAD27amqRk8rQtEWXR/cjPXbyCqfdEAcQoCEWcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NHAtCgZ6sC3XJyB1JsfFMVjP1oVUyG6tpEuH9v+Gqko=;
	b=5j3U7Ln8zzhaIr5yS8eXG5DGcivyga0biN3v4pL2rLKx/pvy/tKZLl9mfUHeVgOq65DJ
	 Lbi6eapM7s6xsT+KJiHxtom67YgrI3FSTJQ+7ACiZF5XPZZH/IcVev/e0OGtsRw+7seXs
	 zOCV1xnTb0oQXMxLlTJzXmeomweOgS0AToKpR8gTUvWl5v1GfFiemhdgNrZdDIz9awZMA
	 ikCXxbxn6Fo8djI8bQmCLNuBF1IzgvMF4LhFoqidtMYWNXy/PkQ9b2B6V4G+gJ9bBmpJs
	 BsuuoO+7R/YJsAiHTGOqbHc2xpJ5715JmOK3ILBUBjkcEFpTo4O+wM7UEbl2reytPkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pG2fymGd;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02C606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 16:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B02C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pG2fymGd
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5366ae57896so18620221cf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792860571; x=1793465371; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NHAtCgZ6sC3XJyB1JsfFMVjP1oVUyG6tpEuH9v+Gqko=;
        b=pG2fymGdz9l6EKrjnD1Qf6fzH/dw3OsHhkFiTitdrZv7fzN2/0Zy24RBy7IXllDC0w
         gX2VCwQZYTtgeJmCl4/nqvSCfstvRm+3zW7cTIu5ujZp4zCtL4ASKb63bFQerZ9yRdOQ
         QZccxOC0x1Ua5I18uwbAuaZVv1Xrh6ROwi2x0NO1gsf3p408FgpUWnwlJe4YyB55SGWM
         IkrStvYZr0tcQCWf6LEHAD/RWKZ8NyRluYxVdRiM7wVTfthU/ybnp/7Ts/a85Sj+05Mr
         f4xCHLoSf4+ytRWmKRhQqgGQkLPTaEGys9C51rkx+UNHK+x/LBgoN07xgxjttbWsU74Y
         fdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792860571; x=1793465371;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NHAtCgZ6sC3XJyB1JsfFMVjP1oVUyG6tpEuH9v+Gqko=;
        b=vig4vlzIP67+C8ZX848twM4u58P/TTyK0ewBoVZV0S/41B68Ij3Y+ovOFlxNDNRSHC
         PgdCj/y8jTgbBoUqvykNhgkwMAOQb1uCaqzEg6XKDvRC2BUhjBsC+rra2L65ckoH5nO6
         fiqayT8jCbiRGgXaXUT5PM+gvqcyq3LK5114hJ/HIIRc6Z3Xp5rYNBiHyqI2+koRrLLh
         MxTuRvmAMiFsquz7ZPJNcxETxC4OBc10+b17SsT3ffa+b3safZiR/tRZs7kCTLkVOiCH
         wDNPbUAWX43H0WhI5Q8K0b37ei4416sY2jInNOJmys+q/t5dUq1p77/UswsmzzHKIkaP
         bQnw==
X-Gm-Message-State: AFq9FYIwlTQLv0KQ3ZRGtY1ntKGr06WXjTBurOe9oVVANSrOq86nqiL4
	AuaMlHRYJTvdJKZ0CacS+jWFJ4NfZQDycQWmGPx3t6659w6W8sc/xHt5o7akJH5U
X-Gm-Gg: AYBFou2TPaTWmipKMQdxgI9Ffp7r4fimHLkT2GkGGZCDbRhIk2B58pTxr+zISF1G/0+
	TrmikpwBeWgJNX32X82q7zjNZtd76TCaabhuvCcyVfehlqFCYZzLlvmuQMM9HIB/35mja4SKRYb
	jBWqKCwhGcw0f/AckIWXJ4K/V1s5kBcxynhp0vGjRVilJthjUEHJmSWRxy4Vzw3TPL5CaRK/2w7
	FqA70T4TCqd0o8OgyKdWjw9zSB/7DyUCt+KkblheNL/7DLBBEfiPOZj6OuxkhFiyJkfYDj4JKBD
	hASXivIl839HTUp9MmELQLY6hy3zLDXEgY2m8TwobFw+Y/wTJ2WV4LQfyFFAyW0W17ac4o3EkGI
	vPMEw7BNMhLuWwqvLO9jliIGqqVF9zV4KcR3CzkwrW4rembbKRmLd6imydFCYpOLeH1SepZk7qB
	JTzlRsYTgf1d6sq6kfs9YspZtmWwcjuImMvq25TUcehK+25A0v6YIBLhQNfchFRaHuxorcxZdx0
	lUge3qZWWrJa6uQAEHX5rwhe57grI/VxUoP6ThNJKlNySARDhwE1gw9OXroWeNQwg==
X-Received: by 2002:a05:622a:90b:b0:532:cb9d:4896 with SMTP id d75a77b69052e-5383b414a97mr37361301cf.9.1792860570739;
        Sat, 24 Oct 2026 09:49:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.102.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538397405e1sm18355571cf.25.2026.10.24.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:49:29 -0700 (PDT)
Message-ID: <6adce199.eb3ee9d5.acd82.520d@mx.google.com>
Date: Sat, 24 Oct 2026 09:49:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0008240481912886234=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com
Subject: RE: Ranging Profile and Ranging Service PTS fixes
In-Reply-To: <20261009092532.3600749-2-cheng.jiang@oss.qualcomm.com>
References: <20261009092532.3600749-2-cheng.jiang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0008240481912886234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Ranging Profile and Ranging Service PTS fixes
   Pull Request: https://github.com/bluez/bluez/pull/2643
   Created:      2026-10-09 14:50:31+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0008240481912886234==--

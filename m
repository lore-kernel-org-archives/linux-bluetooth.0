Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D029AB1B
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898796; cv=none; b=a0iQGYd4eZh3qk3nGF04C2xivLwQSyw5EOguhGCpsk9KFGxbc9VlDpt9QaYwTiJQ9+6PGvxxAJxnyoRIF2kYA6e+DKXp6CUc/sjXb3WgvNSbKZgOMJXiTrC0vKNCl/rDsFt27gch1kxqhq4k0dQIYDkpzGOpWOr/rnR7YtINi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898796; c=relaxed/simple;
	bh=6FsrBPNcJunHLOLsRzl4RBZfOiKw/aYQlZqF1FHCpZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDasjlQCNFx19eCnqHrN6Uco2tsgyYacdcCG0sMhqk7gn2EqNZOqwNvXdR+2f1kcdq/rpEf0xt9rkbRbFSHittf6HQShDVEq8ljd2ECT12shBc5pFlxNChRo51595mcuZAViT1k9q2Ou03kbYHbWwIpeVsEURAgoXSjS61zvwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=Jzz8Tz4A; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="Jzz8Tz4A"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so5207345a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1751898791; x=1752503591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6FsrBPNcJunHLOLsRzl4RBZfOiKw/aYQlZqF1FHCpZ0=;
        b=Jzz8Tz4A6YF97sAdiRqno4cISstKqxMFzlVaEk6qlP+hGIpP4NjcTzx3xTKc+ybYrk
         ZFNr4X3HYw1Uj9z7PDBBz9Yd9tdx6iDCVp8zToRlwCtq5kCZ0n13zzGO2oYfABRfxikj
         RMvS/DMBBmoeKc9oXlwWil9HnmwDCu3nmluS0trSPvDr6/ReSgmJ1VF1AdKPCflYi614
         /dgSrezpVVfYAEGs991wWUOddFYvZaODMtkqkQNitDoXkY4wXNcFqaioJr0PzEEL18mU
         AZN+jpS0x3yZFL1wXR0lv+VMdeSXDGAFKSK1GDtQPc9B32/qqUX7sNvERaXVFAi300iE
         cWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751898791; x=1752503591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FsrBPNcJunHLOLsRzl4RBZfOiKw/aYQlZqF1FHCpZ0=;
        b=SaHvuoY+qpM3OP6WGUpRHJcl4sF3dQv6KqglhbeT2DSbKt3V4MzZK2BMhaKuH4nOtS
         /dDkxOfiXSXvBNBjd8aGl9EqPM166lfGLn2M4vSTiLuqofqaX1WLn/OMKYr1KmKtn2el
         4TakNQCnkc0CA/OXQkNjLUOsbK7QhayE+H14XUx/TjwOd3IYnchKwnCGce0ifIx3B65N
         HhpJ/0hOj7x6fVkZi36o5Zw7r9PxZCsQrz2+rb/fTPhuO8tflOA17ii8iDfXZJfDtEtg
         XqISsvAifryo/4IHEyVdCiVdAIKAhrQiSl40GdfZyWIuNYKt1SAhoMMJVRzl0gYNCxeO
         0eQw==
X-Forwarded-Encrypted: i=1; AJvYcCVsDKUO4FAM/4Y4QR+0BStHnakDIRNYZuHFVyhA36nl6LgQoSq+m5eEZf1ANJ2L/cY6gIpjK099urqP8XiC8WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV69rlmAV87msueR67fXCqes2BgmfvlGiSkYWM/+Jl1mw4R3Zd
	TyaPOE/vJ9S2rij3mAMi46aadb6Y4SoOhZsAiSHCl0WDP2Rvy4UdXz4KcK8hVl6L/nQj25m8vDH
	Am8sNm51gbNCMwMOsmkuxV9vXssKVhk3dQ/5A2fZT
X-Gm-Gg: ASbGncvJDjvjcEATp+UcNiV5Iy4ND7okErEMFlSMwPEnFaeSQWZSW0JCkS6mVreJ6Sz
	Ea6qaiJzY83NRm25jtYLN2QmJc+H+eloTBLbYZc3pjrsmDw5ZKtFohalSmVa4bsy5vFh50al6DD
	CsIC2Cdap0NpaajPqrzt5K01IsvHGAEFMsxcOPxV7BjpZQ
X-Google-Smtp-Source: AGHT+IG4YUAf7sSdRmdt7gL94phIR6fcpB3LEVIAxWbdeP+vevCMYFn7wGF382kdk59WLzdrN4t3z92SY3tC8MSz6I8=
X-Received: by 2002:a05:6402:278a:b0:609:9115:60f8 with SMTP id
 4fb4d7f45d1cf-60fd6d50643mr10775079a12.21.1751898791254; Mon, 07 Jul 2025
 07:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABtds-1fKyFYvU1jL9njmhfphU0XytO+F5mBhARAzQip+CK6cA@mail.gmail.com>
 <CABBYNZLgWF7m0Lwc+C848-0qgBZfV30F7SE0YcKJCPLV5KbG-Q@mail.gmail.com>
 <CABtds-3FMYA1s7n6tFivxNypubKp+D6fjG8aSf-nkRK4Rxh1-w@mail.gmail.com>
 <CABBYNZLPW9PE4qiLaszncFoi3euFba1qfsJB+tU8hszvjFoOoQ@mail.gmail.com>
 <CABtds-2mFsGWU5Qi6CrrhpMeQr4kJ0hZw1A2gw=drNLm_T5tTw@mail.gmail.com>
 <CABBYNZKDxVmcY6uBYvqr=a6Xu=iR76tsb5k4-+MpuVNxpD9jXQ@mail.gmail.com>
 <CABtds-1+zVcnm35VQvwqP0VCXOkuaJszvsqQ-D-etwhm8kMzZA@mail.gmail.com> <CABtds-0SJCdBpipBs0yZ_HGcXtgzGJbtcQTmbdrm7LhVskdv=w@mail.gmail.com>
In-Reply-To: <CABtds-0SJCdBpipBs0yZ_HGcXtgzGJbtcQTmbdrm7LhVskdv=w@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Mon, 7 Jul 2025 15:32:59 +0100
X-Gm-Features: Ac12FXzebMV79aRZCVWgUHpyAhdiAa_PHGXdU-vZF-JBynJ6yvniBQbyfmwELEo
Message-ID: <CABtds-15rSWR5avQ6X=5M-P+KN1UiDCQCzMUhCWVw1JG3TLu5A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
	Matt DeVillier <matt@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"

Hi

Would it be possible to get this revert merged, just to restore functionality?

Thanks

Sean

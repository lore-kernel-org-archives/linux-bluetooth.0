Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B02F12CA
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813127; cv=none; b=gzyiLppjmlTxZF1PjTYpGMzDgCNJNSXQCpqHpGn2z1b5SNFkSonsZyO5SYcg4X9szVvl44u6zhDoXo1RyZrfgZ2C0SZ4CFVgozL1j2N6Yd8A5LNC02Ogr0jEwrPJyDwtaxnbn+c4YH4OboPWMRcg1KqQDjEocAigjNduhdVun5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813127; c=relaxed/simple;
	bh=3W1fzPdLausKSoXjPmbEQ+xmyfpqOD/tyAGgrFJY8Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9e6A6X7YGFHY5M4YRtc9yU7zOKYdW8M6N3knqkkBba9HQxcBljXX96cZbJLEVNHe3Sa9phwi63lV/uqpcABEYVJSJOwGa89vcACvwwsBFSBdyM0bPLM72pWH15el1BAomvjpLIwIhPx3Gbn9vFzea6kA02992ZX2NrYJ1rrAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRHwqRI1; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRHwqRI1"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso3158312d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 07:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765813125; x=1766417925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3W1fzPdLausKSoXjPmbEQ+xmyfpqOD/tyAGgrFJY8Yo=;
        b=MRHwqRI1mrkIMDpqEoNcweuZOxuiurk9WDacaTMxSlwmX8UT7ZEKfjPdSnJh+ugWio
         vMBD2azEsUj0ipoyf/QrXp3yQ72ssO/8lgr/KlN+FXbbUKMurV5f6szVblzj2JxIAX5g
         VSv/LKXJEA+2MHCVf2WvrQDUXyUVxS+7lVBgP8RjOGj40q0a5jA0Dc+qmS6/+c2BjcLb
         vl8CQOqVsyM3lBV5GfioUJy7uzpVJuacsEMjZ5W3zD6wl2y9Fh6jOBWenxnhBpGDmHHQ
         B/uLl3X+XjKIc7qr9RwLaKC2UaZfvDIgXp7H3vBPSTolOm40TjcNQKPWuq56Ek1OxR7c
         Xm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765813125; x=1766417925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W1fzPdLausKSoXjPmbEQ+xmyfpqOD/tyAGgrFJY8Yo=;
        b=WwV5WpPrkiYkz3/IyX5z6ot7UckdbM9gqpTosWFiTzgTAo357yvHfRtG+3WsO5wop/
         4Rhrt2nBG6oLvTk5Ii2ux0nscKeNxN6H8zNqB7+mRlWn+XR9y+o0nMHsS7M0tOoH8eY1
         yzZ5trXI8AzkeL3dVM5xl49SattKT9AZTZ+k3ua3Z0Fu2nfQRz/7NGzw5kqVilNiMM2+
         b+WeUwco4/kRxH05tAuUsAjf9edTvFFbJ6M6Uyq3SYlYXwJBfO8PnPXYITXtZQiTxCd8
         kaqfL2CXxmUR9hp2I3wsyGYRoU4USNnonVwzgqobKaXaNHODfqoAotyWz2qmLa9g1dam
         fDLQ==
X-Gm-Message-State: AOJu0Yz5mBncfLN7hPg6QenGSeE8ZUdaELjODT7VpfDjmg9laajtQorN
	jGdjG5eAKzYBMXNnvd8L3RuBTYYppnqhxYud12dH0QMsk6SDW6Hnj+43rzrRP7XRpPv6iuno/eW
	XpcklDmayLY9QaPRzwWTLLiqTFnNriTw=
X-Gm-Gg: AY/fxX5D3KLfdzAvRFnktGfvshlxC/Ta9uA3olrBdOg7e0TzUvkSCDq0iVHlmQrF3ai
	iH9/9IXeE0PdzZ8joBdkobVT4D4bttLw7DrApJH9lfPuDXpcUFAuA6PNiLxSOp6WdSg3TS6athN
	RuJnph1CNobSKvNjlxXEs8ePDK3scTWBbZJZTdSFv+z/piZvtM4GjxIZS5ABUj74nkZxVTgAuzc
	4FaJe1XqZr31iOnR/uBeU+qHxTsljkDCzOOBzbfM9dV7gzQ6b1noQVgQGJan6Xo1UZ84+o=
X-Google-Smtp-Source: AGHT+IGSyHlLr/9bXq9vUJCfIY44eCkFJnjdCDxs331aGy9IWVRzBpL6092ECQnJKmwxJZQxeca/+DkTn5V7KviOJgo=
X-Received: by 2002:a05:690e:1448:b0:645:52ea:83c5 with SMTP id
 956f58d0204a3-64555661e71mr7540821d50.65.1765813125303; Mon, 15 Dec 2025
 07:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZ+bgaa4znWcjW_n_3n3_oKbPsptg0K80eZU8iQwR81kVA@mail.gmail.com> <CAGFh0265yqFi=Jm2VOSxG4pdy+FKxvnFr5F_+wesB1dwW1nDLA@mail.gmail.com>
In-Reply-To: <CAGFh0265yqFi=Jm2VOSxG4pdy+FKxvnFr5F_+wesB1dwW1nDLA@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 15 Dec 2025 16:38:34 +0100
X-Gm-Features: AQt7F2pq99tfxZdCsyHW_3PpbsnDG7-7KZgmpj06C11VyPO8WfJ78XoLY_4r7-c
Message-ID: <CAGFh027gy+KkyiQXTTyXateYwzVxdHwRwjp8Q+z+h+GZQKNZHA@mail.gmail.com>
Subject: Re: [PATCH] client/player: Refcount registered endpoints
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> org.bluez.Media is per adapter, so the likes of RegisterEndpoint
> registers a new object per adapter.

Or maybe the /local/endpoint/ep0 should be per-adapter in this player
code? I have not checked whether it works with many adapters, though.
My use case is that I'm not able to deregister media endpoint in case
I have more than one adapter attached to my host.

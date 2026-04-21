Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AA3845A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784771; cv=pass; b=BSxMaSbadh2d60+Mc6mFEZZyVoCA4qFY7NoFE8Gq6M5a39XvDyNu+FpAmWcvCjFLzrKavIVOzqdPUw5LxRQRKIwdAtcLAwxu1bN07qQ6tWggNbqSqOh9C6A0vY4/RJztRiFn2Vr7zXY/bH/EnLyq86QcMDdu/P9KsMX9QNDfQmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784771; c=relaxed/simple;
	bh=PjftJJfecmOTA70hHRbK5lG67pybnRdPu/Z7HmX7VfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rq4W37dS7EwOunZuhRhITl6o4CYGjby+t3zkzAS6N/HMf3nqsicpDSVvYspCReralby7bJZnghhlhwA1J+o0tNNHlBDsyKIF1xwdqYJ7/DbyVbw7l3dqnsp5fTr1tYUdjvzUI+Rh9ygF+QqIbXHiG2xXfrlPOgEabgADDO3mu78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haYzPnjr; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haYzPnjr"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79db5e18ac6so54709507b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 08:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776784770; cv=none;
        d=google.com; s=arc-20240605;
        b=ZLhhvE+mZMgPbZSY+ALtMjsCqugi/JmESjd/7QwYqAGpzYomAlh5olBXHKYqIljjIn
         jSyPoi3Au3NvPN3KO8bpP2IDb8kzNQ1ZOt1HHszTf5N2JPu8Xmdw8LW5gmcxZXLOomjL
         lqdN2BS4fHdxUUIEPG5L5HKou0Cp/Sw7HlxNwAcHVcJtKqJvxYvZDrrerYO9YqbC42+z
         6gt75kTUr9wKY1ZCiHohFPUX9CPtQ0PxRjyhEUajZb8/TbR8ER6c8DB6URdFAHRx7OJq
         wSB2ea5l825bcqRZePxyATIXvLSshJM4lneELu123/UPwxWKWlzpAAjRaE570kpmcDLm
         smzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQ2m/CHxIoJhwF5p5vbd5h+FeXxeMjnXlSYb2tbUfSs=;
        fh=YtglB0jzjWKRWHxTwv235PlPwNobwx1QMveyZZvRl+M=;
        b=A73yHiyVWRfZ7ltHTNdxURvVJGc2yU9H/P7DPYFV2SkV7UPPVI137f67mC7WFpwiVW
         6AblOwQusQZH7HocH5n2X5aPiaCBu4E+K/tQtwI/DDmlDeWbdjGRm2cU3YyN8joYCBp8
         NZZHv0M3GLyFvlPPxa3R1cp16jxMGPTqdHIIqpP8qr+7ccBLQhccmAYgubNHr77zjEod
         t9cOS6UvYL/aFBofZ1cESXjU3iUiJbi2vggg/0j1o8UeNaoL7rsgBNPc3zdyL6zyPyTq
         Oq/ZeqaDE4jqPQ9b7SvNBWQEnwYW27wyBnEaqM7nGOPh5HAGFG2YD5lRM/sK3knVcvna
         eF4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784770; x=1777389570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ2m/CHxIoJhwF5p5vbd5h+FeXxeMjnXlSYb2tbUfSs=;
        b=haYzPnjr0PsLcFAU6yTVtAwLND8d82WUWB/dNXi9T3ceehnC1o9IVy0UUcfC2ilhw3
         qng4qxQCeKoYgYkvdT5fpXOMZPj2VfU3/S7NCRW6jn4szUhnQ+lQQ54UbLvWuozpK52b
         SA+SeHzCHxL5LA2rbKGi6u09iylZqfv8TESYsh+xzBxYzvQgiGKJoubA3cwNWGXcFKP2
         2X0D97gw+sNzh65KQcuc4pOJZ2UvHqs94RQ/pMIhs00oaYsEukMFxDNg+iQofZCiN21d
         k9LPxm+AQeJt/kpZETyGDCiJwuoHt0RfvRISzoBGIkeWH173+dDhrrK9hwPKZGBlHR5t
         DNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784770; x=1777389570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQ2m/CHxIoJhwF5p5vbd5h+FeXxeMjnXlSYb2tbUfSs=;
        b=euuFuNKatH0xQOABHZkOU8RmJWzurdzMMvmJ5yh9+tTrDnFyO4WWAErLV0pHvL5g8P
         CmpdyZBF5/pRanGbZy2Jp1oxqwAs7INR8EPOQYAaP0wwrmzQl2IFPUgcoDIIHwAAjJeS
         akNnYYVSlVW51osPBjA/VZyfs1LMlUtq5IutxywJabj2eSDDYBbJ6Rr+HXSSwhCsGUx8
         zLe38iiRANttZJiPSiRmoKmqK6ifzuuLQxOKfkSfFGzrjUZGWgokIpVmbHwwkOBr0E4r
         3aiVBV8kIDAdLpIkNr4KDkPkk+OfDUwem16en5oxGwVdDk03wOJ3a2F69pta3tpqXp4X
         VK7w==
X-Forwarded-Encrypted: i=1; AFNElJ9UqzN7QKK5B1FDsFlHFkfQjiU1ecyGtfkS0hfixYIlC7xQUn3r002yF7qVcnZG81heVr3UB+4JSRq7NG3Qb1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8Y7acaa/NXIgWGa1nHyMoW+2h+fI/m3AMLnXRngpDz/nYoCY
	ZZ/tubrbX1cUtbX7PDF9aCCa1Q9LhHrpFwxJCbH/ha9rwvPvpLFCRci4ZMS6KiwyTeu3cpx8STK
	+O6Y4UxneUdnt7ZhJoSqAdPISpkSq900=
X-Gm-Gg: AeBDiesHCA7kFrJnWR4xKX4NSQCyNDbdVqKarNJeWWovehuhrryQT/LGJwGx8tlrdWA
	kVLrRyxMSBzsVKALSA6FHtkXPalWwf1HvksU6nvQOO6QgqrJY2iGFLC45Kpoe9MgCGW4I85okyP
	d6laUWCNWmYKYR2T2vupikodqWkBI64AjsLLf1qVBe/jIJYR9PBlmsjoBWHDHKjXeEztFGJ6JHQ
	KWLJ5M8Q/X5d+6YkNwq7Pfi+ncIT3XNBI6CggzRY47U7k0hZ7rRaQ5Gb0kV9gJZYonH8ubtS1kF
	tM8YVqqId5l27IaIS601gFxfIzxOrXMqwLXC5uP5m840UbE=
X-Received: by 2002:a05:690e:1914:b0:651:c41c:80ce with SMTP id
 956f58d0204a3-653119894a8mr14639293d50.16.1776784769747; Tue, 21 Apr 2026
 08:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418000138.1848813-1-michael.bommarito@gmail.com> <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com>
In-Reply-To: <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 21 Apr 2026 11:19:18 -0400
X-Gm-Features: AQROBzBPqUpIKnWEQ11L0F-Vix3nySntGBxcZ4D7FG64ZBem_e_xYXdFqVKGSkI
Message-ID: <CAJJ9bXz0nwWsFg-B0nn77bn4dh=ob-F11a6azK+VV8sbLOBmLw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: virtio_bt: clamp rx length before skb_put
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Soenke Huster <soenke.huster@eknoes.de>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 3:17=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> All seem like valid comments to me, first one is odd to me thought,
> never would have though that skb_tailroom wouldn't be enough to check
> if using `skb_put` is safe.

Thanks, those were definitely gnarly.  Went back in with
cscope/libclang and found another spot to guard too.

Let me know if you want me to re-organize/separate these into a
patchset instead of one bigger patch.

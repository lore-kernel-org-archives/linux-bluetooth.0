Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1D3EDADF
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286387; cv=pass; b=RfXY2vlIL3xzbh2UBKKn/amVZk1SNZYfhZvYYn8bdmAKf4OmS2bW45HHGQwQNzsbLg2eiOsVZiCSOubXdpMaZluA8rAIMmaAclrlo/hK+gljygZP3ck5OXf7UZvA0I9E7Tg4dT2NeXoQjyYVd4zXIlhuFDDt5DNOeIlLvGnMCI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286387; c=relaxed/simple;
	bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZai+jATkyCjpNS/7iE85K+vVG2O6UWae8nJ0LQR9wm9GOFSG+8IcT4caIf+usWvOujrSN/+iJdBsqD4C0zpbJ5lZWvoPXfPz4e4n2b2YG0rzLjYPssO7kufXfhLwgU7q9Pf8vNhTX1VyaJwJA24rdFOKmRJInwrshVsrg4aJLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pF51/FNy; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF51/FNy"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bd4c61765dso45853227b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779286385; cv=none;
        d=google.com; s=arc-20240605;
        b=HXMXd9p8zMrNxmCmFSbj8h6pmdq41gz/wSJ/iuWrQUBnhSn/YWObXRENWaRmCz+8Rz
         E0zC4Z6NO00Q+gvTeDblLc6e41yOLTFDci6xRQ0JXy2BUKfGvD/uxqDuSYSYiUHhkQAk
         IIzCSLTKncrh+Kz4CCT0wQvy323IMU3W7p24QpKu+1IKYs9VXHkfOanVBe95BVokQ++S
         sVMd3BF/QtoMeNITpOGKosXb3r2kCeeMs+5tEZR62XaWI+2g0VUiAQ5d4BPkuh6Zw8el
         imoebHP0I64lQiwa+sc83KGXD9ZFa0IxwgZ4qsx0xxN8LULuDe+J/KzOVcVoRtZykEql
         KxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
        fh=nd6K1xarck/IgE+KXkylo+caQsNLKZmSk3KM4egwN+o=;
        b=H+bm9Vd3/Wzb78fPQhc3i1AWlS6nyPjbfEygTXL6mwhlQv/UWoGSYajTR0HT92PNg1
         UQk93s62MPmR6yJoD450q20Kuh3zVlp+GMJOQOp1WTcq5C4JEgOOsQ7uDh4QplgrDeGC
         /EbaIRmmMmMAC8IfvKVyizj7q8svxHyFo+0uv5dD+Mw9TsTNE5/Pd7ggOulAhD7tL5pd
         Wsl9U8J8PRApMnI+9n1z7lKUqsFRQN1u/VVSlmhrNGpYDdagVrYUzkjIJQfKM0CGS3+d
         /KE5f0h73CEs9OXeGPRQjemDNLo538VKnIMUC1+rJn/LgGaD7MuIvyeVTOb+gd4BkXjo
         0mRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286385; x=1779891185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
        b=pF51/FNy/aGNyuPKZxf2LLRRzc6339p9TzxGRpp1NpOCaAChzTbDKcIKKxFiyYdz94
         8ZPl1zLMbIwxQCar7nY4utT+/6g7rD8r6Oqa4I+P/XabwlnZYlOzI04Jta6EfEppmrx1
         9O+zQiXRhl517v/nhZwM+6R5r6oThGd4ctK58L8/pKEiLUfDYBx6ps0nqUgmlHF2/mFq
         qZgIxRtuuAQWHZeoIiGmpNWClsE8HHCSXq1X5/d8Jk4YkcMW7Evoq/7HqsUFtjELulXx
         8DBW0htzglbzB6uDdDpCkOW+vdMcu59tcTYjohodZQCxX9e6YcrAQ4G0/2N/YDUtkdqX
         oKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286385; x=1779891185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
        b=F54G4D8MHPsi5IYHQ0QY6mv8nTWsXdWUV7Ts0bAaujGjL6CcYjB03IKxKGqG9DEIO2
         YLNPlD5EUMmg5NAArBCe8MYzqWzK/mSCNClCgvuFSwy3CWlIcT4YP2M1TpM4htuiiOty
         tq+bO+ptr1N2W+hXfOy9ABmClZc2p6LwywYHgSV0El8YHkGI5u5UNDImPrDdmwT7ubvS
         efVJ3xp8qpDQz7p/1M5Q+9c7z7LxwGIzVB9WpI3GJFUyQswvhf0TyIDRh1d+85gDbydj
         ccAgevLRqizuv4dJSpJJBWKJYAlRY2uCpR8njwWhs8A6SVa2Xi4s7tHfPVDaeG8ODOg4
         r9Hw==
X-Forwarded-Encrypted: i=1; AFNElJ/GvpHw5nofUFkUKh9sKgYSJunwIaPUsRtjkrqE2MEfqM8j3BAtHHoEJUQangFEIayo3X9Dh4yrDmRnPrcGFOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV492MxpTVIvCp1RZrCQNf9MzLGsZIyv9PgckuZU6DWiAcK/nR
	KRMPD8B3s2SFbtz+o/o60LQGB1y57QZmC65BgYkqvPIhqZC4E1REY8SGYgU9NKMD6rNKVqTCrLr
	i4iNuuEMTM5IwSaWd5FqpWfO6sFUBXTk=
X-Gm-Gg: Acq92OGCYf4kfbcwo/nC1vXuHluim+5UnVhP+z3hBsepmBxGSAAhZOmtRThcCECRpJi
	c7VMZegSgsSwk54l0Jz6oMVeOYe0cXMTwIUvfXYwVZpnjagTQ9pqdnGHATuFlLiAE3xEIBPM5/n
	q2PzcI/2kBStSwa8Hfx4YvZFA8ijkui/0uKFp5NmldNW9rJ/o4+eorrLTOlVuEg+Gud1+FTYXMx
	nfgkRn8Ai5GwpKRCDy80UMZL8gvct/lOrPmtCsijk5XvAF1KMxBq2m1w0u9CYDcr4cVzVvsC5r7
	roYiF1S60x9t1756AiFe8bz6qUWSCk+AhDGyggnEnSNm92BVzDrXGzwubg==
X-Received: by 2002:a05:690c:f09:b0:7bb:712:a768 with SMTP id
 00721157ae682-7c959b92a05mr260964467b3.7.1779286385081; Wed, 20 May 2026
 07:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com> <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
In-Reply-To: <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 10:12:53 -0400
X-Gm-Features: AVHnY4Jw2SUIqejxTca-2HXdzAfWn9R-0elBcKvZqiV0qBvm6QtxRM6lQabcQeY
Message-ID: <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 10:00=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Weird, does the AI come up with this? The id is actually _not_
> important because the error code will essentially indicate that the
> entire packet was rejected. Therefore, it doesn't matter if the id is
> for a request or a response, it still needs rejection if it exceeds
> the MTU, so this seems overengineered.

Yes, and I debated this with Claude, but it convinced me that the
lifted helpers were more idiomatic for the actual spec and bt system:
"The identifier shall match the first request command in the L2CAP
packet. If only responses are recognized, the packet shall be silently
discarded."

So if we ever lifted or refactored the code, it would be abundantly
clear/safe to reuse elsewhere.

There is also much shorter version that just peeks skb->data[1] and
exits early if not ident=3D0 if that's what you're going for.

Just let me know what version you prefer.

Thanks,
Mike

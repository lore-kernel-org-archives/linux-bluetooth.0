Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266E20A5F3
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256449; cv=pass; b=nW+Ifk35wy85GXhnwqfTMUpIWSVqgta/xdTtRpAPIObrAtUWKeLB8F7rPlicLSsp1AN2t+5lxw5lJROZ/jwP/Y0ZYJ0p7E9LlZd5c0yAundCmNAHgHOspDQLgWAClwILk+3B+fYdUw+QT4FxTzVHy5SlTStgNHYGjQoOU9tzDSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256449; c=relaxed/simple;
	bh=+h8HlJDwvYNw5rua/v6Zk+eoY4fhxZ1OcFHecBDCW7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDCI2mTUdZsU72h+SlJ271ezCnwJILvuP1gqKnX02vx9FhjGenlEt3XaaN74W9No9EAGxiBY6QBgwYS0XkecUUnGQC6vm69Roj/VDVvoG7Ju4p5TLqHGXBUAx8G/gV5/aKpxwK1vehEfSbwwctQPDHlXlLhxf3ZH9SIvBy7+U9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coUeAToS; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coUeAToS"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so2616399a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 05:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776256447; cv=none;
        d=google.com; s=arc-20240605;
        b=eVlYXsRhw0MnC+x+jx1ofIyi3D0B+T1h8dEhdKavjURn+r6Rmiv+4rhbR6ghP3lR2d
         yPHJ08oKj1gfZnt0LR08Di4Ns2+mIOdvkBIOY9RYdXeuJuK9uQpXsNqlVqXWcd0MkbEm
         ZpXysr46hVgA+27EshJC4Jfo02+wRnHi7foj1kNuNy514RkSdylnV/kYIadv8hppugUc
         NO6Pj7hOHSyMAyxtnExDf8zFQ3RFav3ev+lDXMI/827YlXf2kyCc4hp+M8W/KVRV3k9k
         kT7aiatDxnQRUCXbVCbzAXOTNiT++iUkujR1PxhUuHib8/fwrasgr7AULX3jZXP5JR5v
         3Xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9v5h0WGA6GciBmySthgQ0LZ+Ql4Vyrp/FXGCtEgGi0I=;
        fh=PU4cQ10YwkXXNH6ATnP0qcpwSpJTNNeMU3Bw4NVOpd8=;
        b=GCCzRhgZ6gbC2WjPeTNnXIDQ8IL5odUw81HouQXaswKt4Xi7FmBd+HFrdzN/IR3dyc
         DkigRg+deyfLqnhlqGyYpT33OA27a5Ehq3cOroEuS0ajlLenRuk0OSTx4MspcOsL8fAP
         hFGLHsRHi7pK+wFPcHdmR4imD9gOE/3xkw+H4uhiGyagxjnYLkph9iVtiQA/mUcn+6kh
         NX5Fx5lypGEXG/MynOKX9rJql7XyTxHM123ynU/71RCto8YqNc3pcJU+E3D1LbBTU3Rd
         wSrfdrdBRTl2FJ/UUg+Sv1mOnbt5JTAdven/VsDIvN/+7H7tAF1kGExZn3C4A1C0oRLy
         /lJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776256447; x=1776861247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9v5h0WGA6GciBmySthgQ0LZ+Ql4Vyrp/FXGCtEgGi0I=;
        b=coUeAToScc18oshLGC0r4BNfr+qC+POiK+moOCSMnnLTMm2Kn6FCEJVPZBsctVvdEt
         j22YgRLi98r9pGRpxNkhZTPziPIVbLiK7p52l9D/jde5zByL/bWO5gZixlsYEypEH9iZ
         7QojMrYnMFJYKjw3rHFt5uZ3JijHGOpKDy0vxDGF6lq1jEVAFPiGJ/alcoXUj3B3u/aK
         yfdr9iX8dEONtCv9U+Ub68K6nMoTLJnkWCkH44THSydRKMywhLXp9RyoA4SlEt1+1Tpn
         588RupYVXT+wwBKeQPBraUpPeiYnOFTZha0km4630k2dRJIeXxUkRNwEmK8ku723W/wM
         4KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256447; x=1776861247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v5h0WGA6GciBmySthgQ0LZ+Ql4Vyrp/FXGCtEgGi0I=;
        b=Xz13H9AYR91MOUPXAw/GEpwR42q0HMHIEG2e8E/8ORXOsfloP84+Mlh6m99YCbd6KX
         Mzn2eQtAwUkCstZAUaMTzTAUIsnDcjHOZI+lvYqKlPEySAUBU4NFhlz1KLWvFsLWX06t
         sC31tt3o9MH12GMSgtqQEpK8oeGHKrC/ctNxqfUHgeHVZlcY9GNqaNry0z1FaTOXEWyp
         0p7iLpgtWmrzUpy+1NZ40RLR2svjhuvUP99A7F83W9jEcT0Ib1MyRKUW+LzBiDIbhNFj
         TWlS5DTvGZtBdAB44d5o79dqoOD4nDseRntQpTUxqtlAtwYgkM9fp1cshV7iqJzm4jV1
         QGDA==
X-Forwarded-Encrypted: i=1; AFNElJ/hrTSaD9Ct60kDyn2A2e0sBpPJH7+rrIM5878DbQX4ZIFWEbZuDCrCz6nboMvcFfRMrG7qjPgTBVCh2OWRFsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/tHOxVVKk29NuRyg73q8i8sANS7h1RIqpzpfRdoe7Pa1nKFr
	WlkQYb6DyK4rWRkUCb87rwmcfw3Wkz/4TqhX/9plZatJJRHFkteKgoc16Qv7O3EwrTagV2A7T5X
	QHkqOWD4E+f+Zcq7uzsH8Akyu8WMPT/O4G4uV
X-Gm-Gg: AeBDieuctv2IDWxByPVzV7s04IjwdyMS5QM7CWEXcp2HRi2u1hoGrSXG+6O+snZsNAU
	M4ceVnyrSiPC5bib/C7A7TKSehhVnotT4bmJamQh+ee1n/kYXYDxQ6bfjPSYnpg1EOLcr96yIBN
	UtQ5hIUw/j5JvADJNAi7iJGuzHsYHLtfLxYbRLKV5CJ7CPAGveM4H+nDxnapQhELE/hJ/Zl+eWz
	dKvTPrNFegLVlO36QhXBSc9uIGglXbGzK3h6UbA9Ef1dW1+cASMQ8W5rqMHGHqbBT1J5d7ISNQ3
	SVZw79AJDS7dVNqXVKAVZCjm/iyGBw==
X-Received: by 2002:a17:903:ac6:b0:2b0:60db:7927 with SMTP id
 d9443c01a7336-2b2d5a168bcmr221211305ad.28.1776256447117; Wed, 15 Apr 2026
 05:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com> <CABBYNZJAEqwfTuVqbFAnx97HBSjcwn3Hb+y+r4r2C=MMPxFoDg@mail.gmail.com>
In-Reply-To: <CABBYNZJAEqwfTuVqbFAnx97HBSjcwn3Hb+y+r4r2C=MMPxFoDg@mail.gmail.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Wed, 15 Apr 2026 14:33:55 +0200
X-Gm-Features: AQROBzCJwjrc1bDi-TXhcjD-wf65qYVngCDiW7f3UZYU9kWetoIg3teCKW6NkdA
Message-ID: <CAMT+MTQ6orj5tpiGL9hz8m2TGiBjA-9D_0e1iLt=_dXBFHcOgg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 16:00, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> > +       if (sock)
> > +               set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
>
> This is more complicated than it needs to be. I'd just add a new
> callback, `hdev->set_priority(handle, skb->priority)`, so the driver
> is called whenever it needs to elevate a connection's priority, that
> said there could be cases where a connection needs its priority set
> momentarily to transmit A2DP, followed by OBEX packets that are best
> effort. Therefore, `hci_conn` will probably need to track the priority
> so it can detect when it needs changing on a per skb basis.

I have tested per-skb priorities, and unfortunately, this does not work.
If something tries to send a low-priority packet (for example - a volume
adjustment), a priority drop causes the same kind of dropout that is
caused by scans. It appears that the only way to make this hardware work
is to set the entire hci connection as high priority for as long as it
is being used to transmit audio.

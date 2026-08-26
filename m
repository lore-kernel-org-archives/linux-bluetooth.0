Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F1470425
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763564; cv=pass; b=e3ut8DpkL9E/xxcbe7Y/19+EVVvLcc82x8JhuCISCXiA/Oc56hJ+b9kL5JX2NJPYmlFYHHIdAlbsq6+dcNVeacKm5jIpkc7wdztXJ9a0YlFiTwx0W15JT+hH5TlgWUWQpnEhF9A76osBnA3CT5l1OHONFzXBj8sW26+FuMJltzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763564; c=relaxed/simple;
	bh=5dfDTXXG3e+OJ+eid+niI0Q9Vmj3/oDN3YztsyNfQlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwICGgNB0VAY9d4wpHFlE7fniVXkNqOMA/IFUyaAUmIcx5q/AZUuSXVlTf03qQ3nkOv4mgjuWMk4wp1hj2Hx1F6G6vcgHo6G7FPBS34kvI1L8RGNdfWMj1faja3YDz6lzdw1mY4QmoF2wCgcc9+i/q+pIHhvlBvsgFrmAVAPcMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdXEIlG/; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdXEIlG/"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66d06b5f023so1787020d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 09:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787763548; cv=none;
        d=google.com; s=arc-20260327;
        b=SUheqRFiI9cDEbLpJnXRsduj8jB3GIgj/wRd/FUWYtbETKLAUhBUDb3C/lvLwVL5um
         2dGwCyL2doInWsLhvvKq4+eaCNim6ikR/0hdaRevS4r1Xn/5f78XoMjKLKC+ZFQNmxlN
         uEWTWycRHpnaYsGosjnGUgdyX5jE0axdfCJHajMl5A5nsYalbWpuAzejeUgLXrLV+ONH
         iSGeMzV8pG8QN769GJ1NgLT3mx5nfOPDGoWDbPyUHoK4wfUh4ADMcQtTwDWH9XwaUI0f
         ssu3TeUhFDRtVLsPryXd9VBb9xsqBHV7NbtePl0mLStBDMUndmJjX7zNB384A3pnM612
         nqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a9Wm9kOafuR+J6Syh9BDqfFdZeJCWOUMU6vOSLIvPtI=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=g6jjfcWl9fuqn0KpQMyiGc+WVV2PJEevSSs87r8UKwLPSm6gDojpqs2YdCvhhjfugn
         A9Dkcw5LzZyNMEAFf5gqFpt9xhW/CUJqvjbVE6Dt5Goj2MVrp5rZoOhqVlb+IeRU2Cui
         NGDdVekfsniif7rC0mXAelR55Welv3V095WbREMcwWo0EWeAj4W2NnT2iJYNqUEawm84
         KyWz14iuN4npZfIKFSBhYsiibV4UzUk+4Zro8Pd1+qAMPejUmjiI3YQ+NUF48j9GUoh4
         8/Sng2XZuBDHZQ3JTokG1sFaNQZmqQPqK1VUgnOF+eurOFZ8OaOcAjmx3dogeZbJtVcE
         dNFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787763548; x=1788368348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a9Wm9kOafuR+J6Syh9BDqfFdZeJCWOUMU6vOSLIvPtI=;
        b=DdXEIlG/oABIfBsEoiDum8dnSZp8EbE1TZqIOU06OWLGe3/VJgFpaZFLgcL8CsMcD4
         +tU+PB0gI1S9vLPuvpGrkKguAJ+8HtpllaZoYPHT4E37rdynzqZjf8i0Az98V1YNpq6C
         bQ/++RxBOP/dxppqX/KBBubC6kM7tB20unoqpkhI7lDQvWSUpNrYUrY1i+JZUcABMeaU
         BMlMFA5cKcOMCnztBGW05hv58bPBP0EP5fD5ybEaWG18hGYdlaX+7Q4gom546rgfCvDR
         JNmRTRDfkdCsCCEk0VpFGdJv1xDCXUku5iTuU2OnBiqUkAubtHPaeNGu2BsLnjKzA4Yi
         1giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787763548; x=1788368348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a9Wm9kOafuR+J6Syh9BDqfFdZeJCWOUMU6vOSLIvPtI=;
        b=E5gULdcZOcqjJ8JMmEK2rsJCJiroMUx6rHkNPtQAWLpWItqhQcNxwTUR1NrPlzmcCG
         pPgCNiH4kspTJQb1lO6OtUVVx2nt7HmthbHDTc1w/FozPiFkXPvuoTB/XLAX2t45guee
         6sFf/geRrZnabZBlC2jC2KqvAN6un34EiOLt73hO1tkjwsBSmKxPqDX2k7myMWlR5Lvo
         b0iaz5+9IGdpvmLXqROqskiTK8+XruEc2KEiMLhN9Rqp1xqtWOnL7mOxkGL02F55JFQ8
         aM4n7Un76qzMYxCidwwDrWyFYgEOS6yMLN7hR9gFIcuBYa0CcEmGxGva9KYJ/0o9FDlb
         Dt2A==
X-Gm-Message-State: AFuF++lZe19Fu/+Gq/wR3JoYz0ZFxPWjL7KJjD6bXiq0LelMWXvwzfPZ
	L4ra4UBcI9Xz+hmGXSDoL3hxDHRC6tSgeONaAPVg2WBGhDfocGlFZz0AU5ToivSDSPCgDZDdNGF
	ASmYxRpH6wg5/8Gv60M7bUpN2zu+DVaNDxaLM
X-Gm-Gg: AR+sD10sGqWQBPMu+lkVOMQCElABuB/ROhcbOnoLZmfKwv3NCgeYtojWc4XMxOSQSsg
	ryQlBT5ZITGzghRKuWE6/UOceQtopE8NcGvdikfQZsxS6pCDFj9Fg9WcebQ4Mxr210fr6KLM2PY
	ihqWMuSyVuRu53z29Vwzeg1ZNqVOY2CdsWmz63o4/vZM6ShVhLTHYjMlxLd5j6LRii5wam9ViPG
	oa5oonYsZ5Os+vbpn2pjdrYKBaHw1/x16ni1JPg5acrG2z6r9WDAHNTNlf1LcrldCuDnVQ6labZ
	wLrbwIC3FBoNd4jYY4BkYmw572irBI289jR7Ra+bq/Xn7cRZOXv/qaC4QtYLVGb66yBkP7A0Tdw
	FlJ+jpW9f71mlThXQLoiPFae8SWVCMX4=
X-Received: by 2002:a53:c407:0:b0:667:e51a:118e with SMTP id
 956f58d0204a3-66d2568e27dmr2109316d50.15.1787763548427; Wed, 26 Aug 2026
 09:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826164106.293951-1-frederic.danis@collabora.com>
In-Reply-To: <20260826164106.293951-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 26 Aug 2026 12:58:55 -0400
X-Gm-Features: AcwNN1UheoX5_5Y9E63Z8PWMMq-0St1EcCWnq_WmxI3QRkDtJ_si5fxJl-gDOGI
Message-ID: <CABBYNZJ+G4kN3phLG7RnS9EVcWLzBA7qCA-43qaafG9ppOt=cg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] input: avoid NSP1 disconnects caused by
 Sniff/Exit Sniff churn
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Aug 26, 2026 at 12:52=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> We received reports of Bluetooth instability with Nintendo Switch Pro v1
> (NSP1), including unexpected disconnects during use. HCI traces indicate
> the controller repeatedly requests Sniff mode while BlueZ keeps forcing
> Active mode, creating frequent Sniff/Exit Sniff transitions and increasin=
g
> the chance of LMP Sniff Response failures.

Interesting, but we should only exit sniff mode if we are going to
transmit, right? Or do we exit upon receiving something? Maybe we
should track who initiated sniff mode, if it was the remote initiated
it, then we shouldn't exit it.

> This series adds generic btio support to control force-active behavior fo=
r
> L2CAP sockets, then uses it in the input profile for NSP1 by disabling
> force-active on the HID interrupt channel. With that, BlueZ stops
> repeatedly issuing Exit Sniff requests for this device, improving
> connection stability.
>
> Fr=C3=A9d=C3=A9ric Danis (2):
>   btio: add BT_IO_OPT_FORCE_ACTIVE support for L2CAP sockets
>   profiles/input: disable force-active for Nintendo Switch Pro v1
>
>  btio/btio.c             | 35 +++++++++++++++++++++++++++++++----
>  btio/btio.h             |  1 +
>  profiles/input/device.c | 16 ++++++++++++++++
>  3 files changed, 48 insertions(+), 4 deletions(-)
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz

Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A738D6A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150447; cv=pass; b=n8SSWdETeG6e86RzIIF3k3yQKYX553Mp30kNWGa2U8iUaDoMkTuw5IJ2imldkwpKOTuSHvs9Ad7OYE/q+j3EMzPHZl51P2mNZTq2xOYYUSqlSFPKGsGoxObfWHKrXfjH0jTGPSVzrhoNW5Y1FDyPKXjLFici48OtWXRSU4qvBik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150447; c=relaxed/simple;
	bh=Q9KnJsy+GMob9neX78GaRUOWJgWIPgmzluYFKQS00PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFgfTUBwiuascqtlYuiHPpl4Wu4fVlyWgsDTJyrkgzHCEr02p3mjdvFm7L7FN1h22WMKPy8EOUs5pw1naOzcI8FhfG7dTNnPJYZIWdDCdTl1vv89IM3OnG5RqP8mvbHKtQZ0Uwt31p6XHDibOV3vLGmgg0r8d1sTtNlzoCFd/SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y13ioUxO; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y13ioUxO"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ca9ec3ee7so12561542d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 06:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773150445; cv=none;
        d=google.com; s=arc-20240605;
        b=EVZ7DpM0M0KTT1oMcn4wAH1Dm2l5ZN2xwtZKsVrFG9N2P0PVjESriQ8ZbDIf5DivO9
         /r9YaRE1Hca9TvlOIakU6wMo3sBXIGI7hKHBC/xGy2Nj1oy0v0zCBKMqm2X/sJE+6q2L
         NykjGV1IgeMqzc8FgNI8y22t9RSHYU38wBhn5KThAqq7QZAam7VOCBK68u8m4a6hzDKB
         KqF8vSN8MMXEiJRyWcUQiNF6SWTWJQDnDWxncf5mQIB8NumvH63eGXs74Tq521SquAxm
         xlrXOCdaC1oWSEbILyPzTonemnAzua2gcVKD4SX99QNgQGxD75ru6G3ZJtHXgAU5ZTHz
         aiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q9KnJsy+GMob9neX78GaRUOWJgWIPgmzluYFKQS00PM=;
        fh=NxKWgM8Y0mPyjef7pKRsrPFotD8klt8yrl1f2aQjULE=;
        b=X4QTnMgeSrnwIZlm0yYQ2Ks3mLVoQfwbq7yonUFLyAyVajQ2qR44D2jUH/iNqvODXQ
         nJNhWgFVwb6Z8OwLSK7W89bBgChbaUdF5FeqjbQbxQanPMoO2OL1CU6ogpv4T6PDYGaz
         7Vm2RXYF+XdtviX7u2r74KikcruJNAZHNAJUXvWPtqwON99E9P25wFNjTnMX8R7M+de5
         p2wb7zrmMIqH9rK4uS162IAmM5wnK1QGhRJ/JGCMwYIq4OuIwS+FR2vbhKxC1v4RQjIY
         ogftQH+C0Edcr2TV4zXepQV2/BoaVHffUHxnbGEGT0tEVMafN3yNLZgp356guJt7qv7C
         mdKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773150444; x=1773755244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9KnJsy+GMob9neX78GaRUOWJgWIPgmzluYFKQS00PM=;
        b=Y13ioUxO9agwJvTjxt7gncuvFaCexy6rmRtd3unmz1zMV2DBNlef/G5gPkvwslkjBw
         hrip1eiEqn6b/lq6JqJRfLfFkBggobCWAWftGYG6AALoZS0+FfM4U70SQKrAQfwUpKZf
         +qzoaysXUHJRktuYVHb63AObwaDo/CIsRGtyLsuejE/WuzkkquCAcy54oSb4GQUsZYVf
         d8Cfe1+mpZ1EgifwciXYkDaZKkrjU+rSws8qmOiTB8hq5XwV4PCnhnt+971iNiYoJx63
         vLy+Aa0wFETGQq9CD0+NW5XCQknaqe51W/RZaUGfvv/8W8xoteVa/lTRuF0+kuK89bCo
         qIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773150444; x=1773755244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9KnJsy+GMob9neX78GaRUOWJgWIPgmzluYFKQS00PM=;
        b=GlfF0npcKnBhcdjRZDmubRrxFtPs4EDELgtt8jq9ReZTh9ZHg3DLesoYiOst1jnLCB
         Fvyh3pFpzk7+QjB+sTqJTD+z9E/S4MbrQqtGRD7z8TFj7sAnX53NVkqo9gEoN1HrKERk
         PI+I/uil1aK3E1MastUpa670ALgusQv5oW/1DB9wstxkO3Iy97aeNKbChs6UjRKt3vYw
         A33WrCiCGL2ItWOpGb3FIPAL0JZvJZ5aHg1fZqdO5HKE9O/Xt3Y5KqYtG/LUD5xI17W8
         ID87DX3nLqS+/w1WCBGOmISCtGOER7ufT6v/Wv3BSclJgvHnFy9cHgqPcuswNZjpZuZ6
         85uA==
X-Forwarded-Encrypted: i=1; AJvYcCVCys24ReUYkTXgOiZhWaUvLYBbuH7tAsJckdbH6le5wljcqhQsBY40KBSzuPWHx/viyH36a2cT16z4Kap3XIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNUQ5aFe7xyGwZafiiJSA8Mlxc7a9hTQn3L3H++IgsIu6d0Wj
	2m8PIEmjPDqsepdn2+J/j+nYpqV7t3/5dpRIqXlNN6wuy91N224Ao7HcqxU5EVBzLSBSizq4XeZ
	WxU5q700AbQqxbfFCMmdj/4EUwVJimeI=
X-Gm-Gg: ATEYQzx6EUJYpvB2Z+tvA0id119JtIEoALjNSRcmnogMq7NNIPTc2/NsVvbtuG7KPPX
	eyzfv+OYbqNnx63y7KadnQm/srctLOlQ1gkiN2NGW1AafywOFPg8RNqjqUauEFg4uCM2msg6uID
	p8g3A7CAX+wHpDKxBMDV9DO4D99znf3xk0rCQaerwCjqopq1LLVS2YlLAA/yIOtGrvS40EUQu9x
	lbJGJCA2afobi/eNL1zw/ZbBohZ9QbS8ITBBQtCPpZnk0JK2b3nqShGCVefEAUnVF7wxrvmcl7I
	65vXHr9MZPL3lQCqt+7S2sBXiFfmpj34dz4DOZ1p7i4CfRwYCvmnqL+AbgX8Aylq7rk=
X-Received: by 2002:a05:690e:e0f:b0:641:f5bc:6990 with SMTP id
 956f58d0204a3-64d1431a022mr11300356d50.76.1773150444616; Tue, 10 Mar 2026
 06:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
 <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com>
 <CABBYNZKxUJUtZTNe0+ot1JmNDyLzf3x-TyN+TqPz-o5xMmx=6A@mail.gmail.com>
 <CAM8DPm24s+2raquaofgPoroTMECGdKeba7pnDz5X64wN66yjiw@mail.gmail.com>
 <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
 <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
 <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com>
 <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com>
 <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com>
 <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
 <CABBYNZJ6NNL26BOxV2E6HBA6D3vgOauRQ=75vRcBMA0D-vSEHw@mail.gmail.com>
 <CAM8DPm0rgZEY+aNj8-RJv7JwvMOBQuRu7qt7G+z_OpVL+zk3Gw@mail.gmail.com>
 <ea9528bd-ccde-4da3-b85b-793e370b4da1@molgen.mpg.de> <CAM8DPm20ECFZF6v19SrLwA8o92YXY_dsWvOyFDOuym5S7P2kCg@mail.gmail.com>
 <CABBYNZ+ePfwbc2NS-hG5g98trXOvUqRtp-ZiXD2crrvx-Lygzg@mail.gmail.com> <CAM8DPm1Ca6CDx3nOeJhEvTiD0510RteKd5Mw=Fg8hkZuA4oRKg@mail.gmail.com>
In-Reply-To: <CAM8DPm1Ca6CDx3nOeJhEvTiD0510RteKd5Mw=Fg8hkZuA4oRKg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Mar 2026 09:47:13 -0400
X-Gm-Features: AaiRm51cKz446rxtuFKr2CAde8prE2qQJ8at9le4Ubx0SkDww6sfC7PiJRhal7c
Message-ID: <CABBYNZKtAkftUyyo4B5D7ADN80as3rE5dHHQcKoWa7tmUfBzgw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid Morel <dajidp.morel@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Dajid Morel <dajid.morel@volvo.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dajid,

> Trace Analysis (failure_with_firmware.log attached): Here is the
> relevant excerpt showing the host aborting the sequence on the 5.15
> kernel:
>
> < HCI Command: LE Create Connection (0x08|0x000d) plen 25 #65 [hci0]
> 13.006556 > HCI Event: Command Status (0x0f) plen 4 #66 [hci0] 13.009473
> LE Create Connection (0x08|0x000d) ncmd 1 Status: Success (0x00) [=E2=80=
=A6] <
> HCI Command: LE Create Connectio.. (0x08|0x000e) plen 0 #88 [hci0]
> 17.048391 > HCI Event: Command Complete (0x0e) plen 4 #89 [hci0]
> 17.052037 LE Create Connection Cancel (0x08|0x000e) ncmd 1 Status:
> Success (0x00) > HCI Event: LE Meta Event (0x3e) plen 19 #90 [hci0]
> 17.054039 LE Connection Complete (0x01) Status: Unknown Connection
> Identifier (0x02)

Ok, so it is actually cancelling after 4 seconds, not 2 seconds as you
repeatedly blabbed about so in the end it doesn't correspond to
HCI_CMD_TIMEOUT but probably something else that sets 4 seconds.

> The host systematically aborts the connection attempt after exactly 4.04
> seconds (17.048s - 13.006s).
>
> You mentioned: =E2=80=9COn the recent kernels the timeout is configurable=
.=E2=80=9D
>
> Could you point me to the specific commit/patchset or API that
> introduced this configurable timeout?

It is the third time already:

https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d565356199d60=
e1cb94e5a77a

But you may also need the following:

https://github.com/bluez/bluetooth-next/commit/bf98feea5b65ced367a871cf35fc=
044dedbcfb85

> Best regards,
>
> Dajid Morel



--=20
Luiz Augusto von Dentz

Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454032ED54
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486673; cv=pass; b=bweaRm4avD+ZUcqTbB9mtJs16APOhO4JV2bUYynnNlw1yADvKa+u4t6CDztaZgz9hT/gNeZ6UVnbwpExXEIGvFzj3cgaC0SK0vPqsLbd83bctXPliIR/KYPkPlXflFYPw1Esmqi6W7xVzqBKa1+z1fzBBBmbsc8/UBTLmBPiwoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486673; c=relaxed/simple;
	bh=ivedQVMLDmErXbcVz6UL0LXC+2SevWmNueNLRSx/PDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdecc+m7lHho2nt0ewgyaDbLrjdr1Ve/6P4I1uT1sfpTzX64HCdL7S1RTlrdGlvTzOXYiYqk1beUIlQDwOz+aTFZNWCXgEB/gCyDyYFKNQAydXYAJQVDnX8188+ZFBKSpgRXQjTHZrGYqPVyDJcxmiMVQ3DRbAUBIB0Bxnpwc5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfT4/WTD; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfT4/WTD"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67921b515a6so1238504d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 12:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791486671; cv=none;
        d=google.com; s=arc-20260327;
        b=ogSGvMkRwmtqNMOSj6zWgh7HW9oiH0ALo+V1owz82V3QNvsxjszSPdeyAnNUrDyEpb
         snBV2Jep52SsTrDC+42VvTze2SAS1h7K1Das/E/wkZ/1kLfRhPN4yJhSUD4cTq9DxqrN
         By60/zmjzEZ5tPLA0ovR7ir7UDtbAMhMib6lzpw3+D1m62lo0mmIa/3vrA0ik/wlXBXj
         JBpxTGaiuJCkf5skwc2M1aZFdUvzwyRsLPk+3GCJHkHNUcS0gxp74sncwYL9lz9Tcf0o
         f95C2jvgCz907YTwxqyXqmykdoAdMCtx4YhN41kRJUydWkhMtd2r54sADbv23cUDaX1o
         R82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NCPxEmC50d98R11qKoh3XE0+N9bim2PTOnWAJCX5BJU=;
        fh=dss+mvtVWWcCKjYBBjtoOwyfdbc8Dj1NBkicxxfSm3A=;
        b=k/741Rf4C/Rns5dPbbRMTCfZSaLG2MC22WC6wdtiOSrdcJx4nNznClj6XzX/e/uvP8
         ClU6KMsceJrBVniizpfrSPuenLqOZ2p2fh12WhFQm6jB7CdPYeryQ3mRXF0jJQpslnLS
         AlsO2qiFyXvfDUI+74VnS2aopgTDp5nJ1STxxMRFWfFqGXsz+oUSPsDiSAHW9xIKR2D5
         gx4WAESC+bA47IjcnfovQgVhFdChzFHkDbsjV8qwM0PL/ftYO2h4y7s4R8Ig6iH2WwHY
         +0UPIrd2/cM0ss8bHyt5S7GbfVdgnwFaYn7r5/7RoKG569vJ7btP5fbxLGnsQYD3atAm
         AucA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791486671; x=1792091471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NCPxEmC50d98R11qKoh3XE0+N9bim2PTOnWAJCX5BJU=;
        b=MfT4/WTD+mBTdWP6BpuEzgS9ZCtJe8h5sRTSuHCHtK6EL9LymmmNdSAwfx7jJrITEV
         LktXz0huL7LztHyXSyItVUwAED3Yr0L/2tQvBTsFLPCDpdaszZqllp2yp7PV6LRznmTD
         xhqWDGPhIOpzo8LnsTtkNc0NnqkEc4FwYWNf019q26QNAVj6Tzpoeq2PoOQgUYuyKKR4
         sE+1ELMtsIUCFmDkdW4/NLLFKkgdIiGYoNBcCG97ACKstDumD6fatw1wuAhDTVCqWusx
         5cADeJ0YvIjvW7tiyKzfo8H5DrFJKnz77EHuhOl6oysEc6C5Gfi1vVwumOIr671pQNGd
         0F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486671; x=1792091471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCPxEmC50d98R11qKoh3XE0+N9bim2PTOnWAJCX5BJU=;
        b=vz8T8WivXdahM24ZU/08HaRIkhyDiUTYregBESieP6WoVzqOMpIqYB+UqBJ1f1YEo8
         wb78uIvyJ0PzaV1WkpLJ/fQjvEnJfAq9d/5azrsTK5F2C4aYE6uOajfuhTsM2vQSRFvj
         okwqXhTRI591+VLantbE1Vls3cFuLJAICGPP9BBGITTXjAF6vq7+TXekelZ3cVZRpfrN
         XuSX4kkjTLGYHcPiEombvV6di0nTKLchKJ/NqvMvf1ymmGBGqLyQcrPsTwEsAssLzLLG
         j+LwFjSO4KJTIL8w0axRycPTdzgmPxO2L6GfsNX7VSZSwW5d3YBeaVSO0asllhzdKGqh
         bWgA==
X-Gm-Message-State: AFq9FYKRoe7Fzhm8fL8bYsmjR5FNayHlD6eVAuWxmT56erhmKpGKlxsn
	B8xxIVcx9ozUgw8omAn5AxHuw9U/8JZxWoKur688Wdt4hMQiN3MIDWV+3FSvT4VflUS2MHFj0GK
	izRb20ZRM+AA+i30qFD6Winh7PBUz4ZG1/gn8
X-Gm-Gg: AYBFou29X0crAkPihhjKbr5kCEmgA1HBR3663y0bGHumD0T9kFx/tCFIbhGBvA1T6Do
	BGw7GkYSg/QOWqKvkwspE2xb29n9bkVqZNzigls9XA29Deo8YMLubwnFJaXal5HD60x0FXhiHSa
	0FuTTEe33qkAVccoRTTmhYAdUvv+4bbzWYOoHM5y9cKN6uXmgynjn0QJzYS7UZwM7ZDFzL7Uwtr
	++8KcIUIfbez9vn9dhxAzz9D/pRLgEonb+c5lCKgP03XbkIdkGtM5JyMT71m/VrrHbmS/wP8jCW
	PLvRkJDm3HBJwYT87D7nFnNoD+2ug3Ve17b859VZ9Y60UhjemMWpjTLeSJjYXEpIGVT9sWbIOp8
	iat0qMxzkhoN69d2YQITDReU/KrP9iXpEIyh+WTc=
X-Received: by 2002:a05:690c:660c:b0:8a8:889d:2ea with SMTP id
 00721157ae682-8b05aec9ee9mr32508217b3.48.1791486670502; Thu, 08 Oct 2026
 12:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008173000.3615-1-kevin@simpleble.org>
In-Reply-To: <20261008173000.3615-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Oct 2026 15:10:58 -0400
X-Gm-Features: AclHuK-J_Njw2KeZ9jL-nGpbagYWUWIGo57_u0PyRPRSD9Q5pdcDlaaqr02e6Xc
Message-ID: <CABBYNZLS93hEBfkomBjisijsJWucuxJjz0oCsHsxJ9Cw=DDBww@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/3] Add Role property to org.bluez.Bearer.LE1
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Thu, Oct 8, 2026 at 1:30=E2=80=AFPM Kevin Dewald <kevin@simpleble.org> w=
rote:
>
> Applications acting as a peripheral, or in both roles, cannot tell
> whether a connected device is a central that connected to the adapter
> or a peripheral the adapter connected to. When several applications
> share the adapter, a device object can appear because of any of them,
> so the order of events does not answer it either.
>
> bluetoothd already tracks this per bearer from the Device Connected
> event. This series exposes it as a Role property on
> org.bluez.Bearer.LE1, "central" or "peripheral", present only while
> the device is connected over LE, and prints it as LE.Role in
> bluetoothctl info. The documentation states that it is the link layer
> role and says nothing about GATT client and server roles.
>
> Like the rest of the bearer interfaces, the property is experimental,
> so applications only see it when bluetoothd runs with -E, which few
> systems do. Is there a plan to promote the bearer interfaces, or some
> of their properties, to stable? I would be glad to help with whatever
> that needs.

Good question. Perhaps we should consider marking them stable, but
first we need to implement test automation using test-functional to
ensure they are truly stable.

> Tested with two btvirt controllers, where the advertising side reports
> the other as "central" and the connecting side reports it as
> "peripheral", and with a real adapter connecting to an nRF52840. The
> property goes away when the connection does.

For this type of testing we can use the test-functional framework
nowadays, so we just have to create a few tests to validate our
expectations. Prototyping something like doc/functional-bearer.rst for
testing the interfaces.

> Changes in v2:
> - Move the property from org.bluez.Device1 to org.bluez.Bearer.LE1, so
>   it is clearly per connection (Luiz)
> - State in the documentation that it says nothing about GATT roles
>   (Luiz)
>
> Kevin Dewald (3):
>   org.bluez.Bearer: Add Role property
>   bearer: Add Role property
>   client: Print LE.Role in info
>
>  client/main.c               |  1 +
>  doc/org.bluez.Bearer.LE.rst | 24 +++++++++++++++++++++
>  src/bearer.c                | 42 +++++++++++++++++++++++++++++++++++++
>  src/device.c                |  5 +++++
>  src/device.h                |  1 +
>  5 files changed, 73 insertions(+)
>
> --
> 2.54.0 (Apple Git-157)
>


--=20
Luiz Augusto von Dentz

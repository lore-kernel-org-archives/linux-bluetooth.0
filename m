Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619265;
	b=UGbxpmCq4Exk4sAH+9t9mxUlQeIhvvQwnDvAx00UMLrfFkKNwSwvUlXiQd43jcGBluET
	 pfrhvmxaAdvM5UrKNN9628X2TVJOUZJbCgtlDZVMBDL56LkcdqY1Zcatr5Ry1VqySKqaU
	 Td+W7HvY9OT0Dz5rYFxVdlOuqgCQen61ntqgyWuAZGGup+e/RW95UF7iX4fqJmHNfQPVF
	 by0jxqxDAme9n35yctedZzz3GmN+UicMZ9QRUu5jJlSxsQ2K5pwkve6986qiA4qYMkrYS
	 OMq9vBerDbbtUGDeTW5yH+ulE7qSBQxTbeBNT3ymDzuyFiQcA4X3clkue2j61jTYQbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9JaaQ41COPekmCvElJxLtvlJ1O5sPRI1q2N3NM3o8UY=;
	b=SMprbQqR14o7q6U3og5AbIatZ7I+Fm9T8d2fX8fYEMZLVLE+t8fM9ge0cto7UdVpTwLr
	 IVecaYjBM9fzLAm8eM/a1/x6PAG561P/1V6Ezv6DXcmuB032G7ljoYFnrtUi42ugLg2mX
	 bbyR6p5blZ/llc67Wlpv10qWbI3izhW0CyHYkoaaJGw69Pcl1OTAQU17pFpei5Gty0dPe
	 sTAZF6DmtYiX/Dv0XGRXnKDo00sOZ5RutSIwdq5IEg/WmoIft9e6wMG4hCZk458D2aVDk
	 l4ByRdKoArgTRFG2H7ClPSaBD72Eoh8jq2gHzCBqvD1D+rOcjikN/gM3j9GkaW81QPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jf27PZc+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B96606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B96606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jf27PZc+
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67db8985419so7328168d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:07:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619264; cv=none;
        d=google.com; s=arc-20260327;
        b=GMZOUMzYMt8cVaZZDq1z4/OCbRmaBhx/WeOdcA+leBQsoXRPiOnjMx1VM6/16gNNFB
         lNB12g3E8s9fzZq05P7i6juOz7y0P9nlixtK2myI0+FK2BKp39VGBRLhNyMuIi28UkxH
         sB4vX2pZME3x7qucnEzUO8icMAlC+EqsTxstVfSy4ugh3XH3cIA+LWdo4FkIiJs6AfCp
         xHz6eFgClecJm+OWgPA5fbC41dzUm+BEcLl8CgSQQIimFV5OlPCR2XN1TSGtObkNZ+mR
         Ai1u0AjBQ6/90vdSkzrjh4M3zoJUHOh7OFefzGS0Bg8tIC70KVEBX764cw57jvZ9ydyx
         +DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9JaaQ41COPekmCvElJxLtvlJ1O5sPRI1q2N3NM3o8UY=;
        fh=XJYgDvkETP4e4OXOI39kHnN3Aa9uPpApAZWb5/OMrns=;
        b=kVemXy6b+XHFcc3GS/HIZXboA/p3d+pS515gD5MCtOYdKI23l8IsGQ+U/ABtu4fqjt
         /Rj2BcGgIlY4o0zOZYtTd5Fd4Pcn5Co8mvCviLwiRqDPZ731b9O7wejSXW6PD3bGVhxZ
         2+7EMGhDUF5LuaiotpMgVfjJIPmbVdOBwSUX5QBNgskmRpizpYG9gXld2sT8ABgaEA2y
         BcVE9lkWU0RYK9EoMAvIHeNicuNclzuzvJKGnowXANyshO2nxOGPwOuzJf1UQ/MY6gy8
         t2ECnfdQxnP0CijZVHQCCFbSsuTmRZlPepOOaWQ60/UkkSY42ENn2pSPOgX4ElZuCHaf
         Oymw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619264; x=1796224064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9JaaQ41COPekmCvElJxLtvlJ1O5sPRI1q2N3NM3o8UY=;
        b=jf27PZc+eRWPutwwoK4r14DA2aAYoDBcuBT8+YKUdwB0fK4xZ/ehA7RhIwHMQ6W1DW
         Gv+acvFE7t3D+bmCidkKJ1g9EmXIGSnX/tgiUMfU3M4Fz3MUC2plJw0hHjLS6tNkpSZu
         tq+XClmGeev+zeU9qHggB+ESFanTH92U2lWumZKMuzkmsetZxvw4jEfJI7Hz9/8d4fGW
         +iRX3EyLpmlzgc6yYcPxRL/UErWXQ1zMMrYuCOc7ZOqdh02NQJxXb5GlqItSsZXpGBkZ
         GMZ6iedouAoAb/evAzVKlciRY3hcVXDV4UDB3zy+ZQfKJZSUgSEYGf/LAkmUOPv9eAVK
         5WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619264; x=1796224064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9JaaQ41COPekmCvElJxLtvlJ1O5sPRI1q2N3NM3o8UY=;
        b=XYVNq1oug1w538EMKxoczIMUBTWmp71BHWkotv/vKrdr/dJ8n1b9Ryn3PV97DHSz9R
         aeCpjvAuX2I5l3RNRN0kg7Nfw97/C7sKr4gfKkIdqnmstM7LWT9urN0ddHe7iSypF/ia
         L2pPZ2lU+Hs1FK6+k81zwUT653e+VV8sbyTiJiGi8jJf0lumIqR0UD2TeilfYTeDohna
         h6Abstr7i5X35JpXtN7IeyuIy+TCaYG/oA+SAbM/4G36ubdqsr3j2HdLhJBpto3ioAsY
         7MTr4Hs2eAHr7BXUjzYxqHHSCrUrGTI19rhCbG5FY+v10pFDmokzSgxzjmOAW9w97nb0
         86oQ==
X-Gm-Message-State: APuU4Z+plE74dLRaouji60Zph0za4BX62sNaCeaKttikINOW2hxhfXpJ
	iC8AmXPzzY7rTJXwGtDSx3IrfC4rj6LYwD2uWhZxnkZLNGdbj9ZAUqXrrj5eRd8qRZf5cz2fhqb
	FJWJjX39ZjKmUhHLH6AY1hyn1/+bPRILPbFJ2
X-Gm-Gg: AZFdTZeVfN5wlowWocCkgQPKjDWdtn+MheYhppKBWJdzH5Jeu+kMdUXImbM4i4+Puz3
	ymkSSad8MAc5ptYid9WjWq79fxcaILJAsqlKbOTZAIcR+IYbxSYKHdfrJ516TKaR7lMG0H+Uz4j
	lZna6ugGALS9I9HwSvudyosLPPjKO0WGl3iT5j45DVz+GZcnI+gs+pS+GGz00+JlrGts5RQHhYQ
	kgHBeJJiyqujDX9EvQVKJ5gRp75JOys521lpn66Yiyu8Vy9lKptmsJQ39Vt/CmJ0WsV5ARk5sYD
	IfU3dKWsb0RZCrtNc6y6rnZ9HMUKFhQEtmSZ1nax7nDF2zZRwiajB8DUjqfFXIs5qtDpjXVE7cH
	IxoeT/eOkIaOtYKASmQv25tHG1MUVTmV0aNGUtPSSdUHeD0tlaRVuWqklG0ZkI6KtJ8uclVSnpA
	nXw5gM6o/VtgSd527xFo0bTkOvL2FYt1Z/jnMCd8sYwni96BSNa7ufYy/0VYcjEvIPt+x3/JVUE
	JupGe4msw==
X-Received: by 2002:a05:690e:1486:b0:67d:b673:f6 with SMTP id
 956f58d0204a3-67df4410873mr9581599d50.33.1795619263752; Wed, 25 Nov 2026
 07:07:43 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124144642.298366-2-simon.mikuda@streamunlimited.com> <6b05f714.98a28ad6.96404.68d7@mx.google.com>
In-Reply-To: <6b05f714.98a28ad6.96404.68d7@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Nov 2026 10:07:32 -0500
X-Gm-Features: Aa3M54ooG5VNBiz_jqvpzxda3tIln5AorxVVX2BNZRlon00MVmushXhINKJPIbQ
Message-ID: <CABBYNZLmK_s-X6D0LhCdOVuFYXKoKV+VDra2WD=Z+0MS1ssqsQ@mail.gmail.com>
Subject: Re: Fix GATT over BR/EDR
To: linux-bluetooth@vger.kernel.org
Cc: simon.mikuda@streamunlimited.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Nov 24, 2026 at 3:44=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1220975/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.82 seconds
> GitLint                       PASS      1.97 seconds
> BuildEll                      PASS      14.31 seconds
> BluezMake                     PASS      183.27 seconds
> MakeCheck                     PASS      3.22 seconds
> MakeDistcheck                 PASS      105.60 seconds
> CheckValgrind                 PASS      103.84 seconds
> CheckSmatch                   PASS      191.69 seconds
> bluezmakeextell               PASS      67.26 seconds
> TestFunctional                PASS      938.33 seconds
> IncrementalBuild              PASS      223.50 seconds
> ScanBuild                     PASS      659.07 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2907

Copilot flagged 1 issue:

https://github.com/bluez/bluez/pull/2907#pullrequestreview-6046550224

> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz

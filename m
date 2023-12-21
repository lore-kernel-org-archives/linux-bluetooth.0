Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209C55E6F
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRB+gFfD"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ca04b1cc37so8971931fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703172441; x=1703777241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJeKKkNsqDpI2MsbiealwxAsm40Et0Bgwn2r2YtAsIc=;
        b=iRB+gFfDW6y18HRcDqL91uG9k9gcGpN+HXjC4f0mr+9Oh9K/wVaWP1a//GV0FHDyt7
         3Dv12yz99lUWuMzDa+8cgApdkhuTKFpTiGMLQVSIKu1HevhQxsLxTE2muwHpojfzf6Wu
         hW0bfHz5D3nm5k4vGbRe8yfy1nGAgA1Si5Psh0YWI7GnMXJFTEiSCw4a9n+WriXJ1H7z
         hjCVKf9vFHyD0FY7qBypmB0vn0kia/hQ5jWa6IL+m6bn3Zfmv1h/yA8LCywAtmcYlBcJ
         mGLZiuMkiLUtOk14dSIlmPUUiZHmw3yONkXVc991gr61fFL0feGLGBJyn3lT6z42h9Gb
         yitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172441; x=1703777241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJeKKkNsqDpI2MsbiealwxAsm40Et0Bgwn2r2YtAsIc=;
        b=OMy3zns7l4tsfox0R5+/ZVAY5Frxh0d8U7dnJeI9wNbXrgbkjo7laY7q/N68lyxMAI
         q32s/QUYGelmoy6WwHEoE/NCbp5rOgwmWZLem1Ainf5px1QpRKiUalypQK90Gff+Z5tS
         kE71l5mwDmSCu758mw68HIPT4BpE8VPL2wamKSaB2evp5+CUDfmbYRvizEyGPVUMp4jY
         /ZmlCvVTPFbd6hoAB5ZKrTev+RLI5sTuz7j3ltjWaWP1QbiaLM5ouqr5CxCgIrz5mi5s
         7QoYXf4gzdrSjrBSR7df29yBEKYyhKfRTxyUv4e2LwBlc0pHS9DLhUciRyx03vYXkVYc
         7ixA==
X-Gm-Message-State: AOJu0YwltRF93NN5O6CBt2pnWs8jEHcljcexKYF/NRET2E8KeDC4sz36
	F6EMI7OeTeekYeHdFqgk+13Yq9zeEVP8qu5ELzZvvwl5
X-Google-Smtp-Source: AGHT+IEtjVuMGbD36HwO/LCEIUhgBUoM5lAmGzMYK7ClC5IBtoQbwNLuw+9XGSEYSJuWeayl5slj6uiqtQYMKEDF2yU=
X-Received: by 2002:a2e:391e:0:b0:2cc:a586:805c with SMTP id
 g30-20020a2e391e000000b002cca586805cmr230689lja.1.1703172440687; Thu, 21 Dec
 2023 07:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ce4dab33868db0a8c7b93bf58c20aa876d50f21.camel@interlinx.bc.ca>
 <CABBYNZLbyCkg+heU5gNDooo2w7Uf+P1To0pVnrhS_z7Be3bTYw@mail.gmail.com> <da55cd171a7055f3438447947f36723e9e539547.camel@interlinx.bc.ca>
In-Reply-To: <da55cd171a7055f3438447947f36723e9e539547.camel@interlinx.bc.ca>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 21 Dec 2023 10:27:08 -0500
Message-ID: <CABBYNZJJgYJcswhLcR49H5AE-z7C74HeguwsvHq_BqWr8e3wtw@mail.gmail.com>
Subject: Re: chrome passkey communication timing out
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Thu, Dec 21, 2023 at 9:27=E2=80=AFAM Brian J. Murrell <brian@interlinx.b=
c.ca> wrote:
>
> On Tue, 2023-12-19 at 12:49 -0500, Luiz Augusto von Dentz wrote:
> > Hi Brian,
>
> Hi Luiz.
>
> > Check with btmon what if that is generating any traffic.
>
> Ah, yes.  btmon.  Forgot all about that.
>
> Bluetooth monitor ver 5.71
> =3D Note: Linux version 6.5.11-300.fc39.x86_64 (x86_64)                  =
                                                                           =
                           0.208407
> =3D Note: Bluetooth subsystem version 2.22                               =
                                                                           =
                           0.208411
> =3D New Index: 70:F3:95:3E:92:34 (Primary,USB,hci0)                      =
                                                                           =
                    [hci0] 0.208412
> =3D Open Index: 70:F3:95:3E:92:34                                        =
                                                                           =
                    [hci0] 0.208413
> =3D Index Info: 70:F3:95:3E:92:34 (Broadcom Corporation)                 =
                                                                           =
                    [hci0] 0.208414
> @ MGMT Open: bluetoothd (privileged) version 1.22                        =
                                                                           =
                {0x0001} 0.208415
> @ MGMT Command: Start Service Discovery (0x003a) plen 4                  =
                                                                           =
        {0x0001} [hci0] 24.471901
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                                           =
        {0x0001} [hci0] 24.471919
>       Start Service Discovery (0x003a) plen 1
>         Status: Not Supported (0x0c)
>         Address type: 0x06
>           LE Public
>           LE Rando
> The "Not Supported" is not entirely lost on me.  But what exactly is
> not supported?

I think it doesn't support LE thus why it can't discover.

> Cheers,
> b.
>
>


--=20
Luiz Augusto von Dentz

Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA963321B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/qB1ySV"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso6544435e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703008210; x=1703613010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPZgZftZPMCR/U8Z4jTEHFWpxoolhOxzvH3+CLdiPIc=;
        b=Y/qB1ySV2IdEcMTsXNUzUMYYJQuE+pyQh/Nt/4Njhsegjsb3EbOZOZP3IdWt32EkDH
         6TBRQ1vSIgzG+ZrOVachqR4P21W1Zy3xFSutRl5iT5tQNy21bb4ZRkTwHhSjG2wVvneh
         8mfMUh2suZO8jvavrwEBgTJdaHvJpBTv+4EVuI/B1IAoBulwoe6pbELfmX7wXo2eAQtv
         YKWt0jDIGetoIt5It1P8Wooboqdf9fzuqwOwmyLcGt24WK6fjdSeu67NSQmfEQMU6tC0
         LXTOiLkfNeE5Ii6Z6y+YSIVJBNasr2VTEeMa6B6X3JYmuUz2k+vfAKvwxzv3dPBdjLCo
         jUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008210; x=1703613010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPZgZftZPMCR/U8Z4jTEHFWpxoolhOxzvH3+CLdiPIc=;
        b=b4FJc6j787405P6AoqejxDxWJ7Kc5+qRIugOoYH56nmvyEKlmTWs0XpISVYpG650Zw
         eSyO04mHAX4elzVvhPdSxG7p/A7AWVx2mPPcYea1HyIcj56obr6V30wjzGCswBA67DM1
         IPj2DC5nw4MLZLzrSRN8fg9IXL+584lIxDe1Qmli4TlUQUMxE0cKk5Qu8iW+NGaoFM+t
         wtTzY/EafysVLQYzNfYMenjUH2x17sg8CiYeQUeiFb+tOeWocOhr979P4FUsROZalC2l
         iglXRFt+5LKo2HsYh+dzRIWISfVV4Poj4AhUEFwGz4SJWAkWQzUM/dIov8+SdUR5FqUS
         SjMQ==
X-Gm-Message-State: AOJu0YzRxX1AkpkdMl3Dxn00bC2md+OejI7TbxviGBHITt/GUPNznTK2
	Z+t6fvfqUVQL74syZ0izQqh9+7pvSoDhBa+Q4rHJnNE1
X-Google-Smtp-Source: AGHT+IGtkSr2Nv85Wmc6GuQCz6oUIwpWhthJ6rE5HUfTivaMISJgdAT6PKsP00AV1UGvmf7bXuOLZYEkHCPjoY+pLG0=
X-Received: by 2002:a2e:be11:0:b0:2cc:7744:971f with SMTP id
 z17-20020a2ebe11000000b002cc7744971fmr2068703ljq.92.1703008209455; Tue, 19
 Dec 2023 09:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ce4dab33868db0a8c7b93bf58c20aa876d50f21.camel@interlinx.bc.ca>
In-Reply-To: <6ce4dab33868db0a8c7b93bf58c20aa876d50f21.camel@interlinx.bc.ca>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Dec 2023 12:49:57 -0500
Message-ID: <CABBYNZLbyCkg+heU5gNDooo2w7Uf+P1To0pVnrhS_z7Be3bTYw@mail.gmail.com>
Subject: Re: chrome passkey communication timing out
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Tue, Dec 19, 2023 at 12:35=E2=80=AFPM Brian J. Murrell <brian@interlinx.=
bc.ca> wrote:
>
> I am trying to utilize the facility in Chrome to be able to use
> passkeys stored on an Android phone with the demo site at passkeys.io.
>
> I have tried this on 3 computers I have access to and it only seems to
> work on one of them and the Bluetooth operation fails on two of them.
>
> The one that works is running Fedora 38 with bluez-5.70-5.fc38.x86_64
> on a:
>
> Bus 001 Device 005: ID 8087:0026 Intel Corp. AX201 Bluetooth
>
> BT adapter.
>
> One that is not working is running Fedora 39 with bluez-5.71-
> 1.fc39.x86_64 on a:
>
> Bus 003 Device 004: ID 0a5c:2121 Broadcom Corp. BCM2210 Bluetooth
>
> BT adapter.
>
> The other one that is not working is also Fedora 39 with bluez-5.71-
> 1.fc39.x86_64 but I cannot seem to see a BT adapter in the output of
> either lspci or lsusb.  But I can see that it has a BT adapter:
>
> $ bluetoothctl
> Waiting to connect to bluetoothd...[bluetooth]# hci0 new_settings: powere=
d bondable ssp br/edr
> [bluetooth]# Agent registered
> [bluetooth]# [CHG] Controller 70:F3:95:3E:92:34 Pairable: yes
>
> Any clues or hints on how to further debug why these two non-working
> systems are non-working given that this does work on the third system?

Check with btmon what if that is generating any traffic.

> Cheers,
> b.
>
>


--=20
Luiz Augusto von Dentz

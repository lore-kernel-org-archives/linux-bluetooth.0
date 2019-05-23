Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732E3C282E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443272177E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 21:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJjSs1Ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbfEWVSo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 May 2019 17:18:44 -0400
Received: from mail-vk1-f180.google.com ([209.85.221.180]:43530 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387785AbfEWVSo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 May 2019 17:18:44 -0400
Received: by mail-vk1-f180.google.com with SMTP id h72so1665590vkh.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2019 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QyHNrUNeMazF6mWb9H8ygEL5bietKjDcesYfcxi7eSE=;
        b=XJjSs1YmTmGrpv/CS5Tvvhcwladt10Q/MIyFSc2t5wJyeBcTYWlJ3V3qDrO+jq1uHZ
         Y6Ju7GmgtS4BKDQBRSF9c4slJ7/q8SupTjIMzSOcEDd6lYC9l0pOyTw5rpuVlFEdupOw
         MMfq4WhPfwPDJ8EogDWnDSuAQVPjKTmmif9KJvQNhEx+Ho2WFLLUXGO3Q3OKg3bXzP3r
         Kr2M5zVp1r0qZK5TqJfvgUQrVWit++AJuJxRLJT8tITrBtntWeElPzkWayoM70UImS4c
         EfHM98T8F25Kz8p06B7cvVVuLq7EWdJJDqTayn1cUzRvm+XDoERZNDTVnNc8qzQgjPeW
         RN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=QyHNrUNeMazF6mWb9H8ygEL5bietKjDcesYfcxi7eSE=;
        b=GVQM0qI1Hvm11XWeiAY7Zf6nUWLOx12ZO/jIiDw+CT2/ESFC8AfSuASqNs/fGObdFj
         Fllge4d9jPHPrvwRenK+lXclXS7zhbpf0d+O3cF+2H9xhUW4VkMIaiTXPYSupHR0OPnC
         qOeziXw0/QWgaKgitMk7lk+WujXMcDMEp1Lc6KBgYqC91lv006FSUKQsrB4LelXVwmAG
         EjEECL9meZtBaXXZRxdFj7v/clJuI5IMUD5J8Csj07AJvG4JoQDUmZWMMtQJ6BVCTLFe
         HeJLDFUVVR7Z7QMc2JuBHqv0KOwyz7LuofW8Rh17R0qNl95EBIyI+8utpu5pckc1w9el
         o/uQ==
X-Gm-Message-State: APjAAAUgzzv4VanPxjd1kHYPULQSVY0RKqCDyqXeFLs1oOWGZN79eZxE
        G4tQBFCY2YKCcApKU5xJlYf2vNKYvzM/bb7tgXUpFzDW
X-Google-Smtp-Source: APXvYqxnMCv1hx8ffp7GBObRKIAMC1TMQbtzr8UxW9Soj8m41H/BajQoTYPj7skQxxjR/bPasfoA4zq5RiKpxBKBMxw=
X-Received: by 2002:a1f:2157:: with SMTP id h84mr2731323vkh.84.1558646322689;
 Thu, 23 May 2019 14:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOJ+TdvyHxe7OAgzJsg7Ar1QmoSyWuGqWn0b2rbFXq7xW3B6yA@mail.gmail.com>
In-Reply-To: <CAOJ+TdvyHxe7OAgzJsg7Ar1QmoSyWuGqWn0b2rbFXq7xW3B6yA@mail.gmail.com>
From:   Moreno <morrolinux@gmail.com>
Date:   Thu, 23 May 2019 23:18:31 +0200
Message-ID: <CAOJ+Tdv3o=gNDPvRmj27aO6tAgk7A+T+H3DZF0LEfNHLBj8Vng@mail.gmail.com>
Subject: Re: a2dp sink delay via AVDTP
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bump? Anyone know what I'm talking about?


Il giorno mar 21 mag 2019 alle ore 12:00 Moreno <morrolinux@gmail.com>
ha scritto:
>
> Hi,
>
> I am building an ffmpeg-based audio sink system to use a Raspberry Pi
> as a bluetooth speaker.
>
> Since the audio takes quite a long time to get past the processing on
> the Pi, I need to tell the bluetooth "client" device how much delay
> should be added (eg. for video playback) for it to be in sync.
>
> I've looked at the code and it looks like it's fully supported, but I
> don't understand how to signal bluez (running a2dp sbc sink profile)
> an extra latency for the source device to be aware.
>
> Can anyone help?



--=20

per il supporto tecnico rivolgersi a
Moreno Razzoli
__________________________

       Avvertenze ai sensi del D.Lgs.196 del 30/06/2003 Le
informazioni contenute in questo messaggio di posta elettronica e/o
files allegati, sono da considerarsi strettamente riservati. Il loro
utilizzo =C3=A8 consentito esclusivamente al destinatario del messaggio,
per le finalit=C3=A0  indicate nello stesso. Costituisce violazione ai
principi dettati dal D.Lgs. 196/2003: trattenere il messaggio stesso,
divulgarlo anche in parte, distribuirlo ad altri soggetti, copiarlo o
utilizzarlo per finalit=C3=A0  diverse. Qualora riceveste questo messaggio
senza esserne il destinatario Vi preghiamo cortesemente di darcene
notizia via e-mail e di procedere alla distruzione del messaggio
stesso, cancellandolo dal Vostro sistema. Grazie.

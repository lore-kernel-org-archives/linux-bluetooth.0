Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5F4C2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106F32133D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xab7iA0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfFGP0M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:26:12 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:32993 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfFGP0M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 11:26:12 -0400
Received: by mail-ot1-f45.google.com with SMTP id p4so2234578oti.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oqkqK40ngbU0ZTTKPO2ff75rwvhxwLKkLy757CmB4PY=;
        b=Xab7iA0PcFEZ/GQ2w8cop7B3szq6wia61i/EOqqIKyGns8dXfYolvNhQmVs4rYcQCs
         dd2+Ewu8Ir/V7ZJu9UdrvATe97B382ChDtBaaRS9Eagq2x2margTkbGYYPsLGE7LZSIV
         h9M+93MSvehs66CMGvXbopTi5HUHNmiKx8NrTCxjJ25AX5NUDYAQbs5k6LFgvfWHTewQ
         AUE/YVO3r0xhr9I2uyLuXhn9MIVW75ICKZ0zbQYIKKzQPdVsezLihxJvt8LM7B2UO/Tk
         KmlgGeGBYlXr9Od//rd1Tyj7+s0ST23oBTnzOUOaxTZjM8WL4ufPOVi2Yra1u+o3B3wz
         hvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oqkqK40ngbU0ZTTKPO2ff75rwvhxwLKkLy757CmB4PY=;
        b=EzFEbBC21b/BrWHDe716SJICSyikmz+seonFUETwOsxjqiMuo/CqanJB/5fDQCc7jM
         Knn5rkOEVo6qAdNXDkWFc0erMnKOIBTrwrWJ9XT1SgtMDJasQK4fFX4h6/9Dwe33AHPo
         mFk7KUVrSFTa/Lndcxkj5+3p7MCmEIhZmYAhbui+NxJLD9n5VaNG/J/VNsM/0oUs5/ov
         yuVlREfy4LM9lO/ak6SVy8ydLjrBBm7xGWKGf6EYue68q6dE7zH20nChpgbGv9CjiqJ4
         k3UWdjRsEwYgWjWAiH9KeUn5VL2JU8zmWb+y5iw/NfNRbJbtMr2Q3DkuLhB7DcigkGRW
         ePzQ==
X-Gm-Message-State: APjAAAX2ghnKLMPXQDcx/mcKX0TatTwOl8PleoHqbjF2ReTrqn/T/xn4
        QZGDeI4FS9tLFmPUDzEf8aDvYvCWGhbi/bjh9c4=
X-Google-Smtp-Source: APXvYqyM4y99ONpsE/LDduGy3YnK3+z/NT7SascR/siHWB8Bc/32QGDePcsKUUQTqEdlQ1YaaXptRcVvZqYZouA/gRs=
X-Received: by 2002:a9d:6217:: with SMTP id g23mr20203328otj.11.1559921171771;
 Fri, 07 Jun 2019 08:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190513170550.bsbr2mh7w36hj7io@pali> <20190607125800.trsx2o3njaiaitu2@pali>
In-Reply-To: <20190607125800.trsx2o3njaiaitu2@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jun 2019 18:26:02 +0300
Message-ID: <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
Subject: Re: bluez - check for new a2dp features
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Jun 7, 2019 at 3:58 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Monday 13 May 2019 19:05:50 Pali Roh=C3=A1r wrote:
> > Hello!
> >
> > In current git bluez master repository are new features related to A2DP=
.
> > E.g. support for codec switching or fallback to other local dbus
> > endpoints when current selected rejected connection...
> >
> > Moreover codec switching support is behind experimental runtime switch.
> >
> > For pulseaudio a2dp module I need to do runtime check if above features
> > are supported by currently running bluez instance (which registered to
> > dbus org.bluez. It is needed to ensure that pulseaudio does not
> > introduce regression for older bluez version without above new A2DP
> > features.
> >
> > But currently I have not found any way how to detect if bluez supports
> > codec switching or if it has support for trying another local SEP for
> > connection.
> >
> > So, could you please export e.g. bluez version as dbus property? And
> > also property if codec switching is supported and enabled by that
> > experimental flag?
>
> Hello, I would like to ask for some possibility to export these
> information. Without them it is not really possible to have stable
> implementation which would work with both old and new bluez version.

I wonder what you are talking about since your changes do have checks
for when endpoints are detected, isn't that enough to detect if one
can switch codecs or not? This logic used to work just fine last time
I tested it.


--=20
Luiz Augusto von Dentz

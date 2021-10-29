Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC82EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 14:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26FE61175
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 14:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhJ2OPw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhJ2OP2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 10:15:28 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A291C061714
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 07:13:00 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t127so24419943ybf.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+rJt4ov4+izLAsb0pyA43/TdrlqNH3tPdm5bor1QYag=;
        b=RfMZgD1sXygGqupmqGoOYrDXBXbPUKH0bdt+a/UhJ8fRgCpBQoHMkrXn/7I3Mo4HbT
         GZF7D2mdtynEEgLNZRWycZTP77wwgzEFPtK4/deRFqk1IO5efyMfKf8vqg5qJJpiOLBO
         HFhfDqDJDagSYR/eSVl7Wj2lOljnO7kdlKjEON4bHpOf0fGETJKvwJK2ji6tY/mQITXQ
         bBQ4MR/6WbcreUb1dTZwvtuQLthFbY7O7OE3XbbrUkeQvTMkw1fpcybEVBZkZqK2SW5y
         5bNZJ9zP1pdPigzeY73yS93QlPMfpL5i6Bf3RCEvcODuLzTY2xDAaUehAE3UUX+8/m/G
         mVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+rJt4ov4+izLAsb0pyA43/TdrlqNH3tPdm5bor1QYag=;
        b=IQ5kLOfIhlDH4jyV+40ftfRTZ1sGNV3F1+kzLAMzcYNaFJnsFuJbcY7OeOw7OH3QYy
         ovN2R2zCjIpuw+1SeESpcc2M133FCIODXrHiMVyaEyX2BBZXLST9PIf8MaIsIVrfkrxF
         NFITUubfIK4K+WjWF2HDkDXnHPfRK5m4zRDlslJPim6El6/2+IfBezbbGgdGpKjdLOx5
         lM3VfjzWHPJKELEJVFCA5fR6aS6djXRgpGgz3xskKW6uoLoQr3lLtGmOJfyRcCdT79Kk
         hnpr83E4xzeJ1JfA0bkQUV11/lQ8IQy3F5MogDD0A/VICsonUAh/rkSPnu7sTovEZugU
         5lhA==
X-Gm-Message-State: AOAM5338CvHY3FQBd92KwJqXot6tbFglouZNRBf7zHlsFiLQaWMtfH/S
        SddX7OFMW/+h9+qdUJdWV5Sl1jDx0C72es/z5MOxCQ==
X-Google-Smtp-Source: ABdhPJz8mkH0/PwXRtut74eX9v8EiIMUP7B3CU3hsMNud3yektEYYX5kvaF4lsgAfBKhhBDn0kaWfEHFNpyRfsKohRk=
X-Received: by 2002:a25:3817:: with SMTP id f23mr11736645yba.436.1635516779311;
 Fri, 29 Oct 2021 07:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211021230356.v6.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
 <20211021230356.v6.3.I257ac5cfaf955d15670479efc311bbab702397f4@changeid>
 <AB7796C2-6543-43CD-8FA3-DAF57AB68767@holtmann.org> <CAHFy41_y8LS81gTHNidMdrD9tpeXf0YyvHaTKZJU+jmjuFgYXQ@mail.gmail.com>
 <92566E17-4D3A-4FB5-83B2-E2B9D4BBE2EF@holtmann.org>
In-Reply-To: <92566E17-4D3A-4FB5-83B2-E2B9D4BBE2EF@holtmann.org>
From:   Joseph Hwang <josephsih@google.com>
Date:   Fri, 29 Oct 2021 22:12:48 +0800
Message-ID: <CAHFy419JNEh6DZ68+JBLFOyp_jJgWv9nSy1ejvD1hECsDgbT6A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] Bluetooth: btusb: enable Mediatek to support AOSP extension
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWFyay1ZVyBDaGVuICjpmbPmj5rmlocp?= 
        <Mark-YW.Chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel:

  I see your point. Thank you for letting us know the right way to go.
I will discuss with Mediatek and request them to implement their
specific setup() for the purpose. And then they will submit a new
patch to enable AOSP extensions for their hardware.

Thanks and regards,
Joseph

On Fri, Oct 29, 2021 at 4:21 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Joseph,
>
> > Some of Mediatek's controllers/firmwares do NOT support AOSP extensions=
.
> >
> > Please refer to this Gerrit patch review link for chrome os
> > (https://chromium-review.googlesource.com/c/chromiumos/third_party/kern=
el/+/3054233/8/drivers/bluetooth/btusb.c)
> > which was reviewed by Mark-YW Chen, Mediatek's engineer.
> >
> > As an example, MediaTek MT7615E does not support the AOSP extensions.
> >
> > That was why I used a new BTUSB_QUALITY_REPORT flag in the changes v4
> > and earlier ones.
> >
> > Please let me know how you would like to proceed with this patch.
>
> I want that inside the Mediatek specific hdev->setup() procedure, they de=
cide if AOSP extensions are supported or not. The BTUSB flag business is ge=
tting out of hand. I really don=E2=80=99t want that in btusb.c anymore. I m=
oved Intel over to do that in btintel.c and also Realtek is doing it in btr=
tl.c for their hardware with the MSFT extensions.
>
> We are not doing try-and-error of HCI commands. Just keep that in mind si=
nce I said that multiple times now.
>
> Regards
>
> Marcel
>


--=20

Joseph Shyh-In Hwang
Email: josephsih@google.com

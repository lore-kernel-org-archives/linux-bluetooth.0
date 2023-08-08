Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22646C001B0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 19:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjHHTZF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjHHTYn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 15:24:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1570C19AEE
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 11:48:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so9944798e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Aug 2023 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691520533; x=1692125333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoodR5ArBk0FJd9gWAcbz5q0RGKPZm2B2XXckGBxQTU=;
        b=bCga+rv5bOS6x5tUPfy9z+GFGo0C5yj/y+yWikK2K2umiJCdTAx0OpnooqeGVad5P+
         J5VS5JdVs9FmYWbrj4lG+k+Yp4USk4MZ6CJv+A4PWcs7NBMGy4RnUsqNgtWPVn1roi1R
         FXOOQdQJ6mOOcsdQeEDRw8s83LHoOfoWd/0B77DhneAnodXxLfQnkRmPzheBDSbVjbk9
         XH9CGS4NOtyMIUhuM8kyZoOQnCufQP1I9v6k8hpYTie/cLfnU7FIBwLXOIEyoSIhL6S/
         7QKRoQQWJIeXLTlb7THMh+F4qqkvAqlPNy8ff3zxozDA6/+XB+jdbDswf1LMkpYl7Tjj
         27oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691520533; x=1692125333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoodR5ArBk0FJd9gWAcbz5q0RGKPZm2B2XXckGBxQTU=;
        b=If0SM6WhrIG23UCvqxPYf+gJHKLDR7zyYBfExH1Cd+8b6akpCH2/RawoavCDTS11Hk
         9hyHxWH1ErFICPi4TVfo7eKfB/Z95PpLbq2WZAGyMzdhTg62V9fYcsjEz4dll4HpYStF
         PU+m0cq8x1IFa5GrAhuZI1I8naOVWP3yH/cVQ4/2sbLYWtAXSlJKZ2qgr36KkwIj44n4
         3mivIh8IS/CFEZZlbyJAfsKPFWMmYcvouCov/IBqqNMhKfjXN8gXQ7dJfZmgxJ+IIk0E
         MQMR8a3B6DGJnH4Ug0ZjTnF0FevqAmtSZ5P5/5qj5cLpqciYcmM6ZmgtkjZ4QR25Ja4p
         Mv/g==
X-Gm-Message-State: AOJu0Yws6N/e2mFwGZfXGDjTfJ+nm5cH3BaERvjXO0fvDXEk4wnufFlI
        lDYLLVN2UkCQCvQFcBniErAXvIyDQFGrPLmrOkv/2fTCaXg=
X-Google-Smtp-Source: AGHT+IHhH7lGrPt7r0XpcRn1Kl/g0kXwVJNIY8P6aEItHovhToKiVRsnOgpKpY1Ujp/uTDoMqqETtU3lvFi+k/MpMnk=
X-Received: by 2002:a2e:8759:0:b0:2b5:1b80:264b with SMTP id
 q25-20020a2e8759000000b002b51b80264bmr271920ljj.12.1691520532973; Tue, 08 Aug
 2023 11:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230808085540.1475435-1-gioele@svario.it> <20230808085540.1475435-2-gioele@svario.it>
In-Reply-To: <20230808085540.1475435-2-gioele@svario.it>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Aug 2023 11:48:40 -0700
Message-ID: <CABBYNZLfUaVzERO+ddHkoE39mObZ+uAm8EF+VXngKyQZ4rJjRA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Makefile.am: Install D-Bus policy in
 /usr/share, not /etc
To:     Gioele Barabucci <gioele@svario.it>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gioele,

On Tue, Aug 8, 2023 at 11:23=E2=80=AFAM Gioele Barabucci <gioele@svario.it>=
 wrote:
>
> From https://bugs.debian.org/1006631:
>
> > dbus supports policy files in both `/usr/share/dbus-1/system.d` and
> > `/etc/dbus-1/systemd`. [The] recently released dbus 1.14.0, officially
> > deprecates installing packages' default policies into `/etc/dbus-1/syst=
emd`,
> > instead reserving it for the sysadmin. This is the same idea as the
> > difference between `/usr/lib/udev/rules.d` and `/etc/udev/rules.d`.

I'm fine with these changes but we also need to bump dbus dependency
to 1.14 then since it currently requiring 1.6:

PKG_CHECK_MODULES(DBUS, dbus-1 >=3D 1.6, dummy=3Dyes,
                AC_MSG_ERROR(D-Bus >=3D 1.6 is required))

> ---
>  Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 4b9b7e5cd..f23c39d20 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -32,7 +32,7 @@ confdir =3D $(sysconfdir)/bluetooth
>  statedir =3D $(localstatedir)/lib/bluetooth
>
>  if DATAFILES
> -dbusdir =3D $(DBUS_CONFDIR)/dbus-1/system.d
> +dbusdir =3D $(datadir)/dbus-1/system.d
>  dbus_DATA =3D src/bluetooth.conf
>
>  conf_DATA =3D
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz

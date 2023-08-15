Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCADC0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 18:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbjHOSAD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 14:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239012AbjHOR7w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 13:59:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00C10D1;
        Tue, 15 Aug 2023 10:59:50 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b962c226ceso88714621fa.3;
        Tue, 15 Aug 2023 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692122388; x=1692727188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6NHmk/DgGXyST2YEwWwlaKi2K/9fFe8f3GMLQJZvUg=;
        b=U4tS8SwR1/aseYZ2pAs6GJuRc6XQkGa+gTD/zUkXpxOTSusuiITMuPp0fKykCz1KUm
         ZqctaUbNL2HAnGYLCdCKI84T7xbS+uyZS/iFInww9gx4JnXxYut5muYyNYStEJEi0dFc
         Y1tZ5FOFtfUpTVVBhE2snX6RM+S2dz/0rijkw1TfHFvXgw3jvfdH86D6u3uS2NMm/YUI
         i6Z5PCIIe1UW9j7IbjD+7tba3Qayon6FG/VjgBK649k9epHN5dHG/Q6ozv6VCDFOtoA7
         kpJvFK/83/OZVmOh2znbtWgAjLWf0c5HvxwdyeWby1omnYN+4YTFSumV8Jr+k6jWQTdi
         wkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692122388; x=1692727188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6NHmk/DgGXyST2YEwWwlaKi2K/9fFe8f3GMLQJZvUg=;
        b=fO2NBRiE9zCkHWcuBK3W0QPiEhOxuPVDWj3ozl23U6RBYeFogCdl/R8hgeCY0hh28V
         mDy+cdtSln6W8u/vN5xP4ePLjjP2N9K0y00IxiKf+B2B3gQ6531vug/3/c+567F0WgG6
         dfY1GP8UoxNb9EfsjqMrGdn/C7b5Z7vQOht0fsP2kh+1y1Mk/bemz4Z0d3ANMmOD2Zn9
         YqtSESBjdDGjzsnEZUESfZsz17B0Lz2LSsipceWBTD8ICZyt3wTBtd7SHn+7JDA6tknU
         OIvx+ymOKu60Us8W8oetbZX/pNcgW596W4VG23hBPuC7nIjNDXSKmmUceDDr8zB3LyTw
         wUUg==
X-Gm-Message-State: AOJu0YxNCwX2worOLge9CnAcAUw08qGr3sJKO9HNlQw5kJDo6NDkfPoh
        n0K4I2d/mJSBlEInkFH8Y069GKDPLZJRuyZqPQg=
X-Google-Smtp-Source: AGHT+IHxeGu09Tc4NJA+lpMNiy5ztuNkF3kT3ir3FHuKDj6HH6KUnBRAXKrYdJVJqgJAewNhREeL8BtOLXno/MERbyQ=
X-Received: by 2002:a2e:a0cc:0:b0:2b5:8bb9:4dd6 with SMTP id
 f12-20020a2ea0cc000000b002b58bb94dd6mr9410143ljm.12.1692122388168; Tue, 15
 Aug 2023 10:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230811192256.1988031-1-luiz.dentz@gmail.com> <20230814164546.71dbc695@kernel.org>
In-Reply-To: <20230814164546.71dbc695@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Aug 2023 10:59:35 -0700
Message-ID: <CABBYNZJmkOpPgF6oox-JAyGAZRxzX7Kn9JQpLPXi_FR=Cf-FOA@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2023-08-11
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub,

On Mon, Aug 14, 2023 at 4:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 11 Aug 2023 12:22:56 -0700 Luiz Augusto von Dentz wrote:
> > bluetooth-next pull request for net-next:
> >
> >  - Add new VID/PID for Mediatek MT7922
> >  - Add support multiple BIS/BIG
> >  - Add support for Intel Gale Peak
> >  - Add support for Qualcomm WCN3988
> >  - Add support for BT_PKT_STATUS for ISO sockets
> >  - Various fixes for experimental ISO support
> >  - Load FW v2 for RTL8852C
> >  - Add support for NXP AW693 chipset
> >  - Add support for Mediatek MT2925
>
> As indicated by Stephen's complaint about lack of an SoB tag,
> it appears that DaveM merged this PR over the weekend :)

Ok, since it has been applied what shall we do?

--=20
Luiz Augusto von Dentz

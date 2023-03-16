Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31304C7618A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 19:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCPTR5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 15:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjCPTRw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 15:17:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C9AB32B1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 12:17:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id er8so25755edb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1678994269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvbBMT7ofHzrbvXt+PN9x+UJpe8YiYYHtlZEo+jEfTM=;
        b=heuHIWUccDy7S2Y8CmxkFumgitLqUSXgd84is/kjJO7/dGJ1qBPGqCXJjlLv8aE+HA
         tGUKnK6FcsrZRrZ31SvxN0FxZgpDNTYlPBo2rOocBGTB+0Qk9HeNT32/uevX9z7FOzQN
         RggEnVbUY9SAbSRZnGTVcmrSAAs7tyK87gX96c2OArvgHIrcKyTscq4GK0KlwXuoQ8Wf
         lUtPskqfSzAtP/zCD8CP0lLMZ1JP/lLO/75gNgsuxT2KomkLX1sb3yQgXkT6CNHfjE5q
         KlLOyZBrhis2D/ab3w3tn/UqTu+Idu3zOUpnwWZiTIq9vCrJS5ClgtPNcl8KyCDvhtsW
         v5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678994269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvbBMT7ofHzrbvXt+PN9x+UJpe8YiYYHtlZEo+jEfTM=;
        b=4N3iamuFguYevTBX+DVl2nZU96lancBce/UPc5tS5aLh3fOgko5PYZ0WYaQ1BKKmjJ
         FgN+6nNKryIXKZBkFA+eHiBoFJUxKDJQoLRgKxuChQKg601aQWB2569Tkfq7Nx3PnLGT
         b2R/AqJ907RvlztPXTT8aKphX+h+i8pmD547VBhwdxJfellTs1xK5Z62/Moso/Yx2ITA
         GXTYopSQy5bYIngd8ya5vTFqjzOfxArFw22eSxO8lKC7JYSlSG4kqtEfo7J6uwv5Aity
         fv5AHXiGcm7gnZP0q3Io3Sv70MMluV8awiRURNH4wlwaFwA5H1yvjXPeHNJajsRhfbER
         SaNg==
X-Gm-Message-State: AO0yUKVnCh4licxApFwk5SZ3sMzWQvi1yqNdh3B60unFCiwoTmQgQzlU
        cGcUy8csLiLVirtf6htHVVFvBg16dacgdvgA6BaJtA==
X-Google-Smtp-Source: AK7set/kjprnV34qU3c1tgSinbRc90owaG+ycfoAtwQQ2Faa3s1pMXyrGprH3Sd/BLCv/uSuZUHRkGIxcWzoU10Kpho=
X-Received: by 2002:a50:954e:0:b0:4fb:9735:f913 with SMTP id
 v14-20020a50954e000000b004fb9735f913mr400241eda.8.1678994269329; Thu, 16 Mar
 2023 12:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230316034759.73489-1-steev@kali.org> <20230316034759.73489-5-steev@kali.org>
 <ZBLuxFxFvCY+0XHG@hovoldconsulting.com> <ZBL4Qrp9Lr+aOyXr@hovoldconsulting.com>
In-Reply-To: <ZBL4Qrp9Lr+aOyXr@hovoldconsulting.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Thu, 16 Mar 2023 14:17:38 -0500
Message-ID: <CAKXuJqh447rZxDZ28aCiRZaL=uj5xDULhyU=HUbFVePYyz7AOw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] arm64: dts: qcom: sc8280xp-x13s: Add bluetooth
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

On Thu, Mar 16, 2023 at 6:05=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Thu, Mar 16, 2023 at 11:26:12AM +0100, Johan Hovold wrote:
> > On Wed, Mar 15, 2023 at 10:47:58PM -0500, Steev Klimaszewski wrote:
> > > The Lenovo Thinkpad X13s has a WCN6855 Bluetooth controller on uart2,
> > > add this.
> > >
> > > Signed-off-by: Steev Klimaszewski <steev@kali.org>
> > > ---
>
> > > +           vreg_s1c: smps1 {
> > > +                   regulator-name =3D "vreg_s1c";
> > > +                   regulator-min-microvolt =3D <1880000>;
> > > +                   regulator-max-microvolt =3D <1900000>;
> > > +                   regulator-initial-mode =3D <RPMH_REGULATOR_MODE_H=
PM>;
> > > +                   regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_=
AUTO>,
> > > +                                             <RPMH_REGULATOR_MODE_RE=
T>;
> > > +                   regulator-allow-set-load;
> >
> > So this does not look quite right still as you're specifying an initial
> > mode which is not listed as allowed.
> >
> > Also there are no other in-tree users of RPMH_REGULATOR_MODE_RET and
> > AUTO is used to switch mode automatically which seems odd to use with
> > allow-set-load.
> >
> > This regulator is in fact also used by the wifi part of the chip and as
> > that driver does not set any loads so we may end up with a regulator in
> > retention mode while wifi is in use.
> >
> > Perhaps Bjorn can enlighten us, but my guess is that this should just b=
e
> > "intial-mode =3D AUTO" (or even HPM, but I have no idea where this came
> > from originally).
>
> This one probably also needs to be marked as always-on as we don't
> currently describe the fact that the wifi part also uses s1c.
>
> Johan

I couldn't remember exactly why I chose HPM, and so I recreated what
I'd done.  I looked to see what modes were available by git grepping
the kernel sources and since they are in
include/dt-bindings/regulator/qcom,rpmh-regulator.h with a comment
explaining what each mode is, I picked HPM since it starts it at the
full rated current.  As to why I chose the others... it was based on
SMPS being mentioned in that comment block.  Since I wasn't sure what
PFM is (and admittedly, did not look it up) I skipped it.

And you are right, we probably don't want to yank that regulator out
from under the wifi...  will add that in v7, so I guess for v7 we want
HPM, LPM, AUTO with AUTO being initial.  I guess I was trying to think
that RET would allow as little power usage as possible when bluetooth
isn't in use.

--steev

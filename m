Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B0CC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 15:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCVPfT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCVPfS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 11:35:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989393A4ED
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 08:35:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn12so28966868edb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1679499315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAXNJjlL2o5XEbhFXFeTRkQ4rqR7tfyx01Kl+xPl+TQ=;
        b=M0hMymF57cLJVxIdanY67+ipTZUSyJ3BFUpfOvk/wnSt7sM0FFQsFGPv/FVPXt52b1
         cnAhBA5HNVemraej7KO70E9DC+lETcqc0P6H6H0sNpELYliTovlfXP5CTPj/RiHWCtkr
         Y6Vv4fYzyzO+90/A/5PW6uu4QyCSZoUYRD/NTdvJxLi0NcIlG/zRR6iFM4HZjpmq1h/6
         M2gGOe9XJN7gpkBVHoC3Y9BlkMwASlLZkoKz28XwRstuNng39JeYI2e+bjOi63A1nMfz
         TWA6DD8EnfR3tHdqewHTP7mx8cyMFTGEvyJ92YLNR85pWBZhzUcEZEzs/pRO9ivusoS3
         bgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679499315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAXNJjlL2o5XEbhFXFeTRkQ4rqR7tfyx01Kl+xPl+TQ=;
        b=05qIf+SzB1jqY7P/r9MGOfJVNzpB2q5GoBNTfVBReGD5pVjIsGl/svVbXwjP1W1vOl
         QeOwhq//oCfPTkbhhtsqm7EUIB9ixmfW09DfDsJtZaXwpPFVlTndwR6DpsFnVFk5PH7k
         YBgmKWNcYoRLeCoycB83eDf+iqNAMkdvMVIRrLO1r9j+bmb18tNnDllsqgGeE46B55YV
         QD5ivYPsDlu3WytzaH9Hkzez3symNFvBrIl/DkfwY8sF0Yo0MQzPkBVoiYfHtiAsuSsU
         T+NgqkBFcfW94xtCA8QXvqM1+wRsT4GOjbXeP/cs/5wG0x5N2cXHGLXePiZ418UkDczF
         +N4w==
X-Gm-Message-State: AO0yUKX6S1D8M2brgSaxSkbtariPsth1G9+H/l6Dg4G0ZLwUgY4vs/bq
        uylSEZBwvQSgW6KrP0AA7QPIDDG/p64L8CcuPpqeqg==
X-Google-Smtp-Source: AK7set8SffFuNnYkrvWB6Eb908721d12R6KonUYzgbvCyu0975Xi0mo/lbA4HGtuAA7aH+JolnhFoF5Y8bLRxqw9mZc=
X-Received: by 2002:a50:d61a:0:b0:4fb:9735:f913 with SMTP id
 x26-20020a50d61a000000b004fb9735f913mr3812066edi.8.1679499314957; Wed, 22 Mar
 2023 08:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230322011442.34475-1-steev@kali.org> <20230322011442.34475-5-steev@kali.org>
 <ZBrpyXrkHDTQ6Z+l@hovoldconsulting.com>
In-Reply-To: <ZBrpyXrkHDTQ6Z+l@hovoldconsulting.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Wed, 22 Mar 2023 10:35:03 -0500
Message-ID: <CAKXuJqiirOEuvhHUtqeGvFjxkTR21SxKXe8Hysayx5UXFpukUQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: qcom: sc8280xp-x13s: Add bluetooth
To:     Johan Hovold <johan@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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

Thanks again for your time in reviewing things, it's greatly appreciated!

On Wed, Mar 22, 2023 at 6:41=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Mar 21, 2023 at 08:14:42PM -0500, Steev Klimaszewski wrote:
> > The Lenovo Thinkpad X13s has a WCN6855 Bluetooth controller on uart2,
> > add this.
> >
> > Signed-off-by: Steev Klimaszewski <steev@kali.org>
> > ---
> > Changes since v6:
> >  * Remove allowed-modes as they aren't needed
> >  * Remove regulator-allow-set-load
> >  * Set regulator-always-on because the wifi chip also uses the regulato=
r
> >  * cts pin uses bias-bus-hold
> >  * Alphabetize uart2 pins
> >
> > Changes since v5:
> >  * Update patch subject
> >  * Specify initial mode (via guess) for vreg_s1c
> >  * Drop uart17 definition
> >  * Rename bt_en to bt_default because configuring more than one pin
> >  * Correct (maybe) bias configurations
> >  * Correct cts gpio
> >  * Split rts-tx into two nodes
> >  * Drop incorrect link in the commit message
> >
> > Changes since v4:
> >  * Address Konrad's review comments.
> >
> > Changes since v3:
> >  * Add vreg_s1c
> >  * Add regulators and not dead code
> >  * Fix commit message changelog
> >
> > Changes since v2:
> >  * Remove dead code and add TODO comment
> >  * Make dtbs_check happy with the pin definitions
> >  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 78 +++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts=
 b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index 92d365519546..05e66505e5cc 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -24,6 +24,7 @@ / {
> >       aliases {
> >               i2c4 =3D &i2c4;
> >               i2c21 =3D &i2c21;
> > +             serial1 =3D &uart2;
> >       };
> >
> >       wcd938x: audio-codec {
> > @@ -431,6 +432,14 @@ regulators-1 {
> >               qcom,pmic-id =3D "c";
> >               vdd-bob-supply =3D <&vreg_vph_pwr>;
> >
> > +             vreg_s1c: smps1 {
> > +                     regulator-name =3D "vreg_s1c";
> > +                     regulator-min-microvolt =3D <1880000>;
> > +                     regulator-max-microvolt =3D <1900000>;
> > +                     regulator-initial-mode =3D <RPMH_REGULATOR_MODE_H=
PM>;
> > +                     regulator-always-on;
> > +             };
>
> I went through the schematics to check for further problems with
> consumers that are not yet described and found a few more bugs:
>
>         https://lore.kernel.org/lkml/20230322113318.17908-1-johan+linaro@=
kernel.org
>
> Note that that series is now adding the s1c supply as it also used by
> some of the pmics.
>
> I'm assuming those fixes may get merged before this patch is, in which
> case the above hunk should be dropped.
>

I can spin up v8 dropping this hunk and mention the dependency on that seri=
es.

> > +
> >               vreg_l1c: ldo1 {
> >                       regulator-name =3D "vreg_l1c";
> >                       regulator-min-microvolt =3D <1800000>;
> > @@ -918,6 +927,32 @@ &qup0 {
> >       status =3D "okay";
> >  };
> >
> > +&uart2 {
>
> This node in no longer in alphabetical order and needs to be moved
> further down (above &usb_0).
>
Ack

> > +     pinctrl-0 =3D <&uart2_default>;
> > +     pinctrl-names =3D "default";
> > +
> > +     status =3D "okay";
> > +
> > +     bluetooth {
> > +             compatible =3D "qcom,wcn6855-bt";
> > +
> > +             vddio-supply =3D <&vreg_s10b>;
> > +             vddbtcxmx-supply =3D <&vreg_s12b>;
> > +             vddrfacmn-supply =3D <&vreg_s12b>;
> > +             vddrfa0p8-supply =3D <&vreg_s12b>;
> > +             vddrfa1p2-supply =3D <&vreg_s11b>;
> > +             vddrfa1p7-supply =3D <&vreg_s1c>;
> > +
> > +             max-speed =3D <3200000>;
> > +
> > +             enable-gpios =3D <&tlmm 133 GPIO_ACTIVE_HIGH>;
> > +             swctrl-gpios =3D <&tlmm 132 GPIO_ACTIVE_HIGH>;
> > +
> > +             pinctrl-0 =3D <&bt_default>;
> > +             pinctrl-names =3D "default";
> > +     };
> > +};
> > +
> >  &qup1 {
> >       status =3D "okay";
> >  };
> > @@ -1192,6 +1227,21 @@ hastings_reg_en: hastings-reg-en-state {
> >  &tlmm {
> >       gpio-reserved-ranges =3D <70 2>, <74 6>, <83 4>, <125 2>, <128 2>=
, <154 7>;
> >
> > +     bt_default: bt-default-state {
> > +             hstp-sw-ctrl-pins {
> > +                     pins =3D "gpio132";
> > +                     function =3D "gpio";
> > +                     bias-pull-down;
> > +             };
>
> Similarly, this one should go after hstp-bt-en-pins.
>
Ack
> > +
> > +             hstp-bt-en-pins {
> > +                     pins =3D "gpio133";
> > +                     function =3D "gpio";
> > +                     drive-strength =3D <16>;
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> >       edp_reg_en: edp-reg-en-state {
> >               pins =3D "gpio25";
> >               function =3D "gpio";
> > @@ -1213,6 +1263,34 @@ i2c4_default: i2c4-default-state {
> >               bias-disable;
> >       };
> >
> > +     uart2_default: uart2-default-state {
>
> And this one is also not ordered correctly.
>
Ack
> > +     };
> > +
> >       i2c21_default: i2c21-default-state {
> >               pins =3D "gpio81", "gpio82";
> >               function =3D "qup21";
>
> Johan
-- steev

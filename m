Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD33C761A6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 00:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC2A1P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 20:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2A1O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 20:27:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72135187
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 17:27:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w9so56778227edc.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1680049631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEpY2ODUY5mEqcj9vNQ0ZYZkQmo1P7yFLhuPa4WcepM=;
        b=SfnATT8MDX4N45OHq834fFTpo5bzClAd9VvPwG/QFM41uPnZ1Nvec8zwAzyYHB8V1U
         5AvfxRBgtbyHq4hulLOe6wKecl2mWADZWNw2gWPb/pWeF2En4DuJ3w28Ju7mS5HpwpwL
         vaLOX3x18ByQD5sv1yiZlr/lLpQ4SrByuZASqkwqnL6m+NqERyn/nm424Q5Bcy/gQxiG
         7P9UvUrsxmuL3mwzfGnhrSHe7NmbBqDq24lA8fTQQGlOS9mHXd64ZNAhUdKIih/qt7St
         uiGgqgie5BtYzXOkOhHLX1bapebmILjuI4x26PlMAGTgjTZyHFc/OvaowzexvcL6/uh/
         UPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680049631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEpY2ODUY5mEqcj9vNQ0ZYZkQmo1P7yFLhuPa4WcepM=;
        b=It7sjIPKP5GvT4KJ9RfLiJSicHo0t+qUVAOEyR49c6cS6iZHVenaE+ghj5DFT+XxWg
         hSn0JGZ6YWeBFZS/2bjfualWitDmP9vq/AvFoJ+hVk9sH9NPujlTnmWSPhOWBaKP43Zy
         1dTzJ6g8TfVmI52DQb3sbDePPJG4qmZmvf2EH6nGOcGXqxlilVRKli7n8wd76CEqfIzt
         zwqqLsdveUM0cUSwP2zA64afd0tL8vgMNHPvmiaQP5bvK6EImciDxRDPbblRKZZBf69d
         Hap8CnHkizLaVPC3Cw3CA2zphfcgTXPDMmJeOaEs9sspIBSfb67P5cw8qcASK8s42QdA
         +hmQ==
X-Gm-Message-State: AAQBX9d3M6N07Nz3bnUDy8Qp6aBW/eFetz4pVaFXIcumOAlQKU3Qj+Qi
        VcC2qKFGI6KEBNkC//SSiFwhPn/ucfBAQ4avT1O9dQ==
X-Google-Smtp-Source: AKy350a6b0RNSg0qEukxWpVN2dB5p+ti+B0uqThdB7kAShSe5xvwdydY4q/AP6PYlOkUDiuZPxqS5m+rA0BZBXLXUJM=
X-Received: by 2002:a17:906:524b:b0:877:747d:4a90 with SMTP id
 y11-20020a170906524b00b00877747d4a90mr9121390ejm.14.1680049630974; Tue, 28
 Mar 2023 17:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230326233812.28058-1-steev@kali.org> <20230326233812.28058-5-steev@kali.org>
 <CABBYNZLh2_dKm1ePH3jMY8=EzsbG1TWkTLsgqY1KyFopLNHN6A@mail.gmail.com>
In-Reply-To: <CABBYNZLh2_dKm1ePH3jMY8=EzsbG1TWkTLsgqY1KyFopLNHN6A@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Tue, 28 Mar 2023 19:26:59 -0500
Message-ID: <CAKXuJqi_DJ1GEP-rurJqJF5EyooNQO=daBOo0dipCGqS8QV=Dg@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] arm64: dts: qcom: sc8280xp-x13s: Add bluetooth
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Mar 28, 2023 at 5:24=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Steev,
>
> On Sun, Mar 26, 2023 at 4:38=E2=80=AFPM Steev Klimaszewski <steev@kali.or=
g> wrote:
> >
> > The Lenovo Thinkpad X13s has a WCN6855 Bluetooth controller on uart2,
> > add this.
> >
> > Signed-off-by: Steev Klimaszewski <steev@kali.org>
>
> I would like to merge this set but this one still doesn't have any
> Signed-off-by other than yours.
>
> --
> Luiz Augusto von Dentz
I don't quite follow - should I be adding others S-o-b?  I know that
Bjorn had previously sent an R-b, and Johan as well, but since the
code changed, I didn't bring them forward.  If I'm doing something
wrong, please let me know!
--steev

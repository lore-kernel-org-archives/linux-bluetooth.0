Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18623C7EE26
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 14:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbjELOaT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 10:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbjELOaQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 10:30:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC1914901
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 07:30:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-956ff2399b1so1898628266b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1683901810; x=1686493810;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0OGsKjyATKDb9jYmWbTNqZ4sLTa+V+9kzUcaHu+Bg4=;
        b=NjrV3H/c9DiHGBEjjvqb8Ko94Brk1Dtf/oCUqkm+fROH8lHlSrr1UArdUvMSuEBrTZ
         LG/tVEizSEHlJUQ6SllSMvjU3iTr8RuxOD5O+u1z9ny+O9O+qn5+rpUf8zaxad3xcWxy
         JQN0iIZdGmRwGWUqSgV4B5rNFQVCc5GNL+f0uxFlOSL46MjDUc6RjinVG3auLy59Lnse
         w+2tlm0HEpP81jVq5AOcpkkFZUZRCPRUR1AnN8yEihy7UhOoYS4+Iv+34hKuTifuEGJg
         W2HF0KkXX8wGXC+UhlM6vOA8Bqs+Tku0ObCpDvdnf8n6wG3OfKQH8PW0B1e6Ic2kqOJo
         bkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683901810; x=1686493810;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0OGsKjyATKDb9jYmWbTNqZ4sLTa+V+9kzUcaHu+Bg4=;
        b=j0dy1ShXHlsVGmuaAYKMKULqifjHlhvHquAXS/A0RSK6UhUoUCnOswVK6D671XfrVr
         RVaQuCDlz2KEIjqRB3ZYN9nmRweyFUxwzHQrKMTfeSa7RaKoN632Tu8sHRQSq6WMEVrp
         DwqUpGS8CS2yC0yAOuq63xQSZh2rNMkaUZJmyYuxerpiAXP6/ocEOhOd8TqW+Mn6orzk
         mf/y9XHahllaHE1+X+HHzrreg/ZGt93Ao3CxX2RclVvXGGmb5Ysjc3s3mrgE4gM6O985
         o1cI/u7eTW0ZJd9tPSSXrptjsAwK+wxptynp1XXuXzmNxuVO/JY3NZGO/fJmSPnMiDO8
         XL9g==
X-Gm-Message-State: AC+VfDyFh6UzkUitllP7KjvsLZHlDoJ3hp10RrA2HAsK9kse3nW+G6uq
        Ea+Ic1zRulyBrnOvKhty1jQFgA==
X-Google-Smtp-Source: ACHHUZ7wfROlWoHHVhBbZ9cSWpXy+k/in7usHaTGZqbXMeEoLhu2Kl4Yjqa2+xah0carSqkZXnUH/g==
X-Received: by 2002:a17:907:a41e:b0:965:e556:8f6d with SMTP id sg30-20020a170907a41e00b00965e5568f6dmr23781673ejc.63.1683901810620;
        Fri, 12 May 2023 07:30:10 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id kn3-20020a1709079b0300b0096a27dbb5b2sm3518504ejc.209.2023.05.12.07.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 07:30:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 16:30:08 +0200
Message-Id: <CSKDDFPXC6FD.1TAU3XXOSGA0K@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Balakrishna Godavarthi" <bgodavar@codeaurora.org>,
        "Rocky Liao" <rjliao@codeaurora.org>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH RFC 3/4] arm64: dts: qcom: sm6350: add uart1 node
X-Mailer: aerc 0.15.1
References: <20230421-fp4-bluetooth-v1-0-0430e3a7e0a2@fairphone.com>
 <20230421-fp4-bluetooth-v1-3-0430e3a7e0a2@fairphone.com>
 <8f312ded-8456-eced-85cc-0ae32a0c8bba@linaro.org>
In-Reply-To: <8f312ded-8456-eced-85cc-0ae32a0c8bba@linaro.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun Apr 23, 2023 at 12:51 PM CEST, Krzysztof Kozlowski wrote:
> On 21/04/2023 16:11, Luca Weiss wrote:
> > Add the node describing uart1 incl. opp table and pinctrl.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6350.dtsi | 63 ++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 63 insertions(+)
>
> Please do not send DTS patches for net-next. DTS must go via Qualcomm
> SoC. Split the series and mention where is the bindings change in DTS
> patchset.

Sorry, just saw now after already sending v2.

Is this a special rule for linux-bluetooth@ / netdev@? Isn't it easier
to keep it together so the status of series can be assessed easier? I've
always submitted patches by topic, like input patches + dts patches and
it was never mentioned.

Regards
Luca

>
>
> Best regards,
> Krzysztof


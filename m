Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7211CC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 18:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCPS5a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCPS5Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 14:57:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1FDCA63
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 11:57:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o12so11491313edb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1678993030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISoDwGmCZfIt1++Qrq4EaM3UW6i2EJ00oUlk42ZAa4k=;
        b=V34nuHzb1E1n6ArHtHa/MyOWRtt1PmPMxzBmbNZ70ayTY98fyYvgyrBPtlxZTjt10O
         lcuHVx7snGom/yUxsRx5nKqnb/yl03a4EWJTrGqyjjo68Aqsy/DQRWfmH0L322qjXkGZ
         YjDrMlA56pufnTtXHbENe3k35Br34XL7XIt6c+nHVpCgUU+HYpwxYx0CnXzmoW4cVZew
         oKJl3xnnxfcomJvZQc3MUZDsx7bqVXIanxILdL7nKWbL6VJfpIGqwQRmRtHzNy+ayTDD
         NehCB+jT9oMLIKdvSeqa2/tp5E0ZbFN4UP3ZoIzXLCtYfzk8Cs2RRd3Pi3Fcz52Be0Ry
         JcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678993030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISoDwGmCZfIt1++Qrq4EaM3UW6i2EJ00oUlk42ZAa4k=;
        b=3PZZBsqQc6sUGmTBtmDU7EHXWy+JsRw5pX5AZloDrITeMPvAxqwvpf7kF1jmzYU5f3
         jyq/Uc4Nv2hB8QIzKL8949zzLITovU2lI2C6kkUWT99OTcleszDE5Z/lSa0a8B6xKvI/
         M2LV6Qq8sAIGGf2vzJa5VRTwxlcMIXIK3C9lV/w3BpwpvdeFcHRjfNCt2bw6Qxn5rumO
         IKENulYu0U/xLNuJNwP0CLbDoAys+pZKpElwwes+aopmV+H7eEp6aJ173HO1kgBqlaD4
         fm5hB9N0cZ8F5Sg+b72lYW72UYNSz2GkxjMbXEM3fL+FJCDy7GSufVFnnKL+ABuQYHJ1
         KXPQ==
X-Gm-Message-State: AO0yUKXz2i5OTtF6aS1gAmAuj57+ntivy8kFwV69i2Q68cZw+duRB0GF
        kg2my/pYoYckYZLIKMnfiIoF5c7j4rIkA/MmRObThQ==
X-Google-Smtp-Source: AK7set8R6MPvl1jYDipFYGi3DvPwtseUsQ8EVHZ1VfSLTTmEQjtyKWaAM4IDrmaaOglEDFXN0af7mz8G306mXMeEY84=
X-Received: by 2002:a50:f683:0:b0:4fc:473d:3308 with SMTP id
 d3-20020a50f683000000b004fc473d3308mr360427edn.8.1678993030292; Thu, 16 Mar
 2023 11:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230316034759.73489-1-steev@kali.org> <20230316034759.73489-3-steev@kali.org>
 <f7be8db9-0bdd-644d-c7a0-4321041c5028@molgen.mpg.de>
In-Reply-To: <f7be8db9-0bdd-644d-c7a0-4321041c5028@molgen.mpg.de>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Thu, 16 Mar 2023 13:56:59 -0500
Message-ID: <CAKXuJqiPKJ_Jus2gwA94gQAb-7-PBAZL4CSaFcxpx3+UXBYS-A@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] Bluetooth: hci_qca: Add support for QTI Bluetooth
 chip wcn6855
To:     Paul Menzel <pmenzel@molgen.mpg.de>
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
        Mark Pearson <markpearson@lenovo.com>,
        Tim Jiang <quic_tjiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Mar 16, 2023 at 4:58=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Steev,
>
>
> Thank you for your patch. Some nits.
>
> Am 16.03.23 um 04:47 schrieb Steev Klimaszewski:
> > Added regulators,GPIOs and changes required to power on/off wcn6855.
>
> Please add a space after the comma.
>
Good catch, sorry about that, will do in v7!

> > Added support for firmware download for wcn6855.
>
> You might want to use imperative mood (Add =E2=80=A6).
>
Bah, I'd seen others mention this, and still did it in mine :/

> How did you test this? What firmware files did you use?
>
> Maybe mention, that the assumption is, that it=E2=80=99s identical to WCN=
6750?
>
Are you wanting the firmware used in the commit message?  I think I've
seen similar in e.g. ath11k patches like:

"Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1"

something like that?  The firmware itself is already in
linux-firmware.  I figured it wasn't imperative to the patch and it's
in the cover letter but I can definitely throw it in the commit
message!


> > Signed-off-by: Steev Klimaszewski <steev@kali.org>
> > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > Tested-by: Bjorn Andersson <andersson@kernel.org>
> > ---
>
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul

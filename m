Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F6C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 07:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353071AbiFVHd7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 03:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352953AbiFVHdy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 03:33:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12E37039
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 00:33:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a11so9490778ljb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7u2mzyIk7qCiF6G6ao+KItshVsiYCB6EE/ZVw3jOeOg=;
        b=UoIIX31fk9eu9RxAogLJsx9A/YAhFrakUcRqjx96kbbYaA8qL+nG3a6RkL1Sa2/Pw1
         xeskW6xtvK88Z+1Z732KSM65232wAYSuJ/PNo5JsjzaD8l6OIw1oJ5T4791jYzrMVreV
         jSb462RMd3xrJDmzEqPMeXQoFLaaLljj2+Oprm3rze+Bo0AEEFdYQdGaQ5nua1OW7ZRL
         0xYi/6ESpQLfvobvZpplNRP2ojxgOn6jiJo801f9GnA+C5jC+SpH+JDBYIUJiTStrFHp
         aL/+BwGqQKK9sm2m7CNfooiYsr8mOHlRZqrYjmWlkVzNmy5zFsyd5bQrj5jnNkiI2lVi
         rmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7u2mzyIk7qCiF6G6ao+KItshVsiYCB6EE/ZVw3jOeOg=;
        b=eh5IQXCYZp7omcS82vYXfYNOf4mTU78x6Kk5J6n0nSRNFAp5g0t6kWNd83ImKDV2fn
         fVEtXfNnqYto/XsaI/l32INRSOsq6crGu7EcIPeb0Jpxhw0J2VgnAQNT7w3OhKMUXorM
         I8UdeKJDisL2xcsZA4+0j1AYiWWNpg1f79aKg98z07NLxJbZ8FA609JX2Ai2L4L6+KMm
         JvT17sRilfwa9LvS5dSb/zywepsfo9NU7M2WvAHLq2gjttZRXeUHTRce2EPhuv66/dc2
         3ldUzh5HNEUHMBtSz78CMx6GOt1UG3AYcSqgKS1swwmSzf781asKa+RsqBzJ/tUgzCcF
         2wxA==
X-Gm-Message-State: AJIora8p09gciEIwPYCQC/PERocjgoO1GLkNk4B0HCm/mnHkR32A0Z0v
        wS4CBXHjTs0wg+Zj6wra9LA3Lg==
X-Google-Smtp-Source: AGRyM1v37LDfzbSuWOdp8P7QX+rUiUHnLdODI+EKsivLYUpBCF1ewbujHxy46Ymd9r+swKWmjewGPQ==
X-Received: by 2002:a2e:b890:0:b0:25a:890a:b424 with SMTP id r16-20020a2eb890000000b0025a890ab424mr942861ljp.275.1655883229985;
        Wed, 22 Jun 2022 00:33:49 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m12-20020a056512358c00b0047f8de9734asm335583lfr.123.2022.06.22.00.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 00:33:49 -0700 (PDT)
Message-ID: <b8b21831-8078-fb53-d4be-9feb6138b19d@linaro.org>
Date:   Wed, 22 Jun 2022 10:33:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 0/3] WAR to handle WCN6750 hardware issue
Content-Language: en-GB
To:     Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_saluvala@quicinc.com,
        quic_rjliao@quicinc.com, mcchou@chromium.org
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 29/04/2022 13:27, Balakrishna Godavarthi wrote:
> On WCN6750 sometimes observed AON power source takes 100ms
> time to fully discharge voltage during OFF. As WCN6750 is
> combo chip for WLAN and BT. If any of the tech area ON is
> triggered during discharge phase, it fails to turn ON.
> To overcome this hardware issue, During BT ON, driver check
> for WLAN_EN pin status. If it high, it will pull BT_EN to high
> immediately else it will wait for 100ms assuming WLAN was just
> powered OFF and then BT_EN will be pulled to high.

Ugh. This adds another point to support separate power sequencer device 
for WiFi+BT devices. Let me refresh my last patchset, so that we can 
implement it as a part of common code, rather than hacking hci_qca on 
and on.

> 
> Balakrishna Godavarthi (3):
>    dt-bindings: net: bluetooth: Add wlan-gpio entry for wcn6750
>    arm64: dts: qcom: sc7280: Add wlan enable gpio to bluetooth node
>    Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
> 
>   .../bindings/net/qualcomm-bluetooth.yaml           |  6 +++++
>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  1 +
>   drivers/bluetooth/hci_qca.c                        | 30 +++++++++++++++++-----
>   3 files changed, 31 insertions(+), 6 deletions(-)
> 


-- 
With best wishes
Dmitry

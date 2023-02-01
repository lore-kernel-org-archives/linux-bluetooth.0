Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2358C636D3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 03:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjBADFs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 22:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjBADFn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 22:05:43 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8F483F7
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 19:05:42 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z5so6039731qtn.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 19:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2BzMaWSUkj8EDnF8fjbvdcop5Q3Avd1JgESuZNfB+o=;
        b=Is/6fOxIVI8M0bd8R7Fy/4Ihdq6UXuaz4tnnYG5hYI5231f+oLXxe/Ik/pKsUXsxsS
         jiOkbeNd2+Z141DkDk6AxqJvIoxEIHwdDGudSbge3kcH6Onnwg4+/nsCLiPXThQSH90G
         o7Qdx7yHnoKqwwm82XE5YreaSJcZPXgnNMOfKyDerLjzS78i9D3uYI0ze/bvBSbUm5N+
         yyELOTVNIG/v0THZh9i1dNVDRNkiPA4bWwQ7rItS36DaJWeNoN3JenGtHRdhxdyarpht
         eO5GKma5LsT6e5ckz6YMtp9IuHHdv82KocJSpe6d5Z3hclzE5Gnf9rYa/MctwsYwmUq5
         PBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2BzMaWSUkj8EDnF8fjbvdcop5Q3Avd1JgESuZNfB+o=;
        b=sA6JjqYzQwX4qoPsZ/Nvh0KV3vxQeSLz+3E4ranfETYWG5eb2ZUUX0L/9x24e9rHq0
         6r51vy3KMF0G/FtRanOGVVLwvnNC9fOLDOqnV3JstgEAC9atuiS+2ucX4HoE1V3Yrfnh
         DgIpOF6yVz9IHsJJvRngbrWeBrht1+D91/Fl44dQZ7W8hf7vHYjcH0+lIz1Xn/J4XK9E
         y8lzIObnh1r/FLHeIXHmCwfZoR9AvCLTm4rSYetID0CeDmgKn9lBstymCnW4hLMKNrbi
         NOZH41wy4zyeCzl/NqeJKVFlp836EgZ/ktLuTITn0KW1ALUzxBMt+lkDmFs6PblTxKMk
         UGBQ==
X-Gm-Message-State: AO0yUKVDKK9P+6dpghB1COmARwFHUuhDyUaRlyrt8bBOSTE026XOEpIM
        FdEi8Afd6omCG/KsXDIedYlo6A==
X-Google-Smtp-Source: AK7set9Uvevz/T7MAM3nTgoNdTHemNw5IFZm6aotpv9qD/FICRJqTFmELsTReDvgcu32Pzdpsj9qTQ==
X-Received: by 2002:a05:622a:11d0:b0:3b9:b9ae:1476 with SMTP id n16-20020a05622a11d000b003b9b9ae1476mr1134250qtk.40.1675220740964;
        Tue, 31 Jan 2023 19:05:40 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id q1-20020ae9e401000000b006fc2f74ad12sm11306592qkc.92.2023.01.31.19.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 19:05:40 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Subject: Re: [PATCH v2 2/4] Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855
Date:   Tue, 31 Jan 2023 21:05:38 -0600
Message-Id: <20230201030538.56293-1-steev@kali.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <a18751a0-f51b-0a3a-58ff-2062a9dc46fb@linaro.org>
References: <a18751a0-f51b-0a3a-58ff-2062a9dc46fb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>On 31/01/2023 05:38, Steev Klimaszewski wrote:
>> Added regulators,GPIOs and changes required to power on/off wcn6855.
>> Added support for firmware download for wcn6855.
>> 
>> This is based on commit d8f97da1b92d ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750")

>Drop. If that commit is merged, how is it useful to keep it in git
>history forever?

Sorry if that wasn't clear enough, what I meant to say here is that I used that
commit id as the basis for my work, and it's not based on having access to the
schematics or spec sheets.

-- steev



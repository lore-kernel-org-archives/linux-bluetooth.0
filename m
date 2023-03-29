Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C801FC77B61
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 07:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjC2H3M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 03:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjC2H2q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 03:28:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88D530C2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 00:26:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g19so5820599lfr.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680074796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7183s01mUhY1MlzNjYfsfxMgMWtxEXCM0G4GVkOYwI=;
        b=ANSQpbq4MUpCh6lkL0ICYmHOE4118OEHg8b40jiCxIZm18OGvGFLpfDsyyD6QRYEdp
         giDZinFfnz6lLrVsspEixCHZXDHfo4K+NYzU5JofYizzSvrm2JmcO6/f5H13vIYdRKPb
         /zZva1KYi1rPEdLh67cka7VzB7c616faD1wHv8eue61KEgnfgLNlJAFFiGsb/ZYzLane
         zvVHPAyC8qTSlapYgMademg3TAIVO0H/W89Gfu0r5+V6kR7Z1FRWYK3vrthEE8xNysW1
         4o2jonAUbh22fGO3I0b08h4vz0lpqbY5l9hUYdl8M3fbeuxHBpdXfgO7Q/kGsUgQI4fc
         EABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680074796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7183s01mUhY1MlzNjYfsfxMgMWtxEXCM0G4GVkOYwI=;
        b=WYxtxM2HAhMjZRmq30ulJXApMMq/izdzXoXwROyxo3k7rXLRwvhf6quvqWfXtrM6ki
         lbgjvEI4qYHCssKbZ9UCxT9b0pzCG2h8WbZ/42CprgzVG/Ejhhy8cQZt5/wzgTZs0mNr
         djlFmWtDPcnkp2d4CYQSXDlkmaf6MzIUd5MtwL+VhG2v25ttP8jUz+tqJP2wYmFaPtL1
         NwjUFOH6LUWPpCtWfrWVcmBYYe/0UE6TtmD1LTVxLIppXfciezkIKh+A5NqLBXuybxZJ
         JxSnM//IwWjKHeTYwOh2kycJKq8iMlH63+rKxMwk5uvaz9Y9IcTg0g/WtMYCUslCQNtO
         vGqQ==
X-Gm-Message-State: AAQBX9fSLbdKhcyWYT7H3G7YZv67XlRVPk/sk+t7ftlPwYs/cKuVgOwQ
        LDU2lH4Ty3ho2Fa6G5QHgguL4A==
X-Google-Smtp-Source: AKy350ZswhcAA5B+KdmpmE/aqHA9lWxMk4RrmpJihRyPEunFiBluQGwvppgyXlTCBFluxvW3vo6b1w==
X-Received: by 2002:a19:e01c:0:b0:4d8:86c1:478c with SMTP id x28-20020a19e01c000000b004d886c1478cmr375021lfg.33.1680074795796;
        Wed, 29 Mar 2023 00:26:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004e9bf853c27sm4353061lfk.70.2023.03.29.00.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 00:26:35 -0700 (PDT)
Message-ID: <808cf98a-b4f6-4299-bd47-a8adac5ef7ad@linaro.org>
Date:   Wed, 29 Mar 2023 09:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 4/4] arm64: dts: qcom: sc8280xp-x13s: Add bluetooth
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Steev Klimaszewski <steev@kali.org>
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
References: <20230326233812.28058-1-steev@kali.org>
 <20230326233812.28058-5-steev@kali.org>
 <CABBYNZLh2_dKm1ePH3jMY8=EzsbG1TWkTLsgqY1KyFopLNHN6A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABBYNZLh2_dKm1ePH3jMY8=EzsbG1TWkTLsgqY1KyFopLNHN6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 29/03/2023 00:24, Luiz Augusto von Dentz wrote:
> Hi Steev,
> 
> On Sun, Mar 26, 2023 at 4:38 PM Steev Klimaszewski <steev@kali.org> wrote:
>>
>> The Lenovo Thinkpad X13s has a WCN6855 Bluetooth controller on uart2,
>> add this.
>>
>> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> 
> I would like to merge this set but this one still doesn't have any
> Signed-off-by other than yours.

Please take only driver and bindings. The DTS should always go via
Qualcomm SoC tree (as we want to be sure 100% that it is independent of
driver).

Best regards,
Krzysztof


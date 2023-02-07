Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD0C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 08:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjBGIF3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Feb 2023 03:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjBGIF1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Feb 2023 03:05:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52032B095
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Feb 2023 00:05:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k13so5261103wrh.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Feb 2023 00:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E84y+vKONIcM3mXhEEy2z1fhX1fI78cKOFVSdVHWpv0=;
        b=Yd6jGK6jhUojjZW5dnKQZI/EOMPU01Jjp4shryndwBM0hSOJVzFozY9oRvYv1i0kkI
         6cRh9Fi1gXzfql0/lJ24R8JbdN6DTQmH1Mf+2ma2/ZKT0SiY1HxvGBAtAiYXI9vdznUL
         DQD4k6BkLJMZ+SN+p9HR2Ceg9EmDFblXq+sF7OEOia56dhv5b2DgOgQcgf+CxNajQ3q9
         zT4o+7G4M4+dP0PdBxUScteNxxuxHRsce5kd8tjROlcn9DgINvuZ0MpdveNL9llA5yN0
         qQDsm5mM3/4wzmA8C6jYtQG/4sTq6QebxKJeMXGfdfKC+dooLILuSGrbJkOhKwk/i8bQ
         QhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E84y+vKONIcM3mXhEEy2z1fhX1fI78cKOFVSdVHWpv0=;
        b=AIKA0sLGM4SjXPwOFN67IKeepZ3LyEYXJGyXLFSuZlx2qckSBAS1X9D9WOYdYjutMr
         w8TvGAE78eFCv+jCbBNXp5EkipCP2yps8T3smtbUZiR7P2/a99dsXQ2LEJDO92XgDXaE
         UO1a0YSl3X0vcKjxNBcHEb7hKbS4NH3x63IjE0dmu8Fm+niVcbvMEb8fqvbo1hNhkhzf
         /s6w9PV5Obt8M7xFcXFuDCjFiysR1aarxEaQBivJF1UvtHZVkkLUKpL3k7oCrMRi/B+1
         B8gd1liSBlDZh6umZRcRK3+iQF05wQkeoSLoAPafPek8ySy4Cdsx1BPcnJzSjT4ZUOsf
         z31w==
X-Gm-Message-State: AO0yUKVN8+LnwkOW4ugdHMUwt+I850Vm5xKVYkaseeV2dnqrLw3isuuP
        fkbtonXhXw5hGXM1fpvM1aWIUQ==
X-Google-Smtp-Source: AK7set9PKPCq1x4e9ZzuqO7fkp35tM9IXqxzQ0JsTgYnwNa2tqr7oD7Ks+S9d1vMDNf7iT8Z0q0w7A==
X-Received: by 2002:adf:e389:0:b0:2be:546f:50c2 with SMTP id e9-20020adfe389000000b002be546f50c2mr1788041wrm.12.1675757124552;
        Tue, 07 Feb 2023 00:05:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003dc47d458cdsm13714167wmo.15.2023.02.07.00.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 00:05:24 -0800 (PST)
Message-ID: <b8f800ac-d9f5-c8d5-ab6b-c1c25fafbeaa@linaro.org>
Date:   Tue, 7 Feb 2023 09:05:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/4] dt-bindings: net: Add WCN6855 Bluetooth
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>
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
References: <20230207052829.3996-1-steev@kali.org>
 <20230207052829.3996-2-steev@kali.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207052829.3996-2-steev@kali.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 07/02/2023 06:28, Steev Klimaszewski wrote:
> Add bindings for the QTI WCN6855 chipset.
> 
> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


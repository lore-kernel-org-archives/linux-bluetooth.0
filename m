Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF526C54E94
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 10:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbjAZKDw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 05:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjAZKDv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 05:03:51 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5621B45BC5
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 02:03:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso2909891wmc.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 02:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1f4VhC6BSvSQ+e5t5OrJSoX9lSlfxjIbZ7RXVnsqUl8=;
        b=l2Nr52HOCvPddY5X06qLICnZNj+//HDoBz6gyGIEbnnYFxlQi5utN9oMlQnWU4atsO
         X7RH5+BGEG4/y/mhunSLzgHfZ3WZoA3H46mwW571mYY2Z0gk1K988++NO5UoT+C08ltb
         MA2ixWaMC+5t7HFIeM672wXMOEVtU5K8W0kW0DgOwpOP3wav4IeKIq+1MtCQ7QR4Hjve
         Fz/oHZhV2/yEBoQ7BJzLXTccVDEidZMYHDqgky8Xy8GA5pJFSym66LwvqjaiZ1CafuHk
         XMj7tqMjIPq7f63yqMidoOoo+UN6kDa0ioreX/YVk6AxiP1AroZ00nHkS77HPg8SMka9
         uuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1f4VhC6BSvSQ+e5t5OrJSoX9lSlfxjIbZ7RXVnsqUl8=;
        b=GKoJJyn4wlhg+Wcqy6VJi+ENXG7JB6EI70c0xZnRCJSRuan+YhFmIjnnqfsKbzDSzm
         kkJo7/rOzOozEEIsMcBvmIZhsqSLUJdEj2ZVxO/yETt4KQZEL21DOi3Ewoe0iu8TQIvu
         cp2pvls5FMHC8uUPlAl7u5qhrj8V9HByt6Bj+hh0Nvh1xPGW+rQK/XWRWFRoOaRTbM3I
         DG81zIABtBQPwgqMJRWu7wxeb87S0xBhDiuvA0vJcAvakoLt6AEE6/Bh3w780/CNgffh
         Fzk9k5O/dbI8aMgrTTPNtsKEjpB5/MxhLVUemhxshZ156CFPliHccL9IcmllSskGlRNh
         Sqaw==
X-Gm-Message-State: AFqh2kpmdNIQMmNmpVJRuuyUDqjxuRjx3T113Jc5ligyVcwuN+sUpIzd
        VKpGaNF2ylttZCVbYCx0x7buHQ==
X-Google-Smtp-Source: AMrXdXtNoLKYwDxA+EFs+kUucwoNJxgfjrbFdIGPGi7iYFfbnIMch/yNQ7aFuf8KY3o9vZ6JFcOhhg==
X-Received: by 2002:a05:600c:468f:b0:3dc:c5c:b94f with SMTP id p15-20020a05600c468f00b003dc0c5cb94fmr10524314wmo.39.1674727427869;
        Thu, 26 Jan 2023 02:03:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c1d9800b003dafadd2f77sm4749025wms.1.2023.01.26.02.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:03:47 -0800 (PST)
Message-ID: <7ca0f553-664b-19ce-4c93-e5fad4b71bfd@linaro.org>
Date:   Thu, 26 Jan 2023 11:03:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/5] dt-bindings: bluetooth: marvell: add max-speed
 property
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
References: <20230126074356.431306-1-francesco@dolcini.it>
 <20230126074356.431306-3-francesco@dolcini.it>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126074356.431306-3-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 26/01/2023 08:43, Francesco Dolcini wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The 88W8997 bluetooth module supports setting the max-speed property.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


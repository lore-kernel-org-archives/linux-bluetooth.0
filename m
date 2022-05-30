Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDB4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 18:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbiE3Sql (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243024AbiE3Sqh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 14:46:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45361F7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 11:46:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gh17so22459123ejc.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MGC9lypGvvQHtcPIof+toR4e3sY1geBCnMDhVOsZ03Y=;
        b=Zm6wSN5O6ZM5I2mWkDIIGD00txWoUAy+wG6ekFTiOX1fC1jnHKiCJF3lMFTxP5hL5j
         ilr67+ERw//4a9ENpnAZs+Vvp/nJAaDNyKUJf9FWWKMBcFkfAvI2ufbSSCavYVdcJb8M
         AlRoX3+weThE784Bym5lc78cdv/p621gUHtxViBLMNv3B/1VYCOhYPLntlWd9zlZm3/v
         cXuF2HUrTkk+CF+OR6sGawQwAh+lJk5+4qG/cqMUbYwaZD3Y3C9NzyBdteJSz8NdKK47
         HmqXR7E2pfy2/K+4pjLKazwqpupIDBPp1eT6utl+E9y9JKucl6k+Srdo1uVz/QzYdl9r
         4x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MGC9lypGvvQHtcPIof+toR4e3sY1geBCnMDhVOsZ03Y=;
        b=JIa93yBKNsJYIBBEhERGyLn1HKXpSKLLHe7H/3I2loU+JZX9hRmUuY/Zs58BmF3wFN
         KhZmPf/Kirv51x979VVU3mBVLuNxDywWbwehHER6JlPeUvVv3bIyWw5X91uE4/23/IcI
         WutDq3hqD3W1FV+tmBGJB2EgWwgJZaRga8K6aOR8Z+DZZUO92C+YPVPHxvVqfPfFwtl0
         /UMgBaPr8dGR3RhZ4x0mMJpiOeNUFBNRWKWcwtB3s/z3vTlwLMCyKXumP3vBrdQQpQH/
         WyN8aPZquNPUXuquqr83oYjAFIHqoBRNsCSfC+z+bM6gf41ycNIpij2l/3EETrA6eSP6
         3b8Q==
X-Gm-Message-State: AOAM532dEmHIb1rFu5rZ5DTDG9Lny/MBC8jTXukBtzK1uah54Ez+RnJW
        4yAnVe1GIEvrgyvccsGv6Fg3Ig==
X-Google-Smtp-Source: ABdhPJzsKH/DAFlFH/rItpdXB1i+zYAEEVeFlixS7t9BYZ8Own/moKO/QscKAVorcDmIUKeAZckiPA==
X-Received: by 2002:a17:906:b294:b0:6fe:fdb9:5fb4 with SMTP id q20-20020a170906b29400b006fefdb95fb4mr30084594ejz.179.1653936393433;
        Mon, 30 May 2022 11:46:33 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906354400b006fe98c7c7a9sm4270868eja.85.2022.05.30.11.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 11:46:33 -0700 (PDT)
Message-ID: <cdc6bd79-3fa6-4e3b-45ef-9e6950c3796d@linaro.org>
Date:   Mon, 30 May 2022 20:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] dt-bindings: net: broadcom-bluetooth: Add property
 for autobaud mode
Content-Language: en-US
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <cover.1653916330.git.hakan.jansson@infineon.com>
 <f395ffd03a6594ee11975b708721a33ccf8a4871.1653916330.git.hakan.jansson@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f395ffd03a6594ee11975b708721a33ccf8a4871.1653916330.git.hakan.jansson@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 30/05/2022 17:02, Hakan Jansson wrote:
> Add property, "brcm,requires-autobaud-mode", to enable autobaud mode
> selection.
> 
> Some devices (e.g. CYW5557x) require autobaud mode to enable FW loading.
> Autobaud mode can also be required on some boards where the controller
> device is using a non-standard baud rate when first powered on.
> 
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

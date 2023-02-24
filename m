Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C3C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 11:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBXLUn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 06:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjBXLUl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 06:20:41 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8FE63DF8
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 03:20:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ec43so52949069edb.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 03:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3hEGyCucdzbqe3LrutT0J4NZq9m5aBL5wEqBphvaXQ=;
        b=jbUpwEFLdpLKVZ953n8tg2+JdWrD2rrbXAVTkJRRzca1k45TyM00PvwsLpS0vJGFrc
         RwMLvwKwI8TwqNYj21oQJA/ud3Unyv4HVPhUVAe50anXgbAQmTwr0li8Xf+i6ZZHJ1im
         UCc0uoXxnARYlaoAX8eqvTYwDn1zSGFZ0u+N72c6LQ1VYgNk/JFUQCb3OJzvoyUEzoaD
         cRxSDJWSpmiEb7qYa/k0szyVNZ3gEQ8vnk08SvSP65B4jXmH6bf4LXWGRZq+aBwve8de
         ehfwXeVca7WeyRLbqMBhfzNx+pPeQzprzUc5xdj0xZTzxwdu5Xtitvmrwzt4Es8uGUnn
         khOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3hEGyCucdzbqe3LrutT0J4NZq9m5aBL5wEqBphvaXQ=;
        b=v227Nc8zMlS/J9Zn788Sc7GrqLYuobaw7D5JbS770ni5QqS33uc4FLoX+KI1jLPCHF
         BcalIMn38p52h4WNkSOx3pbgJGBS4WH1LBU1z4h/VAD8aU4F/yeXDu+4OUTeEi03cMOA
         lUzvu9yB7DJxLie/HeLgD41y61iCn1MY1NsqGMSXuVZmhKWFLBYJ2Us+PLEV6LgdlgLF
         FyE5am6dc6fwaTqtSbBdtrP48hagSmqdI4F99+RX8ZYhNJAa+itZv+YvmTob6z3i9iRO
         /bCl0WusU4XlJ/oGubEbjU5b8pkSKyswZNHMfdfy3j9rmsNu9h9FrPErTJMTLvFcC2NK
         ClIA==
X-Gm-Message-State: AO0yUKVNFtiqJMt/CC2oPSegsZwozcjy0S1u8AdTrt4iDBLBeO1Yetwq
        IEKE9fbDvlJgvEYoPeYVGoqv2w==
X-Google-Smtp-Source: AK7set98CJO+wXTLM4UFAXnn0d/1LPj+v6ZqaACgh7v/kaIs6ZoV7T9E/BJ/U9Ahs/LjexIsQttccg==
X-Received: by 2002:a17:906:1093:b0:8b1:75a0:e5c6 with SMTP id u19-20020a170906109300b008b175a0e5c6mr26507949eju.18.1677237636530;
        Fri, 24 Feb 2023 03:20:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090778c700b008e53874f8d8sm3436088ejc.180.2023.02.24.03.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 03:20:36 -0800 (PST)
Message-ID: <1cda61a7-91cd-6f47-619b-e38a5131d182@linaro.org>
Date:   Fri, 24 Feb 2023 12:20:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/3] dt-bindings: net: Bluetooth: Add NXP bluetooth
 support
Content-Language: en-US
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        alok.a.tiwari@oracle.com, hdanton@sina.com,
        ilpo.jarvinen@linux.intel.com, leon@kernel.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-serial@vger.kernel.org, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
References: <20230223103614.4137309-1-neeraj.sanjaykale@nxp.com>
 <20230223103614.4137309-3-neeraj.sanjaykale@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223103614.4137309-3-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 23/02/2023 11:36, Neeraj Sanjay Kale wrote:
> Add binding document for NXP bluetooth chipsets attached over UART.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD5C54EBC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Jan 2023 16:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjALQRD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjALQQI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Jan 2023 11:16:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C303E120BF
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 08:13:38 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ss4so38689904ejb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 08:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzF22PPdIreEIa7ztIOqQnw7vLi6LeZv6ab1mRLDnWc=;
        b=bqsVUJSaXBPpY6v20ecbgsIOho5U3Sj/Z1S91znjlXB1Jsg3nPX3qyf4IobkkjDEXO
         P3HynJbeQkXvir18R3ruJ1/i/jnoXhflHApX/P0aTIL1MP5rKG3XqvZub3m5JfIrSFpq
         mCCHtChSke2M5qtptELzlXxmT13PrRj/8Usjp7CTlVfOvjYTkWsgnPX86dQ3sfkMsiY9
         ONaMNdDkWdZCPbKHtfoj9X261ciUJJ4UagcJlKqy+8P8LaHhUISKztP5uTCepq8+ecgM
         bQliMYX/oE7v95JMxSpySHocLg44juUa4n71Nq0/1aXQuMTLJRZmD3NE1ZGrtUKbXzzx
         q28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzF22PPdIreEIa7ztIOqQnw7vLi6LeZv6ab1mRLDnWc=;
        b=dBoj9YCoFbaGrq1VztLNonhLsIxdUX2e5fmsxIZrIAk8U1dWDdVMEHTO4/IeHMvImX
         UWJTf+slbVu+Qe35nEdnf5uw5hpNKFtPDbEL7tVriq3UXNUTwGyTDW1T/vQAqhTe0u+j
         LTwLEwb955kBnmAC69Lrj0ANkrUfSNr/wlzteZdvKeNLcih4hxTn7302OqG/L9mQEqbh
         wHGxm2NZehc7bLxsHCNA2fi7O4Tof0ceZQE25BJien8eJDBXTw5JdkCszwPAx5AxREGE
         vukBIWnZ8hFo6nHDj8OcRgtaQqYDbOSouIp9MkcefTgnnvNZNP8ccYSDcBE600ZtuYiA
         QSlw==
X-Gm-Message-State: AFqh2kp3ZOrzO4fmF+OEirh9y9HyUgLiNyBpc7hvR/RwWLJHFpkd3Nv+
        MPVB3mzX86/9h/KKvyPZpSYpsA==
X-Google-Smtp-Source: AMrXdXtYZCHpdQvKQqzV4lS/OMAsuYmj6f65+gzDCKvJSN6Zw32OfQ0O0wyHcgs6+c5Yaj9jqIQAcA==
X-Received: by 2002:a17:907:7f04:b0:7c1:36:9002 with SMTP id qf4-20020a1709077f0400b007c100369002mr83786838ejc.67.1673540017416;
        Thu, 12 Jan 2023 08:13:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906311600b0082535e2da13sm7551792ejx.6.2023.01.12.08.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:13:36 -0800 (PST)
Message-ID: <894ffc14-41dc-9abc-4b13-a1f74212ae44@linaro.org>
Date:   Thu, 12 Jan 2023 17:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Fix driver shutdown on closed
 serdev
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Zijun Hu <zijuhu@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20221229102829.403917-1-krzysztof.kozlowski@linaro.org>
 <397c61e8-d928-4e07-9616-afb315d356dd@linaro.org>
 <CABBYNZJYTfVfBMBvfxx6D9a4T5gbqZZcb7BP5LBa28fOEKuoFw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABBYNZJYTfVfBMBvfxx6D9a4T5gbqZZcb7BP5LBa28fOEKuoFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12/01/2023 17:07, Luiz Augusto von Dentz wrote:
>>> Fixes: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure after warm reboot")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>
>> Any comments on this? Patchwork tools complain on longer line, but
>> without it checkpatch would complain as well, so I assume you do not
>> expect to fix it?
> 
> I did apply it already:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=a18fca670e14f0c09c2ed332cf2c6d77a4ae05f9
> 
> Not sure why the bot hasn't responded to you.


Ah, thank you then. I looked at Patchwork and it was still in state "New".

Best regards,
Krzysztof


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C771C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Nov 2022 20:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKHU6N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKHU6M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Nov 2022 15:58:12 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33DB5D6BB
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Nov 2022 12:58:10 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a15so22905991ljb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Nov 2022 12:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YiA2Wd0IR7dQTTPfcMVQBLNUibTd8t/7NXvnUyybPgs=;
        b=lcxjZZUR35gq/5AK49tt3cK2v9exG4A+54xtJZWblLRAduphqSBZA8v3/Yv5A2GzNK
         GDStbrqL78d2zySqbtgHLSw7RJ67rIqHzdhuybvFZ40X30Lt067zVh/y8okJDbgmgryA
         XuBMWiK1kVuZf1Xlpa1fVO5qNNsOahUa/tGQ5u7ibUbiDwbnP0Ab6C3NesGEdjrbwLO9
         lzl+PmZncFQe5HvnG+icbFJA+lhnUuAFjhVwZHXyCrplGCz2PfVOdaX0ivf53xOutvV2
         MFhBiJTaPhKW/1UvzeBGauJQzjDcXzcyhshzZG8P8chHN+8J4Q+ONTM4G7ziXznXACJP
         3ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiA2Wd0IR7dQTTPfcMVQBLNUibTd8t/7NXvnUyybPgs=;
        b=zBkvwpM2HUKvQhz8StxKgWP9prsjULZDv6MyH5Lol/gu8mnPIulzKqqEOKc9cSls4s
         G2A1jUmkIFsnE4R/2FVHv5DDkRuZxyrNVmvfDKn1+b55k0IX+R4rlJn0YL0kSVjwMQnW
         hK/R8/3wlBU53Inncp+50RQ8WraZ2stPr7Nmv0FeYgNHT3boFhIHKgT9bHmDluirdnqW
         //Zl2cBy1ih7Hk3T3jCwEoWC6yjkVCHXxP73Fph7Ov0a9JG9oTIgjdIy28BJHWfsMibB
         e35i3R4zNxMlm8WrVQNlihcsmAYbHSeQMrEFVjxXQ6i6T4K87JUv00x00WNwgUg6vBtj
         ZnLA==
X-Gm-Message-State: ACrzQf0AC+6+wrg/neNatth3XeIT1er6WM5FxV9lWs38Hj3EdAPxs/Cp
        N/CU4tu9VpxCuUNJ9TEnQ9rGsg==
X-Google-Smtp-Source: AMsMyM79uvUhq83VGW7jdee8v+oVdQ4MCBl3TmsdatEAkaCoQD9jY8DL6magc/wqASnZRN1HgL9RIA==
X-Received: by 2002:a2e:b88a:0:b0:277:7364:cbcf with SMTP id r10-20020a2eb88a000000b002777364cbcfmr12360651ljp.50.1667941089163;
        Tue, 08 Nov 2022 12:58:09 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b00498fbec3f8asm1919840lfa.129.2022.11.08.12.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:58:08 -0800 (PST)
Message-ID: <a8fe49f4-09f2-2507-e652-cbbb13ed8006@linaro.org>
Date:   Tue, 8 Nov 2022 21:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 2/2] bluetooth/hci_h4: add serdev support
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>, mizo@atmark-techno.com
References: <20221108055531.2176793-1-dominique.martinet@atmark-techno.com>
 <20221108055531.2176793-3-dominique.martinet@atmark-techno.com>
 <Y2q+TkZJOfXFYlBO@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y2q+TkZJOfXFYlBO@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 08/11/2022 21:38, Andrew Lunn wrote:
>> +static int h4_probe(struct serdev_device *serdev)
>> +{
>> +	struct h4_device *h4dev;
>> +	struct hci_uart *hu;
>> +	int ret;
>> +	u32 speed;
>> +
>> +	h4dev = devm_kzalloc(&serdev->dev, sizeof(*h4dev), GFP_KERNEL);
>> +	if (!h4dev)
>> +		return -ENOMEM;
>> +
>> +	hu = &h4dev->hu;
>> +
>> +	hu->serdev = serdev;
>> +	ret = device_property_read_u32(&serdev->dev, "max-speed", &speed);
>> +	if (!ret) {
>> +		/* h4 does not have any baudrate handling:
>> +		 * user oper speed from the start
>> +		 */
>> +		hu->init_speed = speed;
>> +		hu->oper_speed = speed;
>> +	}
>> +
>> +	serdev_device_set_drvdata(serdev, h4dev);
>> +	dev_info(&serdev->dev, "h4 device registered.\n");
> 
> It is considered bad practice to spam the logs like this. dev_dbg().
> 
>> +
>> +	return hci_uart_register_device(hu, &h4p);
>> +}
>> +
>> +static void h4_remove(struct serdev_device *serdev)
>> +{
>> +	struct h4_device *h4dev = serdev_device_get_drvdata(serdev);
>> +
>> +	dev_info(&serdev->dev, "h4 device unregistered.\n");
> 
> dev_dbg().

I would say none of them (the same in probe). Any prints in probe/remove
paths are considered redundant, as core already gives that information.

Best regards,
Krzysztof


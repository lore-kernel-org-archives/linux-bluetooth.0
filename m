Return-Path: <SRS0=qr/Y=ZO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05405C432C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 12:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA81A20706
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 12:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9oTsu5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKVMhi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:37:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39558 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKVMhi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Nov 2019 07:37:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so7420684wmi.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2019 04:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X4K76pITHjoW+fa3ephYy9jhYLb0anju8+JDtfWwrMo=;
        b=l9oTsu5shbpcjdsSwtgQHiZEY/Zhv+j4fH96zPPltEiyBy+k1AZHX0yabuqzodEBaD
         RQNx5e8fzDptI4ws302zA6INij2R6IeyivlLSxibGUpAkPyxKbejs4IzrR239NGkZRKN
         K6szMVKs0L981fsUN85ZRZixc6ISbRYUHPS7jsrWEamnWXFm2fcWZBbp36wbOxn9j0KZ
         4T8+Rgw7OS971wKMGEiosPjbTrNYrpRzHmzsJ5owSm15prmsNmU0IF/iFaQk6cWXnCN7
         c+23hrrxGsESWqJ6mbBUi6pH+xwepNJB0haDlZEyKor8snR+9Wt3NMznxd+uLaxlCQIh
         CtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X4K76pITHjoW+fa3ephYy9jhYLb0anju8+JDtfWwrMo=;
        b=Bl30uOjtG3oT0MQOir9Q3YflUbMF4xcTrBcaEZ+Lry8op9bQ+WIe/BId3uqcZ7d5ju
         IOegTqIXTLr0BkXPCMfpSacyvT4gItj01Hzyg4eS71UhPPw+FW2Yz9nqvdd7Sc2Lu5jx
         YgNEIPxkQ5GOqo4kIquox6GhkRiirP8qH2CIPxBhtJYjoRSahdqqo0irRkvFUlJGk0yY
         nmfQ7dH40tyNSV+L0A51oi8pnF5UKqvgn5jgxX6N0nUKhVxx6B47lX04x+pVcYDXrHYN
         tjB5ZrIQKVmWZC1IeciGrxWHosKuKaVq0ZsfHI4BYTDoF2aEx8dPvZ+7fAUitrQwsl2f
         9t/g==
X-Gm-Message-State: APjAAAXusUXWI94ysT7WAee+CgglCLtoNciLSwRl2/WSRGYXRgRUz3xJ
        myHJww7zEVC+YzV0jII7Vt0=
X-Google-Smtp-Source: APXvYqwlj4B0SLCG5cLNJj8zPuqIaYFnizLeEnWN+h2GD8HaG2A1/q7LWbWH9EQnHf3HxdLN5lfn3Q==
X-Received: by 2002:a05:600c:295:: with SMTP id 21mr15866926wmk.43.1574426256517;
        Fri, 22 Nov 2019 04:37:36 -0800 (PST)
Received: from mamamia.internal (a89-183-130-53.net-htp.de. [89.183.130.53])
        by smtp.gmail.com with ESMTPSA id v6sm7694594wrt.13.2019.11.22.04.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 04:37:36 -0800 (PST)
Subject: Re: [PATCH v4] bluetooth: bcm: Use the BDADDR_PROPERTY quirk
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <20191122123142.2152298-1-a.heider@gmail.com>
 <FEB2FF9F-A85A-4AA1-A4BA-1B8CFC125B6B@holtmann.org>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <d6ee4a69-1ad3-6f91-2994-c5a3ba704598@gmail.com>
Date:   Fri, 22 Nov 2019 13:37:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <FEB2FF9F-A85A-4AA1-A4BA-1B8CFC125B6B@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 22/11/2019 13:35, Marcel Holtmann wrote:
> Hi Andre,
> 
>> Some devices ship with the controller default address, like the
>> Orange Pi 3 (BCM4345C5).
>>
>> Allow the bootloader to set a valid address through the device tree.
>>
>> Signed-off-by: Andre Heider <a.heider@gmail.com>
>> ---
>> drivers/bluetooth/btbcm.c | 5 +++++
>> 1 file changed, 5 insertions(+)
> 
> patch has been applied to bluetooth-next tree.

Nice, thank you!
Andre

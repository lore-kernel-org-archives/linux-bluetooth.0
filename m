Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF690C61DB3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Jan 2023 15:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjALPae (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjALP2G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Jan 2023 10:28:06 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED8C50E5E
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 07:20:05 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u9so45636550ejo.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 07:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeGx7+cxIil0fG9CKpThQTNHkXDemVS+Svc4rtN60NE=;
        b=RSnI19iNiH4LvfsHiH0oHsMRnYKYQnnYj8yyOiSfw0BMTyX+aL9ot7mgcz5ImgcD+Q
         dnVha/un+y6H6LNAt2e3dSJo2H6ZSYO+NrYHda0tF4bxSNcKnShZiY02YtR4qRjE6vSO
         RzVZea8I74wIWxJku0CWSJA9hpaganuBp3zwEoLy4k7Lx3ysf1rtlkHjEuLZw+F3ZPuV
         YT6MJzg39LH2ISN0VzyynZuuzSpqn+rccNZy6hr6eA6A72+ZonWBT8qRHeoQsRoVvIz9
         uzDksxc1afmAJjpXf10JgRpKMn2Jyf9mgxqZz91ovDSv/iUt1dQ71rmhjFWT6GzxGIyW
         b7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeGx7+cxIil0fG9CKpThQTNHkXDemVS+Svc4rtN60NE=;
        b=vj9pXxwQh/FFe6DmN2KTweqqxOjXwmexowaSOvwWdofCuvS7tWzL04nNvHfqNpXOsa
         Viq3iPXX8o+AycNfVzdpj5DInEkxLvSpvbKqrL7/Tvno1/6ZOYSSQF+oxAhi9R5MgEgS
         RLj2gsLhaQ3sTWFK4MpTv7KshsAS3xB0Ny/E0z+oisjColIszYGyVt0AXod37mV29319
         jerYgk198RstEXLN+xRHrB/lWUL1KIIc3vPPjuCqG5MnLyP8/4MY0vYtGIo0FsfZoQmi
         Jnqy7jtucwL76OECM4jc77H+j/EY/I2kVK145+Mc5BhtzCssVshe5TRonsDdnYD2qrNz
         8mrg==
X-Gm-Message-State: AFqh2kp3T4RBEIk9CXUGWHoPRroziF7hHPevtkQW3fxZPQz+kRYVbPe9
        UWUpPjE7AppHMXCbgmUrqx3CHQ==
X-Google-Smtp-Source: AMrXdXunfAtUO2n9K2zIuudzXhsXWCymJpARhYbcgDoK9J813efwLCbRsshFPugW80P9fxWStQ7obg==
X-Received: by 2002:a17:907:8b98:b0:840:a6a3:41c7 with SMTP id tb24-20020a1709078b9800b00840a6a341c7mr69455668ejc.50.1673536803960;
        Thu, 12 Jan 2023 07:20:03 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090630c200b00780b1979adesm7483266ejb.218.2023.01.12.07.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 07:20:03 -0800 (PST)
Message-ID: <397c61e8-d928-4e07-9616-afb315d356dd@linaro.org>
Date:   Thu, 12 Jan 2023 16:20:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Fix driver shutdown on closed
 serdev
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zijun Hu <zijuhu@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20221229102829.403917-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221229102829.403917-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 29/12/2022 11:28, Krzysztof Kozlowski wrote:
> The driver shutdown callback (which sends EDL_SOC_RESET to the device
> over serdev) should not be invoked when HCI device is not open (e.g. if
> hci_dev_open_sync() failed), because the serdev and its TTY are not open
> either.  Also skip this step if device is powered off
> (qca_power_shutdown()).
> 
> The shutdown callback causes use-after-free during system reboot with
> Qualcomm Atheros Bluetooth:
> 
>   Unable to handle kernel paging request at virtual address 0072662f67726fd7
>   ...
>   CPU: 6 PID: 1 Comm: systemd-shutdow Tainted: G        W          6.1.0-rt5-00325-g8a5f56bcfcca #8
>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>   Call trace:
>    tty_driver_flush_buffer+0x4/0x30
>    serdev_device_write_flush+0x24/0x34
>    qca_serdev_shutdown+0x80/0x130 [hci_uart]
>    device_shutdown+0x15c/0x260
>    kernel_restart+0x48/0xac
> 
> KASAN report:
> 
>   BUG: KASAN: use-after-free in tty_driver_flush_buffer+0x1c/0x50
>   Read of size 8 at addr ffff16270c2e0018 by task systemd-shutdow/1
> 
>   CPU: 7 PID: 1 Comm: systemd-shutdow Not tainted 6.1.0-next-20221220-00014-gb85aaf97fb01-dirty #28
>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>   Call trace:
>    dump_backtrace.part.0+0xdc/0xf0
>    show_stack+0x18/0x30
>    dump_stack_lvl+0x68/0x84
>    print_report+0x188/0x488
>    kasan_report+0xa4/0xf0
>    __asan_load8+0x80/0xac
>    tty_driver_flush_buffer+0x1c/0x50
>    ttyport_write_flush+0x34/0x44
>    serdev_device_write_flush+0x48/0x60
>    qca_serdev_shutdown+0x124/0x274
>    device_shutdown+0x1e8/0x350
>    kernel_restart+0x48/0xb0
>    __do_sys_reboot+0x244/0x2d0
>    __arm64_sys_reboot+0x54/0x70
>    invoke_syscall+0x60/0x190
>    el0_svc_common.constprop.0+0x7c/0x160
>    do_el0_svc+0x44/0xf0
>    el0_svc+0x2c/0x6c
>    el0t_64_sync_handler+0xbc/0x140
>    el0t_64_sync+0x190/0x194
> 
> Fixes: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure after warm reboot")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Any comments on this? Patchwork tools complain on longer line, but
without it checkpatch would complain as well, so I assume you do not
expect to fix it?

Best regards,
Krzysztof


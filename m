Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62545C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 10:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F844611C7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 10:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhJTKK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTKK0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 06:10:26 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF29C06161C;
        Wed, 20 Oct 2021 03:08:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F0EA1645EF;
        Wed, 20 Oct 2021 10:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1634724489; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=M6B5UJlRcsRnejGuLXxI1zEBv97AMT0nOeR4Ymn+8uw=;
        b=tiudbADV6rIlYO4YtsOKrSaISwRb7/xKOL2+ZsZBm8pGPW013FumSlbVpCg7FqViXZYD9a
        BNo8LDXlP2G/JG8vC5Onedq7xt96OhjkQawM7qL6xxx0dgn8e+YYVPX2BdxfNQO5gU3Azy
        pyB1fWl1uODD3lfcA13IpdwVbgoz2XLatmTjFpAcCBLbeGHOKU8fE9tLAY6jPrzOpmYOjP
        V5kyZtFDvRNP7gHIknup+kN/sWg0XEiurWlaVgzlcxtGkGOhagd0JaA3ARNEcTj1NDqf/7
        ZvfkQ/2n4jMJxnDdQp2Z6eR9rk/BBKG2w9xrI3r34yeNYJ7GyS6kl7QDN3C1HQ==
Subject: Re: [PATCH 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver
 0x08
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        chbgdn <chbgdn@gmail.com>
References: <20211019095738.2098486-1-adeep@lexina.in>
 <20211019095738.2098486-2-adeep@lexina.in>
 <F99878E7-51E7-48B0-921B-8CDD53693E04@holtmann.org>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <7c0ba739-f2fe-ad09-e3e2-4b1286aabf38@lexina.in>
Date:   Wed, 20 Oct 2021 13:08:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <F99878E7-51E7-48B0-921B-8CDD53693E04@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

19.10.2021 21:29, Marcel Holtmann wrote:
> Hi Vyacheslav,
> 
>> Add detection of RTL8822CS controller with hci_ver = 0x08
>>
>> Signed-off-by: chbgdn <chbgdn@gmail.com>
> 
> clear name please.

If Bohdan doesn't answer, we can remove this line.

>> +	/* 8822C with UART interface */
>> +	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
>> +	  .config_needed = true,
>> +	  .has_rom_version = true,
>> +	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
>> +	  .cfg_name = "rtl_bt/rtl8822cs_config" },
>> +
> 
> what about the .has_msft_ext here. Does this one support the Microsoft extension?



This is only a variant of the already added 8822c controller, so I 
simply copied the parameters and changed only hci_ver to 0x8.
I found this controller on X96 TV Box and JetHome H1 device.

It will also be necessary to update rtl8822cs_config in the 
linux-firmware repository from 
https://github.com/armbian/firmware/commit/5d685ad233b4dfd03a4d025fa0061f6b0f850cb3

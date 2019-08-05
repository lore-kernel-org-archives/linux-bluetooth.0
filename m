Return-Path: <SRS0=EM7j=WB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34E7C433FF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Aug 2019 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FC3217D9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Aug 2019 04:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfHEEHr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:07:47 -0400
Received: from zrw-cggw-02.zabzd.ru ([195.39.228.149]:50378 "EHLO
        zrw-cggw-02.zabzd.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfHEEHq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Aug 2019 00:07:46 -0400
Received: by zrw-cggw-02.zabzd.ru (CommuniGate Pro PIPE 6.1.2)
  with PIPE id 893699; Mon, 05 Aug 2019 07:07:43 +0300
Received: from [10.244.0.130] (HELO zrw.oao.rzd)
  by zrw-cggw-02.zabzd.ru (CommuniGate Pro SMTP 6.1.2)
  with ESMTP id 893698 for linux-bluetooth@vger.kernel.org; Mon, 05 Aug 2019 07:07:35 +0300
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiPhishing: not scanned, disabled by settings
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2019/08/04 22:17:00 #13682564
X-KLMS-AntiVirus-Status: Clean, skipped
Received: from [10.123.236.115] (HELO [10.123.236.115])
  by zrw.rzd (CommuniGate Pro SMTP 6.1.2)
  with ESMTP id 59028239 for linux-bluetooth@vger.kernel.org; Mon, 05 Aug 2019 07:07:35 +0300
Subject: Re: May be 'bluetoothctl devices' not right?
References: <000301d347db$df1dd300$9d597900$@com>
 <6B2D6FC09217DA4280D35175FA16A620688418CA@msceml521-mbx.china.huawei.com>
 <457BA4F48509464E9000537839AF501857261694@msceml521-mbx.china.huawei.com>
 <59E7EBF9.3050705@zabzd.ru>
 <457BA4F48509464E9000537839AF501857261990@msceml521-mbx.china.huawei.com>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F1DDAB@msceml522-mbx.china.huawei.com>
 <59E946F9.1060501@zabzd.ru>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F1E01D@msceml522-mbx.china.huawei.com>
 <59ED2E3D.7030809@zabzd.ru>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F1E6D0@msceml522-mbx.china.huawei.com>
 <59F92B55.0@zabzd.ru>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F23FDB@msceml522-mbx.china.huawei.com>
 <480C9E29A742984996B50276401889F36B33E940@msceml521-mbx.china.huawei.com>
 <5D427A18.1080402@zabzd.ru>
To:     linux-bluetooth@vger.kernel.org
From:   =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@zabzd.ru>
Message-ID: <5D47BA12.1080502@zabzd.ru>
Date:   Mon, 5 Aug 2019 13:09:38 +0800
User-Agent: Microsoft Outlook Express 6.00.2900.5931
MIME-Version: 1.0
In-Reply-To: <5D427A18.1080402@zabzd.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Maybe you know the standart method to check availability of the device ?

Now i use l2ping command for this.



01.08.2019 13:35, Проклов Александр Валерьевич пишет:
> Hi all,
>
> The 'devices' command 'List available devices' should show all founded
> devices after 'scan on' (all visible paired and unpaired devices?).
>
> Now (git version bluetoothctl) 'devices' command show visible devices
> and all paired devices even if the device is turned off (not available).
>
> May be exclude the display of paired devices that are turned off (not
> available)?
>
> --------------
> Best regards,
> Aleksandr Proklov


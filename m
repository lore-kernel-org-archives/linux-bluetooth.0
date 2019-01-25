Return-Path: <SRS0=pNHN=QB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B04C282C6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 17:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6014C218A2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 17:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAYRqN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:46:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55798 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYRqM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Jan 2019 12:46:12 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gn5YP-0007bu-R5
        for linux-bluetooth@vger.kernel.org; Fri, 25 Jan 2019 17:46:09 +0000
Received: by mail-pg1-f197.google.com with SMTP id o9so6769410pgv.19
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jan 2019 09:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cXMMSsIwIxMUCQGwbpgvBiJSFr93ymqLegKuofcIW2E=;
        b=Hp4CjmwrFgrtNjffCcVXkrrvr2pD8H33wLlAJggcK0mQ1S83ZzsE7ninx8xlVt1zYi
         a0QZQSjL4Rtm6XWsXDoiWrz5LRezY5n98f5bn5UZVDLjFG5BvW+arPfEk6l2+t/rGw/9
         /8hduQ48InFgUJGCYG1waJqJkrFR9GeuRK9dj+uBjDdKb7S5YaGPWJpJ5iHvXKpl7Wc+
         LbVoHPwftyVsS1orbcCEqdxieY5YEn1ShHGZfOWT+iEcpXZ5sIju2K+XXGS8avFmbiK3
         GeOxcIM7nZ/3GGMT+zM0Toczq/7d4lgnO20Zz5qUaGFUekGnUuatnio8H55Qd2UXOquW
         bGgg==
X-Gm-Message-State: AJcUukcTICSR5RuzhbL11Gj8q25lc5w6qH4/spQrmfXbnUSMt9zS0tFE
        khC9HCGm5LQSaOY19cSJFP8ULn5CGIWCi6COAzKgxiQPl7tESPO1WXAwtnxn0zFy9sqXcZ1B6dA
        8jIhHS2qJJw+rTIHgrLp9R5UTlvsJqqw3YDcELKnWw+rhVw==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr10840337pgk.147.1548438368460;
        Fri, 25 Jan 2019 09:46:08 -0800 (PST)
X-Google-Smtp-Source: ALg8bN61h3QIm8TFXh9P0P9jkYWPZDMzfIEz8KU2KfB23ZnFW464wPqh8Vb2AVMrcz1SDG72VE9SeQ==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr10840320pgk.147.1548438368144;
        Fri, 25 Jan 2019 09:46:08 -0800 (PST)
Received: from 2001-b011-380f-13aa-7c32-6b23-13f1-0d51.dynamic-ip6.hinet.net (2001-b011-380f-13aa-7c32-6b23-13f1-0d51.dynamic-ip6.hinet.net. [2001:b011:380f:13aa:7c32:6b23:13f1:d51])
        by smtp.gmail.com with ESMTPSA id s190sm34384027pfb.103.2019.01.25.09.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 09:46:07 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 3/3] Bluetooth: btrtl: Skip initialization if firmware is
 already loaded
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAD8Lp47YpoVeDheK3pi0CcSJTdh2jSVcM8V9T_zmu=7deXszOw@mail.gmail.com>
Date:   Sat, 26 Jan 2019 01:46:01 +0800
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5D6AFF40-BBE2-4B42-91D2-C89C52ED06A0@canonical.com>
References: <20190124152310.29717-1-kai.heng.feng@canonical.com>
 <20190124152310.29717-3-kai.heng.feng@canonical.com>
 <CAD8Lp47YpoVeDheK3pi0CcSJTdh2jSVcM8V9T_zmu=7deXszOw@mail.gmail.com>
To:     Daniel Drake <drake@endlessm.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On Jan 25, 2019, at 08:55, Daniel Drake <drake@endlessm.com> wrote:
> 
> On Thu, Jan 24, 2019 at 11:23 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Realtek bluetooth may not work after reboot:
>> [   12.446130] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver a99e, hci rev 826c, hci ver 0008
>> 
>> The power is not cut during system reboot, so the firmware is kept in
>> Bluetooth controller.
>> 
>> Realtek bluetooth doesn't have the ability to check firmware loading
>> status. but the version queried by HCI_OP_READ_LOCAL_VERSION will be
>> different if firmware is already loaded. Realtek's own fork, rtk_btusb
>> also use this method to detect the loading status.
>> 
>> So let's assume the firmware is already loaded when we can't find
>> matching IC info.
> 
> This logic was already present in the driver - but it looks like this
> regressed at this point:
> 
> commit 26503ad25de8c7c93a2037f919c2e49a62cf65f1
> Author: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Date:   Thu Aug 2 16:57:13 2018 +0200
> 
>    Bluetooth: btrtl: split the device initialization into smaller parts

Thanks, didn’t find out it’s a regression.

> 
> After your patch it is effectively there in two places now, since it
> is also in btrtl_download_firmware() (although not really effective
> after the above commit). I wonder if that can be cleaned up to avoid
> duplication.

Put the additional check to btrtl_download_firmware() should be sufficient.

> 
> Regarding the other patches that move away from the style of returning
> either a useful value or an error, is this purely a stylistic thing or
> is it needed for your 3rd patch? I don't have strong feelings either
> way but I have the impression that the currently implemented approach
> is a common style within kernel code and I don't see benefit in
> splitting off a separate out parameter.

Ok. I’ll send a v2 without the refactoring part.

Kai-Heng

> 
> Daniel
> 
> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201921
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/bluetooth/btrtl.c | 10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
>> index c36f500d8313..e2f89d57dd14 100644
>> --- a/drivers/bluetooth/btrtl.c
>> +++ b/drivers/bluetooth/btrtl.c
>> @@ -546,9 +546,10 @@ int btrtl_initialize(struct hci_dev *hdev,
>>                                            hdev->bus);
>> 
>>        if (!btrtl_dev->ic_info) {
>> -               rtl_dev_err(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
>> -                           lmp_subver, hci_rev, hci_ver);
>> -               return -EINVAL;
>> +               rtl_dev_info(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
>> +                            lmp_subver, hci_rev, hci_ver);
>> +               rtl_dev_info(hdev, "rtl: firmware may be already loaded, or it's an unsupported IC.");
>> +               return 0;
>>        }
>> 
>>        if (btrtl_dev->ic_info->has_rom_version) {
>> @@ -621,7 +622,8 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
>>        if (ret)
>>                return ret;
>> 
>> -       ret = btrtl_download_firmware(hdev, &btrtl_dev);
>> +       if (btrtl_dev.ic_info)
>> +               ret = btrtl_download_firmware(hdev, &btrtl_dev);
>> 
>>        return ret;
>> }
>> --
>> 2.17.1
>> 


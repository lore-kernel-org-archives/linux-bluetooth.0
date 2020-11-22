Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E6C5519F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6748208FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 17:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1ZQHXBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgKVRl5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 12:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgKVRl5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 12:41:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2020 09:41:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b6so16246824wrt.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2020 09:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=EKhb8NhsV/t7Voql2tnLUOimG3vKrjDJT5wJQd1Y+3Y=;
        b=D1ZQHXBjyyv1uazFdNg8a2S4QEklsdXFEZjr5Ia/9MkyyrM52pn+i2WimNC7l9NXxQ
         72SteUT2pR63hMQKefavoXTdTUVokx89nH0WwNlIxWr0j+xc9rV2qKU9Ex54f3AfeypV
         fDlNGIz7fgR2Z8Ay9xH0cejkbYJG49uX7n0+eLDDzmqqoVD/X8YqTUnUmn74aro5yXcU
         YlB+ymsU1PgkJQ61aBw5P9DPvBhNzKow98BxNzUwBwbjJU4xsGE//BsqVZ79eOEIkCwX
         2yislG8133O/4BfdK43iNC3V1EJi+7PWmqS7j4vWzpMnkgfq3Vj5DsZqcHMi2XBfVU9b
         vROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=EKhb8NhsV/t7Voql2tnLUOimG3vKrjDJT5wJQd1Y+3Y=;
        b=CojP5oAMVS6ihx7VTSkAhiEtlorvDpp626TMe/XVVwwP0wj274ZkpGbxTSGZiMdxYx
         IEi4t4V1BNi/RyZaf9rOh7MGQB6RMizVfTJVUlEXodtoQLtGQq1+tgazYCgzAhCxW1oi
         zUc7+nmahPI9nkYWgffTsT0JjRmRUdDvH7/Q1NhS1zCH1fBKfsOauM3Pj713zTJtlNuj
         NIu0EJULEG0eTFjOiBVpdwyLWe6A8TL+CIwyJug536czov5uAx5Qle5jEzUHh0Afj6Ya
         PsGQVxarGPacPaaGsIFUXnn+duu9h3vexrbmf6q+KZSo8fHUwwFwhFkg+wFa1Dd2/2WD
         4bzw==
X-Gm-Message-State: AOAM532AJ+TIzYc0UaYovO1tiKwBNJFiM3cVVzfsSnM5sZXs35XvD8vO
        +I7urO5gRJZRuHk60DEQ45Q=
X-Google-Smtp-Source: ABdhPJwjswWSR25IULqTgZbn/dlUpiGvqYpC8jT3LjkNmpUtheS5Gkdp0lP0dorDBEhOlfaxVPBVrg==
X-Received: by 2002:a5d:6310:: with SMTP id i16mr26629184wru.284.1606066915570;
        Sun, 22 Nov 2020 09:41:55 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:2dfa:b12a:a00c:90c6? (p200300ea8f2328002dfab12aa00c90c6.dip0.t-ipconnect.de. [2003:ea:8f23:2800:2dfa:b12a:a00c:90c6])
        by smtp.googlemail.com with ESMTPSA id q12sm13470473wrx.86.2020.11.22.09.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 09:41:55 -0800 (PST)
Subject: Re: Firmware version read error on Intel AX210
To:     "K, Kiran" <kiran.k@intel.com>, Kiran K <kiraank@gmail.com>
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
References: <89a134d0-c6f6-c685-2aeb-7dc5eee1966f@gmail.com>
 <44820333-3e09-5405-a1aa-19f64087f164@gmail.com>
 <DM6PR11MB314662E82730EF100538531DF5FD0@DM6PR11MB3146.namprd11.prod.outlook.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <65ed6733-6dd2-41fa-7757-55fe5b91f290@gmail.com>
Date:   Sun, 22 Nov 2020 18:41:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB314662E82730EF100538531DF5FD0@DM6PR11MB3146.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 22.11.2020 um 09:35 schrieb K, Kiran:
> Hi Heiner Kallweit,
> 
> The patches to support  Intel AX210  are not fully upstreamed into bluetooth-next.  Final patch set review is in progress - https://patchwork.kernel.org/project/bluetooth/list/?series=387475
> 
Good to hear and thanks for the link to the patch series.
How about firmware, is it submitted to linux-firmware in parallel?


Following is unrelated, however I hope you're the right addressee too.

In btusb.c we have the following code. I interpret this in a way
that once firmware was loaded the driver will never check for
updated firmware.
Shouldn't the driver always read the firmware file available on
the system and check its version against the firmware version
the device has (and apply it if it's newer)?
But maybe I miss something ..

bt_dev_info(hdev, "read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
	    ver.hw_platform, ver.hw_variant, ver.hw_revision,
	    ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
	    ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);

/* fw_patch_num indicates the version of patch the device currently
 * have. If there is no patch data in the device, it is always 0x00.
 * So, if it is other than 0x00, no need to patch the device again.
 */
if (ver.fw_patch_num) {
	bt_dev_info(hdev, "Intel device is already patched. "
		    "patch num: %02x", ver.fw_patch_num);
	goto complete;
}



> Regards,
> Kiran
> 
Thank you, Heiner

>> -----Original Message-----
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>> Sent: Sunday, November 22, 2020 4:30 AM
>> To: Kiran K <kiraank@gmail.com>; K, Kiran <kiran.k@intel.com>
>> Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
>> Subject: Re: Firmware version read error on Intel AX210
>>
>> Am 21.11.2020 um 23:12 schrieb Heiner Kallweit:
>>> I have a new AX210 WiFi/Bluetooth card and btintel_read_version()
>>> fails with error -22 (EINVAL). Underlying error is that the firmware
>>> version read command returns with hdev->req_result = 18 (0x12).
>>> (req_status = 0)
>>> >From what I've read this means invalid command parameters.
>>> Did something change with AX210 and command 0xfc05 requires specific
>>> parameters now? Or what else may cause this issue?
>>>
>> Seems AX210 uses the new TLV infrastructure. btintel_read_version_tlv()
>> returns valid data. Will TLV/AX210 support be added for 5.11?


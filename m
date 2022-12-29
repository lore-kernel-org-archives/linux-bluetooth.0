Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAABC3DA79
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 21:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiL2VGX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 16:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiL2VGU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 16:06:20 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD50D1CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 13:06:19 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id j5so9301832vkp.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLNxs7pbWYpTYvz8n5ArGbH6UGnr7tRzCa9oZesPdqs=;
        b=J29It6oTqRe7mj0MdCJFWyTgOmv9nxCVNkbmAwxBc2g6vwpxbOFusxdV9Pe7g7WCKf
         EkWA40CAiucwPlnh+8KhEqMHAS0xejOWPuZ8C0zd42uflrPXeotn5J5NAPol4TgfdR/R
         ypjAkwXgO7SkxnqTaiT98D9/0Ci6JdoHZrbFJGPC+/zh+w+phujsHCLO94Bi490lvGkL
         tk+muPSj1wA5UM3v2Jwaw7lXvQ5F+slWsQZTINkRCxSOFtHNvwryPDkETQJ+vz644ZEp
         e3X25vGxUaTM35j1ZZxe4Ck0wSd1O6604Xgi5mYfCjrwl2xT3Y4K2vV6yH+I4gPZzqRq
         xv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gLNxs7pbWYpTYvz8n5ArGbH6UGnr7tRzCa9oZesPdqs=;
        b=AL7lnHfWF8XF+lehwwTGddGrN6twTlSNjWPfXm6InAlIS8e4Xdei+WfDcPtLz+NRqi
         mOmQre23Iao2AaY4qVFPrbaA7MI0qaCcOvv9q52YjqBGuvBZGPgq78naqBKYvr8gjDLc
         nll68awAEpoWkpg3dYZomF1HcqR+kfOA6pHqTWZ45SG4tB3JMB4PmaXthvp5HwIqqIh/
         zwiTpGjw9TV526rbJT8Trt5e3pcCPsi81MVyfe69p9A8/tOB0SoFaAln20zdlVZz3ucM
         OkCywjh/K6BcG93ikcbEVLFCLi6Fiz4ph6xddOjfApy8XOrd8IOkqBlxRZxpZ5QMJi/9
         J9Zg==
X-Gm-Message-State: AFqh2krflx6TbGBEyQ2YprQiwL+014oNkV9llmMNy5ZH6tCK4xBVHtv4
        pLEs6XJ9DSvau6pW0JwiQWDdYdW1/Vw=
X-Google-Smtp-Source: AMrXdXsBXNmSQBm9idS9kCkiqnTIudQV25go7pHy23GVzGNUtULp2wBT6mPyVVSlhuXtCNRpMUXymA==
X-Received: by 2002:a1f:1b07:0:b0:3bd:fb7f:e385 with SMTP id b7-20020a1f1b07000000b003bdfb7fe385mr12127997vkb.8.1672347978791;
        Thu, 29 Dec 2022 13:06:18 -0800 (PST)
Received: from [192.168.1.104] (c-73-129-38-53.hsd1.va.comcast.net. [73.129.38.53])
        by smtp.gmail.com with ESMTPSA id bq43-20020a05620a46ab00b0070209239b87sm14001918qkb.41.2022.12.29.13.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 13:06:17 -0800 (PST)
Message-ID: <76585149-101a-f24b-7160-ff741ccd656c@gmail.com>
Date:   Thu, 29 Dec 2022 16:06:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
From:   Robert Lippmann <robert.m.lippmann@gmail.com>
Subject: Ugreen Bluetooth 5.3 adapter
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

I've been working on trying to get this to work.

I've applied this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=0bb039f39058

But I was still getting the following error:

Bluetooth: hci0: Opcode 0x c5a failed: -56

I added

set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,&hdev->quirks);

as an additional quirk for the device, but now I'm getting

Bluetooth: hci0: Opcode 0x202e failed: -56

Which tells me that HCI_OP_LE_SET_RPA_TIMEOUT isn't supported. I'm not 
at all familiar with the linux bluetooth drivers, so I'm not sure how to 
work around this.  I didn't see another quirk I could register.

Any advice?

TIA


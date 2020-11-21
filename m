Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7EFC388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 22:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF72D221F7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 22:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T43OGC50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgKUWMg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 Nov 2020 17:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgKUWMg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 Nov 2020 17:12:36 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2926C0613CF
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 14:12:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p19so10674548wmg.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 14:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=9t8bFinAaMlUyEymt3/69GshI7ikXBboCwGte6k+0fg=;
        b=T43OGC50NbjOvhknQigpaw4ktxVfDOEpyM4FGY2N0SoeN4kptfNB66U/UNCCJjzsxl
         f/cAqMY/MYafXoY+cI2Mh6gf7TslmTAjDu1kjeW1Ot6OoVRn3leA0nYpSsdczwifVzbc
         7HBb/YtWvB9DbZk69w4FHKJAaoQ6u1fKXGYumkMJlqtNaqtAOe+pj4EO7vV75rHr0RIW
         ZW5IxmxpNOmstfP4xgFyO+KilT6tq5vcYqzx6A1Mnqkcfk+G6CumvwjeZhy/Ej3THbhd
         acXRYmLwiSuqmaQBiNpVY4fsmnLdZrta5fd7cfL0qAoopnlahE1QwmStAPiThdDbCdPJ
         byBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=9t8bFinAaMlUyEymt3/69GshI7ikXBboCwGte6k+0fg=;
        b=YUvVQuUENi5ACc6ZldvWmPqeEQqo9kvGxqjLZrPe48jZHsoZDqoG1hQSyl+WusKJi4
         HO7JLaJwyX2o4CypaNrpugX1hrYZe6AGPdRfedupRGq7IW8CRF05TZ673GzEmS7Ji4JC
         /3/vp5nmDLTcTfm16DlcauMb8HQQk0G3PLXei+9ZDwGiSdwrlRgdSKfuqnWjhVqJ6ThM
         Qx8zcaNHJsznzJDBJBFZSnbiLgvYB2NKfFEWjRMQQ8mYdWXA6HvQGyXM9JHU14+gRceX
         zn7VZDT405dOcVfltezG/WpZQfItjo/CW+CIDCf5AEx0kktZmbeTMGmRFsTOdSbH18qs
         DrQA==
X-Gm-Message-State: AOAM532I0qZ9pWqy5M1rB0bHbby3E1c6kBjhDSK1MgkgVoZQOhXuI02D
        NkcI6QreIUjs8aoy66Q7ryMXYHYwDAuzxg==
X-Google-Smtp-Source: ABdhPJwKS1IcxAp9JWjGbviqdfte6k4fqtxtiZ1LLiVsM870PGUhKmuLO86opnSzfO8oSG2fTPCvVw==
X-Received: by 2002:a1c:5f84:: with SMTP id t126mr16503419wmb.172.1605996754133;
        Sat, 21 Nov 2020 14:12:34 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:f88a:cca6:feee:cbdc? (p200300ea8f232800f88acca6feeecbdc.dip0.t-ipconnect.de. [2003:ea:8f23:2800:f88a:cca6:feee:cbdc])
        by smtp.googlemail.com with ESMTPSA id q17sm11556415wro.36.2020.11.21.14.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 14:12:33 -0800 (PST)
To:     Kiran K <kiraank@gmail.com>, Kiran K <kiran.k@intel.com>
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Firmware version read error on Intel AX210
Message-ID: <89a134d0-c6f6-c685-2aeb-7dc5eee1966f@gmail.com>
Date:   Sat, 21 Nov 2020 23:12:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I have a new AX210 WiFi/Bluetooth card and btintel_read_version() fails
with error -22 (EINVAL). Underlying error is that the firmware version
read command returns with hdev->req_result = 18 (0x12). (req_status = 0)
>From what I've read this means invalid command parameters.
Did something change with AX210 and command 0xfc05 requires specific
parameters now? Or what else may cause this issue?

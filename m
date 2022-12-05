Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3AAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 15:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiLEP4V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLEP4U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 10:56:20 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2513D44
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 07:56:19 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1447c7aa004so5791610fac.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 07:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WGSFtuHVW4P96j9RQJ6UMTRL+tc6CJpAtWoOPovSJ3s=;
        b=QBzm2hLPnr3cclKAd9shuu/Uypu17XxRSKoUXObdNGcPUF8vofhhTf0PEhaJ/AwFly
         1BZRt+hqrJeCUUzp3CpFOhFqb1+QgOiac5RofgaxpwqzQE+iU2Q/t93p7X9AQQEJQ+Dx
         OjBUISxqcNIZlyyAX3vw8+o4b6fIDyAq1sa0u44B8/6WJZEocwTKrgwYc6bvGmScuaCO
         cDTIVmcd9xAPo48icXx2dG3YDmaR349t7H8+/IPTkt6ZneArlOMljonOq6y9H16c35Aa
         zYnOPJ3OACpZTYRXm5Kpms+VQ6P3X2rWX6eTC6iqM9FUOJeBNT4O9O6qbXvQ/ihGsfg0
         aSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGSFtuHVW4P96j9RQJ6UMTRL+tc6CJpAtWoOPovSJ3s=;
        b=dSZHJgfakKmV9FkuD/ysgU4HJH/oZ25Djyaqe1dCcENrB3MQaxrdUGiEnTKOefG/jq
         uAyJe7oHy8DQ3/EgJ421OuTcn7A11n5l0D/7KHR/350bVKMH7OR96kKpWsv7Enw9qu4F
         I1IVEpu6SvyGiT+z00ibmS2NeOMboIZY3yHoORPZDriqjUgHQI4ksX9kl5o4dyOI5r9g
         cte6HFI1EdjGW6ze1xS8UAms1IzE5zVuyn1+0HMi9mc9veFryJh5m4dPe1uPC/TSWhge
         3KTWV3hfFs++xOcJB7ZWMoAZEYN3FfurZZiKyig/zLinVTJ0SZknTx/zX26cwN6ciewT
         xZEQ==
X-Gm-Message-State: ANoB5plnj7IP/v1bHiJptVEKrv6B9+Le69jy0GO1p4CfE/sSpyKYUDUT
        7qwUtc03Hd9jOOtWnQ/b4+PZ5IIy8io=
X-Google-Smtp-Source: AA0mqf4Ax07n109qYe82w3PNwGi2lfFhXnnhW5dpiVvIYNNCp3CJUnfP8GQY0ldZUpDKLgqPsybj7A==
X-Received: by 2002:a05:6870:70a3:b0:132:75f3:1920 with SMTP id v35-20020a05687070a300b0013275f31920mr46268672oae.4.1670255778678;
        Mon, 05 Dec 2022 07:56:18 -0800 (PST)
Received: from [172.17.0.2] ([20.97.117.79])
        by smtp.gmail.com with ESMTPSA id k4-20020a056830150400b00661ad8741b4sm7860278otp.24.2022.12.05.07.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 07:56:18 -0800 (PST)
Message-ID: <638e14a2.050a0220.39273.b498@mx.google.com>
Date:   Mon, 05 Dec 2022 07:56:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5272708339879693585=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yangyingliang@huawei.com
Subject: RE: Bluetooth: don't call kfree_skb() under spin_lock_irqsave()
In-Reply-To: <20221205150928.4017973-2-yangyingliang@huawei.com>
References: <20221205150928.4017973-2-yangyingliang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5272708339879693585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=701842

---Test result---

Test Summary:
CheckPatch                    PASS      3.46 seconds
GitLint                       PASS      1.70 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      33.24 seconds
BuildKernel32                 PASS      28.37 seconds
TestRunnerSetup               PASS      404.37 seconds
TestRunner_l2cap-tester       PASS      15.09 seconds
TestRunner_iso-tester         PASS      14.79 seconds
TestRunner_bnep-tester        PASS      5.12 seconds
TestRunner_mgmt-tester        PASS      100.60 seconds
TestRunner_rfcomm-tester      PASS      8.91 seconds
TestRunner_sco-tester         PASS      8.29 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        PASS      7.11 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      5.54 seconds
IncrementalBuild              PASS      60.74 seconds



---
Regards,
Linux Bluetooth


--===============5272708339879693585==--

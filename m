Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F37C0015E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 02:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHGC0N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 22:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHGC0M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 22:26:12 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E968D1709
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 19:26:10 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63cf6b21035so26545606d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Aug 2023 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691375170; x=1691979970;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=54zqrVfx1OnvMWhl+WsGBFmJYU9vMfQN4mjWMPSCNTk=;
        b=SjVgFZAoEs2bzZeY0sOh+2ec606UBmhOLweEimMZurj1dxzOXIKAqunIvylzrvZA+E
         w8rHAecBD66asfGrvuVWgu3B2y9yl02gPL8kl+4v1DhmpiDimm2+rmTJLoqeiXNpwNKZ
         JZAGwX2NPT/ysl8BWHE+gJPzvbtag0PWiaDMQIo/8SY7J4Q7/Vli2/QSLhXU+zYdoc2V
         31OGVOuKqOjxzA3ok5BTb2av3XBMMxIRzRADCcOw0I8Dh0fKwj2i40K3LVoV55yKvIdh
         o3/ZmlKqi8SNEe8KQ8bZ/qR15e2BqL2l4cyLPTrXArmm6j2sXDDCp4SoP/e+rFHCyPyh
         M3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691375170; x=1691979970;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54zqrVfx1OnvMWhl+WsGBFmJYU9vMfQN4mjWMPSCNTk=;
        b=Oe/QiL0A7qi4qD180KayLrJu2X12Wlk3TTRZ1HFTuf5Gn8nA4W3LYQlR8YA9ho+xSg
         8usgH6AsVhKVi72Z70g+vbuGAYIZy0P1Wd5NW6g2iT19HUchJfRvZPnFb1PJkB/v2FBD
         U7hbVgbES0DRDzXFYvqs+CXaLg1UjBqmw56VcEBsnChAmrriG8MB9N4+un1w+abkpERP
         pEINriM/HJL8xSDeiq9BXB6Z7Ghoh9wiANBfBbNlXLGAFgLCBUJ6Yk4wvwNnNKHqEM4d
         xJFbeCHK6EHnB3O8HOgnNuEFLOcH4ItKJwaLVeQEIzrnSF5sFvq6yhlkrOn5BRLPdbQn
         feng==
X-Gm-Message-State: AOJu0Yz4EXEoK7NqZIAC2Y8zFqcRaj4kunY7eU8upRVNzcE1xxj4qd36
        XzqyN5fur0CasVRWbQLvXH5QMsuNgqI=
X-Google-Smtp-Source: AGHT+IHpQvztQiQVlaFbU4B+QT/c+q7cOH3pBCbh/szhaTvwu6CVFRtPFn159BokpF01bdLyYlM6qg==
X-Received: by 2002:a0c:aac2:0:b0:626:3a5a:f8f8 with SMTP id g2-20020a0caac2000000b006263a5af8f8mr6845009qvb.58.1691375169899;
        Sun, 06 Aug 2023 19:26:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.15.51])
        by smtp.gmail.com with ESMTPSA id l9-20020a0ce089000000b0063d5a7871d4sm2513931qvk.78.2023.08.06.19.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:26:09 -0700 (PDT)
Message-ID: <64d05641.0c0a0220.243bc.89d9@mx.google.com>
Date:   Sun, 06 Aug 2023 19:26:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5909683330401380837=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v3] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
In-Reply-To: <20230807014415.12358-1-max.chou@realtek.com>
References: <20230807014415.12358-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5909683330401380837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773464

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.58 seconds
CheckAllWarning               PASS      37.81 seconds
CheckSparse                   PASS      43.01 seconds
CheckSmatch                   PASS      114.49 seconds
BuildKernel32                 PASS      32.61 seconds
TestRunnerSetup               PASS      497.78 seconds
TestRunner_l2cap-tester       PASS      23.96 seconds
TestRunner_iso-tester         PASS      47.03 seconds
TestRunner_bnep-tester        PASS      10.81 seconds
TestRunner_mgmt-tester        PASS      218.10 seconds
TestRunner_rfcomm-tester      PASS      16.38 seconds
TestRunner_sco-tester         PASS      19.54 seconds
TestRunner_ioctl-tester       PASS      18.47 seconds
TestRunner_mesh-tester        PASS      13.67 seconds
TestRunner_smp-tester         PASS      14.72 seconds
TestRunner_userchan-tester    PASS      11.40 seconds
IncrementalBuild              PASS      31.59 seconds



---
Regards,
Linux Bluetooth


--===============5909683330401380837==--

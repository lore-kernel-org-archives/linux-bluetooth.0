Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DDEC38A02
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 18:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ2SLC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2SLB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 14:11:01 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B76917AAF
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 11:10:53 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r83so9298159oih.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ayaAiY3xidjdZrmLvTsvT+mAIoNMmAeoXs6oow8QFqg=;
        b=lcL3dWKuaxsDy8jCh6/9gLw9VOhR0LYTukXM81Kt2lEN9kjh8LMJpFEEUuxcoMvz/v
         iQh0zKobluYJvfaeSsVyN7x4A5InM4ATKrvtY7h7ANtaCz7zepR1llBQdO8Ac16tZgoP
         smI5W5I+C7WUZpTXzASYZAk0V7QSsj8wJrIrZsce1/1FC1rueL90UctY80szkkIULFi3
         hh0eMmZbW8yB82bI/oFsYChWsIw7fob3k3AXUkAkyFY27KVaAWcyNGmJrJ+i0W4dTUUn
         1IRl/Ii6oyVltYnfETjT53k8TqyYengzgxWI4cMRvU8PojFVyM5GHdHDIUo6/nB9lBXN
         bGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayaAiY3xidjdZrmLvTsvT+mAIoNMmAeoXs6oow8QFqg=;
        b=yhP6jhaHJWbR1QXI5TwigZR62V+yuUzOdV4TujbW6G8ssgrse4s60Y1DTALDoXDBuk
         26SX5cuT/m4Q/kvMJswZthMf6aKwNuBhn+cS260JdX1MAp2yuMHwXl4A/yhtK9BrflYr
         vTBZcxRZ/YmFFAzBAOIcXzgI+0PSr1MQUNaODN/uQ0wgs99eauvb7xti4evw905S4ydI
         1etsqUrHEiASVwpBF5KfAl6bHdMPPmsZkxlJHm0XxlHEK0rBwsYXxjrKoXjXuUqUzeyl
         cbT1fQrTJfFEuBt7VmLKL07WAqM0Un+8+vRZhLe3di7rEXLYjJMqz5q3zF+kwVW1isE5
         PT+A==
X-Gm-Message-State: ACrzQf0wmbX8EDzMu7MRaVf4E8kb1VoR47Td2JCTjsONY3IXK1O1bxt/
        qO5wZtlk05tWlZZikKkjcuWcDmleHOE=
X-Google-Smtp-Source: AMsMyM5l6GyfNahRgLTq/i0vYKaRFr0/WmdDEo5j2nn988H1Kem49XvccZ/diUUpFA/Oy3vWzwQrjg==
X-Received: by 2002:a05:6808:1186:b0:353:b77a:a481 with SMTP id j6-20020a056808118600b00353b77aa481mr11049046oil.199.1667067052517;
        Sat, 29 Oct 2022 11:10:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.56.234])
        by smtp.gmail.com with ESMTPSA id g22-20020a056870341600b0012796e8033dsm888503oah.57.2022.10.29.11.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:10:52 -0700 (PDT)
Message-ID: <635d6cac.050a0220.cda55.287d@mx.google.com>
Date:   Sat, 29 Oct 2022 11:10:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7303743341823327329=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wiagn233@outlook.com
Subject: RE: [RESEND,v3] Bluetooth: btusb: Add more device IDs for WCN6855
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <OS3P286MB2597E5DC0322DE5839B85D7698359@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
References: <OS3P286MB2597E5DC0322DE5839B85D7698359@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7303743341823327329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690163

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       PASS      0.83 seconds
SubjectPrefix                 PASS      0.67 seconds
BuildKernel                   PASS      39.42 seconds
BuildKernel32                 PASS      35.36 seconds
Incremental Build with patchesPASS      51.42 seconds
TestRunner: Setup             PASS      592.71 seconds
TestRunner: l2cap-tester      PASS      19.18 seconds
TestRunner: iso-tester        PASS      18.88 seconds
TestRunner: bnep-tester       PASS      7.32 seconds
TestRunner: mgmt-tester       PASS      116.55 seconds
TestRunner: rfcomm-tester     PASS      11.81 seconds
TestRunner: sco-tester        PASS      11.01 seconds
TestRunner: ioctl-tester      PASS      12.45 seconds
TestRunner: mesh-tester       PASS      9.02 seconds
TestRunner: smp-tester        PASS      10.79 seconds
TestRunner: userchan-tester   PASS      7.97 seconds



---
Regards,
Linux Bluetooth


--===============7303743341823327329==--

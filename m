Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501E9C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Oct 2022 03:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJVDdW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 23:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJVDdV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 23:33:21 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E3B481EC
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 20:33:20 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r8-20020a056830120800b00661a0a236efso2936475otp.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 20:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2nvPuv7gBNxYmyj2XyOmSaZHWd2J3Z22zLWEfgoRElg=;
        b=JbWct1/FI0EelI/9lJF+tdOn4EYf5nDqbOrkCEwuwGW0rSZnVrzOzFAayZeos2n8yQ
         RzsIxdSZyGXtdEwVA92B+seu+Vz9GzTwgwSGgA+0i4Mh+azJaQ7upnG9pW1zJH0AusTm
         Ird8M5q9l3XS8glrbWVFBSx6cYTXDB4KsJ42PdkwIVkoxihn62y4tobYUd3ESRshXelL
         tmxvO8h4YLEfcE58Sud41+KCN2S0vkM5Ome9d9A0FiXpqR1eh+74Wr3vpXohCGNCMkhO
         XQb7e2eU3StOHPwyyGuuVT6Uio2sXDGURDW4CX5oRZGWz4uaxx1DABqCPK4dby490lie
         +gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nvPuv7gBNxYmyj2XyOmSaZHWd2J3Z22zLWEfgoRElg=;
        b=abXiy4+kakln/LyvT9DK7LLyWMOSt+6TdVHasGmrsYU87ZEnmwVeO7T5ap0WLyNV9J
         K5d2uktbbnxbx+1um7XOljRyW1z9liE9mWjkf7B+kvsznlZ//NriR6OIaYybhV8sxdt9
         zdmDSL2+JzU1TMat+GUsStDCPiw3qqUaAKeQtoVP+aAxj2McFlrdESch9Wff/rC48t0n
         tsQtUXL3fREJRwhI7gzONO8ksn9xV8clZXnTuEasMDz+nF5cpHh87I2A+Qij4gB8K+XA
         sWhzOSAX9EQR/AuOclJKahvEj2mbpHHDC7hQvhf4NJ+6E+y6pRHxGhw1LZccoL7/NdMa
         nUsw==
X-Gm-Message-State: ACrzQf3JA9OBmzHhC0QLiHyyBxeV12tYCsFOt3Vhp2P5o1bKF9CONRLz
        8NC5/Da3Ns6gkLtLdTvbwMuV1HqUQ4c=
X-Google-Smtp-Source: AMsMyM5IMXGBwviwzoF+Vi5FurIu1+nAmLLmv5joekI1vl+HayNwhXYaohnHgaNvvQkaG/ufnH6avg==
X-Received: by 2002:a9d:27a8:0:b0:661:a16f:2952 with SMTP id c37-20020a9d27a8000000b00661a16f2952mr10960976otb.36.1666409599424;
        Fri, 21 Oct 2022 20:33:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.156.83])
        by smtp.gmail.com with ESMTPSA id c11-20020a4ad8cb000000b0047f72b6988fsm9261611oov.45.2022.10.21.20.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 20:33:19 -0700 (PDT)
Message-ID: <6353647f.4a0a0220.60c36.50db@mx.google.com>
Date:   Fri, 21 Oct 2022 20:33:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9027500982041308721=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [v2] Bluetooth: MGMT: Fix error report for ADD_EXT_ADV_PARAMS
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221022004856.31984-1-inga.stotland@intel.com>
References: <20221022004856.31984-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9027500982041308721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=687734

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.77 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      41.37 seconds
BuildKernel32                 PASS      36.78 seconds
Incremental Build with patchesPASS      54.99 seconds
TestRunner: Setup             PASS      618.60 seconds
TestRunner: l2cap-tester      PASS      19.67 seconds
TestRunner: iso-tester        PASS      19.61 seconds
TestRunner: bnep-tester       PASS      7.67 seconds
TestRunner: mgmt-tester       PASS      120.87 seconds
TestRunner: rfcomm-tester     PASS      12.12 seconds
TestRunner: sco-tester        PASS      11.25 seconds
TestRunner: ioctl-tester      PASS      12.91 seconds
TestRunner: mesh-tester       PASS      9.41 seconds
TestRunner: smp-tester        PASS      11.32 seconds
TestRunner: userchan-tester   PASS      8.19 seconds



---
Regards,
Linux Bluetooth


--===============9027500982041308721==--

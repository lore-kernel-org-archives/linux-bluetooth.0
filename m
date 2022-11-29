Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5E9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 09:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiK2Jzx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 04:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK2Jzu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 04:55:50 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D324F53
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 01:55:49 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id mn15so5421621qvb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 01:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7yPAOyZo8VYEwK7T664TplP3JDxBEl/O9CVhc6LbaBs=;
        b=SpUBzyIRHyrZLUxrFi3e6PSuyPXt+vGQWdT3wyUHj8cJC8vVAT4nWl7BsCil1oO8Pm
         jV2BvCeq3JexdTKsvq+SNkqgcgXWyZtkvGhvEuFrNEQWoZY5CWKEdjjI96pC7w1065QB
         cI364AGv2HxUC+5wMJdGRapoQyVjZ2RUeT6uD6rp7u3Pw77+VliQeTGtRSAbrUVIraTS
         DELLDDMNT1gbX3bUj87mbTRrLL2GpRnOEFnqZR+L6J61Z3Uqo6rTA1ctya5w8X2XyyZY
         WZ3XzWr0AKDYqohg0752T0jMVZ4jKtHryF+3Yanac7hjdZWaHshhX8rDFBVAG1RnsE8X
         ZJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yPAOyZo8VYEwK7T664TplP3JDxBEl/O9CVhc6LbaBs=;
        b=arnVNQAMehAmIg5CsdPVpaAx1a4Bu5ktjXEEXYd+XJa44paOSerkrq32e9CN8xKvJJ
         W/NJd4E1hjcyRKYU8g6IP517zSJcHVnGSmKetol4ht3tc14mxaSlrFIobMWiBneOWR0n
         uV+VyM8FrEnH/ctKHts2NMzWOU9+TTtwZIM8axPEmfLIPVxJrfDgXf2Wlwrxvbv35z6x
         8PyzTT8FBfYi+R9tpQgdDPcJTB7RNcXSkfJO00sbigTF6WW/opfh9XHThieE/v1PP6zw
         VnHXLfev2XAWrno8L/LEyCYQR2y7k63QQE0JVSLsM9vrMH4Dzk/CaUcStshmAjYZG1AS
         U0Eg==
X-Gm-Message-State: ANoB5pl53s8bu+RNZtoE+vR2Q5vORAC/bPUlWYTIkZAcBp7D//vJsBIH
        3wWMaofd+uXrFzZJfE8OpCE3nIYctiKawQ==
X-Google-Smtp-Source: AA0mqf7HwzFn4mS0aJ1uMBQp5ALUdcHi3y1evNktT8qbwefaXkjpCe67a5FRjgJ7q1h9HgPFGAoiGA==
X-Received: by 2002:a05:6214:1023:b0:4c6:a1fd:9b25 with SMTP id k3-20020a056214102300b004c6a1fd9b25mr36900087qvr.128.1669715748297;
        Tue, 29 Nov 2022 01:55:48 -0800 (PST)
Received: from [172.17.0.2] ([20.114.138.118])
        by smtp.gmail.com with ESMTPSA id m17-20020a05620a291100b006fa8299b4d5sm10469085qkp.100.2022.11.29.01.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 01:55:48 -0800 (PST)
Message-ID: <6385d724.050a0220.eac75.a0dc@mx.google.com>
Date:   Tue, 29 Nov 2022 01:55:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3576468716913731520=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chenzhongjin@huawei.com
Subject: RE: Bluetooth: Fix not cleanup led when bt_init fails
In-Reply-To: <20221129092556.116222-1-chenzhongjin@huawei.com>
References: <20221129092556.116222-1-chenzhongjin@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3576468716913731520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700007

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.48 seconds
BuildKernel32                 PASS      30.62 seconds
TestRunnerSetup               PASS      427.37 seconds
TestRunner_l2cap-tester       PASS      16.13 seconds
TestRunner_iso-tester         PASS      15.80 seconds
TestRunner_bnep-tester        PASS      5.62 seconds
TestRunner_mgmt-tester        PASS      107.30 seconds
TestRunner_rfcomm-tester      PASS      9.55 seconds
TestRunner_sco-tester         PASS      8.96 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        PASS      7.04 seconds
TestRunner_smp-tester         PASS      8.79 seconds
TestRunner_userchan-tester    PASS      5.87 seconds
IncrementalBuild              PASS      31.57 seconds



---
Regards,
Linux Bluetooth


--===============3576468716913731520==--

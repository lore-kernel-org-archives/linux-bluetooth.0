Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579CFC10F19
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 19:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345820AbjHPTjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 15:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbjHPTin (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 15:38:43 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8C273A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 12:38:41 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bd0425ad4fso5712758a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692214720; x=1692819520;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fma26Q/kGjLHVnxADtt/RBc4vfE/wNYf+n5KMXHlKAw=;
        b=sPgp6G6oLDd0KNLPXckhykLNCsasmQW5Th7CLpSPFsDNYfMMYZIkRPQDDt3iE9QJ/+
         iJC7VIZyfEOHMPUap/Md7c/PuAojKqOPjJxP81hI1id2KFaeaWT0FyRoeRQJ4NGua8Mf
         wBpT159Rqncu/wqleTJUOVkJjIHkw4f3saN35C1x8CFdQI5vnv9CaMRLtbPEUrCwZJgb
         QXNzSCUs8Vrm065WCD1dfohccSkzg6ax0XFUtmD/XIDU1T0GjHT/xncYbWqbBTIR7ueT
         crTHtDET0joCsu6mDf0zHp+lq3DmqaYbyrghIUW2NGZQ3puBBR8hHZaoRadByZFFpG0H
         TdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692214720; x=1692819520;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fma26Q/kGjLHVnxADtt/RBc4vfE/wNYf+n5KMXHlKAw=;
        b=b2PaZ7+7D7Vepl8JXznLStOjGJ7U1ZAl/3ifLDyvdbBe3Vutms6suFr3XdYSLHEYkn
         Lf097KTLrDAW/YmaafE1cI7QbBFotKWNvbvF4ITww8s2vFOljMksktUgo169LejUG++R
         YSnM1NgZ4LG/sTlJb7XAZhMGmbsXTwd0Hhdnj4Li3WXdw9umBrUKh4Ejx7nVETpBqfWO
         j5cUVMT6a2jQCLQkz2sictOvlBOMVNBK5tfUlu1HJuFZc3/TNuSTBVuP7A/4VVMyVCF8
         95T0cJiC5P47rmvEQwoCwmMVFTUQNFaCSUIFU1heT1FxgoXBzlmokeXlZ4je3uLYyzt/
         i/WA==
X-Gm-Message-State: AOJu0Yx6Huktfs4FCEWkvJxVJSXEoN1AyvSwpEXXDeqMkFR1L1unu1mL
        XoKpnIqVCu56tcw2kEUIoOi1MC6BuVI=
X-Google-Smtp-Source: AGHT+IGxedr2FFhExKjebzcQju4J1PUl4MygYsG4TL05U2mwYt0nKUepUd8wxDMQaPFLmixy4jz5HA==
X-Received: by 2002:a05:6830:1bf1:b0:6bd:a98:211e with SMTP id k17-20020a0568301bf100b006bd0a98211emr2613031otb.11.1692214720294;
        Wed, 16 Aug 2023 12:38:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.127])
        by smtp.gmail.com with ESMTPSA id a19-20020a9d6e93000000b006bc30d47673sm6369715otr.17.2023.08.16.12.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:38:40 -0700 (PDT)
Message-ID: <64dd25c0.9d0a0220.8738e.5bc6@mx.google.com>
Date:   Wed, 16 Aug 2023 12:38:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7062053227116790706=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL
In-Reply-To: <20230816190500.2732009-1-luiz.dentz@gmail.com>
References: <20230816190500.2732009-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7062053227116790706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776737

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      39.19 seconds
CheckAllWarning               PASS      42.49 seconds
CheckSparse                   PASS      47.48 seconds
CheckSmatch                   PASS      131.14 seconds
BuildKernel32                 PASS      37.30 seconds
TestRunnerSetup               PASS      569.82 seconds
TestRunner_l2cap-tester       PASS      28.80 seconds
TestRunner_iso-tester         FAIL      84.10 seconds
TestRunner_bnep-tester        PASS      13.31 seconds
TestRunner_mgmt-tester        PASS      251.00 seconds
TestRunner_rfcomm-tester      PASS      19.10 seconds
TestRunner_sco-tester         PASS      22.35 seconds
TestRunner_ioctl-tester       PASS      22.16 seconds
TestRunner_mesh-tester        PASS      16.91 seconds
TestRunner_smp-tester         PASS      18.24 seconds
TestRunner_userchan-tester    PASS      14.51 seconds
IncrementalBuild              PASS      35.71 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 95, Passed: 93 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.458 seconds
ISO Connect2 Suspend - Success                       Failed      14.591 seconds


---
Regards,
Linux Bluetooth


--===============7062053227116790706==--

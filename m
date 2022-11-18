Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 06:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiKRGhM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiKRGhL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 01:37:11 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEFA6A6B1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:37:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y13so4015772pfp.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FvjXzmkCpElnwEkSUXJF7Um5cWxHuv7ZYQlyZIiRTpg=;
        b=BHKGdm5xs69P6koXgluSzTxnGBtfAIw7j9Fe6daXq9x8qpVFreMuHdg3uriZWQ2u8p
         qMPvTCMc2S/wL88Chl2px53Nj49KkJqD5vRQfdy1cnEQchuEYtbQNWoNON5LHnSHqvHx
         ZIBDC4c0LkhCVbdn0WvmAk+F7pipPdi3NY4kM//z6tP2OuEefsIhK89HP5SmUoFN4kch
         ECnfENN68Ee+HA512/h5hhcRObjh4tVBtcmu0MAgninJYeWB40mzBM27zJLuJ9N+yZVS
         wUUBmbg0M5MsldTwCyOUq/gMQUrAT6/Qxo4zaqAdOrcr+DloTFLdCO/lNJt0oUAKU7ft
         RYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvjXzmkCpElnwEkSUXJF7Um5cWxHuv7ZYQlyZIiRTpg=;
        b=QzkPIFQ+yFuslbXf590OU+Z2eL+53cqr8w2HmW3rMtoTtoygMI3bOhLctOCFjgWi6Y
         vLnCESBYNm5MQ/J+Zpt3BVwsGhByi3pfd3MrQX33LXWmAoRXawjl/obq8i5byGSZNzQG
         06WwhWJkqDpy2tkzfFrOo5cjijaL94fI+WvmWX8L0dXFhw1+gf92TycVycVgb4JgsJg5
         4b62qJ8clJnOfBkYk8RDeRZ5PTKIb3bZukHWZ5sDcnzxJ1zUSgY9/minAJb2b1B8RytK
         Xwuc1lirLf6lJj4w2XCHbCEDVVx6Xjpz6OIBbf+jriaxNsZsCdIRbGMV4rCtQZMSAyFV
         Nqxw==
X-Gm-Message-State: ANoB5pmzlRvaZQDyPVkzUPNBLnWLmrYTcYMLQ3xP3J49foMYfyA3khS9
        qhzmwIpJj/N6vLSyAc3zetPtRTyivyM=
X-Google-Smtp-Source: AA0mqf7budvr/1b4fFLNpHxAzkHIoPf5hi1HKZOhkcrEQVmiFQtag6H69g2ZTYdf9P5fA39Zkl3K1w==
X-Received: by 2002:a63:d712:0:b0:470:4522:f317 with SMTP id d18-20020a63d712000000b004704522f317mr5396400pgg.129.1668753430080;
        Thu, 17 Nov 2022 22:37:10 -0800 (PST)
Received: from [172.17.0.2] ([20.253.164.106])
        by smtp.gmail.com with ESMTPSA id z22-20020a63e116000000b0046ec0ef4a7esm2071032pgh.78.2022.11.17.22.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:37:09 -0800 (PST)
Message-ID: <63772815.630a0220.2d65c.36c0@mx.google.com>
Date:   Thu, 17 Nov 2022 22:37:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2020084962873388000=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix enable failure for a CSR BT dongle
In-Reply-To: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2020084962873388000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689388

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      41.17 seconds
BuildKernel32                 PASS      36.66 seconds
TestRunnerSetup               PASS      532.13 seconds
TestRunner_l2cap-tester       PASS      20.37 seconds
TestRunner_iso-tester         PASS      19.55 seconds
TestRunner_bnep-tester        PASS      6.75 seconds
TestRunner_mgmt-tester        PASS      132.05 seconds
TestRunner_rfcomm-tester      PASS      12.00 seconds
TestRunner_sco-tester         PASS      11.15 seconds
TestRunner_ioctl-tester       PASS      12.98 seconds
TestRunner_mesh-tester        PASS      8.62 seconds
TestRunner_smp-tester         PASS      10.42 seconds
TestRunner_userchan-tester    PASS      7.27 seconds
IncrementalBuild              PASS      40.24 seconds



---
Regards,
Linux Bluetooth


--===============2020084962873388000==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B57C77B76
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Apr 2023 06:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjDRGgq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Apr 2023 02:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDRGgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Apr 2023 02:36:45 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED0810E0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 23:36:44 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-38e04d1b2b4so130079b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 23:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681799803; x=1684391803;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oRBriwtWes0mVKz9zR8aRW0SFg3SUMVh17GjY28syVQ=;
        b=E6L7rvb5GtQ0WVR3huUG+TkHxbUfZG2HyE7SoQKT3sDzODni8K3CBFDKMeTB6ZSEB9
         sDQAud17ab3jBIt3xHXNKagL1LsB+/WibGMjvJLvG7VQB8vbzzAMa8M6fpANWcBvblTn
         ExiGu6RPaoNK+ZCuJSim5iXQCrm6ONM7oSwtbh336M/0zsTshdfKrl45FNIe+WFan8E9
         d8ubiYjl+05jPqXuKQfWN/rARXlH4n1eFqtCvklvoBVLx8DRik/ThXPrNzMbSfy+KPTc
         I4N6He5uQTZwm2a/tXLyCiGZmrF6gouCYPMhauKWJLMWnDA048z2D3lqmwDs4Ythardo
         o6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681799803; x=1684391803;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRBriwtWes0mVKz9zR8aRW0SFg3SUMVh17GjY28syVQ=;
        b=dxzMejQOoTKFEswqQGXv+c/8Ktb0QLzcP1NKy3kMTEBPaTV5R9UgYY7+zTnZwzJHq7
         kjwpKYX//GHKfyCDD/3XHBDbkT1yVyg5Zp0aN+HwNRqnnHnpqO88wh+yjvzOZi8Pq885
         89J8ktsONGCdGWZfpMqIcVHcgCy755MQRlIkE7lhGUIiIgCmsUSHkSQvj/J1XYnAqZzV
         bjENpltVJKolgKWfgGRq3GS8/aZsTbvrimsZNzqccziI+y9Ne+Qmv+dv63kJEjrcrTmz
         t6Bc72b98LSeA6lx0O1GdR2sWnNppMndnQoQ29U+x2xbQRp4Lhs3o2ZY+bA+682JAXSq
         Es5g==
X-Gm-Message-State: AAQBX9euAdAmJmyMv1PmtzExYEvcA0CTx/ik3oHXUNWu21bQYmag5EEl
        /u0704Mf8mqA8T+06l1FBfYFOC4FA3YI6g==
X-Google-Smtp-Source: AKy350a/BQz19i0Ah9aQ0Brubk6hkjPxembwGhOMQ9gVe+zx2MUw97fAPIeHy3bD6whc1bVJJRjYWQ==
X-Received: by 2002:a05:6808:1a98:b0:38e:257e:a610 with SMTP id bm24-20020a0568081a9800b0038e257ea610mr420754oib.49.1681799803331;
        Mon, 17 Apr 2023 23:36:43 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.19])
        by smtp.gmail.com with ESMTPSA id n131-20020acabd89000000b0038c06ae307asm5542914oif.52.2023.04.17.23.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 23:36:43 -0700 (PDT)
Message-ID: <643e3a7b.ca0a0220.617cb.b170@mx.google.com>
Date:   Mon, 17 Apr 2023 23:36:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3068013610581724787=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Add the support for RTL8851B
In-Reply-To: <20230418054354.5452-1-max.chou@realtek.com>
References: <20230418054354.5452-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3068013610581724787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=740762

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.69 seconds
CheckAllWarning               PASS      36.83 seconds
CheckSparse                   PASS      41.43 seconds
CheckSmatch                   PASS      112.30 seconds
BuildKernel32                 PASS      32.27 seconds
TestRunnerSetup               PASS      462.85 seconds
TestRunner_l2cap-tester       PASS      17.23 seconds
TestRunner_iso-tester         PASS      21.09 seconds
TestRunner_bnep-tester        PASS      5.59 seconds
TestRunner_mgmt-tester        PASS      117.55 seconds
TestRunner_rfcomm-tester      PASS      9.05 seconds
TestRunner_sco-tester         PASS      8.40 seconds
TestRunner_ioctl-tester       PASS      9.80 seconds
TestRunner_mesh-tester        PASS      7.14 seconds
TestRunner_smp-tester         PASS      8.25 seconds
TestRunner_userchan-tester    PASS      5.93 seconds
IncrementalBuild              PASS      30.53 seconds



---
Regards,
Linux Bluetooth


--===============3068013610581724787==--

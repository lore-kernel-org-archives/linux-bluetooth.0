Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40189C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 22:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiFUWMd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356669AbiFUWLz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 18:11:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5902ED5B
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 15:11:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 184so14332210pga.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vKXzzPvPkNrQQMcViTCSk+Y5kVf1kvQSNQPSdG6sho0=;
        b=Udww9BxibzyMCrrFPFTE0jl7MqndP1j0JZLerW2HgMgXbm2fSXrdSAMGwgvbWnhcHM
         tAZK4/G85KDujiYf5Jha/W9AVpb+pQM+sd7JBjoqjzRWb8vpnTDmuFQpzCWTRsgTNOtx
         XyTEUxOlKBZnlRqStw4dmGJM7+o2FQv57DutKEyFaWTqU5J60PcZedY8nKKSedyCQT+G
         hg+g9g75p2ik7YsF8SH28V2Eh1EMdtBT96HY6a0Hrg0XeiIwsIfTCYVy7xTp5wu4J5n+
         LDKEKWJagnA6eUW9uK2z0puBoonML6ZWkL5m+W4uprxYHgu1ysZwJFHuPzNbnrmHt1vt
         OZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vKXzzPvPkNrQQMcViTCSk+Y5kVf1kvQSNQPSdG6sho0=;
        b=IXw6dxU11aGOgFIT5JR4fq8ifWX/hOeBAH99+zSsEpnLE+ZV5/BL8eM6NgBvAJFK65
         WRP+c/QkwiMnmykOXaeBUr+LV1hcpgvXAg6qLaY/JOcZo2rLlgnMAjCCRirOXiK3PjVJ
         Mc7oA8KEm5jd22B4fZYdqE6079071R/7n0mLOhM3lMM4hjcjSyfkn6/qHV3kLdnNaPhe
         1VLCUT76LeCV1ykx19FXyJvjgWQQQqE1atRYBrjk08NLt2d/QN87FV0OBJkfIY/lxJt/
         jvGAwHFBNly3hBL20q7N64Zb71IqVGe9sBnLdQT5gItIUAiq6uw16Uv0X8MSqYoPN3m+
         pGNg==
X-Gm-Message-State: AJIora+FL2DiSztVoCA+b8jgOsA0ErKf4PHxPzx5hkVj6+aei1AlKZF9
        LC0BTxmYwJRFASqQmu4DUlHEJI1iXO8=
X-Google-Smtp-Source: AGRyM1uA5G2Kgyi97kXFx3aTurQxGS3zTig0hCyZhP/lfzVWXRr41g/4TSCPB0+1k/BL8AmVmzM1Pg==
X-Received: by 2002:a63:7417:0:b0:40c:99b5:a866 with SMTP id p23-20020a637417000000b0040c99b5a866mr122065pgc.73.1655849514080;
        Tue, 21 Jun 2022 15:11:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.207.110])
        by smtp.gmail.com with ESMTPSA id b15-20020a62a10f000000b00518e1251197sm12296969pff.148.2022.06.21.15.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:11:53 -0700 (PDT)
Message-ID: <62b24229.1c69fb81.5cd8a.147c@mx.google.com>
Date:   Tue, 21 Jun 2022 15:11:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0138434111765595112=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/mgmt-tester: Add test case for scan response data is not updating
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220621201054.66411-1-hj.tedd.an@gmail.com>
References: <20220621201054.66411-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0138434111765595112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652500

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      52.57 seconds
Build - Prep                  PASS      0.58 seconds
Build - Configure             PASS      9.76 seconds
Build - Make                  PASS      1759.59 seconds
Make Check                    PASS      12.12 seconds
Make Check w/Valgrind         PASS      541.29 seconds
Make Distcheck                PASS      273.37 seconds
Build w/ext ELL - Configure   PASS      11.70 seconds
Build w/ext ELL - Make        PASS      1763.12 seconds
Incremental Build with patchesPASS      1786.68 seconds



---
Regards,
Linux Bluetooth


--===============0138434111765595112==--

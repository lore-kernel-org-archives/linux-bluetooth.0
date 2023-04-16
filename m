Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52CBC77B61
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Apr 2023 08:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDPIeS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Apr 2023 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDPIeR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Apr 2023 04:34:17 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0672D59
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Apr 2023 01:34:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id me15so2240866qvb.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Apr 2023 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681634054; x=1684226054;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1CSwYu+j3LYZCcDm8X2h313HzAqWj+8673FM8aY31r4=;
        b=C3uy05ywrOhBB2TtKuhz4A+plB0f6/JssNk2iZwcB/+O/JuldA3x3zo9+X33PwCGe3
         +5DUxS8FjHZtQ6kbvY1fVBcr1BAVzVidI9EdXwFLzyg0OueHTN2LFmFSIw+X4mpCUkBw
         Wcv0XAqwnBInHp6QxeDIC/GrZE+yCbcPYb61evB44xxXZpPmLGeem1FygZFKg6S8PJhT
         X+pAG8ZHelx835zQAk+dxBct4QdqT2cR7DFJBHO1ODZT2xsiT8iVPeG4c5yXiZl8tfZY
         iXrhBXGKTur4rX2E9IAaSfk7K0qTZNv+z/WfEQqWKCicy4SX7UU5mByQ8Acr4sjq6LhW
         OKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681634054; x=1684226054;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CSwYu+j3LYZCcDm8X2h313HzAqWj+8673FM8aY31r4=;
        b=asdf/PbvdhgOwfHjbm5OFIXMOE6pavAhSxy98VksPeviu20X7cD0LO2zlyTuuYJD7M
         tXiBNS+yF7FTRh0KJAJgKL016GZqH7mygsiygWyo+m4gjNDFjvAo3fzP/qGgYR6ujYXg
         VKrtYpjKu0ferdSxXiFQ16+BxfVYThEFiGfg+prIhJj8BHIfGVCFl3vvxMAjMVIqG22C
         qf/SrxmrxV3/qj5PrBKQ8GAjVaDHlKbFfvLX4nYXo5bcRQqQEZFc+XKEyg6zELAO2eKV
         GcpZJuRz7lUhi5p1fLV5bB0Bkr45ws4tqHE7y8cel+eL7FTX/0VG1gFOrHhFEjfX8AL7
         +qIw==
X-Gm-Message-State: AAQBX9ejLtgnkd/rGhUVW3xdV4nnohRaLjt/i6yDMdIJSY4hPV6Bhg83
        Jiiiom6k+ibX+rLa2SEs6bscccHLfyWpPw==
X-Google-Smtp-Source: AKy350Ycbpw4qbW2dC55GPxff1ry0qC6r5pc3ymcrYlJ5vdC91X3W7iqDDVF3Gv2F8qFjuDpA/8KWQ==
X-Received: by 2002:a05:6214:1bcd:b0:5ef:423b:1f4c with SMTP id m13-20020a0562141bcd00b005ef423b1f4cmr11527323qvc.50.1681634054179;
        Sun, 16 Apr 2023 01:34:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.138.32])
        by smtp.gmail.com with ESMTPSA id pz25-20020ad45519000000b005e14936cb09sm2297621qvb.11.2023.04.16.01.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 01:34:14 -0700 (PDT)
Message-ID: <643bb306.d40a0220.eb614.b115@mx.google.com>
Date:   Sun, 16 Apr 2023 01:34:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6045630492672063779=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lrh2000@pku.edu.cn
Subject: RE: bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()
In-Reply-To: <20230416080251.7717-1-lrh2000@pku.edu.cn>
References: <20230416080251.7717-1-lrh2000@pku.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6045630492672063779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=740179

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 FAIL      0.37 seconds
BuildKernel                   PASS      30.78 seconds
CheckAllWarning               PASS      34.52 seconds
CheckSparse                   PASS      38.40 seconds
CheckSmatch                   PASS      108.39 seconds
BuildKernel32                 PASS      29.87 seconds
TestRunnerSetup               PASS      429.50 seconds
TestRunner_l2cap-tester       PASS      16.30 seconds
TestRunner_iso-tester         PASS      19.52 seconds
TestRunner_bnep-tester        PASS      5.19 seconds
TestRunner_mgmt-tester        PASS      109.79 seconds
TestRunner_rfcomm-tester      PASS      8.44 seconds
TestRunner_sco-tester         PASS      7.78 seconds
TestRunner_ioctl-tester       PASS      8.91 seconds
TestRunner_mesh-tester        PASS      6.58 seconds
TestRunner_smp-tester         PASS      7.58 seconds
TestRunner_userchan-tester    PASS      5.46 seconds
IncrementalBuild              PASS      28.20 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============6045630492672063779==--

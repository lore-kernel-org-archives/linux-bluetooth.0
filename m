Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1DFEE14D4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 05:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjIGFgR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 01:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjIGFgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 01:36:17 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF919B0
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 22:36:14 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77a62a84855so22026639f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Sep 2023 22:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694064973; x=1694669773; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6rE4NPBYZdDfVN3lcxXZKXYeqsYdfr3Z3a4VgkULuBc=;
        b=CIA5H9Ku5uH43LDUXcxhHkYYIBQvc/5Dt+bMRwT7vwo4vlT7mHCfDIE7XgEpIBilqG
         6IO30sdGOyq9asXUfsxm2f5L7rNrFndHez+iFu9LYnBeHOZIDykuBHow51ZMNLD6o4Ne
         Nde3tVz+dEDsbUtBNK9kbpbYQ0eP2l7oZ1LjHTCbjmFjtFmaXGzFit/+nB3uxCZvLo81
         bwE7Ac/25GffT62VYrpSNBhm/r+z/2FgURoZMtum6mn0T2i4Lk1+arbHHfVuL/gv+mLw
         N6795kvEnrfD6IEbx/j7yvqBBBwiNEQb7WToRF1Mrkev9bsetV3TVGCyCDvHLa503//k
         URFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694064973; x=1694669773;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rE4NPBYZdDfVN3lcxXZKXYeqsYdfr3Z3a4VgkULuBc=;
        b=FWQXCAB43RQ7CtwcWWYkMcJw+4L8CdNGXjQNK3lyyEc2Qcxy6pbM5yighD6oEpQezj
         r3hgjcZ1EnBWSJQAhk+CpmtEaluZsf4uLTg2jv6Le2yt43ok58cGUaIzTb5bYtVb6dCN
         hsAW0cjl/GyeksB+0iiXeYspzVCYB6yDFnG2AX/uKNfvnUMe+kqeaGnlklymLwBRUmsl
         KPW0h80TxR2u7AbXRTbjESwtLLAwIQKJtjJC9iGrPCEmzr8qhKPWdY+2ikcHwX41s3oQ
         D+MEDpCIuo4QRsi59uypfu7LUWLKy1g3eN8OpvuWkOmSUl57XRmt3XvVpKUZr+4wMLBA
         Ja4A==
X-Gm-Message-State: AOJu0YzumgzkDsLON8egUxfEOn/msn5N8tXZgZ+RVMfjQMueSN6PveZ1
        f30tKKcJHq8oOkiA/C2R+L/DRd8eAC4=
X-Google-Smtp-Source: AGHT+IG8col4KVMTjcImM3whA7FnHRg7hiI7fOkKGmS0UrTin5iWuj8A1oXwTX4Oxn8gtAIz4jN2Cg==
X-Received: by 2002:a92:c14d:0:b0:34f:3a72:c82a with SMTP id b13-20020a92c14d000000b0034f3a72c82amr2939494ilh.32.1694064973239;
        Wed, 06 Sep 2023 22:36:13 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.13.184])
        by smtp.gmail.com with ESMTPSA id o1-20020a92dac1000000b003492dfb8a02sm5415191ilq.8.2023.09.06.22.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 22:36:13 -0700 (PDT)
Message-ID: <64f9614d.920a0220.201a5.5eb5@mx.google.com>
Date:   Wed, 06 Sep 2023 22:36:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0138727294611851014=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v2] Bluetooth: Avoid redundant authentication
In-Reply-To: <20230907043933.v2.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
References: <20230907043933.v2.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0138727294611851014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782141

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      32.62 seconds
CheckAllWarning               PASS      35.64 seconds
CheckSparse                   PASS      40.47 seconds
CheckSmatch                   PASS      113.20 seconds
BuildKernel32                 PASS      30.92 seconds
TestRunnerSetup               PASS      475.32 seconds
TestRunner_l2cap-tester       PASS      26.90 seconds
TestRunner_iso-tester         PASS      47.91 seconds
TestRunner_bnep-tester        PASS      10.35 seconds
TestRunner_mgmt-tester        PASS      220.23 seconds
TestRunner_rfcomm-tester      PASS      15.73 seconds
TestRunner_sco-tester         PASS      19.14 seconds
TestRunner_ioctl-tester       PASS      17.48 seconds
TestRunner_mesh-tester        PASS      13.01 seconds
TestRunner_smp-tester         PASS      13.90 seconds
TestRunner_userchan-tester    PASS      10.87 seconds
IncrementalBuild              PASS      29.19 seconds



---
Regards,
Linux Bluetooth


--===============0138727294611851014==--

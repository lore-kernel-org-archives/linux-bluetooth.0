Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 20:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbiAFUsR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 15:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbiAFUsQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 15:48:16 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F22C061245
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 12:48:15 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id kj16so3544799qvb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jan 2022 12:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EvXC0sPqZ6MCsU6YGKX8iKWYTl19nQeXvYCh5D7Hp6w=;
        b=HCzeRuwIfoknzTnkB5TsH2WmyKSt8772me58ji0TMLy4vOrR0ZdufhQxNl/zo0r3BF
         4/muycr6obkXoJZCM2dO7qFiDHIqUm3NdkGwDcrUpPYQhPa2kp7tJqerEnJzRnUhWzKJ
         gsb9fjhujZI4bOuR9oujEjFZvj2qeTFIY5CILHy/k9cwAnOB3UqqqYEtwtTDHgQhzKHv
         qnxxCwdvUvITqrkJVlmtxeG0gTvyxnndStIXZ233SEbuw+7M7rzREhaegcMgMOuLsHJa
         WfR0uizQtBiKa+2qvSGD5cIyNzs9m0BmK/UvcfE97DIVbhK4R+d++kEr9VXyFdnCNhOp
         LU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EvXC0sPqZ6MCsU6YGKX8iKWYTl19nQeXvYCh5D7Hp6w=;
        b=WpWlf3h+radeEMuo2+ZLcRqBdmewzAg+Kgpc7wBja6xpxb15dDx9VK/dRB9RDPAjX4
         dEGOQzx+L3ShDyOFtDMV/rfEp2OIE478PT3Fv5lXfJSkvX9PCitfTAFHcOeXwTimPj7m
         SEQriZnjBHHf7E2bDZvdIgVKUK88JiXmvTrwwmMCVMdNaqUuTqhk7gCuJrNXtHW2p9kD
         PUHRrVuF1xKN65QcV2mjex8FdoHm34HWkj7uWb2tITFJhXUd3URouTmO8oOCFZXaA5JB
         szd/jQU4xtPrD80mEkGNrj0ye4oGrriNW1IxbeMl5DQdwanpnzX+8QdqMNeld9m0lRmN
         58Jg==
X-Gm-Message-State: AOAM532sakgvQUvu8IIV0XK0LjScrSLBZc2S7qtp3Xz32+1dAXmWJpuy
        SDdp0TWoH5ensS7mGyU3YxiB4DVuU3U=
X-Google-Smtp-Source: ABdhPJxIt8vtTKM4rCXjmSU/ZPMsn1XB5840zkR7K/GXHQTQv/O6hXTfOrDXwMvipDwuVQjTXa5owQ==
X-Received: by 2002:a05:6214:62b:: with SMTP id a11mr6333755qvx.36.1641502095040;
        Thu, 06 Jan 2022 12:48:15 -0800 (PST)
Received: from [172.17.0.2] ([20.122.168.203])
        by smtp.gmail.com with ESMTPSA id m1sm2193650qkn.115.2022.01.06.12.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 12:48:14 -0800 (PST)
Message-ID: <61d7558e.1c69fb81.e6628.90db@mx.google.com>
Date:   Thu, 06 Jan 2022 12:48:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8245292671638595763=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] tools/mesh: Fix help config menu help message
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220106192306.28552-1-inga.stotland@intel.com>
References: <20220106192306.28552-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8245292671638595763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=603293

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       PASS      0.94 seconds
Prep - Setup ELL              PASS      45.50 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      8.94 seconds
Build - Make                  PASS      1561.97 seconds
Make Check                    PASS      11.73 seconds
Make Check w/Valgrind         PASS      471.99 seconds
Make Distcheck                PASS      244.69 seconds
Build w/ext ELL - Configure   PASS      8.97 seconds
Build w/ext ELL - Make        PASS      1534.51 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============8245292671638595763==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE50DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jul 2022 03:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiGHDB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jul 2022 23:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiGHDB6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jul 2022 23:01:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C634F2B60A
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jul 2022 20:01:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id n12so22492212pfq.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jul 2022 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ib8n2kPbcnN0F5F8b8vXoZh+yrvbYx+ajCCiW3WjTds=;
        b=gzFjmfRz4TZ5KQV8pLWdFFCnF3eE9B4j4RauMPs1uUBwbplWRqnuiQgwSC/ho9Cghf
         V5HmEI9qPaXxRZp3WdFlueTTKBw5Tw6vcj5Gqro/Qx1MCtUPQB8Rd8YL4Nreh81CSen6
         lE02+7YiXPbizvuyeq3vdSX2hgoI582B/3yIJVrm7w2qLui4g05Ozza4w6yNu4iEx3V2
         4B18iL3Q4ZOruo9VFq6Q69pq3Szls0BaKqBe0xyrMlK5tLd3GHopU180EruablXLqjMe
         oHDLeBJ02wccnX3k6GrfQuLtsktq++bOV+STVjKw6DxMGlE/5AjjwUClfmYlMfQEim7O
         BV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ib8n2kPbcnN0F5F8b8vXoZh+yrvbYx+ajCCiW3WjTds=;
        b=7Dv14/Q4zXklDzg9PbybQEd902lFiM3xKi0tRP0HUnnkZSPacGy26YU3yAvUJav8vL
         mW817TQnjQ0iF0EP5CrQVSycCNcBV73TPnXV6axnlRl0VR+BaKwdS/HGv08g/2Uk3yF0
         UmhZ0k+Fk/NB0gzkk6zQ4pbFtOfNz6gAA/0ulgMbg8D1FgmvRknqY4NpanAUFUnoITIE
         yRn/3/mImlixgKNUEPCWtjs3d6ZuStLAp6JGAl38bvGIo4ckFiAAsv++luT6OJrwKCWB
         4Rw1aXLXVbcvsHk1lItiSy67EGjc1JGHwCcLPZMjFAX2t1p4cddD39W7eoL1LAvJ3DjY
         ia3w==
X-Gm-Message-State: AJIora8+JSpwtuVuL2M7l1LGTfOdml3RxPgXUaUj0oSnaZRsIvkQa2gI
        JPqbf/rg2Z/ZFwz9Q1PSMHCyK8M505cFYQ==
X-Google-Smtp-Source: AGRyM1sTIIcT73Fh5NkwIDtMUA9WpnW+BlHZQtXOp7HR9jgWYGJi19boW8xgktHV8oSbEc5QC79GEQ==
X-Received: by 2002:a62:a113:0:b0:51c:1b4c:38d1 with SMTP id b19-20020a62a113000000b0051c1b4c38d1mr1559974pff.13.1657249316875;
        Thu, 07 Jul 2022 20:01:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.130.185])
        by smtp.gmail.com with ESMTPSA id ik30-20020a170902ab1e00b0016bee668a5asm7660138plb.161.2022.07.07.20.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 20:01:55 -0700 (PDT)
Message-ID: <62c79e23.1c69fb81.c7e29.c266@mx.google.com>
Date:   Thu, 07 Jul 2022 20:01:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0176909223527183979=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btdev: Fix not checking if a CIG has any active CIS
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220708002751.2308369-1-luiz.dentz@gmail.com>
References: <20220708002751.2308369-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0176909223527183979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=657632

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.55 seconds
Prep - Setup ELL              PASS      26.20 seconds
Build - Prep                  PASS      0.57 seconds
Build - Configure             PASS      8.09 seconds
Build - Make                  PASS      724.77 seconds
Make Check                    PASS      11.08 seconds
Make Check w/Valgrind         PASS      281.28 seconds
Make Distcheck                PASS      231.89 seconds
Build w/ext ELL - Configure   PASS      8.09 seconds
Build w/ext ELL - Make        PASS      79.95 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      472.76 seconds



---
Regards,
Linux Bluetooth


--===============0176909223527183979==--

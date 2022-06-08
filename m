Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F05C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 09:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiFHJAh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiFHI7Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jun 2022 04:59:16 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5773F4673
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 01:19:36 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x65so15003897qke.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jun 2022 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bZfUyS1tPT4tPvEf5wQPWIhxVBpBeKTE8q6oOtrN07o=;
        b=UzFm7R6mMfehN6byw/uph1bY1QBNzwlp2WfSkSnjiBJcmm/9yIptNRr2OStcQHF5jp
         P5Ecwec4pEj0abrc/dJzC+S5B2MqLj/OQGImMx6VlxGCV4/9p5Z826CxxUVcnXkmOCEn
         u0oVu5/Y0cNPVI1jcIIVSE9ZM+scEd1h4+2iajC1PxD22gwWDUSOSGHi1MOC2OxtY7nE
         c+695gyy2/qFUdld6hK9gWxsEEwpy7gjsgxLEP7sWuynbWcYDRmgl4PmL9N3e2nOp9QT
         I6wyvF38kIPPI634tvEpkyYJEAi0B4MXERM7TblLTC3H72zG7xRoAVOdSe8F7K+34e50
         gCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bZfUyS1tPT4tPvEf5wQPWIhxVBpBeKTE8q6oOtrN07o=;
        b=Fj8byN4XLeJPwYBapifm1OSvSeiq3cvLLHDpZnOGLcWNUvQtvnY1SdWfdq4oKfgs8l
         yjd76AQVsDJYn7XUXUxBywezapIFzEcgjjOZygexFc9+I3ZuYiSs7aHak+fAk+MoYT6N
         RX0f4yo/62Si8MMsTsJpF2pK76b18vv4Xj/KCLYdU6ylhkegj7DYsSAwRkE+5bWUu3UD
         rfXXDEovy8J1ppNwahgYXf7BcB5Q8mOT6vtL07rq7QZidnJnLOp/l5cD8WN4pYIjtAmc
         2DlA0z/Li4VYacEVUN0p5WEuft2q0+jxkwdjjanb3PSJCjRGKirMLwvvJkpkB05KGxmX
         aoMw==
X-Gm-Message-State: AOAM531/hwERwO6heP4ulQ1WFyQ0Y05kqztDGpEVdBiIsdV48p5wxxAy
        pi0YwH5SOOzpBTLbwLAFG0OPp+hU2NrJmg==
X-Google-Smtp-Source: ABdhPJzVB+b+xFk5gE8NnFPfoS9WBPgZBdQp7VnFMIXbK9/w7VIjtazd5r4Awx7b8GtO3yonQ7XCPA==
X-Received: by 2002:a05:620a:2681:b0:67e:95f2:7ce2 with SMTP id c1-20020a05620a268100b0067e95f27ce2mr21669468qkp.223.1654676372687;
        Wed, 08 Jun 2022 01:19:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.159.206])
        by smtp.gmail.com with ESMTPSA id f23-20020ac84717000000b002fcb0d95f65sm10653891qtp.90.2022.06.08.01.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:19:31 -0700 (PDT)
Message-ID: <62a05b93.1c69fb81.75efe.44ec@mx.google.com>
Date:   Wed, 08 Jun 2022 01:19:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1198302393832995326=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] device: Fix not deleting the folder after removing the device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220608051418.197426-1-hj.tedd.an@gmail.com>
References: <20220608051418.197426-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1198302393832995326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=648310

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
GitLint                       PASS      1.05 seconds
Prep - Setup ELL              PASS      41.93 seconds
Build - Prep                  PASS      0.73 seconds
Build - Configure             PASS      8.38 seconds
Build - Make                  PASS      1238.96 seconds
Make Check                    PASS      11.58 seconds
Make Check w/Valgrind         PASS      426.43 seconds
Make Distcheck                PASS      224.82 seconds
Build w/ext ELL - Configure   PASS      8.46 seconds
Build w/ext ELL - Make        PASS      1243.24 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1198302393832995326==--

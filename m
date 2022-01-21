Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4960C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 18:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiAUSFC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 13:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351808AbiAUSFB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 13:05:01 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26AC06173B
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 10:05:00 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t32so8758424pgm.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 10:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OFI1YuDqDIuXnDFAPvj7wPPZz7HPZJXEq/sOdUTi6q8=;
        b=UdyJFbx07AGhFhV8lP8XexX9LiQVjqzAPzoThpRcJFXZww39kPUhB1QEolBmTSse1/
         HoYuE0joYNifJyGhbklzsInP6g5TOP2pbny0HCDQNGEuUnu6M6AkudhSnXW48SJTr9Rj
         o2127sRCzynCnARedga7Wj/YteW41N+hQoc3suXsQylArHHOAtGrmbWkMqb8TaWSOwyF
         ENvi4CXIsEwn1cmrrFa0L6SQBPz6bbXoRMuP738ue1/VjFmpcW2zw+Ko0Fbg6AjNMrK7
         aPIrGFYcywZYgONLhx9Ojt9EDq3dw7WGqJjx51+F27TO84U2YwGV1ujKiiH2PJ8kaLOg
         B2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OFI1YuDqDIuXnDFAPvj7wPPZz7HPZJXEq/sOdUTi6q8=;
        b=dNHS0eyBtj73wLEjTGAz34Pvbc20FL9z7lVZBfyhaRmtfkGqW3c6x0H9oXJLerx81k
         p+6Yfr/UvZtmKz+REc4U8lI75UV+xluZfMGRHGhU6YiIpf0dbZA9urkY64t6YnDTcBSw
         68jQ/UjlUJ7rwLGd7++LfyyNS08XV9bSi2n+q4Iwf10GIeddW4H5PIXMy1yEARxJOsMM
         WIvqYB/NDEMEZvaliOdSS86K1+CfE+GFCavCe3kaxoeeUT7/0jYje49vDmSn/QZjtkOt
         daO5OJTUDMZeBotkkvzH2mxvsEjCKHv8hdp7uzYTiZwrZoA/r6EX4Qs+weNuM9TaCNsV
         uwwQ==
X-Gm-Message-State: AOAM532UZOeC6qSvdILs/gDnhIHcOoZMYFB4blxyzAqosYB5CSW244vF
        p/npIQX45aLGeFE5Ia2YmLP4cBJMPWYmkQ==
X-Google-Smtp-Source: ABdhPJxhIZt9JuSqMs6XCfvZfxCMYgbypkJlGFeqPBRIDULnD9/sxrDHBA1FKxuMB+eB6w5mQJ6DFg==
X-Received: by 2002:a05:6a00:23cc:b0:4c6:d3b8:29ea with SMTP id g12-20020a056a0023cc00b004c6d3b829eamr4585884pfc.78.1642788299814;
        Fri, 21 Jan 2022 10:04:59 -0800 (PST)
Received: from [172.17.0.2] ([20.114.33.237])
        by smtp.gmail.com with ESMTPSA id e12sm3300006pfv.43.2022.01.21.10.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 10:04:59 -0800 (PST)
Message-ID: <61eaf5cb.1c69fb81.91822.932b@mx.google.com>
Date:   Fri, 21 Jan 2022 10:04:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5322238139614200127=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: [RFC] Bluetooth: hci_event: Ignore multiple conn complete events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220121173622.192744-1-soenke.huster@eknoes.de>
References: <20220121173622.192744-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5322238139614200127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607341

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      35.48 seconds
BuildKernel32                 PASS      32.61 seconds
Incremental Build with patchesPASS      43.24 seconds
TestRunner: Setup             PASS      547.21 seconds
TestRunner: l2cap-tester      PASS      14.72 seconds
TestRunner: bnep-tester       PASS      6.56 seconds
TestRunner: mgmt-tester       PASS      118.55 seconds
TestRunner: rfcomm-tester     PASS      8.44 seconds
TestRunner: sco-tester        PASS      8.91 seconds
TestRunner: smp-tester        PASS      8.40 seconds
TestRunner: userchan-tester   PASS      7.11 seconds



---
Regards,
Linux Bluetooth


--===============5322238139614200127==--

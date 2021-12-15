Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3251FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Dec 2021 18:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbhLOSmy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Dec 2021 13:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbhLOSmx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Dec 2021 13:42:53 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD0CC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 10:42:53 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id gu12so21116260qvb.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 10:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=h+1QWdwf008vshHXU12Zj4k5ETBYbBKRdUxZlQJ1Uh8=;
        b=KdWEBO03tPf92SQgVfVMH7/vHZum039i+IYHsLSi6YPtKiIaz8ii037tlXfSOQLrwg
         xyRj/KPomWrIhu/JoN93wPl+mpCUyl8ud27R0pt+rnnyxGuiH8sAyxEkKId7LTDV8OwM
         6DbBvp5n66hFfF1RpMrXg6O9rSqhpfsQto4AW2bNaz+a1oBIxVOOLEYh9a2WmXaB5Q9q
         oDTeO3HX0V8IlPkS5TBpb5T/MU1mjyb+JBNEFGx7ZWtKWt3tf80LyTpG+Ta8Zz80Cv4X
         3z18rhiUMz33kb+kyszlajxVfQAv6tb5PxysXAPs+5+/DweGrczZv7SmwbwZyO7DoRCR
         Pa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=h+1QWdwf008vshHXU12Zj4k5ETBYbBKRdUxZlQJ1Uh8=;
        b=cKCVb934WQpxSvSCvjacHN5Imb1Trmcrd22WHfY4d5aTu+9gLJ7u9eMzT+mMaU28EN
         n53ojkOh6RF0/bduC0uXOV6CL/f84EUC9JLFm8XHatVHnASOHTlrYs0pnPgF2R3u5QPD
         q7piUL692ag++WocOoiK2Inm24tQEv9kveLsFJ12kDZfnXQ1FrqjAxBG2qYvBII6xVMt
         Ms5WeMeISkqDyyAtT7g8y3D1kLyRfGdrptdRJzp6H1h0Cmr6Cmjdt+EhqjtebzSfxYpL
         qTwlvlk7ioMC8DwxSjJ5TOB+FU15YJIbtXGlBJNFU4cH1NOfVA1LnMP0z34qlmRxF/dc
         uvMw==
X-Gm-Message-State: AOAM530/5w0Zi6YejiXqEszaqXtwLdLFgzrtz2hJiG9SLpTltOYQViUt
        QTzf9d0rpWTp6PIPBcSch06wGriL4Eo=
X-Google-Smtp-Source: ABdhPJzRenjI2Szw8xNe5JIybk3qrJ2v2wL4jsCeEhzTcvQkx7GPVKNpIXgD9EjozZJ5U5q72Ctbnw==
X-Received: by 2002:a05:6214:19e5:: with SMTP id q5mr12451745qvc.74.1639593772001;
        Wed, 15 Dec 2021 10:42:52 -0800 (PST)
Received: from [172.17.0.2] ([20.122.40.29])
        by smtp.gmail.com with ESMTPSA id v12sm1470724qkl.50.2021.12.15.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:42:51 -0800 (PST)
Message-ID: <61ba372b.1c69fb81.82f24.9d4f@mx.google.com>
Date:   Wed, 15 Dec 2021 10:42:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0904005546915699528=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudio.takahasi@gmail.com
Subject: RE: [BlueZ] advertising: Fix reporting advertising properties
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211215180527.886481-1-claudio.takahasi@gmail.com>
References: <20211215180527.886481-1-claudio.takahasi@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0904005546915699528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=596151

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      49.04 seconds
Build - Prep                  PASS      0.61 seconds
Build - Configure             PASS      9.40 seconds
Build - Make                  PASS      209.53 seconds
Make Check                    PASS      9.37 seconds
Make Distcheck                PASS      248.72 seconds
Build w/ext ELL - Configure   PASS      9.46 seconds
Build w/ext ELL - Make        PASS      198.40 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============0904005546915699528==--

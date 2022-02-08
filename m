Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA31C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 23:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiBHXnZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbiBHXnY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 18:43:24 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960BC0613CA
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 15:43:23 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id o5so528619qvm.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Feb 2022 15:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=e17zwMAfJSQ6GpvRJi/BLNVw6jRZp1Lf/HNCHLM6XvU=;
        b=OkiwJqEyD5Xiq7KM/i71EjwwG9+GyzI6UBIba1+bZGreMcOCNagy3mUAB32YvKH3/j
         mF4pGqR/qZSDJ+w3dbOBH2LAKnXahQrzOwNQRqGU2C9Z7LSe6+Siu8RBDLx+QnLBBd+k
         Qbk1Wrtye2kn2s1gCfSZNAXyv9y57vADHc/JTvmBOsIQkmaP7wjuwwc/CLx3TlPyrwxg
         UWIbvpmwqqB82RW+jDFuuU/EQmJAANLcIAoMJ1SuaMA3hsPY/r16VmB+Kid5rfl7eC/o
         m85AMNrNiaRouX02Olw7l/+n5KbglbJVJnDYj8CtbEI8Wpc10bBhpAKOYnGd/7/PBZVa
         Tn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=e17zwMAfJSQ6GpvRJi/BLNVw6jRZp1Lf/HNCHLM6XvU=;
        b=Z78A4jxNr/A5vBW5r30H2XZDkGb7Ow8u54/sGLhgWpD45BYPKZzshhpmKiM1jtrmPk
         oOWk6bfo/Dqyza662umzN4WCfYHS7d+r3cdzU8xJil08ZTZF0GGf6i2iU0oDWQdkvpSJ
         2Z4E6M4m4kih+1ZK5qMiEyIdq3qcw17m8cjwok6NTiv6NyUSnaGwPXvk88cBQDb3Bqli
         8RFy8ryOBtENN8rjkNs3mnjiHhO51YEwfrDwvjhjxL9dP0V0p80mY/jZZ+oKDPaBZ7Hn
         BZnn3Zm2KKxXMMLSSVTLGUPQHKlyRx8m+h77g1gPPpa+eE1CkXNw6Q63pyrphEUc4VyH
         zSeg==
X-Gm-Message-State: AOAM533pf1hb/YEgNNh+/JJ6kou7ze4UZNfe6JWph1e02nFNDxN0Fpio
        zERsKvwzw97ZbwE4Z+CHfLr00V724hqQUg==
X-Google-Smtp-Source: ABdhPJyO9NIfTmW91R1bCRJM0/XMQfwObmvRDkDUwI3YwY0j8hbVHIY+spOa1zS3ys07HntxIXOVZQ==
X-Received: by 2002:ad4:596b:: with SMTP id eq11mr5050450qvb.70.1644363802550;
        Tue, 08 Feb 2022 15:43:22 -0800 (PST)
Received: from [172.17.0.2] ([20.114.191.243])
        by smtp.gmail.com with ESMTPSA id a22sm8287145qtx.38.2022.02.08.15.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:43:22 -0800 (PST)
Message-ID: <6203001a.1c69fb81.8c8ae.c2cb@mx.google.com>
Date:   Tue, 08 Feb 2022 15:43:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7544626042540439044=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] adv_monitor: Fix spamming errors
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220208210541.3883437-1-luiz.dentz@gmail.com>
References: <20220208210541.3883437-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7544626042540439044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612350

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      49.50 seconds
Build - Prep                  PASS      0.73 seconds
Build - Configure             PASS      9.70 seconds
Build - Make                  PASS      1398.39 seconds
Make Check                    PASS      12.21 seconds
Make Check w/Valgrind         PASS      513.32 seconds
Make Distcheck                PASS      258.23 seconds
Build w/ext ELL - Configure   PASS      9.62 seconds
Build w/ext ELL - Make        PASS      1372.14 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============7544626042540439044==--

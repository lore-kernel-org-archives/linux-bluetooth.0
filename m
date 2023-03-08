Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476CFC678D5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 02:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCHCTM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 21:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCHCTI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 21:19:08 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7875A592E
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 18:19:06 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id ky4so16348462plb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 18:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678241946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rXIFFHx9XvIwm3UV1q/zohN3vUA1jd0v99HTvuJjsvM=;
        b=V7Tv/uiluYCasG/z7sGfZTq4i0bwnq5/TWp+4VaUdR1hSNw0qjoiprfdmMGxzGUKj0
         aa79O6Ojhc8sZJSim2cQzeVR3r4b/OhsOoOzXa5ksF8AfInSwGR8cbNTERFajiLkHJOZ
         deNc8FPUh/rtAbJ+WA1x0Y1G/q8WxYFo4tV4S6uXnXqcnbtEr8viP+9klGBnF3c4eoqd
         tlCAdkpypnH5K9CgrCJSaPRjPCSxnNBE5mePWYnoba2EOf4UgYWVW9UIyl2X9Vm5raui
         1p0T8FgxpFH7rtvZjBrh7wPKhuOAijTvT2ZNNpP7j+eb4kDdesbP6BS/J5KQcU5x+J6a
         waJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678241946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXIFFHx9XvIwm3UV1q/zohN3vUA1jd0v99HTvuJjsvM=;
        b=JzLmjYVVewNg3S4NsPTxS3XvagCly5Nf6Cw+XMnHeo+Ya7IzdU4rS5XzhRQr/l3hfz
         +w3pm9W2/uBQX7w8BgkjmslsNqmset4A2sg12iZKpAxTBut/SH8HQYBeXD0fxbr3myFX
         frVRXEShLvIfiucSWt+nOhLGQAFDAWVK45I78Z+MB+Fn2lQNwuRURX0dqyakinynV/sE
         dWvE6oCWhVfo1x09QQIvTXoOcdQ5SgACpmHRT8Ihejicpp/0mh5Tb23VGtZcN6tYMnyM
         hW8qu4yHAyjO6ViRb9e4rDsAjjNFQLran8b6T6JEcM3XnA4vWD7gpx1MSUGHePGIpPqN
         IzPg==
X-Gm-Message-State: AO0yUKU1z9z5okfWKBFl5M5LWXi01v1/ypILaIjE7M9+UZtAgt5QCDHO
        XOaUnLNyHy4OGIl81e23t1rp+e96fYg=
X-Google-Smtp-Source: AK7set8o1SGavLGZ2n2wvi5Ix4p6UjBkT9qAgikL86IEcYpKVfEnb3Bo3ss2KeEgE1jV14qpf3WjEA==
X-Received: by 2002:a17:90b:1d12:b0:234:e3f:f53b with SMTP id on18-20020a17090b1d1200b002340e3ff53bmr17432724pjb.21.1678241945935;
        Tue, 07 Mar 2023 18:19:05 -0800 (PST)
Received: from [172.17.0.2] ([20.171.102.112])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090aca9400b0023317104415sm9838169pjt.17.2023.03.07.18.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 18:19:05 -0800 (PST)
Message-ID: <6407f099.170a0220.47f45.2cc0@mx.google.com>
Date:   Tue, 07 Mar 2023 18:19:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3295788535551704058=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] device: Fix not always storing device info
In-Reply-To: <20230308005158.2661414-1-luiz.dentz@gmail.com>
References: <20230308005158.2661414-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3295788535551704058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727684

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.49 seconds
BuildEll                      PASS      26.25 seconds
BluezMake                     PASS      763.65 seconds
MakeCheck                     PASS      11.06 seconds
MakeDistcheck                 PASS      154.66 seconds
CheckValgrind                 PASS      241.74 seconds
CheckSmatch                   PASS      323.62 seconds
bluezmakeextell               PASS      97.21 seconds
IncrementalBuild              PASS      1235.69 seconds
ScanBuild                     WARNING   983.36 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/gatt-database.c:1152:10: warning: Value stored to 'bits' during its initialization is never read
        uint8_t bits[] = { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
                ^~~~     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============3295788535551704058==--

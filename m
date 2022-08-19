Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B3C28B2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 18:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350904AbiHSSzM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350555AbiHSSzM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 14:55:12 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A8FEE87
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 11:55:11 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bb16so5693432oib.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=kY1uAWz9qwAHmJDEPXQN97MrA15mgVIarJSWX2EU24o=;
        b=DqsCk+SNGoVgcPU5xhLo8t/2wVPHYTsv1YWcTD5jwNiKX+iwUpHXuB9vn7INEWHVx9
         fDdJEii4F2gsjAfsux9kANMXoMcnVLYdlLnVUqxCtYVaoDBSN+855SfUxClH4H1JpBLf
         1/0V856TefdLIaMj/ekColSZQaf/Vf2zWmgU8AiGRqNeQCzGd6K2gIeigWHAVgQZfqV+
         2OhY17bG/5y0CyrrQCTW5908kEm1YA+LV+srxBvOFpBTjjPyUQWsoFCOK4mpQ/NJ1a5b
         itqmu4O5CkToo+1UMq4ND1GEyRFHqioJi/1+4XPjDpvGnyN3oPiVVfekje/FAwh7fBdZ
         6bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=kY1uAWz9qwAHmJDEPXQN97MrA15mgVIarJSWX2EU24o=;
        b=Z7IkoGEHla6U+t+Z2aC+zC+w4wXE299NYAx35gSJw+ZNnNGWkuXwxmvDlRH9qlBOIf
         AMxO3KiYaoVxBos7CTDLvTmy86WvnX+PzB8LIGA08IFuk+Nxvcmou5ogMxyg3+DBMuz5
         3p8/8QJiZbNOtQxzTeCs4gYUSzpJQLzITZvxVGz1AxWBBPnPeTykaGKIZ3FOZTyxk8Oj
         b4d+IoF5Yv9PvKJL0sEDxpkb4tJu+IXj+n48Nv0Z3rGh8sxIlcq+lbapsBwc4/MiWx4w
         rh2SSBz+jQ4fQOyB8QkO16dORfW+eicb335KyRvcD3Ip6KznEkYX1lH+8oyfC2lbzchx
         9Udg==
X-Gm-Message-State: ACgBeo08dMKPP5ELYpmrXMI+jpI9OatiXfi8xe/fSRMFTNLgZ2rJr1mv
        yYzXRALRc9jwI/qU3rZ9KLeSTAl0NouOgA==
X-Google-Smtp-Source: AA6agR65wK8EFEfMRjhXI8UxEFDsOmrqeDw814gU9aMXF7WZoRRqFPc9Zp9+SQxviXBc70NGT10vDA==
X-Received: by 2002:a05:6808:118a:b0:343:43c:58d with SMTP id j10-20020a056808118a00b00343043c058dmr6046517oil.137.1660935310717;
        Fri, 19 Aug 2022 11:55:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.220.168])
        by smtp.gmail.com with ESMTPSA id w20-20020a056808091400b003432bb4322esm1207089oih.40.2022.08.19.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:55:10 -0700 (PDT)
Message-ID: <62ffdc8e.050a0220.26ecf.4687@mx.google.com>
Date:   Fri, 19 Aug 2022 11:55:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3698426279298561017=="
MIME-Version: 1.0
Subject: RE: [BlueZ] iso-tester: Fix using shutdown(SHUT_RDWR)
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
In-Reply-To: <20220819184605.19225-1-luiz.dentz@gmail.com>
References: <20220819184605.19225-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3698426279298561017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: tools/iso-tester.c:1185
error: tools/iso-tester.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3698426279298561017==--

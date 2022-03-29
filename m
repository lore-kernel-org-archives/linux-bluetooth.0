Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFFCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 14:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiC2OqS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiC2OqL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 10:46:11 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280047057
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 07:44:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j21so15440656qta.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QJqDEk/4DKuDESszL6JBWXEtl/jAiDAn/vU1RwLwEWg=;
        b=UFbK/ocFJTF3i1CGTEUNRX5RluV686b7zqPwr7BI6+72O4jP5uUdsUrohViAOhlWt0
         qPTvojnFrYnD0o2eMzBc4Qhb2UHeM/AMWyyKPOzPFSBF6DqLzJBXP+m5gQfos3NSXLr9
         scUEA1pbVHbWr9mH49KWULSy43JHCQ1+M+80wb+oiX/fDN+CiPxXLLFQ+q/GOfbBOFEA
         y9MrNFmIziJ99yp+qjk7WzXvy38WokZ2biRpr86XDDwnSiArDVfW+Qay3iQ8EflIBOTQ
         q60SJkOyfk+/JAJynr0e/QQs2GoFFLxMeSl35zFS8ElrJp7Z88jFEnHwXsomTzATJwZB
         4Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QJqDEk/4DKuDESszL6JBWXEtl/jAiDAn/vU1RwLwEWg=;
        b=I09fD2anwUSu56SApk3hKZC7fNHTe6u133/mzmd7ffgGqRFvb8resVvVF4nWq1fj4y
         EtuOYKAENvmLIBK3lP0/FJ3KguGC12B5CwSneUayj1A2WoeszYN3S2BzFrRkkpvhAA4o
         MPoQFaa3qAqODs35Nsqx4gre3zG27JQBckhBSqeqCl+dfUZQhNw1f8HDF9PBzSisyWeI
         uFn8lSDYubR4c13Qx36l/kfY+zrp93IatugMmqWD0GopV9yU0xmroG6OOVh7O4nw9LvF
         Sq8XndT/dEcmd/XVe8z3zxZ/+lB54WWVvdj4ndKAqd0fvf5Uo4+KtbzTPqBXSHQI+OUN
         X/bw==
X-Gm-Message-State: AOAM533xkF0SiKhqJRcwEe+IYx7Qoaj7rQntlhbsXF3JKUWV4fzoFP2a
        bPkcPXYOLEhR+4uwZQDPwC/amJ+rQpYAig==
X-Google-Smtp-Source: ABdhPJwLkPMUHRrtu3f/Wd+rnTiLRw0mNV37x0jT8suCI4LrGTHgS+ZPFk31i1HoB7PGQLWBX//eBw==
X-Received: by 2002:a05:622a:138a:b0:2e1:ea16:4fd9 with SMTP id o10-20020a05622a138a00b002e1ea164fd9mr28284200qtk.527.1648565067575;
        Tue, 29 Mar 2022 07:44:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.143.228])
        by smtp.gmail.com with ESMTPSA id u62-20020a379241000000b0067ed2b0994dsm9591531qkd.54.2022.03.29.07.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:44:27 -0700 (PDT)
Message-ID: <62431b4b.1c69fb81.45d6.05e8@mx.google.com>
Date:   Tue, 29 Mar 2022 07:44:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1847461333273617822=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v3] a2dp: Fix crash when SEP codec has not been initialized
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220329132311.163117-1-frederic.danis@collabora.com>
References: <20220329132311.163117-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1847461333273617822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627219

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
GitLint                       PASS      1.00 seconds
Prep - Setup ELL              PASS      52.78 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      10.69 seconds
Build - Make                  PASS      1501.55 seconds
Make Check                    PASS      13.29 seconds
Make Check w/Valgrind         PASS      540.54 seconds
Make Distcheck                PASS      283.94 seconds
Build w/ext ELL - Configure   PASS      10.71 seconds
Build w/ext ELL - Make        PASS      1468.92 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1847461333273617822==--

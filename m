Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9535EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 09:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiJDJhP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 05:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiJDJgl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 05:36:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E24D4C8
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 02:33:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 10so8571493pli.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Oct 2022 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=2nSw2yWhkAQq1JORoEk0Exf9jtUQ5Zy66gop2lOPQag=;
        b=O04fEhRrxoG460l52v4qxfit7SgSYuSlwXxnnhBlDP1jPetFyYc0zT9zyFfFlaAYnM
         j14e1ITk5+0cNjtBWBpB4xyiMKV+2T2zypUshCnIl9WNJF9rKnAvNkWjeTVHExGSKC6X
         fEI6Z/tlkco+0liHYOvF21wI4FrbQ7J9ADxfU8rH2VeiMAz+zp6cKqyRxhyKmsnKvJmR
         Q1nVVM6pIEt1sEMittihtTJRwBgSgKZR9OuZIPu1hpfFRkq9i9oci8po2vRwQxxSWvel
         M8D8SV5BNapikU9AXvC4ESnR9sSe3er6Zn2mKlQ0EfRQ+GYYO0NsUFha37bHipBPib66
         106g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=2nSw2yWhkAQq1JORoEk0Exf9jtUQ5Zy66gop2lOPQag=;
        b=W2BvyEP7G9asTmHNc4y85XMLa0nDDL1sGQzvwFiQTr7KYey+1y0xxt8OyuskjH0XOH
         Vp4NiZoLNvdyfoDV85lsUNgmIG0URfXL9zRLUlTbB7akc28k3MQJz+MRGbGWWijzPtE3
         jee7SxUIwX9omoq9q/trsnc3UnJlMLnWzuQ1eYehvxKjfcy3JUffw85PomiNZ7nP7+Qz
         /3NqZwM8EO5kUpbBR+s/ys9wcXBb3pIGHlKn2ZCRUfzG9bZUBAd96F1QvUrYMFqJBBLm
         UlUwwcoB39vst+f/I44n4Vy47K0LbTcCiFjDoR47V5YXby4JSZ5UP5W2on8h1Y9X5kMX
         0dmQ==
X-Gm-Message-State: ACrzQf21hLynN/bLeX+xQ7Sc68jB+Hp4INMlwRWypw8YZ0TYbDSbMqhv
        1gIcmocL5bT0C2xlmrtcQzuIF1D6L1I=
X-Google-Smtp-Source: AMsMyM5gUfx7iXbXWJ7pMmB/kaFAJ+PaqBAM2BmWzIvQhmqjVzkHJP2yn9Aww2mA5tMYPCmtSF7hwQ==
X-Received: by 2002:a17:90b:4f8d:b0:202:dd39:c03a with SMTP id qe13-20020a17090b4f8d00b00202dd39c03amr16795932pjb.71.1664875971993;
        Tue, 04 Oct 2022 02:32:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.70.255])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902680500b0016d1b70872asm3989139plk.134.2022.10.04.02.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 02:32:51 -0700 (PDT)
Message-ID: <633bfdc3.170a0220.c0279.6a25@mx.google.com>
Date:   Tue, 04 Oct 2022 02:32:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4052618703708551128=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@loytec.com
Subject: RE: Mesh: Fixes for friendship procedures
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221004082530.25719-2-isak.westin@loytec.com>
References: <20221004082530.25719-2-isak.westin@loytec.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4052618703708551128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682931

---Test result---

Test Summary:
CheckPatch                    PASS      2.69 seconds
GitLint                       PASS      1.83 seconds
Prep - Setup ELL              PASS      32.77 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      10.20 seconds
Build - Make                  PASS      1074.82 seconds
Make Check                    PASS      12.10 seconds
Make Check w/Valgrind         PASS      347.39 seconds
Make Distcheck                PASS      287.27 seconds
Build w/ext ELL - Configure   PASS      10.21 seconds
Build w/ext ELL - Make        PASS      104.52 seconds
Incremental Build w/ patches  PASS      492.04 seconds
Scan Build                    PASS      642.46 seconds



---
Regards,
Linux Bluetooth


--===============4052618703708551128==--

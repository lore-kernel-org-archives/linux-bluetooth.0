Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EFEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007546509B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCEXAy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhCEXAk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 18:00:40 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50860C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 15:00:40 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id n4so1834104qvl.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 15:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9SPdrtMRILAVL/ZyTXhBqCRzqic9XLKP4bR1wpIxC0g=;
        b=U2GqReLpuK5D+FUvClwX9sQ7qounJzMRkPCrik28Z5OQf6W00HwZUy8qTTSNixrGrh
         zgFLnKIB6S5SDocLclVXi2uwVN/HXDBI3C2IGr/0MueclHoLInjM9MU8VOnPfYOVik5i
         n41lGDNVa0PSKbr8Lj7lgLLRjRyApfvm7Z+aNM/DBJbB5EQLeAcDq7fSn5a276HJyF0G
         4YI5tUbxFsX638q60WarGpawwiQRavGPPocxkoefwZ7YrLXzMzW8pwVB4m2+gVXyS8xZ
         HBQOv5Oz5ETlQmCA/xV4aftbAfDYS8n0XbMMvRNi0B6jRHzjMeJewdlSFOVuN9COdk5m
         Ii9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9SPdrtMRILAVL/ZyTXhBqCRzqic9XLKP4bR1wpIxC0g=;
        b=Hxz0FjvFRZDoX2yPzRGSHj12+3erU8ZJQay0+HKgsPu1/fX7bxZdLiTCjKRJY1epqH
         GWKI4AxIOQRccbIXQ95u4X7cJwS0+JEw5YBtHiQ2mrxv0FSOn3EWP6XdDdTO9nsqztM/
         7rV1wj2fb0e6LVjl+/+Xz8QbN0xkWQs6l3jtisQVnv/tckaTyL7Xkky0ZCB5kzh9t3IM
         qDmhJb2Tw2tIz3q4sknc+pJ4fa6CWQmTx0M4+DWgTebRJilCsLg4JNx5HIdZe0TjDoVD
         XE9BkhBG543PMdftBOR6ub5wBbKQgDPyQMDz5gxLYqrTdVDqtKcMKqdcd8jdihgsd/7q
         cUhw==
X-Gm-Message-State: AOAM530B6NLb0vrByxOp9yZp5cFKPzHpAZE8bEtOeM7ZbMm6Z4Q9M7oV
        SA0VT5l4IIwsPsnOaLHXCQa0cc9yxWEQiQ==
X-Google-Smtp-Source: ABdhPJyqrEgvEkoDArY0sgkAPBvQkt+1f9mAxwQdnuhIHEKrjmG/y5bWvhYysRGc9TdxMgRsopfq+g==
X-Received: by 2002:a05:6214:10e7:: with SMTP id q7mr11127716qvt.16.1614985239451;
        Fri, 05 Mar 2021 15:00:39 -0800 (PST)
Received: from [172.17.0.2] ([13.77.96.135])
        by smtp.gmail.com with ESMTPSA id o89sm3081852qte.84.2021.03.05.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:00:39 -0800 (PST)
Message-ID: <6042b817.1c69fb81.5ae9e.5767@mx.google.com>
Date:   Fri, 05 Mar 2021 15:00:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5085760232226278373=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gatt: Fix registering DIS without a valid source
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210305222544.4005053-1-luiz.dentz@gmail.com>
References: <20210305222544.4005053-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5085760232226278373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=443009

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5085760232226278373==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29408C43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 23:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353460AbiDAXpT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353445AbiDAXpQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 19:45:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5CD2ACF
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 16:43:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso3861373pjh.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 16:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cT3pKg/O6TItRJrrPlcb7RV6sMnQp/iKCLaAoZMBezs=;
        b=gwC1eMA4kyYecpKFaZlT9KtDqVabOB0Ljl2/lhidCWCmeYlzzIu5qHTCchKVoNA0DT
         A87ht99Qeozqv6Cg07oRF5i44sOcDAJuljGCiR//8d1nU/h1sL7kBbjOxIHl+dQyMG7A
         enxOKsCT813B6HGjW9VBjIOVDala7jFUGG+dvNTvnj5tVH/QPvO9RnAvD/g+dvtQfosc
         elkp5ceY509jjayYBTNrAdS3LFUfDTxyuC2Ap+BLGylTlD2tkEIHuPVb44G80uxgxIjo
         wiHEBc3nKcQMbYtDe+yYHNbqMoGfxPzPj5yvams/uwYwLH/rphLuQtZIKhxky/uAOiRA
         qU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cT3pKg/O6TItRJrrPlcb7RV6sMnQp/iKCLaAoZMBezs=;
        b=h9Mh2F3ijbDPpeNKUVkOaWpJb+a5jsn32OUJHlWFuN2IYsla/DgLEc2csj2WXDWzQo
         S7Cy8Qk6yl7me1hq4Sw8swsnZZtR5+QV+nuneyg7UeN+X0cw+6FN3CtUvKCT+oFo+1bq
         UJLQjgqZ1gw+rkUwb4YlPywizwGSh6MsPs5d9fDnxwkGdxRjO4u7+/5cpxZDH/+z+7sR
         0XLGCLqe4I/x2fZMf3lXWpbaSAkmjnk0rY9BkZegZ41TqGuj3bz3qj9PVrePplyZiQkL
         rfaZozNMGlMOpum3c7/7tmQf8sU1NucSq9KD+oJctI9LME/is0bPgWrAZbhadpi0a+8l
         DtRw==
X-Gm-Message-State: AOAM530peMXR2jPRiASRMQbfvs91TbNAF3FS0kNs6jz75n5Ie4pdK/Dd
        N5xRAYWXdxZm/rjLk5DKkyRq7Okc6OA=
X-Google-Smtp-Source: ABdhPJy+AL6wGEA7o5lL7wOtA0b0zyE9ASeGkQ/gFwEHpvInlDkQ2oa8I1q2Zyfex5i/Tplyh+KNDA==
X-Received: by 2002:a17:90b:3882:b0:1c6:7cf9:8a23 with SMTP id mu2-20020a17090b388200b001c67cf98a23mr14172890pjb.21.1648856604177;
        Fri, 01 Apr 2022 16:43:24 -0700 (PDT)
Received: from [172.17.0.2] ([137.135.58.35])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a001a8b00b004fab740dbddsm4351840pfv.105.2022.04.01.16.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:43:23 -0700 (PDT)
Message-ID: <62478e1b.1c69fb81.500e1.cd08@mx.google.com>
Date:   Fri, 01 Apr 2022 16:43:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4828649064417609283=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-db: Fix gatt_db_attribute_get_index
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220401213857.36738-1-luiz.dentz@gmail.com>
References: <20220401213857.36738-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4828649064417609283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=628334

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.46 seconds
Prep - Setup ELL              PASS      51.25 seconds
Build - Prep                  PASS      0.66 seconds
Build - Configure             PASS      10.18 seconds
Build - Make                  PASS      1848.64 seconds
Make Check                    PASS      13.13 seconds
Make Check w/Valgrind         PASS      543.05 seconds
Make Distcheck                PASS      295.71 seconds
Build w/ext ELL - Configure   PASS      10.95 seconds
Build w/ext ELL - Make        PASS      1838.54 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4828649064417609283==--

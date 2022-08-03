Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F09C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 18:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbiHCSA4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 14:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiHCSAq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 14:00:46 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E960D19010
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 11:00:44 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id bz13so13196610qtb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=OLsKcNE2iRrYZ+YDutg0wksgEO4xzO0VtRAj9SnwPS0=;
        b=mL4GdHaWqSEMa43zIvWfe6k57CTCEaZno8ld3QYR0Ip4W7d6x1/JZ4I0mAiwyiAKws
         C0lDxxjo4DEXh+FP/i2uijVDPs3YMg6GXTB0N4xv8/Llp41vg4F1Gk0/LQsVbHyORjqx
         CI6gzW0sTTLWAKd6w6z2n9WfU/chfuuKRlOmd3QNK6w8q7s9liOlevEx6yIv++8KrFOl
         7uJ8X6ze8CLoankomqGR5xyKrTGdUXk6a+CivpSW5tqK0jeOq5GHNbyTvxEIJuPymQv6
         WlQOxUu8jP/XCtKYjzCSLFYG+GhW669Olezdh0EE0PQDzKIdmf98noD7nrMP7T5dtBpH
         lhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=OLsKcNE2iRrYZ+YDutg0wksgEO4xzO0VtRAj9SnwPS0=;
        b=NdRuiJGJOo+SqoXNx+98wJrdMp2QP92JQNnshRN2C0yBWj4FY7mPxFhHxq7bx4qKri
         /sU7U5dvu3rOnmXw6g5ifls9E6LFXBxSwzjwMBWkSFoXKgsXnXhe5eZ4UsCaPmnE6LMd
         aTp/10O3E9OQ7DWWYEyaVuBvZxgahZqpY9lSbgH/qjKr/povZ2/kzQlOtqyjgtaHWO+1
         tZYALukiwrDdSvMxlWlLt7A+d4dLHoA9ywVGRdSYn7i7BL8Ip04pUcgbNjfWJ/+kOKjK
         etGI6KwMSrcXPCzUtw5PhjzxJXS01z8hFAsW3A9wXXnIXSn/8bgtHqlYyOZvRfoF14xn
         9QJg==
X-Gm-Message-State: AJIora+bJaVuTcx8k8VLHZGLqS6FHR7UVjGhyoV6UirIa7qKDCKSAYn0
        X2vmRTvpHzUG6Z1mMoobRkAZgG1bXLr6cg==
X-Google-Smtp-Source: AGRyM1sECqEagvSVbNmhfy3H+9jiTHF94IF1n6XNC2kunqIx3By1UPSPkGVToOXjOJ8wbxlBRJUVpQ==
X-Received: by 2002:a05:622a:307:b0:31e:f654:1602 with SMTP id q7-20020a05622a030700b0031ef6541602mr22782066qtw.336.1659549643891;
        Wed, 03 Aug 2022 11:00:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.159.168])
        by smtp.gmail.com with ESMTPSA id x15-20020ac85f0f000000b0031ee918e9f9sm12389037qta.39.2022.08.03.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:00:43 -0700 (PDT)
Message-ID: <62eab7cb.c80a0220.ce75f.55e4@mx.google.com>
Date:   Wed, 03 Aug 2022 11:00:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3744554763774430640=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] iso-tester: Test BT_DEFER_SETUP works with getsockopt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220803172222.2952373-1-luiz.dentz@gmail.com>
References: <20220803172222.2952373-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3744554763774430640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665142

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.09 seconds
Prep - Setup ELL              PASS      27.01 seconds
Build - Prep                  PASS      0.81 seconds
Build - Configure             PASS      8.44 seconds
Build - Make                  PASS      761.00 seconds
Make Check                    PASS      11.81 seconds
Make Check w/Valgrind         PASS      284.50 seconds
Make Distcheck                PASS      234.65 seconds
Build w/ext ELL - Configure   PASS      8.46 seconds
Build w/ext ELL - Make        PASS      81.60 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      473.14 seconds



---
Regards,
Linux Bluetooth


--===============3744554763774430640==--

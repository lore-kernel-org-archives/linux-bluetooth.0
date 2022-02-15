Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96292C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 02:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiBOCbf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 21:31:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiBOCbe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 21:31:34 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812EF59
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 18:31:24 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 200so16157780qki.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 18:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=eVpVD8+BJx8jMX4nokjLXIVH4hFEwIz3G0WAe7CD7sk=;
        b=R63EtGRIKtmyEYa8oMRjdfBL6+0VgXaLyK3SbYUzgxxoDv5J6ZxGbNFBZdzd0qtFYM
         J4u7L/gWChh6uQ//3aoLDiP3kvglb71OqpuXdZnWvBsyfdJr/rq5BgoRMBbq71Y68r6G
         8Z0FYtcur0JRrSiZVFli3LSYz+/y8qeV6OXtzNmdC3uq5z2Ttkm2vZ4xFH6iUjNEtagk
         S3WYNpsFcCspkIVTbnLCDU7/IqAg63rUJzHY7XKxSN9cEkUy7VBE9UWipgkD2FpHIIB1
         MqAe+VdntYTWgP4L7HMVAStyy9iEj3DLRgyJS2dIubR+WGQhdoKw3DncbxKKAb8xesm/
         RH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=eVpVD8+BJx8jMX4nokjLXIVH4hFEwIz3G0WAe7CD7sk=;
        b=qLZWsDIpi/A0wwo7HyfSkCvbc0PUiqXmlPvOacRceLUJ4ihz/18mx8fj0d4iyvBPpW
         FNJlxSeqq6F+zTE4bbi4jPQ4kQS5avdcuaV0RvL2zMde9r23dT4U5y/cMiPZPE2DCrRn
         ze5AsjNPp95dP7VgV23KUPwS/W4xGQ0XlH4EodFx7zDsK5doofMaPnKvP8bNgd9Uadve
         iGRIHK9W2JMNSlrSrFsc9Bt3UHdhuqkQircLjZCYvG+n3Gaaet/zE4ctRZ0m8wBpy2Gn
         8wlQPLlTzxNJ0p3wXOi5vWmnq6VlyLaYzoHcveds77G0bTpGHIdmf7O4a/RrsK0ENr5g
         1Nmg==
X-Gm-Message-State: AOAM533DXUqRQVDupxXv9da5RkU1uaRHJYAOm5kxRg9E9uLoCO/ZNful
        yDkwZa7UKL/PFQOM9uVeYXwUrR0NLo/HzQ==
X-Google-Smtp-Source: ABdhPJy2nubR4SXF2CsCzzd/mCmz7+8p5KCo1b7JEsSZ5XbheFqZL47ZSpQlI/KwA+N9mpSwl+RTEA==
X-Received: by 2002:a05:620a:40ca:: with SMTP id g10mr1037091qko.574.1644892283236;
        Mon, 14 Feb 2022 18:31:23 -0800 (PST)
Received: from [172.17.0.2] ([23.102.117.21])
        by smtp.gmail.com with ESMTPSA id z19sm19613934qtj.77.2022.02.14.18.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:31:22 -0800 (PST)
Message-ID: <620b107a.1c69fb81.e124a.938b@mx.google.com>
Date:   Mon, 14 Feb 2022 18:31:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2509083220582544867=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gobex: Print error if data cannot be written
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220214234200.1881712-1-luiz.dentz@gmail.com>
References: <20220214234200.1881712-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2509083220582544867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614288

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      1.04 seconds
Prep - Setup ELL              PASS      45.12 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      9.33 seconds
Build - Make                  PASS      1298.30 seconds
Make Check                    PASS      12.01 seconds
Make Check w/Valgrind         PASS      462.64 seconds
Make Distcheck                PASS      243.49 seconds
Build w/ext ELL - Configure   PASS      9.23 seconds
Build w/ext ELL - Make        PASS      1278.19 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2509083220582544867==--

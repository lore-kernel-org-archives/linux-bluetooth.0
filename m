Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AEBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 09:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiAMJax (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 04:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiAMJau (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 04:30:50 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEDC061748
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 01:30:50 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id g21so6186979qtk.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 01:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=renYRd09Ki4UAbgy6b1r1dmdca9tnZnWTxduZ+9SS6s=;
        b=Vgwo+YhaF9aTx6Stp7gAzUPMQxFKPbeiC/bNqtvPmLQLLuOKK5PjSRvs5PFUSWNp93
         MLf3pUq+VVWEh+dzwuvJ8j4m2TNQSstnMU/QLW9IyhEVxnfJ1aIoUKoAPZ8LF/vOs51P
         9B7Y1xg+BwAeRd9P1pqmDs6EzCQL6feALwUqBVlmC2HZ5eYVNHI/YNIudxED9FGgkab7
         +aQqkG9gOZRNB7ZKRNNwMEO32ZufalG0oCzC1aT7T+PkG+nz+918cED4um+nhRFBc6he
         rdz1QYCMmUrBgZJooM3pirT+AnXhAL+ktq4jlHUSPVDF799yRIX1v9Llt7O6pOy1UMAr
         6Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=renYRd09Ki4UAbgy6b1r1dmdca9tnZnWTxduZ+9SS6s=;
        b=mZmkB8bPGG2lQmVBWo3s13lhSaMhFEvplnVmIw135p2N3XblpcIuTVHu2vj0RZjsho
         4QZ853FkBPagcrT8/LNRTMH3vQKnhDBDDBHDbMhZ4SmokatCJDRoppJe6cFg7nI2x+Fm
         wCSicVoad3zYSfccXmc4jY4TZ9OkYLbqMjQ1OcDRb2gmclHxM8m3rT6rJTPMHwi/qcEv
         yIdLXwVuhVkgmeeYehxz3z70XVUETxy3pkgj0vU8RVSDAklVgaxTMBcubK5xBeOVFdyy
         yUTVbTV4O+wDbZrSXRNDIAh1CHDXqMyuZmlRIdPu+V7MwNeDsbjL4PGb8dKG2V4mONPv
         wTlg==
X-Gm-Message-State: AOAM532J9NmrN/qymVowjEbRJ4Zu+g6tz3UM1h2+Sh3risSycTAu8W6r
        7j8ZRFBfNrPN83JX6yUkZD4lmBPa3to=
X-Google-Smtp-Source: ABdhPJzri2S6x633dpRp/CaN3z48JeSoHbc9YR017lCOMtyfOD45ZSAXFYGkHptr0NvZKY4nPx1CBg==
X-Received: by 2002:a05:622a:14cc:: with SMTP id u12mr2771178qtx.644.1642066249385;
        Thu, 13 Jan 2022 01:30:49 -0800 (PST)
Received: from [172.17.0.2] ([20.65.77.233])
        by smtp.gmail.com with ESMTPSA id j12sm1639512qtj.30.2022.01.13.01.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:30:49 -0800 (PST)
Message-ID: <61dff149.1c69fb81.415f4.8d3e@mx.google.com>
Date:   Thu, 13 Jan 2022 01:30:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7908240986835885459=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2] device: Fix device can't be scanned for 5 mins after reboot
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220113154626.Bluez.v2.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
References: <20220113154626.Bluez.v2.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7908240986835885459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=605104

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      0.97 seconds
Prep - Setup ELL              PASS      42.40 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.52 seconds
Build - Make                  PASS      1403.75 seconds
Make Check                    PASS      12.08 seconds
Make Check w/Valgrind         PASS      437.97 seconds
Make Distcheck                PASS      232.37 seconds
Build w/ext ELL - Configure   PASS      8.66 seconds
Build w/ext ELL - Make        PASS      1365.55 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============7908240986835885459==--

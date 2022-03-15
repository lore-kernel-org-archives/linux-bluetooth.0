Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC27C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 11:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347521AbiCOLFS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Mar 2022 07:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241801AbiCOLFS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Mar 2022 07:05:18 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4419D24BDD
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 04:04:06 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id i8so3550052qtx.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=N6mVzyoGyoeob7rmIBgzyHA6DdjQadgXQe7KPQb8Z1I=;
        b=XoK4hMLmFEuATm9nulIOuQRKhudEjpqltRPh+877XoOHLcPXXqTCcCgpcSPTAB+gog
         maz8/vSWpoa45hnXTi8sV5/WIUXL/Zk0m6TN0tE78hRsgzpmXDlQqmXf7pXmCxXxadIC
         7UnLgglb/8tDM9aRCkD235W/USjzHdPbeVlvl4+exm6Y9U1Q754XlJa9LK20Pi/M1M2k
         dR75HJeI13FRzX4z9KDhICmuYWWXmEHrZ8C+u/QDEUFF7FAwQQwHcMqj3poBsiWjhIEy
         YRKxahxVf/ZCuOdDPte9jZJI7hsbVUjotzUwlYXv3+N/9ivmNh7cDdHlHg/By80XV7kV
         a7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=N6mVzyoGyoeob7rmIBgzyHA6DdjQadgXQe7KPQb8Z1I=;
        b=n/XRbtzRA4sZc15xoBqWNyTNCSJjtCI2CBZMOYTLIa65JpSPulX7z6gPQlsRDxlbhr
         LiR8bziOJheRuKOyVClUkmwKVPvFMV3BkKsMvLGzIyedBupuP4NjPRR9n0acQcYM7G7e
         vWlvC9MYBfN5iCyDGw8gqxAaU3yFHg0JEw0T/nMagXNCg6o0FVnYBaIqX1WVtPiSw6Pf
         u06B/qXqNQ7eWPBfMczfmmB8wOcSoTCTNmIreVtOQPpleShRT460S1srBrIZ8V5VWB2K
         Yqr76DbixOf1pzj1XmqcgKsLl6UXes31MLyCw21OfK/Q98ZBBgviXNgMU2yd66VsQXKL
         qHiQ==
X-Gm-Message-State: AOAM532GmXTNDGNdZnlJDcmWKelqn5X5NhZfCNap7wp28fcTV/8YP7O4
        UrJswpVvoheBHT66jU5VaO7uG5Zp+6uX2w==
X-Google-Smtp-Source: ABdhPJx1fOo2XAM0e7KswCus518gx6eAVRNBkABKbEosooM/A9Y7295B0V+JfIAMjF0+nsoqyXcuFQ==
X-Received: by 2002:a05:622a:56:b0:2e1:aaa1:739a with SMTP id y22-20020a05622a005600b002e1aaa1739amr20216337qtw.210.1647342245176;
        Tue, 15 Mar 2022 04:04:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.178.151])
        by smtp.gmail.com with ESMTPSA id k6-20020a378806000000b0064915d9584fsm9148711qkd.8.2022.03.15.04.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 04:04:05 -0700 (PDT)
Message-ID: <623072a5.1c69fb81.2119c.3d51@mx.google.com>
Date:   Tue, 15 Mar 2022 04:04:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6862872148313763695=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: [v3,1/2] Bluetooth: btrtl: btmrvl: Fix firmware filename for rtl8723bs chipset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220315095129.15254-1-tangmeng@uniontech.com>
References: <20220315095129.15254-1-tangmeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6862872148313763695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=623467

---Test result---

Test Summary:
CheckPatch                    PASS      3.06 seconds
GitLint                       PASS      2.07 seconds
SubjectPrefix                 PASS      1.72 seconds
BuildKernel                   PASS      29.67 seconds
BuildKernel32                 PASS      26.39 seconds
Incremental Build with patchesPASS      44.25 seconds
TestRunner: Setup             PASS      457.53 seconds
TestRunner: l2cap-tester      PASS      15.11 seconds
TestRunner: bnep-tester       PASS      5.91 seconds
TestRunner: mgmt-tester       PASS      97.37 seconds
TestRunner: rfcomm-tester     PASS      7.41 seconds
TestRunner: sco-tester        PASS      7.23 seconds
TestRunner: smp-tester        PASS      7.31 seconds
TestRunner: userchan-tester   PASS      6.00 seconds



---
Regards,
Linux Bluetooth


--===============6862872148313763695==--

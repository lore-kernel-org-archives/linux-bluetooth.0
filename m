Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675ACC05027
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 01:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjBOBVW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 20:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjBOBVP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 20:21:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A2D32CC5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 17:21:02 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id bt14so4697664pfb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 17:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/NuQDsuvjzCNaVkDymyQQUUtoVjiMe4pBdFmdaEHt8E=;
        b=WUgoTdy0gXEuHnQLfQOVBBhaxe1QQgL5JxMyclkZNMzYCiproZpcQwDFYl7R3O1Fbi
         bZgNm+l70IPmH/+XefrGvir5mdOEQjeEm5p404I1oeTFhEhTRA/e2EpuyDiqq5khHJXj
         Sak0xFiR7aQIEYx/ojxIm3tj6ol0AKOLQzZJrC17r4izWhSAw3AZK1vkt08GvCFSPcLF
         IFFxOP7IZxIdiUtIRS8LCMeDL7xO1fprkibiCsPQ4HajiwoSsgss97fnyNKtTvTDm9ES
         LZ/fnksTAms4Mb44IbHNLD0VBy/30Co99YUJCQdr0B/GFiHiF/hzV8M+Yb8k3oGWTvWc
         Y0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NuQDsuvjzCNaVkDymyQQUUtoVjiMe4pBdFmdaEHt8E=;
        b=G9RJUB0e6x3ngPl1yXOCpgDPRU2+7TMjj+PSwnHrebHnJxaZpMNd7ty10q4grkEmvj
         yBCyno7AaRyvwE5zy89XB1s8k89MGfeSy5c2qFqVhQ4KDzoOHnnAMyjtpRpi4m9xfJs3
         YrkGiNTrB/5LXz0JKJKsndkEUzuNIiDgIQxUG1dp6/Xx2fCoJ+6UVPgMZvpthFmOsvau
         hbshhBDobF443s4mc+xmGFMoLBLz0RnSc7h+GXJiby3fc08TWrkSkINwUTK8fZkZcE70
         DTilk+Ym/gcdIl4QSTbGG77uJWRzJdX9sykU0ZXweco+ENECe3N+yBINENG7hTgVtT5d
         b2FA==
X-Gm-Message-State: AO0yUKUQ4eYNx0E6a4PuWwk4MqdQ13FXZqIfyjFBUYJmKJqSSb4kkfC0
        DEMmkYaXRKchmrR9qcDyVk81I+4Busk=
X-Google-Smtp-Source: AK7set+SuW3I0MJ/WxIOOPZSnKKahBU/pV2gRWygyRkzfrkI1BU3wq/Brg/ZXEpkT3D4LoYCym9GNA==
X-Received: by 2002:aa7:954f:0:b0:580:d71e:a2e5 with SMTP id w15-20020aa7954f000000b00580d71ea2e5mr136059pfq.22.1676424061524;
        Tue, 14 Feb 2023 17:21:01 -0800 (PST)
Received: from [172.17.0.2] ([13.91.161.18])
        by smtp.gmail.com with ESMTPSA id j21-20020aa78d15000000b00581c741f95csm10355512pfe.46.2023.02.14.17.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 17:21:01 -0800 (PST)
Message-ID: <63ec337d.a70a0220.26124.37ab@mx.google.com>
Date:   Tue, 14 Feb 2023 17:21:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3495753262834606085=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v2] Bluetooth: hci_sync: Resume adv with no RPA when active scan
In-Reply-To: <20230214154104.kernel.v2.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
References: <20230214154104.kernel.v2.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3495753262834606085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721897

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      39.06 seconds
CheckAllWarning               PASS      42.41 seconds
CheckSparse                   PASS      47.61 seconds
CheckSmatch                   PASS      129.51 seconds
BuildKernel32                 PASS      37.67 seconds
TestRunnerSetup               PASS      537.95 seconds
TestRunner_l2cap-tester       PASS      18.94 seconds
TestRunner_iso-tester         PASS      20.48 seconds
TestRunner_bnep-tester        PASS      6.82 seconds
TestRunner_mgmt-tester        PASS      130.43 seconds
TestRunner_rfcomm-tester      PASS      10.84 seconds
TestRunner_sco-tester         PASS      9.82 seconds
TestRunner_ioctl-tester       PASS      11.65 seconds
TestRunner_mesh-tester        PASS      8.92 seconds
TestRunner_smp-tester         PASS      9.60 seconds
TestRunner_userchan-tester    PASS      7.18 seconds
IncrementalBuild              PASS      35.28 seconds



---
Regards,
Linux Bluetooth


--===============3495753262834606085==--

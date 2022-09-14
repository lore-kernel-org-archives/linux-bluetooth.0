Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CADEC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 00:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiINALf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 20:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiINALe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 20:11:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C95AA2E
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 17:11:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fs14so12868497pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 17:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Q0n6xcnn6BU45qum4Yc7WR3vtovpjwVmRF4QxODXApI=;
        b=oxdqXYiz6MMK/ybtacbh0V0b+Eh0OFvFJgI/IK1HUBv0kwY0TT0qT84f32OD5wVUM4
         r05uDCDr4VY+KHAjDZn5URFFvUBovwkPBNhEoiJg+Waj6yt5wvUssL2zpOfEHTiAXN+V
         B1a8c0XjPmKboYznyCApcmF2DXQ4o6Gw/eOP8qyf2HVRhKaxfyZs2lmM1YkaEgYtnqWt
         7HQOimi3BZQUNBOOnphIEIloSCdEeu8EQVQ3oxmj9H+8gQb1jA8oN9OeXkrAdV/WA2Gp
         5teIjKH5T4LA4Op6YAhiyTkNo9RDiOu3J0GKUYFRJuHWNkpc6g9ZDQJOqMTqQD6eLw3u
         egTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Q0n6xcnn6BU45qum4Yc7WR3vtovpjwVmRF4QxODXApI=;
        b=oNuTfYT4edRiudWkpCWpWXXvvmflF51ucSd59Qwz7Yuxg6wHfJwNwrH8L3Yu8tME7z
         ddE87eLqoUFfNm9grAMylJ1kHlG/2ghHdNA0XpLUfE226jphZTqk9BxdPBhiCroyms4g
         oyCUsF14TPkJTFBCvo6JmpJt+xC84ZNOrPwv+3lbpW+Qc52uFBL7ysXSuGLzXf1jrfdC
         6KblzhRJ8vYSWOFaJdTYJA4ci/obuALkCWmT77ZcK8zowiEeZh12a53+hjvQ18S0de+S
         jFtiVUZ3Gh5NrJCt0TKvBX64XYDuJ2oleHmh03g3rDl3N4dbC5AMXARhnSpxCIFp39V9
         zXAQ==
X-Gm-Message-State: ACgBeo1yyH6MgWpZd39Z1e2wdJignu7ZfVJ6BKm1888EOC0t/GcbSpJp
        fvOTjeTwYdNblJGKgQjyiOAJnzleddQ=
X-Google-Smtp-Source: AA6agR5aN3E9e4ecgybeQ9U0k8HArYFdPYMCliwNA5yarzhQJptjuBcVo+LJX0S+frtes3uxMcukvQ==
X-Received: by 2002:a17:903:1c3:b0:177:ef4b:c614 with SMTP id e3-20020a17090301c300b00177ef4bc614mr29333719plh.17.1663114292798;
        Tue, 13 Sep 2022 17:11:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.254.122])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090a6b4c00b00202d1745014sm4565042pjl.31.2022.09.13.17.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 17:11:32 -0700 (PDT)
Message-ID: <63211c34.170a0220.83cba.82ad@mx.google.com>
Date:   Tue, 13 Sep 2022 17:11:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2498890637028069507=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Bluetooth: hci_sync: allow advertise when scan without RPA
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220913163710.kernel.v2.1.I54824fdfb8de716a1d7d9eccecbbfb6e45b116a8@changeid>
References: <20220913163710.kernel.v2.1.I54824fdfb8de716a1d7d9eccecbbfb6e45b116a8@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2498890637028069507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676717

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      41.10 seconds
BuildKernel32                 PASS      35.42 seconds
Incremental Build with patchesPASS      53.59 seconds
TestRunner: Setup             PASS      595.31 seconds
TestRunner: l2cap-tester      PASS      19.10 seconds
TestRunner: iso-tester        PASS      18.90 seconds
TestRunner: bnep-tester       PASS      7.27 seconds
TestRunner: mgmt-tester       PASS      117.60 seconds
TestRunner: rfcomm-tester     PASS      11.28 seconds
TestRunner: sco-tester        PASS      10.98 seconds
TestRunner: smp-tester        PASS      10.82 seconds
TestRunner: userchan-tester   PASS      7.66 seconds



---
Regards,
Linux Bluetooth


--===============2498890637028069507==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0071EE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 16:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjHUQIY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjHUQIX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 12:08:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10860ED
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 09:08:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a4025b5e8so967559b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692634101; x=1693238901;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XL/to5mMezF2NgZfOkQ+4sJIRSENiswWUbaHRID9AC0=;
        b=LW70EdDYH68NBtMhG4FMYTcvhNCoBjSPR+e3Hu1weDMYmUUOkm+XfBNtQ5onP8NxCo
         7pJAXqKFswUllwNLYVIvDeANpLZr7SBAkQ2Pmv84YY+Va1dGThofjAwfM+nvNbkXOkoW
         pV5kbJhNlG7aGeWrUoEE9UkMxsFFqzOrate0I+LdlErcPQtsJMHQY6ea5huBSHKRDvcS
         Ixh0eQWXQ74wdyCtE8KjHhqTWbQFOdk+E35SUrpKGzNSbH1AKG294rAS+nJ8/XE2szDt
         8p5XbxbwynKAQhYfnVKJwAShn/i7yGhEBGakY8Dlm8vZarG5Fewg1S6PLXL0bt8eql01
         bTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692634101; x=1693238901;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XL/to5mMezF2NgZfOkQ+4sJIRSENiswWUbaHRID9AC0=;
        b=eri8HlKYNmKKjYaTUZPUZ1496xGDitVa+o4NOJGwvNJHSVNcB/rlrRX+EojLTq/jiW
         88L54cnsTCQKQ0tCZ+59CFVUBLRaOEbUTBmHPjs3+HMgi8pG7SgXocj2KwG34mlRbenz
         pS5kVeNCEuMkF5giO8SWDOeauJa5tD6DXMkoXLqoh3qQpLb+GJTjXLo28Z6OEVtm4shW
         2TajNqDboQDdy+dIq/qeBD78rmAUpoVteZHAbmp2MBC5tqKfXJgPq9mjmF3bwZ0VaKBN
         6RZG4+zTAkbWOvd8EHiSmCJJMeL+uUUXXGPKOpE1pxZakK4EPJrsWi+HoZeP1+d4Culs
         c8Ag==
X-Gm-Message-State: AOJu0YzHc/1rC8UNBsRjo3uKGBpMXK9P5cC23VIhNnP4kAI0tTUcS+ER
        InV5qRopEOOL9SNnGee85HucReHOJC0=
X-Google-Smtp-Source: AGHT+IGLwemSNTsh+XLJYvm9QJrk6lyusV0tkWWdiZoMRB0BdU+iUqtDVK7dHGMRDeIjmWwEmzXwow==
X-Received: by 2002:a05:6a20:3d09:b0:13f:13cb:bc51 with SMTP id y9-20020a056a203d0900b0013f13cbbc51mr6474261pzi.25.1692634101228;
        Mon, 21 Aug 2023 09:08:21 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.116.223])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001bf3bdbceb5sm7028094pli.134.2023.08.21.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 09:08:21 -0700 (PDT)
Message-ID: <64e38bf5.170a0220.13ed7.c7ee@mx.google.com>
Date:   Mon, 21 Aug 2023 09:08:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5353175027045561051=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: ISO: Add support for periodic adv reports processing
In-Reply-To: <20230821152529.23000-2-claudia.rosu@nxp.com>
References: <20230821152529.23000-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5353175027045561051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777927

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      42.93 seconds
CheckAllWarning               PASS      46.87 seconds
CheckSparse                   WARNING   53.16 seconds
CheckSmatch                   WARNING   143.38 seconds
BuildKernel32                 PASS      41.90 seconds
TestRunnerSetup               PASS      640.92 seconds
TestRunner_l2cap-tester       PASS      37.25 seconds
TestRunner_iso-tester         PASS      85.34 seconds
TestRunner_bnep-tester        PASS      15.95 seconds
TestRunner_mgmt-tester        PASS      278.91 seconds
TestRunner_rfcomm-tester      PASS      23.34 seconds
TestRunner_sco-tester         PASS      25.46 seconds
TestRunner_ioctl-tester       PASS      26.25 seconds
TestRunner_mesh-tester        PASS      20.32 seconds
TestRunner_smp-tester         PASS      20.52 seconds
TestRunner_userchan-tester    PASS      16.32 seconds
IncrementalBuild              PASS      40.64 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============5353175027045561051==--

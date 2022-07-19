Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ABBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jul 2022 16:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiGSQKp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiGSQKm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jul 2022 12:10:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284215FC1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jul 2022 09:10:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b10so4286237pjq.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jul 2022 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=stGTs2x8LRm4s/1keePhjo+aVJnjn5w7XdP+qhmgMIQ=;
        b=U6kHejWZqJVXgYJWJYzhDxFzMJHgVJb+Xj8ERR2wWS8DqZKXqBrVphMWNfkF+6vs0L
         DhS1psyojME18Z79cLR/ni0b76JdGHQGaBG/NET/XDmPH62om/3+pRk7d4IO9qNuC3Yi
         MThPBpR8yAJBzu6fjHjLIsMxBbXGf7Q52LrL5kO5vwuJZWZvHpdrsCXqfYk5rR9Ar0MB
         kDK6Q+d0Tp+r8+dHWPaeYmGk2I1DOlIx92UaL7RVPY+5pqNrdKyQDgcW7qcXzIlcoheV
         YZhbK2QRw1I7Wishz/PAgdtREfeDqY11O2t2ZbXnub9bUxscRXUwq3RG+uNxqG7Mx18t
         Bgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=stGTs2x8LRm4s/1keePhjo+aVJnjn5w7XdP+qhmgMIQ=;
        b=ziU4HrxVpE7eyj+qkq9TLEKk9t4LJAUSu4hluJzUl/I59N5wl78IKOVuLFHZIHG+31
         Ud5dM7n6zyXJM0LoZ4S6jowHDMfC1ALUZ6wOksvzgDIm+lrDzYPxAxE2Dgp+l1WzcIgh
         MKeO+7E2mpaWvMANOu1PJF5/2oXmpHfMz2FYLYF0xwg51qwdrgh00+AvTha/kioA+kOm
         LgiNY1EJJdP7DuF1575eZBSfbAox0zjgiqOv0Lrgzm4Oe519bnhgGRYPzzIjgGkzJFfm
         PEtOXUDfl0LNuvDFs1VrNXyJl9wi4sXOuM+IPiKkmA1m3XoId0yEO4VueNlOll5FA8s+
         7n7A==
X-Gm-Message-State: AJIora/1xQBN3DSX1EdOMHk/oGcY1+b919BEueRvxEXHphttUguRVUUs
        vNkyFKGagkkkELwCZayjlWCFcLY+dww=
X-Google-Smtp-Source: AGRyM1tKSjJXPxjGT44pTi1sMfaUxYZOgM5+n2oIckAjJrbHryL9OZ/oqspvET/SQ13hc/i2sZddpw==
X-Received: by 2002:a17:90b:3d04:b0:1f0:693f:69c8 with SMTP id pt4-20020a17090b3d0400b001f0693f69c8mr87210pjb.188.1658247040814;
        Tue, 19 Jul 2022 09:10:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.151.139])
        by smtp.gmail.com with ESMTPSA id a10-20020aa7970a000000b0052513b5d078sm11789353pfg.31.2022.07.19.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 09:10:40 -0700 (PDT)
Message-ID: <62d6d780.1c69fb81.dc274.1ae0@mx.google.com>
Date:   Tue, 19 Jul 2022 09:10:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6944314941263306368=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dengshaomin@cdjrlc.com
Subject: RE: Bluetooth:btrtl:Fix typo in comment
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220719154148.16769-1-dengshaomin@cdjrlc.com>
References: <20220719154148.16769-1-dengshaomin@cdjrlc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6944314941263306368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661165

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 FAIL      0.40 seconds
BuildKernel                   PASS      33.58 seconds
BuildKernel32                 PASS      28.97 seconds
Incremental Build with patchesPASS      41.56 seconds
TestRunner: Setup             PASS      497.27 seconds
TestRunner: l2cap-tester      PASS      16.71 seconds
TestRunner: bnep-tester       PASS      5.57 seconds
TestRunner: mgmt-tester       PASS      96.20 seconds
TestRunner: rfcomm-tester     PASS      8.98 seconds
TestRunner: sco-tester        PASS      8.72 seconds
TestRunner: smp-tester        PASS      8.80 seconds
TestRunner: userchan-tester   PASS      5.75 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.40 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============6944314941263306368==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A092C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 18:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbiFMS7i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347912AbiFMS7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 14:59:07 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8D23BEC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 09:14:07 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id ea7so4611236qvb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 09:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iVjD57hdo2WMxchav0+PBHHKW/6ZnzWazRGd8eLPWfg=;
        b=Le4aB7r1p9Fldy4F+dH2T26r0c/ypf53Fb5vwWDafTXfg20Jt3Unm1GrfYPdvN+vam
         DAlg1Gbs5CIMtpddXXdOeld3g+7kC4F+P/74wRoHIBHINLtEFM1rlTYTBaLid6W4Rqw8
         cDARJG4xu6w8f39aoE/dRnccx+EUDhEJv3IKpp6rULZlLol6fJILFWTdyeMdhObQiTC+
         gVIdDeTiknpPPpO4JgRlLQCSX7Ra5AqBOHEtHW/POziE2oFTpQeY4rBU9gHh8PkHQZZr
         jBxXteVQ//oX8EJ+6AqFuHo9lWiTLE3qVJC5sizhn6X+BV8LTkY65JmAxLkD4Z+B3pyU
         u6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iVjD57hdo2WMxchav0+PBHHKW/6ZnzWazRGd8eLPWfg=;
        b=tuwO1eFoRXV0WC3KSvp+s5QU+2Zndv5YuBriknqAIiCKo4qK7ix6Dwok+stmic2B5g
         RtlT2tPjH36t/Q2kuIBEMQBIW/P69lKdlkVstwto5s4wFTtgTA1iz8QUwk8eIKs9w2gk
         BEYV92Iu01/frFsnJUozVySvz6LsNHP0ll2OIprUTp0YVCb1tel39hiWyCw2Iz1r9ZtD
         lnSl7NRA2kwKb3Zer/jneeE7v1CIQjqP1fSICaMnKLB2M1wY5XP9CvmU/sdRrViuOlBW
         UEmsYnjwW9CFWLCbteES4AAEwcNyMh6bJsT8J2RRQQdXrH77e3OzJuJbngNDdL7ENLvH
         M3bA==
X-Gm-Message-State: AJIora+8vtvhlDuFyXUV1V8vFKGkCn6iu2/22kKOJScBx544DvYOOMVC
        Mr/dyO0HA5Sy3W0zN15WNWqe4fjhURGHWw==
X-Google-Smtp-Source: AGRyM1sTpKalT51rjKx+Q2JaMxWvkDZne1YEjPJrWuiDLq3FQLszCEMN2MoNpLqTyle6sejglmO58A==
X-Received: by 2002:a05:6214:2247:b0:464:426e:3c5a with SMTP id c7-20020a056214224700b00464426e3c5amr616218qvc.46.1655136845922;
        Mon, 13 Jun 2022 09:14:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.10.188])
        by smtp.gmail.com with ESMTPSA id 14-20020a37030e000000b006a6b498e23esm7390482qkd.81.2022.06.13.09.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:14:05 -0700 (PDT)
Message-ID: <62a7624d.1c69fb81.f4b81.b4bd@mx.google.com>
Date:   Mon, 13 Jun 2022 09:14:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2373166270340183875=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, stephan.gerhold@kernkonzept.com
Subject: RE: Bluetooth: btqcomsmd: Fix command timeout after setting BD address
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220613110745.3778356-1-stephan.gerhold@kernkonzept.com>
References: <20220613110745.3778356-1-stephan.gerhold@kernkonzept.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2373166270340183875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649852

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       FAIL      1.00 seconds
SubjectPrefix                 PASS      0.92 seconds
BuildKernel                   PASS      32.35 seconds
BuildKernel32                 PASS      28.92 seconds
Incremental Build with patchesPASS      39.04 seconds
TestRunner: Setup             PASS      476.76 seconds
TestRunner: l2cap-tester      PASS      17.37 seconds
TestRunner: bnep-tester       PASS      6.07 seconds
TestRunner: mgmt-tester       FAIL      105.82 seconds
TestRunner: rfcomm-tester     PASS      9.67 seconds
TestRunner: sco-tester        PASS      9.39 seconds
TestRunner: smp-tester        PASS      9.40 seconds
TestRunner: userchan-tester   PASS      6.37 seconds

Details
##############################
Test: GitLint - FAIL - 1.00 seconds
Run gitlint with rule in .gitlint
Bluetooth: btqcomsmd: Fix command timeout after setting BD address
8: B3 Line contains hard tab characters (\t): "	Bluetooth: hci0: Opcode 0x c03 failed: -110"


##############################
Test: TestRunner: mgmt-tester - FAIL - 105.82 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 491 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Add Advertising - Success (Name+data+appear)         Timed out    2.630 seconds
Add Ext Advertising - Success (Name+data+appear)     Timed out    2.489 seconds



---
Regards,
Linux Bluetooth


--===============2373166270340183875==--

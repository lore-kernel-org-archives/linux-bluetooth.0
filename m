Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB621EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 14:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbjFMO51 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjFMO50 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 10:57:26 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED15173E
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 07:57:22 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39a523e8209so2850691b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686668242; x=1689260242;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=caP1xPgRlqUSCe5yYdjuatsQ8Cgi84LlO5yoWXkS1NM=;
        b=r3UP1fDFfuaz9nf0yYk0yN6oQn+K6Ee69oO7r5pvUWO5dRR60rcy1PZBkr0gwYSw1m
         9V+XSEqUfvDpFUh0uj5jy21V9OM1jaGI5vppHAs4hHFAEfP7mcxrxBIRxobNBFfncZ5C
         9gkLhPZY4ynLNC8tx4QccXd+d4ejKC6cbkURlykdKYzWpaGCYGR6x5c9FJ7zvJBWKP0W
         BhNpk0WmkDj4stHIuRON+COUcmX7K2z1WfUsp2JtRVHU0Xn/r31NULeVAWUAQC23eKnc
         cEr1wqj0IU4NYFMMrJ2GhlCX1cUokmP1RQB++vSBnxvsK9X7WlV8WOKUzX7FcCH9cTEo
         7j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686668242; x=1689260242;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caP1xPgRlqUSCe5yYdjuatsQ8Cgi84LlO5yoWXkS1NM=;
        b=bPw8Rv5dxJteTd+KnBI05JzikKghkqDr1pGfvxeb7Nu4A6bChoNBT43KwOUpk8QyIx
         2L/d63JwOSljgEXKlHxPFpLLRbdCWHvmyShAxv5yjxQFwchF3Npybwwp+G6xJq+DcVFC
         kpHZIVTG0NdRcdf9gApkRvLj20Mnz3d667X9lQnfuE5+o10ZEcj1PXQqD8SpzzGaGcGO
         xz6tisJLsxFPnc8RDLp+qzw3QlXrJMK7dvljRGHOttPRoq5jC2CGv9l8QZ4q70WZnH0O
         tY1rmskN8KZczGwDeB2hm4jfFF/NZzTkuGiHzB/1iFIjK/SEfyh10sGoukchmdfMjZLf
         Hf8g==
X-Gm-Message-State: AC+VfDxpKlhdBPvLIS9HubanxaCSh5Yfv2xQHThUOos+zLBW250T2d+B
        ePNCRGqrQGadSbHGqRkRM0GYkz7aWFI=
X-Google-Smtp-Source: ACHHUZ7mksmUBI5oQolOj0JNwgP95QuKH6taJ+YtxX49h21d8vGJMcXwgZHpl+xLUyk/uTzO89CpRA==
X-Received: by 2002:a05:6808:13ca:b0:39a:aa06:859a with SMTP id d10-20020a05680813ca00b0039aaa06859amr8931416oiw.21.1686668241679;
        Tue, 13 Jun 2023 07:57:21 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.165])
        by smtp.gmail.com with ESMTPSA id e10-20020acab50a000000b003942036439dsm5383393oif.46.2023.06.13.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:57:21 -0700 (PDT)
Message-ID: <648883d1.ca0a0220.a4702.8eef@mx.google.com>
Date:   Tue, 13 Jun 2023 07:57:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7445691389290164508=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Support multiple BIGs
In-Reply-To: <20230613142017.9337-2-iulia.tanasescu@nxp.com>
References: <20230613142017.9337-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7445691389290164508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=756772

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       FAIL      0.67 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      32.60 seconds
CheckAllWarning               PASS      35.16 seconds
CheckSparse                   WARNING   39.83 seconds
CheckSmatch                   WARNING   111.79 seconds
BuildKernel32                 PASS      30.98 seconds
TestRunnerSetup               PASS      449.75 seconds
TestRunner_l2cap-tester       PASS      16.94 seconds
TestRunner_iso-tester         PASS      22.54 seconds
TestRunner_bnep-tester        PASS      5.56 seconds
TestRunner_mgmt-tester        PASS      112.35 seconds
TestRunner_rfcomm-tester      PASS      8.91 seconds
TestRunner_sco-tester         PASS      8.08 seconds
TestRunner_ioctl-tester       PASS      9.54 seconds
TestRunner_mesh-tester        PASS      6.99 seconds
TestRunner_smp-tester         PASS      7.98 seconds
TestRunner_userchan-tester    PASS      5.79 seconds
IncrementalBuild              PASS      29.66 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/1] Bluetooth: ISO: Support multiple BIGs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B3 Line contains hard tab characters (\t): "	tools/isotest -i hci0 -s 00:00:00:00:00:00"
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


--===============7445691389290164508==--

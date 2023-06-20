Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D43EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 07:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjFTH6e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjFTH6E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 03:58:04 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A61BD8
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 00:57:39 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1aa291b3fc4so1673338fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687247859; x=1689839859;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf0JO+vBC3Rx9BipJNwWS4ktegyx0tB4/zjuGNIGF7k=;
        b=r6eNb7XBOvsTp8hIDGGufPuu+eluXwOF7x7CjtRBvbVSDk0/PBuwCQS5x2X8XEbpDk
         mM7uGT/gtpBPPRPc3aOFDEpZTz2OkSTiP/BGCh6JRz54li4DzbDeWoGdr683Mn9Ai/gO
         9APo9Eg9PGpnYFqvrwHajIxfRCfRlgciUn76bkNLYz4J0BSolksffksIpS4eNUvzyz+S
         AJCzPxE/z/Smv4ex5tMt1jJJ/WrOek0OmoT+uMpI3/Qg9ioskA1WNzX3SVrzcDdII9BP
         WU2F04HFALBXzw4n+aERzgz5zMei6M7XYJgB/R+eFiDJUyVUCN/2M9mLsB26LjwJtISt
         FWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247859; x=1689839859;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf0JO+vBC3Rx9BipJNwWS4ktegyx0tB4/zjuGNIGF7k=;
        b=D3lIEPAsLJ/fvwN/Tptf2f5XIBLMUyE3B5HXJ5ySBVqaONFro9dS/0QftM8UFhkm+b
         DiCjXVUdnHMU9qYSUCQktUSj9TJC1vQlRF/NSgeiCg2VwitG2OGx4xRcKOc/Td6YY0qe
         /CLvKVtGuNDqKMUF/VDnLcU29UIe+OiQysmD+3iZGU4U3SGDAuWtR1x+aOMIChkwiSXo
         lqvv5redo7D+o+JOrYf7gP9gK2A9vInay2Bz7ksYTM/D9dEsoO1AVjTwXzG/hrA5WmjA
         MXKjEfRXnLGstesFTZqnK+4s7ixHASBqCH5xShTFbT9n3p0PSIEzLBUeVn9ET4P6QOmU
         T/3A==
X-Gm-Message-State: AC+VfDwIqDBLlXVNLJNXOJKZP1UJzziD2w0Q2RgARaXFon2421R2GOch
        /5fr/0LA3GAIYRuj2CY3MZNX3fQtQxo=
X-Google-Smtp-Source: ACHHUZ50A1Kib82giIXAWgSphFKZNqDUHnoq0U6yT6JBB1FfCtHQK6r5D4/ku5I7Kim0K1QLdD+Lbg==
X-Received: by 2002:a05:6870:3815:b0:1a6:c120:3bae with SMTP id y21-20020a056870381500b001a6c1203baemr2438328oal.58.1687247858788;
        Tue, 20 Jun 2023 00:57:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.141.234])
        by smtp.gmail.com with ESMTPSA id j20-20020a4ad194000000b0055b333a3af1sm763079oor.13.2023.06.20.00.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:57:38 -0700 (PDT)
Message-ID: <64915bf2.4a0a0220.9f2b1.3b16@mx.google.com>
Date:   Tue, 20 Jun 2023 00:57:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6245988764871891368=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, peter.tsao@mediatek.com
Subject: RE: [v2] Bluetooth: btusb: Add support Mediatek MT7925
In-Reply-To: <20230620073004.4560-1-peter.tsao@mediatek.com>
References: <20230620073004.4560-1-peter.tsao@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6245988764871891368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758569

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.33 seconds
CheckAllWarning               PASS      35.87 seconds
CheckSparse                   PASS      40.80 seconds
CheckSmatch                   PASS      110.54 seconds
BuildKernel32                 PASS      31.73 seconds
TestRunnerSetup               PASS      455.37 seconds
TestRunner_l2cap-tester       PASS      17.27 seconds
TestRunner_iso-tester         PASS      23.73 seconds
TestRunner_bnep-tester        PASS      5.69 seconds
TestRunner_mgmt-tester        PASS      117.20 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      8.48 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        PASS      7.31 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.07 seconds
IncrementalBuild              PASS      30.25 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btusb: Add support Mediatek MT7925

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B2 Line has trailing whitespace: "1. The firmware location of MT7925 will set to "
6: B2 Line has trailing whitespace: "2. Add Mediatek private data in hdev "


---
Regards,
Linux Bluetooth


--===============6245988764871891368==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1AFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiBOS1p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 13:27:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBOS1k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 13:27:40 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E76320
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 10:27:28 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id n6so18377265qvk.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xTUXSw1woJUh2Q1SMF6PXl1lRLXbkO3CWcpJD9df4N8=;
        b=ATckbbrBb7+Z4Hz0s5f3egMWdLcZRkkl5EaAUqKWmaDU7fASLbK8vEPP/sRJKTq8X7
         8RyqcCuQeg62ApmnchranGwVU6Yn2xZzjNzchdXykLokeaeCUA5HbLECB2E0wBtwV3FR
         CW71vSgdzU6tmY5NR5oOZEzP1nLiHy94EG9/ZBamoW+KUs9lwbs3teLQxFeTqk2ZWXOL
         yDTpXmaRGp6AlrA6Ff6tgF+tKnuYyi8B/fs92C4mthc/zpnGkv+v1YG9Rx/e4HYDMXM/
         MAbJEO7FHBmjbjVZzgJa8M202cX5ZxK/0E3oIBVZJIneANOe97YJahffTgx21BdqeW8R
         YAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xTUXSw1woJUh2Q1SMF6PXl1lRLXbkO3CWcpJD9df4N8=;
        b=BHBh4chA1BMNK4LOGDBvFKaiHhvZko1oXaRbGtvfG6Z478a22xGWLSFES718xU69+O
         ebTZHAPN2KMGRlf5PXICTf9XnXLJ/Jgx6f0AKIMRCeZ3C2Pekwv/gYX1KwS6/6LHxKGz
         fGq5Klb8ykhFVB+fFLyh1nn59QS9smqT4hX7lTF2MmU42hz3eRQwjL54zSicu3FCUS9I
         tXj4bPmt7/4ZBz8zPL8zGzQE9eIh7jpBb20CcOnqch2x+3C0Inko5If0MR0dt6RjqNs3
         Lj8d1F3PK4+mPGzuUeR2QouTZ8k/COZzIIDhbqqyBeCaSmbEFGAE6c3wsc0tYpLzTy5j
         q0dw==
X-Gm-Message-State: AOAM530rxBVH8MTpIId2g9hYRJTcSxKQGI3DgkTN4C5rUqX0Shxdt9OL
        j4DVwQzj6P2fYjtK2f6z69T7Q85UoGO4+g==
X-Google-Smtp-Source: ABdhPJzquk9RJzb2xHECm4A217FCNuL5eb3a9C9abBlx0QnbGaBLEqbO8YpibAAxM3YgcGz0aYAbSw==
X-Received: by 2002:a05:6214:2aa9:: with SMTP id js9mr277603qvb.121.1644949647607;
        Tue, 15 Feb 2022 10:27:27 -0800 (PST)
Received: from [172.17.0.2] ([20.98.244.202])
        by smtp.gmail.com with ESMTPSA id z23sm529477qtn.40.2022.02.15.10.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:27:27 -0800 (PST)
Message-ID: <620bf08f.1c69fb81.2f4f0.442d@mx.google.com>
Date:   Tue, 15 Feb 2022 10:27:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0158280461332362927=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gustavoars@kernel.org
Subject: RE: [next] treewide: Replace zero-length arrays with flexible-array members
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220215174743.GA878920@embeddedor>
References: <20220215174743.GA878920@embeddedor>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0158280461332362927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614633

---Test result---

Test Summary:
CheckPatch                    FAIL      11.80 seconds
GitLint                       FAIL      1.15 seconds
SubjectPrefix                 FAIL      1.05 seconds
BuildKernel                   PASS      29.82 seconds
BuildKernel32                 PASS      26.52 seconds
Incremental Build with patchesPASS      37.16 seconds
TestRunner: Setup             PASS      472.06 seconds
TestRunner: l2cap-tester      PASS      13.68 seconds
TestRunner: bnep-tester       PASS      6.12 seconds
TestRunner: mgmt-tester       PASS      101.94 seconds
TestRunner: rfcomm-tester     PASS      7.60 seconds
TestRunner: sco-tester        PASS      7.73 seconds
TestRunner: smp-tester        PASS      7.61 seconds
TestRunner: userchan-tester   PASS      6.09 seconds

Details
##############################
Test: CheckPatch - FAIL - 11.80 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[next] treewide: Replace zero-length arrays with flexible-array members\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
(next-20220214$ spatch --jobs $(getconf _NPROCESSORS_ONLN) --sp-file script.cocci --include-headers --dir . > output.patch)

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#632: FILE: drivers/net/ethernet/i825xx/sun3_82586.h:253:
+  unsigned char  mc_list[][6];  ^I/* pointer to 6 bytes entries */$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#632: FILE: drivers/net/ethernet/i825xx/sun3_82586.h:253:
+  unsigned char  mc_list[][6];  ^I/* pointer to 6 bytes entries */$

total: 0 errors, 3 warnings, 915 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12747443.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 1.15 seconds
Run gitlint with rule in .gitlint
[next] treewide: Replace zero-length arrays with flexible-array members
10: B1 Line exceeds max length (123>80): "(next-20220214$ spatch --jobs $(getconf _NPROCESSORS_ONLN) --sp-file script.cocci --include-headers --dir . > output.patch)"
29: B1 Line exceeds max length (100>80): "[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays"


##############################
Test: SubjectPrefix - FAIL - 1.05 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============0158280461332362927==--

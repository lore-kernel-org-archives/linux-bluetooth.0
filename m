Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C19CC00144
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 00:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiG0ADk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jul 2022 20:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiG0ADj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jul 2022 20:03:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981393A4A9
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 17:03:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e16so12229594qka.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pH/IUzawaT0Oi60soy0K8eouAvO3puqx8YlWTH9jpl4=;
        b=O7dB0QXoF3xW4mikfO9W85vYkoq6u5Qezw6hQEMD4703J/KNTcvmZ9hZjEC9n9MeEc
         lgiV0d/su08JjeBnHVA266D5XDY8l8uPpVugx/QByR7eGf983lEbO4fupmGwTyrhPVzt
         fsmelwEWwwagj7FTKk74daKvRaN1JCXcQ0WZoLa1zlR5eALgq6NcxOMQjhBjlNd+CVQu
         LzxiletUznW3GlHcR880FLKUaq8/R+iPu3bRO3Nsih8Y0TPiffrW9ppTeUfozxmjktCV
         SZu8zfyWoiU35TlZzMq7lO0f1GlYN4fVzDEXrxOrbsJrsCbmYb7iahrlVt0dpHtVCXRB
         AXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pH/IUzawaT0Oi60soy0K8eouAvO3puqx8YlWTH9jpl4=;
        b=B8NLXIyZllXIDIBLRp/und/4br4t1p2M3NRaoXu/ZVyJj25FhxodrlP7T3IAeLFNEY
         F8+XjqSFV5yRkpruU0P9BOpXVM0zWXuF2n7LU94F0MR2gZNpv+NJgpcS30BU+8XTgds5
         mtOQz/7Qa9E0Y6eI0HU+olg0mOkvhNzx9iXEPr+M5TjnCur4l5ZogEwCCeUkLkLktRdn
         hfp0Dw1weMWCbLKr7c2F83X8k+6vhRTLsMvAuaekkUWgOJOsg9XOB2FHTygJ7/HF5cxt
         pHOjRDzdBMNmsfIJ6jJ3q7x2AXwodt3INcJoJKQhO0fWK1OBUyF/yoAPfcbQUuQl6L09
         1UiQ==
X-Gm-Message-State: AJIora+tBmI3D/pwDdOdDdnl28CwYr21UuZZsKLeaFXejANOasTKBA0Q
        Cv7BTjO+xz+T4z3fPrsBOvzdEKkc5YM=
X-Google-Smtp-Source: AGRyM1vJvQh9Ul6TYBeHaoOJIBgrXurNbj3Z3O1KP3N8FvNFn1lFts5ZiCxHSoDpir6e5OulI6e/bw==
X-Received: by 2002:a05:620a:261a:b0:6b2:6e4d:b607 with SMTP id z26-20020a05620a261a00b006b26e4db607mr15363497qko.414.1658880216134;
        Tue, 26 Jul 2022 17:03:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.217.140])
        by smtp.gmail.com with ESMTPSA id t4-20020a37ea04000000b006b66293d79dsm4287054qkj.80.2022.07.26.17.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 17:03:35 -0700 (PDT)
Message-ID: <62e080d7.1c69fb81.343ed.dcf7@mx.google.com>
Date:   Tue, 26 Jul 2022 17:03:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4794373140156207777=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Clean-up stale/unused hci_request.c code
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220726230140.205481-2-brian.gix@intel.com>
References: <20220726230140.205481-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4794373140156207777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=663264

---Test result---

Test Summary:
CheckPatch                    FAIL      7.47 seconds
GitLint                       PASS      3.87 seconds
SubjectPrefix                 PASS      3.45 seconds
BuildKernel                   PASS      31.82 seconds
BuildKernel32                 PASS      27.62 seconds
Incremental Build with patchesPASS      68.28 seconds
TestRunner: Setup             PASS      456.12 seconds
TestRunner: l2cap-tester      PASS      16.76 seconds
TestRunner: bnep-tester       PASS      6.28 seconds
TestRunner: mgmt-tester       PASS      98.34 seconds
TestRunner: rfcomm-tester     PASS      9.62 seconds
TestRunner: sco-tester        PASS      9.38 seconds
TestRunner: smp-tester        PASS      9.51 seconds
TestRunner: userchan-tester   PASS      6.91 seconds

Details
##############################
Test: CheckPatch - FAIL - 7.47 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v3,4/4] Bluetooth: Convert SCO configure_datapath to hci_sync\CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#128: FILE: net/bluetooth/hci_conn.c:354:
+	err = __hci_cmd_sync_status(hdev, HCI_CONFIGURE_DATA_PATH,
+			      sizeof(*cmd) + vnd_len, cmd, HCI_CMD_TIMEOUT);

total: 0 errors, 0 warnings, 1 checks, 200 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12929916.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4794373140156207777==--

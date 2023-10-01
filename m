Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F2CE748ED
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 08:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjJAIjz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjJAIjy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 04:39:54 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A67A2
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Oct 2023 01:39:51 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65af72cf9e7so72492766d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Oct 2023 01:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696149591; x=1696754391; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yX3vI0A6yQAO/YlhTVTfVSt/gqZSurDfcq+f4M2Rd2E=;
        b=FrGpmPF4vNhpLg+7eD1eQrIqJWm28p1Ci39jklJAiNxe9XrRGJkHS2ZfieNsFpUpvR
         VVvYrV47BdpxJYmhHx0xvffhlzgpVvqKMlspOkBSD7C/ZYT0y64g8BeP2z/qjkO5soZE
         tZMGlmjQKVqTqt5SDQjv5RkpOIxLMOccqDdsy1J0B25ZuYWHvkK1VND2cxjjqCxQacbp
         1jzU1N4amPk7Kn3o5zcrPBveKAMtIHqGSD2gGPlqPPCkgdPmAs1XsaBrgE0DgvkTwrzO
         W+1mLZaZrWOv97psgFSoGN7Lkeghqd6D8PepkQ6YxdptoGRBODrhLMFTvu5mbL+9ch6C
         KACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696149591; x=1696754391;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yX3vI0A6yQAO/YlhTVTfVSt/gqZSurDfcq+f4M2Rd2E=;
        b=ItDSq0KKE1zUpXwo4q88hVCyeXQm9cyzF+opCqK82LRUHddkk1bEd6x3dD726+UQx1
         nadASpXtSyoUBeLur61VuPCzCU0EfwEdRXD8/OR3IeNI1mxHqEdgdRknlMpcbPPAW3s1
         mOYmK3xVab/VEVcGaCzFBTey4me7vMbYnpXcHUQLQ4rGpmsTfTBw2I776WS01NqtBHjS
         lAhKjfmUmxeapczGxU82X1UCtWiqggfgXLCuhSnlyZQCtQY5j9coLovYzbdCqDIX8Zm4
         SRpRD8XqXWqddwTQIkPOxyf5XMAbu9+/J6PVQmuTlgpD9LnXuoqFPZbWR36Wg5XXP6jg
         VSwg==
X-Gm-Message-State: AOJu0Yyqp12azMf6+tUByzreVSgr4HVPbHQBNGMu+nOjMv3vnOk/Zsn5
        YsYoSfeyYOGWJgYBSxpVrsZor0RWpPc=
X-Google-Smtp-Source: AGHT+IFtLrAnouifhHYlU5M1/A533rbwx0MBxicV63ckaMVleBQbJFWoXw+ru0lLvOIdJc/1mOvyJQ==
X-Received: by 2002:ad4:4b23:0:b0:64f:6e53:4e17 with SMTP id s3-20020ad44b23000000b0064f6e534e17mr7737627qvw.16.1696149590690;
        Sun, 01 Oct 2023 01:39:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.41.204])
        by smtp.gmail.com with ESMTPSA id o8-20020a0cf4c8000000b0065b260eafd9sm4355638qvm.87.2023.10.01.01.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:39:50 -0700 (PDT)
Message-ID: <65193056.0c0a0220.8bb55.174a@mx.google.com>
Date:   Sun, 01 Oct 2023 01:39:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8580333294291801067=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jlee@suse.com
Subject: RE: Bluetooth: ignore NULL link key and reject connection with the device which has same BD_ADDR
In-Reply-To: <20231001081046.GA14551@linux-691t>
References: <20231001081046.GA14551@linux-691t>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8580333294291801067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789095

---Test result---

Test Summary:
CheckPatch                    FAIL      1.88 seconds
GitLint                       PASS      0.71 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      36.22 seconds
CheckAllWarning               PASS      38.57 seconds
CheckSparse                   WARNING   44.78 seconds
CheckSmatch                   WARNING   117.53 seconds
BuildKernel32                 PASS      34.05 seconds
TestRunnerSetup               PASS      513.44 seconds
TestRunner_l2cap-tester       PASS      31.39 seconds
TestRunner_iso-tester         PASS      61.14 seconds
TestRunner_bnep-tester        PASS      10.66 seconds
TestRunner_mgmt-tester        PASS      229.05 seconds
TestRunner_rfcomm-tester      PASS      16.26 seconds
TestRunner_sco-tester         PASS      19.68 seconds
TestRunner_ioctl-tester       PASS      18.55 seconds
TestRunner_mesh-tester        PASS      13.47 seconds
TestRunner_smp-tester         PASS      14.49 seconds
TestRunner_userchan-tester    PASS      11.19 seconds
IncrementalBuild              PASS      39.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[2/2] Bluetooth: Reject connection with the device which has same BD_ADDR
ERROR: that open brace { should be on the previous line
#144: FILE: net/bluetooth/hci_conn.c:1615:
+	if (!bacmp(&hdev->bdaddr, dst))
+	{

ERROR: that open brace { should be on the previous line
#162: FILE: net/bluetooth/hci_event.c:3272:
+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))
+	{

WARNING: line length of 108 exceeds 100 columns
#164: FILE: net/bluetooth/hci_event.c:3274:
+		bt_dev_dbg(hdev, "Reject connection from the device with same BD_ADDR %pMR\n", &ev->bdaddr);

total: 2 errors, 1 warnings, 0 checks, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13405302.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============8580333294291801067==--

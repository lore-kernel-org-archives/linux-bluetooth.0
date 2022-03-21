Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2466CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 02:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbiCUCgG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 22:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbiCUCgF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 22:36:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6F81CFFC
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 19:34:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i11so10843519plr.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 19:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DJlluC2RruzPM6js4ZTrwSPcNFy0ZXwiDFNqmZe6QgM=;
        b=QdS5URNUpxURPH66wTDdSqnWYNlZ4xWBl+4iY4wzVNNv7Q52MY04/JGYGilZ2Zioy5
         zk2lnuxELK+TPVj4BDKmLQGwA8Cu/qD/WGuJIlpiMhv5p8YTaba1t5vs2kHs37TWw2ZH
         jQNPaPKaweLCxB4aijW7Q/ddIBER/MDL9gx0EEt0zP7T/cCCkoH3fmuJsMRrIYl4IbsB
         NmWTRsPIYGMV/SLzGEAPmDuz7xHLoJrlOV0ZXw+XqnYCDodA6vgwjTdszoFzQgGbsi2/
         852jYV+PTsplKkhR8kIwwfS9y0+uDkBwwuytuYZUaa+ilsDWjGmMRWwNP4W1PQbv6qIW
         fNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DJlluC2RruzPM6js4ZTrwSPcNFy0ZXwiDFNqmZe6QgM=;
        b=DJIk6gPW6M1MQGsPg+JG7dEDffuUd8R5Mkc0EO9ZGdYwVCGW/JVRNiURtDIom3evPW
         G7sLXRQPWzHUECFo+kEcmJZijQyD8vkYVTN0ux18CwQ8dVO1M0zhCFSFcLMpGhRwswm5
         GApyXaaSmzMy/AomSnD5VVg0oHU2wzPNaC1GnsqqSrvv1kNFQTUpJ0UaJ+JU+w/zrj5M
         0jf4+ndLwk9cChcLFORIxQ/SIXx1jrDrV6aaUds5dDNICSTLvl4VWC1WYO3+wRHhH5VO
         OZv9GtHz1QnXLKIJD9y27G3MeINRT3/g/J7ObvaYhayZdIBuAcEPxZj4e+ckrFoahQbz
         Q0GQ==
X-Gm-Message-State: AOAM533EQbNoMztOagRCxUsSG3wJQ4736XqLrswh688pJn27GZlivLZP
        a3MQg8qskbdRH1rqXaPBpkj7vE3XOdE=
X-Google-Smtp-Source: ABdhPJzDyQ9PzQBH67zC/hVIGxJkaFiYbcPUMULvt8/yJzMV7XfmZjfOy1VzIOzlHsB/ytIzmHQYjA==
X-Received: by 2002:a17:902:c401:b0:154:152a:7fb7 with SMTP id k1-20020a170902c40100b00154152a7fb7mr11028559plk.63.1647830080096;
        Sun, 20 Mar 2022 19:34:40 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.67.32])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090a178c00b001bd036e11fdsm18146053pja.42.2022.03.20.19.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 19:34:39 -0700 (PDT)
Message-ID: <6237e43f.1c69fb81.3014f.20cf@mx.google.com>
Date:   Sun, 20 Mar 2022 19:34:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4948809323235963772=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [1/2] Bluetooth: Add support for devcoredump
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220320183225.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
References: <20220320183225.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4948809323235963772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=624997

---Test result---

Test Summary:
CheckPatch                    FAIL      1.78 seconds
GitLint                       PASS      0.89 seconds
SubjectPrefix                 PASS      0.64 seconds
BuildKernel                   PASS      38.17 seconds
BuildKernel32                 PASS      33.98 seconds
Incremental Build with patchesPASS      53.60 seconds
TestRunner: Setup             PASS      594.46 seconds
TestRunner: l2cap-tester      PASS      18.39 seconds
TestRunner: bnep-tester       PASS      7.43 seconds
TestRunner: mgmt-tester       PASS      125.35 seconds
TestRunner: rfcomm-tester     PASS      9.63 seconds
TestRunner: sco-tester        PASS      9.35 seconds
TestRunner: smp-tester        PASS      9.48 seconds
TestRunner: userchan-tester   PASS      7.82 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.78 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[1/2] Bluetooth: Add support for devcoredump\WARNING:SPLIT_STRING: quoted string split across lines
#498: FILE: net/bluetooth/hci_core.c:2696:
+				    "Devcoredump complete with size %u "
+				    "(expect %u)",

WARNING:SPLIT_STRING: quoted string split across lines
#517: FILE: net/bluetooth/hci_core.c:2715:
+				    "Devcoredump aborted with size %u "
+				    "(expect %u)",

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#598: FILE: net/bluetooth/hci_core.c:2796:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump init");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#641: FILE: net/bluetooth/hci_core.c:2839:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump pattern");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#667: FILE: net/bluetooth/hci_core.c:2865:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump complete");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#689: FILE: net/bluetooth/hci_core.c:2887:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump abort");

total: 0 errors, 6 warnings, 0 checks, 599 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12786731.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4948809323235963772==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915FC77B73
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Apr 2023 17:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjD3R5C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Apr 2023 13:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjD3R5B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Apr 2023 13:57:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F910E7
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 10:57:00 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-61b2f654b54so1239246d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682877419; x=1685469419;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xNzgd2JfXQiyPxJgLYOA0xXLi2Z0X9mvxb+nUSFD5DQ=;
        b=B3ayR7wP/y33Zw42JAeVMF+kErACna2wDDA1MPB/TsH83y15KSpQILWUulOciturJC
         wgo5zPDMkRf9lB3jXe/hr9P3TB5MZGOFkpo75XdJCQonlyp/trxTceDHspJQPRPDS5vh
         IQ7Ujbj/dsEY2egtb10bCnQx/shVrzda4cehbLqpm8ooI7jch1Um3XkkaU0DcMA3YsAd
         hDkhJbF87aHrL8W9Yezeb7Go5HXiKPnIrj4a1bWXcag/uenlYULNUb8deS5mYdMZ2vfY
         O9o9h6QyZTrEbHPFhFWOY27XGwHg/7hMVZrZkbTCdm1C48jGUfhggsnUjc4IJqS5waD6
         EFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682877419; x=1685469419;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNzgd2JfXQiyPxJgLYOA0xXLi2Z0X9mvxb+nUSFD5DQ=;
        b=g1NtkkyLE7gUIaA7QDxZ4CMpsM6ZqKKU/Inhg8w3v+t2AU1egQGpJqg0pc38/r0aqL
         3L96dZbCHIPYNx5e/ph8B/Ab+CX6uM5Jl+aCULWfaKcGYoweAHN4yn3geRwWOM6pbmL7
         q7pzUznVOUdPgadw3CCzsDBbtf2qIG9nGMAZ6n2O6rcSGM+0rOeqgoPiwToZSbuV8V5U
         iN2vulj4aCvklMnUkARlTivt7tyS3x7MoOrPr2R8cZJOpuMCU69QfWT5/9KOMW205w63
         UKvM/YimhzKL6YsadOg7NTdvwt1VnLriqRQxFyzTdd5EIklT6FqOgAHK1giXIUBAuy4r
         hk+Q==
X-Gm-Message-State: AC+VfDwqaRQzE8CurtqLKLCGK3iDQzoFbWM7fxJzK8LI80tv468jo4gM
        swaTE1CW+GCmQTAZfdsnoMO222mCucg=
X-Google-Smtp-Source: ACHHUZ7oAPWds5EjJGShOOF/tEegEmPjmNuZtBApw6jweCIeZLncaHQJExIINq1bGogNcmxVhxJovw==
X-Received: by 2002:ad4:5dc2:0:b0:61a:d6af:cb00 with SMTP id m2-20020ad45dc2000000b0061ad6afcb00mr1898397qvh.9.1682877419326;
        Sun, 30 Apr 2023 10:56:59 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.48])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cedca000000b005ef493c6bebsm8017678qvr.77.2023.04.30.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 10:56:59 -0700 (PDT)
Message-ID: <644eabeb.0c0a0220.1245d.fc0b@mx.google.com>
Date:   Sun, 30 Apr 2023 10:56:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5742443708805543211=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lrh2000@pku.edu.cn
Subject: RE: Bluetooth: Fix UAF in hci_conn_hash_flush again
In-Reply-To: <20230430171847.156825-1-lrh2000@pku.edu.cn>
References: <20230430171847.156825-1-lrh2000@pku.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5742443708805543211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744073

---Test result---

Test Summary:
CheckPatch                    FAIL      1.12 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.06 seconds
CheckAllWarning               PASS      34.74 seconds
CheckSparse                   PASS      39.61 seconds
CheckSmatch                   PASS      108.27 seconds
BuildKernel32                 PASS      31.25 seconds
TestRunnerSetup               PASS      442.52 seconds
TestRunner_l2cap-tester       PASS      16.91 seconds
TestRunner_iso-tester         PASS      21.38 seconds
TestRunner_bnep-tester        PASS      5.63 seconds
TestRunner_mgmt-tester        PASS      116.50 seconds
TestRunner_rfcomm-tester      PASS      9.06 seconds
TestRunner_sco-tester         PASS      8.31 seconds
TestRunner_ioctl-tester       PASS      9.75 seconds
TestRunner_mesh-tester        PASS      7.21 seconds
TestRunner_smp-tester         PASS      8.15 seconds
TestRunner_userchan-tester    PASS      5.94 seconds
IncrementalBuild              PASS      29.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Fix UAF in hci_conn_hash_flush again
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#92: 
Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8bb72f86fc823817bc5d

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#93: 
Closes: https://syzkaller.appspot.com/bug?extid=8bb72f86fc823817bc5d

CHECK: Alignment should match open parenthesis
#163: FILE: net/bluetooth/hci_conn.c:2473:
+	while ((conn = list_first_entry_or_null(head,
+				struct hci_conn, list)) != NULL) {

total: 0 errors, 2 warnings, 1 checks, 57 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13227257.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5742443708805543211==--

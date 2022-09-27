Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265B7C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Sep 2022 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiI0VKK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 17:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiI0VKJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 17:10:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2171C6A40
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 14:10:08 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id v1so5756504ilq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=JJigQu9zjnijBJJPdoADdZKVkwl+vwGwqtbR0HwRFlQ=;
        b=K4aX1Oai3MT9h+rzwnNt8I+WOkC8EysP5s/eVfhrD0Ob4XWIrIORPhKEMPteYWk7NC
         cxhbMk1jVDwJgxRylR1G4ErGh5d2cpcbrtl0URO0FO52+KQSmNFiV4ajMvfxoQKUMYaG
         HxM/0Sjj6g5t5Mv8Cs2k83dx5DGIZHnNd8ZofmoY8DtWJAkYhmI9nsDmH/JrG5qaUyp1
         pUsWSFAOcL5d98y5r92MtIBYOjF0kutF4Xour6ctOmaaC+DdeL1FbRGTSTLoYG+jPzRD
         Ce95nrBu5COvZXq5BQDWAi9DDLguNlaSEYSce2zslWhksn7N+mZSuglDICdraGgqNB4w
         pIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=JJigQu9zjnijBJJPdoADdZKVkwl+vwGwqtbR0HwRFlQ=;
        b=7JYekLWmVRR2NaXlmR4mZjySJ486GmVUWsvE8cZihZ48Ok8oKP3+/ZVf4qyvGd4eHX
         5UoDZW7pgQX+mQlYQ+6f3v7uEHigfyrFyCNCxx6as7OEKyNznN3jprBNlr5idI6Xgc6Y
         7n7LIiKCEKK4wgmEFnsCUNEBGaUskO+mAFPdYQh3XrzXwEWycO1+32NVyO04eSWGXvmY
         3ewlP+eOWmE0NhHpiXeu537fJnLnPXWvI2F2MQxbF92CQRDnPrtwTbl11Q32QTUW1gjI
         ZI2b/U40jflPPiBLlie1QVMbmHMG4QkOVWwJSmsFonTBmctGJ88Fye3kaW4t5lB6uGL2
         xqeg==
X-Gm-Message-State: ACrzQf2wSXiLI6DftwweQqJvHLQQdT1npDwL4YXprzhcp6UAoDUfa9Eg
        oXSSyTeHq/w66NFNEKPCSRivEFGZ3FU=
X-Google-Smtp-Source: AMsMyM5NF5a0saRhZfUNj+ROFVJFvq5VzExyFCcZAz1DEusutjE+QHzmcK2q/Q0UGXgxsEvKAfFsHw==
X-Received: by 2002:a05:6e02:1645:b0:2f8:3545:5470 with SMTP id v5-20020a056e02164500b002f835455470mr7504776ilu.245.1664313007457;
        Tue, 27 Sep 2022 14:10:07 -0700 (PDT)
Received: from [172.17.0.2] ([40.69.174.250])
        by smtp.gmail.com with ESMTPSA id n1-20020a056638264100b0034af3f3f9c0sm1008656jat.118.2022.09.27.14.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:10:07 -0700 (PDT)
Message-ID: <633366af.050a0220.7368c.14ee@mx.google.com>
Date:   Tue, 27 Sep 2022 14:10:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5847527822593035103=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@google.com
Subject: RE: [v3] Bluetooth: Call shutdown for HCI_USER_CHANNEL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220927131717.v3.1.Ic8eabc8ed89a07c3d52726dd017539069faac6c4@changeid>
References: <20220927131717.v3.1.Ic8eabc8ed89a07c3d52726dd017539069faac6c4@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5847527822593035103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681203

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      0.80 seconds
SubjectPrefix                 PASS      0.65 seconds
BuildKernel                   PASS      33.70 seconds
BuildKernel32                 PASS      29.38 seconds
Incremental Build with patchesPASS      42.26 seconds
TestRunner: Setup             PASS      498.42 seconds
TestRunner: l2cap-tester      PASS      16.50 seconds
TestRunner: iso-tester        PASS      15.38 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      99.33 seconds
TestRunner: rfcomm-tester     PASS      9.83 seconds
TestRunner: sco-tester        PASS      9.19 seconds
TestRunner: ioctl-tester      PASS      10.31 seconds
TestRunner: smp-tester        PASS      9.30 seconds
TestRunner: userchan-tester   PASS      6.28 seconds



---
Regards,
Linux Bluetooth


--===============5847527822593035103==--

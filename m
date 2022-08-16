Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24E4C25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 19:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiHPT5U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiHPT5T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 15:57:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE67968F
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 12:57:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pm17so10630442pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=kfemwrC7j1v4hOO/3y7udB7GvD72hiY7kp/zR6EMsYk=;
        b=JhfhKhKBSfNgx9uzMoCtItg9xFj0fpelyC8gbiTJytoOLiW4UpNJDvahEThJ1k7JQa
         fzPWULRmKjvCuGQOl9M/u+bozkQ7iILxDdQ58OL04oG+ZLtDpk6koXQUcfPN0YLyphTd
         iuEOP4XH8f7ghDsNx8Yh8IV6ExQFGzAtu4vTuA8E0qbPaLEpy/5IrAwKNWZQp4L9DsUg
         fW6dkK8+jE+RdGyYxUnDjy2n+sOzkBcxEcCETvCg+3ccE/EdmXrvnyKu2rcMnKmMoXBy
         jF9zVFivgvkw6tvRYnr2sfbz6zjOsflmVWPeJY+mQQZZmmutnvVeo80jf2nTZp3CtTAf
         zp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=kfemwrC7j1v4hOO/3y7udB7GvD72hiY7kp/zR6EMsYk=;
        b=e1Jd3e3RLt0rrZWV5Xw4DmdbvXRBGQXqMTtvycS9oBfv0rnvQETbGJ39sUI+Y8iUHa
         XqAEhrIEwiG9SDu2vO9MO7KUS63OCu1A4OmgKxHok3K3EtksOTAnv3kPU9nEXa0RJR54
         50sDJm0gN2Hs2vNwQPdGhrXn9HY5lzDFEpgtuAbDr809Cq0k6gKMwKYcRzwjwWmf0t0K
         bgI36egCU5TEnBWfKMwAvVv1t/TzsTF/FaTNsGYW217z4WSinwHOvq/G2IPC4n+fHuVs
         8uAyQD993QWbyDbmZKUnipcAt+1s3WAiydo6ypjJU8uW6ZQa2E+Sx9V9N1ntpmttSeqj
         VnUw==
X-Gm-Message-State: ACgBeo29H2peFup9D/40Zw0CbFhTrzxGfGR1yk0SEVJ2rax+mMUfw00q
        8Vjj2eHaWwnrJNw8cmTfFjpJYh3ZVJw=
X-Google-Smtp-Source: AA6agR7YVQMEq+3fIfyWyFAWXBX8Ub9HS1Kf+D+Bgjm1/BbAb6WEM6GpS9x4CVlaCctp+MkP+RRRbw==
X-Received: by 2002:a17:90b:4b4d:b0:1f5:164f:f7c4 with SMTP id mi13-20020a17090b4b4d00b001f5164ff7c4mr173619pjb.131.1660679837539;
        Tue, 16 Aug 2022 12:57:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.39.74])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b00170a757a191sm9429591plc.9.2022.08.16.12.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 12:57:17 -0700 (PDT)
Message-ID: <62fbf69d.170a0220.6d6fe.0694@mx.google.com>
Date:   Tue, 16 Aug 2022 12:57:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0386460699140205580=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [v2] Bluetooth: Normalize HCI_OP_READ_ENC_KEY_SIZE cmdcmplt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220816190434.1015206-1-brian.gix@intel.com>
References: <20220816190434.1015206-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0386460699140205580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=668188

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.52 seconds
SubjectPrefix                 PASS      0.41 seconds
BuildKernel                   PASS      33.60 seconds
BuildKernel32                 PASS      28.72 seconds
Incremental Build with patchesPASS      42.98 seconds
TestRunner: Setup             PASS      480.55 seconds
TestRunner: l2cap-tester      PASS      16.85 seconds
TestRunner: bnep-tester       PASS      6.16 seconds
TestRunner: mgmt-tester       PASS      101.20 seconds
TestRunner: rfcomm-tester     PASS      9.36 seconds
TestRunner: sco-tester        PASS      9.16 seconds
TestRunner: smp-tester        PASS      9.20 seconds
TestRunner: userchan-tester   PASS      6.27 seconds



---
Regards,
Linux Bluetooth


--===============0386460699140205580==--

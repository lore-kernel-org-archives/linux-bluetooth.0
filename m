Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0658DC25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 17:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiHPRWO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiHPRWM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 13:22:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB57C31B
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 10:22:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c24so9805242pgg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=yilSjJLKfDc2RBviADcJ56u+OdHPYsHuXZYA3705Or4=;
        b=hDbDvDqWfH4S8EmVE4xW7R/8A51AKYHCDuQACfsXrh94WP19yq7X93lPHziJoARn9j
         QIW1IDLxROxvgS+/RLXmU52jkrp6olOSkEWX7pXlBVo03UvMxolZWJ6SBpsDs8MeilQd
         o15OZV8aep9FnaRovdnVNCTSUdlvSyl90htMP41RR0MJOGanxrnZ+5jA2OSVLec9z+P3
         RIsvg2BdVp/p0G/VBoTwaQbdJGY4Nt2LFK7ykz+Ssq+UscAs66q5upoQCGVgy+2vj41y
         LHF8q/cdbz/O0A2nA1W8THIXpD1q89mA+IWnKg7cRAl1Rz5Z7EhEZQsugJzs1M5GrlqF
         Jhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=yilSjJLKfDc2RBviADcJ56u+OdHPYsHuXZYA3705Or4=;
        b=snwfAVqOTDUK9ljLMR342pRRPrsXyeCz/PP9+4Bjv3Kx8Kzob/AqHiiRqybhXB9kwz
         7zbLLO2QA3v2IgFXPOEUSQiIKLu8b3FoyjnxHGmCk193+JGJTisTTtTcEw94ofvjV1rx
         tfUXMRrJAqcBXzWTYB43oOJ+ih8i770k8tyW9oMhM2S4qD2yzEmjs1Vh+01BDPfwtsq4
         8/NTPHWbyLj66849ymG1tgvnQVAjPCagcWimHznmVlslD4c8vqMjMATEsXjvjIGtts+1
         mVL1DnbMsp2sUO2kiR3HzfaB5JScDU7GYfddgVRyBtX0FLNv8bdUzGvhtKg/U8EdhZNA
         2gWA==
X-Gm-Message-State: ACgBeo2fZXcuwdUSlDrERIz9xn1X5Y2C/PfjVK1hvTCP51XgYvdRM4dg
        hhKI5fMcvvtjocjqLiFHnfCywq0QWBs=
X-Google-Smtp-Source: AA6agR4M+nxsLm+wqPEeOJ1I4OzZWtf0wpliXrU4iKRdT3ZnV/9lwSYlxe77JxxHGLVyUwAOsMeHzw==
X-Received: by 2002:a65:4388:0:b0:41b:c071:d21f with SMTP id m8-20020a654388000000b0041bc071d21fmr18388726pgp.335.1660670529697;
        Tue, 16 Aug 2022 10:22:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.237.201.91])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b0016f196209c9sm9284494plk.123.2022.08.16.10.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:22:09 -0700 (PDT)
Message-ID: <62fbd241.170a0220.f9b89.049b@mx.google.com>
Date:   Tue, 16 Aug 2022 10:22:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5295032956141891725=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Bluetooth: Normalize HCI_OP_READ_ENC_KEY_SIZE cmdcmplt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220816161756.997539-1-brian.gix@intel.com>
References: <20220816161756.997539-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5295032956141891725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=668138

---Test result---

Test Summary:
CheckPatch                    FAIL      0.92 seconds
GitLint                       PASS      0.43 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      39.92 seconds
BuildKernel32                 PASS      35.01 seconds
Incremental Build with patchesPASS      52.28 seconds
TestRunner: Setup             PASS      590.70 seconds
TestRunner: l2cap-tester      PASS      19.47 seconds
TestRunner: bnep-tester       PASS      7.61 seconds
TestRunner: mgmt-tester       PASS      117.62 seconds
TestRunner: rfcomm-tester     PASS      11.30 seconds
TestRunner: sco-tester        PASS      11.11 seconds
TestRunner: smp-tester        PASS      11.08 seconds
TestRunner: userchan-tester   PASS      7.83 seconds

Details
##############################
Test: CheckPatch - FAIL - 0.92 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: Normalize HCI_OP_READ_ENC_KEY_SIZE cmdcmplt\CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#82: FILE: net/bluetooth/hci_event.c:716:
+static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
+				     struct sk_buff *skb)

total: 0 errors, 0 warnings, 1 checks, 123 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12945071.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5295032956141891725==--

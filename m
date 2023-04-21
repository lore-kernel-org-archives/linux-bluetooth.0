Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A70EC77B76
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 19:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDUTay (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDUTax (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Apr 2023 15:30:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2647E55
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 12:30:51 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-329627dabfbso25625495ab.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682105451; x=1684697451;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YQaUHJER2IiKOsJJdMiR4c/nSvTFupR508mSr25wUHw=;
        b=Ek+PKRqDDl1qa5LyMsDOW3/IJrfVqp1qcRljorvkbkmPuR4mJ1ZaCZR/EmAo2wk7Me
         NSk5YDDa9NmCIg9LgrO85aSbl2PTcPkqRxE57i+GXyZrGUXxoq7cmpHBxPnDcO7nZ8ty
         YoFcuj0o+9+el7S1KdjcRVZPZRgMc1lojq08RBilixh6o3YG3hctUA372+cE0FR109K+
         Tgi1rnZvhsdnNjorIhXG9FELADvsKA5Hq/LGl594DtHETB2wnXHKq73dZBNxlxiN6Cvo
         Cha0r4gQYBL78NIQ45pUIm1ErSQQu96OObIHRkxTFRixxj41keOEtCXTUJU7h/rmpPlW
         AFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682105451; x=1684697451;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQaUHJER2IiKOsJJdMiR4c/nSvTFupR508mSr25wUHw=;
        b=koFtucr46vgZOdItbrFpRQ3D+bICEpIb/6p0CYJbMTDlmCYAeS2VcqdpA2FDIuNGE7
         R+7+Wm/1rmvEHQ8UrQ+mszUseUOeHeKSLhAk77lK01M44/btGDzx238DLyxTD4SU1vLJ
         hXG34pEsyvEpMBHxs+wbjGQ4knfk4F704auwbrhPn0kEkBpIwOF2TGVka+ROq4U6bUrv
         zHrubzJPFf8YdsViBE2ZnDbpCCt+uaeFq1IGTqy3KWXQA9GVZfWObQR3Mor7wMbJflbI
         A7htSWKLofexg2CkrAIu3oEjXR4mKh51Aovoe+7mf5ufkWZdq0eq00mXK/XOpdhKMuzA
         OhCw==
X-Gm-Message-State: AAQBX9eVSiHGg7B8y2bJ0ta8YxmwZ1BC//WTy2hLaefNR0XBjZyhGmWf
        NFxiM/SNi0hhhn/9BpRlLlkpv4OFHEk=
X-Google-Smtp-Source: AKy350b4g5WcqT8BYWU1celp8tONXDd6aKeOwrqaBTtC4qoAkSqb0+2yPdseGQePxUxGlQKnXEqkvw==
X-Received: by 2002:a05:6e02:1b8d:b0:326:5b1b:3cc5 with SMTP id h13-20020a056e021b8d00b003265b1b3cc5mr6120312ili.15.1682105450839;
        Fri, 21 Apr 2023 12:30:50 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.22.120])
        by smtp.gmail.com with ESMTPSA id v4-20020a02b084000000b0040fc56ad9fasm1441525jah.9.2023.04.21.12.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:30:50 -0700 (PDT)
Message-ID: <6442e46a.020a0220.5a6ba.1a2f@mx.google.com>
Date:   Fri, 21 Apr 2023 12:30:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7385235916979823367=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running
In-Reply-To: <20230421184716.2846319-1-luiz.dentz@gmail.com>
References: <20230421184716.2846319-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7385235916979823367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=742262

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.75 seconds
CheckAllWarning               PASS      34.68 seconds
CheckSparse                   PASS      39.60 seconds
CheckSmatch                   PASS      108.36 seconds
BuildKernel32                 PASS      30.84 seconds
TestRunnerSetup               PASS      438.72 seconds
TestRunner_l2cap-tester       PASS      16.88 seconds
TestRunner_iso-tester         PASS      21.10 seconds
TestRunner_bnep-tester        PASS      5.55 seconds
TestRunner_mgmt-tester        PASS      114.61 seconds
TestRunner_rfcomm-tester      PASS      8.81 seconds
TestRunner_sco-tester         PASS      8.22 seconds
TestRunner_ioctl-tester       PASS      9.61 seconds
TestRunner_mesh-tester        PASS      7.03 seconds
TestRunner_smp-tester         PASS      8.10 seconds
TestRunner_userchan-tester    PASS      5.85 seconds
IncrementalBuild              PASS      29.47 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (101>80): "Link: https://lore.kernel.org/all/CAB4PzUpDMvdc8j2MdeSAy1KkAE-D3woprCwAdYWeOc-3v3c9Sw@mail.gmail.com/"


---
Regards,
Linux Bluetooth


--===============7385235916979823367==--

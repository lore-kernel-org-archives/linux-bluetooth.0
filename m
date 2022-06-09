Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E0FC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jun 2022 09:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiFIJNy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiFIJNx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 05:13:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB41817E25
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 02:13:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gd1so20860542pjb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jun 2022 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=z9m+EYe51qVLFSP7vogAQQfskFMBMsZU14E5ewnrU08=;
        b=HyfGIpufi6oInzoqK04tg0tb8Zf8lx1+5wVnVRBZCEJS3TaS3tLt9cQ4K1ft9IjNt7
         aHswqzrPW02UKNUFoNkKb84n27jeFBCAbj9nRDBopxiOr/f+Uo/sDUdZJ++Q3YpBlAq3
         LFu/1JSYONC+1aBi3W53Zi3rJAogOrGen5KrrcatQ5BHkGiTsxDfsQ1dGb7ZfznNDuMG
         eiG6IMWUJtDBbftCpzj4O7B9Jad91gmsYwR6TW1DIGlvNtmyPBjhUDDH9NBLfutGSXbv
         O5J6Ov2o62Qc9LcjkOrp1n6kXWBiQY+ziNOZOZed948Tey4bB+sgTvDqHef4NUywW/PX
         bndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=z9m+EYe51qVLFSP7vogAQQfskFMBMsZU14E5ewnrU08=;
        b=E0lhUtFDFEiSeonm/O/xPuiKVqcfiQIemynNtW5n/1krEEqgshCtQPN+O/S2HIc/9l
         Yo7I64AOipdkPojpzkW+G3ucfivhc7P22yNbwAbNX8iLM9M0H6ssg1ElYWhgzN9P1kM+
         7vdeynYrf7/0XRa/T8XGAr+eC5EgpkMCRJqsHqpxNyPBiKjbwTLmhOtbde6wt/F6Ik7z
         6tKnwmnYmbF1Wy4J1M6isbK33Qr+WdbdNed5dGESg7VhOMYj0Iat3GScLAcFdP2sVHrW
         lTFc232ZViCJjdjIsH4lYCwxeibHgUeK2U88UawARPcKgH3pvtLWH5dGjvHF/bLZp1Ix
         kNsw==
X-Gm-Message-State: AOAM533YKtxaF8fVwkbYb8KReqjUeSbGRmRVoSXiBJlKv2gec5WFWRUc
        CdYC60g5uZp3iMS0RlFhDUKMmuWFIjI=
X-Google-Smtp-Source: ABdhPJzGL0dTNfxg3S9GjU5e3F809KcXxWv0tHi5uZxJ7XkaOjjoigJGaeXIbzvwAgsfr1RFZSoKiw==
X-Received: by 2002:a17:90a:bf94:b0:1e2:e640:37dd with SMTP id d20-20020a17090abf9400b001e2e64037ddmr2458575pjs.169.1654766027231;
        Thu, 09 Jun 2022 02:13:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.136.18])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090ac50200b001e891958e02sm6856604pjt.14.2022.06.09.02.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:13:46 -0700 (PDT)
Message-ID: <62a1b9ca.1c69fb81.a5925.bc5e@mx.google.com>
Date:   Thu, 09 Jun 2022 02:13:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1811118907622629131=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix set up CVSD SCO failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1654763558-20721-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1654763558-20721-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1811118907622629131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=648751

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      36.73 seconds
BuildKernel32                 PASS      33.49 seconds
Incremental Build with patchesPASS      46.01 seconds
TestRunner: Setup             PASS      551.49 seconds
TestRunner: l2cap-tester      PASS      19.15 seconds
TestRunner: bnep-tester       PASS      6.94 seconds
TestRunner: mgmt-tester       PASS      113.43 seconds
TestRunner: rfcomm-tester     PASS      10.77 seconds
TestRunner: sco-tester        PASS      10.46 seconds
TestRunner: smp-tester        PASS      10.58 seconds
TestRunner: userchan-tester   PASS      7.26 seconds



---
Regards,
Linux Bluetooth


--===============1811118907622629131==--

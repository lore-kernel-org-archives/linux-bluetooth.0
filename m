Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBC7C636CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 12:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjBMMn0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 07:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBMMn0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 07:43:26 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EC046A3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 04:43:25 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id q13so13512137qtx.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wYvt2lwZfas0BcXO0bcFeuOAVbTtgzGm3ZAG5BxBXhc=;
        b=qe8cfVftLcMFN4GeiTB5uNHg9nClf022cRZOGQWuFzwPxduxDDxwRWQ0IlSaYxAEdb
         BA8330eZYigS8yRX/SF6A9oNmzusjA/Ea5U0Gxkobt0JAkZd1EVSm3nkk8KgCl6kCK2M
         Kb1J9phzMH5PO8mm8oJDUVa4wrQojm32EHJB5E4L9IjlQqKM4m0gdqq/ARUNKdB0lnqA
         ZNLjUWONAS5gq/BvJvvktgs4c4rKW4A61s1RvWVQvrx3l6ZsTt4mCPMhIhMMZJCVj3iX
         LwVriKc1zNXQ8+mCy+0RnU2SHIQoMcKnlJ8NsPiy22vxEEEdceQ1Aw4o9uHkmYQnAAKD
         KyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYvt2lwZfas0BcXO0bcFeuOAVbTtgzGm3ZAG5BxBXhc=;
        b=xy6JFVQ6VJSLVP1JdGk7vuZ6LHG85mC39jT5Rf5Iq7EYRwMWvuQP2JBpbpNWtZp8iJ
         mQaetcQUtGgpWPn7JBx6avtHa2FNcNfxsmPAfPQvMkXJYpIlaVMuhMijmvLwsBcEmn3A
         jxqCjXwE7Jj6UqMir48/tYNfgblopXRqpzUTPgssb6WdhT7ELDfx0i7B+e1YpcbjqP8d
         +ufnFeOqCBEBeXLfW9NDymCeAuQiT+OicWVdJjQrFlgxJtoE/q8A3f9+i2+mpVKSJgJY
         4VfB/60OZBe+08seUcWCduvBcPsB6k4hPnj3ou5alVpigoahSsCFBWjwATJMxq2hQBwP
         Eggg==
X-Gm-Message-State: AO0yUKUweEFRqPT9ttab1+tFemBCpoF0sZNkyJX59HtM0V4hamnaYqAk
        ZhqaAKzvqSas7ZtiSf0wF4gVpaOu7Y8=
X-Google-Smtp-Source: AK7set8JWHHjUck6tqh3iIs9Xc5yM0+aWUINfK/HbG1chkXdfqNwd0DeTHams75QTprl/6fxqNkuXw==
X-Received: by 2002:ac8:5f8b:0:b0:3b9:e4cf:ce2d with SMTP id j11-20020ac85f8b000000b003b9e4cfce2dmr29936622qta.16.1676292204144;
        Mon, 13 Feb 2023 04:43:24 -0800 (PST)
Received: from [172.17.0.2] ([172.177.255.82])
        by smtp.gmail.com with ESMTPSA id k9-20020ac84789000000b003b2d890752dsm9114931qtq.88.2023.02.13.04.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:43:23 -0800 (PST)
Message-ID: <63ea306b.c80a0220.353fb.83dc@mx.google.com>
Date:   Mon, 13 Feb 2023 04:43:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3570506606243273608=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, francesco@dolcini.it
Subject: RE: Bluetooth: hci_mrvl: Add serdev support for 88W8997
In-Reply-To: <20230213120926.8166-2-francesco@dolcini.it>
References: <20230213120926.8166-2-francesco@dolcini.it>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3570506606243273608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721269

---Test result---

Test Summary:
CheckPatch                    PASS      2.69 seconds
GitLint                       PASS      1.29 seconds
SubjectPrefix                 FAIL      0.80 seconds
BuildKernel                   PASS      31.32 seconds
CheckAllWarning               PASS      34.87 seconds
CheckSparse                   WARNING   39.45 seconds
CheckSmatch                   PASS      108.71 seconds
BuildKernel32                 PASS      30.45 seconds
TestRunnerSetup               PASS      436.43 seconds
TestRunner_l2cap-tester       PASS      15.89 seconds
TestRunner_iso-tester         PASS      16.65 seconds
TestRunner_bnep-tester        PASS      5.40 seconds
TestRunner_mgmt-tester        PASS      108.06 seconds
TestRunner_rfcomm-tester      PASS      8.60 seconds
TestRunner_sco-tester         PASS      7.90 seconds
TestRunner_ioctl-tester       PASS      9.22 seconds
TestRunner_mesh-tester        PASS      6.85 seconds
TestRunner_smp-tester         PASS      7.91 seconds
TestRunner_userchan-tester    PASS      5.64 seconds
IncrementalBuild              PASS      42.02 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integer


---
Regards,
Linux Bluetooth


--===============3570506606243273608==--

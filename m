Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE3CC83F2C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 15:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353182AbjIDPHt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 11:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353169AbjIDPHt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 11:07:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D52BD
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 08:07:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso771364b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693840065; x=1694444865; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hAoXiXMOqhYhQdqVm+Qr7OFmNQqwyt5wwiO9IlDBKrw=;
        b=I8MN7DMOblw6BkzItJxUgZawBznlXEkO9BDZhA9Zv7dFIjyco5kLFLbaVcWhzSYK3K
         TGylMN0IrwUgzC1utkYokCFTwaAasErV7YVjTku7GM2GUN2DCPVP/wah7y6RKgvcQU/v
         ndexmRTF9e6+UYkgHGSoUGhClwP4ZdMsw567nThcklRD1vA5FzbXyau/CivZFJ+ydfdd
         Bo8ZTMSwzzBfou3IlkJK6pcaSrgwKw4soS8qWNF3TH71NOxs+EqKv4jjej9n6hwCUyu5
         F/qxwzxGjX+Iq43QGLOo53ZlSikuB5J/Cf5Kid7MBbDm2XxzJxUMDqoQfM3z+WRaxtk/
         PlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693840065; x=1694444865;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAoXiXMOqhYhQdqVm+Qr7OFmNQqwyt5wwiO9IlDBKrw=;
        b=gKJkMu5PykvIqLVFHHuwqig2e8HdP5xTDHKzOcGyzBwt+lBtcB7UGi4CaBWuE3jkZR
         hpI44nsTrPXXTWT6sGjnE5fT+YALHG7RXswt1KsUAAtEdtFze+XQvvHcaQLNTv3VvqtD
         4qaLs87eL3L9lcIUjMZdHmq7oWXRSZrlEOZOkVIrtyRwIUZAIcpgrTQd/h0HQu6mECMY
         Xa8pXX9K4LIW3cZziW08WN46A1L+WhQjR1SWdtbYe0XDGvD96JJ4ALDnLxqqFRb+almN
         4bzV7qz4IgfuzDZw8axEfWyYNolNWos//Yex9DqYAvyh6QniQRQrbyRKUnyQ0UoLgMhH
         8tbQ==
X-Gm-Message-State: AOJu0YzEiD/Ini6hfLXf3h2PsW7zmKYG9Nvu6MoQe3iSc7I4QSSIiMuB
        c7F7uPK2UO/9e5Ui/fUYLJJdae971bk=
X-Google-Smtp-Source: AGHT+IFFlEOEJpZf6kR/ssJetNobZeVuKZ++owywV0WbaXlAIjMgbzkMJcRn3SF1coAM6pQMRO4cGg==
X-Received: by 2002:a05:6a00:80f:b0:68b:e710:eea1 with SMTP id m15-20020a056a00080f00b0068be710eea1mr10029481pfk.33.1693840064785;
        Mon, 04 Sep 2023 08:07:44 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.50.82])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79119000000b0062cf75a9e6bsm7416565pfh.131.2023.09.04.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:07:44 -0700 (PDT)
Message-ID: <64f5f2c0.a70a0220.2540b.e349@mx.google.com>
Date:   Mon, 04 Sep 2023 08:07:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4228555707721916927=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: Fix hci_link_tx_to RCU lock usage
In-Reply-To: <20230904141155.1688673-1-yinghsu@chromium.org>
References: <20230904141155.1688673-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4228555707721916927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=781528

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      43.81 seconds
CheckAllWarning               PASS      47.96 seconds
CheckSparse                   PASS      53.57 seconds
CheckSmatch                   PASS      144.09 seconds
BuildKernel32                 PASS      42.36 seconds
TestRunnerSetup               PASS      638.67 seconds
TestRunner_l2cap-tester       PASS      36.81 seconds
TestRunner_iso-tester         PASS      72.23 seconds
TestRunner_bnep-tester        PASS      13.51 seconds
TestRunner_mgmt-tester        PASS      263.46 seconds
TestRunner_rfcomm-tester      PASS      23.73 seconds
TestRunner_sco-tester         PASS      29.06 seconds
TestRunner_ioctl-tester       PASS      25.21 seconds
TestRunner_mesh-tester        PASS      19.68 seconds
TestRunner_smp-tester         PASS      19.87 seconds
TestRunner_userchan-tester    PASS      15.92 seconds
IncrementalBuild              PASS      39.59 seconds



---
Regards,
Linux Bluetooth


--===============4228555707721916927==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B262C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 19:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiAYTxG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiAYTwy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 14:52:54 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B56C06173B
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 11:52:53 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id e20so18318160qvu.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 11:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pFeYXcx+XY/2Hl6ykwo5+jrhakkbK/bkJNOo8ZJyAck=;
        b=g5szjhI0noQCs/2LKGjbxvTcQsZ+XJZ7TPhJJq1lXX4311ybxH7hjj204/6ob3RjSM
         w8hPk4dCvykR/9MtaMMf4hXi4j1OEwl4we2CfmC1Kg1yYXAQXuJ+dB5/4X1wtsWBsBEz
         7dond/l73jiaJRfUCBMit8KO5asEfVFFWSXzJ1ng9nrptnNLP5hNpYrwrs4aQ+7C/bJt
         1F7AwV8M8o6Wr6pSJxOXphZe5cp+GTgi+VHo2t5/oQDK0jM5YZgNTUoGWWNpto3DQl1h
         HuWCcYByXhI3wVe+n4MVktbBVJIs4xkJlRl4mrTvQ70uLthl8zmyAUcL5PoTU5k9Xtqe
         Ryow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pFeYXcx+XY/2Hl6ykwo5+jrhakkbK/bkJNOo8ZJyAck=;
        b=E1U9E9UH8InjCXTu6pFiSeCP6PyKtVNQRTmF46+LfTmibI/SW80yNBOC1ucQF45Hy2
         +eQh9TwjZZzTf0zxfOSJJWOcOMUgi38QOHbUCmvZrE23bj0wRpVhINJJWM1rjnXTR5po
         dWI+ILR70p4SNMhvFJ9FL2PCXJWK6Z5Rgg0O4LqPX3RkyYVO5d9KI25J9pYNJXG6fgCP
         S/zN5ZD8uGdHjp6Be8aXQTrUS0S1KBzZN2MnH6+efaw8PloOu1Bgx3hqqsak0/QXWHC0
         VGccrrdO9tEl2Ho2KEqDx0BzsBky80JYC7zV3bPMQcHU2tXCl5RMbjjYKY9h7m6vSykc
         y6SQ==
X-Gm-Message-State: AOAM530RXBQReh8qdvHv7nGOEKg/kcEQw9uQh7p4L9CqjILfjjabwLUH
        WFH942j1+NtGOTIhv4Mxs6EQpa9l0/A=
X-Google-Smtp-Source: ABdhPJxHClGpEZme0V9FCkaJ2JxPDlEO8/Z+PzyDPWJeVVpgE0U46QvMcYRb5YPQyXoEPeJ849YDlA==
X-Received: by 2002:a05:6214:c47:: with SMTP id r7mr20544442qvj.46.1643140372468;
        Tue, 25 Jan 2022 11:52:52 -0800 (PST)
Received: from [172.17.0.2] ([52.247.64.45])
        by smtp.gmail.com with ESMTPSA id x13sm9714277qko.114.2022.01.25.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:52:52 -0800 (PST)
Message-ID: <61f05514.1c69fb81.abc49.a104@mx.google.com>
Date:   Tue, 25 Jan 2022 11:52:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3307261360819540732=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_core: Rate limit the logging of invalid SCO handle
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220125191537.2426630-1-luiz.dentz@gmail.com>
References: <20220125191537.2426630-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3307261360819540732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608393

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      29.74 seconds
BuildKernel32                 PASS      26.66 seconds
Incremental Build with patchesPASS      36.42 seconds
TestRunner: Setup             PASS      469.09 seconds
TestRunner: l2cap-tester      PASS      13.42 seconds
TestRunner: bnep-tester       PASS      6.12 seconds
TestRunner: mgmt-tester       PASS      104.48 seconds
TestRunner: rfcomm-tester     PASS      7.37 seconds
TestRunner: sco-tester        PASS      7.62 seconds
TestRunner: smp-tester        PASS      7.49 seconds
TestRunner: userchan-tester   PASS      6.37 seconds



---
Regards,
Linux Bluetooth


--===============3307261360819540732==--

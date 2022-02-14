Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1879C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 12:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352110AbiBNMAe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 07:00:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiBNMAe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 07:00:34 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE6CFA
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 04:00:26 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h9so14561461qvm.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 04:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=gEM4rLeUQ+Gm8cO69RgINHKtcQk9vc2rR3pOtjewZJE=;
        b=pABG7Cvu3k5fHdPhGl0g8FDDkUS9JtvPys7MwRkvP6qBS1YZQ9KuS2ve7J0r6oIz7m
         O9Cn7QlV1gD6KM+GV5hmn/xk/QLsM3QXt+A5WlyQp7WYBvkkmu+6IiC7GLbU+QCD9YjZ
         S2502U9mQNxhXxCOFLXmz6UYxcNVxHVRm8IiIuh9gqnX/uptzLxpLIRrQ/D8lrEE6WjH
         Ld67hC2GEvrEgkm3+4LuAFiZ1T+yfPfvkk5XA07sc/rYBDr7d3TESKcXkMy7VQsfVSHh
         Uekp4IU5XnblNVE6jGdpaXzKeRVhy0d3iGAVID1KLlv/DNN0JDnuqfSiKAOG7nSxxx1v
         7sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=gEM4rLeUQ+Gm8cO69RgINHKtcQk9vc2rR3pOtjewZJE=;
        b=PS3BP22qDAYJio3Df5Jh415fxwvPTJ2R5sDQNoXaLjBDl++P1wwAuPEcR+p/UFWlo2
         1PPKJp/ml6c/H7Qgzj4KV1VwADlMStoJa68BYSyKT6/5lqfkNOrAlP3sORWzUwjwJjJb
         JtdF9+Hv8r3jpjGXST03gJXQWcsJIWo/cise5puLxNu38O+10tNvtRnRbrl2hoY7cwAA
         mQ9Qm8wjosFwWWK3JKriqz/ogENvw5wBxPw7qu44QN0++Jy0b+t688egzI6EMas1UnP8
         8vDfc3nwpPoTBCdl7gGk98m0KvQfyQWvJcFCAA7ocn9IdCQRBQpIV0ZGfA5BsN7QsxRG
         BXuw==
X-Gm-Message-State: AOAM530BKYrPeD+Nkx1NQXYm0iPkoZBAsiz44juArOgn/EK60MJZ+yyn
        5yS0oQxTAdVwB6WDrZgUtLtaWEa0NYHLyQ==
X-Google-Smtp-Source: ABdhPJx8O80VXgwWG3Mi98iqjwdEHDISi2fdVQUaOKcHvagOauOyVfzHtz4iLLxdAke673RT2Ayvbg==
X-Received: by 2002:a05:6214:23c9:: with SMTP id hr9mr8980391qvb.16.1644840025855;
        Mon, 14 Feb 2022 04:00:25 -0800 (PST)
Received: from [172.17.0.2] ([20.114.197.240])
        by smtp.gmail.com with ESMTPSA id r13sm9798875qkp.129.2022.02.14.04.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 04:00:25 -0800 (PST)
Message-ID: <620a4459.1c69fb81.b21a0.473c@mx.google.com>
Date:   Mon, 14 Feb 2022 04:00:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3241583174927751357=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zijuhu@codeaurora.org
Subject: RE: [v4] Bluetooth: btusb: Improve stability for QCA devices
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1644835419-23943-1-git-send-email-zijuhu@codeaurora.org>
References: <1644835419-23943-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3241583174927751357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614068

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      36.37 seconds
BuildKernel32                 PASS      31.22 seconds
Incremental Build with patchesPASS      43.51 seconds
TestRunner: Setup             PASS      554.81 seconds
TestRunner: l2cap-tester      PASS      15.77 seconds
TestRunner: bnep-tester       PASS      7.42 seconds
TestRunner: mgmt-tester       PASS      118.55 seconds
TestRunner: rfcomm-tester     PASS      9.07 seconds
TestRunner: sco-tester        PASS      9.27 seconds
TestRunner: smp-tester        PASS      9.31 seconds
TestRunner: userchan-tester   PASS      7.51 seconds



---
Regards,
Linux Bluetooth


--===============3241583174927751357==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71234C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 03:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiBODNy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:13:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBODNx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 22:13:53 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725CAAC078
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 19:13:43 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id h9so16548334qvm.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 19:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rzk5EFFcDtgykl+YnsMO2mszAxWHh5+UMFtT8VVLsig=;
        b=UZ+/3U2r9AWL6c3NpxNTMUjtjDnM97VoIHLISWRsCfTgCK8tyifhwh2w63Ifk1h8Jz
         PRYKQvAVMegIckqMoGc+FaklfhhAQQVmneS5sMRAvagUjlX5BWdePz/hCCLgk9+Qfvur
         /+DSk4masGtQCPbzvrn8wKRol/jSozoNsQgNjx4kTnN8AHBwhuAptBwso++XuKgt0QMz
         kiMGY1lMtr5yf4L9+P42u8T0pMeZbf1nwXhrKtpWlNk2NU53F1XjYFVpDCtZVxgYEcMC
         1F2+kWNXqC7QgrZVCmedhJEH9sr2gO5hgfpzfYDnh2GTJ5pgNZNr1bs1n0HmKWBp+fXk
         tyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rzk5EFFcDtgykl+YnsMO2mszAxWHh5+UMFtT8VVLsig=;
        b=Y/hOlbJPLUjEJizy7qVAWel+mLS4nKJipK5vFAGqoqr251Tiu+1TgQp+T9sWEbYeI9
         IfTA2aAYgsLidyz4zLIMY1E6+MzoaUevBc6G6pw1SGkQ0KPlFCwZgnY1vHmYvkCgSO7a
         KBgYNeq33lC2gY3FkmU+nrD8TXISqkh0KLtyUj4Up7vr+beF4hiTHaBkMbdK08VBQ9KC
         FuW3XVNqFK8ULTJ5gyHLDkLcZcRz7t9Vqm8IpUjvah6OKj27t2B1T0vpzETiUq/EWLab
         XvB6X5iHXYPAqB7ln+kG3sEmGklXUUKX8yBZuyKHSqi3OipZE8YJplFpJPXU+pzq50dq
         U1fQ==
X-Gm-Message-State: AOAM5324o5voiWQWTH7ICsx5GPl5KBxqZnZP11SodyHBDV/2BOUvZxFa
        9zcynzxlC8YgSOPskSZc8HucKbP++MQd6g==
X-Google-Smtp-Source: ABdhPJyVMIFBWTIBsb5CNr6tvhFULFEF5VAqomWbadibwR1RaJlQ7qvaqzggw20AC0IDLBxEgA9Afw==
X-Received: by 2002:ad4:5bca:: with SMTP id t10mr1215123qvt.90.1644894822285;
        Mon, 14 Feb 2022 19:13:42 -0800 (PST)
Received: from [172.17.0.2] ([20.121.188.18])
        by smtp.gmail.com with ESMTPSA id b8sm18977192qtx.79.2022.02.14.19.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 19:13:42 -0800 (PST)
Message-ID: <620b1a66.1c69fb81.4c8c3.73bf@mx.google.com>
Date:   Mon, 14 Feb 2022 19:13:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8141434877672980698=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangqing@vivo.com
Subject: RE: net: bluetooth: assign len after null check
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1644890516-65362-1-git-send-email-wangqing@vivo.com>
References: <1644890516-65362-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8141434877672980698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614340

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 FAIL      0.93 seconds
BuildKernel                   PASS      29.24 seconds
BuildKernel32                 PASS      25.80 seconds
Incremental Build with patchesPASS      36.01 seconds
TestRunner: Setup             PASS      460.64 seconds
TestRunner: l2cap-tester      PASS      13.05 seconds
TestRunner: bnep-tester       PASS      5.87 seconds
TestRunner: mgmt-tester       PASS      100.79 seconds
TestRunner: rfcomm-tester     PASS      7.37 seconds
TestRunner: sco-tester        PASS      7.28 seconds
TestRunner: smp-tester        PASS      7.21 seconds
TestRunner: userchan-tester   PASS      6.09 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.93 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8141434877672980698==--

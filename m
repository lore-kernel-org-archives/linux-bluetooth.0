Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512A8C678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 23:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCGXCF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 18:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCGXBs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 18:01:48 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6549CBF4
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:59:26 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id r5so16378529qtp.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678229965;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZajhAPyXdEHUaSqlFllqBVx/FgYYtQNUAmCzXc0d44=;
        b=O9nj31kTxiaGtYxgzFk87QmvUx6Jw6UtDmta4rAnMVFYHWY+W/yWqrkzdibuzhEBKx
         woNKYw2sFGLp3fBdteTa+XPJyWKseXbzcPKnVM7cPb3ipPxHC9yRNBCwig6oBweRRZ/H
         ioGUAmLT3lEQSVaSirPZQOkwGNLZotkDNnDdcKqGRDBsS23oMdssan/2A+yJCMUKJ+DB
         PPF+KkqWbCIXQOLV1jdZnTzb6RBTLlPtdIQokl3VPwo68sAMpqHjiL5fvT8BPswyIHgp
         Ncbuf9FzgTaCx5xI5BrUeaO7KBcZ/dCtRnRuPlV9RZm2zBJL6vuHeazPn4szzB79hK4c
         VcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678229965;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZajhAPyXdEHUaSqlFllqBVx/FgYYtQNUAmCzXc0d44=;
        b=UspYq1IgwB1TaKK7lDa8dtmKXhHwjJkH/ws3wx6bKFWEC2DAQtKaGxxejcnAcc1ja7
         FuebYxyXjlGdGyukjKyUI6fkDaz1eQ8cQR1gA1oHcK9w1YrgWx/y4I4YV7NJGEcsy0OP
         iULJIGxjCj4LtXfMNpBmwzverfusUk22+QlQTHZK0WeNgndwxRzjJL/uoKJUVRtVQzN5
         d/if8Fme1GGmStw7ng2i9x3RNeRGPK38elLeG0Kz16SFg4xPsE+6PevoFS2pv+Ztyj40
         QEBrjr2Ik3mCJYO+6D64EU4varoBvqD0ibHAZB0I4X6tGjq2owDKqPrIOPB3FoKZcCeV
         L5fg==
X-Gm-Message-State: AO0yUKWAbBkzvnhKf9jsRlU2XbeUATmP6bKODwhLI56sd0PH9IrxGTlZ
        cQ03B0xO1kB3/hQB3H4xVPRaDOFJ/+0=
X-Google-Smtp-Source: AK7set/b2qlqiVQVhCwDddsvV0GEHQCH5uF1o2VJsiHrnugHVJAtLX+6lDHU8gaP8PJyhm7IlULitw==
X-Received: by 2002:a05:622a:11c3:b0:3b9:bd8d:bb22 with SMTP id n3-20020a05622a11c300b003b9bd8dbb22mr34490956qtk.14.1678229965514;
        Tue, 07 Mar 2023 14:59:25 -0800 (PST)
Received: from [172.17.0.2] ([20.42.13.50])
        by smtp.gmail.com with ESMTPSA id i185-20020a37b8c2000000b0073b79edf46csm10251041qkf.83.2023.03.07.14.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:59:25 -0800 (PST)
Message-ID: <6407c1cd.370a0220.908e3.1f0e@mx.google.com>
Date:   Tue, 07 Mar 2023 14:59:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3096346472436763957=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bage@debian.org
Subject: RE: Bluetooth: btrtl: add support for the RTL8723CS
In-Reply-To: <20230307221732.3391-2-bage@debian.org>
References: <20230307221732.3391-2-bage@debian.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3096346472436763957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727648

---Test result---

Test Summary:
CheckPatch                    PASS      2.00 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      31.28 seconds
CheckAllWarning               PASS      34.68 seconds
CheckSparse                   WARNING   39.08 seconds
CheckSmatch                   WARNING   106.29 seconds
BuildKernel32                 PASS      30.42 seconds
TestRunnerSetup               PASS      442.73 seconds
TestRunner_l2cap-tester       PASS      16.49 seconds
TestRunner_iso-tester         PASS      17.64 seconds
TestRunner_bnep-tester        PASS      5.72 seconds
TestRunner_mgmt-tester        PASS      112.73 seconds
TestRunner_rfcomm-tester      PASS      9.10 seconds
TestRunner_sco-tester         PASS      8.38 seconds
TestRunner_ioctl-tester       PASS      9.78 seconds
TestRunner_mesh-tester        PASS      7.24 seconds
TestRunner_smp-tester         PASS      8.22 seconds
TestRunner_userchan-tester    PASS      6.12 seconds
IncrementalBuild              PASS      34.31 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3096346472436763957==--

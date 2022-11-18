Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A06BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiKREeW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiKREeV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:34:21 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074B1EC7E
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:34:17 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-14263779059so3885295fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kGWf4oKmKuj1IWcajg7Xm+JR7NvxUDOFpG+cf0Z8zTs=;
        b=hN0qzg+xpTW4E82ZMeglSomwx7smuhqTQUzHODCMKN4vbuWuDADwsWGuLvS10cWFmk
         blv2FPNkcF/iMTZCbS5msGmk/ExA+lGEEx+lHF03pFwS89GRyrLzMEGCAgzXKZi63qQV
         Q9sm2SVDOz1fkuzTMtfciW1z9y+8LvvFsMqScGfB1B9FbqDSkAfvrR+NkfeTM3CQIrrs
         2jP7N+3mPXmzEnnFkuvWPd/FuKDLLNs2Y3b0rcqiyNeKxrdf8Hbyr4OQRt2F2s3kIuAc
         zLBuv+/R0IF78PHHmQs8+E9j4RkcXTOEP4S5FhzFicL3y4mpgI3bDMfBtnhgTZxRR93Y
         OPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGWf4oKmKuj1IWcajg7Xm+JR7NvxUDOFpG+cf0Z8zTs=;
        b=GipDWH2w+ZydKQk6CKhDFRpPQItCteOJmndamx+bd/i6qpR9pgc19IWxa+9wekHEW+
         BMCAqCxXDLrS4trJ9ZiTJGWPisB4yFzkIUx6q+72cDdTx3dFBautCa4Mmonar4Hzzo4a
         +spsBLFUPm6MPHLif5U9KKpgY8CPZY7GJTGXtHgG/pV4s2uj80DXrHmvrfu4jSgwXfwK
         ZuGOKN5TobtWyrNeJjGPLMpuHPs04hkAucT0GQeWRSLmFQd8cnKLIBCg9THBfFqH1ada
         u7xnd31ZvPhkc7EXkB1287igh2XwrrJWjIlkvS95P/0CxTmESjT+unXqXgn9F8YnXIRZ
         TYNA==
X-Gm-Message-State: ANoB5plWsSde6E4PAMLkfhJ7u87CTLOaQrjERVjU/jmzYbd4N0Iv190V
        o8V6jK4IDMvqQLxbGlUIMNdUFhM5+7nW6A==
X-Google-Smtp-Source: AA0mqf5hGg07BR8/+lD4Nsst1g2XbGEg1CVETbwzzMXNZToFZI59sEPSwY/2vOXgWcc45mce0hhboA==
X-Received: by 2002:a05:6870:c687:b0:13b:cb39:3f80 with SMTP id cv7-20020a056870c68700b0013bcb393f80mr3153605oab.133.1668746056448;
        Thu, 17 Nov 2022 20:34:16 -0800 (PST)
Received: from [172.17.0.2] ([20.225.198.79])
        by smtp.gmail.com with ESMTPSA id o17-20020a056870525100b0011f22e74d5fsm1432932oai.20.2022.11.17.20.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:34:16 -0800 (PST)
Message-ID: <63770b48.050a0220.33644.6898@mx.google.com>
Date:   Thu, 17 Nov 2022 20:34:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7221311660721344840=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix enable failure for a CSR BT dongle
In-Reply-To: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7221311660721344840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689388

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      33.29 seconds
BuildKernel32                 PASS      29.65 seconds
TestRunnerSetup               PASS      417.65 seconds
TestRunner_l2cap-tester       PASS      15.67 seconds
TestRunner_iso-tester         PASS      15.12 seconds
TestRunner_bnep-tester        PASS      5.26 seconds
TestRunner_mgmt-tester        PASS      103.06 seconds
TestRunner_rfcomm-tester      PASS      9.04 seconds
TestRunner_sco-tester         PASS      8.54 seconds
TestRunner_ioctl-tester       PASS      9.76 seconds
TestRunner_mesh-tester        PASS      6.63 seconds
TestRunner_smp-tester         PASS      8.40 seconds
TestRunner_userchan-tester    PASS      5.53 seconds
IncrementalBuild              PASS      31.08 seconds



---
Regards,
Linux Bluetooth


--===============7221311660721344840==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6926EEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jul 2023 21:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjGBVcT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jul 2023 17:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBVcS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jul 2023 17:32:18 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B68F199
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jul 2023 14:32:17 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-635857af3beso19050976d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Jul 2023 14:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688333536; x=1690925536;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5cYQLvl1PrzinEQl6MBhoXQgVfiUkslMc48Utoz76X4=;
        b=Kk/WOrPwf6SQYikobQrGrHCpn2ogaesHsnP9AeHi2Ivpt+agCaa+8nh9LhIZ3k0ici
         pleLBHWR/VrTRJriL2V9cTCb2xY4DxAUq0GRpkkUf5B7kNxsFeU31BxqqqD7z865L3wN
         VCde110rewxECVbPupPeHIj175TUa05GXCdlT0XDgW3tbIugy+mBEMw2DlUML+YwwnDa
         pGa8+lEdvUx0BGu4XYg0hldZ16E4X8uKBY1yrzmVxWXGlhHnQ9IflLoI0LBVRFJO3PS0
         qZtaW6RRdaxAWa7HdUuQflURMKasz5Mfbfzyu4l6OjxdlGkC7tZ/sOoDJ/WYt+UfxUK2
         n5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688333536; x=1690925536;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cYQLvl1PrzinEQl6MBhoXQgVfiUkslMc48Utoz76X4=;
        b=NuoJCq7imFn27lmnexIGYxow2vJo+ysEHByrJ8pKZ+rggIwJMPAi6FfLGAMHnDNR03
         MbA+i+JBQ5hFrgXmORCYY4Qcc+nBaXLk+dGPYbngpDRC57jRd4wF5rZUhqGa9ro6UQLM
         SYQkNyfsbuRbFP75xYqnA2uZkv7vANPF157RFNiXNFwLbuzYUcSPZ3EcykJv29MxvdBD
         5kNdgX9y9b/Kv+gCM+XLHM+4v864RF0lcn1u0VzNbXoV7SdONrSG30Rlxk2X2eGNpB+U
         wc1MNyef5Rg624OXWZRvow0h1pFgsAYUnfjtalnemV8o0s+kk6hmV1XqmX5zd3Ih5TRv
         bGfQ==
X-Gm-Message-State: ABy/qLbssuYunT/Y6yeLWgvMi98hdy64s/g1ADjHgna5QMHdoEzcsEt4
        G8vEFwFRfQ0kwvO+6gI5N+J4v9RQV6E=
X-Google-Smtp-Source: APBJJlHdG2AksmmQuu1J+Cn7ZLv4z524louYessTRlhmWN9JVU7ksYFcERgcFrP9W+rpCfbUuKB9Eg==
X-Received: by 2002:a05:6214:ccc:b0:635:e303:ed63 with SMTP id 12-20020a0562140ccc00b00635e303ed63mr10878982qvx.8.1688333536276;
        Sun, 02 Jul 2023 14:32:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.98.52])
        by smtp.gmail.com with ESMTPSA id ee12-20020a0562140a4c00b0062ffbf23c22sm10642766qvb.131.2023.07.02.14.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 14:32:16 -0700 (PDT)
Message-ID: <64a1ece0.050a0220.1fa26.86d4@mx.google.com>
Date:   Sun, 02 Jul 2023 14:32:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5014011711320194555=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, valentin.david@gmail.com
Subject: RE: Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
In-Reply-To: <20230702210138.226929-1-valentin.david@gmail.com>
References: <20230702210138.226929-1-valentin.david@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5014011711320194555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761869

---Test result---

Test Summary:
CheckPatch                    FAIL      0.95 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.53 seconds
CheckAllWarning               PASS      36.46 seconds
CheckSparse                   PASS      41.12 seconds
CheckSmatch                   PASS      113.59 seconds
BuildKernel32                 PASS      32.27 seconds
TestRunnerSetup               PASS      454.28 seconds
TestRunner_l2cap-tester       PASS      13.00 seconds
TestRunner_iso-tester         PASS      23.67 seconds
TestRunner_bnep-tester        PASS      5.65 seconds
TestRunner_mgmt-tester        PASS      132.22 seconds
TestRunner_rfcomm-tester      PASS      8.98 seconds
TestRunner_sco-tester         PASS      10.55 seconds
TestRunner_ioctl-tester       PASS      9.85 seconds
TestRunner_mesh-tester        PASS      7.09 seconds
TestRunner_smp-tester         PASS      8.13 seconds
TestRunner_userchan-tester    PASS      5.85 seconds
IncrementalBuild              PASS      30.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13299507.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5014011711320194555==--

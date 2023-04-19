Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE96C77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 04:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjDSEfm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 00:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjDSEfj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 00:35:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789A083D9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 21:35:38 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7606d6b3294so341097339f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 21:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681878937; x=1684470937;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=87JePyUoKMqkGn2f6jw1e+MeivCMJabRSAmFD1gXAkY=;
        b=kaeP58u7EQSVwXGfTF59zkvkJRKo9V8O2u2cPsCVnijdFxBoUS59U0arNuAKMJ40UB
         3U2gS50thVJwWygKI90dmGg+QqHTvKejIO0X/J+eEFsRM1foaPshf9w0byrm9myZhN2g
         wiwOblKWhcWmcisIheoJL0MUXDDPj5uvLCUSaI2UYr+OwHtxS46nPvoaiqJv9Q7kKN8M
         j7NmeuXXBO2SGk3bKBUisOg6Ks1JY3fVIYmOuWqhO4PAU788QHm7OnyNHsmOC5SuqSIw
         LRFU+mC7SSJ4fWBL4OGG9o9yFQNh0rdAQFi3SEgSWZXK2le9YD4WPVGmpf7CffF0mUgt
         WOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681878938; x=1684470938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87JePyUoKMqkGn2f6jw1e+MeivCMJabRSAmFD1gXAkY=;
        b=ZntG8mBPCISTGZJZB8lKcZmNINea2jqtB9MfRt0N54A0ox4BLbJWa3Bm/AMgfktzwZ
         X4p+YLk5ooWSsUryehj7n4+JX5MK3M4IvkkLYrrBG2CxUdy4jRQlsfwQy9FgKEtM6wTp
         4NRQ5oWM1blXlQWhcpC6Z6xFbeITTHBU1REuCxl1c7s7jzyZobE7J1rmlXmGO9ViBXy7
         2XEpz5Oovb6gsYl6EBrxqZ0NOUxPsAmUrdOGOylVD71oG9NCgv1q7TMNbC9VOcj4hjNR
         iC0BHs6xCgAXUFBACID/yNvu0qmB/B9/fWBqOTRHKIa3arVjKzhF3g9sR6MbHW5b/vVT
         onSw==
X-Gm-Message-State: AAQBX9d30YP4cI0KqEqueHbsFdQsOSf/Lo+glakzAHhuJcYoCjztYweC
        zF+u53cJ9scT/tIdQgQ9KjAKSjP4VtA=
X-Google-Smtp-Source: AKy350aZVlvCoMxgiPPyZwvLlJbhF7jiYnch+2z0x7xWckeTJh1iEsENVPCwgov1ZS3o4HsTspz/gg==
X-Received: by 2002:a5e:d70e:0:b0:763:5cf8:65eb with SMTP id v14-20020a5ed70e000000b007635cf865ebmr4161632iom.9.1681878937700;
        Tue, 18 Apr 2023 21:35:37 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.50.161])
        by smtp.gmail.com with ESMTPSA id d131-20020a026289000000b0040f9e6695d7sm2846946jac.140.2023.04.18.21.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 21:35:37 -0700 (PDT)
Message-ID: <643f6f99.020a0220.f0d3c.3347@mx.google.com>
Date:   Tue, 18 Apr 2023 21:35:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3722957156100995180=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v3] Bluetooth: btusb: Add WCN6855 devcoredump support
In-Reply-To: <20230419033805.27356-1-quic_tjiang@quicinc.com>
References: <20230419033805.27356-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3722957156100995180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741172

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.92 seconds
CheckAllWarning               PASS      35.42 seconds
CheckSparse                   PASS      40.65 seconds
CheckSmatch                   PASS      110.35 seconds
BuildKernel32                 PASS      31.79 seconds
TestRunnerSetup               PASS      456.05 seconds
TestRunner_l2cap-tester       PASS      17.24 seconds
TestRunner_iso-tester         PASS      20.98 seconds
TestRunner_bnep-tester        PASS      5.65 seconds
TestRunner_mgmt-tester        PASS      116.99 seconds
TestRunner_rfcomm-tester      PASS      8.99 seconds
TestRunner_sco-tester         PASS      8.43 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        PASS      7.12 seconds
TestRunner_smp-tester         PASS      8.16 seconds
TestRunner_userchan-tester    PASS      5.94 seconds
IncrementalBuild              PASS      29.73 seconds



---
Regards,
Linux Bluetooth


--===============3722957156100995180==--

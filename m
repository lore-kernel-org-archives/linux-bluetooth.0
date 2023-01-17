Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9523C3DA78
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Jan 2023 11:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbjAQLby (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Jan 2023 06:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbjAQLb0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Jan 2023 06:31:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8109436B30
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jan 2023 03:30:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso33828205pjf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jan 2023 03:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bd+QIG4OMBR0vYpcLovONqRX0rFMRrxmHMpkDgl84AQ=;
        b=Vau4zVkdKaUywFX302xit6NKdIp3L7yzP07aPibTLaCSXYJkKchcTO7Rx8WzeKvYNI
         eXKq5wqxvc5dE6AuVSGQNiHIepiPiulNzTGeXrJ2zwbpuvLBLNBgxbyVNXM7eJRRKv7I
         4kn3YPRHCB9yBawyaJ7Sq0S9KbAjZo7qB2q3gYMkSSbNRpQkySQl1Mu8yvD8TBl5CmEm
         NIMmMA0Ft3Bbja0WqJi3bNpnt2rmBLSbCDvBrh/440ChHgwrpMXzgxm3F6Hn8ijkkGhS
         Ux5XpnCi8rvIkVerQZKv8elW4scDUrz30ZsBB5rZcB9hraBwKgdQkH+4tgZ/gOaB2iv/
         fTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bd+QIG4OMBR0vYpcLovONqRX0rFMRrxmHMpkDgl84AQ=;
        b=YZmpTF4kjpbegaOdFoc8qwlMU8OrWE7TcCd1KIJqb+FXXXyiajNPpvxdIFxjrjYS32
         zxGQVjsArMSI7HtS01bl0FEHBj0Qb+vzAskFjeao2r08R3gco3Jo6i/JVVHs21Uhsro8
         CQLZ0HigENLCSGxTXwVGIWiqSDAROuRSlX8/4z//QEPaMocQrplSbKzxO3Wp4+qCyRPO
         p6kS8OiT4q7jq5EfuIzrbvlx2JhJt5WEkkXUFRqvuxK3L2U3U0NGjufOLp3OAHLGCBgZ
         TLpcjc4jmMnUwzWzKFAS7yXvgsG/lHsHnfnLpPz0BEoe6qgi5T8aGBr3Ki8UWVkVJjYA
         Rp0Q==
X-Gm-Message-State: AFqh2krEOYhGKxA5SR64ARQ0x1rlEeIoJ7liNfX+sIM8pUiLCKkr0Ex/
        qx1T7UGjl66N2IBd2n00uKV0bxhxLyc=
X-Google-Smtp-Source: AMrXdXstwtW3GfE5cy0t39hSE/zzRy/mZMW8uv69ba6WyTezGweGJScgl96Gjst+8sqFGjltDWXU/g==
X-Received: by 2002:a17:903:108c:b0:194:9ddd:9acf with SMTP id u12-20020a170903108c00b001949ddd9acfmr1739064pld.2.1673955054797;
        Tue, 17 Jan 2023 03:30:54 -0800 (PST)
Received: from [172.17.0.2] ([4.227.8.33])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b00186a2dd3ffdsm21007724plk.15.2023.01.17.03.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:30:54 -0800 (PST)
Message-ID: <63c686ee.170a0220.aef6b.19f0@mx.google.com>
Date:   Tue, 17 Jan 2023 03:30:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3175445731817314772=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, stephan.gerhold@kernkonzept.com
Subject: RE: [v2,RESEND,RESEND] Bluetooth: btqcomsmd: Fix command timeout after setting BD address
In-Reply-To: <20230117100703.375787-1-stephan.gerhold@kernkonzept.com>
References: <20230117100703.375787-1-stephan.gerhold@kernkonzept.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3175445731817314772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=712703

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.81 seconds
CheckAllWarning               PASS      33.48 seconds
CheckSparse                   PASS      37.88 seconds
CheckSmatch                   PASS      106.53 seconds
BuildKernel32                 PASS      29.58 seconds
TestRunnerSetup               PASS      428.64 seconds
TestRunner_l2cap-tester       PASS      15.91 seconds
TestRunner_iso-tester         PASS      16.21 seconds
TestRunner_bnep-tester        PASS      5.44 seconds
TestRunner_mgmt-tester        PASS      107.46 seconds
TestRunner_rfcomm-tester      PASS      8.64 seconds
TestRunner_sco-tester         PASS      7.89 seconds
TestRunner_ioctl-tester       PASS      9.15 seconds
TestRunner_mesh-tester        PASS      6.85 seconds
TestRunner_smp-tester         PASS      7.81 seconds
TestRunner_userchan-tester    PASS      5.70 seconds
IncrementalBuild              PASS      27.79 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,RESEND,RESEND] Bluetooth: btqcomsmd: Fix command timeout after setting BD address

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[v2,RESEND,RESEND] Bluetooth: btqcomsmd: Fix command timeout after setting BD address"


---
Regards,
Linux Bluetooth


--===============3175445731817314772==--

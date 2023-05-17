Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15815C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 02:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjEQC1v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 22:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjEQC1s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 22:27:48 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3713ABB
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 19:27:22 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3318baede4cso678735ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 19:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684290439; x=1686882439;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1qWocaZPsQXdG3QCHTANf8qWvlCCMB7yQkx/JK2OxiY=;
        b=K15ssCl0pH0giBdMIlgKatiP2VHI+am4QNNaBjzhdW/g61wrzp7oOhQR6KQTgZWDl/
         pNxo/AVgbgC2NyjfeclPehcIFKUJdBRhbQw5PlJq+1A4WbyFYg7LlucI6OIHNRj151fj
         cutq466IwCms+BpvF6HYQhfQpnMxvceJt2Ov4K0zI/68NMClO5cbZ5bJsrauXOsIfQlu
         UUXRY8WAg0rebbyKRfGqQ9/3KHZT4S9chvtInMPSEdX6oWYx7s7K0KkXnTk2K30D/mZc
         SGs6oLUVQZAmAgtTWlk+ctc/pWbmkrj3kSZ7Bq83G4R06cX+IptZW3QCt9tvhIEmoM23
         34nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684290439; x=1686882439;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qWocaZPsQXdG3QCHTANf8qWvlCCMB7yQkx/JK2OxiY=;
        b=jTALyBl+jFCE2EpUs+6CghRUy+pmAm9dwMSPnzvkGiu5bpqCEqtGELytdeq+ekK+fR
         1Ufd3wPhO0s1AUnLqlsiilYj3HGm3krWMFMPNyBiORg81Sqe3gYEChrmPMowg19+kT8N
         cPsEl+o+QKdOUcftvD7J4884h3mLZj+6aqBmuU8pW6aVEZcTFFEOCVCPdvGTge/dal70
         OtpF3Ia3Ods2d2JIaALRhUNRlRLZiGnY4BeY8L6jKmx0s30GXKI2wlmlW8JBcXjpRZu/
         DbYwq0h+uiZ+NtCYJ37838NyPBWxVfiY/m6WaGaLWtWaFdB5hr0f655us1+XvcT1MNCk
         TmNw==
X-Gm-Message-State: AC+VfDw3L8EkRf6qpQwC+bUFPn17xPAUsiDGKLRm5q4iYtEGRpIcbt/G
        mSDEyA+SRFifT1mlHseJv3L74s4JYS0=
X-Google-Smtp-Source: ACHHUZ6LVhIRpuQl4ycSl49bt4p+dN6kLk86c92RuGri+Yod7mOWZ2gkw1rmw+OAjzrp+hjHrjaYAQ==
X-Received: by 2002:a92:c644:0:b0:326:1cf1:a9ce with SMTP id 4-20020a92c644000000b003261cf1a9cemr756564ill.29.1684290439110;
        Tue, 16 May 2023 19:27:19 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.125.161])
        by smtp.gmail.com with ESMTPSA id z15-20020a92da0f000000b00333760c865asm7789814ilm.10.2023.05.16.19.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:27:18 -0700 (PDT)
Message-ID: <64643b86.920a0220.1949a.8df9@mx.google.com>
Date:   Tue, 16 May 2023 19:27:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8581919698220016697=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kuba@kernel.org
Subject: RE: [net] MAINTAINERS: skip CCing netdev for Bluetooth patches
In-Reply-To: <20230517014253.1233333-1-kuba@kernel.org>
References: <20230517014253.1233333-1-kuba@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8581919698220016697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748215

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       FAIL      0.57 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      32.33 seconds
CheckAllWarning               PASS      34.99 seconds
CheckSparse                   PASS      39.77 seconds
CheckSmatch                   PASS      108.64 seconds
BuildKernel32                 PASS      31.08 seconds
TestRunnerSetup               PASS      445.03 seconds
TestRunner_l2cap-tester       PASS      17.21 seconds
TestRunner_iso-tester         PASS      21.47 seconds
TestRunner_bnep-tester        PASS      5.62 seconds
TestRunner_mgmt-tester        PASS      116.78 seconds
TestRunner_rfcomm-tester      PASS      9.11 seconds
TestRunner_sco-tester         PASS      8.36 seconds
TestRunner_ioctl-tester       PASS      9.70 seconds
TestRunner_mesh-tester        PASS      7.08 seconds
TestRunner_smp-tester         PASS      8.09 seconds
TestRunner_userchan-tester    PASS      5.90 seconds
IncrementalBuild              PASS      29.36 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[net] MAINTAINERS: skip CCing netdev for Bluetooth patches

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (87>80): "Link: https://lore.kernel.org/netdev/639C8EA4-1F6E-42BE-8F04-E4A753A6EFFC@holtmann.org/"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============8581919698220016697==--

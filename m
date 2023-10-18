Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C5FCDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 15:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjJRPmh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 11:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjJRPmf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 11:42:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A7B11F
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 08:42:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf55a81eeaso48101195ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697643753; x=1698248553; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J5e55TtLWyW79DG31E6tMXsDrOufzF8DLPpdm5KeSFw=;
        b=F0I4+JicKiEtx6pe6Xm1upDGTe3Iz3lS3vSaAJ/a/FU1dWBfyFg+apI4jPZu1DrerU
         KBRcnxuA0ZDhotWVwLJ3AFIUizwlNoNuHk9NE7WF8vCOlKpqeZweJdddmGUP9tw3f7C9
         gbJ8Vm9L2F4z2nKvWYmG6kCpILuX3EuK1y8U1w1BNhpsap9vpwSLAZXWPniFyN+yL4Um
         kQmWbJD9alhZTx/f1XLz+9GXUyMBOXvdE2qdoyjhYrlUri1CZaoxDuNsqtvW6v8xiIai
         rMr90GqaYGgDOMvmjD5I+Twp6sJKVST9MpQLFRb29aMr3MQATX6RkqK6JcWESjwes+TT
         OE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697643753; x=1698248553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5e55TtLWyW79DG31E6tMXsDrOufzF8DLPpdm5KeSFw=;
        b=ikgo6OEmTe4V/SGOPDELL91/6bAk0K2A+0TFWu+aC65QEUubPiICSPVdUVN4H9mXs6
         JteGWVspJ5f/NknDcUpYK0Zcyiim3Cm35NUXyJvjMjtz2Idbi1YaJi81hzvdbfltLf8G
         KVZhHGs7+LcQhOcTQ4g9xabmK4Fo1Xh2bs4wDLaruGJoqu1SA1H4ua2Il78vTYFM5uVN
         MH8DijqBsMp2CNCEXZXWQYiQSprm5wp/FgP8QlUfu5YvHJYimMsL6d2ZaLecbXThALtu
         JR5sAjql+zuCN2wkYOGhb466g51YAIk3Wo8XsAHQxiHf/yLtlETrrd+DHNTvsiF4a54V
         iksw==
X-Gm-Message-State: AOJu0Yx83KZD7ZnpZjuwycvEAyzVWP7NjP1juHI0efsg/lnbbL6FD5Jl
        wmh+PZ1tVgpnNMYtbVstOnbpUT4X/7I=
X-Google-Smtp-Source: AGHT+IG8ZFX+9yOsqAEi8Iku0MOLmBQggc5L9t3SD1v2zWNg0k0z0JJkz0cX/3+2l4kB+ab1SJ9x2g==
X-Received: by 2002:a17:902:7609:b0:1ca:3c63:d5cc with SMTP id k9-20020a170902760900b001ca3c63d5ccmr5227395pll.49.1697643752932;
        Wed, 18 Oct 2023 08:42:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.156.32])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001c55db80b14sm66671plf.221.2023.10.18.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 08:42:32 -0700 (PDT)
Message-ID: <652ffce8.170a0220.a2222.04d8@mx.google.com>
Date:   Wed, 18 Oct 2023 08:42:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5327935229171650224=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcel@ziswiler.com
Subject: RE: Bluetooth: btnxpuart: Fixes
In-Reply-To: <20231018145540.34014-2-marcel@ziswiler.com>
References: <20231018145540.34014-2-marcel@ziswiler.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5327935229171650224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794372

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
GitLint                       FAIL      0.87 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      40.70 seconds
CheckAllWarning               PASS      44.32 seconds
CheckSparse                   PASS      50.43 seconds
CheckSmatch                   PASS      136.47 seconds
BuildKernel32                 PASS      39.48 seconds
TestRunnerSetup               PASS      605.01 seconds
TestRunner_l2cap-tester       PASS      36.73 seconds
TestRunner_iso-tester         PASS      82.05 seconds
TestRunner_bnep-tester        PASS      13.00 seconds
TestRunner_mgmt-tester        PASS      253.02 seconds
TestRunner_rfcomm-tester      PASS      19.14 seconds
TestRunner_sco-tester         PASS      21.88 seconds
TestRunner_ioctl-tester       PASS      21.50 seconds
TestRunner_mesh-tester        PASS      17.43 seconds
TestRunner_smp-tester         PASS      16.74 seconds
TestRunner_userchan-tester    PASS      13.37 seconds
IncrementalBuild              PASS      43.08 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/2] Bluetooth: btnxpuart: Fix btnxpuart_close

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (485>80): "[   29.277062] Modules linked in: snd_soc_simple_card snd_soc_simple_card_utils crct10dif_ce btnxpuart usb_f_ncm u_ether rtc_ti_k3 k3_j72xx_bandgap mwifiex_sdio mwifiex snd_soc_davinci_mcasp snd_soc_ti_udma sa2ul snd_soc_ti_edma snd_soc_ti_sdma authenc ina2xx snd_soc_nau8822 tps65219_pwrbutton at24 ti_ads1015 industrialio_triggered_buffer kfifo_buf lm75 rtc_ds1307 spi_omap2_mcspi 8021q garp mrp stp llc cfg80211 bluetooth ecdh_generic ecc rfkill libcomposite fuse drm backlight ipv6"
15: B1 Line exceeds max length (94>80): "[   29.319532] CPU: 0 PID: 55 Comm: kworker/u3:0 Not tainted 6.6.0-rc5-next-20231010-dirty #35"
16: B1 Line exceeds max length (85>80): "[   29.327883] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)"
46: B1 Line exceeds max length (485>80): "[   29.453556] Modules linked in: snd_soc_simple_card snd_soc_simple_card_utils crct10dif_ce btnxpuart usb_f_ncm u_ether rtc_ti_k3 k3_j72xx_bandgap mwifiex_sdio mwifiex snd_soc_davinci_mcasp snd_soc_ti_udma sa2ul snd_soc_ti_edma snd_soc_ti_sdma authenc ina2xx snd_soc_nau8822 tps65219_pwrbutton at24 ti_ads1015 industrialio_triggered_buffer kfifo_buf lm75 rtc_ds1307 spi_omap2_mcspi 8021q garp mrp stp llc cfg80211 bluetooth ecdh_generic ecc rfkill libcomposite fuse drm backlight ipv6"
47: B1 Line exceeds max length (111>80): "[   29.496085] CPU: 0 PID: 55 Comm: kworker/u3:0 Tainted: G        W          6.6.0-rc5-next-20231010-dirty #35"
48: B1 Line exceeds max length (85>80): "[   29.505912] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)"


---
Regards,
Linux Bluetooth


--===============5327935229171650224==--

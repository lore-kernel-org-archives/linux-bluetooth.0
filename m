Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B847EC3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Dec 2022 19:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLYT3t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Dec 2022 14:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYT3r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Dec 2022 14:29:47 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE97273D
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 11:29:46 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id d2-20020a4ab202000000b004ae3035538bso1542712ooo.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 11:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AQDtiZIC+q5UwDL0SYDm+stmMh/wZ+ibYc69e/Zvub8=;
        b=O4AIfnTN7/o/sEW41qtrKZolJHF3PE+busv+VSIelXxfpAYJpHl5E0stYAVYV1L3sS
         xl9w9sulrnL+HyeaaTtdgtsQ+ud03TtYHsv3vfaT+te6o//TJ/TGtqrjVgNiH3z20rw+
         D/4q5G0CwhTZEEv6EFDeS1Y1v2+YyGoiqCDctDB2VFyBnU2AmKByKIv2T+PCRcrtgeko
         4929vDWcfHjZwN5PmvE/R1SS6BOk3vP717I72N+u82yVIfLX9okR44D+jv1u8/BaJuIf
         C0K9Rt03JcMc1iv90NHuXrIdFXZ6Gt/dv7JZ3XtRblEB+o1fMkqORrfZD3BPKZmGLINr
         6Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQDtiZIC+q5UwDL0SYDm+stmMh/wZ+ibYc69e/Zvub8=;
        b=WEh37FIoAKVPWJY4cP6W5UkImkzt2QLqnYdsiwkoFNBEVTlkaTDPF/hqCmo7evwmrb
         +wuXlyVkFhIJEow+hiSvlWRDqHchtm1cwC8oCYd9v6/P8IAG2mGaHJfDOSM9tlOPpZrk
         nlfYu/lge1xHZhC+HHIulZ/BPpzdxGzBYpsD1/W5ZYmxLd/+YEbO95N6AtJN2P/53t7I
         5Ta8BEsBhgkD2cyidMEKqm867IOGfNxJVLlOa8OU1vkYPGDhCDrT+jpmHUYLxBvElSJX
         3/pJK15H+HGD4VmGXxmCZQZ9KqgdvEEFSw5BEeXMwfXGEFFXi6BhktvGbypKvzWQcVjb
         /GWA==
X-Gm-Message-State: AFqh2krN9OJrpzAgfyQbPN1JNavXdipQYPOjHOh6B0nheeGH9XZSFrHz
        d0tdVr6xImoLbQkj3KaY5nJ5nPOITdY=
X-Google-Smtp-Source: AMrXdXv5a5+R+ncixYzZB51G0LOxf2uGI5DQhskj9nyTmS2vseWzswKmZ2H1/+Yp0X5OcyC0EChELg==
X-Received: by 2002:a4a:ded6:0:b0:4b7:a5eb:b239 with SMTP id w22-20020a4aded6000000b004b7a5ebb239mr7880905oou.3.1671996584877;
        Sun, 25 Dec 2022 11:29:44 -0800 (PST)
Received: from [172.17.0.2] ([70.37.167.48])
        by smtp.gmail.com with ESMTPSA id j15-20020a4ad18f000000b004c60069d1fbsm3657107oor.11.2022.12.25.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 11:29:44 -0800 (PST)
Message-ID: <63a8a4a8.4a0a0220.6681f.c5cd@mx.google.com>
Date:   Sun, 25 Dec 2022 11:29:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7081801459234638527=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, moisesmcardona@gmail.com
Subject: RE: Bluetooth: btusb: Add VID:PID 13d3:3529 for Realtek RTL8821CE
In-Reply-To: <20221225190713.656505-1-moisesmcardona@gmail.com>
References: <20221225190713.656505-1-moisesmcardona@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7081801459234638527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=706933

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      32.60 seconds
CheckAllWarning               PASS      35.31 seconds
CheckSparse                   PASS      40.00 seconds
BuildKernel32                 PASS      31.34 seconds
TestRunnerSetup               PASS      452.54 seconds
TestRunner_l2cap-tester       PASS      16.57 seconds
TestRunner_iso-tester         PASS      17.45 seconds
TestRunner_bnep-tester        PASS      5.78 seconds
TestRunner_mgmt-tester        PASS      110.97 seconds
TestRunner_rfcomm-tester      PASS      9.19 seconds
TestRunner_sco-tester         PASS      8.55 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        PASS      7.33 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      6.09 seconds
IncrementalBuild              PASS      30.14 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Add VID:PID 13d3:3529 for Realtek RTL8821CE

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B2 Line has trailing whitespace: "This VID:PID is found in the Realtek RTL8821CE module "
15: B2 Line has trailing whitespace: "S:  Manufacturer=Realtek "
16: B2 Line has trailing whitespace: "S:  Product=Bluetooth Radio "


---
Regards,
Linux Bluetooth


--===============7081801459234638527==--

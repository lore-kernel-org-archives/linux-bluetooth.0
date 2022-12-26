Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Dec 2022 08:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiLZIgO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Dec 2022 03:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLZIgM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Dec 2022 03:36:12 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A229E4A
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Dec 2022 00:36:11 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id g7so8092289qts.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Dec 2022 00:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Llkpmkxw8XhRQSEA92CiVf9+e7Pr9rjfvK+cHH5wcEo=;
        b=IHgs+qGS/SuXiCA/MI1+vTZpGPkGMgwOe0a/SpS4faiXsy7G0WU5Ss3NbRjNzdyOON
         MvHgUjHOHwBTrrbFunNr0qVRNEb46VuU1exNEzOjwX7VLS+rvGjE3USvVfs67pBacVz6
         o6Ks/5T+9ORZpN/zQmVgFtQyWX5Jozp+OtMoAV08eBj5ft8Gh1L/WuAo/0VlMDZDRy2b
         fJGvRcpZ3gU/FtFXzeEjzWJymAmM6zvfkiCUQkgdpgn9wNe+kE7Y2TkfDHrXwViQiZTg
         S6uG164UsuL9ikfybP+JK2vi7foiNjW3oTVwXedJTNN30dTFGI8NfrigHft6kJWK2dBt
         6I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Llkpmkxw8XhRQSEA92CiVf9+e7Pr9rjfvK+cHH5wcEo=;
        b=vedUWpue5fYaA7E9D8vm1GtQXUwI7NN0XQPkSOacZmMCWAoc0YnOIJFV0H+E/7x6cB
         prO2z5QOCEYzgniZKcsOpityMIIifpWyoCR2RspxMVOQEuS4f+9Dhw6PrZoFVPTwVOYC
         0G2oiHl71FWgWwjq8LfNh0uvqx1dA7j/4KlRZAt690rRg7id8hdCQ8wiCAxoP9Loawnu
         PwKm7U6d5h9vhU4yMt5ROesE1xPU/J2Dm8vG1A9UK/RNnYesNK8ASReJDs0Xd7goD4dC
         2B2TruN9ZQrEDBoMON33ottnBi7llKUhT1zddb7aTNcBQKy2CGVuVHZEYSONczH4MwWh
         l6Ww==
X-Gm-Message-State: AFqh2kqaxBAnktAL5N4wE/vjGpmwumEjaTrx72qPnOZ70wnCmKQbqrAL
        7FTI9oj3/+D5Zij1quPnjxQyrEm1zoSrIQ==
X-Google-Smtp-Source: AMrXdXumBDEgD+nI23irfIdwDbEWtALbh67HdOSMypV40yL+94MM2tSnZ+LSG3OJbYKlmY1iYbxTRw==
X-Received: by 2002:ac8:4f16:0:b0:3a7:ec99:56e4 with SMTP id b22-20020ac84f16000000b003a7ec9956e4mr31337913qte.39.1672043770193;
        Mon, 26 Dec 2022 00:36:10 -0800 (PST)
Received: from [172.17.0.2] ([52.226.126.55])
        by smtp.gmail.com with ESMTPSA id g14-20020ac87d0e000000b003a7eceb8cbasm6486629qtb.90.2022.12.26.00.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 00:36:10 -0800 (PST)
Message-ID: <63a95cfa.c80a0220.401e7.2e0b@mx.google.com>
Date:   Mon, 26 Dec 2022 00:36:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6377548344260856897=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v5] Bluetooth: btusb: Work around spotty SCO quality
In-Reply-To: <20221226074829.8682-1-hildawu@realtek.com>
References: <20221226074829.8682-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6377548344260856897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=706984

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      31.73 seconds
CheckAllWarning               PASS      34.32 seconds
CheckSparse                   WARNING   38.39 seconds
CheckSmatch                   WARNING   107.33 seconds
BuildKernel32                 PASS      29.91 seconds
TestRunnerSetup               PASS      434.60 seconds
TestRunner_l2cap-tester       PASS      16.04 seconds
TestRunner_iso-tester         PASS      16.17 seconds
TestRunner_bnep-tester        PASS      5.55 seconds
TestRunner_mgmt-tester        PASS      106.46 seconds
TestRunner_rfcomm-tester      PASS      8.75 seconds
TestRunner_sco-tester         PASS      7.96 seconds
TestRunner_ioctl-tester       PASS      9.33 seconds
TestRunner_mesh-tester        PASS      6.87 seconds
TestRunner_smp-tester         PASS      7.93 seconds
TestRunner_userchan-tester    PASS      5.78 seconds
IncrementalBuild              PASS      28.56 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============6377548344260856897==--

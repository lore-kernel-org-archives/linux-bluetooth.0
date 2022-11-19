Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0ACC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 03:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiKSDH2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiKSDH1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 22:07:27 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E5B9490
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:07:26 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id i9so4736583qki.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kcKgxzHs1BrMZPY69hirdxAsUaTZKcrQ5TkAqouG6rI=;
        b=DOqBanc6K98uCLIpQ0P8N7pQULbWFR4pjd2LzPX9XWl8X3KMqONofODPhDP5j/mgKQ
         sX1RnmBC01kgVmN4vr4fcywzhKOg6pBq047kyEiEEDBCdN5yXC5hUrNGczVrU11UeE17
         RrAtQ7diTDTAlWtBFpn1tBYX7rAN13VOOvq4paHhDhTlzmOozlpNgWY4fy5kGn3RMRro
         ib9KVxU8+i03JQpeS3Z1X5v7i1sfC8fTMYlSvzhhylY81TF7oW187mt3LLpG8nDbm93L
         WuUES+5ffRZrq52rPCiXcAPotX+lmwvScJQ1ar5aM0N5t1yQCCRZRy1uT+7J1xK56+Fs
         qn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcKgxzHs1BrMZPY69hirdxAsUaTZKcrQ5TkAqouG6rI=;
        b=0lWfLpOvEmlPEEFDgOfoYq1A1x6YCtM/Cl2HEGkH1xKq7yPyVVZkv9mLRxi0OmiDz+
         c0Tp6z4p1tKm8AQQexJ0mp33XTA8aRT4lu3O+SZBOCMqcZ+xLH94kWKk+dFVgQOEUtDF
         Qas344pVET6msjek8DhXKOPcegFEUkNuwNkSyXDqRe1yS+5N1S1dY31MlsoauBB6/OX4
         rTq9JWEnnjeL10+QdQAQKAr2azBgaPi9zVK9e9SI1pwuMaoS6lyHIaZhR9qUW00UrFNa
         aVAn2uuRdt6W2DDg9T2ucdeGX84csUwHIBtZQ560tngrGmGYuw0Zv3PRRlabMvFzagPP
         nelA==
X-Gm-Message-State: ANoB5pljWUn5XvfbFG/QgK31C5wKoctLoPgoZm7iOoRtxkNBSjfyuiij
        q33PrG43dRnkdFc1ifjncrjCjbuI4x82xQ==
X-Google-Smtp-Source: AA0mqf4f2PemWFKkRWfyx3+U3Js5nQaOKq4J8qjVD+HSV0ZlOp33QoBM+XCYacnUj76NztRUFDQAig==
X-Received: by 2002:a05:620a:10b1:b0:6fa:972d:bbf3 with SMTP id h17-20020a05620a10b100b006fa972dbbf3mr7809231qkk.49.1668827245777;
        Fri, 18 Nov 2022 19:07:25 -0800 (PST)
Received: from [172.17.0.2] ([4.246.152.185])
        by smtp.gmail.com with ESMTPSA id y10-20020a05620a25ca00b006f9f714cb6asm3629836qko.50.2022.11.18.19.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:07:25 -0800 (PST)
Message-ID: <6378486d.050a0220.cad97.110a@mx.google.com>
Date:   Fri, 18 Nov 2022 19:07:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9177470810506082051=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, benjamin.tissoires@redhat.com
Subject: RE: [hid-next] HID: fix BT_HIDP Kconfig dependencies
In-Reply-To: <20221118084254.1880165-1-benjamin.tissoires@redhat.com>
References: <20221118084254.1880165-1-benjamin.tissoires@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9177470810506082051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696819

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      33.09 seconds
BuildKernel32                 PASS      29.58 seconds
TestRunnerSetup               PASS      423.99 seconds
TestRunner_l2cap-tester       PASS      16.41 seconds
TestRunner_iso-tester         PASS      15.58 seconds
TestRunner_bnep-tester        PASS      5.57 seconds
TestRunner_mgmt-tester        PASS      106.35 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         PASS      9.00 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        PASS      7.09 seconds
TestRunner_smp-tester         PASS      8.78 seconds
TestRunner_userchan-tester    PASS      5.89 seconds
IncrementalBuild              PASS      30.89 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============9177470810506082051==--

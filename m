Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D265DEB8FDE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 14:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbjIFOpk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbjIFOpk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 10:45:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58921733
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 07:45:36 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bcb15aa074so560390a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Sep 2023 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694011536; x=1694616336; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cEa1xGg59aI25ux4US1z8VznX5bM7SR3XO4z1ZKZomY=;
        b=E8h+ByIRIJ0vBJQkUmBkHZAaXzh6hLYJ9MVMp9k10shc/6vhoEkWzGB2OK+vlm3IyT
         24Z6le+SKw2/kmwWUOcP6K0JilxVr41CRqdvIvls+KzMeJk5zjnQ37UH1eGJEH+QI2hK
         C9P6ZgEaw8d7d2jdhXm669UG+HVrSUM5b9WimO5qAQwXUtyuImCFe9ZDnTT2I5M3nGRE
         M+2q4zOSDp1/TYY0sKZz3ZqFneSEnh3hOmoFoqh7CKYAJFNuZgW+9cRIY/Qr/6lbNYpr
         2jsEQDXytIDcd5zgnaZDPARVQVstON48OPU/rszJB8YjXqBqHBAyg+Xo5U5TXASq03Do
         LaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694011536; x=1694616336;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEa1xGg59aI25ux4US1z8VznX5bM7SR3XO4z1ZKZomY=;
        b=bMhTpbYCAVCklG8gHGg+zQKN+m3o14q1ly6eKIJPU/Hrg3HC5i0LflmU56Bw38NDMQ
         WWzrm3QzZvmQU0o9znX8cHoGTaeBultY4al7pKbUt9J0YgoKW7ZsYYnpW8BIdxGk3+mu
         0BxhVZfqaVwgcBU1HcPveHRFd4GwHVFIPjur6N85AWFvyVEjoIJwfiEQFUu5TcuiiqtX
         z9pbVHPO0XwlJ3wk/isPnsGYj6uvtvFuOxRUC2V4FQ4BNPNWhaGI9Lcgy+5VOWPUoSFU
         idua33XF1iYjFc5oSLYfXws7yDgcmZ+NrdohOD/hDwfnwjr/GqqS5C94p9ysBTf2jgJl
         P07A==
X-Gm-Message-State: AOJu0YyFnfnTycN2ZvsFLxas/+b/44yWi0zaBGqk1umBnCFF+TCRHHTj
        zgl+4igA5hxZT55+zxzqrVrlmvFOMPc=
X-Google-Smtp-Source: AGHT+IEavncS6czUJWCE5y4ohIOqdiEf4HU97muDkFBJG5YsGw3x16wThPynkOLpb5dleOHi5yBcSg==
X-Received: by 2002:a9d:4687:0:b0:6bd:7a0f:5c52 with SMTP id z7-20020a9d4687000000b006bd7a0f5c52mr10546262ote.12.1694011535748;
        Wed, 06 Sep 2023 07:45:35 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.79.87])
        by smtp.gmail.com with ESMTPSA id s27-20020a0568301e1b00b006af7580c84csm6463306otr.60.2023.09.06.07.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:45:35 -0700 (PDT)
Message-ID: <64f8908f.050a0220.79ae2.5a30@mx.google.com>
Date:   Wed, 06 Sep 2023 07:45:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6086163842622862744=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Pass BIG encryption info through QoS
In-Reply-To: <20230906140103.9183-2-iulia.tanasescu@nxp.com>
References: <20230906140103.9183-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6086163842622862744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782009

---Test result---

Test Summary:
CheckPatch                    PASS      1.83 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      46.38 seconds
CheckAllWarning               PASS      51.23 seconds
CheckSparse                   WARNING   57.01 seconds
CheckSmatch                   WARNING   155.08 seconds
BuildKernel32                 PASS      45.21 seconds
TestRunnerSetup               PASS      681.25 seconds
TestRunner_l2cap-tester       PASS      39.31 seconds
TestRunner_iso-tester         PASS      100.07 seconds
TestRunner_bnep-tester        PASS      16.46 seconds
TestRunner_mgmt-tester        FAIL      297.13 seconds
TestRunner_rfcomm-tester      PASS      23.70 seconds
TestRunner_sco-tester         PASS      27.03 seconds
TestRunner_ioctl-tester       PASS      27.44 seconds
TestRunner_mesh-tester        PASS      20.64 seconds
TestRunner_smp-tester         PASS      21.27 seconds
TestRunner_userchan-tester    PASS      17.16 seconds
IncrementalBuild              PASS      42.76 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.906 seconds
LL Privacy - Unpair 2 (Remove from AL)               Timed out    4.969 seconds


---
Regards,
Linux Bluetooth


--===============6086163842622862744==--

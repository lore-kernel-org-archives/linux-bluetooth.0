Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73A3E7B611
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 13:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjJDNZp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjJDNZo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 09:25:44 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044D2AB
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 06:25:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4180f5c51f8so7462531cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Oct 2023 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696425940; x=1697030740; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=parZ1pE96t1B/WiWE/rhl1XX8vxsbtGJZyxCGDL7s/Q=;
        b=QSCieNQwbcGYcT1ua3XrHh7edWEpgrM+/J4Fe6eld85OEMHKBZzF/8e5cfzThbhbwY
         rLTaClh07N6wpTfDZqWs9PT3fG1ufPYa/Pg9fs6GbOQEz/EkRw+74hYdlycoThRHkJGH
         bjyF4/bywOgVBfVOvcCXkcfy2Vxl0pgh2i4anbx65yzv2fPjJmSdknFyHjjN8XxDyyb6
         uEuSpjPPmuqnq2taO0k0naUuwn8nvUfYOKCqzvjUeFzb7N3wPeQ6naxZoQLRLfFORuu5
         OfsZB+1mz3eXrJwC4ipmvorRUCu6PVM+DSkOTI2XqMKjArXs2YDMBfhztoNITw2bhtbG
         MqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425940; x=1697030740;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=parZ1pE96t1B/WiWE/rhl1XX8vxsbtGJZyxCGDL7s/Q=;
        b=YkuC28hRKZCrx5TQ6chEk/PODGUJh0FXgow/t9H1+6VrjQqGVnWp/rfENsNk30reiO
         bAKDjc7+QO0uf9DoXN6aOpNJ++uGxalkZPTIgzyVm8gXfY88kURSkkNU0LIR5kUCX5uK
         j1FicFfhMxTu110BEhzXCTxaaUnnJAM6TBcHbwK0Nqdj0gQdG8aI62HTrfEXeqqmWskI
         JvCi9HDPdmoj4+uVrbanAhUI2cuc4cHabUgHaHZeyvingiKH+iarqxzMilCUVntIPOJ7
         fMOx84H8/wfYgOoVToXPsRKdvNeHZ1NIfjM8rvxPMDa5L0Acx5EsIbXngZZQpWraQXjD
         TZYA==
X-Gm-Message-State: AOJu0YxmENnvmEZuVPITBIaLtVXIJTZTt2eRj4VSIFO27MOxOIsZCu51
        YDbNuGXDd1EEygnA8/Kj09e9QTcZhtY=
X-Google-Smtp-Source: AGHT+IFkV6Q6mfd2i+jv3YoKxMUsrW3RFdiG+QitAUNwCGTC5Xwe4aWtfFJ2mCb106mWee3P8BLqMg==
X-Received: by 2002:a05:622a:1046:b0:407:c2e2:2a06 with SMTP id f6-20020a05622a104600b00407c2e22a06mr6823210qte.8.1696425939886;
        Wed, 04 Oct 2023 06:25:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.75.230])
        by smtp.gmail.com with ESMTPSA id x25-20020ac87a99000000b004198ae7f841sm1209167qtr.90.2023.10.04.06.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:25:39 -0700 (PDT)
Message-ID: <651d67d3.c80a0220.9d145.615d@mx.google.com>
Date:   Wed, 04 Oct 2023 06:25:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8194173198965444625=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, william.xuanziyang@huawei.com
Subject: RE: Bluetooth: Fix a refcnt underflow problem for hci_conn
In-Reply-To: <20231004124224.630914-1-william.xuanziyang@huawei.com>
References: <20231004124224.630914-1-william.xuanziyang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8194173198965444625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789919

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       FAIL      0.65 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      43.45 seconds
CheckAllWarning               PASS      45.87 seconds
CheckSparse                   WARNING   53.57 seconds
CheckSmatch                   WARNING   154.17 seconds
BuildKernel32                 PASS      44.99 seconds
TestRunnerSetup               PASS      652.20 seconds
TestRunner_l2cap-tester       PASS      37.78 seconds
TestRunner_iso-tester         PASS      94.68 seconds
TestRunner_bnep-tester        PASS      13.16 seconds
TestRunner_mgmt-tester        PASS      266.03 seconds
TestRunner_rfcomm-tester      PASS      20.14 seconds
TestRunner_sco-tester         PASS      23.29 seconds
TestRunner_ioctl-tester       PASS      23.21 seconds
TestRunner_mesh-tester        PASS      17.11 seconds
TestRunner_smp-tester         PASS      17.68 seconds
TestRunner_userchan-tester    PASS      13.96 seconds
IncrementalBuild              PASS      38.79 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix a refcnt underflow problem for hci_conn

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
5: B1 Line exceeds max length (116>80): "WARNING: CPU: 1 PID: 26946 at net/bluetooth/hci_conn.c:619 hci_conn_timeout+0x122/0x210 net/bluetooth/hci_conn.c:619"
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


---
Regards,
Linux Bluetooth


--===============8194173198965444625==--

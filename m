Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB4CE77373
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Sep 2023 13:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjI3Ngp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Sep 2023 09:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3Ngn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Sep 2023 09:36:43 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2559AE6
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Sep 2023 06:36:41 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57b9cb05fa3so851504eaf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Sep 2023 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696081000; x=1696685800; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xDc1iO3x3z3vM/uW484Z78UHxHSd4n9s6vkEKyufZkY=;
        b=bUXi14pf6d6xYt27SdT8dVpwmYMuOOUMVHLhAtTZ+Ejgqg7Kh/f+IOQUZHy2TG/SEg
         mnRnBr7hg6jgjIm+kdJBKPeuBlPVdOn/Zmw7e3im+EPypMsICvhentAYNZwgqGLtlj9M
         8Y7/e7bsw88RGZpgl3VneOZLNE4X7AbOAXVNL7oPhB/6cUNT4Io/R6C1JxdBtr7x7I11
         4F6zQgnE+DHzenUA5z/mV77xcbWebExl1v80/gp3947zMNDr2iBhcs7wyqvgQaEk0Tsk
         LqL5ssDeC6Ki9vQPfDCq/K+qlvQR5tAirgCoPNHSW8hn5+8hU68PoXSfFlZWPyqt/ier
         8ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696081000; x=1696685800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDc1iO3x3z3vM/uW484Z78UHxHSd4n9s6vkEKyufZkY=;
        b=rxTyx0l/MYpObUVd0KVFuG4vyMHihwUNujB7mQJjFZXx2MC1uTPC0hYDcRjWiKhEVa
         ssAkvl17vJSwqXmvDYZquYrYgZ/kpz9Q9OR5a03dSqRC8EAazy3sEvfia7g0Gy675GNC
         SDlvHYUjwMaxL5U5KvO5bxr+NcTXDAXLEYgN5TgYBZTM8N4+ZjumK2cxiYrT9kcvl03m
         LURAP2mIu87rTrJB/fJ31tFxUCZEn+/QDU/ip5aH+yREPfWLpJEYz4wy345NgUXRfx7m
         sFY6GDRsqR6hSK4K18l2ORrm9roRr28sosphg63Wq2F+rMNTYpdxW6SicK7mx362OOHi
         QbRg==
X-Gm-Message-State: AOJu0Yy7/R9TrwldV6FEVtMZOh+c/V7IMfRS7fNpcaSauLyGM2qkDrvS
        r3L5IbcA+9hjMiOAln2BuMkiLit8wjQ=
X-Google-Smtp-Source: AGHT+IFjB8x/966H447u/jusIBd4+79oCuuKZWdxbhz/Ikf+un2Shez+J5IbtH44c4k1L2PC7Q/4/Q==
X-Received: by 2002:a4a:85cd:0:b0:57b:e5db:7a4a with SMTP id u13-20020a4a85cd000000b0057be5db7a4amr4665877ooh.0.1696081000194;
        Sat, 30 Sep 2023 06:36:40 -0700 (PDT)
Received: from [172.17.0.2] ([65.52.35.30])
        by smtp.gmail.com with ESMTPSA id v2-20020a4aaec2000000b00573fb6178a6sm3733479oon.44.2023.09.30.06.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 06:36:39 -0700 (PDT)
Message-ID: <65182467.4a0a0220.e243c.ed61@mx.google.com>
Date:   Sat, 30 Sep 2023 06:36:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3781817248936540657=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2,1/2] Bluetooth: hci_sync: always check if connection is alive before deleting
In-Reply-To: <53130b4a5fb21a15f2674c336282d25ef5d2232e.1696077070.git.pav@iki.fi>
References: <53130b4a5fb21a15f2674c336282d25ef5d2232e.1696077070.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3781817248936540657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789014

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       FAIL      0.86 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      33.69 seconds
CheckAllWarning               PASS      36.16 seconds
CheckSparse                   PASS      41.46 seconds
CheckSmatch                   PASS      115.45 seconds
BuildKernel32                 PASS      31.93 seconds
TestRunnerSetup               PASS      489.12 seconds
TestRunner_l2cap-tester       PASS      30.32 seconds
TestRunner_iso-tester         PASS      49.69 seconds
TestRunner_bnep-tester        PASS      9.79 seconds
TestRunner_mgmt-tester        PASS      214.41 seconds
TestRunner_rfcomm-tester      PASS      14.96 seconds
TestRunner_sco-tester         PASS      18.53 seconds
TestRunner_ioctl-tester       PASS      16.93 seconds
TestRunner_mesh-tester        PASS      12.59 seconds
TestRunner_smp-tester         PASS      13.38 seconds
TestRunner_userchan-tester    PASS      10.31 seconds
IncrementalBuild              PASS      37.23 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: hci_sync: always check if connection is alive before deleting

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[v2,1/2] Bluetooth: hci_sync: always check if connection is alive before deleting"
[v2,2/2] Bluetooth: hci_conn: verify connection is to be aborted before doing it

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/0000000000005ab984060371583e@google.com/"
31: B3 Line contains hard tab characters (\t): "        2874	conn = hci_conn_hash_lookup_handle(hdev, handle);"
32: B3 Line contains hard tab characters (\t): "        2875	if (!conn || WARN_ON(!conn->abort_reason))"
33: B3 Line contains hard tab characters (\t): "        2876		return 0;"


---
Regards,
Linux Bluetooth


--===============3781817248936540657==--

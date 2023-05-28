Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFB9C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 18:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjE1Sh2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 14:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1Sh1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 14:37:27 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5738AC
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 11:37:26 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6af896f0908so2005843a34.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685299046; x=1687891046;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hAXSPFMPKBW2HT8uWMOSgdyCxK+aEpfBf+NODq8pRTg=;
        b=grZpHEpqopN3RmCA00Gs1EtEh6KO3h/bMFq9A4lzXATLqc9OFwtbbRGpf5ptofURQ8
         IkrqoWU5FAgVUk2lyEdcBzrqueczotonSFwBL7rPX5ixi2Myyqoi7Y/WeDJg/xnUEOiG
         IQkFOSagCTFppPBTl5XP/QUhvC0eff84UlVirt08fyoFGC1DF2dfGh16LJTTvhgtaOGx
         anKA3iEPohWchWnDaZE8IIZOtkUprCmvml6ml0KbHtvnZBTE0kaulPwyEWv8nW55gnGF
         q82DgZzTCOAhdyls3fecy2D7Umre9p4pNAg7Fcvc0FRD1D1kZ5MORRj5A07fNVpl34+X
         hRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685299046; x=1687891046;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAXSPFMPKBW2HT8uWMOSgdyCxK+aEpfBf+NODq8pRTg=;
        b=JVN4RVv7hkwdSzWLED+/yxEYDykvDxtIu6RzBrTo598ulNhN7wxY8FLkeMb91B6qB1
         F+M6LWU84d0nVyV6MZbadm7YWwdnh/wj1oiEuOOhhn61D784/Eqy1+RPU2OcChjLq5Xg
         AMagkJ2Ntkg58WGXWXZtDqdxTnhs1SHhathQfnKgUJi0Bspc2AXG15BVCrqmGSTcOlL/
         5DV6a0iXxCadiVMZvhcejRpvfG0w+gS6JbOYy10GEG+JG7Iz1gkDieZW3NINb5YOMXwR
         fgn5xO/2r0sO/vQ2riSbaJc5pJDiONqqLOAPl51e3PfHbPN1MRBULFrzDq6QEYTWyCv/
         3bHA==
X-Gm-Message-State: AC+VfDycUYAMG7/rBko0s1pdC62wLjPOlfwWl9W5EYDkj6/Rkp5D0ERq
        feTeZFQA9XXsskVKkNHv5Ms7MoP6baY=
X-Google-Smtp-Source: ACHHUZ4O6IsxgwD+S4t9pkFqnFDfhYiKjsfF61NeKHpFhJ+RTZtNDxSJHbda4VgY74JBa+wQ3wTEyA==
X-Received: by 2002:a9d:684e:0:b0:6af:6de9:1c19 with SMTP id c14-20020a9d684e000000b006af6de91c19mr3597879oto.1.1685299045865;
        Sun, 28 May 2023 11:37:25 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.2])
        by smtp.gmail.com with ESMTPSA id d3-20020a0568301b6300b006af99ac5832sm3880239ote.47.2023.05.28.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 11:37:25 -0700 (PDT)
Message-ID: <64739f65.050a0220.3c91b.1c77@mx.google.com>
Date:   Sun, 28 May 2023 11:37:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1250124167014105610=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: LE Set CIG Parameters / Create CIS fixes
In-Reply-To: <46eefccceb45556120a0d1fa95cf27c576e9649a.1685294131.git.pav@iki.fi>
References: <46eefccceb45556120a0d1fa95cf27c576e9649a.1685294131.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1250124167014105610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751684

---Test result---

Test Summary:
CheckPatch                    PASS      5.24 seconds
GitLint                       PASS      1.85 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      37.62 seconds
CheckAllWarning               PASS      40.98 seconds
CheckSparse                   WARNING   46.29 seconds
CheckSmatch                   WARNING   126.89 seconds
BuildKernel32                 PASS      36.43 seconds
TestRunnerSetup               PASS      517.97 seconds
TestRunner_l2cap-tester       PASS      19.01 seconds
TestRunner_iso-tester         PASS      25.59 seconds
TestRunner_bnep-tester        PASS      6.55 seconds
TestRunner_mgmt-tester        PASS      129.05 seconds
TestRunner_rfcomm-tester      PASS      10.34 seconds
TestRunner_sco-tester         PASS      9.55 seconds
TestRunner_ioctl-tester       PASS      11.24 seconds
TestRunner_mesh-tester        PASS      8.29 seconds
TestRunner_smp-tester         PASS      9.34 seconds
TestRunner_userchan-tester    PASS      6.83 seconds
IncrementalBuild              PASS      90.25 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============1250124167014105610==--

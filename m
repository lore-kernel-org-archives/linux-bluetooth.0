Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8D6C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 07:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjFAHmr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 03:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjFAHkh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 03:40:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6D3E4C
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jun 2023 00:36:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b0478487c3so1687725ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jun 2023 00:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685605011; x=1688197011;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w404iGXLLG9CMCWagZyqh8c4fTPGzxKZaCD+misHwLU=;
        b=gRniD/sIQ4FSFRaD1/cK6bPl3C7epoM6L89j2ifQE/wBrI+ui3j9UNla4jiMbNEP4N
         VWL+SiiHhNnPJePvhv+RdY1a5ChDWALZCeF4pCiMf0NI5jS4rHMMz9sRdkxTFZEJRQlm
         jhBLDvb2DTJqkWjb9cgnIheDm0eNwQsh+PsmrHJg2TedsyTitjFkZhVun3oMMY4gwYMV
         /s2q4GkHXAHUZ2i3/HnFT+kyiZ4GiMILy8WOzT1lOJHorp1D/oG7PZpLb36u5R9A1bsq
         Z88sgXNpnHFfwsKTyISpwvhMX4KEwf3sd5qx2GqVeRbfWSAH/YixOuUNRktGZmsaEAhb
         6OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685605011; x=1688197011;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w404iGXLLG9CMCWagZyqh8c4fTPGzxKZaCD+misHwLU=;
        b=JgYOSJRgKG4XKmjDqYFvRZZVUieMcaXPxQkkmstqV5ZYRA+NxkSIduPuXdk/9EZk6V
         1tIHdK9ANIbQl9tpsR+DhAs3J4BpORUGDsQcrAvv8Y/XYCHst5XlyuNhfgiBoPARrDQq
         3zJLTiHOc+vu4t+x12aml3YFUVoYAMFD+YXjMpjwoVNBsyKlgSXeU34shGcfyVSRvSbb
         uCcB7WBzWbpcqB7ZPr3itrRd59TLph6PVeHN5kLnb21fCN+iE3sS8ONDeVdc/DThvaK1
         jDbJjW8o+RMc0QuX8CbnsS3N1GQwuxDcNRVgWlTmtjFSFNq/JjeHNwXN1SDzRw4sS2ED
         n+Og==
X-Gm-Message-State: AC+VfDxadMNSoFX5TbHFIzyvC46k9LfFEaOn/t6+IG1Z63oix0Ktrsy4
        BkfyzEUtO+beP+xF/cQGxWUlntQ2K7I=
X-Google-Smtp-Source: ACHHUZ4aKR7xQqya/GvZm0YKO7wvu014Vp1sxr/VOjBg01zwrterXhYnvY9NHb1tJysUkgdnb7Kp0g==
X-Received: by 2002:a17:902:c78c:b0:1b0:4baa:ba92 with SMTP id w12-20020a170902c78c00b001b04baaba92mr5039192pla.1.1685605011418;
        Thu, 01 Jun 2023 00:36:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.160.111.17])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b001b050db1894sm2710785plg.36.2023.06.01.00.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:36:51 -0700 (PDT)
Message-ID: <64784a93.170a0220.3a473.5204@mx.google.com>
Date:   Thu, 01 Jun 2023 00:36:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6568576615664573847=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: LE Set CIG Parameters / Create CIS fixes
In-Reply-To: <97114b5f17f44d913c564f4ac8b41726c3a8eeae.1685565568.git.pav@iki.fi>
References: <97114b5f17f44d913c564f4ac8b41726c3a8eeae.1685565568.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6568576615664573847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752943

---Test result---

Test Summary:
CheckPatch                    PASS      3.68 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      38.01 seconds
CheckAllWarning               PASS      42.14 seconds
CheckSparse                   WARNING   47.48 seconds
CheckSmatch                   WARNING   129.23 seconds
BuildKernel32                 PASS      37.72 seconds
TestRunnerSetup               PASS      528.41 seconds
TestRunner_l2cap-tester       PASS      19.39 seconds
TestRunner_iso-tester         PASS      27.00 seconds
TestRunner_bnep-tester        PASS      6.56 seconds
TestRunner_mgmt-tester        PASS      132.55 seconds
TestRunner_rfcomm-tester      PASS      10.70 seconds
TestRunner_sco-tester         PASS      9.77 seconds
TestRunner_ioctl-tester       PASS      11.76 seconds
TestRunner_mesh-tester        PASS      8.46 seconds
TestRunner_smp-tester         PASS      9.57 seconds
TestRunner_userchan-tester    PASS      6.95 seconds
IncrementalBuild              PASS      81.16 seconds

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


--===============6568576615664573847==--

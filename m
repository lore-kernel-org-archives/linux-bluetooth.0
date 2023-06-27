Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17BEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 22:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjF0WdN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 18:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjF0WdM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 18:33:12 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A77211E
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 15:33:10 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7836272f36eso96518939f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687905190; x=1690497190;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hqSQrN8MAGBAo6GDIhqDkqOROUf72pifgPYi221wRIY=;
        b=hNMnATSbyErhgRsKheOVo17l/EHVBxMd0kCAQGoan5vq4M5FVw3EIygPgboLOtOMDp
         H7z7M5Bm/lQdAjghrkoDheece6kZRd3VcB1rH/MEET5NVbttYaY6mwtV1qIEIPD0WI3A
         O6k9GxtYmdzn6ilYlboDxyV/q5tTQvppgV5nTYcZNrVkzG29aEa4m3fYJAWX3kIr11sD
         suHu9ybdVNSfFOrlGVlDT4KIBnGIOkFakBZXNFXlwgdYTK1xZ2dmjSsPJOxYoRQhkZIw
         fqi2e9vSWZTXBQl6j+FeHYjWKweR0HnWj3BrvMve3hKTd2PyctMG9z7GvyM747dd2Eqa
         eKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687905190; x=1690497190;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqSQrN8MAGBAo6GDIhqDkqOROUf72pifgPYi221wRIY=;
        b=T5js8rStDyjqDX9ltQFIPiN7v+aQJ8VjL5De1eLdegIkUeIGZzKxpFrBm8niaFxka9
         ZTOoDHBvof+U2yz5yl8iNslRRwHCWgW51fu9a96fYW6D9gVIDTsQUQMvBQ4KoOHz8cB5
         /RTSZLbbwdoAo7SaVfKYuzNhFP6a3nIvmLeBZTGU3J0MQNAcDaz9rslZM176NDR4vOZH
         PsoZxBwJKE8OqP1ABD/ONE806q8r7uVvTK9yfeMrh4IJChYavz+azHA+TZGKpqxKv5l1
         fZI8aTi05F0XY74XfTuR2NVjY/Otshz5EkTtoAgYwGBOLKQl6kH3IQtFVHTsY/EQFizM
         Cx9g==
X-Gm-Message-State: AC+VfDytQvlGgNzMDX2O6X1De2ga3vQXoHeRD0OH7Fd3uFmq2m8VlJdB
        JmQL4vIw9ZIxlxCX2gJs+WSLng05N/E=
X-Google-Smtp-Source: ACHHUZ4i/fzu2sEnxqiXofGXNdDzzbRpfu0xMo24TCS4AGVezTxqMLr7lGSO8h9NH2PJR1O8ZYPS1g==
X-Received: by 2002:a92:d08a:0:b0:345:8373:4ca8 with SMTP id h10-20020a92d08a000000b0034583734ca8mr10545130ilh.27.1687905189619;
        Tue, 27 Jun 2023 15:33:09 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.45.158])
        by smtp.gmail.com with ESMTPSA id v12-20020a92c80c000000b003426356a35asm2958668iln.0.2023.06.27.15.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 15:33:09 -0700 (PDT)
Message-ID: <649b63a5.920a0220.c6db9.3d77@mx.google.com>
Date:   Tue, 27 Jun 2023 15:33:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8533304711327968779=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_conn: Consolidate code for aborting connections
In-Reply-To: <20230627215301.2648840-1-luiz.dentz@gmail.com>
References: <20230627215301.2648840-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8533304711327968779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760750

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.11 seconds
CheckAllWarning               PASS      34.85 seconds
CheckSparse                   PASS      39.32 seconds
CheckSmatch                   PASS      110.88 seconds
BuildKernel32                 PASS      31.18 seconds
TestRunnerSetup               PASS      441.19 seconds
TestRunner_l2cap-tester       PASS      16.34 seconds
TestRunner_iso-tester         PASS      22.12 seconds
TestRunner_bnep-tester        PASS      5.21 seconds
TestRunner_mgmt-tester        PASS      125.89 seconds
TestRunner_rfcomm-tester      PASS      8.33 seconds
TestRunner_sco-tester         PASS      9.77 seconds
TestRunner_ioctl-tester       PASS      8.92 seconds
TestRunner_mesh-tester        PASS      6.57 seconds
TestRunner_smp-tester         PASS      7.69 seconds
TestRunner_userchan-tester    PASS      5.47 seconds
IncrementalBuild              PASS      29.16 seconds



---
Regards,
Linux Bluetooth


--===============8533304711327968779==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C58C43334
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jun 2022 07:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiFEH4v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jun 2022 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244537AbiFEH4u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jun 2022 03:56:50 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC20C6361
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jun 2022 00:56:48 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d128so1155339qkg.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jun 2022 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=SO8PI3LNmuoHJSTOm1nypI2nR1Ll2CFwRgjC34+7pTY=;
        b=qamGMwWwM/+krsX1kUw8qd2N72k8exMf7QSvP17AUG9yw0ix9gCn7TSb1/m0EHDHlS
         6fpFEnU4ewIJk01M9kqgx8hlg/fmkfvTePjqWmt18CZIUd3ROERnoY+VLzx6xTMDEAY7
         M2+brQkaKWW/ZhbMV9GPRYFivytAlNesoMhZ32AX+xnpJaIWybecoFNRra5rR9YR/V7c
         yTQRdXGn4d2RHR9h6CaXAs8F+wyHoiWyrZ/qF+HdLe6t6wWtE2G4TWgxAp4MaaZZa+Ja
         0CSGWX2+UKb3KxDAhiAJchb3+3gOUPNrFv1cTgHzuxP1ep05vMPWdf3V1z6KjBuPXPix
         bMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=SO8PI3LNmuoHJSTOm1nypI2nR1Ll2CFwRgjC34+7pTY=;
        b=H6T2KrZpIiSxsLWadNc8Sz5Y67DBW1HbFajkWcMnNF0UFrkhuqlH5FxC9dTd8euzKL
         6yq07Wtz/1ECcDZ1U3ibb8aaB+0SHJYLVNiAJMRGLl3LI1xIb7yyLkoAgsSXEUj8fLlw
         8egFcwO++JI6oNKMfGZbcAzOqYeNHw89KaVqWJGqACjBtmvVoO4Jxq2FLCNO9MG3cFFt
         G8OLYzqgz//rp2bjyk/KYOJHFGALVTpKohLXiJiT63AzKl09yQBCPhtW0lOF3BXFt99G
         DsM/6U2bpPNqBmO961pi3a3xCoZjqm2JSYjncvKpZ0slJfI93PSaVnTzk8gfcyOZK/MO
         FL+Q==
X-Gm-Message-State: AOAM5324OpJnCRGZy54hRLiss8kyh+G0PY0IjYVBaQniE36jQKF3a3xi
        OYfsCo8qm3i0fIicNqfGCMIC1H/ojEaPwg==
X-Google-Smtp-Source: ABdhPJxYo0+z7y0oV3pXoQnQMvnaSsb3DZMdQTtgzp2719/L5sHkKntkijFvqvoVST8ABnQhq+jFyA==
X-Received: by 2002:a05:620a:4155:b0:6a5:76e5:82c6 with SMTP id k21-20020a05620a415500b006a576e582c6mr12077155qko.420.1654415807835;
        Sun, 05 Jun 2022 00:56:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.65.215])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a430800b006a6acd33f18sm2886224qko.8.2022.06.05.00.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 00:56:47 -0700 (PDT)
Message-ID: <629c61bf.1c69fb81.322da.9c1f@mx.google.com>
Date:   Sun, 05 Jun 2022 00:56:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9192247719003336860=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, linmq006@gmail.com
Subject: RE: Bluetooth: btbcm: Fix refcount leak in btbcm_get_board_name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220605065614.1332-1-linmq006@gmail.com>
References: <20220605065614.1332-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9192247719003336860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647420

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.92 seconds
BuildKernel                   PASS      32.38 seconds
BuildKernel32                 PASS      28.97 seconds
Incremental Build with patchesPASS      39.52 seconds
TestRunner: Setup             PASS      478.23 seconds
TestRunner: l2cap-tester      PASS      17.54 seconds
TestRunner: bnep-tester       PASS      6.12 seconds
TestRunner: mgmt-tester       PASS      102.36 seconds
TestRunner: rfcomm-tester     PASS      9.75 seconds
TestRunner: sco-tester        PASS      9.53 seconds
TestRunner: smp-tester        PASS      9.60 seconds
TestRunner: userchan-tester   PASS      6.45 seconds



---
Regards,
Linux Bluetooth


--===============9192247719003336860==--

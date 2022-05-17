Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E403C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 May 2022 11:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbiEQLIU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 May 2022 07:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344910AbiEQLIE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 May 2022 07:08:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977816255
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 04:08:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v14so12857837qtc.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 04:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OBY5L6LwPWujuWYMIyNcagIkTZvWSrFZntzyhkKLMbo=;
        b=Ifue4sxZYNSUAAs9mk9SSXndIbxEYzuWkbFzNTtyRKVoSmXY7IOwxBT29Fc7fa8VL/
         WM8ltnXDgz2XWMkGc6C+LLrENd36XcTYKO5/tRbAtJDkKwHeMbX0G8Kg9U8qUqpKKOzx
         9jt4Y/wXml1pJOA91ddZkPfaLRulmyHaD36bWJfZrx9frOil/SdCjHoFBBjisZ5fE+40
         olYLqgCF3tpMod2/MBn7EhHmaB+ae5zZQBaikeiDUBNY2VUq0seeLKKA0OP3qUA5Mrvk
         Ye9C+bBqL1jK0ChMa3VQp8vyKxeEDRW6efRRZOHm086QCf2vW4WB+MQFn78CcwOg3gvw
         1Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OBY5L6LwPWujuWYMIyNcagIkTZvWSrFZntzyhkKLMbo=;
        b=0u9EnL6DKWKr5rcmjGINhAcOfDy9k7UxwWRNT4ulrMB5tcExhhwAOP91evSTOj+2CK
         RcpwdKgl8+jo4ybc0R9O4Ee7tzLbdWCjYZ6TogCCblIpiqSyUATazAO1vsle3Cek79FY
         jwWCAOZ5ykZUxoPQvvKDNtR8IBiZowxIvFV8fse2OlSqora3rGnN7zkkHyCXx3OyNjq9
         064FmgjX32EsiOEVwEcpWkxux7cFG8Spn8w9HI+3YB0r4GekUVL1q4XGUa0G338caTwp
         lnkcn+WWKsN2XUXYcggjJGc/NZuqOjLgj14jMPeejVfpWKktBIupHVdiNISzUJgbz3ga
         2XwA==
X-Gm-Message-State: AOAM533kLoIYalo5xkBb36gBuXSLk+MlrqqqeLjsb1x6a7Wx0ZwAt+MS
        5xxHP94J+1YvjVA66PC+slOoOuV0ADWcRQ==
X-Google-Smtp-Source: ABdhPJydls8DxCNjXScOWBdrOja4OD5i1YDBhWB4Dp2MS9KOtsAEh4hnGzmuctvPEtX87ymMNR5kGg==
X-Received: by 2002:a05:622a:1d2:b0:2f3:f4d4:4c63 with SMTP id t18-20020a05622a01d200b002f3f4d44c63mr19026487qtw.678.1652785682575;
        Tue, 17 May 2022 04:08:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.170.31.24])
        by smtp.gmail.com with ESMTPSA id f6-20020a05622a114600b002f39b99f69esm7495204qty.56.2022.05.17.04.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 04:08:02 -0700 (PDT)
Message-ID: <62838212.1c69fb81.e896e.7a0d@mx.google.com>
Date:   Tue, 17 May 2022 04:08:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1605916444815077385=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, poprdi@google.com
Subject: RE: Bluetooth: Collect kcov coverage from hci_rx_work
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220517094532.2729049-1-poprdi@google.com>
References: <20220517094532.2729049-1-poprdi@google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1605916444815077385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=642289

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      30.85 seconds
BuildKernel32                 PASS      27.42 seconds
Incremental Build with patchesPASS      38.41 seconds
TestRunner: Setup             PASS      466.08 seconds
TestRunner: l2cap-tester      PASS      17.39 seconds
TestRunner: bnep-tester       PASS      6.12 seconds
TestRunner: mgmt-tester       PASS      101.74 seconds
TestRunner: rfcomm-tester     PASS      9.64 seconds
TestRunner: sco-tester        PASS      9.45 seconds
TestRunner: smp-tester        PASS      9.42 seconds
TestRunner: userchan-tester   PASS      6.32 seconds



---
Regards,
Linux Bluetooth


--===============1605916444815077385==--

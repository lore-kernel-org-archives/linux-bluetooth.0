Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF26C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 11:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjESLcK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 May 2023 07:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjESLcJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 May 2023 07:32:09 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A40C1AD
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 04:32:04 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-61cd6191a62so13554336d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684495923; x=1687087923;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AFJbXOx2DsT6BABp2X1f33cuGuNTFUeSfpAokIrN4B8=;
        b=G4XZ+D0BDml1y3Xp9vt1eLl3g+Vk8jq/9oAs/e/Mvej9VN0KpGrvPiqqJqRmHuGSIf
         ptyckxqCfOl1hGf5mKUs79CzUEttmRB10K4dl9VKBbMcwcMSGV6+2xjXxiteMkKQtYdC
         4FpjH180CNCD+ivz9j2tboJZZ+vrjRB209gLuCF7mouzW+pG1y1tU6VYQhOWQxMuV8rB
         2iuQiy3MNrqRmHLzgRds3KJQT1f3lE1vEJOpSdKyUfaKA8AGFPdnYFtUoyoqzh5ahEb8
         dYwv4A6wZGeIEjVSY7OdmcWZTpJ9r8YZu2YKsMTVqxYAAsX6I7dqt7qDYg5KPq9m/Fmn
         i6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684495923; x=1687087923;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFJbXOx2DsT6BABp2X1f33cuGuNTFUeSfpAokIrN4B8=;
        b=gSZFp0Bl9QUN+4RI8KdeNg+Zt+Agee8YajELqQlgyl85D8zgsE1Rp22c3WTQXANk6e
         S05fPWW/XOxgJTywX/3mtFXLj82wVmVfqw5nSzdmslrk1lX5VsuPGJo5mkQyHtGOss2Z
         eHL2oEXMWvz+uP4HxpyT+wFD/k4wvESawuPfufZnXw6ljrgPLEGeLWFHQFIXhW5bEnje
         yeCPzut5lmZ4vnYIjlfQRcUTcAnTTniI3xTkYWOos8YRv0q+rboJ9omBaep1tKr8MtMZ
         2oFwQAaSDBGVBMO50USIdP9MLQuyh5SzQvrYcEzxyCnDhiSzuJPcQUfjHv1lToQsFU7Q
         3aSw==
X-Gm-Message-State: AC+VfDyFTsrXkqJQKotdBQXQXPZKVEVjT3Igb9lepwLTzulrLIS1rMtR
        X11VzS9H+7d5FjBmtjTymW+PO9h88NPu5g==
X-Google-Smtp-Source: ACHHUZ7Tap/QS+9iz0jQB99jEBja7D0plflyDtMxYiJbVL6oUT0oBmOgNKjOcgnce1LOutGZomMlEw==
X-Received: by 2002:a05:6214:29c2:b0:619:152a:b9a5 with SMTP id gh2-20020a05621429c200b00619152ab9a5mr3173745qvb.10.1684495923550;
        Fri, 19 May 2023 04:32:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.73.33])
        by smtp.gmail.com with ESMTPSA id dj17-20020a056214091100b0061668c4b426sm1246419qvb.59.2023.05.19.04.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 04:32:03 -0700 (PDT)
Message-ID: <64675e33.050a0220.b3d97.5ab5@mx.google.com>
Date:   Fri, 19 May 2023 04:32:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3910150811171397072=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, minhuadotchen@gmail.com
Subject: RE: [v2] Bluetooth: btqca: use le32_to_cpu for ver.soc_id
In-Reply-To: <20230519104324.4623-1-minhuadotchen@gmail.com>
References: <20230519104324.4623-1-minhuadotchen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3910150811171397072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749213

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      34.26 seconds
CheckAllWarning               PASS      38.13 seconds
CheckSparse                   PASS      42.86 seconds
CheckSmatch                   PASS      116.41 seconds
BuildKernel32                 PASS      32.57 seconds
TestRunnerSetup               PASS      467.00 seconds
TestRunner_l2cap-tester       PASS      16.88 seconds
TestRunner_iso-tester         PASS      20.97 seconds
TestRunner_bnep-tester        PASS      5.53 seconds
TestRunner_mgmt-tester        PASS      114.93 seconds
TestRunner_rfcomm-tester      PASS      8.66 seconds
TestRunner_sco-tester         PASS      8.07 seconds
TestRunner_ioctl-tester       PASS      9.39 seconds
TestRunner_mesh-tester        PASS      6.96 seconds
TestRunner_smp-tester         PASS      8.03 seconds
TestRunner_userchan-tester    PASS      5.76 seconds
IncrementalBuild              PASS      29.92 seconds



---
Regards,
Linux Bluetooth


--===============3910150811171397072==--

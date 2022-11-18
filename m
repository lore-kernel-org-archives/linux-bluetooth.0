Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A49C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbiKRERi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiKRERh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:17:37 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1CF6151C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:17:35 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y10so2343553plp.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pQDkeRTGEYiRjVeajeTAXCvHJQb7CJyirS2G83etKDI=;
        b=CrlxzRzPzvSXTHtK5PXF0+2/ZlaeU8YD2iNAE325ozaO0BwuWOLg6VJmFtHVVo5DuY
         zHCKsAxH77ZC/Uu6jTaoV+ySwQ0lkQZ1OGbgH3hNzKVi1O6QD0Oe+MeIvVkTAdKB2QTi
         9q7irmr5MWTVnZs0ItCEcH0Zr3650PgciVr+ehgBC1GX0bCpBehuEFzGL5dkovLq5hD8
         8OSoeHTPtSovMOZdtqtF0eFVBkG3WkfRSVajYHm5UQWGO1FzxhG2pSr7J9zdis5T2DF8
         UmWL4iQpovzzC4yFdpHb3XZAyATgWrrlk3qHJWbQnPs8KLOlg8NINcekjayB11V9qk6f
         b+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQDkeRTGEYiRjVeajeTAXCvHJQb7CJyirS2G83etKDI=;
        b=sQ6jbnKkun+kWA9d/K+58TEuJx8bU8LSgXCYK69DLQ4p10f55reHL9EKAbb4IyZRu/
         DXbeQBPfrvs4NGG3jOAqIIUyCO9hPCLo5PSFq32hsc+YQ1/8VUfsT0eia78aiDwD2Dz4
         otCIZNsSZzjIvumbvqj5efS9CLlUxyNySird9fqsdDaHXknMueAXowIdH9a5fb1Lbr16
         I1Fi4YnDcwDTkCFff8xAYAxNrWhxq+sAKyKw4CEFeULUvcKZtWoIm3A5uCUhuBzPG9Q5
         Gz+/tUFXVEw2IiWp6G4RKRNB5YFcKJmPw0AmzQEkourM7CEhmZi/3PZR5iExi/tafGi7
         zkMg==
X-Gm-Message-State: ANoB5pkdL0ESbVaw1hJ9T3jt4pI3i5JZVZyKPuw11Zx9nMVBLqJgZo9S
        ReUF2KRQo8JrvkEYI16XgS1bcBwAbCM=
X-Google-Smtp-Source: AA0mqf6PaG0EwyvL8PekKJdVuQamBfHKlZTcsG7ZgMBNm9aRKuzV18tUXubNkCb/av3lvzvu7DFVPA==
X-Received: by 2002:a17:903:2642:b0:17e:fb19:63ba with SMTP id je2-20020a170903264200b0017efb1963bamr5696799plb.160.1668745054871;
        Thu, 17 Nov 2022 20:17:34 -0800 (PST)
Received: from [172.17.0.2] ([40.112.163.31])
        by smtp.gmail.com with ESMTPSA id 124-20020a620482000000b0056c2e497ad6sm2071302pfe.93.2022.11.17.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:17:34 -0800 (PST)
Message-ID: <6377075e.620a0220.21e26.3be8@mx.google.com>
Date:   Thu, 17 Nov 2022 20:17:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1000058349014676221=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1000058349014676221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695798

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      40.50 seconds
BuildKernel32                 PASS      36.69 seconds
TestRunnerSetup               PASS      504.44 seconds
TestRunner_l2cap-tester       PASS      17.83 seconds
TestRunner_iso-tester         PASS      18.51 seconds
TestRunner_bnep-tester        PASS      6.54 seconds
TestRunner_mgmt-tester        PASS      120.17 seconds
TestRunner_rfcomm-tester      PASS      10.78 seconds
TestRunner_sco-tester         PASS      10.24 seconds
TestRunner_ioctl-tester       PASS      11.72 seconds
TestRunner_mesh-tester        PASS      8.15 seconds
TestRunner_smp-tester         PASS      9.88 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PASS      37.77 seconds



---
Regards,
Linux Bluetooth


--===============1000058349014676221==--

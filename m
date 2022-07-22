Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15220C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 03:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiGVDQ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 23:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGVDQ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 23:16:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA95621AF
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 20:16:55 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h16so1776841ilc.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 20:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1ufy3JGcO0B84k1GMtDiJT5NdY+lnj8bSnZK5Iv01jw=;
        b=RT+H4XF+RktgGpLYzYXR7+DUBgOJ2Q0QkUJP5sBpj5BVFZagJa06bJETXfHewJBcK9
         oU4fKoOK4MWWjRm0wnAcDI/jeCsLurNRtDqlbWfrpSuM+1sHTWgR5mKX8gFAf9hY9LYd
         ooQvPMxMcbV3+2Ne0zRXmog5FXaegi9KL7XpkhRJP66gyI9pLIO6qUNvI9pjHHFLZCmd
         Apevh2CihBxIqzTLwTXGHPy3GXvPZyBi1L6FOyB8YmlxyXMrwLD2ZbJc+Nql2OL0I2Wk
         bRPhY6LaNbWWso74HSNAGmPYIKQm0wU3VcPOXbbbRX+nUMIDQIRGX+pVLTwhSwjmsga9
         fmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1ufy3JGcO0B84k1GMtDiJT5NdY+lnj8bSnZK5Iv01jw=;
        b=W7juwgwgK826yjP6/ubbw5UTSQpWJMKbQXn9h84TkrNCUFF9s1Y4qwA6NaDyNnuvDZ
         Ko36BZDgujVQhmpIT19Cj5BeGdf76PVyAs905gjj5GPTQcd0WdN24L5t68C4Dr20coGx
         Tlb6rjoutsVYl6f5ozp0Fm7Rgv3JQRsZ7JOn4U5O8l6YL7SswP5FTIjPz9eob1Kthi2n
         aQSzuLSKjmCdE1VP4KldMNYNqH3FEv6a7m+opOhlMIXCgAZNRYnwFGhw4CkCdkt3gc15
         uUcS07KG0hZ+LldgF180w6cXr7nO1a2YN+XeYh8vDjHGQjT3NI0UkZbWpoAJwzs4opkC
         glVQ==
X-Gm-Message-State: AJIora+LLzhulXQ9e1/cT0unZCjYY2bvrhvAQY03J/CVVnddmEgpZkdY
        ght6tLf+EqVGzLI1xDn1Gs0LAl/1jlE=
X-Google-Smtp-Source: AGRyM1s/QCT1Oboal31LJFLu0XDR0bDUgmbMmgAkycOzUsUbu7iHCx66eF1NwsARbqYI8cWZptjJkA==
X-Received: by 2002:a05:6e02:158a:b0:2d3:f1c0:6b68 with SMTP id m10-20020a056e02158a00b002d3f1c06b68mr683352ilu.38.1658459814885;
        Thu, 21 Jul 2022 20:16:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.113.243.56])
        by smtp.gmail.com with ESMTPSA id m4-20020a02a144000000b0033eff75fb32sm1505611jah.15.2022.07.21.20.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 20:16:54 -0700 (PDT)
Message-ID: <62da16a6.1c69fb81.af88d.1e7c@mx.google.com>
Date:   Thu, 21 Jul 2022 20:16:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1039673730188202316=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: MGMT: Fix helding hci_conn reference while command is queued
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220722002600.632792-1-luiz.dentz@gmail.com>
References: <20220722002600.632792-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1039673730188202316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662034

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      0.86 seconds
SubjectPrefix                 PASS      0.63 seconds
BuildKernel                   PASS      36.42 seconds
BuildKernel32                 PASS      30.98 seconds
Incremental Build with patchesPASS      51.65 seconds
TestRunner: Setup             PASS      542.91 seconds
TestRunner: l2cap-tester      PASS      17.68 seconds
TestRunner: bnep-tester       PASS      5.95 seconds
TestRunner: mgmt-tester       PASS      100.44 seconds
TestRunner: rfcomm-tester     PASS      9.54 seconds
TestRunner: sco-tester        PASS      9.29 seconds
TestRunner: smp-tester        PASS      9.35 seconds
TestRunner: userchan-tester   PASS      6.11 seconds



---
Regards,
Linux Bluetooth


--===============1039673730188202316==--

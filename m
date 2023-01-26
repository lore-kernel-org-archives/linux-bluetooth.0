Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98721C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 17:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjAZRgE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 12:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjAZRf6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 12:35:58 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E16ACB9
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 09:35:43 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id m26so1864097qtp.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=anpMbEVRblybJ0tnnRqcZwVZoie2rKc9wCS16bNa+yQ=;
        b=iWhvy2/GyB+41xYGajH2oXpXf2oafSDwYyfDrRCC/lkmtaHiV5ZdC46YW+e0PjT724
         52nuVNNl47NUEakUHlyc5QTt8OFvaMLwp443jOBXpXx90lftCeJ7UsDOr++RGp7mWGJA
         TqDMJ6X9qfnbKQMR559XUXgRj+ZWbYBfe/ONSSOC0aX06ZRWD0bcLpWs9YyqXwyYDCqv
         r0FbSdjtHQP6EyEILGc0vWzjoOHP1EgRjYCHv+fqLXyUyBVhvm4KsfE9mByEOJ/bJtvM
         /cjgIRyz4fzrFfpw1DC16FqsrOrpHtNXRWv/DEzhx9J118sfV0osI1jfaoYNz53OONK4
         VcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anpMbEVRblybJ0tnnRqcZwVZoie2rKc9wCS16bNa+yQ=;
        b=huBfZlPem7cCsixa9F76v1M04wQWa+Guuqtbjk38bbMOgl+RmNzvm0FZpKMMxCh9Br
         DQX8mZi120xAXGl6rjb8Ps8GfNKo+K9/KdHdGaKVvj7k/PDhWcR/65UmmQtuUBIvudJR
         iYuKwHWqMuQp1t6sNIMC03aH3Al35/SsSxVXyOpDnjPOAeIrJCaJ1d+NWR4lupMWL8Oe
         G1LG4PLaZ45MLQ3Pyv0njE0PD2km+jroFi0TTkColiT+kMiJnA8MhEZNq8M5PNOUnRFp
         60Itvmq7FEZvko774pCwo+dPIPXIsI/fSnQQ997/JOt9XLBHul6ee5dRcbnElkhywyE7
         Fseg==
X-Gm-Message-State: AO0yUKUgKPNDpc+vqKfAkgUPHwym9g1wT91vHLwWAvNIYXPRX4e2b+sl
        uDD5BTrUpzSUHg0PfPicBIq+hzNNI4E=
X-Google-Smtp-Source: AK7set9vkuq6WLz1KDKl9+/BXFi0kINzb70aoxo3ZcFopncGIgoM+GNszn2j0oXvG49b31OqMJ8bfA==
X-Received: by 2002:ac8:5796:0:b0:3b6:2fcd:6d3e with SMTP id v22-20020ac85796000000b003b62fcd6d3emr12150945qta.33.1674754542686;
        Thu, 26 Jan 2023 09:35:42 -0800 (PST)
Received: from [172.17.0.2] ([104.45.204.48])
        by smtp.gmail.com with ESMTPSA id u20-20020ae9c014000000b006bb29d932e1sm1228681qkk.105.2023.01.26.09.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:35:42 -0800 (PST)
Message-ID: <63d2b9ee.e90a0220.863c.3f4c@mx.google.com>
Date:   Thu, 26 Jan 2023 09:35:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1043284415188947935=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, macroalpha82@gmail.com
Subject: RE: Bluetooth: Add support for RTL8821CS
In-Reply-To: <20230126165529.1452252-2-macroalpha82@gmail.com>
References: <20230126165529.1452252-2-macroalpha82@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1043284415188947935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715934

---Test result---

Test Summary:
CheckPatch                    PASS      2.17 seconds
GitLint                       PASS      0.75 seconds
SubjectPrefix                 FAIL      0.58 seconds
BuildKernel                   PASS      38.49 seconds
CheckAllWarning               PASS      41.50 seconds
CheckSparse                   WARNING   47.05 seconds
CheckSmatch                   WARNING   127.35 seconds
BuildKernel32                 PASS      36.70 seconds
TestRunnerSetup               PASS      526.86 seconds
TestRunner_l2cap-tester       PASS      19.05 seconds
TestRunner_iso-tester         PASS      20.75 seconds
TestRunner_bnep-tester        PASS      6.80 seconds
TestRunner_mgmt-tester        PASS      129.94 seconds
TestRunner_rfcomm-tester      PASS      10.75 seconds
TestRunner_sco-tester         PASS      9.87 seconds
TestRunner_ioctl-tester       PASS      11.82 seconds
TestRunner_mesh-tester        PASS      8.72 seconds
TestRunner_smp-tester         PASS      9.75 seconds
TestRunner_userchan-tester    PASS      7.21 seconds
IncrementalBuild              PASS      40.32 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1043284415188947935==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F49EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 12:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjF1Mr6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjF1MrY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 08:47:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484EF30FF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 05:46:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262ff3a4659so2163313a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687956383; x=1690548383;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r3Mgp07LRj1ckSQxFTluRF5f3HQQmQni5YPKYH9sjTk=;
        b=DgdsmUAxOtsSq1lf9SP8EK3Le4Fxd4aglZd/Pc4QH4SFNCNDPzHQesAsfdehR1pZAQ
         0DC7C5Z1YjZxyygO6DVk4BwVSJgMcwR+3Q7xeO2ORwWK5uxR1amF5urKaBwpPpCx8wng
         Y1t9ZWW6qu0+jnjeTrpinFwX2b8MpT39elqlryYr1pSjR6O4fr/3QMYE2u01kMpixH1O
         JlqLf7gaDXl3BQ2uYspaQNXS0xjlqxIFsVzcjsbIsLydM0GXkSJPL3K2qWEICBzyDxPd
         UMOYshJSF5VWLQiKCZkOkV9G2i6/WgdNRL0jd2lZd4/s1hjqxDP7TlxtabQCNF+EZKGx
         aACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687956383; x=1690548383;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3Mgp07LRj1ckSQxFTluRF5f3HQQmQni5YPKYH9sjTk=;
        b=FWi4AaOlamfJzkg0SdcrYrnCLaqMjj5aOEjlWKAityE60QUluTRDUeVNJt2RWU5NEk
         k0P/flCvm4sKjHIj4eCS1W06wjTxw6rXDTfUvQcfBsj76M9Omo839pu3MHB9PKf7YORs
         6QthIAgwodKwhf/iu5DRNsfEZ0u57jQfLQ+JgQjJXfx8tBCcw74Dm+b4M6OsT/gREGs+
         faraUkjetn1OUe9PzSVAW03eYUCDU2DOiQUgeVjj6mUywndObEmBzJHMIoYkDdptIWgC
         0nK+kiCauTVzLx4+bismgjnBj5ukI/KZdPoo/hNI1UP9mwnrYE+oQgJUF/rIkMSsnUvH
         wnHw==
X-Gm-Message-State: AC+VfDwKU5rXTAugsnwS1RrrNmZyGn63ndCakJQZz+6DERqVylDKUf92
        Eu7Qib+mUmfK3+bsGNH96Laasj8CjvY=
X-Google-Smtp-Source: ACHHUZ4p1qTA//u7YqGDBbfHyyeXh56DuCOc2hJ72meKcNm2Z+YLHzLEsBvEbPd9lQnp4o+G6BXT3g==
X-Received: by 2002:a17:90b:4b88:b0:262:b22b:d2e8 with SMTP id lr8-20020a17090b4b8800b00262b22bd2e8mr14673654pjb.17.1687956383521;
        Wed, 28 Jun 2023 05:46:23 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.87.55])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090aee8c00b00263418c81c5sm1164989pjz.46.2023.06.28.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 05:46:23 -0700 (PDT)
Message-ID: <649c2b9f.170a0220.975b2.1ec3@mx.google.com>
Date:   Wed, 28 Jun 2023 05:46:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5627691978859321936=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel: Add support for Gale Peak
In-Reply-To: <20230628121831.827171-1-kiran.k@intel.com>
References: <20230628121831.827171-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5627691978859321936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760925

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      36.48 seconds
CheckAllWarning               PASS      42.05 seconds
CheckSparse                   PASS      47.77 seconds
CheckSmatch                   PASS      119.50 seconds
BuildKernel32                 PASS      33.54 seconds
TestRunnerSetup               PASS      487.52 seconds
TestRunner_l2cap-tester       PASS      17.85 seconds
TestRunner_iso-tester         PASS      25.81 seconds
TestRunner_bnep-tester        PASS      5.78 seconds
TestRunner_mgmt-tester        PASS      146.29 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         PASS      8.65 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        PASS      8.00 seconds
TestRunner_smp-tester         PASS      9.51 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
IncrementalBuild              PASS      32.61 seconds



---
Regards,
Linux Bluetooth


--===============5627691978859321936==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684E9C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 04:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKSEgs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 23:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiKSEgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 23:36:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CC92085
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 20:36:45 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c203so6687978pfc.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 20:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VocH6WCDBVMC4MXulKlGr5nqKXOv9u3f8utubT5EDrM=;
        b=LkQlT1lZBEvhICVs+G9frOwmzaf46RtkUzqdszzgZgKWRIuOFCBFbzmM0fxhCpi1ae
         8I6h4DfyyvvS7qbktYnKm2cCXrVfOLJZFY6a0EDtgnCYcd1QeHD2RzUVLW03BLa5CUuE
         jmRkU+Bs1BY33MyTk7X/KWTrBhmRwWrPOFZozdti13XoRUFuqLRwpyQOH90R80u6lPdt
         pC+2S7OpCE6V9mcbGSQe7BLl2gH5RFUUplHlZKdzazfqwLgnnTp8fFeoLZ5YYRf5m07p
         xih5QOVjWbKlgMjuSKhKTlo3e6oOhavKXO3whq1IanO+6S/3mdu5p1uKE9xsYX1U9wla
         CUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VocH6WCDBVMC4MXulKlGr5nqKXOv9u3f8utubT5EDrM=;
        b=b6Oh954YBLtUS98oRQfHJyoUs1DXq28g1Iky6+nCHEzTEajp92fTnwaUJqPZHjBWCl
         +KzXU4OB/y74qPq1d7n5ESwD9msflJLdye//Gy6tKDXADsvExbh0r77A3X4mPKuJyCsg
         d7q9sezuYiO3NOdQ1de35T7j9o7dApXDxbfkU3itdkYITRNn7m3R8D0QneC7utxC3Tns
         d4XHVRbVxNmXk54k8IJngz8hBOH1kXw/RzhlcIPHWYC/BkvaCmRub02767oWeczuFCDL
         aIDYjMafXCHSVVA45WpPp7s8CbP4bxG3kqTqhJo1Iz5QXTW3R0AzXet9LLuedf+iLsoO
         S3YA==
X-Gm-Message-State: ANoB5pmxmKsA8+Z4VBR4cnPRv7o6fmLgyCO0rkpcNCWSu94nQL3Jrfcp
        wV4ELjNqk+s252XqDnKwg9oK4ZscOq8=
X-Google-Smtp-Source: AA0mqf6vx7ZZC0PZI6AHFQUPXvKqPdfVDkulImEHgMwdl0d8surbQAN22yL737aRboRhFSiM/YqRPg==
X-Received: by 2002:a62:840e:0:b0:569:9649:1e08 with SMTP id k14-20020a62840e000000b0056996491e08mr11092793pfd.0.1668832603983;
        Fri, 18 Nov 2022 20:36:43 -0800 (PST)
Received: from [172.17.0.2] ([20.228.77.74])
        by smtp.gmail.com with ESMTPSA id a24-20020a1709027d9800b00186ac812ab0sm4586752plm.83.2022.11.18.20.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 20:36:43 -0800 (PST)
Message-ID: <63785d5b.170a0220.c6921.7ba3@mx.google.com>
Date:   Fri, 18 Nov 2022 20:36:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2240057346443767422=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: L2CAP: Fix u8 overflow
In-Reply-To: <20221118200145.1741199-1-iam@sung-woo.kim>
References: <20221118200145.1741199-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2240057346443767422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697073

---Test result---

Test Summary:
CheckPatch                    FAIL      0.96 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      47.38 seconds
BuildKernel32                 PASS      42.25 seconds
TestRunnerSetup               PASS      575.10 seconds
TestRunner_l2cap-tester       PASS      18.91 seconds
TestRunner_iso-tester         PASS      20.00 seconds
TestRunner_bnep-tester        PASS      6.97 seconds
TestRunner_mgmt-tester        PASS      133.29 seconds
TestRunner_rfcomm-tester      PASS      11.72 seconds
TestRunner_sco-tester         PASS      10.98 seconds
TestRunner_ioctl-tester       PASS      13.25 seconds
TestRunner_mesh-tester        PASS      9.23 seconds
TestRunner_smp-tester         PASS      10.85 seconds
TestRunner_userchan-tester    PASS      7.47 seconds
IncrementalBuild              PASS      42.58 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: Fix u8 overflow
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
= Note: Linux version 6.1.0-rc2 (x86_64)                               0.264594

total: 0 errors, 1 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13048756.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: Fix u8 overflow

20: B2 Line has trailing whitespace: "        08 00 01 00 02 01 04 00 01 10 ff ff              ............    "
23: B2 Line has trailing whitespace: "        0a 00 01 00 04 01 06 00 40 00 00 00 00 00        ........@.....  "
33: B2 Line has trailing whitespace: "        08 00 01 00 04 01 04 00 40 00 00 00              ........@...    "


---
Regards,
Linux Bluetooth


--===============2240057346443767422==--

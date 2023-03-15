Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC9C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 19:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCOT1p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjCOT1S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 15:27:18 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75F1158AE
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 12:27:16 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x22-20020a056830409600b0069b30fb38f7so1064106ott.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678908436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7k3CmHsDCS0W156JW3FXaS5NCLQ77eJpYZ5QkJLR7Wc=;
        b=cSVMXv6gZn2NQioplmU2P7QYtvo3uUK2poMJXbeYBCdAY7NpVpmUVAaExfLVuN/0Xo
         BKydwrEqSnSAIB5I4AxVMF/wV8OD1YqemR8rqXh8X/t/MnXehVyq2rB1eGYn/KXAl5Ap
         nxk9HhngPzK896Jsn9Fo3XGQirRixSWJKBfRecHLx9imWmGNRJ8LnDsKjm1IPNDHn+91
         Spyv1dkGxqKmycJQi7W7FjpPtr1ndFkoGazYzL2CCCcUJ2fyi8m3NoEnFkidoScBfrhD
         FZs7RcFnbn3LjTuACXp7soqZm9cRQXWhSYl8wbxucnDI9CPBO7/45HdClZeYN2UHI11q
         LiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678908436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7k3CmHsDCS0W156JW3FXaS5NCLQ77eJpYZ5QkJLR7Wc=;
        b=Xgy/UQKGsZZfKxMgOLc3AkABdt77R2EO22TPZ+cPO9VGDt6Jp73fpgMUc3GuOXrSmR
         LcKz6OhKw9I8edjWD11PD1gF0q2Ev/rvqw567ArdRMLw5sZNnVwT1LRacytX+p3VXh5V
         IKF2uYSAAnSzPOURO5b2qnyA/bsNxrQWqo/5nIiND3/IVqgvcsyDBDskw7G+WcgGDloe
         v7tOPdL6i+ER0uUPHn+h7ytAYgPHMRkhqmoFFQ2RZVUs+mhlIT0tzwNpdr83+3fR/9F5
         R0fHWO8pkXl4MchVKsncJHkd1/XrmAMSveiv5sVLEbBTZ0yF7Tqs1eCTY4LDyVJhw9ZV
         2wJw==
X-Gm-Message-State: AO0yUKV8wyRO6RyiRdB2l+JjJmF6gP8arqH0dljrXlV3EjWA+2Z97nP1
        jnXZApLMwOvgB+t4NPaSGX5W1z2Sdvc=
X-Google-Smtp-Source: AK7set9JKwlYc1kKQ7Gs6+pftzij3CdEQosutu5ken2gd5iy7FP3KQpZeb5XjoOVQHCwCqIJnBquSw==
X-Received: by 2002:a9d:836:0:b0:697:4aba:4cb3 with SMTP id 51-20020a9d0836000000b006974aba4cb3mr2978976oty.5.1678908436085;
        Wed, 15 Mar 2023 12:27:16 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.141.224])
        by smtp.gmail.com with ESMTPSA id d13-20020a9d5e0d000000b00684c5211c58sm2660377oti.60.2023.03.15.12.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:27:15 -0700 (PDT)
Message-ID: <64121c13.9d0a0220.de276.db3f@mx.google.com>
Date:   Wed, 15 Mar 2023 12:27:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5052337790599014554=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] transport: add CIG/CIS/PHY properties, don't show unset QoS properties
In-Reply-To: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678902782.git.pav@iki.fi>
References: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678902782.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5052337790599014554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730450

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       FAIL      0.88 seconds
BuildEll                      FAIL      21.98 seconds
BluezMake                     PASS      863.86 seconds
MakeCheck                     PASS      11.04 seconds
MakeDistcheck                 PASS      151.92 seconds
CheckValgrind                 PASS      248.09 seconds
CheckSmatch                   PASS      329.13 seconds
bluezmakeextell               FAIL      7.32 seconds
IncrementalBuild              PASS      1432.04 seconds
ScanBuild                     PASS      1036.93 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] transport: add CIG/CIS/PHY properties, don't show unset QoS properties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[BlueZ,1/2] transport: add CIG/CIS/PHY properties, don't show unset QoS properties"
##############################
Test: BuildEll - FAIL
Desc: Build and Install ELL
Output:

writing RSA key
writing RSA key
writing RSA key
writing RSA key
writing RSA key
make[1]: *** [Makefile:3277: unit/cert-intca.pem] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1265: all] Error 2
##############################
Test: bluezmakeextell - FAIL
Desc: Build Bluez with External ELL
Output:

configure.ac:21: installing './compile'
configure.ac:36: installing './config.guess'
configure.ac:36: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
configure: error: Embedded Linux library >= 0.39 is required


---
Regards,
Linux Bluetooth


--===============5052337790599014554==--

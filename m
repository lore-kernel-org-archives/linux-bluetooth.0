Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD70C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 00:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbiBPAWm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:22:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiBPAWm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 19:22:42 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEF8193F4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 16:22:30 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id b5so534428qtq.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 16:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YPTzvOFi//MusTFllVrV1iztVdLZPy9dc1Q3fbrT7aA=;
        b=BZvAJ3BAkIW+foeUa+79Cnb5/oVY1LdHqukVO52iGSeOauxIB3BOi8TvmNNTeUQxA9
         h6XElYKOIWo9sH6P/AygyL8nFKoAe1RCTHQRm0mQD8hQfuHffMFn6qSjuAl7UmjuqNam
         NCdcO1lY/lc2bKqbQ+gaSKt7wKSMUlIGKmpZ0ADLpee3vlkzILvggBtV3FraqF+iQuuF
         +JZ5lXLveM203WbFRDioKDuMOmxeC4uY+jF6IKr4cU4jZ/CG/0nYTZYnYFaZUwQ6U1jO
         5e6cDUHYNGiIx5LoUd6aXPC42nquawowFafyiHjTxLWb/xDujXf3ZJNv6xuRWph5Er1G
         Cafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YPTzvOFi//MusTFllVrV1iztVdLZPy9dc1Q3fbrT7aA=;
        b=uxQUXzKbO8iPXcKl29FQfBz40eN+lBdsoYgoOAeAbtNwHA5Zil2RBqx9fwfuuBxgtn
         jbnNtMaRRMUQzcEIrbidbV3MIO4zfjQzDGGczudynEyBsHVUTwQh2qZm3sVuofgp4YgA
         TyCDnA3Bo1q6MsmIgQfD7d9T5XLaBHG1+6XNIrCobAfpYB+Lg4SBRftKPxXNae3+3rF7
         Y8ntzk9a6gBNODcae5QzZYNk5BwV8jfJoUMIUOj3pt0cnnSBukludLqsw2DgBiXMxftA
         d6DeEkzTo9V8qL0gv94gEI60UYePF1bMgLZ4kAtIiQvABOd9eVocnc9U/O6oh6gYD3qR
         S23w==
X-Gm-Message-State: AOAM530X5LH2BbYpPwzVPZjzscbCfkZI3Zn07V7hQSYbzwZ+viAwOInF
        RVbk/p6mPMXhLeEcNhhM3rckCmAVxZil5w==
X-Google-Smtp-Source: ABdhPJzk73Vj91i0T8du7shbOZbxfJDTHGF2AfLD3uwWwM4nDFvNACz5basKVr8ZKt45UkTDxmNKOw==
X-Received: by 2002:a05:622a:1441:b0:2d4:4afc:8409 with SMTP id v1-20020a05622a144100b002d44afc8409mr404885qtx.460.1644970949028;
        Tue, 15 Feb 2022 16:22:29 -0800 (PST)
Received: from [172.17.0.2] ([20.57.49.185])
        by smtp.gmail.com with ESMTPSA id t11sm12928472qkp.82.2022.02.15.16.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:22:28 -0800 (PST)
Message-ID: <620c43c4.1c69fb81.40644.a4cd@mx.google.com>
Date:   Tue, 15 Feb 2022 16:22:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1696857431791484384=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, fontaine.fabrice@gmail.com
Subject: RE: [BlueZ] tools/mesh-cfgtest: include limits.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220215225015.3568246-1-fontaine.fabrice@gmail.com>
References: <20220215225015.3568246-1-fontaine.fabrice@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1696857431791484384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614720

---Test result---

Test Summary:
CheckPatch                    FAIL      1.40 seconds
GitLint                       FAIL      0.99 seconds
Prep - Setup ELL              PASS      41.86 seconds
Build - Prep                  PASS      0.77 seconds
Build - Configure             PASS      8.46 seconds
Build - Make                  PASS      1361.27 seconds
Make Check                    PASS      11.94 seconds
Make Check w/Valgrind         PASS      437.89 seconds
Make Distcheck                PASS      225.60 seconds
Build w/ext ELL - Configure   PASS      8.57 seconds
Build w/ext ELL - Make        PASS      1344.82 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] tools/mesh-cfgtest: include limits.h
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#87: 
http://autobuild.buildroot.net/results/20cc47f54de0b0d4bdf108c3715c590ae8ab476f/

/github/workspace/src/12747687.patch total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12747687.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] tools/mesh-cfgtest: include limits.h
17: B1 Line exceeds max length (92>80): "https://patchwork.kernel.org/project/bluetooth/patch/20210722204923.29735-1-bluez@heine.tech"




---
Regards,
Linux Bluetooth


--===============1696857431791484384==--

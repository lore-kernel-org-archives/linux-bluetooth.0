Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1C3EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 22:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjGLWoN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjGLWoM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 18:44:12 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D321BF9
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:44:10 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3464c774f23so148715ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689201850; x=1691793850;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=29ScXFeKyzQ2vuxBHXdjHYL2oKulmCDiAmZ0eVxw9I8=;
        b=pVAOyybcNSLPz1Ymxt9pghi4ds2rUWwhpEENZlx0zPehd5rcfEcOer/NWv7DYtO1Ob
         BOhpVUfsdi9FmMRCLp8TmV6SqY7PhGZf9FztrozNPyETpjFptTT46vI5YuaLjOzaPzyM
         KQmalSUgJxF5g6/HR5RhxgZRVtltABfZ4dgU0xT/5rgdBJvoJRP7CtzZIaWALAjWIWB8
         XyZPCQol513LA4iRopq8KIMxOjHA9WKUmZZpJz2EAVP5M+41YRVZHb0CUt3YS7bCSHqb
         savBMiLH0L5b0VeiLh4hkthxTPB+XmtA7MuYq86unJML7jAtJPdt0mvSPig2o7UIENK/
         Seew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201850; x=1691793850;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29ScXFeKyzQ2vuxBHXdjHYL2oKulmCDiAmZ0eVxw9I8=;
        b=MjuzWzvtLnLybEQFpYQWIF2J6G/nlbCaG41aCGYMrbzV2XTsrlnjqkfDAcSXMHq8th
         GWiw8ufo40OFx0HY1GHkF4MTJGzLAA86Qq6lHrA4nZ+4cIWpriGZF6aIfbc1/f+44Sx0
         jSO2vv71I6+1yzYVuzexQiVHGoKtm2CuC4Ja5yMhhwVJoLy44pNjlPwBPqCMXQlSkI/2
         8JjPA9dvKtWFUJnf5sM3W5gjIdgKF3OKomNezQMp8jCBu9TdTb7Qh12KdZqrjWOib61V
         /VU6PFoD0eOttilAIWq3nUivrjCH+gTw4jC1UNLgi7oXsOGLD6dyBT2G71pqrK1jhMd+
         zrzQ==
X-Gm-Message-State: ABy/qLbgv8xSzgG+eM5QTAXbaZQUBrVTSrE+6Rzg2UX0M/bJ/caPHQ8o
        NgOefWVGIAR8hTtey/j5QcIzvW+0iZ4=
X-Google-Smtp-Source: APBJJlFqnk7SK33YmJJAsWQ3O9wQI7mDtv2qRkIXUgMAJDXEPEqSfHDT2JGFUzX1n2042sbzFch+/Q==
X-Received: by 2002:a92:c8c8:0:b0:345:a629:83ff with SMTP id c8-20020a92c8c8000000b00345a62983ffmr17686120ilq.17.1689201850121;
        Wed, 12 Jul 2023 15:44:10 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.51.22])
        by smtp.gmail.com with ESMTPSA id q16-20020a056e02079000b00345d5a3748csm1618252ils.63.2023.07.12.15.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:44:09 -0700 (PDT)
Message-ID: <64af2cb9.050a0220.a680.2bd0@mx.google.com>
Date:   Wed, 12 Jul 2023 15:44:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4597014193927219795=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] test-runner: set non-quiet printk before running tests
In-Reply-To: <e521a8d35e8baff45db1fdf8a26725bdc8d595ee.1689196901.git.pav@iki.fi>
References: <e521a8d35e8baff45db1fdf8a26725bdc8d595ee.1689196901.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4597014193927219795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=765028

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       FAIL      0.73 seconds
BuildEll                      PASS      26.50 seconds
BluezMake                     PASS      782.61 seconds
MakeCheck                     PASS      11.22 seconds
MakeDistcheck                 PASS      153.70 seconds
CheckValgrind                 PASS      247.48 seconds
CheckSmatch                   PASS      334.50 seconds
bluezmakeextell               PASS      101.55 seconds
IncrementalBuild              PASS      1297.41 seconds
ScanBuild                     WARNING   1008.97 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] test-runner: set non-quiet printk before running tests

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B2 Line has trailing whitespace: "    "
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/test-runner.c:945:2: warning: 2nd function call argument is an uninitialized value
        printf("Running command %s\n", cmdname ? cmdname : argv[0]);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============4597014193927219795==--

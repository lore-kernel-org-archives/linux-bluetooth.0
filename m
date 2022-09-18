Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB6C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Sep 2022 09:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIRJLR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Sep 2022 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIRJLP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Sep 2022 05:11:15 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D636825C40
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 02:11:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h194so18907495iof.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 02:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=xQJoMg6gPzmqHqu3e1BqdiTI6kjeeWfrZNIOsln0a8o=;
        b=hE2hLVsHuQH/44N0UbGsr/+nOJpjx81GWHcGE4k1aDuR6aja343cFiwH7kkQt5hWRM
         cJfd0gWFtBc0yUrWJXp7Fo8ABaMydAW1QC/JB6uCIieb09ZQsfko/MasIsCHMyXOqMeR
         YjUGC/AACwCd1I1CFI56dwB6VRzuACE2PdATbvKvRVKRCwxxkJMxEMxYktIduCZRogYv
         BMnujf0JPtlosyIyi93HBX2aSzvNUcpWsUD2qUDUEr7FGENs4ulsxiVyrRlJ61hHFcfL
         0rse86SNlcH1OAgvs8iSgqg6uFxAtnTVE8ddhTsXyyTvCP99v3SLJXB4oU0pFD6BcCpf
         f9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=xQJoMg6gPzmqHqu3e1BqdiTI6kjeeWfrZNIOsln0a8o=;
        b=nfsIB5ddCNczVqj14NradBY4QIfNkrqyoolhu1JpuN9sX2vKXqW/3W8PA+37dedv4n
         bHK4ddsGJpHwLLuec2z8aQDpMQ6M0/Tv/wgONtycFRF4gQtb3yct+Pezy2de9UOc5WGO
         EP+XkHVrc17DHuJIVq6yJsnnPbE815osMuCXejAN9LlH8qLYLUVa1PQy/Q9kuT84AiZD
         zXzuyZbi+wsKb2A1qyMDN9QtUd7inBJW9P9PWf+uxAKd5WJSYMin1XBwyOoX1qZbDuFA
         9e54p4Wo1XioIhd9gA3XKxofgGWhoqUxxv7LJ5G09MKI+p3tNYKGo6QdL6JfuS3q3IFw
         opqQ==
X-Gm-Message-State: ACrzQf2BNZS2DdvAosn8JCWL8ssWs8tspwkx79JGMyrNyhb2ME8v2+fL
        hLtqnFYyfjIlW7Cf1w9Mb7EwjrEqSvQ=
X-Google-Smtp-Source: AMsMyM6XgsS60O9+onjNIUljoZY0YTwSqCAmL8JZ6TooJsxTMATqCilYgC4BaVC2RVMvLLKQ+xCF5w==
X-Received: by 2002:a6b:c349:0:b0:689:d9f6:adf0 with SMTP id t70-20020a6bc349000000b00689d9f6adf0mr4800037iof.21.1663492273027;
        Sun, 18 Sep 2022 02:11:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.9.92.47])
        by smtp.gmail.com with ESMTPSA id p7-20020a92c107000000b002f4e385252asm2600309ile.39.2022.09.18.02.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 02:11:12 -0700 (PDT)
Message-ID: <6326e0b0.920a0220.99a38.2651@mx.google.com>
Date:   Sun, 18 Sep 2022 02:11:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5441816398692683895=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wiagn233@outlook.com
Subject: RE: [v2] Bluetooth: btusb: Add more device IDs for WCN6855
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <TY3P286MB261158D091A010380F30E539984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <TY3P286MB261158D091A010380F30E539984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5441816398692683895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=677934

---Test result---

Test Summary:
CheckPatch                    FAIL      1.82 seconds
GitLint                       FAIL      0.90 seconds
SubjectPrefix                 PASS      0.70 seconds
BuildKernel                   PASS      34.86 seconds
BuildKernel32                 PASS      30.15 seconds
Incremental Build with patchesPASS      44.08 seconds
TestRunner: Setup             PASS      502.39 seconds
TestRunner: l2cap-tester      PASS      16.95 seconds
TestRunner: iso-tester        PASS      15.45 seconds
TestRunner: bnep-tester       PASS      6.12 seconds
TestRunner: mgmt-tester       PASS      100.05 seconds
TestRunner: rfcomm-tester     PASS      10.08 seconds
TestRunner: sco-tester        PASS      9.47 seconds
TestRunner: smp-tester        PASS      9.26 seconds
TestRunner: userchan-tester   PASS      6.37 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.82 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2] Bluetooth: btusb: Add more device IDs for WCN6855\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#97: 
https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t14-gen-2-type-20xk-20xl/downloads/driver-list/

total: 0 errors, 1 warnings, 90 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12979356.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.90 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: btusb: Add more device IDs for WCN6855
7: B1 Line exceeds max length (147>80): "https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t14-gen-2-type-20xk-20xl/downloads/driver-list/"




---
Regards,
Linux Bluetooth


--===============5441816398692683895==--

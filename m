Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD992C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 02:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbiCWC6R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 22:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiCWC6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 22:58:16 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C970864
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 19:56:48 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a11so188173qtb.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Nf1o1RCM+sqj4LVBOHn6/s7AS3F4rOIfTFO4NTzY1BA=;
        b=IEaj4RcO79eV439z4HmC1vHBOasDo605pDm/ZQ57IHq5MQ7/BESZl1VL8h4ORjF0uW
         sL+WW0Qm600+81h562zua+WWjmuQP/iBbG9x5TR94tJkCfPe9aMjUE8zQncS3ayomwaR
         9tphkSssF/1THZyMrDoNUkz+gdfb2JHez5+cLHOaqVlU3bbLxV3ozI45G2hjlYhdZplk
         CF1IYlroNxyPYCcGguDIxP5SbyfGsRXrISi7FgujqOVwjDiNul82O2t1yEvLCur0gEru
         Z/f031wB/noTZGdx6M9ut/nl94yus9O4H06EGFyEu5ENBvpcvXMtorbVf1KTgcV8HWus
         jzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Nf1o1RCM+sqj4LVBOHn6/s7AS3F4rOIfTFO4NTzY1BA=;
        b=M4KP/eH/OvYrGC4xl7PbZjyeIO/KZjqmLi6E5KUNuZcpUMQrk/OxFpLn+Fbux1xC5G
         62+Ake92KMByEkkgU328Qlq2Wdb/HuEuwpdIfs8/qvV6HT6aKD1KYO5QGwOzOsyz5pPQ
         c/LHl55QX6zp1kUBaypEjdsZ4K3JMZy4azkkkXBQI0jEQxmrDB3x27GYkUWv01mK1sHy
         SxcpGLoNw5bbNqhsPDuzL+3ICv7BEf7Eh0InLxTjVfIM+5VHxV4A8zJ/c4qdV2pIAtJ3
         4CdwWbyldfHPtqhKquFCdY0IYTkfG5jE3N3gJNjOcG1n9aXQHW3u2MwFPGtFA04+5UsT
         uMyg==
X-Gm-Message-State: AOAM532wRz0avoR7YT6ZBm8h7woXf7cVstaXZNgz6nv4Kf/qfwALUDal
        gigiARKUwWWcWqclbX3Fo2ZXWXdpw1DCpQ==
X-Google-Smtp-Source: ABdhPJzjoyHdXsncDVtmi8Fnv3VgbS9OEVru9oRIr6LFYlD+YZMXmZCDdX5Bw3htEN02taXR36SUrw==
X-Received: by 2002:ac8:5789:0:b0:2e1:c40e:9be3 with SMTP id v9-20020ac85789000000b002e1c40e9be3mr22334279qta.308.1648004207254;
        Tue, 22 Mar 2022 19:56:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.120.165])
        by smtp.gmail.com with ESMTPSA id a16-20020a05622a02d000b002e20e4bf4aesm8248700qtx.23.2022.03.22.19.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 19:56:47 -0700 (PDT)
Message-ID: <623a8c6f.1c69fb81.641d1.95d2@mx.google.com>
Date:   Tue, 22 Mar 2022 19:56:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0879652602860224747=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gatt-server: Limit the Server MTU based on the Client MTU
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220322234956.3153209-1-luiz.dentz@gmail.com>
References: <20220322234956.3153209-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0879652602860224747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625601

---Test result---

Test Summary:
CheckPatch                    PASS      1.48 seconds
GitLint                       FAIL      0.99 seconds
Prep - Setup ELL              PASS      50.55 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      10.12 seconds
Build - Make                  PASS      1461.63 seconds
Make Check                    FAIL      12.98 seconds
Make Check w/Valgrind         FAIL      511.72 seconds
Make Distcheck                FAIL      246.21 seconds
Build w/ext ELL - Configure   PASS      10.14 seconds
Build w/ext ELL - Make        PASS      1435.79 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] gatt-server: Limit the Server MTU based on the Client MTU
10: B1 Line exceeds max length (117>80): "Link: https://lore.kernel.org/linux-bluetooth/CABBYNZL-fjTd8JdmRRM5Y26d41KwDxvvuaED+j2+yPT-RBpMtw@mail.gmail.com/T/#t"


##############################
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
./test-driver: line 107: 30021 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[3]: *** [Makefile:10773: test-suite.log] Error 1
make[2]: *** [Makefile:10881: check-TESTS] Error 2
make[1]: *** [Makefile:11275: check-am] Error 2
make: *** [Makefile:11277: check] Error 2


##############################
Test: Make Check w/Valgrind - FAIL
Desc: Run 'make check' with Valgrind
Output:
./test-driver: line 107: 47441 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[3]: *** [Makefile:10773: test-suite.log] Error 1
make[2]: *** [Makefile:10881: check-TESTS] Error 2
make[1]: *** [Makefile:11275: check-am] Error 2
make: *** [Makefile:11277: check] Error 2


##############################
Test: Make Distcheck - FAIL
Desc: Run distcheck to check the distribution
Output:
../../test-driver: line 107: 67803 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[4]: *** [Makefile:10773: test-suite.log] Error 1
make[3]: *** [Makefile:10881: check-TESTS] Error 2
make[2]: *** [Makefile:11275: check-am] Error 2
make[1]: *** [Makefile:11277: check] Error 2
make: *** [Makefile:11198: distcheck] Error 1




---
Regards,
Linux Bluetooth


--===============0879652602860224747==--

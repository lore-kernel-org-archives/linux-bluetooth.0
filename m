Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18341ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 12:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiIAMSs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiIAMSn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 08:18:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA80118A7D
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 05:18:42 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id cr9so13168542qtb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=z2Lel5PFDJFpYC+pTYTTkSqgkfqt6t+PDKaNqLi9xg0=;
        b=WMQ8deDHAb49zNH8oFT5dkU75FicM4DGE12U7Ea8rT/yvtvjVtfx35hbysUE2dK9eI
         0eYnvDWodrCRaIfN+etWkQX1FEWZjqThL9NAR6YiGtEq9gXkj3Fg0f3Vz6WSGCtrdvyO
         qnX/aI8FTaerFEnkrcSHcuPULShB4LRPm6FhDsAwxe0mXao6Z+YcetGFR+OFJF0NlbXt
         IybSeMFeBw1jP5QBkVe43ggiY3GO4ydvw45xK1RsLx+IGymmcPXqswYN9x6o7A/t9Psd
         V9NUgsatxtnzort3Wlv8NwM6hDML3MjPKEBo6VqEuLIIGlzlKI6OqmjMWewsEameLpIv
         yRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=z2Lel5PFDJFpYC+pTYTTkSqgkfqt6t+PDKaNqLi9xg0=;
        b=ramzltwmLYzfbVjEjL5ufE2UKMa+gzaiWZqdGlqGYp+wKZZFv3tmeMgrRztHHjfXE4
         yWLI7i3hhYIkEnbk+jhYYQlpdqB/hjj4L0T9gkutaOme0aAWyAqip49/IE8pFfvGIpZ1
         OW7IvxdV3ILNBJGQQZLtscDhpe+GFZCioaSRlUDmoIPo04q8F/vr3ay/L0Qxl9bgf0DO
         7pfVZiuDDfwmAPPfWvI4dwXHYg2xlfKtmDN4QDQ7mY8YaU6n8HkN8Y4NzAMP6u+1Gbnc
         hnJMjyiHVai9a3OcFm2/QsFHcQbFVsCBT0nmfvr+arD3H2XEKwrNrJllQzAMmIods70n
         gGFw==
X-Gm-Message-State: ACgBeo2oL38tadoK8hNVmB1rLx0oeoPTqIk6Wu+VoZLP9Ikba/dWKCjE
        3N/IGYk0IQrP6fopGB6LbRKQk7E2p0Hb4w==
X-Google-Smtp-Source: AA6agR47qs+cPIZIN48vlLGoWNx5zGyQPSIx1QeJo5upFOu0s3QsH75gw0nM/PliptlQm/CLH/vJvg==
X-Received: by 2002:a05:622a:53:b0:344:6f46:9b16 with SMTP id y19-20020a05622a005300b003446f469b16mr23680613qtw.664.1662034721376;
        Thu, 01 Sep 2022 05:18:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.171.241])
        by smtp.gmail.com with ESMTPSA id ay6-20020a05620a178600b006b59f02224asm11276003qkb.60.2022.09.01.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:18:41 -0700 (PDT)
Message-ID: <6310a321.050a0220.8baf7.0fc9@mx.google.com>
Date:   Thu, 01 Sep 2022 05:18:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1716830359432035319=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v7,1/6] adapter: Keep track of whether the adapter is rfkill'ed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220901110719.176944-1-hadess@hadess.net>
References: <20220901110719.176944-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1716830359432035319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=673192

---Test result---

Test Summary:
CheckPatch                    PASS      9.13 seconds
GitLint                       PASS      6.18 seconds
Prep - Setup ELL              PASS      31.76 seconds
Build - Prep                  PASS      0.90 seconds
Build - Configure             PASS      10.19 seconds
Build - Make                  PASS      939.89 seconds
Make Check                    PASS      12.96 seconds
Make Check w/Valgrind         PASS      340.88 seconds
Make Distcheck                PASS      284.03 seconds
Build w/ext ELL - Configure   PASS      10.35 seconds
Build w/ext ELL - Make        PASS      97.92 seconds
Incremental Build w/ patches  PASS      700.61 seconds
Scan Build                    PASS      756.40 seconds



---
Regards,
Linux Bluetooth


--===============1716830359432035319==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02166EB8FAF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 09:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjIFJm4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjIFJmz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 05:42:55 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2131723
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 02:42:49 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6491907dbc3so21024846d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Sep 2023 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693993368; x=1694598168; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngp6PioXMEcdVdajycKjcrpBi9ur6rwQ+PaEKC0CLLU=;
        b=AQNVoHXjfd15VUUrohhMmzAgp3iBua+qOyhgeXx6zXjxFLfY9u4epzNsvKhCXLVGSr
         JDMjdluxIFwcI5JJVJzM/2MKLhK1omQBbUdZNDX3KnemZXRwMbVf+Gyf7wnCK0+V2tGF
         VdCk+dU6znsBtJHBxQ8uy8pok2Mo2FBmvD+6kpT2adWb+aO88h49bOfDYr4ca7EVzi03
         MsKx31nuzlu3wAjapYAJTN482YLbqFUKJcF1k1YIZN6NuosxaZEXtDmt+whKbfm5HfzF
         6aelTI9wwwVmRjSgSwvHbzL0jWyHBNK1ZO9OE3cfw8f/eo8DRsiozFjCbKh29XXw30xa
         Po9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693993368; x=1694598168;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ngp6PioXMEcdVdajycKjcrpBi9ur6rwQ+PaEKC0CLLU=;
        b=CAdqbI2WOM2J9Xh/dR1Qr8UmtcbCtup0HQUd9F9SBNU7oOc6whzPLOqOqeEgr/nh+7
         nwum1mddd1zSUXYE8htq603yDhqQ3X7W88sbSyF/UkEYT8Ir6eeCFhmRfOiNpwKwXJe4
         v8mLtwDNnww86MERZMY2f33F3vPTDPNDQXoD5o26mFDGx597MxgPgNCOltd6uDwX8Pmq
         4PceprMECgLrV3fUx3wWGEJAHC3QaXsqjP8gBLPocAN4UEJxE5lYKRTQ9W+ArJkLTX7Z
         KHwGV0TN5Klg9qpgFNxzq4GXihp2/PkrGaOjfP7jZ1J+bRNwwXJWO2jLvmSFvT5N7TLx
         I3JQ==
X-Gm-Message-State: AOJu0YwcMthuDHmZHy1Cfo4MZxWBZ9qXJW7gnM4Qy8pRYp8LTxvOcDH5
        aM1YiJnVy/4/70JyHf1LNy6A2hH4gJM=
X-Google-Smtp-Source: AGHT+IGkE8dO/4iFsQPl4MpgsbMJkd7HFslWxeOu7NRilda+HUl939Cz9/dlqua8zeoLXXui5MXZ4w==
X-Received: by 2002:a0c:e00b:0:b0:636:1aae:1bcc with SMTP id j11-20020a0ce00b000000b006361aae1bccmr18125470qvk.39.1693993368397;
        Wed, 06 Sep 2023 02:42:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.102.210])
        by smtp.gmail.com with ESMTPSA id n8-20020a0ce488000000b0063f82020d8bsm5238646qvl.60.2023.09.06.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:42:48 -0700 (PDT)
Message-ID: <64f84998.0c0a0220.7a5ff.110f@mx.google.com>
Date:   Wed, 06 Sep 2023 02:42:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5160132364792211121=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wjy7717@126.com
Subject: RE: Bluetooth: Add support ITTIM PE50-M75C
In-Reply-To: <20230906083147.25298-1-wjy7717@126.com>
References: <20230906083147.25298-1-wjy7717@126.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5160132364792211121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=781906

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      41.80 seconds
CheckAllWarning               PASS      47.11 seconds
CheckSparse                   PASS      50.46 seconds
CheckSmatch                   PASS      140.05 seconds
BuildKernel32                 PASS      39.40 seconds
TestRunnerSetup               PASS      619.64 seconds
TestRunner_l2cap-tester       PASS      36.15 seconds
TestRunner_iso-tester         PASS      89.15 seconds
TestRunner_bnep-tester        PASS      14.15 seconds
TestRunner_mgmt-tester        PASS      258.73 seconds
TestRunner_rfcomm-tester      PASS      20.84 seconds
TestRunner_sco-tester         PASS      24.32 seconds
TestRunner_ioctl-tester       PASS      25.52 seconds
TestRunner_mesh-tester        PASS      18.08 seconds
TestRunner_smp-tester         PASS      18.68 seconds
TestRunner_userchan-tester    PASS      14.80 seconds
IncrementalBuild              PASS      37.58 seconds



---
Regards,
Linux Bluetooth


--===============5160132364792211121==--

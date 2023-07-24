Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC39EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 22:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGXWxU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 18:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGXWxT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 18:53:19 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA7B1B8
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 15:53:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-785ccf19489so257313939f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 15:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690239197; x=1690843997;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tfrgb5PRNNMIE7eR21wHHQIjvRXQNEwxFERtddGmWzs=;
        b=WDJ+A4O2X7DOoWiZNgTFVELnoBqrwVNVi3bur/uDBBB5AIjWHgXB96X5tYPE1Az34m
         Abv+koDfYQSLNmTuUcz0ytrOAkL9f9GA2Y3tX83woL83JOMA6u3z351e7Dtv7g2+Ac1S
         WH1LGP3dxMJ3/GuNHlbhUv8BlmXs8cWpShpoPEl4BUQsjsEQiQ0yFiIVZMWsZ3xi+agk
         Z+uUKlWVhAnmDVPt6e1v6oiUjNehpKTv++hMBZrdSuHhxf38k9LExSYU/lcktZvenwFz
         kOEhX0zDFTVMcYj/4/Dsk9f894/KPROuu5DAy8IbIWY+uZUyo48/5hn2Sr+6iGnXvet0
         pBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690239197; x=1690843997;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tfrgb5PRNNMIE7eR21wHHQIjvRXQNEwxFERtddGmWzs=;
        b=DrLu+2ZHBgUynNEyZUQ33ee39xMlfvakJAlw7fTm66DIYTDonzTNRuqT2mqH17hbg5
         t1OXB7cZvsAFhIB6Lpqu6Vs+0nCntpCXLHqSqofbzNMJ9b6k1JjVC5t0oUuwdzE8zq60
         oxBuxKnRu33WrZ5Rgp4jplcSZB3DZmZTfN/jG02R0G5T+4S8/PlKtBVihz5rYJ5KHbJJ
         eut0lqxraHlcwbWHJqMUlvKSZgVFpkAKDGB6w3LtjbW3jGh/wPmkHKJe9ETomsfJL6hr
         d6CXcdtMkLq96rkNcdp6J1KrIc72vFH55kzK8w8YJ/1NxcdPAul3WfYeUGS6C2haup/B
         5ouw==
X-Gm-Message-State: ABy/qLYueKHdvLtsZI4uApxxku5HaICVFf6UasoG4zKMbRtaGsAwB28A
        uQWyi4lKFQE4klh7nYpALFoOZ7g03u0=
X-Google-Smtp-Source: APBJJlEC5Y36ksHC+tUFTl7zkMQdd8u01sKoGhfi4OaNKD2rjQWgda3ZgSNJp25bG8Zx5z7XiiK4LQ==
X-Received: by 2002:a5e:c317:0:b0:783:57ae:1894 with SMTP id a23-20020a5ec317000000b0078357ae1894mr1030873iok.9.1690239197602;
        Mon, 24 Jul 2023 15:53:17 -0700 (PDT)
Received: from [172.17.0.2] ([13.89.26.213])
        by smtp.gmail.com with ESMTPSA id g17-20020a02cd11000000b0042b326ed1ebsm3322194jaq.48.2023.07.24.15.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 15:53:17 -0700 (PDT)
Message-ID: <64bf00dd.020a0220.c125f.4962@mx.google.com>
Date:   Mon, 24 Jul 2023 15:53:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3597950748307231249=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gatt: Fix not establishing a socket for each device
In-Reply-To: <20230724212731.848134-1-luiz.dentz@gmail.com>
References: <20230724212731.848134-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3597950748307231249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769045

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      32.80 seconds
BluezMake                     PASS      1137.96 seconds
MakeCheck                     PASS      13.27 seconds
MakeDistcheck                 PASS      186.29 seconds
CheckValgrind                 PASS      307.57 seconds
CheckSmatch                   PASS      420.60 seconds
bluezmakeextell               PASS      128.29 seconds
IncrementalBuild              PASS      975.54 seconds
ScanBuild                     WARNING   1344.12 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/gatt-database.c:1154:10: warning: Value stored to 'bits' during its initialization is never read
        uint8_t bits[] = { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
                ^~~~     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============3597950748307231249==--

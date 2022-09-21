Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA320C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 23:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIUXKA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 19:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIUXJ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 19:09:58 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739EC83051
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 16:09:57 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i16so982660ilq.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=OMEc6YsCpzXg8DUL/ei3eZVzUdnjOhAoTt+/oEuur5g=;
        b=Rue+LtfxDZXhXAeKnhhnKkKh3PteuEYKCHcDITUiIr9fHp/r+MJuhb2lLX1HDnXTuD
         TCztOeTgQ1RK2ZrhMLD0myZXoYYfEi+FlG9meoVTjd/w0nUw1fwvyF2aAlHTzGSgUnDF
         bzkCl6w8GgshTV7Puow2gtmDptjaP69oJsTadMH4HrKAyp45UY/HjLJY7t7cFVmZ896J
         xtkZRJ8p8ZaMq8Sj3QwOnS8hq4nf3hwXCe1oGhWMF592vVE5Zke8ZgT+VNEqnZGScbUm
         xuGWofk4B3IWKnj5t4ni/wJFEOzkAZ5cWxP21Ae4LwdfB1/yqYAuDE+LvL701xxyPcyE
         ETww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=OMEc6YsCpzXg8DUL/ei3eZVzUdnjOhAoTt+/oEuur5g=;
        b=UBD2IcOVo+UzihwWN2yj8G4s9jF0KgrScY9tF6r51IYYZO2A63KBkO4SfmYBVYIHBc
         IIIlObT10T/16vyNbl7PpXi6SQYxXhdw3v4Sl3/9g0hi+hRdClFX5LprMg440lud7AOh
         8hPsFPdAuL2vbCpwjtwGlpEMr7uDMCA5j1DPgtHTnyNJayXciaUUkxRloCpEAt33qO45
         ynUTJhUVnlBbIZXBJkQepJD+QvbuOZgZq3rgfNpMbDvZxtouR+wFiAvOcHvPjofduUR4
         /oiRo5KcNfxyK6jOQaIobjz2/rHEqmGWEQbfs0211lj5+EcIqtRTGY01TyitB/6LWsnO
         FONQ==
X-Gm-Message-State: ACrzQf0W1NPnYaag2z+3huSBMcKu7hd3tdTTWnOK5ZPIdU8A7yjrHeZT
        NJFx+/Hfh9Exl1ntyQV/LmRHiAUptsA=
X-Google-Smtp-Source: AMsMyM6iVaMwkLoUaBFlYzGx3P2nTntFH6/BKPrun0FAyJg+tooUa7Cr0TIxZZq0sh9HvSaMjSNukg==
X-Received: by 2002:a05:6e02:12c6:b0:2f6:5f42:89ed with SMTP id i6-20020a056e0212c600b002f65f4289edmr277875ilm.153.1663801796573;
        Wed, 21 Sep 2022 16:09:56 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.45.184])
        by smtp.gmail.com with ESMTPSA id l42-20020a026a2a000000b0035a872cdad8sm1521588jac.157.2022.09.21.16.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:09:56 -0700 (PDT)
Message-ID: <632b99c4.020a0220.ddd44.222a@mx.google.com>
Date:   Wed, 21 Sep 2022 16:09:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5668061271807347905=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] gatt: Fix not setting permissions for CCC
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220921214656.2241730-1-luiz.dentz@gmail.com>
References: <20220921214656.2241730-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5668061271807347905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679174

---Test result---

Test Summary:
CheckPatch                    PASS      3.42 seconds
GitLint                       PASS      2.26 seconds
Prep - Setup ELL              PASS      26.17 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.15 seconds
Build - Make                  PASS      740.85 seconds
Make Check                    PASS      10.95 seconds
Make Check w/Valgrind         PASS      287.39 seconds
Make Distcheck                PASS      237.16 seconds
Build w/ext ELL - Configure   PASS      8.19 seconds
Build w/ext ELL - Make        PASS      83.30 seconds
Incremental Build w/ patches  PASS      294.92 seconds
Scan Build                    WARNING   509.27 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
src/gatt-database.c:1138:10: warning: Value stored to 'bits' during its initialization is never read
        uint8_t bits[] = { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
                ^~~~     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/gatt-database.c:3541:14: warning: Value stored to 'iface' during its initialization is never read
        const char *iface = g_dbus_proxy_get_interface(proxy);
                    ^~~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/gatt-database.c:3542:14: warning: Value stored to 'path' during its initialization is never read
        const char *path = g_dbus_proxy_get_path(proxy);
                    ^~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.




---
Regards,
Linux Bluetooth


--===============5668061271807347905==--

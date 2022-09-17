Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91631ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Sep 2022 00:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIQAba (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Sep 2022 20:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIQAb2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Sep 2022 20:31:28 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7656EBCCCF
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 17:31:27 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id j10so14360491qtv.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 17:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=oCDKLRmAm24Hcv8Ekb/CCZaMbZ4p03Z2CZ9HkCmJQg0=;
        b=i4yTSeNdvfzxnqCiOnTrmfmW6McIvvoPWmawLVAVq8OY96rq3qF30vxx9nJrdaeIhN
         lNXDWUaLznXYVHqVWr7UG+LkiMaPbEuufxe3DSTVXehFbEt/xPU3drh3hhSFFVfCfZwE
         1Uum5w/jHv5Um3mV7Wka7eJg4jq1rzM9AaLI5S6K212y2ymr6EgMTeJy5mtkk6FSS2Ng
         tVK4IYwLJfTQ5JGP3eWcDIL9axL3ZBbDChmDKdAazxYu5QzLBnpn4gF1GLONI/i/GXvW
         fP7oCPgBrzM5b/HxNO8z1HLdt3oimmnechh/vyBjp+OT0FNSaPj0nHD+Z6b0ASNfd34j
         6iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=oCDKLRmAm24Hcv8Ekb/CCZaMbZ4p03Z2CZ9HkCmJQg0=;
        b=U/65Ohp2nkoAJ7YMqTOdNagpVaeB28ocr6ERdm3pZPilXeHD/WJhYPIZEfH1PIEvnA
         1aZ/gWr9i4uZBlIWYV7O18wEJ4dkVnZS9iMbhYmW2UKF9xUEIpbA8pLN/ElF2EqfboMW
         ME3jpwToBiCYth3plEONPb3S3UXMdfKeC/MaunkWYMpIUmjSUaIZ5xlijKGNUoIbe5qM
         MxJGLKqefTYOJiquOHmBT7LvMh/QNd2b2+eAuqYOmZlspqOUPqXFnWe+ZOdcb+FGO7X2
         7VzWplcJ16ZJAKI2QcMisMqSfqJtW3RAMIrKn39Hlm0UmEvQzycrsw7xeim/0hZdsomz
         pL2g==
X-Gm-Message-State: ACrzQf14PQ+IvilyggsnNG3mpYbeO2tPUlWX5GUz0aPIvZEW4QDgiVWB
        yvgVX5hzq1p7dSqd6pcyP4X6fNftUGS0Gg==
X-Google-Smtp-Source: AMsMyM4u76i1I4m14TEu1xMUMwyhbaEF6jHzn6kZp1l86A7UEysdZxypgm+u1rcjZrlCepjnQl3asg==
X-Received: by 2002:a05:622a:1a21:b0:35c:4a24:e9ba with SMTP id f33-20020a05622a1a2100b0035c4a24e9bamr6874020qtb.622.1663374686380;
        Fri, 16 Sep 2022 17:31:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.195.133])
        by smtp.gmail.com with ESMTPSA id r4-20020ae9d604000000b006bb29d932e1sm7369543qkk.105.2022.09.16.17.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 17:31:25 -0700 (PDT)
Message-ID: <6325155d.e90a0220.6ff3f.8644@mx.google.com>
Date:   Fri, 16 Sep 2022 17:31:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0123471604146190076=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-client: Make use of gatt_db_attribute_get_ccc
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220916234604.1156551-1-luiz.dentz@gmail.com>
References: <20220916234604.1156551-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0123471604146190076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=677779

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      27.08 seconds
Build - Prep                  PASS      0.94 seconds
Build - Configure             PASS      8.81 seconds
Build - Make                  PASS      984.61 seconds
Make Check                    PASS      11.55 seconds
Make Check w/Valgrind         PASS      292.56 seconds
Make Distcheck                PASS      242.54 seconds
Build w/ext ELL - Configure   PASS      8.75 seconds
Build w/ext ELL - Make        PASS      85.00 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   553.94 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
src/shared/gatt-client.c:387:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:600:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:900:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1009:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1185:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1250:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1521:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1526:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2028:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2036:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3119:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3141:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.




---
Regards,
Linux Bluetooth


--===============0123471604146190076==--

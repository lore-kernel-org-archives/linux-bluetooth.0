Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFCAC00140
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Aug 2022 17:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiHURLb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Aug 2022 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHURLb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Aug 2022 13:11:31 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5698721E06
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 10:11:30 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id c5so6231959qvt.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=r5eMnvfD5RjUnHbUeyia/w2ybXI0hGG1XTC0xJvT2Zg=;
        b=gP/CoAScudnY3zPLpg5W8N/SNPjVxdJAwQI85fWkATH4uI7URgdvV4kjV5PBxifvIh
         b0gMlCSxL27vZuOo5qPnSl4TKHxP3Xht4/t312kD9TgMrJjAizYbWtmj6nWjE5hs4Y6H
         2l7cWdysA3dw3GIPT5EdY2BwQ31b4D8UqOrdSTINQ4qHePGfiIhl+DLUwZgmIx0IGYVu
         /yKR4d26/X7vvOa3kbPYPM2d/1m4KOrhjLoc/Sq6aZTQzzm7ia5XDO3UuRwW8ERyqgHh
         +VdfpA47fkn6NH4rZEZTP8a7fE8YOuVAJrhx81VnivGaTmRKuK9FYlwX/vNC8BSN3A1N
         zUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=r5eMnvfD5RjUnHbUeyia/w2ybXI0hGG1XTC0xJvT2Zg=;
        b=Nqn8EsbkUDJSVNhr2//yTQRSrN4IQra3dqrUJ6z1SxRHfd7UDgBeSK3L2VRb3BYE/W
         vOiVrk9l/xKjHW1SdPO7tB1EFO3UCpRfvsi3q6xFRi5UEEdArB8CkJ3ZeI+0F6KKhnEx
         oj3bCrqhQTI/a9DlUbHUMNctVREbA6UyXBLqGUdmrFNS+tDkVDR52c7e6GEMo+CPDa2+
         zq8Ts6G86Kv1ZOUNQa9vQt2bh2rTFcX+gZaUCnI8Pe58/feNck2BOuvR05LJ6+TFbQ8I
         LJncumWSKWi2KlPc0FHrL/mU9JA+Nb0ImUjFhEycu7GzHqD0z676hU2+CWsdc3n+EiMk
         kqdg==
X-Gm-Message-State: ACgBeo1m5q5sre5k78O57/1VQrYp7dgFgMTiieqOMFAWRh3LbhUjbf8j
        zx5ogFGMS1o3rcf+szldqkX690X+LRVAzQ==
X-Google-Smtp-Source: AA6agR4l6Ux0emCAuaUi6W3M5jSXEppyCo6o70g3n+8cUNI+yBTe9IH4qTQ0pmDdkX2Lc0dJTZWLJw==
X-Received: by 2002:a05:6214:d66:b0:496:d9c0:3134 with SMTP id 6-20020a0562140d6600b00496d9c03134mr3969911qvs.109.1661101889343;
        Sun, 21 Aug 2022 10:11:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.191.197.6])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006bb83e2e65fsm8910667qkb.42.2022.08.21.10.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:11:28 -0700 (PDT)
Message-ID: <63026740.050a0220.e1032.489c@mx.google.com>
Date:   Sun, 21 Aug 2022 10:11:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1349076945368201417=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kmachanwenw@gmail.com
Subject: RE: shared/util: Correct UUID for Microphone Control
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220821160248.3481431-1-kmachanwenw@gmail.com>
References: <20220821160248.3481431-1-kmachanwenw@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1349076945368201417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=669554

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
GitLint                       PASS      1.00 seconds
Prep - Setup ELL              PASS      26.83 seconds
Build - Prep                  PASS      0.93 seconds
Build - Configure             PASS      8.56 seconds
Build - Make                  PASS      867.08 seconds
Make Check                    PASS      12.21 seconds
Make Check w/Valgrind         PASS      287.66 seconds
Make Distcheck                PASS      240.80 seconds
Build w/ext ELL - Configure   PASS      8.78 seconds
Build w/ext ELL - Make        PASS      82.39 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      510.53 seconds



---
Regards,
Linux Bluetooth


--===============1349076945368201417==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B32C32774
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 13:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiHVNaA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbiHVN3t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 09:29:49 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9257C1172
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 06:29:48 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11c5505dba2so12823614fac.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=iJh9xe8l13W9D5QIVtKbBubde7vX7TrENB834fvMJ2c=;
        b=diSRRkK81OsUd2Qt13OFqifyH9r4ie1GIEEi3HXDfhRriJGyCJADw4B09Z1Nz+/lrx
         n0wqyn1w1RfqOwu19PUeCsXQprXj0xZs7KOpZQLqZjoeRYd0ODD6dkWWHboQbNz30jIl
         6p46Xj/H9m24B85iwgriCrHjelCrF3ptALnTzgbR5AH4LN8icWABPtfH8Fq6Cl+gFfW3
         sOBKNOXRpWBcuwSI85HgDMAWW6LcEAb1WDJ/hfgBLfPXeqcXAFRqL/LH+O8StLXllDJk
         yf5DTj6euDtRfDYOWesWZUmHRKjk8Hv6zK8NXh9GSUe5dX2R3dl/Sk2MFgWkud6Hq0vB
         c8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=iJh9xe8l13W9D5QIVtKbBubde7vX7TrENB834fvMJ2c=;
        b=7CMKTGKMaj5GQgK08GSpOEuaISUR/1OlZvTz7JhOaNg87iglcHiQmr3aS3zQXtWTtC
         hQKLyW/RTx3iuaY5+NvuovVeC+zjH5BPMIgb7P9qQw54EnUQhhgaeCZOYFi+BXIHcd0C
         PE7L+dJbSL2VijaW6T12A65r6KN3R3FbKM3OX6mXSYXJEdX4GDcnEbzhhzFxcszOMUEF
         EfEwRQenf6beeEmwaswB652kSMJZFUnCNCv+3DzZr1NcdsHvV7nFouZS7qbJwZplV2RQ
         D2Sfcaz0h7aF+M+DwjOa3rArdfr5XUwzvYvIhPn2++QXogBrZbXGvtzvMFELz5aNR647
         N2iw==
X-Gm-Message-State: ACgBeo1pf3tSnzSPi5RbIDE76oZrn9PjGme3apusopV/n8aT7CqABHqz
        BGjHpGIanTe7V/Wi9abO0l64MhbR/n950Q==
X-Google-Smtp-Source: AA6agR5ztYOdiYE1kaIKQVrbXPW67Jy6KRyoXYNcBbQhY2xiYNeJGQETWrDsh4YEfvM3VlLnVRTsPg==
X-Received: by 2002:a05:6870:8a25:b0:11c:4b72:8e46 with SMTP id p37-20020a0568708a2500b0011c4b728e46mr12727535oaq.237.1661174987042;
        Mon, 22 Aug 2022 06:29:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.113.238])
        by smtp.gmail.com with ESMTPSA id s41-20020a4a96ac000000b0044584998c9asm2475666ooi.38.2022.08.22.06.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 06:29:46 -0700 (PDT)
Message-ID: <630384ca.4a0a0220.a0af.7f9b@mx.google.com>
Date:   Mon, 22 Aug 2022 06:29:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8228218729036463389=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiaquan.he@9amtech.com
Subject: RE: [BlueZ] test/test-mesh: Fix python warning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <CEE786764994BC33+20220822114212.GA5807@ixamedge-b4f804>
References: <CEE786764994BC33+20220822114212.GA5807@ixamedge-b4f804>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8228218729036463389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=669733

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.75 seconds
Prep - Setup ELL              PASS      27.42 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.71 seconds
Build - Make                  PASS      876.68 seconds
Make Check                    PASS      11.57 seconds
Make Check w/Valgrind         PASS      292.49 seconds
Make Distcheck                PASS      245.98 seconds
Build w/ext ELL - Configure   PASS      8.98 seconds
Build w/ext ELL - Make        PASS      85.72 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      521.12 seconds



---
Regards,
Linux Bluetooth


--===============8228218729036463389==--

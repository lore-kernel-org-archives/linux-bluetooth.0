Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8B1C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 14:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGEOSZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGEORT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 10:17:19 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF3E41
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 07:13:03 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id p9so7301425ilj.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jul 2022 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=yE73hxo5NySa7RmWCKCqCIr8tnmuCgppGcBxO7b/fug=;
        b=h9J0HZisbbxpCFsLe/7hhqhrD8MLMZ4kmMApEip8fex6lXf+61rCHZOqYblYAEX32Z
         ROCXvUsCSzpy4A5uzoKVTWkhdftxF9lCz4Fe/GXnbEunElx00ZA2WuVUMWYDGmg0bQVW
         kquF5TRzwauRwptmvf33R4KRhiqfFtKkd7cDdID1HA/UZwE2/SdK6avJe86u4N6/h/NH
         kYbOX2lgSLnK9T5sJ+U+ytnBVXMGqhfEqckFrDkIpSbddA8pMVGixYCrABQkNkKhdDKq
         nonOLa23DcnZlVvu9hrqsndpTLbrBZgAQ3U37d6yny5FC3KIQkGt3xpFTsLUuimEOTbR
         jGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=yE73hxo5NySa7RmWCKCqCIr8tnmuCgppGcBxO7b/fug=;
        b=krEtRJ2i2dgbZ7RNrJ8xMS1dxjgR+suIfi3fgb04Uyep5zUH22lJRyfvtrQr9HZnB1
         99zJItj6jdK8588pjpS7NB95fxQ5RkFQI5rfzGo3c9rUMU4j62p/ZDqmEQtkHnZDsCyQ
         oVZ6J3pQfzyjbFOJMn+GEb3cenhhG/NPMtTscreWF0WvE75IzlL3F1rRvVEtKSYtwLrY
         zwO7Grqpru5sAQLrp9Y69UwCN33NAl2/cXrRzegBALtoOwv5eKV+M77XFpZTQ+N/4Tdk
         bO5kxg7/d/ln+fzwmSkgKb78+pxVb8yvovP71NESTOKNqEBC53B06dXLj4uh1266hx4a
         neIg==
X-Gm-Message-State: AJIora+59UZSyqSfRs7Rvp89iAh6p8yNYcWNxVLvtfV1iI80qUR1RTCe
        UJSLq0Hwa+El6iCkWw/wwuZRXkbHfa4=
X-Google-Smtp-Source: AGRyM1uIl+aTmPnLe4j5uSfp94udWfPeg1IT6kU428+EXuMB5dJoR1lpCMDkYm4SblUntUjh155Z2g==
X-Received: by 2002:a05:6e02:1a0b:b0:2db:f8ed:edb1 with SMTP id s11-20020a056e021a0b00b002dbf8ededb1mr11164093ild.75.1657030383097;
        Tue, 05 Jul 2022 07:13:03 -0700 (PDT)
Received: from [172.17.0.2] ([13.67.138.178])
        by smtp.gmail.com with ESMTPSA id x11-20020a0566380cab00b00335c432c4b9sm14693715jad.136.2022.07.05.07.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:13:02 -0700 (PDT)
Message-ID: <62c446ee.1c69fb81.f7fa0.16a2@mx.google.com>
Date:   Tue, 05 Jul 2022 07:13:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3931972226323639753=="
MIME-Version: 1.0
Subject: RE: Bluetooth: core: Fix deadlock due to `cancel_work_sync(&hdev->power_on)` from hci_power_on_sync.
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vasyl.vavrychuk@opensynergy.com
In-Reply-To: <20220705125931.3601-1-vasyl.vavrychuk@opensynergy.com>
References: <20220705125931.3601-1-vasyl.vavrychuk@opensynergy.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3931972226323639753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_core.c:2675
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3931972226323639753==--

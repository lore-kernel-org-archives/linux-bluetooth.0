Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF1C04A68
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jul 2022 22:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiG1WAg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 18:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiG1WAf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 18:00:35 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D131A04B
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 15:00:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id o2so2413146iof.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jz87QR1n2Er7uuIvj9a6hugmX5uqDlSg6Qbk7E+CNYo=;
        b=Pig5nDBzgkUoGKOJexNiaV2thwVCaMAG6w+F4m7c8EXQxgQAxAgt/05rxOG09/ZJ5r
         7Guhu7Xc/so1h/ni/ddu/ktXW5sJl2kAiiHOFhCa9wDqqZNlIVp/4xdJHaidTrOXj+9z
         XQQ8E0z9LEo1AYZ93jUR7QtwdregMPpW5EQCr//B5r5DCcAix8mZVz83gVcFropZ7vt5
         7xPKQ6auxAzL9EMxiNS8lop8Auy2gKYSIWtYRydVlja9GJTj+Y9bn5K4hs0xg545SiKT
         OGewqcOdqvpWFtBjJSYo6Zg6yO2+umqN1qK5YfCJwQWvKbz/b9TJsa7Ixpu8TqRIH9+n
         kiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jz87QR1n2Er7uuIvj9a6hugmX5uqDlSg6Qbk7E+CNYo=;
        b=raaRqXXQRcC1swks0AAoJeAPAvWbfViiauCtCJ3+OZ68FY+fxWiWwziCbm9xNKjWod
         JyEKuSeSIxc9kFvSNGb/s3my2lXFNV0LWKXI456A36T5mZw6JXpPrdJ3eyS0fpfPjseQ
         NmvGIPAtwvF93aPfjbFMLcQqUPnp/BJifOqNAqK0VWGrkAfVK6hpFjvZdDPYl71nRUPg
         tmxM8Zz3CZ+u9qZW7xOsSqVObEjUPv8RKu6CzDbExgQCFIYSgjhOJMQjymKnI1k7JJRL
         wdUWdojkmcCe7KdZxpGXBhrbQPW1rISpiww6UM/QYuOcpWip12HxEmgYoYrrLTAEdLlD
         7ceA==
X-Gm-Message-State: AJIora/MaAg1dQ1WZGPefUr1ypZYChQFdZFjaNwJ4zf+Btl+5afU3iZl
        uFclFUooUv9tica9qujwqO1BL1W8olY=
X-Google-Smtp-Source: AGRyM1uawzKZvMfobV3veTdw1Na31hGv4tbWdOWRimFeQ963bxN30Fqjq2KAQxC1Dos8ZGCqtU8wMQ==
X-Received: by 2002:a05:6602:1654:b0:67c:d3a7:d2e0 with SMTP id y20-20020a056602165400b0067cd3a7d2e0mr209940iow.24.1659045632149;
        Thu, 28 Jul 2022 15:00:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.67.217.80])
        by smtp.gmail.com with ESMTPSA id y31-20020a029522000000b0033f3782eccfsm849480jah.89.2022.07.28.15.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 15:00:31 -0700 (PDT)
Message-ID: <62e306ff.020a0220.d5b0e.1bc7@mx.google.com>
Date:   Thu, 28 Jul 2022 15:00:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6117893955864932159=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] iso-test: Add ISO 48_2_1 Defer Send
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220728210637.1247789-1-luiz.dentz@gmail.com>
References: <20220728210637.1247789-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6117893955864932159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=663886

---Test result---

Test Summary:
CheckPatch                    PASS      1.30 seconds
GitLint                       PASS      0.77 seconds
Prep - Setup ELL              PASS      26.60 seconds
Build - Prep                  PASS      0.75 seconds
Build - Configure             PASS      8.51 seconds
Build - Make                  PASS      959.56 seconds
Make Check                    PASS      11.15 seconds
Make Check w/Valgrind         PASS      274.10 seconds
Make Distcheck                PASS      233.63 seconds
Build w/ext ELL - Configure   PASS      8.49 seconds
Build w/ext ELL - Make        PASS      79.18 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      483.41 seconds



---
Regards,
Linux Bluetooth


--===============6117893955864932159==--

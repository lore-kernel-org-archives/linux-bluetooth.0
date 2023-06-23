Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7749C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 22:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjFWWmM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 18:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjFWWmG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 18:42:06 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1383B9D
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 15:42:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3411ea250efso4629535ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687560125; x=1690152125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g1xciNPACgCLOYoTe21g7vnXAM9H5d+1xTq1E1YRKoQ=;
        b=dIymKq97VoPFZu3anvHTgHqrNr8fxe0pw+X+JCJoecoR3rowK6OqmZFJeaB7aIutLY
         pHlfKHEdo+t+CJ4t7j3aT1Dh9n7UTxo7t6E5UQuTIgmrdw4wDCl5yqtERNcj0lCcBZnD
         hwajreP3tALLto6Wxm1xGQECbpE88TtNPBZAFmvQ7+8GInh7p1kJDpmAqe4f/8wCcC7S
         zChrhmr2UYnWt8iIhfcZ4u9qrkRJ2CtfABlknkBF7kcSzAyC9tg7sE6MSmfYWCr1ueJ2
         aVHsJjDFQB4+BLyIWwAFou4oqCUkLc+NCqaCjyGg8nAhxegS9ueROJskNMBVZ7J9Xql8
         qusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687560125; x=1690152125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1xciNPACgCLOYoTe21g7vnXAM9H5d+1xTq1E1YRKoQ=;
        b=SH6MGmygI9SkY0qX1OEeVyRkQ3HSqy9pJmpGOQSU4NH6nu7C97NxsCijScOepNwWdr
         XpKfQ79sjsdySTA1gyPBQaALsPc92XypwQ3InbXpKz5gqFlXD3l5OndZlwPNEB9Sa7nr
         FZV5a8znnw5V+LrlSHBBO+HttnwY4GtK8WE3eWUbGLyEg6kj+x1X9Gy3NCSmcyKBDNNF
         /wb2xtRnVuYz+DNXcmOERCwhqoR1A/iEeEl58EqPZ5AtqsOrOvDAP3u11qtxEoupLqw1
         cEC9x/3TQIhQwJ9k+0dVy38bvxW0gN787AhAeNBaKJX6bzmXHt3SJVl3ZFBvcebiAz5M
         TFSw==
X-Gm-Message-State: AC+VfDyD++44Q5xzF8XhPt3JAV9o5a1n6BJt/mpFvrbUx6HOBfOdcg7t
        wGi9FdFTgA6IXjv4t77BQOq2I4YQh7c=
X-Google-Smtp-Source: ACHHUZ5i/IK9R1umRgjL6XYluxv+kxNhy3s2XgEifg2sbWiNHdUhBMudr85PKSP4GYIkYn5jexykQQ==
X-Received: by 2002:a92:c60a:0:b0:340:6db8:e814 with SMTP id p10-20020a92c60a000000b003406db8e814mr22407795ilm.22.1687560125147;
        Fri, 23 Jun 2023 15:42:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.63.112])
        by smtp.gmail.com with ESMTPSA id v2-20020aa78502000000b006667b36e904sm41814pfn.113.2023.06.23.15.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:42:04 -0700 (PDT)
Message-ID: <64961fbc.a70a0220.24784.01f3@mx.google.com>
Date:   Fri, 23 Jun 2023 15:42:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8429188685903281699=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] btdev: Fix CIS Established Event parameters
In-Reply-To: <20230623212430.1702254-1-luiz.dentz@gmail.com>
References: <20230623212430.1702254-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8429188685903281699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759916

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.51 seconds
BuildEll                      PASS      26.27 seconds
BluezMake                     PASS      752.96 seconds
MakeCheck                     PASS      11.68 seconds
MakeDistcheck                 PASS      152.27 seconds
CheckValgrind                 PASS      245.87 seconds
CheckSmatch                   WARNING   330.57 seconds
bluezmakeextell               PASS      100.03 seconds
IncrementalBuild              PASS      1279.32 seconds
ScanBuild                     PASS      978.92 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:417:29: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8429188685903281699==--

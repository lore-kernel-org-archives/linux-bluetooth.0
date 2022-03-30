Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DC8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 11:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiC3LL3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343540AbiC3LL2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 07:11:28 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A63ED33
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 04:09:42 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d65so12806028qke.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 04:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ALK4cjDUO2arKmU+90tIQYZU0JwIPGzeMWgeB9D0m5U=;
        b=qM4Qj7+A4B9l4zz1zBCbj9QyW24P/XF9uUftnZDjvVF/7wJeHIXBoYM0GCcSicvAuB
         zG3df+6MI0QBQAHZwOgpueog5NP+DD+dsE4FihmRRD0W6QlQsau45pFTcbWyjFoDE7iY
         qK+S14omkgqbhp+m/HPMj9InMa+RxoxJmVNtQeMrOfoLmSIzN7JYj5w1XtMexM6U9xjF
         h6n8/KWoKjEj47AtcmPOEtn5TdOg8WKAHtDU38sV8YPtrtXTMl38TrQtAE0zj9UGJD2O
         U8N2hgGYY+kwVzypTBuo1YA+hD4PzllU7mb4xWh1Z3Hn8wp1yEGIlUqWzFMhAYWw4n2x
         zSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ALK4cjDUO2arKmU+90tIQYZU0JwIPGzeMWgeB9D0m5U=;
        b=j2ZQksTF5p7p4I1rXc1xPdA//qDP2eAbXswPzOxuzsnqNxcVz8nnW4a4FpFJGYjit6
         TWiR+Po6ca+Fo3OYiIh/BSgyQ2kDtuq37sY6GJmHv3UWp/+QH0VPYz0M+rsJ+n4iEcXW
         4GiCcwRwhQeruwhpWc5CHBSUyQr9dlE8SRc5g9nTpFikm71naTsgSgZaSmWuW4e5asji
         zQASlVvb5BzoAo+nYcjBqde7DDlPjCTI5nq8zGiB6F8TsfAWiZQA2to+xoJr0UCZlBF1
         gzHa3bfGMaKGJf7q5zudX9zfDL5u742T0IAR0tl++ATljOqJrqslLZRAeMVICnTTc5l7
         IqLw==
X-Gm-Message-State: AOAM531qk7E+wVP3aF7Jztv22X3KqEPVfoXMyShuBEa84SuohPQqj3VA
        bJDo72YyZaBh58OzHGQdtYjEfPC/Jt8=
X-Google-Smtp-Source: ABdhPJwO7OBsXawPM3XyxL8DhDuudq8tPS8H9SLO41Z2uPjrjdx/yoaOa4aZkv7rj8YLHhQVenBfFg==
X-Received: by 2002:a05:620a:152d:b0:67d:7370:f428 with SMTP id n13-20020a05620a152d00b0067d7370f428mr22842136qkk.15.1648638581347;
        Wed, 30 Mar 2022 04:09:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.47.175])
        by smtp.gmail.com with ESMTPSA id l13-20020a37a20d000000b0067d17b656acsm10765165qke.78.2022.03.30.04.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:09:40 -0700 (PDT)
Message-ID: <62443a74.1c69fb81.b7f31.8a91@mx.google.com>
Date:   Wed, 30 Mar 2022 04:09:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1784529225989209516=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] tools: Fix g_dbus_setup_private connection check in mpris-proxy
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220330094740.45637-1-frederic.danis@collabora.com>
References: <20220330094740.45637-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1784529225989209516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627447

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      1.10 seconds
Prep - Setup ELL              PASS      51.59 seconds
Build - Prep                  PASS      0.93 seconds
Build - Configure             PASS      10.28 seconds
Build - Make                  PASS      1821.30 seconds
Make Check                    PASS      12.59 seconds
Make Check w/Valgrind         PASS      528.58 seconds
Make Distcheck                PASS      276.12 seconds
Build w/ext ELL - Configure   PASS      10.18 seconds
Build w/ext ELL - Make        PASS      1781.88 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1784529225989209516==--

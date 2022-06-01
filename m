Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0EBCCA479
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jun 2022 22:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiFAW0I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jun 2022 18:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiFAW0H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jun 2022 18:26:07 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04349FDA
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jun 2022 15:26:02 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h188so4477871oia.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jun 2022 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=47F2QYLmoLzAImz2n3Y+kPb1YGKknLhQwON2sOdoni4=;
        b=ZUtC9xTv/iISy1CU81bPtYpAIBTMwh9tJfuCwujNDa3Liu8tHKukRcNpzdLJANIgiX
         joR2GlmMELc5hDgLcZbldJItFbLsCXzJNEbIeRBsbLcRXoyK+OYNVLF8ZuUu4ODmaL0T
         KXRqLdq659oK2UbHO74gq81FHNf3uiWvPRKHqTRY9OgYcM20L38hRryzJzCdkCJTd1qj
         P/MIq7v6PQspSB3QBTVTC4XYSFgYoNF15Cpei0RyEV79d765uxtlibBIaHgvlY2U4kaf
         9EBrlBY82oZhefWlMT26bYkYtJT15R/axh4OhEbxZ2ZCvwhvJT8nTVjrcQcchDwupgY/
         TcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=47F2QYLmoLzAImz2n3Y+kPb1YGKknLhQwON2sOdoni4=;
        b=593KH6G9tGsuHp50fCxmezeTOJSTkimhFycrRyqDUsKjjrN7bHancQyOR7bCdpILYH
         7PFw3LNhEXthPJBTdH1nvU2LvAo8R3PKtC+niozfxszTqe9A1DZZM4WOd3URe4qQ02Ar
         nGGnJ4o4avFeQq1DuC+7g9jyH2YZgSef/D1BXE7FmW6obtgbfg+ppMlWBP7Lp8pRu+DO
         WRppY4w0zi9i/ZrR6daZpj/RrWPsWLYXd6rgDmaeDatm+HBtjUoT86XkIm7RdwDI8844
         4z+BpGeoCeEmJU0NtaaX0/fZukf+MAf2Kl5BJ3CprnM94Lq2fSpM804uLzoIEud/Dz7j
         nQHg==
X-Gm-Message-State: AOAM531EAgrW3MwO7SxdYVlpIY7IMkOtUyERKM2wiCMjI8UFVG0LMncK
        Vcn/yQ6W6dYWYrj0iu7HwbNPsVk/14I=
X-Google-Smtp-Source: ABdhPJy5Zvev4a+EuJBOfzvPndFSJl4+gn1sYkztHAaD+3UI2Yeu2s3/LgDHWvSbaPCaHmEuvmg3HA==
X-Received: by 2002:a05:6808:1902:b0:32b:2141:f5c3 with SMTP id bf2-20020a056808190200b0032b2141f5c3mr16916909oib.143.1654122362101;
        Wed, 01 Jun 2022 15:26:02 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.148.29])
        by smtp.gmail.com with ESMTPSA id gn27-20020a056870d99b00b000f323072184sm1218047oab.15.2022.06.01.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 15:26:01 -0700 (PDT)
Message-ID: <6297e779.1c69fb81.3f12d.7d14@mx.google.com>
Date:   Wed, 01 Jun 2022 15:26:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0280079691076388306=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] test-runner: Fix not waiting for system_bus_socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220601211230.1355268-1-luiz.dentz@gmail.com>
References: <20220601211230.1355268-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0280079691076388306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646680

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
GitLint                       PASS      0.72 seconds
Prep - Setup ELL              PASS      44.61 seconds
Build - Prep                  PASS      0.57 seconds
Build - Configure             PASS      8.79 seconds
Build - Make                  PASS      1393.52 seconds
Make Check                    PASS      12.16 seconds
Make Check w/Valgrind         PASS      447.51 seconds
Make Distcheck                PASS      233.13 seconds
Build w/ext ELL - Configure   PASS      8.55 seconds
Build w/ext ELL - Make        PASS      1382.88 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============0280079691076388306==--

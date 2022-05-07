Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58C3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 01:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358963AbiEGBhL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 21:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiEGBhJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 21:37:09 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A62E5DBC7
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 18:33:25 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j6so7135978qkp.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 18:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3sSoXQcmPb9Vh4kOt7tvhDdgdsasDlGIrctBd1IpFaI=;
        b=VNxlETG3M9rfwBIk5mpxLqnx8DtBzAVwBvNhiLkiPvGBUVpHFE5sLkz4OWbEWaOGTs
         MACGApTU+SaVnvRaUYI8JU7O0n6Y26HECjL2wuKdWhQ8IqYBJI9FRARz5K6im+OojCqG
         gvmQdx0net3Du4z0YHHbSCdeYdNzptHxutqaJV+vtmQ0fpmvGgqLT3YFynrJ+O3yFWAn
         fAT4NZKbMbQCd+jI415VDAdP3mL1luhF4TdLrMfkaYe44I4oxJTFMHMbh8oBhFLb+PO/
         yD6Xf9XBETn2W1ylAb495bvA7HilemCtbf33KEHYK/E97+Sb4dnPsaoJZdl5jPYPkOPk
         HaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3sSoXQcmPb9Vh4kOt7tvhDdgdsasDlGIrctBd1IpFaI=;
        b=ZP4uWekJ8OoPNyWludWW6Jh0ERMUnNvVX7I+/B1n9yeMQlY36FY5U+oHnGmdJPr3RE
         DFYxjZdN9eIYxGA4/VkAzz4JeL60i23K/0bpNDFGotqWj2c1QeL17jJWUCCuHzsA9KXf
         N9M3IzNXPE5ceYsG7EDzrXOrVjJtGjBM/iBMkYM3Vh2Sy3+6m9j6Y619UplZvxF8pS23
         Z2ClmsHmnspBX9n+P49aketJWj67VEt0mnQhr9nEVWkx1+HhScCi36jz/k4fkd/Uq3oY
         0ZU1egN4xWzlLYvaPrrsi/KopPH0bmDeclsUsI0LbQd3YMrEyzQsFWcutJcfEtE/MQSq
         RLTg==
X-Gm-Message-State: AOAM531hnWWNBCje29GsGfMXWrKchqHQdv2aEIqejOLqi2Tg7cncqgV6
        kib+O3GTdUMRvVdGrtq6ahMP7b9A5HF/EQ==
X-Google-Smtp-Source: ABdhPJxYnKQk6KeJLt6Z5jVQRtXn/xiZloT78hIYvIZ8oEJCcdM7s9o/v/QfrE3t/ndYVKrRQAQfrw==
X-Received: by 2002:ae9:dd46:0:b0:69f:7a60:dec3 with SMTP id r67-20020ae9dd46000000b0069f7a60dec3mr4552692qkf.436.1651887204037;
        Fri, 06 May 2022 18:33:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.107.152])
        by smtp.gmail.com with ESMTPSA id z26-20020ac86b9a000000b002f39b99f688sm3673962qts.34.2022.05.06.18.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 18:33:23 -0700 (PDT)
Message-ID: <6275cc63.1c69fb81.29205.3666@mx.google.com>
Date:   Fri, 06 May 2022 18:33:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4777815569978813340=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,BlueZ,1/8] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220506223139.3950573-4-luiz.dentz@gmail.com>
References: <20220506223139.3950573-4-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4777815569978813340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639259

---Test result---

Test Summary:
CheckPatch                    PASS      5.95 seconds
GitLint                       PASS      4.07 seconds
Prep - Setup ELL              PASS      53.17 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      10.73 seconds
Build - Make                  PASS      1522.68 seconds
Make Check                    PASS      12.25 seconds
Make Check w/Valgrind         PASS      535.82 seconds
Make Distcheck                PASS      282.86 seconds
Build w/ext ELL - Configure   PASS      10.65 seconds
Build w/ext ELL - Make        PASS      1484.76 seconds
Incremental Build with patchesPASS      6094.60 seconds



---
Regards,
Linux Bluetooth


--===============4777815569978813340==--

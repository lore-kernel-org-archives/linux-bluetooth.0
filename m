Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C862ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 11:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIULVl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIULVh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 07:21:37 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4046FA3F
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 04:21:37 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d64so4585356oia.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=YkzQ5PRJbZYoC3NVke9rit92Ryk7vvOpIfkUHxfNC+8=;
        b=d4Y1+kV+fiGZWhjZdGddTiJLiBOAWvRXpuxAAXhKobpe8Rhmc++nJUlha2uQ229g5o
         Aofx5tfpDy/KQXArcL3/2GsErH7Z7pGdqGoO33uNdRj+QnGAWd0PCDEztUBiOYcmOG72
         TSspjbMGWYOzrKPNSYS2pDXjFhtg0Jz/wEm9gdtdLT2OPYYbpiyew3lDoe9PTY7DW2P6
         IqRiNgzBn2hglxxEYV0aMn/K/Q2+0QAKgmh4oXEgS6xRNVJhTZPhiD/EEXYKm5rVoRCb
         SRxJLxYpVkxp3mFfUzx1QVTU2mtee7P4IaterolnNaD/LMQUsEeeM5zB9MbLKSvpuFQ0
         tkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=YkzQ5PRJbZYoC3NVke9rit92Ryk7vvOpIfkUHxfNC+8=;
        b=VtTjKKnRc2ATpocD3XUFgS+ZDgC2EeuM+tR17e1YQBg/oI3yh/oNlc/jKA7QUZsMrd
         msySJTBcKmObcWl/BoTn495QNqPhw1R56gL+7L1k9PyC4lcqIhOjCoo5tEeOxf4hFfzO
         eQ81x3QVaWJZIhDEPZwvj1NFNEV0vEAVXx9JsMgQSZi+tYAxZ3fuOYwGVwBdYORixsa9
         9y2X55XedvnI/nnCUbNLUuKmkkdpGV6JFbklafUkK9eGJ+FTBAR/6VUkfrjJM76UqaJB
         NAnuDN0SolXz/kNQlWSlZbYLWKCY09UWcLrGW5XdqJWbQ5mjstQ9We1FmZYjPaf8ysc8
         fr7g==
X-Gm-Message-State: ACrzQf3VrmrzgWFuwocA2Ti/IaYVZPNH/SqiVNcpU7hX4oFFKRjifVMs
        ThAcZPOFHrLJ62NA6ZMym5O1JD/u4PnMVQ==
X-Google-Smtp-Source: AMsMyM4y9YkKRTXoRLpgclun02C42zrO9jI9Nbu+EbahEov4iWT1oNepD8fxg0+l4W8X+AVHLbEGdQ==
X-Received: by 2002:aca:1119:0:b0:34f:d61d:698d with SMTP id 25-20020aca1119000000b0034fd61d698dmr3599842oir.277.1663759296335;
        Wed, 21 Sep 2022 04:21:36 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.234.34])
        by smtp.gmail.com with ESMTPSA id 26-20020aca0f1a000000b0034f937c50fasm1029664oip.49.2022.09.21.04.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:21:35 -0700 (PDT)
Message-ID: <632af3bf.ca0a0220.efc7f.4008@mx.google.com>
Date:   Wed, 21 Sep 2022 04:21:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4668985394932054545=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [BlueZ,v2,1/2] shared/vcp: Add bt_vcp_set_debug
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220921102732.688081-1-sathish.narasimman@intel.com>
References: <20220921102732.688081-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4668985394932054545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679002

---Test result---

Test Summary:
CheckPatch                    PASS      2.56 seconds
GitLint                       PASS      1.58 seconds
Prep - Setup ELL              PASS      32.59 seconds
Build - Prep                  PASS      0.93 seconds
Build - Configure             PASS      10.18 seconds
Build - Make                  PASS      1064.68 seconds
Make Check                    PASS      12.77 seconds
Make Check w/Valgrind         PASS      352.92 seconds
Make Distcheck                PASS      298.91 seconds
Build w/ext ELL - Configure   PASS      10.47 seconds
Build w/ext ELL - Make        PASS      106.23 seconds
Incremental Build w/ patches  PASS      251.04 seconds
Scan Build                    PASS      686.01 seconds



---
Regards,
Linux Bluetooth


--===============4668985394932054545==--

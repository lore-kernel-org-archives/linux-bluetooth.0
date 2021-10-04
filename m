Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7406AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5266108F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhJDWh4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 18:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbhJDWh4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 18:37:56 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0FC061749
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 15:36:06 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r2so17949629pgl.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WvJTqRgfl0oLeor64szAWPOJwWw4b4sFMGFcoW+0hdQ=;
        b=o09KVlVp47KzgZ2AYvdVrimlPRP5XfFYBZlCGgBV9QeWPcLZ2h9fVlC0HSkKQNvSLk
         buT9joqLqC/Nv9ix68oCi7CVjdI1MTWSwWGa3o+QPipddLtablIuM0O8AdBVug5MvOzn
         lADvPS2oRoQDNqxnBGuhrT8oDCXuAuZ0cQ4e+zyAaRUVtEh1eL9ESsYiplkZfztXGtrc
         B55a6t28AhqKEfoQUzrvKYoJO8TnYB2BWrMZQ1OTb9Rl9vnbDMS86vpfTaHKR57xg8+s
         M9OQr+Mn1+HU/j+q2LCFQMwIbN9JdHgSy1rzoz9duFw4E+JY2v7AQCyf5bJB+j6srZqm
         G3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WvJTqRgfl0oLeor64szAWPOJwWw4b4sFMGFcoW+0hdQ=;
        b=evOZ5rz+5qEJ/+9bpCU+JQLl+3GXTzGvzzKCG5+79cnrWD3x+g4nQHiFdp8Z/ewhXP
         HU9jp9+PDTqVekgo5VmqUYJs4yWaiGQX5b4j58z8hnTzJgkh6iLEuCWyEBNMM6qGQA55
         4SzikOuGltohXdZ3fXeax/vaP5POk5vLRF/AESApwSbhRn499kv9MqVuxhxRq19zCYNt
         A6Puh5iyStfOnsC0TjHHfjORKgD61pmGnup/aT27V5c22C48BQgNBebSuESUYHqE2v8m
         rHnFCsE9RjeZJntRIQbP8L0MEFwS7AHEa2aVZRHQY++sW8yzcLdZbKxq7TG+jjS/7c1l
         /M6g==
X-Gm-Message-State: AOAM532ttQym3ngGIBUlrcNxq4lIO24ON4P21R35BMmAhgtEK3k/whw0
        gwHQ2Ph8UeqqN+eZDeKjN9NvBR2ntwI=
X-Google-Smtp-Source: ABdhPJzMx0YMB1jfKh3EshB3RUPB8Xqs084wl7vwFpckohoRgIvWlVmj80LBQlcWKC8C2svsaGPwuw==
X-Received: by 2002:a63:7447:: with SMTP id e7mr12859966pgn.240.1633386966104;
        Mon, 04 Oct 2021 15:36:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.100.100])
        by smtp.gmail.com with ESMTPSA id b134sm3091013pga.3.2021.10.04.15.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 15:36:05 -0700 (PDT)
Message-ID: <615b81d5.1c69fb81.ebe57.9357@mx.google.com>
Date:   Mon, 04 Oct 2021 15:36:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8467022644854581079=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/mgmt-tester: Fix the suspend reason code
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211004215630.216603-1-hj.tedd.an@gmail.com>
References: <20211004215630.216603-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8467022644854581079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=557383

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.28 seconds
Prep - Setup ELL              PASS      43.19 seconds
Build - Prep                  PASS      0.21 seconds
Build - Configure             PASS      7.72 seconds
Build - Make                  PASS      184.40 seconds
Make Check                    PASS      9.19 seconds
Make Distcheck                PASS      220.77 seconds
Build w/ext ELL - Configure   PASS      7.74 seconds
Build w/ext ELL - Make        PASS      179.59 seconds



---
Regards,
Linux Bluetooth


--===============8467022644854581079==--

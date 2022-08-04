Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EF0C19F29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 02:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiHDCqt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 22:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiHDCqs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 22:46:48 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAAA1EC72
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 19:46:47 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s204so21900660oif.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 19:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=YP7N8aBZje5bqqLToUNtyqvlGtf/zWrJ8cStjVOr2BA=;
        b=AnaIf0RoUR3+18HXwXgKAQF76N50Mpm5H8s+6iSYWInLRAk2XRaHb5rTxphQ9RwuMz
         Tjo8zZ4vgRubu0STxtDkS2ygidT+vlMjLYWyB5tRqfYh9E4j+LPx/CuoXRzDwrYHJYAj
         9fK2dn7WKp4EgF1jZ5qMDg+ysmTq1aHRriryx6WAfgKV4/m38rU6sFB3vh4eSMbgLZw3
         YCPPUGw1xOqvmsrg7cB3Q5uy/fD20pBig3edhFh7sAy3twyvDPwm9JfulyCP4plNiNKs
         rqOAbT2kHqeUtpiHo4yRvhYCre7O8LD7S+nAQQY3EggzSO6wAQtmEIBxWZ4uK1piv26l
         4RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=YP7N8aBZje5bqqLToUNtyqvlGtf/zWrJ8cStjVOr2BA=;
        b=Xy0hVnmeiTv7errxTl60GxA/PnkcbAqdIzt8iUoZt2K/8Jkn15NCbopSLLxPFvMuCW
         hZb7pfksgFHxdRsPmq5FBGc80/nXEhX4kE4UKkuaJdOFFkm2d/tL7WObiKZnPsOlgMI0
         /CN7AOLvcEEMLf1RvPDNa+qjPhDe8zEsg+EibqyiB382YAh0qZpavXeBibUKCtGMkGcl
         eK15IvuPR5MB2GjciLVZjvOxonI20eoJObQK2ZIF2nPgbi6/HwiLywdIkZaWILtlf33N
         hsto2764CQxiw+Ag+AV7uaTA7nqB6W42wk2Baiwd1aWgZaknQTe5WWB7VcqvER2GrlhI
         KtzQ==
X-Gm-Message-State: ACgBeo0rfI/VSE3chGXD58FN7CLj91cWIcOFqSgOAYBxbAehopIJF3tm
        505syCTBXT3Wl5Xx6ptkDMofPCBrdcVjrg==
X-Google-Smtp-Source: AA6agR4184+SFPETEYywEHLu+dynhFfIUvkcF0bbYnbEYNh8jfJj/2ooeal9TzMXxlDNSk4NGUQCnA==
X-Received: by 2002:a17:90b:8c6:b0:1f4:e3d6:cc9c with SMTP id ds6-20020a17090b08c600b001f4e3d6cc9cmr8054574pjb.167.1659581196710;
        Wed, 03 Aug 2022 19:46:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.92.135])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b0016db7f49cc2sm2753798plg.115.2022.08.03.19.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 19:46:36 -0700 (PDT)
Message-ID: <62eb330c.170a0220.d0a8e.535e@mx.google.com>
Date:   Wed, 03 Aug 2022 19:46:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0511140431764142354=="
MIME-Version: 1.0
Subject: RE: [v4] Bluetooth: btusb: mediatek: fix WMT failure during runtime suspend
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
In-Reply-To: <ab9f6acff9c0d5f5b639827ef9d5c2bfecfe95b7.1659573623.git.objelf@gmail.com>
References: <ab9f6acff9c0d5f5b639827ef9d5c2bfecfe95b7.1659573623.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0511140431764142354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/bluetooth/btusb.c:2436
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0511140431764142354==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 23:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351287AbhLGAA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 19:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhLGAA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 19:00:26 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFCFC061746
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Dec 2021 15:56:57 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z9so12591705qtj.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Dec 2021 15:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HRWUJ65bFl1tTejvy9iz1dixX9VVX9ahQBy7Uc4wHpo=;
        b=k2C00wfr+JAbRDPrKmhCvmmF9NUtn75H9UKvX3u/x5IDx/kp5vt0pTOfdjrVrZxd4g
         /MckPCo8a4uPhR7a2VbMy0FjKKgUg0kHplQDIfnBhazl6tNu2OauexghWAm3FAd4x//V
         5Zc4yM37LPMtowvYgBH4q11Oh23SdrIKZztJBoFF9jcEAm5BQV3d1N3HQmeeSYFAhVi1
         XOjdxep5eEAi1AqBreN2XjME9F0uNNs699E+FX3uHxR0+eeLwaGjVl1zfGktgNpf02d6
         mhZHpilQV017UVNsbMXlDXdb4/pQelMUYercvYDbp8WKwWOdNgBBxek/zhHw6Tud5QQO
         jmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HRWUJ65bFl1tTejvy9iz1dixX9VVX9ahQBy7Uc4wHpo=;
        b=5bDCD0oWfYGXIe1DcXdcYCOUlTTt9/djbf5Gn0oSdjw3ebtZ2RfS/Tldr4iTXWc8LG
         h07/ZHoTpON8Ne3P+/65pzGtv5Zgzt16Kt0KOwGdm2wKITFaEhXOHuAbdjieAJpJFTFZ
         8FQNsR53ahUHstziq/ulglOMlVykWr0WDWoEMw7M49T5xWxIXhwz2OyIKgbj2miqUiXH
         h+bipPPZWXjTmPNW6iz2bPFtCypQk3y1OUnEJ4sn2uZisc1fyfxqf+ib63FjsB6Cn5z7
         HuNbzvVF+3cJe+nd30gSeIWDeUVivOzepw0FTNkgQvcVlr205oMWR9f551Iuf0Dili1I
         48qg==
X-Gm-Message-State: AOAM531MHj65/9xiqjDW5HinWvu/T1/R5WBX+EjKZcNx7+X+1r8ZzKTV
        dOj1wOmYdD/0DyOWT/28UHqTqLhIIW/+mw==
X-Google-Smtp-Source: ABdhPJwjfdyE/oofUGxRFnPpWOgW82zEF7Lr7TkwmpyWq7OM3v3jQ6d/dCKL9BOzlSB/m5HcwkEwoQ==
X-Received: by 2002:a05:622a:11d4:: with SMTP id n20mr42404894qtk.412.1638835016261;
        Mon, 06 Dec 2021 15:56:56 -0800 (PST)
Received: from [172.17.0.2] ([52.170.134.216])
        by smtp.gmail.com with ESMTPSA id y12sm6934113qko.36.2021.12.06.15.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 15:56:55 -0800 (PST)
Message-ID: <61aea347.1c69fb81.bfa99.9f2a@mx.google.com>
Date:   Mon, 06 Dec 2021 15:56:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1274717115568520961=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ulissesaraujocosta@gmail.com
Subject: RE: [BlueZ] client/gatt: Fix property_change in WriteValue for desc
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211206234001.4248-1-ulissesaraujocosta@gmail.com>
References: <20211206234001.4248-1-ulissesaraujocosta@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1274717115568520961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=591213

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.86 seconds
Prep - Setup ELL              PASS      42.63 seconds
Build - Prep                  PASS      0.43 seconds
Build - Configure             PASS      8.04 seconds
Build - Make                  PASS      183.51 seconds
Make Check                    PASS      9.36 seconds
Make Distcheck                PASS      218.76 seconds
Build w/ext ELL - Configure   PASS      8.12 seconds
Build w/ext ELL - Make        PASS      172.56 seconds



---
Regards,
Linux Bluetooth


--===============1274717115568520961==--

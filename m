Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3D0ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 00:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiINAaO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 20:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiINAaM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 20:30:12 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366EF31363
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 17:30:11 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i15so10563525qvp.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 17:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=8eFlz06WXgamuD/dKMe2dzsPdQLkK2PEAryORMmA4Jk=;
        b=SewvHggX317E+xCuafAS9BWCEm80sVaOSM7/WupBa0VRSUby6Uf0zCFjvUMqzNSR3R
         6nJSsqASjmYQMYHQsTm4gz2t+LRIvpx5NfQ5ELqlICbqt8HGXjTpZ5gcY5XNxvJ2WRkI
         KoGjA8q4+01b4B4rkqTuYbKGGZYPNzt+zSxrVmm9Dxvzr/bUUsFbYotyPwLifhFBwYjB
         Erh26XY6YKhVltVXm0I1038MZLn4U4tsdmHYMhE9CtxTwle7KEfjv6wzd5m+/8ovi76l
         PAq7Jj9WpncL9y3U2zSpHs0bp9BvJXzecE9n3axYquk1FLQGH2GHFbEE5s+ruDbselIz
         W3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=8eFlz06WXgamuD/dKMe2dzsPdQLkK2PEAryORMmA4Jk=;
        b=IB9f8klScftzSylgsw+Oci5EfutEh0C+nJGnrK/3hmMLF9lK8U7PrrkJ3hsH4FnSG+
         74TNYq8Y2QEyuXo4bjY16Dv2dsT0kyPf7dxN4mNWRkCWBDenNV3Oa4grxjLn82fR1I8c
         qQnQiuLi55ZbTZA6sITwB5c+V50E7m56V2EHTimIdQ91NNibOipoo6VBoWm0mIPIxjXf
         PFMaTppGZyV/NDptAQQfHgcWixBPOctsBih83yG8bw+gQdd2TGNezs51hL2tBHFJBRnD
         2ZC/AetWKyjv6oTwhzKIoyGwq4HCzvjt3j6FpkzkTjF/5PlVbnxFXvLt9siYUHe2KLZI
         wUzg==
X-Gm-Message-State: ACgBeo1GXvrdEjrJbBlEb0ADfEG4cVfXWfBpd7xBIOL6ErAPiayRPZ8j
        K5xyREgdboM2yDYPvurDY3Zr5HiXykA=
X-Google-Smtp-Source: AA6agR5kHYJuvo9SIXvgKCl7iQwqDXnFjTAwkLZOjGGYqCORwJH3+F9PnwSS6mmazVkj6LC7hwWS8Q==
X-Received: by 2002:a05:6214:d89:b0:4ac:b862:90da with SMTP id e9-20020a0562140d8900b004acb86290damr10607389qve.71.1663115409934;
        Tue, 13 Sep 2022 17:30:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.68.46])
        by smtp.gmail.com with ESMTPSA id l2-20020a37f902000000b006b9c355ed75sm653281qkj.70.2022.09.13.17.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 17:30:09 -0700 (PDT)
Message-ID: <63212091.370a0220.536c6.239f@mx.google.com>
Date:   Tue, 13 Sep 2022 17:30:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6978378990492762460=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] rfcomm-tester: Add test to close socket while connecting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220913233349.526675-1-luiz.dentz@gmail.com>
References: <20220913233349.526675-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6978378990492762460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676715

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      27.14 seconds
Build - Prep                  PASS      0.88 seconds
Build - Configure             PASS      8.64 seconds
Build - Make                  PASS      954.48 seconds
Make Check                    PASS      12.11 seconds
Make Check w/Valgrind         PASS      291.47 seconds
Make Distcheck                PASS      240.42 seconds
Build w/ext ELL - Configure   PASS      8.76 seconds
Build w/ext ELL - Make        PASS      84.35 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      503.77 seconds



---
Regards,
Linux Bluetooth


--===============6978378990492762460==--

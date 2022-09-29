Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57455C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiI2TDF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiI2TDC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:03:02 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E314354C
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:03:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n83so2545310oif.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Slg1gZjhZTEFnozInG3oISaGhsmNqmsI5VpA6Cid4a0=;
        b=AQk44tWKm/t2obWPhIFGPKbqwIrBfeBvvRc+XICqXaytKLkXr+rGInPSAv6wnplsL8
         5fSPZdMWieEvAVoixqxt/1da1WyDT8vmlcfvN/KS1heyx6nuA0k6Pq5wGeAX7i1o0c7I
         foVelwl94AHvaeZ1qcACPhzhBMvWKTw/EUUmbGksfWxNBdw4rM0vkgjlhVkoaukk05d6
         ZMiLKa5VZgFuB7wPE8AK206hgEAuftSHGEXJ8Phxe/MiioW58NeR+slJgLltmN9/UXiV
         xpdcywoKunpThoGGpiEDP42KhS7CdVXsTZqHMV5j7Z6UFnnU8EFzZmKXCKNMWHun4qz3
         APYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Slg1gZjhZTEFnozInG3oISaGhsmNqmsI5VpA6Cid4a0=;
        b=pC2jmLwDDuTzIenEG/ehmgmcWH5dA2DkPWJbwqDDo+R4eFindHz8znJzkX73872hMQ
         zYuHxkD3DxmmXJvi0xOe1PbBfxPvqex57UnbWPSTCQgwIm+yctROruokcNVb2KsForaG
         6+a9Dctk5VtUX9PeaUgcbEfEEt6BTBk5ZXUneNsvQiWS2lbP/h3wUYk/aJaB5hn0EeQk
         K41PoF7Sn4ACVwv/T4UEvfSyi25zis5tbRWX7kCuop50CXOSoKr67Rkc/r0HgJoJYal8
         /O/xGAHqWFhl0ggwfeNm9Gj87wgJQhDFhyAKnoHnKfajEsj6qEEWHRlxGHvuRmRG/RZL
         RG+g==
X-Gm-Message-State: ACrzQf3Qy4m4cKtCh64qfE6wFUdHCfMZl/8sOirgGg49xrt5jJFEhAVk
        6FYe0g2hNytFUEqgf3rR4G2S2cyp5ec=
X-Google-Smtp-Source: AMsMyM58mlO+4lYmsHjFCG0wO+HuEP6iy1V3Zg9wPbY3vLUKEtYKoXFVVSEfp1YjERah9fFQFLFgUQ==
X-Received: by 2002:a05:6808:f8d:b0:350:ec44:80b1 with SMTP id o13-20020a0568080f8d00b00350ec4480b1mr2259139oiw.162.1664478180624;
        Thu, 29 Sep 2022 12:03:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.84.214.97])
        by smtp.gmail.com with ESMTPSA id g96-20020a9d2de9000000b00637190319eesm113912otb.29.2022.09.29.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:03:00 -0700 (PDT)
Message-ID: <6335ebe4.9d0a0220.2769e.09b1@mx.google.com>
Date:   Thu, 29 Sep 2022 12:03:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0044824362562380276=="
MIME-Version: 1.0
Subject: RE: [v4,03/18] Bluetooth: RFCOMM: remove define-only RFCOMM_TTY_MAGIC ex-magic-number
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nabijaczleweli@nabijaczleweli.xyz
In-Reply-To: <f6d375201dfd99416ea03b49b3dd40af56c1537e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <f6d375201dfd99416ea03b49b3dd40af56c1537e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0044824362562380276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: Documentation/process/magic-number.rst:78
error: Documentation/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/it_IT/process/magic-number.rst:84
error: Documentation/translations/it_IT/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/zh_CN/process/magic-number.rst:67
error: Documentation/translations/zh_CN/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/zh_TW/process/magic-number.rst:70
error: Documentation/translations/zh_TW/process/magic-number.rst: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0044824362562380276==--

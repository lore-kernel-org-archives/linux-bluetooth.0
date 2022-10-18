Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CA3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 19:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJRTy3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJRTyO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 15:54:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB488DCB
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 12:54:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gf8so14999713pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FRAORO5bjzmMCkw/3BMvRZjW/8GO7OWivNtU0BCd2EY=;
        b=EPrnR1xOGfalA9FdJ08/tUZu7olGOlayGFlJ5qvTu/0g8TlWmW6180X/xFpYkTEV4p
         YEWFn1nZ9Vq2/UP4GnCwPWVe/umYz0zpYn8pc3T3jkHQELrvo0Eu4C+UUDth4ueJ9+c9
         +RX8E/mXrJzITQqAVUUMpAt7bsn4AmCrddSj7FMOQAf70lDAUquJJt0vUoIQiIIPkZTV
         F44QMKsRJyiI8gi+D6O5Zk5Ni9NNHdeZtrKdgjgA6LmvvmbTUysOcdkqnhm/wJfTBYDK
         9ZxaRtCBv+0RsaroNFv9iItv6bHE5vQ43NU9ZgKgSLrn+jRQr1h6TJQCewEhukhpkV0n
         2qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRAORO5bjzmMCkw/3BMvRZjW/8GO7OWivNtU0BCd2EY=;
        b=dbwd20nyb9zu5dXIqA5w0tAqAIS8oi5dl/OuqqbJD6mnYPHYRw5STc7K7S9sYAOJK6
         oVpypPVKfqu1YsVjTts1U9zj52nGJnkOBRWOLaV6OllIkFE2Utu87AdtY8cUtKP2FfUZ
         B6PEHa4bwSnZKXab+DcBj0lTqpIfttdHLXcCOXPIh/2/cOJr+na034XNNwP9Xb77kNcR
         cAXQg7BS6kF9Ufaut3YI9ki5SqqM5fdURfCTCnv4upo8IuHCd9PzI6yglOxkx4bZq3uI
         TJcKLASNOTe6LJrXKSymaDlbEG3NEJW9JUbgsJ7rwgWWELAJOtrTiUAslDEHwOA905Q0
         uIiQ==
X-Gm-Message-State: ACrzQf39jFZhrIoLTa+z37cxp3FWmLdbx6DaJqDRwjIq67tbB0O38/i8
        IDdj2yLvXkMuvwJg1qFtAEDPULOiOdw=
X-Google-Smtp-Source: AMsMyM6XyblbvK4Jld3KV3oUWm+bVEwfZUwTVVH/hrrPD7+tc1w8Z+RbW+hWHHUSlEjGKANIyzsMDA==
X-Received: by 2002:a17:902:c952:b0:183:6e51:4fa with SMTP id i18-20020a170902c95200b001836e5104famr4928937pla.42.1666122845804;
        Tue, 18 Oct 2022 12:54:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.237.181.221])
        by smtp.gmail.com with ESMTPSA id p4-20020a637f44000000b0043954df3162sm8251825pgn.10.2022.10.18.12.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 12:54:05 -0700 (PDT)
Message-ID: <634f045d.630a0220.5e841.f646@mx.google.com>
Date:   Tue, 18 Oct 2022 12:54:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8098594344187936585=="
MIME-Version: 1.0
Subject: RE: virtio_bt: Fix alignment in configuration struct
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, igor.skalkin@opensynergy.com
In-Reply-To: <20221018191911.589564-2-Igor.Skalkin@opensynergy.com>
References: <20221018191911.589564-2-Igor.Skalkin@opensynergy.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8098594344187936585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/bluetooth/virtio_bt.c:306
error: drivers/bluetooth/virtio_bt.c: patch does not apply
error: patch failed: include/uapi/linux/virtio_bt.h:9
error: include/uapi/linux/virtio_bt.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8098594344187936585==--

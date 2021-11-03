Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 09:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A30B6112D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 09:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhKCJlY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhKCJlC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 05:41:02 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C67C061714
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 02:38:26 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id g25so2337186qvf.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Nov 2021 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RR6UJ/edQJbA+PzeKKIBZ56Z7Bu9MIpcbKOnSWZbwoU=;
        b=DeAUWydt/z54eZW+tKgxjH2+qTbiUT5woCH8Er5IYLROpjt9HoDchDY6fmar8POKTC
         6D3iJIMJPVHKMWaNGmJRymKGHrpUj8WGtam2573R84LDahr4bB+wXR2xankkd+u7ayk3
         sOvPA7nPKUVLowI5k7ak6gf0hPnPia+eL3Wkw9mKvCYDR6HUm0i5/gYugr2eJeAcEX7+
         6cgVqbQiCdcygo8Ao/TTVFLA1885Jeza/e2CfY5ii13fQOShbBX3MYWGq0VDMtrwB+ZV
         p+xrYH6mW/fhaKzHzHYgz6Z3ruwty44GgzHNlv7Ws3MFhbH2GpPm2JT1g8UB5Fi1DfnY
         lC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RR6UJ/edQJbA+PzeKKIBZ56Z7Bu9MIpcbKOnSWZbwoU=;
        b=bz5DrTCYfMB+rjzupoYxLHk0g7beiEkqlNeRhNappx4k2+f6znTXcaCR9/6O8/FRyq
         8w/Q1KdVFvBAq3Axm9DAiIPUKGKtgfkIT4ehvnmVrR/WoNfJ537wfNOHnEmHx1Q4HbGr
         cH8qoav+3TLebGUsvScPQpQQY1kD//vscI3j2P2LGYTexiCBcPcOidEt7GOwWHduz4Hr
         RaK+OtJQZV2xkP8jThI+q4Cl2crdkbrz1t3rzq6LnifTxwd56CfNuHObAdLd49u2GjRu
         9zJ+oG4I1RCcuqQvEc3/DT8z00f/z2J9rnL+rd38oxPxu6olIfFnYWejRGnG+MYFkGdO
         TRIw==
X-Gm-Message-State: AOAM532N3nGxNm7cmRmAnfnGU19CQTJIZleOri6Igw/+ATEE7S2/FZU7
        /A+T/BmhgX7VgcWc7WsV2i609Y+opakQ+Q==
X-Google-Smtp-Source: ABdhPJy8h617JVLQi+CrbR4D0iaywZ+sokvMyGPnNhD4UodFHv+59RimRHGGXzadDPUgjPJx5M9TqA==
X-Received: by 2002:ac8:5cc5:: with SMTP id s5mr44090437qta.256.1635932305415;
        Wed, 03 Nov 2021 02:38:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.147.79])
        by smtp.gmail.com with ESMTPSA id v19sm1326454qtk.6.2021.11.03.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 02:38:25 -0700 (PDT)
Message-ID: <61825891.1c69fb81.61efa.6759@mx.google.com>
Date:   Wed, 03 Nov 2021 02:38:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6007471115369070531=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2,1/3] adapter: Use PeripheralLongTermKey to store LTK
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211103170206.Bluez.v2.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
References: <20211103170206.Bluez.v2.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6007471115369070531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=574639

---Test result---

Test Summary:
CheckPatch                    PASS      4.46 seconds
GitLint                       PASS      3.02 seconds
Prep - Setup ELL              PASS      49.79 seconds
Build - Prep                  PASS      0.54 seconds
Build - Configure             PASS      9.54 seconds
Build - Make                  PASS      216.71 seconds
Make Check                    PASS      9.87 seconds
Make Distcheck                PASS      251.91 seconds
Build w/ext ELL - Configure   PASS      8.81 seconds
Build w/ext ELL - Make        PASS      198.37 seconds



---
Regards,
Linux Bluetooth


--===============6007471115369070531==--

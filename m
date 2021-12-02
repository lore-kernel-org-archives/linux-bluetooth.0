Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFD1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 23:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349300AbhLBXF6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Dec 2021 18:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhLBXF6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Dec 2021 18:05:58 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B9EC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 15:02:35 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 70so633134vkx.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Dec 2021 15:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dv9IS84oYg7+nWeRYyxjHovGZiHJCu2caKpGCf6vfVs=;
        b=i1Gv2s2wdzP/xXhG0khj4Wmqv/09CUOshZ3q/5Uj/2MqpuTErP9XrpJrl99OwE3tm5
         4xZVqdpV97L7dEsiLjAD+xycv/XyTQAz4oeedsyoJTeoWa7EQRxPWdIzbxop7vD/6/CA
         OlUUsQeXRphOP27Ra1mK2pJ125SxKeQkqy/AxzxnYBdYcFve8Fs5luwB/RoPGo8KVWIL
         6mI3fOWU3E5MPHYfXcTo8dji4XhDonOTMegNXRPNAVgGLTMO7QtEryMnzs/R+S7Es5Xk
         jY9msJh31S5HqR9192gXVtS/hyMm0RPiWLm5hBKFawOXtNG8KoQ7PogdXeX/rzniFLex
         EO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dv9IS84oYg7+nWeRYyxjHovGZiHJCu2caKpGCf6vfVs=;
        b=J2OKIoJirI1eyH6C+4tGlUtWPgIb2vBet+kplrswKwDR8xH3hBUjYFc4iRhgVePdTF
         +FMZ6EwiJyA7FlNWA6xwNJz7LCuuHBJBjhz0/fX80A2mRufo5CEhyr813TGkyFapA4WA
         MKs1HwIvo+7XOINBBCdKE8FVjswq93TjV5crZ2BDWy/MHK9lvzN+Dr2Qhb2WI0XK9GDT
         ZL4wbm3v3sbFMnlzyEk2m7jjfsr9sFIjBSXvhQJTJMvbQiPCIyLYbLrlfHV0FVj8PU3k
         qFqbKtQ29++oN4RfGA4qdVPDcfdd/Ezw55w9AMEKdCqbOHjSNz7CEMNN0fepuCOLxvDp
         QZmA==
X-Gm-Message-State: AOAM533QWbF/6pKt4GR5unVsa0EEMZMmkrEGEKcMHV0HBn1yEUQ7m+zy
        aA5Qvb1g7RjptuFGy58rC+EHjC9p78mZtXi4F8k2wxTl
X-Google-Smtp-Source: ABdhPJyAiBs8tI8fWEA7ykKmaRr27N44MYEcsqo7CCyro1LMP/31EpHLR/yH0JH0xIy1XN/EOomx9XU9QPIvv9Uno5c=
X-Received: by 2002:a05:6122:d8d:: with SMTP id bc13mr19751598vkb.22.1638486154025;
 Thu, 02 Dec 2021 15:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20211202222619.626678-1-brian.gix@intel.com>
In-Reply-To: <20211202222619.626678-1-brian.gix@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Dec 2021 15:02:23 -0800
Message-ID: <CABBYNZLX9Cahgh1auLefyjb4zC6J6-BkHy-Zt_v9vu2fWq-7gA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kernel based Mesh support
To:     Brian Gix <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Thu, Dec 2, 2021 at 2:26 PM Brian Gix <brian.gix@intel.com> wrote:
>
> This patch set implements support for sending and receiving Mesh packets
> in the kernel without assuming full control of the Bluetooth Controller.
>
> The purpose of the patch-set is to allow co-existance and sharing of a
> single controller between the Classic Bluetooth daemon (bluetoothd) and
> the Bluetooth Mesh daemon (bluetooth-meshd).
>
> Basic functionality is that once enabled, the bluetooth controller will
> always at a minimum be performing a Passive Scan, and can at any time
> request an ADV packet to be sent.
>
> Brian Gix (2):
>   Bluetooth: Add management API for Mesh support
>   Bluetooth: Implement support for Mesh
>
>  include/net/bluetooth/hci.h      |   5 +
>  include/net/bluetooth/hci_core.h |  16 ++-
>  include/net/bluetooth/hci_sync.h |   2 +
>  include/net/bluetooth/mgmt.h     |  26 ++++
>  net/bluetooth/hci_conn.c         |   4 +-
>  net/bluetooth/hci_event.c        |  61 +++++----
>  net/bluetooth/hci_request.c      | 119 ++++++++++++++----
>  net/bluetooth/hci_sync.c         |  94 +++++++++++---
>  net/bluetooth/mgmt.c             | 208 +++++++++++++++++++++++++++++--
>  9 files changed, 456 insertions(+), 79 deletions(-)
>
> --
> 2.31.1

I'd like to see the documentation of those MGMT command/events first
so we can agree on their requirements, etc, that said what I had in
mind was quite different approach with use of a dedicated socket type
for the advertising bearer, so it is more generic and allow any
protocol not just mesh on top of the advertising bearer and on the
plus side we also have BPF filtering which would be a lot simpler
doing on a bare advertising bearer than on top of MGMT protocol.

-- 
Luiz Augusto von Dentz

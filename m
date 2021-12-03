Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A04C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbhLCSvE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 13:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhLCSvE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 13:51:04 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D9C061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 10:47:39 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id l24so7300748uak.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 10:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNoufLOeU2au3B1+RnRvzkw/qNNhUMpZeGuuYeJjeEo=;
        b=PTG3cm2ASvmjVu5p6Osh6/FFgqgQsmLkZbB5zNcyBTyEOkmbNTQXHcv7qz1aEcaVlL
         t1/jwg54w8lVjIXJ6hKcs6gUSQv/hNCasFy5XDO1Yt2FXVxDQzgU4dpnBegBtVdkxVBu
         rJTKS0Z/EsOSUviY5HxRO9oQsmE8NGdu0AvcIMW/9Wx1jlMAWC1oEWOnalEeiSrrosEB
         HrOb4IyekEpsRACa2ZtuE7gtZnI1+vyD3eCAgywHdsqSPxCwfDUkkgKJncdgChT1EjL2
         j6kI7ecwEG7rbarNv8Sq2PEiZExhRss6Ts2YgYNG83Ri0OkzZH7c1TuLMAecC096LB/0
         Q4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNoufLOeU2au3B1+RnRvzkw/qNNhUMpZeGuuYeJjeEo=;
        b=UHI93Ievb43HyGd1Bk0Tq1yWuZCw1ICDuGZRGa1Gny4Tm5Hk8Wr3P8+58nEv+yxA53
         ScQJzpRPiQgU67uuDiZXK2Br/QCmWaseTz8/1AtaCSldeMXjTxMJ/q6FHt8cK17MgD8M
         LqCG9THgApD06JUsErPqE7tYAeTcUkYevJ075oEnXm0BK0UVWnEl18G8TvUf8UQ5PYDU
         V6a7l+rgh7Q6dy80xKpa9I4smdEIe45ycV1OI53VbOFjXhoDRgK/b2wTCvEx5NSHwzTf
         /sGDGnljBFxNf4td/n5BBi3M9Q2mj5caXqJsqZ8nSlPOP4AWegYxKRYTZ24Ai0Ogmiv2
         jevg==
X-Gm-Message-State: AOAM5305QCWjeksxcxRHhnTi7kM/Kec1CGUezGUZBTMHx9Inn5GNprCF
        h5Oxx0fjbwxszvPBXJrYTagiHvmawJggOxrSA82mZrNh
X-Google-Smtp-Source: ABdhPJwL39UJotHWLs56TcQ8nz9kOe60t/gOb7UsXDaVzUQlZkWuGa0Tduu1SROF0MdjzzsfXQUrspMlMKbgTM+LI/4=
X-Received: by 2002:a9f:3142:: with SMTP id n2mr24500885uab.102.1638557258402;
 Fri, 03 Dec 2021 10:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20211203145902.3223861-1-benjamin@sipsolutions.net>
In-Reply-To: <20211203145902.3223861-1-benjamin@sipsolutions.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 10:47:27 -0800
Message-ID: <CABBYNZ+JmyM=bgQziigjL51-t_WzqoEpV=F00_mqO9xVU0k=UQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Cancel sync commands if a TX failure occurs
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Benjamin,

On Fri, Dec 3, 2021 at 6:59 AM Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> It was reported that userspace could hang for 10s after resuming due to
> btusb hitting the internal timeout when sending the firmware.
>
> In this case, the bluetooth dongle disappeared right after resume due to
> the thinkpad_acpi rfkill being blocked. This causes the USB device to
> disappear, however the bluetooth stack does not handle the
> corresponding ENODEV errors and instead waits for a timeout to happen.
>
> To avoid blocking everything for such a long time, the synchronous
> command has to finish immediately after an ENODEV error occurs. This
> requires further error handling, which this patchset adds by building
> on top of the existing cancellation infrastructure for synchronous
> commands.
>
> Note that this just adds basic error handling in order to quickly abort
> the initialization routine in case the device disappears at that time.
> Additional error handling such as calling hci_reset_dev might be
> sensible in some cases.
>
> Benjamin Berg (4):
>   Bluetooth: Reset more state when cancelling a sync command
>   Bluetooth: Add hci_cmd_sync_cancel to public API
>   Bluetooth: hci_core: Cancel sync command if sending a frame failed
>   Bluetooth: btusb: Cancel sync commands for certain URB errors
>
>  drivers/bluetooth/btusb.c        | 11 +++++++++--
>  include/net/bluetooth/hci_sync.h |  1 +
>  net/bluetooth/hci_core.c         | 14 +++++++++++---
>  net/bluetooth/hci_request.c      | 13 +------------
>  net/bluetooth/hci_request.h      |  1 -
>  net/bluetooth/hci_sync.c         | 17 +++++++++++++++++
>  6 files changed, 39 insertions(+), 18 deletions(-)
>
> --
> 2.33.1

Applied, thanks.

-- 
Luiz Augusto von Dentz

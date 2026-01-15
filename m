Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641E2F3608
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488068; cv=none; b=bnTTgbbT7xSsyUc1uZlRxlkUyNH2Zc4iFOR2EDMRKajZ2YMyfZAeuBfUM1y72JMf468qY55yQ4Ppik9u2yjW9Vdq6yrxgSW8rkPFZ2uciuNZg6PFbdi508LnPZW1GOxVgWR1PK34Gc5jRpoW3rw0cHXPJIhAgacGNgQ4JEV2s5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488068; c=relaxed/simple;
	bh=zWTG277arfAUxvB7YkknHzmpFe+V7uUvYBdi2X5MiY8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CemK7aImBqe8V747E4/DfPTXh+lpyz0XyQJ21lnQ8YXfbii95bNp641V8EJzXluDYiCtuKtSUq1cKrxESu0t0pqtJ7C37vwa2G5clTujrESJEUfxl3OIFmB9LxwRcKbFVz6iAwoyMLqRxBjL2ELMGd+yhiY4R38/nO2tyJvMESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I5mN0ye3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I5mN0ye3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768488063;
	bh=zWTG277arfAUxvB7YkknHzmpFe+V7uUvYBdi2X5MiY8=;
	h=From:To:Subject:Date:From;
	b=I5mN0ye3hrTgr/WaywcxJNL7GizKLyFXawaGLm62z6b8Qm03uz2MR/Qhc3jnsaU9j
	 4AMg0K1/Py63zpGRURIItX70ROeCnGJ0tpyGfh+cxLzEmZQWIkAXB24mzcLHNlZX3z
	 HnoKVB+D5l1UOnQ2qsyIJ34zKvkJ81gjFnd24ytjci11AYQXPaSFtXsOcCipUNbtHg
	 9FH5nj85PpYGVb/4K+PDi7+CGv25CwbrJZlrICSR8r83VmTdLQinZtXwV6hQpk3pGI
	 CouRVcTOAmeE21RB3pvtdw6CZhgY9NBVM2xxZtovwKTDE0maXIveJ4q92mf4UfxxA8
	 1eFYukjUqV9zA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-6f33-5c0f-0153-9768.rev.sfr.net [IPv6:2a02:8428:af44:1001:6f33:5c0f:153:9768])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C093917E0CB0
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:41:03 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools/btpclient: Fix name advertising
Date: Thu, 15 Jan 2026 15:40:58 +0100
Message-ID: <20260115144058.12960-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This allows to pass GAP/BROB/BCST/BV-03-C and GAP/BROB/OBSV/BV-06-C
tests with auto-pts.

Those tests request privacy to be on to share IRK.
---
 tools/btpclient.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index e722b2242..5c01e345d 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -33,6 +33,7 @@
 #define AD_TYPE_FLAGS				0x01
 #define AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST	0x02
 #define AD_TYPE_SHORT_NAME			0x08
+#define AD_TYPE_COMPLETE_NAME			0x09
 #define AD_TYPE_TX_POWER			0x0a
 #define AD_TYPE_SOLICIT_UUID16_SERVICE_LIST	0x14
 #define AD_TYPE_SERVICE_DATA_UUID16		0x16
@@ -1066,6 +1067,7 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 			break;
 		}
 		case AD_TYPE_SHORT_NAME:
+		case AD_TYPE_COMPLETE_NAME:
 			ad.local_name = malloc(ad_len + 1);
 			memcpy(ad.local_name, ad_data, ad_len);
 			ad.local_name[ad_len] = '\0';
-- 
2.43.0


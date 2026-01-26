Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2043BB4A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439484; cv=none; b=bUVtEPvEx3pqdcHV6ndZeLN+B6HxTxRRbX+Vwixi0lzeVyW0fXDyZaOEC8+rovFaN798D2kC8fIzxPTMOqFaWOiKp2y7joxA3hF2ZhNhfnbwrYiWZ9BcKaAkE9BYKuj7YqSdWBMHK9O0vagZn9CFLmGYlG6pLrtDQ/sEnt0KI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439484; c=relaxed/simple;
	bh=2ATOF6r0WYFvcrSYsplouB6kZNzMhAE6WBHQidSDXHM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lXoWrMDerxiv2NOUx9wFipaiKSnN4GXZthhYCrquJmE7K5cX5B9LeE+a7B+vhyJkg0a/EEsOr1yOG2eAATQQfp5R2GzfkU+ON1EhhesqYhBAmujFYPZiK4Aog7aziQ+NfefIeGtMyRqqlR6OHa9Ljcjj56QNAMIL2zOtV3yhuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUoV3ibt; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUoV3ibt"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64959e30705so3247406d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 06:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769439482; x=1770044282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ywjd6ZqYPhV3rqbAia2e9S56xrx5SuisyB+F5jiG4jc=;
        b=cUoV3ibtGNiG9Gx7oynDTKQ4Mc1dgz/DYO3nDKu/Jd5RT1/aZXC9es+905bHMRPB02
         M+qNnnC5T3S2GKTOuUBPT6nAlXHGQNN5ufIM4liOLxVp0rfD4G87ddlZi47N67MfmV/+
         xJK5qFuemXTApttYPtreae7zmegg9yomzj60L+e8lZm93Hi0LzEWVVPim6sIsTOkeWkb
         ICOIx1gYqVR/aWhLGDAO9CrARD/rF7M0ZZZqyM0c1KGtnGcKbH1oBzHhnw9PXMSefhQb
         5iQ7xxMH2L0OVmJF/14mUyTjtYSQHq/U4NipHilVOX0Y8J1i0LZOnf9s5OcZ9vnW1JN+
         Yh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769439482; x=1770044282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ywjd6ZqYPhV3rqbAia2e9S56xrx5SuisyB+F5jiG4jc=;
        b=L0JlkJj2HaYcSzKY156xyaGMD0D2E3Sur99uSEyuEB/VrmmEnqcghcE8sn5vPiZ9au
         ycxSjjg5RnHP2UoRYPXBJxN9MKZd90v9b6PH+1HD3mqaXksxJ76GyimbkNx5n7jku8dN
         8K5bzh5xSRbs9oH4sHwgqWqr0P/THIsdbJpOhGoVWVFGkX0Ts4/W5yeTGqu7euvzlxWN
         SFdgoL1hoEmZwxBruEwC5YFlXFc5ed0ks0695DNNOYq2p1RfgcsB1b59JR/fOWBJGelA
         jrevriLeHlm2I0boT2/TsGjzAp69/drE10eUGIEPvo9ycKHXrSsSCreZ2c0wemvxeqRV
         QUZQ==
X-Gm-Message-State: AOJu0Yz+c+dRBbP9gn/DHx1J3bvrgoIOB0RrgQoHrkH2tbGlfAneq60x
	06PWadnPS8TPYbQEMg5/A9yT7ni9Ps3XvzdLSXT1n2ERL9tUT8JNIrTgUXdlXxfE
X-Gm-Gg: AZuq6aLKiHl1UF3ew97kvobiB+r9OPB5avQIdDydvLmJs723aijt6u0de8i7RPstMal
	IOktj3M/plV+PbBeycCuZa0AnptN+X+JX06F1mYLUln+LmEV1ilIw60ThK5U13nWAvZV+Ld8VKH
	XGHVE6ZUr59XOQBjIniuJ2tC2np7Hq/ipej36sHAq5Cypv7yrdp5tN/5VG7l2WgVsweoyQ7w8Xq
	sVUFYqIqc9t7M1bfEnPl/ZBgvFwu83trAJi83nk3sQntbI2Ktnneqx0TP0kNVT77qzUkvwlUbl3
	tLZ86QX0D42TzUifMfSjW34S4/oHpunT0ol7UgCQJY58FXlp8dMvsyFbPbpSh691MRGNruLOcIb
	zZycaDMVsAnQ6Y7p73Erew8QKzBrdIhdu/9FWFCtj30KOzR0+wn3DGDn2wcGYuxmG6TavU7rNm3
	cyFUNELmot1EVde34uMCKzpgpKq++vf1VpsYAQC8iwXpWLI+joISqCcH3/vjWJkJNjTNrJAadvy
	pSJeA==
X-Received: by 2002:a05:690c:6010:b0:786:4f8a:39b5 with SMTP id 00721157ae682-7945aa1054dmr82718877b3.59.1769439482080;
        Mon, 26 Jan 2026 06:58:02 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7946369b253sm12498417b3.2.2026.01.26.06.58.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 06:58:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/tmap: Fix TMAP/SR/SGGIT/CHA/BV-01-C on big endian
Date: Mon, 26 Jan 2026 09:57:52 -0500
Message-ID: <20260126145752.3528305-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fix the following error cause by not converting the role value to
little endian:

TMAP/SR/SGGIT/CHA/BV-01-C [Characteristic GGIT - TMAP Role] - run
**
ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)
Bail out! ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)
---
 src/shared/tmap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/shared/tmap.c b/src/shared/tmap.c
index 27e08d74a0d4..685c15fba2df 100644
--- a/src/shared/tmap.c
+++ b/src/shared/tmap.c
@@ -239,13 +239,12 @@ static void tmas_role_read(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct bt_tmas_db *db = user_data;
-	struct iovec iov = {
-		.iov_base = &db->role_value,
-		.iov_len = sizeof(db->role_value)
-	};
+	uint16_t role;
 
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
+	role = cpu_to_le16(db->role_value);
+
+	gatt_db_attribute_read_result(attrib, id, 0, (void *)&role,
+					sizeof(role));
 }
 
 static bool match_db(const void *data, const void *match_data)
-- 
2.52.0


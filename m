Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA281E25F8
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752908801; cv=none; b=gfOb/aN28XzF8fKlvOoSznv5oGSGsIcJZWO3jgmrbD3tNVYHlerkLHx2V1RJyG0kyNpQpYXkHeK6oK1a3InIvlYOkxZ8jy4VWSI4TYKkFvH7TMfnWcW8Wcw8TzD4eAZQZ/4zDlNl1YhE6ywIil9X+yZtuLeekqBF3EV1q9BNUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752908801; c=relaxed/simple;
	bh=rsUXqZG9Idbqegl8icQnUoliEJBdQxw0O54nhacCVDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HE3kiNOKl+dU5A2UmwAmhNJHTchmsCgXTtKkCoPpb3AHrrv42M8JwKMxB9dRPAOqEJmzuZtVNzf2x1lSmgxO+/1xlIYYVuMVnpFx1lr41Ak59Lppf24LZi0KKsA02o0YYbFu6uAWhZwi073NQ3MdCGaKLjA7ZWO5/kO6EWVFaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=V7hgnZdG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="V7hgnZdG"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1D2F126004;
	Sat, 19 Jul 2025 09:06:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFPnUjK60eTN; Sat, 19 Jul 2025 09:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752908795; bh=rsUXqZG9Idbqegl8icQnUoliEJBdQxw0O54nhacCVDE=;
	h=From:To:Cc:Subject:Date;
	b=V7hgnZdG0RDnGEk2tsCQEDQRj2A4mvBTDPAV5wU+VwnoJ6T7n451qhNcb5Zz0btgh
	 tQuCgaE9ZG/0YVRePMRM2l77rTm1um1ZPpjvM2vBt9W/mwX+Tzcau4C5GGiv9F2yrl
	 CpWEVbKdOK3kAyzuqT77wBBjswfQ4+ySIeHPMWTduxW+fLKNbFbwhjzIoB4+2CMdQU
	 MQsb4Z0DEWrrqlzC3m+T84foqkVblcnhN8UpPHfpONwO/UzqDLQaB3+BHU1vdzuCJs
	 1rhP94G/oBGIRgmCCJ2zTkLMxK6WvLJpKBzQfZ1+QeFf1HIOce4eLURi80eNhRzM6D
	 A5joz6WEmbxOQ==
From: Yao Zi <ziyao@disroot.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH BlueZ] client/mgmt: Print UUID and flags when showing experimental features
Date: Sat, 19 Jul 2025 07:05:47 +0000
Message-ID: <20250719070547.9551-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Command expinfo in mgmt menu queries experimental features from kernel
with MGMT_OP_READ_EXP_FEATURES_INFO. However, currently only the number
of experimental features are shown,

	> expinfo
	Global
	        Number of experimental features: 1
	Primary controller (hci0)
	        Number of experimental features: 4

and lacking of details makes the command less useful. To ease debug,
this patch introduces extra output for the expinfo command, showing UUID
and flags of experimental features as well. A typical output will look
like,

	> expinfo
	Global
	        Number of experimental features: 1
	        6fbaf188-05e0-496a-9885-d6ddfdb4e03e (flags 0x0000)
	Primary controller (hci0)
	        Number of experimental features: 4
	        671b10b5-42c0-4696-9227-eb28d1b049d6 (flags 0x0000)
	        330859bc-7506-492d-9370-9a6f0614037f (flags 0x0000)
	        6fbaf188-05e0-496a-9885-d6ddfdb4e03e (flags 0x0000)
	        2ce463d7-7a03-4d8d-bf05-5f24e8f36e76 (flags 0x0000)

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 client/mgmt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index d07f7d8c0ea3..f1d607283da5 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -1699,7 +1699,10 @@ static void exp_info_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
 	const struct mgmt_rp_read_exp_features_info *rp = param;
-	uint16_t index = PTR_TO_UINT(user_data);
+	uint16_t index = PTR_TO_UINT(user_data), i;
+	uint128_t uuid_be;
+	char uuidstr[40];
+	bt_uuid_t uuid;
 
 	if (status != 0) {
 		error("Reading hci%u exp features failed with status 0x%02x (%s)",
@@ -1720,6 +1723,14 @@ static void exp_info_rsp(uint8_t status, uint16_t len, const void *param,
 	print("\tNumber of experimental features: %u",
 					le16_to_cpu(rp->feature_count));
 
+	uuid.type = BT_UUID128;
+	for (i = 0; i < le16_to_cpu(rp->feature_count); i++) {
+		memcpy(&uuid_be, &rp->features[i].uuid, sizeof(uint128_t));
+		ntoh128(&uuid_be, &uuid.value.u128);
+		bt_uuid_to_string(&uuid, uuidstr, sizeof(uuidstr));
+
+		print("\t%s (flags 0x%04x)", uuidstr, rp->features[i].flags);
+	}
 done:
 	pending_index--;
 
-- 
2.50.1


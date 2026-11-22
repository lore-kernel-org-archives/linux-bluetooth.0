Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378187;
	b=scv6eHSAN7k2HREucdRaceFJZK/oB4jf83/xOtPo1DXwOGeejNmHdoCYGsrx+kB3iH3c
	 jnIUpI6JwHo5cbVSqXomwtZjW91gVfbBL/wwQv70BHr7hnT05RkdnT2YAXAdx5UFsGOrB
	 YPoowe9LkZIEdU++lriH5QgKQNn8bFZlVfu3/41ZU3uU/bMCCBiFJGO+MjR/5/FZNOSnE
	 H6pBJxVGSHKdqSzSzadA1+0I38kM4Cg4lc+ATYwWO3X0FQ6wL5hlZFWAlsDETAFsh0ota
	 OTOBQ14wBmAlq+RIrbo3RHm8E+b8bBqa4Nm1nhTeiNj9kh+NC0Z7/QYudp/lMYtJa3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kIuz2G1Zk4FJ0SXiIibnX+OXjBUyugiM5jI+dF0i6oQ=;
	b=tzrklCydfZcNlSju9SwsuVY/LkM8mO0g+fCs0+rdp6fsSUDVXmgwsPwqo2wnnnTeJn0P
	 WGlT7bGK8VZ+hBiuIxATSDICD2ExXcBfRktpSn0YV+tY0Nyi2wAW14B4+omOKntIsDKF/
	 uJnh4+2I1xnyBZ5xIzNp+BokJYjbkWJxQ3eCtmtpOq91sL/DSXV9eeVaB9lfrH3GSfoEr
	 jwP5gCXbKwxJQv/T64YRcH8BqjE5WpP/MPLr9zwBNht1FAAbsVzdb1DrYLDLcMfAnOawa
	 WLNmE+Recc+ymqGGUop9dpwLNiq/o/DZBrIADQ7yBwnvYn2enj9sZre2zUYhIn/gXvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=csompp36;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0732606A332
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0732606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=csompp36
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so1584520f8f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378185; x=1795982985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kIuz2G1Zk4FJ0SXiIibnX+OXjBUyugiM5jI+dF0i6oQ=;
        b=csompp36IOp0kqx/M7MEjoap9SlivvHwknbOgABRvaXqEBX9+UE17geeEx7JJh5tq5
         Kag60OO50q8/21H8qgFCgxtVa/6pkgDNEcc38lU9UojjQ06noyau8kP+dwy+2QCQ7qn0
         +QEpI0GBjLlHNLNkx2jSfvSGAuGuLP/RvSKgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378185; x=1795982985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIuz2G1Zk4FJ0SXiIibnX+OXjBUyugiM5jI+dF0i6oQ=;
        b=psmhwJOEz7tpiZ8hJc5H6YzEge83hPrJWmaxKDsVyhbXKXAqszYZrw4673ZBwqFMQs
         Gfq/nKzLljhNw1QkirmXzIguAyZmK4arh3mzIhqcbdChIgmvQ4pnkr8NxJ0102qa6OBD
         gXgKCmlqEgXQH7YbiMxCYN3dMzxRnegwyBdQ6yyKfGCVBVbpMypc04827Llblacej+FP
         4ebSUwmRtDtn4znebbh5OP1/PjJIecqU51RNDxbYxxO3DV86aLL4gMsSbg75Z35AzLqR
         +Tse5fsq6/bw7i6ISYBebWX7pqf+QepGC34MNJyuGPirKWdWm17uEG1AemoLh4OMiTh5
         IM1g==
X-Gm-Message-State: APuU4Z/SYsk0enYcNwhbDiAXTGabvdy2a5+zJRcjC8WundjjNUvGIEDm
	46Xb+JGg8pOTzjeChGVwkvy0Nw5oRhr71j8pKuT/Nt3PmIa+AtyyZJdAusXbg6GCH4IDtUwPkv0
	EMmpP
X-Gm-Gg: AZFdTZen+YyYP6H6ps3UIY4lw+XhAIEmJEtzTjOPxcWwVitRzrxtoNOsac81+wFgLWp
	6AbXMT36BVFgnPJrQs/5+azY0HipN3dO+h+uOixVGXQdTf7yoRlq5Y5IuAFZoJpWxE9q20YJPvt
	UVb8u31/8/h6QrRHzfhbM8MveG2iI373417lNnUVdGIRw2BCQj0JbKsRt4naZqnRqlbTMIhouuH
	ISSl39fhq/y7M8yJtoidFnc1pZd9OLzHST0QjhKG9jzNN4lUiTgJeaMC5I3TPL8FXRK9GXOXhSm
	eJ79z1mWhTkPnnJR/G+jHJBNq4PvtNlEk/gecC60JB/7bTIUBubGQlV5DH8jzq03o8oMrksgSzJ
	nOJCXfaK70+PR+5YTD4AC0LuaIcKtRTZ0hZhw6PRwrVLxcUrba3Bm5KFYC/f8Gh1JlVjI8X9DMZ
	nSsD+lIenMC4RZ9Hm8Z5Y25M1IlwzETaqjAJTHrn20L45QSexL4Jo9RUPjBO3AWgUho5yitkkBa
	XnILACk1wmEys6N09pFJxzkXDqfavjGX8BNyzu0jnK/HI+xScTuXqEA32Gf31NAxhg1FuzOE/B8
	WoNWSGA41dHIIJnVA1FpNrw4BVl2O4jLS8I1E1sRW87MfZ3ftQ==
X-Received: by 2002:a5d:64c9:0:b0:488:88ec:59c3 with SMTP id ffacd0b85a97d-4abb0f3c071mr19691524f8f.14.1795378185289;
        Sun, 22 Nov 2026 12:09:45 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b3415763f7sm1293533f8f.9.2026.11.22.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:09:45 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Don't announce a broadcast from an NRPA
Date: Sun, 22 Nov 2026 21:09:35 +0100
Message-ID: <20261122200935.2778839-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A source registered over MGMT becomes periodic only when its PA starts, so
until then it advertises from a non-resolvable private address without a
PA, and from another address once the PA starts. Scanners list it twice,
and an assistant that picks the first entry can never sync:

    broadcast [1] 7C:A3:38:7A:00:38  Broadcast ID EAE7E6
    broadcast [2] 50:1E:2D:9E:E7:92  Broadcast ID EAE7E6

Treat a set with a Broadcast Audio Announcement as a broadcast set too, and
set it up again once its data is known.

Fixes: 03ddb4ac2514 ("Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_sync.c | 12 ++++++++++--
 net/bluetooth/mgmt.c     | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 638589f77081..c7533cc94ec1 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1483,7 +1483,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
 	struct hci_rp_le_set_ext_adv_params rp;
-	bool connectable, require_privacy;
+	bool connectable, periodic, require_privacy;
 	u32 flags;
 	bdaddr_t random_addr;
 	u8 own_addr_type;
@@ -1518,6 +1518,14 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 
 	flags = hci_adv_instance_flags(hdev, instance);
 
+	/* A set with a Broadcast Audio Announcement is a broadcast source even
+	 * before its PA starts.
+	 */
+	periodic = adv && (adv->periodic ||
+			   eir_get_service_data(adv->adv_data,
+						adv->adv_data_len, 0x1852,
+						NULL));
+
 	/* If the "connectable" instance flag was not set, then choose between
 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
 	 */
@@ -1534,7 +1542,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	 * advertising is used and it is not periodic.
 	 * In that case it is fine to use a non-resolvable private address.
 	 */
-	require_privacy = !connectable && !(adv && adv->periodic);
+	require_privacy = !connectable && !periodic;
 
 	err = hci_get_random_address(hdev, require_privacy,
 				     adv_use_rpa(hdev, flags), adv,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f5f32860782d..edfbdf2942f7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9646,6 +9646,20 @@ static int add_ext_adv_data_sync(struct hci_dev *hdev, void *data)
 	int err;
 
 	if (ext_adv_capable(hdev)) {
+		struct adv_info *adv;
+		bool bcast;
+
+		/* The parameters were set before the data was known */
+		hci_dev_lock(hdev);
+		adv = hci_find_adv_instance(hdev, cp->instance);
+		bcast = adv && !adv->periodic &&
+			eir_get_service_data(adv->adv_data, adv->adv_data_len,
+					     0x1852, NULL);
+		hci_dev_unlock(hdev);
+
+		if (bcast)
+			return hci_start_ext_adv_sync(hdev, cp->instance);
+
 		err = hci_update_adv_data_sync(hdev, cp->instance);
 		if (err)
 			return err;

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0


Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628B12C484
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866927; cv=none; b=EKXPHI/zQU4bHbcyW/uwUy4U77sVUfd+FM/l+oRN9qPOkUY1RY4JM2O4aBWmf5Ddfp1Egl+pCbvhvHhDEE4NekCgTcIvX1WaJRKtKDjVw0R1TWqCurhseCno5x0RkR7uUNRtj7VeYqPFinlECQpqQ9I/yKawqqSkey1pwHVEU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866927; c=relaxed/simple;
	bh=yUneGDyBLidQe02OZmR7Mstv0imyNiw+9ggZirz2eHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFh9K9PNvrj741lzUytNZkz+bz67+Km4SZT5D1h/v2nG7JfyExpvxv+ucgZizXs+kOnjEMG3vZYdk5J1qhmF/7SJAUwgwzgwvuWXk+5Yaha6jLp4Fp5RQrOZWZZ3zvLcYvKB1c7sO6BB6JcoiH1K/cXCMvKtdaGR8RBZRgQ/SyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 390362000D;
	Mon,  5 Aug 2024 14:08:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 6/8] shared/gatt-db: Fix possible buffer overrun
Date: Mon,  5 Aug 2024 16:06:44 +0200
Message-ID: <20240805140840.1606239-7-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805140840.1606239-1-hadess@hadess.net>
References: <20240805140840.1606239-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

uuid_to_le() returns one of the possible values from bt_uuid_len().
bt_uuid_len() returns "type / 8".
type is a value between 0 and 128, but could be something else
depending on the validity of the UUID that's parsed. So an invalid
value of type between 128 and 256 would trigger an overrun.

Add a check to make sure that an invalid type isn't used to calculate
the length.

Error: OVERRUN (CWE-119): [#def6] [important]
bluez-5.77/src/shared/gatt-db.c:612:2: assignment: Assigning: "len" = "uuid_to_le(uuid, value)". The value of "len" is now between 0 and 31 (inclusive).
bluez-5.77/src/shared/gatt-db.c:614:2: overrun-buffer-arg: Overrunning array "value" of 16 bytes by passing it to a function which accesses it at byte offset 30 using argument "len" (which evaluates to 31).
612|	len = uuid_to_le(uuid, value);
613|
614|->	service->attributes[0] = new_attribute(service, handle, type, value,
615|									len);
616|	if (!service->attributes[0]) {
---
 src/shared/gatt-db.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b35763410d17..cd0eba6bf1d0 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -560,9 +560,14 @@ static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
 		return bt_uuid_len(uuid);
 	}
 
-	bt_uuid_to_uuid128(uuid, &uuid128);
-	bswap_128(&uuid128.value.u128, dst);
-	return bt_uuid_len(&uuid128);
+	if (uuid->type == BT_UUID32 ||
+	    uuid->type == BT_UUID128) {
+		bt_uuid_to_uuid128(uuid, &uuid128);
+		bswap_128(&uuid128.value.u128, dst);
+		return bt_uuid_len(&uuid128);
+	}
+
+	return 0;
 }
 
 static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
-- 
2.45.2


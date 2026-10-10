Received: from mailsh.amlogic.com (unknown [114.94.151.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D038CFE1
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.94.151.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615662; cv=none; b=C9jZdCinFx/9ZscMAQSYDCrBh6Xypyj3QJjhOabTMzgxaQ8C2OUdhpnRrkluHKULdBh7MOFBK1PkN+NnRKz63mNHqSKWHrOd9UQprFplnJxfKlbrgWfZQ4efCnVhcLtv3W7hYD7L+ESwav90WuWOzAZeklL5G4JGmsiz5cfb5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615662; c=relaxed/simple;
	bh=EqvukbHlWygKa6z6kuJYyoSwvz0zytHEjCDdVCL0Tus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=i3k6JhpCUx/CJhTDh5YFVBqQEjL2NL5D3jgGofKsLkt83Q1gRuoS4+BnOAIy2yy+z84EjvAh3UK6UnmQIR5b7g70YWyXt/pr9p6hKc8FV2n5o05jFlV2494WBMfjgKXUwwNT0Ypl0hZ36ihQ4LJPOrvnXL4CFC8kHcOe/YWnVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=114.94.151.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from [127.0.1.1] (10.98.11.201) by mailsh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Sat, 10 Oct
 2026 14:55:50 +0800
From: Ye He <ye.he@amlogic.com>
Date: Sat, 10 Oct 2026 14:55:49 +0800
Subject: [PATCH bluez] device: fix loss BREDR info when merge duplicate
 device
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261010-device-merge-v1-1-65e5e1a79d91@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAHThyWoC/x2MSwqAMAwFryJZW6gVv1cRF2pSDfijRRFL725wO
 bx5E8CTY/LQJgEc3ez52AWyNIFpGfaZFKMwGG1KXehCoUgTqY2cbIi1ycfGVogNyOV0ZPn5cx2
 M60Uv9DF+L5bgjmUAAAA=
X-Change-ID: 20260505-device-merge-dd823b9f7dd9
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
CC: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791615350; l=1529;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=EqvukbHlWygKa6z6kuJYyoSwvz0zytHEjCDdVCL0Tus=;
 b=SM5STpHIk7Xu9yHeKjGjDM2+nYYTnnhwMhJPpYJjWHo8EceUTWtB0tBeIEcHzWs9zpq/vjP6Y
 62IpGXHKpJiAN8rFnAKcd9ZdJ6Sfz3YQHncNeRkSnLKvPI+zdLaohHZ
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=

Two device objects for the same device in case it has
first been discovered over BREDR and has a private
address when discovered over LE for the next time.
The merge logic doesn't create a new BREDR bearer.
Makes the application loss connection info of BREDR.

Signed-off-by: Ye He <ye.he@amlogic.com>
---
 src/device.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8fdef14489540e64b95e7e75d153d532811af611..9b36d01d4cb8fa6f866409901bcbd9ae2d86a886 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5456,9 +5456,22 @@ void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup)
 {
 	GSList *l;
 
-	DBG("");
+	DBG("dev path '%s', dup dev path '%s'", dev->path, dup->path);
+
+	/* copy state */
+	dev->bredr_state = dup->bredr_state;
+	dev->bredr = btd_bearer_new(dev, BDADDR_BREDR);
+	DBG("connected %d, paired %d, bonded %d",
+			dev->bredr_state.connected, dev->bredr_state.paired,
+			dev->bredr_state.bonded);
 
-	dev->bredr = dup->bredr;
+	/* emit bearer properties */
+	if (dev->bredr_state.connected)
+		btd_bearer_connected(dev->bredr, 0);
+	if (dev->bredr_state.paired)
+		btd_bearer_paired(dev->bredr);
+	if (dev->bredr_state.bonded)
+		btd_bearer_bonded(dev->bredr);
 
 	dev->trusted = dup->trusted;
 	dev->blocked = dup->blocked;

---
base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f
change-id: 20260505-device-merge-dd823b9f7dd9

Best regards,
-- 
Ye He <ye.he@amlogic.com>


Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170A390237
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078772; cv=none; b=Qv/hno4cwwA8yWqLB6p7uyL7nezQIqbjCXqCEpN5QS+YS6wapPZ94UEQ/zr+Ls33ADcdn9H4lNndHWxtwYvH7LDY82xRqPyokJFKNO6q/L+PfWvKhENIQ8VRIBHqRaTT+Xr08z4Qdj/FoBX0Vrg3mtec1pdvWM+hZJcqhSWJUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078772; c=relaxed/simple;
	bh=6CQlYxsyUYG/AF/LFjziHNwIegEvGxfeO0FtkgHozlw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BdDeCUBgV1c/Bcy2mC5ocXDieh4xBEnfSIKGNmWbLxZCZ9713/ukyHOgKeNRkZDiYqM3ebZFqIKz707/oVlowhIO8uOMcZH3pXm1h6dIv6ZlIwE2uEDGXhT+asIl1D42L4hh5Q8f2wyuCTMSEknu5z1/gFuoE9SwW+WLSuElq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkdaP8tB; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkdaP8tB"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9907fa1d2d1so95459241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792078759; x=1792683559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbR2xSwS3BjeTliFduWGNpJ79P8nkd9N8StTjmegP9M=;
        b=WkdaP8tBaKlJsIrFJupoUyAYNz18STauhq7z4/s0WWxX4IvYWXdSn3KyKRQv++Io5N
         G9P+7BnuFJn+oXaRpm56LPSyEDTsKJDtVU2nQI16e23W7PnG0rM0Z0Wnt5jWD4JHxg4e
         wNpzywdPYjNIjatVtETewo5tmsSCtRgAuIhslu9/DYGp5BaA0g14LjptLk8oG3o6YjzU
         3rKsbRuiqcQRM2AZxowE+LyKyE75lnsUV9ZtCS+irSNk5BZTC+NhNiVepZ+MlBh0sB/R
         GSPC/sx4FYPbAT1kMzkZJtNGCYhjgiaze5d8VJWDAD79FuO7pZ07GI97gZtnI16VYSY8
         u35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078759; x=1792683559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AbR2xSwS3BjeTliFduWGNpJ79P8nkd9N8StTjmegP9M=;
        b=AB66eY6BZH6I9thB6D3zGr7B6KHh0MiVfm/D30ZNVyV5hZcf2GawHb+B3Fiqu0YSXg
         an0DJsWqusTeN4CAXQnInZKfK3gxSub2vEVciOyhCMP6n5e/8qQTe+rnjHSEnJ1GXorp
         TqViFwC22/oQ2USpw+e4CgIcvX20k9weCIwFVaLsV0iozMPeGVf82pqMj2KSFHx65FeN
         IiRoRWyk/B2qAzU+c/gJdKOG2Dwv6TZhwLIfW/FbKOVXxXPXqvSplSgFD9+OX+cvaApN
         em4ZpqgKI6LlZzVrVN46Nsonq6ivzOI1KOWlJv81ic9MnGZ57nvPNHuYO4reMgDP7+g1
         uNBA==
X-Gm-Message-State: AFq9FYK6ictot8TXATBzEp5bCYoX+jE8A2vbj5zibF7KxqignlH5JqDo
	1ClBI+JPzRRDxdNmpYMQ5+RJNPuml5heZozLJhX1K8yRxZ57Jsxc4TYotrJkkCiWqOY=
X-Gm-Gg: AYBFou2z9DMNqLyUCuahLcWOVQp/Zkrk2h+sXwmcn7ndSfCZMSYkm1xlETSPEgvRR6u
	JDb+J51LCUynCYOqkevQS6OdtyDvo7EMBCz7ahsMIluuIiRQLJXBmLyEqVUOgRp6I8YUXL6abGJ
	mZyLAx00Uq8845HppVDkq4rsdtmIutR2uoYJw2inGYmXYQAicYcz9QmEtKShRYLbDP47Jdg0YDp
	srgShMeyQwamLOiDglG8y2rWz9uRuAyIWG7PaPZhc5zwZAlTaOuTttfOOm6w+EFYVZVyGgM2OU1
	X51+pbUDV5LDTCrkAQKRiH41oFC8syBULV0pMc/mozF4I5m5BWB3wH0oGRadv8mRHPrrjO9qS9M
	2v8SmAp1lTF5sOKUsXsUa3kYY/jLOy1tdlaixSse6wm+qYonNkJ82NX86Xe1MOWxHtmZhh0ngRJ
	680nlI/cqoXJAGOEPlRjCglNYqBxJiWkMWf8O4v+sGSFW8q4QWW05yBNsTbbq8EsqYnNPg6sPnw
	SvQ0W+3ablS1UO+8b/wIE+0RTB/oQjyuBoAlUHFwL24pp6cRjxTgVM8lkdyJv/2VGHCYD02fHEL
X-Received: by 2002:a05:6102:5122:b0:7b2:7490:fd75 with SMTP id ada2fe7eead31-7cb3728257dmr5056291137.7.1792078758683;
        Thu, 15 Oct 2026 08:39:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f242a9sm12662820241.7.2026.10.15.08.39.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:39:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
Date: Thu, 15 Oct 2026 11:39:09 -0400
Message-ID: <20261015153909.1870855-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The LE Set Default Rate Parameters command is rejected with Invalid HCI
Command Parameters (0x12) because the Supervision_Timeout of 120 ms is
exactly the minimum recommended by HOGP v1.2:

  Greater than or equal to (1 + Peripheral Latency) x Subrate max x
  Connection Interval max x 2

But the Core spec treats the equality as invalid:

BLUETOOTH CORE SPECIFICATION Version 6.3 | Vol 4, Part E
7.8.158. LE Set Default Rate Parameters command

  If Connection_Interval_Max x Subrate_Max x (Max_Latency + 1) is
  greater than or equal to Supervision_Timeout x 40, the Controller
  shall return the error code Invalid HCI Command Parameters (0x12).

With the current values 0x78 x 4 x 1 = 480 >= 0x0c x 40 = 480.

Fix this by using 2 s as the default Supervision_Timeout, which is 10x
lower than the 20 s used for non-SCI connections while still well above
the minimum required, and make sure it remains above the minimum in
case interval_max is raised to match the controller's minimum supported
connection interval.

Fixes: 2f8784cfe8a9 ("Bluetooth: Add support for Shorter Connection Interval (SCI) feature")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 03f706c1f815..7ac26daba966 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4828,6 +4828,9 @@ static int hci_le_set_def_rate_sync(struct hci_dev *hdev)
 	struct hci_cp_le_set_def_rate cp;
 	u16 interval_min = 0x000a;	/* 1.25 ms */
 	u16 interval_max = 0x0078;	/* 15 ms */
+	u16 subrate_max = 0x0004;
+	u16 max_latency = 0x0000;
+	u32 supv_timeout;
 
 	if (!le_sci_capable(hdev))
 		return 0;
@@ -4852,10 +4855,31 @@ static int hci_le_set_def_rate_sync(struct hci_dev *hdev)
 	cp.interval_min = cpu_to_le16(interval_min);
 	cp.interval_max = cpu_to_le16(interval_max);
 	cp.subrate_min = cpu_to_le16(0x0001);
-	cp.subrate_max = cpu_to_le16(0x0004);
-	cp.max_latency = cpu_to_le16(0x0000);
+	cp.subrate_max = cpu_to_le16(subrate_max);
+	cp.max_latency = cpu_to_le16(max_latency);
 	cp.cont_num = cpu_to_le16(0x0001);
-	cp.supv_timeout = cpu_to_le16(0x000c);	/* 120 ms */
+
+	/* HOGP v1.2 recommends a Supervision_Timeout greater than or equal to
+	 * (1 + Max_Latency) x Subrate_Max x Connection_Interval_Max x 2, but
+	 * the Core spec treats the equality as invalid:
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 6.3 | Vol 4, Part E
+	 * 7.8.158. LE Set Default Rate Parameters command
+	 *
+	 * If Connection_Interval_Max x Subrate_Max x (Max_Latency + 1) is
+	 * greater than or equal to Supervision_Timeout x 40, the Controller
+	 * shall return the error code Invalid HCI Command Parameters (0x12).
+	 *
+	 * So default to 2 s, 10x lower than the 20 s used for non-SCI
+	 * connections while still well above the minimum required, but make
+	 * sure it stays strictly above the minimum in case interval_max has
+	 * been raised.
+	 */
+	supv_timeout = (u32)interval_max * subrate_max * (max_latency + 1);
+	supv_timeout = supv_timeout / 40 + 1;
+	supv_timeout = clamp_t(u32, max_t(u32, supv_timeout, 0x00c8),
+			       0x000a, 0x0c80);
+	cp.supv_timeout = cpu_to_le16(supv_timeout);
 
 	/* The connection event length recommended in requests by a Peripheral
 	 * uses units of 125 us with a valid range of 0x0001 to 0x7CFF
-- 
2.56.0


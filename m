Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378456;
	b=IpbedS9En4JjJu4AEa9pFdynfMyscqHx1H2ZRwNK/wjTMxmiKV7vRE2dCMmbyWPjMpC+
	 MpkYZSLe1LV2/kmj+GxNhOSwdDh4DdKhXVzPrwcppuYhtKf3DQmjmTHBGAwS3MagGmt2r
	 VLc9pPdizd3s2YbFexpnwow2mHyn8ULazas2/2g65zEw6OoAq34yyVBfZbfX/LsXXft8p
	 QoTf3bP/4TPaSGH8OO1Z/Y8QQXXo+IGws7G2VoFUZ8bvrxgnJxes6tgotmFj329ePS0FT
	 Pp34iZ5sQvV1xF/ojfGiKr+6Co1V19VpQrONnAjdetZJY5AjFXhKJ/pOlriDptrjh4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=e5npmz5RHSlIwuo6Yz+PQPwD57PmmrakjKdijdvX3GE=;
	b=BMKJtbZNJa2OcUBOYlWB85JCA59UQwi2W574QJtcjewksuVVUYiIFWiNTt1rvYNZ3/+A
	 HIChLjTvPoJHNemkJtl85e2/dpcVMCZdEc3OdCRgTWYv7vLAx715bEzNRJu6T/pOTT8aK
	 9bqhLpLCGM/3Js3nbWlWAroDlrVwbPHdDUe9Ty7U3sZTPIQb9A26YTw746VdJP84ofL3H
	 qZDWp6dPdh0YI/JDq37ZVzvXwElUOUWNTwWELI2TBVdFzIt/4Y/0UqvHWq4QuBtHtsRc6
	 i6O6d/N4XWAQjSKHehQBWYAyIjYWwURlWURji08fdnHdIzb97BCeKHo6sJCMZFE10tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=UTQIYkuS;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153F606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4153F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=UTQIYkuS
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb61185057so16805315e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378454; x=1795983254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5npmz5RHSlIwuo6Yz+PQPwD57PmmrakjKdijdvX3GE=;
        b=UTQIYkuSgOfFu/bLqVZCPZRMhObnaoCGccJhIvncEXMs9eqlBBxdHmvyLrNMkFY16W
         qoCp+1FLDDT5ghkAp4tjhd8Ce1xRmqw6QGR99LGQfeA02BaBem7Ewp05tJq4B4I/MyhF
         w3JMBGLHHd0TXtHp0mM2fYFUvT4pzGZdX6Rqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378454; x=1795983254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5npmz5RHSlIwuo6Yz+PQPwD57PmmrakjKdijdvX3GE=;
        b=jlEBq7M0UoHSgv6TkTzOhuW4hTtP363nJQk4LsmXSFyjWbxgnvNjcvKukWaTmxWZfs
         MZ8Zo/m6BZfzck8kXtYA9JTQOSOOrLb4rHL2rSE+IRj8zz7cdDwB/4fCTuFEfA+Iz2SR
         peNqdw0tyvqNg1i2AjWFd2gtV8CQmlf9i7mU6sun3GMJ5R2vDuu9k+jHVlqh1uXJ1FZQ
         JrnMJQF5HFeiSJPbkhBpmI6VnMg2clJlSSREs6hlgHhdRa7I+oNpWGnCNX0yeBg7wd43
         1veNMwssYqpc1hW12xciScuMM9YE+Ec6Ah4V6UcKf2dBqt84iShPlJOauoKVtIiRC01k
         JC6w==
X-Gm-Message-State: APuU4Z+0FAVa9f8yrkNZvrRPTrr6lKV6sJJmbSEHtgx0sxGyz2gwuQBQ
	PhWFyBjoXwwsQMtV3tLBcPRsxqzM7IAipLG2ZKZ1Z7bpLMpMN2r+e9YofwbKwZBvRicoiNSihjr
	Te5MZ
X-Gm-Gg: AZFdTZfOiaMsmEpPM5vXuLtRritqOIV5lJMCH3Z85r862hTzBGC9AmxmTF14ORP4k5p
	/E1XgnEKmX7vaIpIWuirQZMQA1BDLmXib3aSNrHnLI6WuCByNIuRp7XzTXPayN55xi638Aeusvu
	MMWgnNZFcgailqlaNjWHttVw+rGIV0Tzo1UFHVQmYCWpNrsCVhMv3Xm+hreIPiVDDltcxpRwGjd
	qKZquZsQZlqocXMK92gTEPe3wA6WESJcbJ1q60GRhBSZBeHg7WNHlOxIwYXL2DCMujgeadYu/k+
	J7Tgzrlxc6lBL2CG8v0SujBpYst1hlMLJF4nQHXZN+loeYhTp3cOtraDUrrIJeWlxWhhSoAi/5b
	1jBv7BVZ/04mCLJn5AVQoGBphWzOlhsTpOFKcd2fNcgFa4R2TJb1onq5R6DwhTn2uIiJemXSxel
	2T5lMSs4BB9cJg1PXtWlbEkrYA964Xii76r9pgku6Wq2SfWyt4ur95UYeIgbg1nWTlojiJCXQT0
	TL31Vm/WBS+zSEmnhsLxPgrFHSGGesVk943oYpM03sVECMnVVz+/03H76xngcvFxe//uM4CZx14
	OKl7cn8sJGgA1RWi70CoF4CdoPJI5FFcMBcbV6gR4dChnFGhhg==
X-Received: by 2002:a05:600c:e40b:b0:4bb:9a6c:8712 with SMTP id 5b1f17b1804b1-4bb9a6c8724mr9561175e9.12.1795378454538;
        Sun, 22 Nov 2026 12:14:14 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm136637825e9.1.2026.11.22.12.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:14:14 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH] Bluetooth: hci_sync: Don't make a periodic advertising set connectable
Date: Sun, 22 Nov 2026 21:14:12 +0100
Message-ID: <20261122201412.2856420-1-simon.mikuda@streamunlimited.com>
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

From: Michal Dzik <michal.dzik@streamunlimited.com>

An advertising instance without MGMT_ADV_FLAG_CONNECTABLE follows the
global connectable setting, and so does the instance of a broadcast
source, which create_big_sync() starts with no flag but
MGMT_ADV_FLAG_SEC_2M. Whenever the adapter is connectable, e.g. while it
is discoverable, the set is configured as connectable extended
advertising, and the controller rejects enabling periodic advertising on
it with Command Disallowed ([Vol 4] Part E, Section 7.8.63), so the
broadcast source fails to start:

  Bluetooth: hci0: Opcode 0x2040 failed: -16
  Bluetooth: hci0: Unable to create BIG: -16

Don't let the global connectable setting make an instance with periodic
advertising connectable.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Michal Dzik <michal.dzik@streamunlimited.com>
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 638589f77081..11aeaa9feef5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1519,10 +1519,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	flags = hci_adv_instance_flags(hdev, instance);
 
 	/* If the "connectable" instance flag was not set, then choose between
-	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
+	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting,
+	 * unless the instance carries periodic advertising, which can only be
+	 * enabled on a non-connectable advertising set.
 	 */
 	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
-		      mgmt_get_connectable(hdev);
+		      (mgmt_get_connectable(hdev) && !(adv && adv->periodic));
 
 	if (!is_advertising_allowed(hdev, connectable)) {
 		if (instance)

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0


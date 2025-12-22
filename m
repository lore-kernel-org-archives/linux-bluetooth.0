Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845451A304A
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432118; cv=none; b=Z7RIrM4yGkEOuoJwTOpcLSYJjCINBiktPCO0F6RLTPdpKQqHAfhBMDbgYzudKrcuxP2wEoPj2NRKwLXJLj7vHJWBQETKQOpcSVuHjRZl/v/L0f/1aRMGC92HGx66SKhA/GbknsH9qiIoat9qKrf4vcihq8TUvNjnUAUPGOu21ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432118; c=relaxed/simple;
	bh=DH7IbWXiPQk3vw5ipIYDl+ii31k2MYxupfn+rtXQTdk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kttgiVm+QG7tkNiko5LiCqx+PSYSwDX+SHAsyzQKrOwpXGdM+attU+YEbw+MAulEdDPtoSYbW9jBCxhyDVRv5AdupSQzUADc1Iyl41AzuORXTRXU/fZuMcPeFIXa1nT1aHLIJmH36yb9yUgqXZ5YAlvPp4wRDVoqPxewl9eSkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGUC+1se; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGUC+1se"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56021f809acso875830e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766432115; x=1767036915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIqMSzOpEhLpn3viNsF3s9mdHuBt7nNzVJKwitkrOtU=;
        b=eGUC+1sevqAypz1besXj0tEkrTWDXHQw+n4vEGZXQ9PuyMCj3ZPIJNABhyK/SXEtAW
         kRayyif+4rCZl1EeDk2kmy3go7o81Mz89HWhwqJAXOHZzT3hUqpPPp/emEA8ISkas97N
         cwJ3JsprmB3gllgkAo+I2w5hcWstN4tVA7xUtZDWAxCgmSfdqblYlNazLMmeeTclTwn2
         CrtCHYSf9w3Ko2HzV6hC2MavWMZNhuhC/IYM4J5aQCJA+aqaH08jYGWHiqjOfHiyyS9Q
         k5Hsx7E3ZxNVe+ID1SNeDNIKC9MaDYA9OY+CQlxHlRSYCiSMIOfwXKgb/Nli1lkHNwuL
         r5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766432115; x=1767036915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sIqMSzOpEhLpn3viNsF3s9mdHuBt7nNzVJKwitkrOtU=;
        b=ROtpOJsNbv0jDhjJhUuZpxBt/648udkns40rjrw0krpI4sUe8jcSSulxYDskRMVNTq
         +op63ncHZq4wIV7pAPu7EMoAOT2+YsKJQ6C4iLM3M/D1pSd8QsOlZLeANPo8CIJRFxc4
         IpmdDHth2ZkgxSZjAUr/nZbF9L6o7l7DXzvYotnpizn6BwUguutVYmZj5MbQRvf1EJ7g
         TxfIQVP5nayARAJmXbslxwtQNlc3/0hbFWrfeO5lNhP4w74xqS61yFdCbl61fIKRo0Dw
         PkZ/RItAkcBd6oVPbJnz6mSd2fjIVIBBDDA8Jv0hTjtzSXik15RbCXSKbhqPuFEKI77Q
         BxGg==
X-Gm-Message-State: AOJu0Yy6bV+859j+YZAxunjsdZ8uuGvo2eCIr98yEafQNg0fhIl/4dZF
	yzZjQNhVwHgV+epRL2QRtfYb+ASbhB23RJp1En4rDyGw1CWGd7g6RGlxqyYkOGJIXvk=
X-Gm-Gg: AY/fxX5RQBNsdeTnOs2t9WorL01dOSAl5BSC6YW5komYejsNMHsI/S3bRk9Y2dA7fXV
	i1VnbEHEv953df0xfMGsiymb7VtKCG/YkqPELaPPsdxDMDfgK6d4XhkxysJwwFlncuqXOWdtmy9
	HVFjzkmnGze+hE9LCzyTaWL9B9nYOWKDY22R3TnCxS8N9Udr41rW1kfDDTtgQ5dOYARITdmu/Qx
	lUwvAEGQxc25Pl/lWVea4udTAsgP3npQ4RIV4RB3sSz8ZrvzZc6XVF/dbqMQJ4vLsG6ic9EOnYN
	g/QghfUeQpeqFkS8BRTNSaiK833PP3jWScoXl++yKQERTzXEOM9MPlqMWUKHXsscCyyKgBINZVp
	K2Gp/6RqIVuAeMqzHslaT8jYyvJsYan1rr7Ou6z/G6P3Wwu637+mkS1z0Av/cxwGMbirzZ9Aq1n
	ytSCwEzj5Q4lnWeg==
X-Google-Smtp-Source: AGHT+IH5Vn1iwdCd5w0kxW+xKdszurmqaWlQfPeHGn5enfxef0bmnKn2vD1Fwoxj0fktcihbtnmyLw==
X-Received: by 2002:a05:6122:7c7:b0:55f:c6c9:e4ba with SMTP id 71dfb90a1353d-5615be0dee9mr3248916e0c.13.1766432115185;
        Mon, 22 Dec 2025 11:35:15 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d132efesm3764301e0c.11.2025.12.22.11.35.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 11:35:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] emulator: Fix using BT_HCI_CMD_LE_SET_CIG_PARAMS PHYs as values
Date: Mon, 22 Dec 2025 14:35:03 -0500
Message-ID: <20251222193504.650019-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222193504.650019-1-luiz.dentz@gmail.com>
References: <20251222193504.650019-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_HCI_CMD_LE_SET_CIG_PARAMS PHYs are bitfield so they need to be
converted to values when emitting BT_HCI_EVT_LE_CIS_ESTABLISHED.
---
 emulator/btdev.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f66fe4c78d03..6db723ce8797 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6955,6 +6955,23 @@ static uint32_t le_cis_latecy(uint8_t ft, uint8_t iso_interval,
 	return latency >= interval ? latency : interval;
 }
 
+static uint8_t bits_to_phy(uint8_t bits)
+{
+	uint8_t phy = 0x00;
+
+	/* Convert PHY bits to PHY values on a ascending order. */
+	if (bits & BIT(0))
+		phy = 0x01; /* LE 1M */
+
+	if (bits & BIT(1))
+		phy = 0x02; /* LE 2M */
+
+	if (bits & BIT(2))
+		phy = 0x03; /* LE Coded */
+
+	return phy;
+}
+
 static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 						uint8_t status)
 {
@@ -6977,8 +6994,8 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		memset(evt.cig_sync_delay, 0, sizeof(evt.cig_sync_delay));
 		memset(evt.cis_sync_delay, 0, sizeof(evt.cis_sync_delay));
 
-		evt.c_phy = le_cig->cis[cis_idx].c_phys;
-		evt.p_phy = le_cig->cis[cis_idx].p_phys;
+		evt.c_phy = bits_to_phy(le_cig->cis[cis_idx].c_phys);
+		evt.p_phy = bits_to_phy(le_cig->cis[cis_idx].p_phys);
 		evt.nse = 0x01;
 		evt.c_bn = 0x01;
 		evt.p_bn = 0x01;
-- 
2.52.0


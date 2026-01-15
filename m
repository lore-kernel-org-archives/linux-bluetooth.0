Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE1231AAA2
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510466; cv=none; b=UgqpFwQ64wT+D8n5vMCvE31tHCHwDQgwuI6TTGhSLlDB6Z6AnGQxwuxOsHem7qvu+2TDNk2zPb0fetXTZ+q03c9fS1HRgdEL8A7Q7NbF5dQ0SAtz82Dqz7Fx04vSuv8gZf9XOwWyhqPTEWUpXZ2Qcn8QjAKyMPug7ml/wWOkHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510466; c=relaxed/simple;
	bh=mGTDWk+2HNbND4rSKhYj3ONc4sSF8CdNRxHxiylQRoE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=socStCzZW4KcOe4jAEINuSo7Z6cuGRYq0twDtvx8Ya3AAp/PI3niLzjtlnnt68zghpGt1wuzn+zxbzEjx0ytv+vKFyCtZJk8LFsjStbG2p7bSJ7ghC2H8Ztf8seOW+S9mMy/Z589x9mvTfW1DfAIRkxWhufGLy9+4fKDxmEJcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPu04H3B; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPu04H3B"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5637886c92aso465110e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 12:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768510464; x=1769115264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubu6wecu01rSKgtS5A9JrDV6StzpsrWnvWJhSUcZDxA=;
        b=kPu04H3BscjKqgYuIbZ/BBN8YukugdIGJ5ki6s8nzT1fioxmaAApt5Oy6IjJd3HPJ/
         NwIeg1VyWgtiuzFy3Jw3Mqse3iZrfn5R4MqWj4CrA2VlezrnJks8mHb9oiVckyd9ZmLw
         4oi95wVjfgFED7VPYToteMEYY27b/oL/S75hLwNaRAqSWLA/kVcvKbYJ6CRNr9BNGk/c
         G3PKhf6VZODFYM5/e3K5l6bTaDcCI2lwOSINeAyzrRaeC1Hi6um3PpDec1u4O1TuPeRm
         9CAt0+HZI3JKjC8cu1VtPeiykcKTa1C6bN1AraMElHCpzzUw9IIrD8GyC4rqGxjlUREw
         WZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768510464; x=1769115264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ubu6wecu01rSKgtS5A9JrDV6StzpsrWnvWJhSUcZDxA=;
        b=gqh5F0C7mB317RPNSAb4eGpXrscf9i03gQoUo/7v3d9T3tQpXbOE2ci4PSMsTUicqN
         MQNdsO+8qzzfPmR5fr60dxOsfPObT3LxMgZPaqwEWNwowQzL4KxpZuOLTzcso8ZTHR1R
         G9PwP6ruzq6qbJz0XBl7CYiQvF3WqAMkLZrp57rhZuufNGzghVhYCT7IeibkPWJkgcFD
         RZPoS6CiDuJ92D10kse6I6PUJ1xDmYpfxVQQXTKqBqePim+UtaCaAFBIzcF/os46I/U+
         TWsUf9t5h5ihB49JJvkdPX8KsSSEgHeGOvS8KOo7ZBDeeNMU82io8MmVf9XpAVVVn7fj
         W51Q==
X-Gm-Message-State: AOJu0YxF1xueVfIIoN3Llo64g6OOIixDxSV9kiem9MYbApRS/nLgMTdG
	EksDApuXQx1DoX52SB+w5RDrpnU1nKZYVjBnLug6ag5Plh/OfFZBIrQeJd6qR5Ma
X-Gm-Gg: AY/fxX7TH2Hg9CqHxJVLzSZ40iGqUcVFGvKbGpC11wQQVg7D2L7zs5oqPlhNWrtJA4J
	fVPK2XPrAPKAWGbAISBHsBlEbWnfJW+D7M5HCsJvhHFyV18KNSd7Q1T+iePP/LTHrucsP7MRX4V
	eaT8b+tXTYbsI41bmK0LDv8H3awpi6OyP5llpxCfcXBE2wTsVKgRvz7YwTRjn5Zv8pitL9/kSMY
	85xRYeq+Y40FEYRxh8nFCKQAolO3/KNkDxIumDDii18kl8LDxh+P6Ww8gCw9rtOiBwY1FiMTRsH
	ysU393iDJPszJPwc2Z6PrtJdq+ifAcPoqzg2N1RxBGgqlzPjXcetcQw1Q4hZoppfG9BMBY/YLPl
	ldqSxbB4tHJYyQm3D5WbDRYA/LesJQqzEBXWc71ukdxUULI6zrpz6QIGw4WRYCyVve5hSB5K5oe
	m60Bc4N85GgoR3xbdOmStzrFWrthi0opViNs0RBr4h7glA95pntNyitsU7zXxOjK7iKqC4P5SAb
	G/EaA==
X-Received: by 2002:a05:6122:512:b0:55f:c318:1afa with SMTP id 71dfb90a1353d-563b72dc295mr142044e0c.6.1768510463668;
        Thu, 15 Jan 2026 12:54:23 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6ffda3csm167159e0c.7.2026.01.15.12.54.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 12:54:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/6] advtest: Fix displaying RSI as a byte array rather then an address
Date: Thu, 15 Jan 2026 15:54:07 -0500
Message-ID: <20260115205408.1554101-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115205408.1554101-1-luiz.dentz@gmail.com>
References: <20260115205408.1554101-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

RSI should be displayed as an address if the intention is to use big
endian format.
---
 src/advertising.c | 3 ---
 tools/advtest.c   | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 0543870eea02..8970e65f7d13 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -533,9 +533,6 @@ static bool validate_rsi(const uint8_t *data, uint8_t len)
 	ret = !(memcmp(hash, data, 3));
 	if (!ret) {
 		error("RSI set invalid: hash mismatch");
-		printf("Random: %02x%02x%02x\n", data[3], data[4], data[5]);
-		printf("Hash:   %02x%02x%02x\n", data[0], data[1], data[2]);
-		printf("Match:   %02x%02x%02x\n", hash[0], hash[1], hash[2]);
 		goto done;
 	}
 
diff --git a/tools/advtest.c b/tools/advtest.c
index 706b2503b74c..7e744dca8021 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -53,7 +53,7 @@ static struct bt_hci *scan_dev;
 
 static void print_rpa(const uint8_t addr[6])
 {
-	printf("  RSI:\t0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
+	printf("  RSI:\t%02x-%02x-%02x-%02x-%02x-%02x\n",
 					addr[5], addr[4], addr[3],
 					addr[2], addr[1], addr[0]);
 	printf("    Random: %02x%02x%02x\n", addr[3], addr[4], addr[5]);
-- 
2.52.0


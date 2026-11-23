Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449876;
	b=Ljq+TbXZzB1CDjtskNRzeXmy8W1+Te72h906Vza58zNZe1CuoYotz655eSXEGpGUwluO
	 eotI7AmCOQELy4Smh6WJ1UHFmYVNhCX048PJFpsrVH+uxkeRXCmqHJhT5CZYqvDLhu9DL
	 4rlPA0zRnicAGCfm3hxWoixBajON+TM9BH1TDIGq7pgF+JRJJR0JomOr1cUpW7Nz38MAa
	 FqHlT18M9eJffKCORglCrpa0Lm1PyC45vZ0SgsXuXJfQBgkX6MrLHF6Qcf2z4Rq4GmSLB
	 BjVVSe2InkDX3mIv+TbDPLZPgjC5sTu+1YWUgVxwVviphuYBQTzqzbL1aNleHHGYrig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=BM0F8B0uZIrlmAuRI2NRKM/dmk5YstSmP3No9fJQH38=;
	b=gdKwdvGLnCBzx4Tyiy5xrl8Wq/C9B9CXdCPu3Res5IKWGxctVugkBzc6Gzfu8rPwePPJ
	 0TTX3O14oXU16YAXUaymu2nC84p9F6yXZE7iK9Za1wK2jf4Dft9DdvrK2TqsQtlLgkK3p
	 fR9YbBpJvOu5nSg3KumWNRY5lNEDbxWMUxT22KZM/YlTNBYNSG47B83pUAQpgJpSr/VpR
	 ykVO0Fvi62nRFgUKD6lV/Ggx6TYpKEgb5gexy4rNX2kLHCAN66J4nWnB0sCBro805Su5A
	 vqpZR59J+1xKUPDrMyMxWQEGYgDPXp4ViYMLihLdp9Bh2HmJK35xa/fzBcaKmRKExBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CRgINeFt;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FD606A32D
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 254FD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CRgINeFt
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so2667766f8f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795449873; x=1796054673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BM0F8B0uZIrlmAuRI2NRKM/dmk5YstSmP3No9fJQH38=;
        b=CRgINeFtTNyJjNzMEc/ZPidK0JDlgQ2Gop9JkOGy5T4j3s74xzjmgs9FPYA5JNumNV
         aFf6gT/Ffz0AfUgtSVPQEnWxFc9memHb+rSXFlGqyKcaYUu1qqWOCcUP/qSmbEKcxeOf
         R+PUp1u2lSFgLTyzjIW46aeQi9gZcL9Wa3onKH3lVQ+i1NTUVhzwt3rNsQ4bjDlKEHfi
         zRgVKEzMG7B3Z2JMLbsVXOsWDeSIAk3q57lXYRMaz0Q0MZqU+bR9d1PHx7Pjc9B2Ut3e
         CJQbXrjsLP+0OyrmIgdnWTchBZOxibYA3kU53CSH+R0FpFnZPdCbHlQjt4Jq9YgoU0DD
         x97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795449873; x=1796054673;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BM0F8B0uZIrlmAuRI2NRKM/dmk5YstSmP3No9fJQH38=;
        b=jpVoUAWnQtsNKOVXvzgYahj3HvAKLAykVTDBihZSZCsMHZExyK0LaX2PXoCI3e02bM
         IUempAIP4wRtHVOfLFU3PRVWTt+RPfSIK+a4glyqAq7L6EJsAdxuK7v/PkeyqwZVq29H
         dl7vTm+04Lysyi5McIQP/rJSUbWglEX0SGmXRMQ2gvTLj0hNekfQbMOeyIQ5++65YqNr
         iH7PmP8IGmgF0rSclYMOOC0ZSU6fZmpqA8sha8ESWg7rNADUuxaj9yLhW8tL4OwTLz7u
         XaQv/uDLg4Rjstk3xIftaEMNoQDJpW2DWRVkRai8TJmPU8GJXNsIqzp3VrwGYLAPz7Y+
         w7BQ==
X-Forwarded-Encrypted: i=1; AL+hErFxIq+8unhL8Sj+JfqRuGYNSuNOPLJXlXzhP0zCdIt6c/lwLxkh67m8JdIm4LykgvC/a82lUOl5oqTwZ6N6RXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HiIltWjfFdI9qYWCewfuDv0ngSEhWbGFSxtHp/yN+XhFEjooP
	61nW5XnyNyu8xoiFNslk0Hq8pCfxcq4sQDFpOq3BahM0wEV7kCfUIGuLCDL2GKAFzug=
X-Gm-Gg: AZFdTZd2ihAtDBapRLU/dU5bjhjqZQ+loy2rJ9ftMWoKNkJPD8D+zpMALO4iWN0Bfrx
	hLvFw+ESHMx9LfpTYx+/Znn2A0OVFgJU3b9h3AhmGvl8/Drr2zk/8NVNy+FJic+3qJnVR+4F8q+
	tfZQKkLfzz/XD4cXmD9hswANy3JttRQlTXI87p5mxhjvkI13hPDAqsWNLnW4PI86njlnY5kRv2U
	t0BCqmlwSFhqa6fTq9rXzJwn9b3v7FQT3EVMw8SeconCzP+GE+wt97moP4ZWO0qMp2bR94n6xi5
	H7jQyvZ4YTKWlssCwThYcVJCZpANplzAJ7B+T75XHTBsXuc5KTUklJUmD4W9ImJUgrZC6WFz1e7
	5rVuY9u/cegkX3rzu4JOgcuNoPNrpwnINd5NDXVtmq+Hx2Mr9R+cn1VmU6kf5Q/3bpYENs45070
	2dplQ4UhNaz/LQDDiUenwWaiayPdAhWcO5cszESQwwwCf/AK4lU2yEZveepDz4HtbnQvq/a+xL0
	iyUPtD9QLi+RCcanU1Iv/Fr3ApJcp9PhjXrOYBqPcwCvoYBlnCEC8LSmh/H01Y5/O6QEtc6I1zj
	rq6dSoMlw+q8D/Eq8tcXpqvCGHtwS5O1qStk5ICSWlas5yc5M5od1QB+/OwJzQRLB8/+Nt/XHeh
	zs7Y/MHdq1D6PReX8
X-Received: by 2002:a05:6000:4310:b0:4a9:6c58:178a with SMTP id ffacd0b85a97d-4aa55bfeb43mr30234907f8f.12.1795449873436;
        Mon, 23 Nov 2026 08:04:33 -0800 (PST)
Received: from localhost (p200300f65f19a90445515a0bd0762d9c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:4551:5a0b:d076:2d9c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6c340df4sm26507719f8f.55.2026.11.23.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:04:32 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_bcm4377: Use named initializers for pci_device_id array
Date: Mon, 23 Nov 2026 17:04:21 +0100
Message-ID: <20261123160421.3227994-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=oBOBpE2L2GptXbojrM0cYbgWlJFm1d0CC7BXFv6hEeo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBGQF87UbSoNY7tEf7OIpBMP8e7ER1F3nxV2e5 /rXR5oY4lqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawRkBQAKCRCPgPtYfRL+ TsNtB/9VbcpdzRp2saBCj7NASZGY7gQVockWHmQ2ik42IgaMyheB2m3F2iJvDHu66R8Vo52mTjs DiDGZuGAxkt1AVME1/0+H9ol8iZ9PxLZu3K8lXElNfiHuiVOG03YQwrAjVgEf9nzKVKugZaf6Th Bby5V63KB0yw3wO5GlvBxuOt2y7m+cu30Pw0RG9+Rw9+f/lbzi76ozzNRPjlzLmxE6JnH26LPjn pSgJ1bw6gSOBiZIxwOMLgX1Qwi4FsN4b4GN4s6hdhniV6bi+yJnzuwxIgp0H6UyOQVD7PB+qopi 70N+dlezC+ptpqzmmG7SgoDKO1oub3JyNF4zngG11HWyz/AA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Initializing a struct using list initializers is hard to read, compared
to that using named initializers is more ideomatic. Convert the macro
used to assign values in the driver's pci_device_id array accordingly.

This change doesn't introduce any changes to the compiled array on an
x86 and an arm64 build.

Acked-by: Sven Peter <sven@kernel.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch was send before back in July (available at
https://lore.kernel.org/linux-bluetooth/20260718172513.986134-2-u.kleine-koenig@baylibre.com)
and before that in May (available at
https://lore.kernel.org/linux-bluetooth/20260504160940.2168650-2-u.kleine-koenig@baylibre.com)

The feedback on that was a linter error due to a trailing whitespace in
the cover text that doesn't make it into git and an Acked-by by Sven
that I added above. I rebased trivially to next-20261120.

Best regards
Uwe

 drivers/bluetooth/hci_bcm4377.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index efd3a6424301..ab5a593ec0ad 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2525,11 +2525,12 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
 	},
 };
 
-#define BCM4377_DEVID_ENTRY(id)                                             \
-	{                                                                   \
-		PCI_VENDOR_ID_BROADCOM, BCM##id##_DEVICE_ID, PCI_ANY_ID,    \
-			PCI_ANY_ID, PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-			BCM##id                                             \
+#define BCM4377_DEVID_ENTRY(id)                                                 \
+	{                                                                       \
+		PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BCM ## id ## _DEVICE_ID),    \
+		.class = PCI_CLASS_NETWORK_OTHER << 8,                          \
+		.class_mask = 0xffff00,                                         \
+		.driver_data = BCM ## id,                                       \
 	}
 
 static const struct pci_device_id bcm4377_devid_table[] = {

base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
-- 
2.56.0.rc1


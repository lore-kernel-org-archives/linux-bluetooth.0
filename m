Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E8A37DAA9
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783252617; cv=none; b=b6uTK+N+Nejn46LQ8TK3v59lUXIGFLp11d+qq/S2I5rQwesDpzjTcsEOCYv7g1R2+mPBhXGA9nVcbBWvJkLoPp2CIG6Ydvv/J9smCcQ9wkYn1KKyYSI2jD7XE9lyjjthKYLOyeRLpwowHsxRJS5r+hPZlDbLb9Po+UUBlpXe2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783252617; c=relaxed/simple;
	bh=ZpBpDhRlBEf1wyNvaNZaS7fLIl4HOxR7G7oVZkBp3ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUnf0u2r4zrcAKI1ZjqkdqHz7seA63bTHLQN4SKbwGS3pCYhZjau4zejLIfOR6mSC/De9ncbzj84UJSqHCNQtLez5K0fZtRyT1gyCa1bWbk7XoqJmFKceBT/yjUhDt1Y7FEaSpQVnoYza/5rk31/ZHEwX7i7THksFzmdyfKnErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=zFBApqhf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="zFBApqhf"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47dc6e04367so41354f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jul 2026 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783252613; x=1783857413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EV257GsPAdFkYYKujprEQlB3BUfGHubKEIdwYlwwzjs=;
        b=zFBApqhfcCUPdjzF3ejy7rU8jDn8uBJUg2ujxTYp5ImPFdGPvxgBocjuxZq1QTyTc0
         iH7pGknglUAt/Wuf3OSyaztolgF5P6EVxMVumXfLnS5KYgIbkzupKIXQZIVq4OjKAKee
         NThp8BQpdp9pT/JP2nmFrIGqI8JL34dSgoBPLrfk7h5tdrGsr4s8M0ddhUHVdxlTB5qx
         gMCugOYg53/Mvc6DUq3SJVEueKMpYj5oAzx+eMBB0ZxDBJLzLssNA+TL/jFPk8Ucn/mh
         7yqMcYydYaGpTvOWxXf0JPNf+t43/g8znsEf3cKSe4MDHRgxYilLdDxHHYgz1oIbdhTk
         JL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783252613; x=1783857413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV257GsPAdFkYYKujprEQlB3BUfGHubKEIdwYlwwzjs=;
        b=GiGs9ferP1xKccFLyJNQFrSfPnLycoAYbYSrWvD/T3hZFYlcxFCKov3Nh4yv9mneLU
         sGSGeQuQ5Ne9fJbpKRJzgaTR6R6pKxcsZtj3502f9jEuury5jWVBkvLuC9ANpTyti37+
         bGpfKZcmQAB0Q/+6+xzBqNVJ2BZ18O0tGHYTXS1TbHUTD26hACD+QvSPGAiI3yvXiN4U
         lEfXnWnWvMpasPvZDAXv6TGyCMfdlgCLVfYwJEo0hL9n6dzFdV1D+ynLYyyz619c8mq0
         dALPghEYx/Wg2/uPWHGr+ljPt6Zvq02ra9ToPHREYr1QpgALVFNoPL02cRjJbePiGqy9
         TgNw==
X-Gm-Message-State: AOJu0YyBo7Pdd0PM1AYFSlO2FTJZAz0LwrFTOygU4QB+dj0CxAUBBN54
	L/TfNq+n7VnQ3SYC2PPQR/1KVxU/c7x+yXrdD/vTLKxlK9RpizdxRtcxdDLgBP/t1Ilt
X-Gm-Gg: AfdE7cmkOD/qjdnJDjXP32/eu8rCbBKlpyJ4HGD9yrt72TyIDTPpfnJbgHj8wFos0eD
	BNgYCZU+YdSIU0e49fmVAkbkoKPuRrhAXm47TdD2uGhN1dg6ZEY/uSgZUjeWzxsg+mWVvd8i5wR
	hoyklltQTLv7xv+4jrtVRW9/koBeISVIlKN8hEEM0OX02csjWWk+NWd7NgS8bYcPV+zKDwHe7kX
	mc2wZJh+f8+83/2ETB4mVTTmfIiRvU43DrH9it3BA2FDmJrlFsIFoXNTnvrweshLBzxMnLFa5xD
	c4GIYRmPtern/Nt8J9yYTIdnnubtvRlgHlgzOfVyyYvQ/IkAszK6c5A4qbdrqvh2nE/ZjVlN6NF
	QKIq5MoC1oYdovPXMcCMvTeBZTSpCVpYj3mo2wYh4VqcyCcrOJVkf0RK5mUCFvngWVS+MnoYXxi
	Z4z1Iov15mNNhyFTqGXHxUFLJcXU7Yij3QU+HWI2KQ6jkbYL/E4ewPRXglh6R0b/vJfIhxLa38L
	yEpEIaq5tMHyFnAnOsEHgXcZiaJ6ON7WYdwW+J4We7Avg==
X-Received: by 2002:a5d:5885:0:b0:45e:779a:302c with SMTP id ffacd0b85a97d-47aae2c5e12mr7467125f8f.29.1783252612919;
        Sun, 05 Jul 2026 04:56:52 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm15364670f8f.36.2026.07.05.04.56.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jul 2026 04:56:52 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v1()
Date: Sun,  5 Jul 2026 13:56:50 +0200
Message-ID: <20260705115650.81724-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds firmware
read in nxp_recv_fw_req_v3()") bounded the v3 firmware download offset but
left an unbounded read in the v1 handler.

nxp_recv_fw_req_v1() advances a device-driven download offset
(fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
bookkeeping runs even when the payload write is skipped, so the offset can
walk past nxpdev->fw->size. When the controller then requests a header
(len == HDR_LEN), the driver reads the 16-byte bootloader header at

  nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)

with no bound on the offset, reading past the end of the firmware image.
A malicious or malfunctioning NXP UART controller can drive this to read
out-of-bounds kernel memory during firmware download.

Bound the offset before the header read, and convert the payload write
guard to the overflow-safe form used by the v3 path (fw_dnld_v1_offset is
u32, so fw_dnld_v1_offset + len can wrap).

This was found by 0sec automated security-research tooling
(https://0sec.ai).

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/bluetooth/btnxpuart.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6a1cffe08d5f..88d9ebf25a8f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1041,11 +1041,17 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		 * and we need to re-send the previous header again.
 		 */
 		if (len == nxpdev->fw_v1_expected_len) {
-			if (len == HDR_LEN)
+			if (len == HDR_LEN) {
+				if (nxpdev->fw_dnld_v1_offset >= nxpdev->fw->size ||
+				    nxpdev->fw->size - nxpdev->fw_dnld_v1_offset < HDR_LEN) {
+					bt_dev_err(hdev, "FW request offset out of bounds");
+					goto free_skb;
+				}
 				nxpdev->fw_v1_expected_len = nxp_get_data_len(nxpdev->fw->data +
 									nxpdev->fw_dnld_v1_offset);
-			else
+			} else {
 				nxpdev->fw_v1_expected_len = HDR_LEN;
+			}
 		} else if (len == HDR_LEN) {
 			/* FW download out of sync. Send previous chunk again */
 			nxpdev->fw_dnld_v1_offset -= nxpdev->fw_v1_sent_bytes;
@@ -1053,7 +1059,8 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	if (nxpdev->fw_dnld_v1_offset + len <= nxpdev->fw->size)
+	if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
+	    len <= nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
 		serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
 					nxpdev->fw_dnld_v1_offset, len);
 	nxpdev->fw_v1_sent_bytes = len;
-- 
2.43.0


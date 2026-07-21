Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3034DCE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669411; cv=none; b=VH4aUGBsLSkPWqgzqau+xgpKEC95EhvHCsHKZuw2jO9oaY6mYzio15lkoNgFYtpWIWf8/+e7jbyrTebycHp7gw913FFJlijIiVBNPRzVpAsRp44ayjP7+1lipXQaduFsmcz6hA2TZCo9Wj91ManesNsIQ2ddjCn+DiCHHUGrFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669411; c=relaxed/simple;
	bh=P7ujY1EjctEEJ5BiCaydXlUdc5GaBLmNSJjxyuWmsJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrMZcpE1FyE4+Izvlczwb8yljm2uLN0O1aaAQEl05l9UVcKIYcFDfiEPIYCHFgt0PxaOweJqS5zhZPQT5AozY9cEGZ8mlJJxs7K8XQ0LLmrtP/XJ666ZcrDUoaa43Vx4jau+zKo6C9IESLxk+CgVyOf2gZ/EAJC3bRo4viiOaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=T3WJo1Sp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="T3WJo1Sp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso6703137f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784669408; x=1785274208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3s/JSUZXhrEE+qb2/7zOa34Br6kcFp6PkK9c5SJgKlI=;
        b=T3WJo1SptPzmlk/ldenzEcIE2GqeIiJwBqYm1DocSde9Txix6fRcGn2tIWpocS/Z3F
         8yHBG3boHSQBSSioe1OsfCMHVhexXDHxLd5NkCQgXFAzRZD3Qi+mP1XIcef9pk8rQb4t
         64CrHX9/6PwLnCmPw0GafMTPDc4qDszvl8UlKfK5onTE48pNSLb57l0trC7P8HKaBsDq
         QHLPURCMCFjMmCDs0Yp8qowj8Qn///BVCFv3Kx/lvZZeu4WsrN0/uSnn4xhxVmm6xh5F
         4RN8d7/a9XliGagmN4lj3CEIQquNtRxID6ZvjkMtWfcItQFHqPDCiDcEBPXg2UVvppYM
         WT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784669408; x=1785274208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3s/JSUZXhrEE+qb2/7zOa34Br6kcFp6PkK9c5SJgKlI=;
        b=SBACB1WrmlJfQ38BNnv+CQwHdPsIj83R+XxqbVSovyAqpuZHx2eScSPN+DvFEvc3kI
         WdDcTTbrW7wHaYVXiB4yYR+jZPaTzcaQ+SqFHdTXxaKB+I+t1CTq+X/jmU9nzNSFMNCr
         zpPOLb/bfBNlVcgBaNurB5Hh6EiaL2p7pXL6i4gZKHvy4UOrI1Lh18U3LKRZLQBQF9rf
         fPk7/u/kxvlOhYj83pwTvDY6e9xtmb7mzjjxJv8Xwgj04QJ5vJ7Sub0/ZDIA7gUhlp3R
         vB5UcDS7sLAowNN3D6DHiQ44J5hMS6IBK+izy41Qx9QN9v6G/eFV1DHqIAFF94+fzt3Z
         P38g==
X-Forwarded-Encrypted: i=1; AHgh+RrLHb7+vdkEwUBYkWuZ9QTzUJFUZHyFmk3+D3vKJyokM7srhjEvyZGbIFLniaH8AgSwRrlXQSfpRtCTrp0YdG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LVN7GuhjV50RwxQGwGeuYotc1rEj3u9SvsLEywNuhneiDjJw
	yPNBbnBRuNiHa6vAO0NFT9toEi+YqEVRy27LHHimub4hKR2axuI9YXAEQbR9rH9YrflN
X-Gm-Gg: AR+sD11rkH+/ePsSjdPt+V0RB/wwg/xalhI5juYu9s7deMtjGNKGiUSVUB+rqxWZu+3
	2nWKF9Rg9Ocnywj7FrkLObOXfL/qOJ5n/GM9W34vWQ711b6vOVA9vBs9jjuhpQAcOKSs9D32oBR
	rwX3PPLU05Lrlspr+MorneGByWYHSEs20jTgLP+4EriWyyUTGi+hQBJXaKH7Zo9pSbxp7USl94J
	+bLGsXNAR532o4k0VtPx9xP5Mz8LA9oAcsbViiJWkkfaMMvEyqEeSvSY1eWpZoeU/ZjStRAcDDZ
	Xrc8UBOhl8rCG2QbLHTcsPzLLNvnJCEgqaXE5SbjW9K/moxuoQShr40QZntpUKIUK41wDH8RYmn
	/z9C4Cp98hy2vxFWAH6difH3Q9YEKUc0ANYaHGb1Mzi69OBWO0avNRc/lIH9mPsPWUsvtYtmCjc
	t2Zjz8x2q+RAw4uI9fLTtJHgIJeQhwcchpfC27VrvSMlsWlzGmt7nfzs2WjzwftuBtAafwGPheh
	sE6elngKdsAr4tQ5X7sAi8P
X-Received: by 2002:a05:6000:2c10:b0:47d:f023:b4b3 with SMTP id ffacd0b85a97d-47f62328323mr23668481f8f.34.1784669407123;
        Tue, 21 Jul 2026 14:30:07 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e519f4sm40482672f8f.14.2026.07.21.14.30.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 14:30:06 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH v3] Bluetooth: btnxpuart: Fix out-of-bounds read in nxp_recv_fw_req_v1()
Date: Tue, 21 Jul 2026 23:30:05 +0200
Message-ID: <20260721213005.38581-1-doruk@0sec.ai>
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
u32, so fw_dnld_v1_offset + len can wrap). Log the offset and firmware
size at the reject site to aid debugging of a real device.

This was found by 0sec automated security-research tooling
(https://0sec.ai).

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Cc: stable@vger.kernel.org
Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v3: reformat the reject path to stay within the 80-column limit (hoist
    offset/size to locals, fold the header-request and bounds tests
    into one guard); no functional change vs v2.  Drop expected_len
    from the log line -- it is always HDR_LEN at the reject site.
    Shorten the subject to 80 columns.  Carries the Reviewed-by,
    the logic is unchanged.

v2: log offset/fw size at the reject site (requested by Neeraj Kale
    and Paul Menzel).

v1: https://lore.kernel.org/linux-bluetooth/20260705115650.81724-1-doruk@0sec.ai/
 drivers/bluetooth/btnxpuart.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0bb300eef157..423a20f78baa 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1041,6 +1041,16 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		 * and we need to re-send the previous header again.
 		 */
 		if (len == nxpdev->fw_v1_expected_len) {
+			u32 off = nxpdev->fw_dnld_v1_offset;
+			size_t sz = nxpdev->fw->size;
+
+			if (len == HDR_LEN &&
+			    (off >= sz || sz - off < HDR_LEN)) {
+				bt_dev_err(hdev,
+					   "FW req OOB: offset %u, size %zu",
+					   off, sz);
+				goto free_skb;
+			}
 			if (len == HDR_LEN)
 				nxpdev->fw_v1_expected_len = nxp_get_data_len(nxpdev->fw->data +
 									nxpdev->fw_dnld_v1_offset);
@@ -1053,7 +1063,8 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
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


Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E834D91F
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955029; cv=none; b=S7KSJn9AN2a2bltkvNydfO4VmB0rpHMcfidC4T1RisDjvXww44ATsDG2BvitU7/5OvZ3KT4TY9h0dlc8N0BH1CXc5TSH19QbCWTreTHjfptWV4nqq+E6zy+GAGgX6E308tZ+uSZZxenkCphb/lkDDEZIwTuaw/Bi3nf6LLzvMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955029; c=relaxed/simple;
	bh=oP8rIIoUzxg9hIZd2waDjppIEnI2BrHnfGO8z+KL5N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fvl5UGfwkUdy1DqszACK6C9HAUU3PWMQInXeSjhIzLE0NLOT1cffL7M+F/1585KJMP8+dU49LZnRf75Csy5dmAtaayXdVS9QNQpXsQSkD295sTkceAfLf2u9468hxqo9TtUCmGLjZqP3qKcvNE/vXHhpwAkYxv/AhMwTNtejZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHYyzKTk; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHYyzKTk"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2baca4df358so80047835ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779955027; x=1780559827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0szyu0aLTYDrwsxxxTLCxZBA4Psj+By733/2324tjo=;
        b=DHYyzKTkhPEyK6s9S0lc4TUuWXa/8/oaATZ7fxfPBp97CzLF/QvYbPno/60MHPgGwx
         FE1A5vtAbIW5wEx3mp3hIelRY/O27SpZ9NcjWcLRMQQccp5+0ynSMl/4o9B+AedGA9/w
         l1qYKo+GKqYRYFtBVXlvGHAUqOfax4WxI3X+L3Plq2ICiF3lwTg4vGX10PaVdBaeHsCW
         5E/v/VfSqhHMKfI0JHgoHnKudbGLSCXIFfdivf7CMKcJyVsQRmjd7SpvX24O43POsgmR
         ntMm4YFVIcg2nBElg1DnauDswrBqlyPxgndLjOjAX91AOkr3TqOXsCH2dSvVQf5+EsH1
         XakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779955027; x=1780559827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0szyu0aLTYDrwsxxxTLCxZBA4Psj+By733/2324tjo=;
        b=O8Cmev90kVmLQ14Pcu8XQyqCxXOJZQSG0tCv3VObV8O7Us5WuB84EtEvhHBvYEOQlu
         18JcTkzfMepPdnal+fCBDwtP6RXjZUv4vHggZOD/ra1+yF58TieP8Lu73aknaZX+LEXA
         gz6PdJLFsEosYwnI/YyhYaLPqqoFGBY9RApuGvX8wpraX8X1aPfpAXugcDDqUcTnQrZd
         aY+fNci7AbDAS9KmBDJ9amXTxdk5jjxcptGh4AkzLc+JfpMn/mRqeIvaPceYuQwoUCeE
         YEjUMVMn8+A2ORD57KgpOPjXN+lCkBcuBz1GePHSvJqVNrNkXtTeKlyMih8ZsXB/ITY7
         V2Cg==
X-Gm-Message-State: AOJu0YwAZamXjTFIxVEpreq1ic/V7kfBaa4u1tU75JuIKsS25SfyV+AZ
	JXYAYC7xlUsi96lELtdZxAvpiZfKXemdAEC+z9ekhUKr4EeJIZfYzs6m
X-Gm-Gg: Acq92OHh4sfhEYJ6gh6mcrYEXNVj3wg6c3SCZs1LBWW6plRGjM6+MR6DKIpNJSWAUIM
	gzZFn2+pRuD3LAb0A2/AXKFhwFvYVi0WUsr2WMgTMsHA+Zb1W4b/oFPR2mRxj7qdbKACO7pFW77
	jdfnGFdGyeek5oAvJhZc7Cdo/4W7Jmnx48eqDN5JztAMOA6+lr44NTxzQg1kwZHmrtjlPHBIMf0
	G0DZGm2CsKZ6o4n1Ly4Xp5tx5GUagIYZnxzVTtPbQMFKUxt3G8QWCctAE47NLu8uG0Mhe9ubbC2
	Gn7CgCLKp7I2wj3fEwDmdahuXhicCD+n4a4udu3j7SSE0RbE9CGQ7azmXiJL5k2a+5lH5Rjih99
	NFOfXqGDb1KcYu65C8CFw+rzuBbqysENiTCqj0zppkN4oFNBqE+NEIiGJWvXuLBfWLcbPfutTFW
	KiPqVML75PIXUAOygi9gLPBoaAT1zQRxsIy84nUv7ddA==
X-Received: by 2002:a17:903:2b0c:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2beb0582ba0mr266026775ad.0.1779955027507;
        Thu, 28 May 2026 00:57:07 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5903bcasm182119355ad.77.2026.05.28.00.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 00:57:06 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com
Subject: [PATCH v2] Bluetooth: MGMT: validate advertising TLV before type checks
Date: Thu, 28 May 2026 15:57:01 +0800
Message-Id: <20260528075701.3417224-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tlv_data_is_valid() reads each advertising data field length from
data[i], then inspects data[i + 1] for managed EIR types before
checking that the current field still fits inside the supplied buffer.

A malformed field whose length byte is the last byte of the buffer can
therefore make the parser read one byte past the advertising data.

Move the existing element-length check before any type-octet inspection
so each non-empty element is proven to contain its type byte before the
parser looks at data[i + 1].

KASAN reported an out-of-bounds read in tlv_data_is_valid(), reached
through add_advertising() and hci_mgmt_cmd().

Fixes: 2bb36870e8cb ("Bluetooth: Unify advertising instance flags check")
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
v2:
- Drop the MGMT_OP_ADD_EXT_ADV_DATA hunk; bluetooth-next already
  validates that command length.
- Keep only the tlv_data_is_valid() element-ordering fix.
- Add a Fixes tag and avoid the raw KASAN headline that triggered
  checkpatch.

 net/bluetooth/mgmt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index de5bd6b637b20..027b266ccc747 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8638,6 +8638,12 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		if (!cur_len)
 			continue;
 
+		/* If the current field length would exceed the total data
+		 * length, then it's invalid.
+		 */
+		if (i + cur_len >= len)
+			return false;
+
 		if (data[i + 1] == EIR_FLAGS &&
 		    (!is_adv_data || flags_managed(adv_flags)))
 			return false;
@@ -8654,12 +8660,6 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		if (data[i + 1] == EIR_APPEARANCE &&
 		    appearance_managed(adv_flags))
 			return false;
-
-		/* If the current field length would exceed the total data
-		 * length, then it's invalid.
-		 */
-		if (i + cur_len >= len)
-			return false;
 	}
 
 	return true;
-- 
2.43.0


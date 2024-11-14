Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0519E98E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612337; cv=none; b=OfC/I5tirHt99Lr5xFSggIyWu8GXVqVU2Q9gRHFSQBLpg7MzZDa0R4zSK62cpy7AvSgdo5f2Ex25JjFZePAdpMbuYD2sqRlmpuUt5mMjZT1MNLQDHoP+IKsjRaD5LCaii61urFYmAPrzld/IVrRURYqjP6TlbYAvUb1A7P21oCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612337; c=relaxed/simple;
	bh=PlRXfXGZRXfh/Dg41TphBXFaL6OfVmKKDy1TKlAztjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8113nHxd1iQuzxgoH9csMPqFSCbkYr7m+UV+j2iAdS20sH2CkTx2bKP59WlFuxEttcB7gwKr3MF54h1epPIai9E46p7JrBJc6ADEzzU8Ir2KkqhNe/LFmWa+TZ8atx/Vt3pUeXMnSionmAwWxvWoCDfBaR7oNu83Txuvgu4Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JywapLOb; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JywapLOb"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d399891d6so437490e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731612334; x=1732217134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RThP8lQ4Dz9fNP6z+7ZeWVvRA9F70KZWYAD89OJlzn0=;
        b=JywapLObtg+e0fxcZLlSAIrP5zSLRgPocONZ20o8Ha8jmR+2zsZkjYjU9MVGT2oXBk
         wrdjfqNNOiTvzNRyolH8FvCebtLHkmCFQUCtPuDXUvS7QSj9iyP8acKtPNk7dl5ueyun
         Iw4k7Dc/XnNgmGXvorMv3n3hS2cdMgBWQgFw2X+uq9WiDdmwfh7RcbBe9d/7Cv2hOFQn
         SsXgUo+lV5SpiraaXTCsRqd3UY5X/WUrl3wPptq/P1noNj/7a3BLHRxkrJyFf1frNjAZ
         atOVz8B3JU9vVG7jxcXb9uAJCY8QFGDZ2zKq8yDXIYgHcu2oaATHJvIb/vo2Y4rpai1e
         SkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731612334; x=1732217134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RThP8lQ4Dz9fNP6z+7ZeWVvRA9F70KZWYAD89OJlzn0=;
        b=F94URJ///8+vY88fkqQNX2l861radmm5mDaFTKqmtSGHvCsiXM5GNiNApbjBGTZvET
         D4vGmf8DYzPUXL1Pvk9WXPIx8b4yDQcYkPf9xXu8lPy8yDs5+gCtYsyBRNz7HwgZ2S/S
         xrmuFl9OgHR10slAnsBT4XJNZMADgjFKtJZ1xxDAv+92Q4yBjO74ZxezMH7Od8ovwwTk
         n5YahoBosgiUM4WSoimtJDFoRD7vSaBWp4Pkcrq5Y39Q4Rfw68mCcL8lmyasXvdADYpR
         YS+dQl1OqhEaJ8hbRvHKHN6KVAGKc5DbmySeode5rqDTK74lk5rV38Js5F47CmGujg81
         kVYA==
X-Gm-Message-State: AOJu0YyZP9yTwbuuHyttadpclnN3Cpm5PsXxuCFAW44eMd/uEp0IZpYQ
	i5jZm1JI54FzyYIm/lM9/Yr7Udi017yWWAuFNLKFW8s6aX7ywi/qjb1I+Q==
X-Google-Smtp-Source: AGHT+IG8T3lrwIPXtFONaQLcA7kV07qY4TXX7gYfpI0HT/61lAHhqInl2dz0VxWjJJwzktuMYsBI0A==
X-Received: by 2002:a05:6122:1d13:b0:50d:160e:de73 with SMTP id 71dfb90a1353d-51477f0ce98mr327510e0c.6.1731612334290;
        Thu, 14 Nov 2024 11:25:34 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856ce622853sm213911241.18.2024.11.14.11.25.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:25:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] monitor: Add decoding of MGMT_OP_HCI_CMD_SYNC
Date: Thu, 14 Nov 2024 14:25:22 -0500
Message-ID: <20241114192524.1856334-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114192524.1856334-1-luiz.dentz@gmail.com>
References: <20241114192524.1856334-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

@ MGMT Com..nd (0x005b) plen 6  {0x0002}
        Opcode: 0xffff
        Event: 0x00
        Timeout: 0 seconds
        Parameters Length: 0
        Parameters[0]:
@ MGMT Event: Command Status (0x0002) plen 3    {0x0002}
        Send HCI command and wait for event (0x005b)
          Status: Failed (0x03)
---
 monitor/packet.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 6d869ffeadb8..f1a42925a8fc 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14712,6 +14712,55 @@ static void mgmt_mesh_send_cancel_cmd(const void *data, uint16_t size)
 	print_field("Handle: %d", handle);
 }
 
+static void mgmt_hci_cmd_sync_cmd(const void *data, uint16_t size)
+{
+	struct iovec iov = { (void *)data, size };
+	uint16_t opcode, len;
+	uint8_t event;
+	uint8_t timeout;
+
+	if (!util_iov_pull_le16(&iov, &opcode)) {
+		print_text(COLOR_ERROR, "  invalid opcode");
+		return;
+	}
+
+	print_field("Opcode: 0x%4.4x", opcode);
+
+	if (!util_iov_pull_u8(&iov, &event)) {
+		print_text(COLOR_ERROR, "  invalid event");
+		return;
+	}
+
+	print_field("Event: 0x%2.2x", event);
+
+	if (!util_iov_pull_u8(&iov, &timeout)) {
+		print_text(COLOR_ERROR, "  invalid timeout");
+		return;
+	}
+
+	print_field("Timeout: %d seconds", timeout);
+
+	if (!util_iov_pull_le16(&iov, &len)) {
+		print_text(COLOR_ERROR, "  invalid parameters length");
+		return;
+	}
+
+	print_field("Parameters Length: %d", len);
+
+	if (iov.iov_len != len) {
+		print_text(COLOR_ERROR, "  length mismatch (%zu != %d)",
+				iov.iov_len, len);
+		return;
+	}
+
+	print_hex_field("Parameters", iov.iov_base, iov.iov_len);
+}
+
+static void mgmt_hci_cmd_sync_rsp(const void *data, uint16_t size)
+{
+	print_hex_field("Response", data, size);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -14985,6 +15034,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x005A, "Mesh Send Cancel",
 				mgmt_mesh_send_cancel_cmd, 1, true,
 				mgmt_null_rsp, 0, true},
+	{ 0x005B, "Send HCI command and wait for event",
+				mgmt_hci_cmd_sync_cmd, 6, false,
+				mgmt_hci_cmd_sync_rsp, 0, false},
 	{ }
 };
 
-- 
2.47.0


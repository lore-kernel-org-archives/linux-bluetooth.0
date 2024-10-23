Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076F17ADFA
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716438; cv=none; b=C1NlQctxK2+OvCpeUjgQFQT1wJnJtkf0YK3rl87kZwSSkgE3/g/P6XMBtivE85POGjuVHDHKrdDcke/WJZqEaNTwFhEjt4DuOvVxMoZddD15zWgUWBf9Xl8jCsnsl5pGP3K9y64gBIZamoqbxbM1LvGCDPXmbHFnPP7lrC3pQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716438; c=relaxed/simple;
	bh=PlRXfXGZRXfh/Dg41TphBXFaL6OfVmKKDy1TKlAztjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpM0oScRjEe4BCDd4Wl4zdqbumdA7sfnsA/51TehUAfWYHYQiSL/9sD7WcorjcMqfYXvTen2av2Q3BoP5x0LetKWt2aN4wID1uCIHuRD++KsqT+SEEG11v9d/nlPhslMz7/jopv9Zj3xf8OFzt298bU7nVwqUsWPhOlSvCZDIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHt7WeUf; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHt7WeUf"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50fcc0cdcefso60181e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729716435; x=1730321235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RThP8lQ4Dz9fNP6z+7ZeWVvRA9F70KZWYAD89OJlzn0=;
        b=lHt7WeUf3zmA5yzadS5V9LW1Ryt16ZLvrifspfPMb+duE5bzvSRcbNtpECqT+KUUec
         OdgBlfcjK/neOoigpHuWzS+m1UAJ8d1O1q+w/ws3I6m5coxFWVrIXxL090LKm8bDuKXv
         stpNEiSRKGlzOu8/y+rBQnsKvC7KoBqgYKmfl8wOwbsNEq1Q9yjmXhJvIJJOXcmP6kIm
         sHHHbNZp+dDLZzQm4TSwFlmwBIVYPo7rWajCzudGqtaklCAztOSWHn5MYheCudUtx3GU
         3WdFkw0S06qPGuaSYENpsepwlnD8x2AZ1FnT0vUmbKLRqtyRw4kKN18+oqz5Cr9F1ebP
         B+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716435; x=1730321235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RThP8lQ4Dz9fNP6z+7ZeWVvRA9F70KZWYAD89OJlzn0=;
        b=XgIhm3GhwlZS5plOIuUaqScSA6/WR1Oknd8zoPcPOdSWmEGkmdRl78LfZeh10VEham
         lrkS/NFGkINoAK9+z8jY4g6NB7f997DpmFgrTcEikcwXhx94tvF/heTUmGhgRHtrrqm7
         XWieCrKXMcHWuS7ApQfQVvURut0Op4576Q2HNKyWN3ucgHycDA7OVXMHEjYufwNmMSJl
         usjoxJqUp5CxwcxS7O3DrbzR1dzmV7kAjijUh9Nm+tsN1qWiYi7uwGUnANupg+Z6DPW1
         P6APA4MI395Sx6a+NSNeIw/tuIIQVBDlaxtuNeQkxTFKW5tZgsYESCR1qYOyEG0g32U+
         T86g==
X-Gm-Message-State: AOJu0Yyxh3RO+5eYK3I481nEd7KR1c4jR5cAI/mPh6by89p0fsQ+wN+o
	3YNJlv3NJGOGBszqk6K5ixYHMyYlFdJcLbLiFC9D8f5jW/9EDsi/BsMNwQ==
X-Google-Smtp-Source: AGHT+IExodb0zunOP45/n09svJjflcB2VMCIUCUZgAlEhMbVbVA4qi3IjAo7yNQRvzD1EGbPFXH0iA==
X-Received: by 2002:a05:6122:2a53:b0:50d:60fa:183e with SMTP id 71dfb90a1353d-50fd037aecemr3898007e0c.11.1729716435569;
        Wed, 23 Oct 2024 13:47:15 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19e0dbe9sm1168436e0c.3.2024.10.23.13.47.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:47:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1 3/5] monitor: Add decoding of MGMT_OP_HCI_CMD_SYNC
Date: Wed, 23 Oct 2024 16:47:03 -0400
Message-ID: <20241023204705.2422998-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023204705.2422998-1-luiz.dentz@gmail.com>
References: <20241023204705.2422998-1-luiz.dentz@gmail.com>
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


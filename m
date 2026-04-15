Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526C396599
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291898; cv=none; b=rLk9H6cvEU7mbeh/83vHxWSGg8Yrhwchaqb7fgHtaYMtKTz/7ysx9tK7qXnx0x3bfo1Hva2ZnYASJY0ibFkrqvDUVGj5JoWpCG4erMaB7l5X28lVDjkQGeeQt3QI0U7pKw5Td8/exM20ya0FusbgkX7bGbhE/9tTA0bsNSiozZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291898; c=relaxed/simple;
	bh=3OL1zEuQN0fn++jqXDTIIT051LlJXz7a/EpbpSTJFyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q72usBbZRo3u2n+cP/xvxPCeoZEm6Vs0ue9qFSX2gkH4/LDi1fpuc3MjvgNWOIK0fSg3Y5IgJhbglJURDlq6JsAR88ochDH67eNu2PtQtmdPTwvAW5AVTpEy+8GqRx29Kz1VIVEUFnJdukUFrcutB0Dnrx4SHVBrq5OAoHzsatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3tLGP0J; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3tLGP0J"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so96409285e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291895; x=1776896695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b15IkafPfIRKQwId3wrpIPX17TVkjx2r9u0B11S3rRY=;
        b=M3tLGP0JM+hqGHeTihvJ9wTAo3k6jn+WDJ2M2IS9fw8cY5Z7u3X11tc9hKvxQ4NYu5
         ycAXXYZd1+RMt81zdDXQJ6YNfoADgMPaT92K/MPi8S8XsY2Dc9Nkr+GAaeFuZjrMlz4S
         DmIFhGuJ+2HaP/KI33mn41pJKaaxqzGPqxjNvaCDxOlHmGOqw9UCRcm8ih9xBUOPV52r
         r9VgfrZtRccMQgRK2OjQymH+TEgYIayyu9yAY20t7JQejbqgP2CE+yYl+0/W/FkoS7YS
         Nv0DJQktq3Vl26PzrBkRT5xEf6J2MH6OlpLJLmWpgtzNGzeOuHbXQXIqvjczH8dGW0XB
         irQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291895; x=1776896695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b15IkafPfIRKQwId3wrpIPX17TVkjx2r9u0B11S3rRY=;
        b=SxhX9RMojE0hZY+Ur+w/cUDYG/++95xOZYFlTMwDjQXDLo7se0BocRy1vDNo6r7hOZ
         N6z7+UeYkxw9FiLjiJwFXW1E+7e23ge6hE/zdoKU9w+RXu95CUHfk0GRCiNcKyNyJsyY
         SAfJvo6qZGn5vrpPP7dFw/oOWNVjwLaxQfDCkSSBjoFhUD0h+ckZvFAk75UJCDTl+jHd
         ghDVmcRU5Aj+4bqFyjMR+/IlS+mNuPwfc7/VcBDNOio+5dEggH5bCRc5qyRcntOsSJtb
         d3agaFVkfxmbqap75lUcBmDRty0eVthDFJelCHx3bLXe7JB5s1LB6Gu+iVtvAeWsakNL
         0kxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YjTAI/PPqG02r3PubGBvqynj8I66gJv8H/tD3Jm8l+oENQruAn1/AM89G7XvuhFwGdSG+RtUIoRlrxbXWkAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvHtw7rofsR45wJlkRf6PZDu/+nUHLUO5RY5mCrbnxq5tTIem
	vwmlGa8Dxp+y/XsFExhBG9l/70Qp9bG3lYhK0cA4X6B8x8Dim0l+/7g=
X-Gm-Gg: AeBDiev6HeJeB6k3n9IliQWZx/z/zdh+eLnZcLmQijjOEtlP4/dvtDLrS/ZxaOZJRWn
	1spocdW9n9SeEsvoWny/6alkCxQ8TB2QUxiw5LNuCfO5a7O2Kk44+ZYFdVUkvLl2rU4o0YBorzp
	j01Uefs5L8PWuac30vQa04aHCOAQA2KCRbmMtM1QwJmHm1fNQwIctqSHb7KkwhSOROJ+3qOqxct
	THofza2wEZ18kzTpSb10Aj1iDxe5RL8AdsZIrXX/87yd+2r6o3n6y2hqYxfWW3sruYnjEA2OtYF
	Ky/tSzzj5rHUB/KX2KxtGYKLH1T6xKZQoM9skxC7oYF1Auz+j3yMSfkx1sqA9wjkRPv4lmlww3T
	q7DsG6RkAwcEmJFZK95i/5GIaoRpgA7yRZx5x+HbVSrQ70V1lxMI9QT6OXe/Fr1pmSs6lZVLktz
	lR8jE=
X-Received: by 2002:a05:600c:4a18:b0:488:e6cf:671a with SMTP id 5b1f17b1804b1-488e6cf67d6mr109815055e9.25.1776291895440;
        Wed, 15 Apr 2026 15:24:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f581b8f8sm2482665e9.4.2026.04.15.15.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	asahi@lists.linux.dev
Subject: [PATCH v2] Bluetooth: hci_bcm4377: fix OOB read from firmware event length in completion ring
Date: Wed, 15 Apr 2026 22:24:54 +0000
Message-ID: <20260415222454.1547214-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled entry->len is used as the memcpy size for inline
payload data without bounds checking when the PAYLOAD_MAPPED flag is not
set. This causes out-of-bounds reads from the completion ring DMA memory
for the HCI_D2H and SCO_D2H transfer rings.

Add a length validation against the completion ring payload_size.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Note: v2 resubmission -- original sent via Gmail had HTML rendering
issues. This version uses git send-email for plain-text formatting.

drivers/bluetooth/hci_bcm4377.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -754,6 +754,14 @@ static void bcm4377_handle_completion(struct bcm4377_data *bcm4377,
 	data_len = le32_to_cpu(entry->len);
 	msg_id = le16_to_cpu(entry->msg_id);
 	transfer_ring = le16_to_cpu(entry->ring_id);
+
+	if (data_len > ring->payload_size) {
+		dev_warn(&bcm4377->pdev->dev,
+			 "event data len %zu exceeds payload size %zu for completion ring %d\n",
+			 data_len, ring->payload_size, ring->ring_id);
+		return;
+	}
+
 	if ((ring->transfer_rings & BIT(transfer_ring)) == 0) {
 		dev_warn(


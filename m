Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793566026;
	b=DAUEh0BtiFS1IPiLItQ5nmYbJTRSR5FTOViBuDgoPDIBE1wEYFM1k/ZbUB4j1bwq5Aj0
	 j7Mp1BteBjztOGo403HFBt+ZP41hyHfdoRyi3BHXxiTjRkD/Ye/VtvR53dTmPSmiVOgXd
	 yeNwWfTwjMAAzKc0WINkbKMEB+EG5/tIOiiU9uhorBBuGmEk4qqqtRean1Wr1AuOVkZVO
	 xYEioHUGJl6iiuO3K0DRV2wkrDPUE8JOmxZ9Jr8vxLSA490j54gPQ5lJJFShBJs2OW8sf
	 5N28rh++m9VOhpDQRnkreQZh4rIAs1GUV4zj39aUX9TPde8AgOimbl8d1veVhdptcYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793566026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yMQqpQDiKs7uaSI9ZXZcOp+ka5/Pebym49yFSbFp92E=;
	b=Jjn+VRbaQHYp6oNiVGD/4OYhcWzMyzkl0fWhbRSpnFSHdaMZ5KjnoQ7/I6FrCyLsvKbT
	 165q7HzPeiw6rq/cWxoGn7oXBUg9ULXwfizwyYMAQHgveQKjIQoe8kNsLirrP2IbznlNK
	 ki1kvqMpS7DlpGiqJcK0T/ZauumkUb4aOGceWoFD02s7tpqCNziLHtVcFBrXyDLzh4ZDd
	 XpacGGIXF4b95gBHEnMAqLMSaNDxIpsTz83VL/el2dsvOAwUC1VnEEzliqQhBIp59tC2p
	 Z5feppsCCGqFUBXUOrfcN/gl3lvc3sVengJQJ/bZvfAF7Cfj9356lLjSHGmprz3GIjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyn0UUmd;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8297606A324
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Nov 2026 20:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8297606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyn0UUmd
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso24231105e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Nov 2026 12:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793566024; x=1794170824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yMQqpQDiKs7uaSI9ZXZcOp+ka5/Pebym49yFSbFp92E=;
        b=uyn0UUmd5DmTqweYOWwmfRBB0vRnW70olD9vJcqDzlnJTA249rwTfz/QFwR2LfGn7i
         bGOcm598ZA2CGvFEN9blfPNhyPxFjJUkeZ+VfJoMYN5Bzs+Mj9LXkNTl8UxO1IXJM7li
         +1Ar7bsHi1sEbuEwSsSxOQbppKDH9+sijB0qrvJqyv+tpLX3w32b+skck3/SfimPT0y7
         EsaGNeyvhvRbzp87efA4rn9AgJHAdmuuj/p892FBOxJI4vYna94GFVFkefkYhzKM8Co+
         vypw+RAOmaF8sBMi9cyLbPCd3NwJ3Yhp/H+pL0WPuyDRB7tJxlETRRzo60kQygt0UgNM
         0oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793566024; x=1794170824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yMQqpQDiKs7uaSI9ZXZcOp+ka5/Pebym49yFSbFp92E=;
        b=VF4/yCKPcJtuhwEatPKly0XSDNY3al0xeGvSumqpWmrgx3S1b/zsNunRaLZPXNqiMb
         2PiCgw5XmQEe2+qKlZ5+G2VD3EnjTbqAPH28M4OKgyJTsKUWnx80jYasH3YKEBsNy8pw
         fZM9LwNhMJkVThI4AK6/N60qhYAbHfXSVpEdb15/dJKjk0X9P6RrBbGrjISijfnvqnYm
         Uj1SyYLvYCkzDSfSo1Prhvv4/KEXQEsObRbuYV2tNuIl76k+1TBpJ7UA4L3EKSbeoONz
         X/6CAsGKx7OZAwGVPEeux5lJUBCc+GEBLBz/yiJKCDfZmlJ2T3NUcl7P/DqnJQsHSKf9
         uqIg==
X-Forwarded-Encrypted: i=1; AKwUvBwXMsvpiZbMSBuyI5nxBAJQTe0ptsd6MHMMnMnMl3Q9nUBnPeFFGsIUerf5cId67nldRqEtuAOrx/VykU47pgQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrj90OlZXhrArQalWFn6lrR8jn6L1wl7G99mqB7vyh2b15lmHu
	PFM+EserN+SUUGDwJJM2YrIj3JPeR355ouyN/Ql9xM//lYSYgHyAZ5I=
X-Gm-Gg: AYBFou1WfEJ8kscMBsDlvl63Q51blIJdNQ6aAdYF5jfjEnmnELRYXg+HG3jpI08FeNT
	F7GLRV1wghSOXl9qZbfs6fgD2CE2yWCx8N6pkyKv3wGLsZZYR7qfc3tdTrfZ7uM05SIniEXCxBy
	YhBU/rP1kViZifi3dbj6Y4ntjx2e6AvtgL1/Upk1i4ywUoZaE71YeDV5eqE3H18OpcroXIBsOPR
	fgS77EAd8VzJdfN0zSYQb7okK+RTkZTeaobIbwszOhUEvr0H/bvlArYT/lF3u8Moj8zq1AUwNxw
	r5Z/7H3CVs53cwHc/igVSrWqlbzPKC776wr4dACmdzTtlt3K5PyhaZsiH/P2pxs4rpRYMCqR9p3
	kejTkMD0f6Pg0ZaPhRm3oivco94cIYlWZmlMu2DrGU20kCLP7KlZuzy1oPmeuAQZ8wr9ShUZ0FU
	cESr5gdio5gxhBDTkeB6yVsfy3HV21aKEwpdBc0xNAravOZP/l2gj2prtr8evc/8SsU/yNfDsT6
	8txY1PS8hAupT8CG2Xr9FWPCBhYH58z/16cwAWN1/WRsP+NY4R4A1j0ZaQuw5d1AXootLjPDbHG
	ZT4ZKEUsq+hHZkEvpNzauZ8ilJ1hzESi
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr195820425e9.32.1793566024206;
        Sun, 01 Nov 2026 12:47:04 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf0b36853sm205314035e9.0.2026.11.01.12.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:47:02 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] Bluetooth: hci_bcm4377: validate completion ring entry data length
Date: Sun,  1 Nov 2026 20:47:01 +0000
Message-ID: <20261101204701.2851941-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

The data_len field is read from a firmware-supplied completion ring
entry and passed to bcm4377_handle_event() as the payload length for
memcpy into a newly allocated skb. When the PAYLOAD_MAPPED flag is
not set, the payload comes from inline ring memory of payload_size
bytes, but data_len is not checked against this limit.

Add a bounds check for data_len before processing the entry.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/bluetooth/hci_bcm4377.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 66d49b4715440a..5d6bda4a04114f 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -755,6 +755,13 @@ static void bcm4377_handle_completion(struct bcm4377_data *bcm4377,
 	msg_id = le16_to_cpu(entry->msg_id);
 	transfer_ring = le16_to_cpu(entry->ring_id);
 
+	if (data_len > ring->payload_size) {
+		dev_warn(&bcm4377->pdev->dev,
+			 "completion event data len %zu exceeds payload size %u for ring %d\n",
+			 data_len, ring->payload_size, ring->ring_id);
+		return;
+	}
+
 	if ((ring->transfer_rings & BIT(transfer_ring)) == 0) {
 		dev_warn(
 			&bcm4377->pdev->dev,
-- 
2.47.3


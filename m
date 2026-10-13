Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F93EB815
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900190; cv=none; b=XftNnsMXOmibSnMq0IKIIW2nWczWHtrxXEgUNW6qpQLM3j2v+WAsQqX5yHBRRFb/LmrV+/kzJcTJeijwtQxMOes63jSGS5rieTQgechlRqdhAIm8GpME5wxXxdTDTJ4gAKbFrN8X7Ja3q7coWwVKjKhL8J3MpTRJ2+V0rj/PnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900190; c=relaxed/simple;
	bh=Mqsg/whadPfAE/KbLUf9kAh/6XNs6b4/bFN+AMUoBIo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aXeDCwVQf8n7mSwZwocTGBfdqfJ3uFkWr2E0pvWvg7Kd0bRyl/fbBKGYvEVTb9bVBFM64nINi0rC6QvN6CF+oL7IHBSFjWPWLfrZ9Mx4rByg1A+yS2EtJjfuYDpv8PIJTJJTYHldYgMy1rKlbv092+XUQAjm76B79VCC8JSK3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU2+6Tbz; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU2+6Tbz"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5e67a6b3633so1011793e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900188; x=1792504988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNLV7ZAIQBsjcsIot/z900VwXs0dja1HV1f/X33CG8w=;
        b=KU2+6TbzHkwVP6rLjbx/d87G1PDYlL0dCzW6whTD1YHW5GpnM7rHfAKxvBB6K9uAG+
         93c1983fQmnOjYD7jEDFmVd7bXC7rELwhOUN2ptUAfK0nQCz2Nb8gtkct+Bg4V7GURXJ
         XdqCyzBz+ehq/5XkNdKjhxnRa91VSc3Ed7Ef9jaGHe2DA7Y7tgbrHXlAwsr9Y8R8qhj5
         5Sv42XJyKcgcFc3mOACpF/3mQ2LxWt4mBAVwa2Kam8CUrugruEoOiRkpOocGFI0bskAd
         /WnIWh7mUOr6AZY2oEwiHPNVPxf8jM7cvXq4uqKRT3AGQxDPyUhmIu3y50bn9JxoIjjn
         7k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900188; x=1792504988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lNLV7ZAIQBsjcsIot/z900VwXs0dja1HV1f/X33CG8w=;
        b=Jb6Sfj/rbF/lGhICXl+xYOpqXn67o8IKBt9F4OTjSaTjZz64HqJfeptlimHVtU5og4
         wMWX4V6krOWuYsZnU3H6Fc04vpzu7kvI3ujZJfKs/jNHACOStYquEFQRU+ZfvxSQSjFm
         xl3RUsUz/I0PsL7h7Qfan8k52zhFUD4hxQ/NXjBXIIvOaOtgKIxNQb0po1dj5qcoBEUv
         J4W9T37q5WkyBt9OSybrxQKaDupkoKdMdYZYS7qX3La05yNfzUCMEAqUKe2zw/A1R5eh
         aaABnb3hde6JdDBgMwXJU8OOJGGi+TurJlC5/vZC1hZjh/aQar5IDgOqK31ne1zhK3Ur
         Ge0w==
X-Gm-Message-State: AFq9FYL5RUj5PlM87QMPSpENIoY5pdE4tZRbxt0jXfeXJgMf0fv+um3R
	CtyMZjzAZ6Qeo6PxlDfD3cSY2rAWSNtdFnkIUMh1zitG9XpS6mGeYTNYWjtArw==
X-Gm-Gg: AYBFou0HqNsZZezndkpIGZV88a0pnerFDt2EsYYOloGFS2UgWmJFWX55yNmT1/ZQfXG
	4hd8HX7gncAP5dY8D+UQ8GZxYRhjTbl3scbLdXAiWWG/g9tWilB5xPJHDCPcE/wr8lqBwyS622Z
	pGcz4UjtqYTWPhBZIpaw0Ph+N5iMMaWCv2dpbaJrE+sbyEI1Q7Z4bQVFJmlhJ7ajkEJKp+NyfO9
	sZHmq+CeLR9BcCcr7KEAjEA2gEnlOdiE5dhfdcbuoyvzhD9rhHcCVVyRKLSkF6K4/rEBU9GeIBn
	zyLtICR1cGw2xg4UQwJdwEquGjbdUiOkRqyhEO7le9251LpVb2cMcntWpnJJRQ0WRPhA7i1RDi5
	j3Fyqo7TRAJ/BjyfoU7sq6zJk1kXSzt9l+/0eB6r2CGWV0X8KUm4ZI9xBda+sWWlA+NBfQrRi/F
	9flpBDThur8pPaQWD1Paa7mb+ElkiHX6m0Bjuj3lPNZKg5SNkF6w8bEJRiCbAXUWhPJR41drV7+
	w3OWuO6xk3LUBUXjODCJXvaMuoKnqzYu7Q1Uk0tiGmJo3BWsfTunDlmtigAlIqq
X-Received: by 2002:a05:6122:3282:b0:5d2:4a4c:ad83 with SMTP id 71dfb90a1353d-5e91f57b796mr4277210e0c.23.1791900185432;
        Tue, 13 Oct 2026 07:03:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cb3117esm9062554e0c.9.2026.10.13.07.03.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:03:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] monitor: Add Minimum Supported Connection Interval
Date: Tue, 13 Oct 2026 10:02:54 -0400
Message-ID: <20261013140255.521668-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The LE Read Connection Interval response carries a
Minimum_Supported_Connection_Interval octet between the status and
Num_Groups, in units of 125 us with a range of 0x03 to 0x3C. Add it to
the structure and decode it.

Assisted-by: OpenCode:claude-opus-5.5
---
 monitor/bt.h     | 1 +
 monitor/packet.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 6efccb27e758..2ddf37ccc22f 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3242,6 +3242,7 @@ struct bt_hci_le_conn_interval_group {
 
 struct bt_hci_rsp_le_read_conn_interval {
 	uint8_t  status;
+	uint8_t  min;
 	uint8_t  num_grps;
 	struct bt_hci_le_conn_interval_group grps[0];
 } __attribute__ ((packed));
diff --git a/monitor/packet.c b/monitor/packet.c
index 8450347fc56b..fe7b054dd7cb 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10276,6 +10276,8 @@ static void le_read_conn_interval_rsp(uint16_t index, const void *data,
 	uint8_t i;
 
 	print_status(rsp->status);
+	print_field("Minimum Supported Interval: %.3f msec (0x%2.2x)",
+						rsp->min * 0.125, rsp->min);
 	print_field("Number of Groups: %u", rsp->num_grps);
 
 	if (!rsp->num_grps)
-- 
2.56.0


Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D04A29
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739650431; cv=none; b=g1q8AJcnqxX2xKQP7xMP4YTH3lY0Jhv2liZn/MWQZYL6KZkPNgUbdku4TU6cBb+ziM+9lP3Kmq0/tSV/116pS2xzA9zjPFW0vNJUAhewR9Rf8HyA4JkSWpGQi5FnnVcKL5Atpoyh+Amq8Dsa1uGmiUbzUW6KTWLvoMKDtSZ/njc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739650431; c=relaxed/simple;
	bh=R51P7vRZl77QjZcLjR00HXtXOMINDrSf6gsOcZk+eiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKJ2cqWhrieQejMLRv8wlHXCzJVdjAQgximPN5lhpIMFES/WHq+wqEMVZdcCtWMevqP+/CURnRCSDrchvvc7z6QRvYE0qU+Oe6lLI7vQH0IpXN3XpIO14+Pedt7s7/BBH+/CCgsmyodhydVbiJtDuI2P/xugIKDTY56nK52NJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB1Tq+1Q; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB1Tq+1Q"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso3520976a12.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 12:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739650428; x=1740255228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCM9F3sS4EllgCZFBXWNCdq05zaS2cvWXLdi4yt67go=;
        b=XB1Tq+1QNUSwdhxlOYGcW4LIIfsLRyd6ILGflGAY8zejk9GRi9T3GFiuVaplWwMX3v
         0LrPLTPgwe+YEa6Lt5N8+h+MGDKc00DoJsaA4C+2BJNl86ykxvTv43XrBeX2G5SwObv6
         k6Q78K7hRUok5tcZj2opiFVO0pvAnGV+NET6AmMsuK3nFWfRnAuZsw1/1fsLJCnSrFJd
         ebjeeXaEQdUqZs4owsQW0MyMi+MPbx4Rn3ww8u8syL/LSmVOSpd/1LEfrTv2MZx4MgNf
         olECdKdNwYJ8cc7xaC/D7in6qQppm3gbQglDgOrkpRQkJ0icVcQJsofBmF2RuqQ8HoEB
         Hv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739650428; x=1740255228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCM9F3sS4EllgCZFBXWNCdq05zaS2cvWXLdi4yt67go=;
        b=tVJ0I10Xq3ww+wXq20IbQKrenAU4sfO1PNmrUsqoZ3SQNBDbb2t+WrNcBZHjhKCmB8
         ZpVAUj+3M2vCuqqqSB/uMVZ5zclOAQUxAZGEduV5/kDZFV/aYTEhgeLTlB1qG7ns4mq6
         /1Xhb3+I6wCQ5C2XLvseo1VeXyIzYXtCmlUhZvd6oIGLOF0aIWl9cYjSuTogpmlh2QFv
         ycG2pL805BdDhjp6R3OeL0KAEAuQI+yW3B33SoaOEu5wXGP0owD2tKLVb9kmv2JnRzyk
         3yEjSo2nJGy0kt68qTzprKcs+Fjf+6oeP9yMfaVLCYIw4AekIU9ZWtbgV9qXKuAhaxbN
         /4kA==
X-Gm-Message-State: AOJu0YzSu+lve3IAOEeZa72TAHZXeixcffT3cMtbm96Uaekr56CKGN8V
	EbjlwV2K9WjJOX4uqcF/0J7x5f7fKeAtcWaSUNf41/e7Hhy1/lmUpn0buQ==
X-Gm-Gg: ASbGncscYUvungvilV40XIDFv8Zna8hwPChI+g0Q3QDy1jEZ7+FouJ8Yj6ZyxUW+WWl
	kUra19Tkpo5GXsQg5oxt6mdJdKvY0rOtgMdeYF7fmeDKtu7K6fEThgo5e8i5lGZTFI/0EcDlLuF
	wfSLHopmlw8LcrFTlSHmDpnxGzGLzC/YmscISWIyTW0K8EMBpN9VNratmZEKhU2AwdtwSshmNMy
	AEijOeczYpYNJuWT2T1nP+CzBqxjFzpuosaP2ayCdIgP47KmoGgAtLYrMKuknfHgIsFqErHC8Pm
	5wy+a0Xs9kCuYzFyB4F9A5xmRmIuSLV1nc4XwZ8RfDTA98um70tsL6LW3lrIkIemtnlOP2IJf+G
	58+73oEHVCEY=
X-Google-Smtp-Source: AGHT+IHY4uCgCfqyNKY+q55gGYRI33Brs9BKi4ha64NGsyD8Et9Otqg1a/WkEOFbY8pHnFiPMBH8XQ==
X-Received: by 2002:a05:6402:354f:b0:5dc:89e0:8eb3 with SMTP id 4fb4d7f45d1cf-5e0360b4ac4mr3929202a12.11.1739650427454;
        Sat, 15 Feb 2025 12:13:47 -0800 (PST)
Received: from localhost.localdomain (46.205.193.135.nat.ftth.dynamic.t-mobile.pl. [46.205.193.135])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2709ffsm4919709a12.60.2025.02.15.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 12:13:46 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v2] bthost: Set advertising intervals to valid value
Date: Sat, 15 Feb 2025 21:13:29 +0100
Message-Id: <20250215201329.173999-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250215190251.173383-1-arkadiusz.bokowy@gmail.com>
References: <20250215190251.173383-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The range for LE advertising intervals shall be in range between 20 ms
and 10,485,759.375 ms. Requesting other value should result in the
unsupported feature or parameter value error code (0x11).

After the modification in fa4d477, the btdev emulator no longer accepts
uninitialized LE advertising intervals. To fix that, set the default LE
advertising interval to the lowest possible value - 20 ms - in order to
minimize tests delay cause by device discovery.

Also, this commit fixes the detection of the high duty cycle directed
connectable advertising and sets the advertising interval to 3 ms for
such cases in order to be complaint with the spec.
---
 emulator/btdev.c  | 11 ++++++-----
 emulator/bthost.c |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d7f61deb0..d04c5b023 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4870,14 +4870,15 @@ static int cmd_set_ext_adv_params(struct btdev *dev, const void *data,
 
 	ext_adv->type = le16_to_cpu(cmd->evt_properties);
 
-	/* In case of direct advertising (type == 0x01) the advertising
-	 * intervals shall be ignored and high duty cycle shall be used.
+	/* In case of high duty cycle directed connectable advertising
+	 * intervals shall be ignored and high duty cycle shall be used
+	 * (advertising interval <= 3.75 ms).
 	 */
-	if (ext_adv->type == 0x01)
-		ext_adv->interval = 10;
+	if ((ext_adv->type & 0x0D) == 0x0D /* 0b1101 */)
+		ext_adv->interval = 3;
 	else {
 		unsigned int min_interval = get_le24(cmd->min_interval);
-		if (min_interval < 0x0020 || min_interval > 0x4000) {
+		if (min_interval < 0x0020 || min_interval > 0xFFFFFF) {
 			rsp.status = BT_HCI_ERR_UNSUPPORTED_FEATURE;
 			cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 						&rsp, sizeof(rsp));
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 95160506d..a76b02ecc 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3249,11 +3249,14 @@ void bthost_set_scan_enable(struct bthost *bthost, uint8_t enable)
 
 void bthost_set_ext_adv_params(struct bthost *bthost)
 {
+	const uint8_t interval_20ms[] = { 0x20, 0x00, 0x00 };
 	struct bt_hci_cmd_le_set_ext_adv_params cp;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.handle = 0x01;
 	cp.evt_properties = cpu_to_le16(0x0013);
+	memcpy(cp.min_interval, interval_20ms, sizeof(cp.min_interval));
+	memcpy(cp.max_interval, interval_20ms, sizeof(cp.max_interval));
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 							&cp, sizeof(cp));
 }
-- 
2.39.5


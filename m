Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F53192B86
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493189; cv=none; b=T4r2d3vY+M4+tcbuHtJCy4i/g6ZS2fjzd4fFradg5utpcy1vQGno00lnb4QYDihkHrxcxi3AUvf0uTV4W9p8tAhcugaS1TJihzEmzgPLyshV/Yvoi43xh+yn5LvyB7hiWZa+USwbwq25wf4mqB363f12N640JxPuZBRpnvn8aNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493189; c=relaxed/simple;
	bh=6E3vmpTZRf5BEdWfqgA6TXGLu+jjt7noG/bcZI0NvYQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VBV24qPHj7Fl71bWQO38Ze7JGnO2M1gWmaVY2+4eRn5xH8C3bgg/EqA+c/6FqVdNSZGtCfKOtxRw+wbYwzeoEY5kWfCZE9Xtb2mCpjUNDF6NcFicnYV/Hx6DWdcMto54Dq1yS1f8kMKpyi7dwWAxGLxgNmDQ56iZdFsJKVQm+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL6coQBe; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL6coQBe"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f6b8b7d85bso1611249e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723493185; x=1724097985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WZh5rHB7Rh/cjAtYoP5i/aNUfogSzPHqAz4xv4Vgw4=;
        b=OL6coQBe5jT5jmZkNDYBQZNuFL/FTVyFCQcvmYiz8KpUhavnJBYT67+JSQCwAyRY9K
         Dx3Tv6Vqm5wnvOIlbkVTcB2sgYiAlCWz+tIs7DnANTA+NFx3DVIAi/KF83zP/uXcjOwx
         8/lYa6bw5c35dY9a5fOZDZBqCjeAHMgb7/DLVeJoOuD6WbBosVC9gOUjkPLfqeovzOsn
         LP1xfLMQ79Hlq7nve8lplxVaUBCUtolqcXhey3nYBwJlP51oEcZx8gMpD+ailXHp4QOm
         A3tuTG1/xP1ehvcG3MIP88hugl0SXBcSPPrH3US9e43WM9gD5CJ1grZF3avnb2JnxApY
         5w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493185; x=1724097985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WZh5rHB7Rh/cjAtYoP5i/aNUfogSzPHqAz4xv4Vgw4=;
        b=rFSS6z007J5ANM8s/uOUa6gwCJQK6xdOv+t2HaSWHNKa73vxyMYc+bUGmAzx2AymPh
         FBGO4elKUWUyjXUc/CnB1taxvETjCEnnqFw3HXVBgZUxcvOQrkH/spQ0YTn2eh8uxGTM
         fLrDZor7adfrjjs1Lak/m6kcitLW2SGyAa/saaxjElVLCZnO1NZGsozVnNDV3HjF9qnu
         Nh1tYAc/Q3NmG6muPfV0MMCaZPSX2qJR1y2iVcO1VjD5OvmQAuCgsZXM3QY+CFLDViCI
         SoHMGuZkxXNPZmokQ4jt4HLzKTLWUlzsdrMEn4czvlh6Jm5FBifWVoHDYYhgi6qVVnfD
         Zm6w==
X-Gm-Message-State: AOJu0YyVLckakfI01iqx+TTLUkDy8If00FQK8i83Xq+YRdVClBFnT/Oz
	G0XF2odfeLcQ5wzz/b5cCZInhI5301kXpAPAhFUG+W/1179GPuSHSs4Fig==
X-Google-Smtp-Source: AGHT+IHvbcUDiVM+jO9xMQMcd3YrCUVxrqzNNIzPn8rsx4r/qZyjktjCuEeBTRE/fgLg0Q10S7SUGg==
X-Received: by 2002:a05:6122:a22:b0:4f5:446c:f749 with SMTP id 71dfb90a1353d-4fabeef1110mr1785178e0c.6.1723493184794;
        Mon, 12 Aug 2024 13:06:24 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f91f2b948csm736133e0c.8.2024.08.12.13.06.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 13:06:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/uhid: Fix registering UHID_START multiple times
Date: Mon, 12 Aug 2024 16:06:21 -0400
Message-ID: <20240812200622.351942-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

UHID_START callback shall only be registered once otherwise there is a
risk of processing input queue multiple times.
---
 src/shared/uhid.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 1eddc6122990..b0a436d7862b 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -46,6 +46,7 @@ struct bt_uhid {
 	struct queue *input;
 	uint8_t type;
 	bool created;
+	unsigned int start_id;
 	bool started;
 	struct uhid_replay *replay;
 };
@@ -351,6 +352,14 @@ int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
 	if (uhid->created)
 		return 0;
 
+	/* Register callback for UHID_START if not registered yet */
+	if (!uhid->start_id) {
+		uhid->start_id = bt_uhid_register(uhid, UHID_START, uhid_start,
+									uhid);
+		if (!uhid->start_id)
+			return -ENOMEM;
+	}
+
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE2;
 	strncpy((char *) ev.u.create2.name, name,
@@ -378,8 +387,6 @@ int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
 	if (err)
 		return err;
 
-	bt_uhid_register(uhid, UHID_START, uhid_start, uhid);
-
 	uhid->created = true;
 	uhid->started = false;
 	uhid->type = type;
-- 
2.46.0


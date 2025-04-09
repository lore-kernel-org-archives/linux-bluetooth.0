Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2031E503C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226514; cv=none; b=N0ilLffOOlEof5Y8AyatidelgXn7BIAeez5duwEaZNBNXTsf3rdr0ou3paSiMC3hGwfLk0+nci/30pfuZC5NlqCwOWLIA9Y6RAoP/2i3ZlQSKezZkBemRjyUAbaYSm+90dnwDdQtLnKK6VXrqDNUWkdAD71qRd7irJP2NNZ3Zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226514; c=relaxed/simple;
	bh=+iiNKFvbINuGM6zQxHW06EVqWIQzeB1Ow64FyZOhH90=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EAeeqgqHYuKkYzTcUPmu19/KlX4xFrs9vlLq8J95hhBJAU5Vmr8mQ+Yhm5IJjRRjYJl/DwgawtGdyauMEj574CmExydFIjTQm2YliaN40PKT4YlBra6+GyH7Vw15T0w4cv24YXCT/8xx6RP79fYPDcqIq57SlK6/0mpWd4E3WkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niPxPIQc; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niPxPIQc"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5242f137a1eso37807e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744226511; x=1744831311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHBV7jYyuOb6Y1LiUtevjzCSAuyGeoGIHOLA8cIVKz4=;
        b=niPxPIQcZD//u0bjohiPT65/dWZl6fhuuLhsuGG4/yv1cqdMRldIGg+qm2xIJ6bTYM
         AGUZVNBoaBb1o9NPjYzg6SUyVEV+g3+9g/MhEwWd9ZBulWJmT/hL75mJVi5nxEob8HPy
         SwUerd1y8mS4SH3FqyrH7QETfX1/lW/t3dXfZudN6pLbq2R+UmRheG3VCMcSr2/j93p/
         OzPaQegRMoxYpczztRQj3FnbFjjNOxACTUtwwf6RaL++AgukOEKS4u+5R6ga11r26VWm
         q6h+PyLmu8Ji7bSR3fv8kFB2PvBvC+KcnYE0Fk4F4HQY5YNrjuKVBauvTbBPo/VOpkEH
         6ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226511; x=1744831311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHBV7jYyuOb6Y1LiUtevjzCSAuyGeoGIHOLA8cIVKz4=;
        b=d1beWauZ7NH97wrIJGupKUdlON0hjI+OaMwCIvTkuAlItv22GtJdajBkOJIaOfDxWr
         w0kILPYb3iN0hxW1aSwtWLvAYWkSBDYlxz9BRSBAuZKFYQeujy96Aw1iWftM4IJKS2Qv
         ybW/1mItllUkSlz3JnhQfBFunYV8sv8j3l9jts0DPinsl9NvfJjuFFqsO8R6Mq6HyCHu
         bsmDIKPJ/ZuQmz8ezWt6eo6vUzsN4ADNWO+rsOiTzEqZDWLZBXdRRFWbfbaHhgbPanns
         JYYL1F6C0A+fPL1i2bdZEELFC3vqO7vRD+dSkr7qqf5otOf0HmEKp03eXO1KbnPxxene
         oAqQ==
X-Gm-Message-State: AOJu0YywKWmilLnRWJ6b9uhB8ME2paIiD/dISIJ4sMETaRT39g+pmxy1
	Kg5aahb6mqp60vpZKPFQFwJ6gv4hwlp5yIXhxoE6uBQTjPhlQN2gSvKTfA==
X-Gm-Gg: ASbGncuAtuuzgiEfDDouvS1jjzjYo1Vw604vf4g7sbpsFajw5wbCOcb0NSbJ4Hu3J7R
	E0XxFOAn6eBjkj05kR3jOtOlle/5iBM+jau+ZNhJ2x7lWeJXD01i2rAdQuRiZScG+Rumfzt1keA
	QibEV9h+YsFb1CWULchHIJ0O4oSrsd4yQqS1+9/U99qQzI7bIwOop/RLdiLZvUOYjX3kdvMfjqv
	ykZQCc2H/UG4SMYHrTS9ravQ756pf/aT9pnT3IQTAye7aYrmG81i1908LB4FF1+gKGfl7jR5P/z
	PZwz2zFsErKabqvsdwN6rygoLed063moBtxmzb96mRi9nM6aW1uSD4z1RF5SxXWmBfACMn2oMX/
	flrAEPIvOeFvTwQ5XZe/U
X-Google-Smtp-Source: AGHT+IEPJ8zDTt06bZdHhOahp0p++1SjaHN4OqZKY58vZXRGDVtNe2mn90sS5FK4dmU0cnkQtUwJwQ==
X-Received: by 2002:a05:6122:1e03:b0:526:19e6:fa34 with SMTP id 71dfb90a1353d-527b4faeea1mr257302e0c.1.1744226510745;
        Wed, 09 Apr 2025 12:21:50 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abbe5486sm365033e0c.0.2025.04.09.12.21.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:21:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] btdev: Fix checking for BR/EDR scan enable rather than LE for PA
Date: Wed,  9 Apr 2025 15:21:48 -0400
Message-ID: <20250409192148.305768-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

PA is exclusive to LE so le_scan_enable flag shall be checked not
scan_enable.
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1b7b75c21399..7e4cb9393593 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5750,7 +5750,7 @@ static int cmd_pa_create_sync_complete(struct btdev *dev, const void *data,
 	 * synchronization can only occur when scanning is enabled. While
 	 * scanning is disabled, no attempt to synchronize will take place.
 	 */
-	if (!dev->scan_enable)
+	if (!dev->le_scan_enable)
 		return 0;
 
 	remote = find_btdev_by_bdaddr_type(cmd->addr, cmd->addr_type);
-- 
2.49.0


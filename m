Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7934C96
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737362880; cv=none; b=mlS3s+ismZaTIp4jYNmgJ620oJknoHD2MvgkzvQLawLEK1NGN9hPL+8gCMjYIVU2ZrZu/agCGXHuE/sd36XWWwYVwPMiMKcE4UuWoE7ZYv9JmCwkMCzDuyOlunzWIkjIIAIi1U+XjAuv8vMaK3vTbqxGNEBwZ0iNClK2FRdrRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737362880; c=relaxed/simple;
	bh=57/gmddafCix2wCQk8ONCUsPx42jua1qoA6j5vtRPR4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UCN5C8YmIY9IXF8WWASc7xy0nGwd+pPbWjg86YVDHj37ZEese4OAJk3HoIR9E6vOWdDcH6AAG55N3J+D4gsSPD2WrsTErAHO77BgCSz8eIJuaUmYoarhJouoqGPaRrgAtFPEP41RLVfBN7GZrMEpqACO7TKVO621W/OK8HwQ08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcpQ4yDH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcpQ4yDH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216387ddda8so92234895ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 00:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737362878; x=1737967678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g0QIn/v29ZtoRiOVMkhYJzfsf9Ci4N9toY9tFO+AR5Y=;
        b=mcpQ4yDHncNSrLPmePOJDiMRWwvtG97XBpygM7RuJKksZmmqWq9R00CUB68nAepaan
         I/VvYKITJQdp6A9KKwySXGQGFuQhg7xS5PYE7S19+bfeoVgcys3iBA/C1mO+5FMC2ZXt
         Rm9aYwbQ/ohpu/kXDjK7pvSauYbxFQOqnEeTO9t11FGPDL2+YPf0imCx0WPRtusfJ+b6
         /kpjab2czHZ6A/R5K2nYWX2qRn0vQgf94RlpngzqhptcsaynMzDhx8OBugB3NuY0NqQO
         6JtWqBfcLiuCfaqwLDE6A+8ZyMez4nO0lCiJmw8eNN0eaE3iPky95OhH3WHoDDgxPqks
         CEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737362878; x=1737967678;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0QIn/v29ZtoRiOVMkhYJzfsf9Ci4N9toY9tFO+AR5Y=;
        b=c05Hsh2QxsQYTg7ropSChENQgh29Be5TiuI9UO6tgwF5/XTG86T+7g4mtLB3gGSr64
         GM3qMFV0EkT/pOj2Zd41KwyvUQ5drrB58M6R98Bg/eWYlzYOaf0kqN4FpKB8MC+ORsSK
         CdOy0rDhI+I34mZaEqQk+XvrvU8107OiZunwUjJH+YiPRIXlWGmohG7iUODVpHZvHq4m
         DZ5p5jJ9HkxQw/ph1axm41xJKFwDfc5K4nSFu0aWNwD6WSdIwpGkeQvigDlHtTu/RCyt
         NwFw3yKOtGfkXY3RkcyUb53hoRcSKY+GBCf4FuWSZvPoIjjYenpNiy8cQR5HeENjtcD2
         xJJA==
X-Gm-Message-State: AOJu0Yyhu8G+X/o2+dwdQZNaQwnDV1Kn8TIjj+fnlvIHV1PbCUfhVa6v
	4cval604aJ2PRiAOW6nNBIls38aemvNHK8W8M45G2YTJkO8iXwzX8spd705iO5KUWtJLvpxElPo
	3IfYfW1wL+chKo2DurzGVjwdf+HySzW9QfXM+bqm7fTTp7kTBmro4k63+RVshZvpOxkeZITnCkn
	LbUMmWMI+5glkFdKzAC1LaiJk8ve8uz57srOaMffThtrkP3PCHug==
X-Google-Smtp-Source: AGHT+IGSKjPEI4dd/p1qSoeecsVRUdjCOwk5+yIrOaSG1Tn5or3EkO+z4z8xdTU53NFm5U5w6IrDHZiiesyN
X-Received: from pgbgc5.prod.google.com ([2002:a05:6a02:4b85:b0:a88:3e2b:cada])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2342:b0:215:cbbf:8926
 with SMTP id d9443c01a7336-21c355b053fmr169274655ad.35.1737362878183; Mon, 20
 Jan 2025 00:47:58 -0800 (PST)
Date: Mon, 20 Jan 2025 16:47:36 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250120164732.v2.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
Subject: [PATCH v2] Bluetooth: Add ABI doc for sysfs reset
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de, 
	luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

The functionality was implemented in commit 0f8a00137411 ("Bluetooth:
Allow reset via sysfs")

Fixes: 0f8a00137411 ("Bluetooth: Allow reset via sysfs")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v2:
- Resolved review comments from Paul

 Documentation/ABI/stable/sysfs-class-bluetooth | 9 +++++++++
 MAINTAINERS                                    | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-class-bluetooth

diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentation/ABI/stable/sysfs-class-bluetooth
new file mode 100644
index 000000000000..36be02471174
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-class-bluetooth
@@ -0,0 +1,9 @@
+What: 		/sys/class/bluetooth/hci<index>/reset
+Date:		14-Jan-2025
+KernelVersion:	6.13
+Contact:	linux-bluetooth@vger.kernel.org
+Description: 	This write-only attribute allows users to trigger the vendor reset
+		method on the Bluetooth device when arbitrary data is written.
+		The reset may or may not be done through the device transport
+		(e.g., UART/USB), and can also be done through an out-of-band
+		approach such as GPIO.
diff --git a/MAINTAINERS b/MAINTAINERS
index 797e94ba74f7..e949c3ac7846 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4058,6 +4058,7 @@ S:	Supported
 W:	http://www.bluez.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
+F:	Documentation/ABI/stable/sysfs-class-bluetooth
 F:	include/net/bluetooth/
 F:	net/bluetooth/
 
-- 
2.48.0.rc2.279.g1de40edade-goog


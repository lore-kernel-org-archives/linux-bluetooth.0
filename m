Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7281381B10
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654804; cv=none; b=QMGqc9Ekonh6VytqWefqIZc7Jm9zCpVlp1MCiiVsVNslMgn8WgqS+vL3cOIYSZg6Nf8XlcvNGsstneQtlzkRzopT6bdHeHV0R2Rir8/NYiLBbteuVyBp1fNLa2tp3F1lXxJdm8EG0Q37q+PUz86jMBozQNaVacGuFbE6MYBehC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654804; c=relaxed/simple;
	bh=7CM9NoRAuvUD71ZDcfVmBq2YbhkwMF0c5pP8vC1jbkI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WPl1Kx+r3w+u8SXgJjbjlqIQ50NXsKY4RX6vaeQk3Hqcbs2j0ZbLyXCT70X6rujkwt9g2T2XOfqAbWtwnxaqXgv2nKunmSopITMqDnR9MS+6rstwdJ0qC64y+XI03DgHGoZlLJcLCVNH6JEV59/qVv1h8wkQ5j9JRn91szXbFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9uHyw1J; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9uHyw1J"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94acf9ce1b7so4904450241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 12:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772654802; x=1773259602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8P9TxqbeHgZriwaCk3dsO8vwKP/AARuDd00No5RZYNg=;
        b=Y9uHyw1JJYVGOOKlA9ISkaD6yD3mza7d9W0Juxp8nw33c/nZALxTkt92bhxMv1kAKH
         0TXsjzn8DX79l41A+nfGjUzJJbsWuODyifB9hzV9lBSumAk7UeX3heIoH3N0/F6FkmTl
         zxhRmhvPDRi7yIpg+ZPX+l9/EDGdxphtwxOGH6XzPX3pHYJbLbdY9diO5aDr96tN8Pyb
         JxBfkVfhxIIpg9cHGWwYkPmo4gQj4dBMzQBbwSEZwldLufO/YBPuRS3iJs7M/u0z0Dnn
         dttBXqDr7rwqClWBQE+1QvyD8R65VJjq8m90VOh0L8Kgnh2QhAT+wjDnGO47y1+BriRC
         FwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772654802; x=1773259602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8P9TxqbeHgZriwaCk3dsO8vwKP/AARuDd00No5RZYNg=;
        b=s3Vz9Rf/W9caqYFhUkrTJ7IF44pDNOfEgQH6AajrG1oKOXTO3REEXAar84YUxMAYHw
         3WKR/fXRs0qJGQ5ZOTloRLaWxujfHWBscSta2CNqJFx6BI6h0deAOfj0jlYdIx3XWwj5
         S6kqr+z3JzlIi9phwjyAVmaRySl9njdUP9SKoIRyyXHtZfhiSRzcbWvH7ydGGOa4N9i7
         nMcUip0t4eGsSgyRTSL5jaU2mhLEEirEZRcYBCFr2JPvHIX9XsD+/v5cJ6RgLpJY1p8C
         wttD7YjqwZP6c2QByv6+53Ft9CAq4SvLsILWXD3qJUDsfmMnsM+2DZhi7Tcw4DnDt1sJ
         2O5Q==
X-Gm-Message-State: AOJu0Yz1ZIM2GBGDjvICr6rhgo+CtGOI2b8ENkudqUjMTG+ohiS0TIce
	rDyudKTOArAgI3JxlBNIVYdYvekQg8dfgv47f4Q9+orH4x5MFI3mvqBA61sYCRAA1wM=
X-Gm-Gg: ATEYQzyKyfa7tXtt3LFbrrCFprYTMn2yqqPvNcFnPf1pvVqXTel+W/a/tYkXIX1AdO4
	YFoimE6p0HLcnLBYEryd3R7caSpnnscI6+reFb8/NLrBhOWI93LE7FYosyONQu2GRPKEW/fGZqb
	878anTTi6HwYRnR1WdZWGIxZ9NzyZdJ3MAtZMm86BEtmn9805sPdQtqxjwVrY0RTiW/Xgccyv5j
	MhTbusyRjdXtzfHSQaCYLAGeXxttloW8OKb4zySBiE2L/SWUdX6ZiRW9ZxxXxLllLQaDYfXPNkC
	npbSGDMAwlc2DnIhOtnuxmHn1dRSFCk8+kY7nLplSbvCyEx7pG023j9tCzBZGiadCqGCedyy4FC
	7pGS6fSpD9TLflHWus8RC01z66PhF3RGSQ/eQWGlHFqklDZrkJfrq7HAaGxw8DM1Jhqtc0tyI9J
	e9Yg/unBqXRbQu992Z+IDqfOgRcS1EolQ8l8pQ+rBX98ztBAkHznWnpd4E6s9ShspP4PGMTROw/
	4mmuPdNA/MxlcXmmlaka8mY+pcE
X-Received: by 2002:a05:6102:e14:b0:5ee:a083:7935 with SMTP id ada2fe7eead31-5ffaac1e726mr1556271137.1.1772654801693;
        Wed, 04 Mar 2026 12:06:41 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e7af30asm21434936137.3.2026.03.04.12.06.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:06:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: HIDP: Mark BT_HIDP as DEPRECATED
Date: Wed,  4 Mar 2026 15:06:32 -0500
Message-ID: <20260304200632.273572-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This marks BT_HIDP as DEPRECATED as it is no longer needed on systems
with UHID which is preferred over BT_HIDP as that works both on BR/EDR
and LE beares.

Userspace already defaults to UHID since 9698870015b0
("input.conf: Make UserspaceHID defaults to true") which was released
with 5.73.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hidp/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/Kconfig b/net/bluetooth/hidp/Kconfig
index e08aae35351a..915035e23719 100644
--- a/net/bluetooth/hidp/Kconfig
+++ b/net/bluetooth/hidp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config BT_HIDP
-	tristate "HIDP protocol support"
-	depends on BT_BREDR && HID
+	tristate "HIDP protocol support (DEPRECATED)"
+	depends on BT_BREDR && HID && DEPRECATED
 	help
 	  HIDP (Human Interface Device Protocol) is a transport layer
 	  for HID reports.  HIDP is required for the Bluetooth Human
-- 
2.53.0


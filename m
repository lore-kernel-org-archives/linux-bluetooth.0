Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302314831D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859602; cv=none; b=Uc23V2ZezQ3PN1nNoU2Pj4UmzQA01ImcqSK18PExE7cEEeQC4xaEGwo7R1XWAaJOdg3GT/05bbsr1i36DdiIyX3bYDfoox+ju0lRT4l4V69AnxhpAy9BFdK5xj2Qi+eZw+FzFuuqLM2fpOCGFsoN7CecQFZL96tGkBSzBbDIIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859602; c=relaxed/simple;
	bh=7kmJltjg+iRNIrcmgpAoUVzQficqzDBRHt3/jzPYc6w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rr0p+nzKTJXQUzOgmxEGrMaTdQ0lj4GcCVt2468ZrAdjC7dPXx0i3x+IVgVrWZ2BlgV+QCw0Y5VHZzJojI0edKEu9HEVFfe7FQssWB9NNg1D+Is+Qw/Du50QX2lfTBBhyRmK4tEJBGKH2kydEBMCHxIjly1wD9pNU2opD+y7+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CozXrLn8; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CozXrLn8"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498d587c13bso2140068137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724859599; x=1725464399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjN0c3XF332E6D6+oF6pTAR/hvdkYQJQJ8mtQRRQT5Y=;
        b=CozXrLn8QQ0cPDy6GvZ+hccbQHSWfL4nzBq0U60OMzcreRRxGl/gZt7o3/678fJPsz
         K45VS2jQARcXG3HxI9E7qbDXMkbejILGP/VfCn4BYPg+fHg80sTlLkT6cIdzfoATfYKQ
         aAXWVJAdDccLtzr6eMqSLOIL5wa+LbtUDT0XnVdZ9d1nmTDTPNY1cgDeCMDM0G2+WJtm
         TPrsq50UcqZ6k3Nf9f5cH6Mjm20oBLM0vIMOpnwuX9lQREWnrQ+Ih1cnS0wKbgHNeiZP
         0TLQEIfzVXGcL7znlKiYcFOGspPSyTHOQ4GZW7JfVogaD+YrdE2WnYIbEOIqqG493KpH
         /sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859599; x=1725464399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjN0c3XF332E6D6+oF6pTAR/hvdkYQJQJ8mtQRRQT5Y=;
        b=uqMkvdZDFr3kr69iwgC8HlL7bsvZk1y3HqaZJ10k9T4p7xsBgur7miqvluQsByBw3i
         jEogrndBtWRcSb3ZBTWCEiozLBOnXuoMRO7OCw2xeYt3d2jn7pO3MIU5oJdI1huLumbh
         FaJxeKA1tB+1AZnjBlfiFjPzMvQ1KxCqAUCJegfr133DWkIW9bPKGyg9t4TLzA0nSOi/
         V7v0G3y3yJK6oxFPrfFmfyj8jFos8+gR5wjYa5D79mn7/fC/HeLTwNCSbP4kiu11qS4h
         U7BzNNq57voeY6Ukes3zSPdg9R6WraBAjMgoTFzCm3ockHtOA7k9YlRiGOfi0X12NV34
         NrnQ==
X-Gm-Message-State: AOJu0YwMSl5xhK98GOaNwDDjn5Ukt3ONzcfseVDDRkU8VquenitkFWnc
	5fIc+KEpACovfaD7wXKekO94Jf0OAQRSiUB0wH5DY+4TnZCTyhGldCW1Ew==
X-Google-Smtp-Source: AGHT+IGGzLu9uCIeEZXhoZ6HSTnYrkjBsSbwt8hFNerdd2y1/ZKSSMJ/qgs8vlEXqYMJ/50EofdJ4w==
X-Received: by 2002:a05:6102:3f0f:b0:492:7bb0:9bc with SMTP id ada2fe7eead31-49a5b169172mr77552137.30.1724859598976;
        Wed, 28 Aug 2024 08:39:58 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e48c9d63sm1855709137.26.2024.08.28.08.39.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:39:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] adapter: Fix up address type when loading keys
Date: Wed, 28 Aug 2024 11:39:55 -0400
Message-ID: <20240828153956.861220-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Due to kernel change 59b047bc9808
("Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE")
some keys maybe store using the wrong/invalid address type as per MGMT
API, so this attempts to fix them up.

Fixes: https://github.com/bluez/bluez/issues/875
---
 src/adapter.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 245de4456868..9f44bdefa5f4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5017,12 +5017,28 @@ static void load_devices(struct btd_adapter *adapter)
 			goto free;
 		}
 
-		if (key_info)
+		if (key_info) {
+			/* Fix up address type if it was stored with the wrong
+			 * address type since Load Link Keys are only meant to
+			 * work with BR/EDR addresses as per MGMT documentation.
+			 */
+			if (key_info->bdaddr_type != BDADDR_BREDR)
+				key_info->bdaddr_type = BDADDR_BREDR;
+
 			adapter->load_keys = g_slist_append(adapter->load_keys,
 								key_info);
+		}
+
+		if (ltk_info) {
+			/* Fix up address type if it was stored with the wrong
+			 * address type since Load Long Term Keys are only meant
+			 * to work with LE addresses as per MGMT documentation.
+			 */
+			if (ltk_info->bdaddr_type == BDADDR_BREDR)
+				ltk_info->bdaddr_type = BDADDR_LE_PUBLIC;
 
-		if (ltk_info)
 			ltks = g_slist_append(ltks, ltk_info);
+		}
 
 		if (peripheral_ltk_info)
 			ltks = g_slist_append(ltks, peripheral_ltk_info);
-- 
2.46.0


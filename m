Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166691D0E05
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883641; cv=none; b=idHliQ8GJkgcO29gj60h9XLNj/wOIIP7bDSYME+20erKgNgm9vQF4ZjI3GK5ZnSr5Y26CgZ4lzaW7oK6CCtJaOg/COSSMyqrrz92NCsu8hIxa3SYVUzp2JC8xnSxPiwNvvjunusYl+LjXUNUX04tFK3SSHnMC5kD7WTIpSfXud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883641; c=relaxed/simple;
	bh=fAuXYclvrFNZVpOtQA0vf9A7D584NfG7DPp1axu3Jcw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZyXRTR1JR56jULykSsnEmwkl2nLNiarQtrxJnRsE+sbhzGWubtsqWvYOJDY6o0wg4DKDKBLalQq/OTpLhYmPv4kqeIsj6O5iSo0wzR4HopJPZkDvjooyS/N9AP4hdKhxStBPa/imyLoVbaEgaRgnmffmngCsBSv7rgmgM+V9NyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuOrRITg; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuOrRITg"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84f29f2547fso188453241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2024 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727883638; x=1728488438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0u/OwYTbGjEU7D7mktOkxJSgLNfgfqdM0ut2KMX0BSY=;
        b=OuOrRITgaVo1qbh/OtZZWvn47xZ9Fw6SuxC4h5MuqGtHOvEnN0896lCgNP5m4N4eeg
         ng3XqEo0NW2DLtH3e44GziKimYSlAZ8ZnPYq5iv9nE2RgWpyjKz3nLQP1+4a7E+tGQ/a
         oqo/cOv4L3ymfmDFhzrGgOARLMGKoZeaEX2dBWxESfBgdLG5TeBbuDCmPXV8mZCBek9V
         bOvT2soir8ebcDbtuJVmrkWHNosirWFKZQWExSS0ailyK6GlNi/Zo/6iXNToCKN1p4tu
         HdNbZoPU30xAp8fwkA+fiVHESF5TLmXYw/o8XmeRcwERM+XCfY3znB8hJOGUAhEi+khm
         wZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883638; x=1728488438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0u/OwYTbGjEU7D7mktOkxJSgLNfgfqdM0ut2KMX0BSY=;
        b=R6STPgDB0NDm7FAy90qJI8xRqXVF8/v3TBB+5hhaiPFzh7OOCVXlfIlpvFmVT/yTR1
         D/oPAfGxLWGqn3OVumlQenRmMuNskicd0bFcA8gxZoeFtmqQRjtXl9or0GMsg1jZT/2J
         RmZBkjjXS5IuDWU5l7s5ScedMAzF2TOMFsSHo2xTBToUVl+YgOgxxnFWLmTX6dC66bKK
         QowJ0xRkap2mBnjJF11iDv69+uGjvql9sNYU4NgnS7tk7J22dJSGrprdaW2mutbNFXg2
         CBx7l52DeEUvMcdSCR0exjVoqs/LE03IY3/IGTNirC1jLEYO3+DiuZZOPcqdsmOI7QEh
         WoIw==
X-Gm-Message-State: AOJu0YxHgH3ARAHASfLO6L7Buixy2TQIO3ZAIfL913FygizCqpwEM5nI
	i81TUGoyQIIHJIP4QokfSvk1vPPpA1C0ptJPiIR2YkBHFLRy37dlw18cIw==
X-Google-Smtp-Source: AGHT+IFt9cz+egEKkmwcn9Lv/k+oWwSNPahP1f/P6LSFz7fWj101OrucT79stkeFGqWv2ExGHzixNg==
X-Received: by 2002:a05:6122:922:b0:507:81f0:f952 with SMTP id 71dfb90a1353d-50c58253d67mr2651137e0c.9.1727883638048;
        Wed, 02 Oct 2024 08:40:38 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50ac01cb31fsm708464e0c.14.2024.10.02.08.40.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:40:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: ISO: Use disable_delayed_work_sync
Date: Wed,  2 Oct 2024 11:40:33 -0400
Message-ID: <20241002154034.3359675-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of disable_delayed_work_sync instead
cancel_delayed_work_sync as it not only cancels the ongoing work but also
disables new submissions which is disarable since the object holding the
work is about to be freed.

In addition to it remove call to iso_sock_set_timer on iso_sock_disconn
since at that point it is useless to set a timer as the sk will be freed
there is nothing to be done in iso_sock_timeout.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d5e00d0dd1a0..8908cf093032 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -223,7 +223,7 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	}
 
 	/* Ensure no more work items will run before freeing conn. */
-	cancel_delayed_work_sync(&conn->timeout_work);
+	disable_delayed_work_sync(&conn->timeout_work);
 
 	hcon->iso_data = NULL;
 	kfree(conn);
-- 
2.46.1


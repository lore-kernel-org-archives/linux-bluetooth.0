Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017571;
	b=HNUmb9HaPO0UavBLVRnKaSp3em0boGBrLlX4/Dtl//Z0BqLn8qPUcvHDgmFmR91wNVZy
	 wXB9WOyawB8bk0ORIZBCwkHw5aBvS4CfA+soLdoHSJPc6fRlXUXm7FFtWPmKyNfUkybIx
	 3UkPAqQfS9GpJ7He0qVCzW3iE7lm72o+Pa82Z7VG+3BseakRGOpQoqUFLno4tGOaa4Ab6
	 MTKg1drwU7QMpBuaVCNr2dPRacLM5wCPTfzv0esLW2XLK9EmZEkqSkQ+w2oCbtRabopLF
	 rkBVQ9uHBV1ZMxIngwK8oJBSSdJPk9sANuWN8QcD2GjbBco8fIV/9oy6+9osy6jOl5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lqRxdXDZwkoBIUpQiKDSxdBxhOqNT2G/FU1odLMr7P4=;
	b=0lwg7GY5naTWSaL4RiyUTIxfMXBiWof51xI39Mo2SGNiawcr0MEqlq8vI/eAtRxRBjEo
	 jkQM6vRzPcfOMy8mn78KWg59u2O3SNhYpiUWCDVhR7r7DctwugCm2e7vSaixPfoOIbE+J
	 07/eXYqmrTMqlsU97SGvjlQogIUpP94dm6oFX1ePGcVl8bVUy2IT1lSPxQbJgJd2IXR4L
	 wcxA+bL5zFulvG2WSO2w8peTTn30YixBeIusrd7/04TX8xteKJDrs0F1jZyx89ToYXTt3
	 0zQTPxMqfwAbCmOEPpYw0IreIoLHgZVvH+YW+gLjHnUJsai7c2Xqir8JgS2AYpiwxYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxJb1fYR;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AC60A2604
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 179AC60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxJb1fYR
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so834344e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017570; x=1795622370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lqRxdXDZwkoBIUpQiKDSxdBxhOqNT2G/FU1odLMr7P4=;
        b=qxJb1fYR2o36wKHQlwls3uyzVyK7SIakVTXQjRn3Oxw38gnXWbRoHSJ9T7jfT+MMWf
         0EW/rbff+kmy+hONxZx+QfsTZMzX77nBlI342DtxF8zw4lRNaSeKsAguF5cZI4FLJiqw
         kLY88VES0jo0rzNQ07oCfae8YkneKqRJbnwJzTKbxoWWz0WL93AiqVenZBLgx0RB9Npe
         /m7r/kN73HBA7D1wmlOanS+9XVXW3C7OvtRQDAt0B8Fkx5GV9k/RbYORsBV8S0YHbnIY
         b24P5vOkSHjUN9x5SnInmM7P+1CsSa+gjp3yx3dzvajLr4v/f4Ye7G9zOSbDTf4W3lK8
         KgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017570; x=1795622370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lqRxdXDZwkoBIUpQiKDSxdBxhOqNT2G/FU1odLMr7P4=;
        b=GxDtdHqJpGi/JlBa3Rrhsd1kAquNNKOgj9qkJjObr2hncCa0QV0q8cdwVW9mHZ8423
         FVRLzppDrIImys4rJD0D6nqYETjBbj2iLOnUIEEbUsVcHoAWENWpmW380r8F67P2J8Bg
         otsnJCQE6JAJA4v1jrM9kYOat4p36YRJH0EiHPv8UuMRs7UxmvQZ+BvPD0SygUNDQLMR
         lO6F+laKR9hBmRhWLTL8d82E9qOGa9UZBLW7bOai3g2xnew0Uh0v2wRylS+/8vYvo5dw
         BFpZwHXbwAh8VnwdP6wU4oQDhnCIBY7BfZsIsFv0y24RcNzPj9+qDvdvh9huiBV2Lcz/
         gvIQ==
X-Gm-Message-State: APuU4Z/wyvXdsWH8E4oCTPnEGII3wscklF/80prGiCfdid/cDnL4yp+V
	l9iCbW9UKzFScnKLJ7+396fm0U7wY/K0vgvKUgBr7Z+Uv4Ks8ozYOvZAZ/gOqEt7
X-Gm-Gg: AYBFou17wThB0tb1/HbW/zGCym1DbJ8CGTzEexCqbS6fAMJ0utuXQ1NlusH7EjPsEif
	GtFHNXFByLQwKhR87enY7zDzlnLE9ctVm+slNkJhaoK+rcYLb95I4ey9x/bBNWNSNWR6l9b/t9s
	YxAtk+BcEDcooWElXB9zw87vPHL4W5tCTE4BIqMdDX0LyNIXaTeLXEJxiGCMMX6IKdXPTa5WqTx
	g03GgZfhnVZDuPQtivb48rsKoxNlW/XESWCmOMqd8WXbtZ0aJ1gGuUmXhYPXMgOvEICboCjFoSN
	M0hQI6hrq4owAL588PDrgm3Nf71rXh5WWGZZ3bMyWYiEkfIzzhvfQsNBZbBO/KoCBwjC7+8kZjl
	+8c61jt+hOkm9ayEkDpPT41LFPyA8+hV9s0dIjPVVgstJxWKarGnUwAmvPLXG2ja1KrP/B+7asy
	IprBs1etR1SxYp0RnVbFhKyzuyCKe3anGCxK1i3zlKn2P5JqKim3mtoEpWm3s0Nlgau3mZHf5IA
	efLyHj305RPpiuNwOyvjFgzx3WeBpIGQGO71TV6JqL/OvfxNV/A1Y7C0NxsOiysrY7iGwP7T2+0
	93sM/p33POWI85Ekgt1lcB4hyz3udVMx/frlPNhAk/aQJJ2huGfILZTAoQFTTrrabBc3s1WCBdM
	NX+rGeW7VVGnh4FN2Pd8AqvUnSwGSnFFPorW7iQSXl2gQOZc1BaxVm6/3yQNCzax4rqZtihXLTN
	pa8a0=
X-Received: by 2002:a05:6122:d85:b0:5ec:d70c:633a with SMTP id 71dfb90a1353d-5ee646ad069mr1445375e0c.6.1795017570049;
        Wed, 18 Nov 2026 07:59:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 17/17] Bluetooth: hci_core: Don't fail removing a monitor unknown to the controller
Date: Wed, 18 Nov 2026 10:59:14 -0500
Message-ID: <20261118155914.178050-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_remove_adv_monitor() frees the monitor when the controller has no
matching handle for it but still returned -ENOENT, so callers took it for
a failure of a monitor that is gone, and hci_remove_all_adv_monitor()
stopped at the first one leaving the others behind. Return success since
the monitor was removed.

Found by the sashiko.dev review of this series.
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5522d4397682..024960e9af66 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2134,7 +2134,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	hci_free_adv_monitor(hdev, monitor);
 	hci_dev_unlock(hdev);
 
-	return status;
+	/* The monitor is gone, not having been known by the controller is not
+	 * an error for the caller.
+	 */
+	return status == -ENOENT ? 0 : status;
 }
 
 /* This function requires the caller holds hci_req_sync_lock */
-- 
2.56.0


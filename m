Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092623507A
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816946; cv=none; b=qOBTc0yUIZm+QIIo+RqgTMwEiGWxDH1kDe4yeZyt97wJ4mSfI5uiF81ZF+hM7ZmekjnhJf4+iKrbmTwLjmte2NRgA0yvRESw+bwXYTRPl1Aiv6x/gKfabZKABtF4PRzMOH6mP6g5UIU9OLMOzu7Yn9/VcXa/WoLvzf2Xfg1tMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816946; c=relaxed/simple;
	bh=aOW89f31Hrcq1kipE2Ko2kwWYXIrUwaDv/sAqdYMrJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5TPmQuindts9nFa7jUZaE6JWQGLu2pByEp2SYAC2aPwz2jW5CZVy7YSnwlZtr4touuwp0xWmuXf260hF4avrjzQgl/qwbR6kP2YijxFhjecFv7n7iOjaNdY/rGc7t1RK962QfVsGJe0QwoWaj4C/MPNC1B4hb4CA2Xp0ZwDxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZNMPVmI; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZNMPVmI"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-535f0912f1cso67011e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753816943; x=1754421743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcTJ8qd+ndcX5tmvk6PPNMdK7nLYtTwmMGOlND+YY7I=;
        b=TZNMPVmIuDL4YT8ettqU1p5eH1jKcoe2YluyZVYhNUVpe5eSk2PcA02LjYUrix8vat
         DNzppS661ZbGO0yKZVFq/0eMQr0OcRRr+Jn/woDLp7mjmR8N7P9eVAXwqZ+Xl14WvcpJ
         /WHXtjZvIFN7AkZZO60JljkjlOe9/nuhvTRXrVRRGheCXX42HcafiGrjnYcwl8j83Dod
         IVS/G3DLIxJNhdrm93bjYnwMvu6k305ZoYnmEFfOW6eXupn7+8dKLefYBztSjG71+llH
         1WQUB8jGCTbxW/ryCtqDxgT5KhawcAP0YPOEABWyRzDazcDHyjvBNiupjwpR4jMQ4XxJ
         E0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753816943; x=1754421743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcTJ8qd+ndcX5tmvk6PPNMdK7nLYtTwmMGOlND+YY7I=;
        b=Wfi+iLuSMde9iPAIqBTN08IU9AY/LQC7VxMVbx9H68lojuM0SfbfuQqB+FAAVSs6JM
         QZ/bAuGg4/S+cjOFL6TFQuvyCENgFhNZJsnbImVCfuu2Tm72mTzNjaK6rU1c9mOhJ+bB
         FMC3FHsLU2LX31J+bx5pLGlWst13FI7nHY7Jat+w66jy62DtOyYPZTCfhbt9dMfFJbRX
         NKYzNd1YCfmybkKpBtvMY9kzudoshwGOwaLghWO6XnasyCzuKOvMAjQEDUlAvSY9dzls
         P5BWDSXoFrAHxXDIXvdX5gw5cW1VSkrloSu+ELau3fk8gpp0sneWG1Eh80kQa3VNJHjB
         0Rgw==
X-Gm-Message-State: AOJu0YxmGIh+7nf2poqpxWdOdYypGEaQqrDjsjuuIOS/0HkJS3YN1LeP
	IdaxfZID1mlYjIm0eV7XtUjEiS2C3q7QRcMkiEwje04cYxZCFfoejDcJ2Q8zkcLX
X-Gm-Gg: ASbGncsPQrWSRTLOxskWw5aYtb8Ii7vAvcMI6zJiIzs+hmVxIwUO0QrGzMRmiJvmyN5
	BHM2DOPsFBLY2o8+IHziMCjExq5bDDUoD7XhAO7ErwFBux4AWfGN2+b/ANupC825oGLMHP5+iyu
	qAhHKamC+6rcGBbLP+Sn5RiUctwwJmBxQuCVrUR1UN894jeiY53rilxu9sm9CkJFLWz63kwN7PA
	ilSljxeqVYDateV+g6s290lISlUED5pBeJbBBPVXXleLSS9G2VDNtXMB/lAbNxABMfIZAoEroCg
	7JS6Jt6ZEB+a1vO7cUrVvBFDmFl4meF/4MMgAIfITJsQQC4bLYCJKGS4wWqINzCL9dsDjyteqiw
	kfRoKHBPWTs9R4x3AewoONIdPDr/rqTaYzuHsVkv7pTPD8pTaHvPRUn+D1R/QhKW9lKTqqBOcSM
	8=
X-Google-Smtp-Source: AGHT+IFAznF6Iitx7STempUfXNWxAHC7mbLmbnIPRaN1B+HWqFo7wb9arKRxpsQkPGgVwh1NNyXCJQ==
X-Received: by 2002:a05:6102:941:b0:4e9:8f71:bd53 with SMTP id ada2fe7eead31-4fbe7f218d1mr803434137.2.1753816943267;
        Tue, 29 Jul 2025 12:22:23 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fa46d0745fsm1684577137.5.2025.07.29.12.22.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 12:22:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] btdev: Fix sending BT_HCI_EVT_LE_BIG_SYNC_LOST with wrong BIG handle
Date: Tue, 29 Jul 2025 15:22:06 -0400
Message-ID: <20250729192206.272462-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729192206.272462-1-luiz.dentz@gmail.com>
References: <20250729192206.272462-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_HCI_EVT_LE_BIG_SYNC_LOST must be sent with the BIG handle used by the
remote peer which may be different than the one use with
BT_HCI_CMD_LE_TERM_BIG.
---
 emulator/btdev.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 5dd7d099432c..6833d4d51920 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6561,6 +6561,14 @@ done:
 	return 0;
 }
 
+static bool match_bis(const void *data, const void *match_data)
+{
+	const struct le_big *big = data;
+	const struct btdev_conn *conn = match_data;
+
+	return queue_find(big->bis, NULL, conn);
+}
+
 static int cmd_term_big_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -6593,13 +6601,17 @@ static int cmd_term_big_complete(struct btdev *dev, const void *data,
 		if (conn->link->dev != remote) {
 			struct bt_hci_evt_le_big_sync_lost evt;
 
-			memset(&evt, 0, sizeof(evt));
-			evt.big_handle = cmd->handle;
-			evt.reason = cmd->reason;
-
 			remote = conn->link->dev;
-			le_meta_event(remote, BT_HCI_EVT_LE_BIG_SYNC_LOST,
-				      &evt, sizeof(evt));
+
+			big = queue_find(remote->le_big, match_bis, conn->link);
+			if (big) {
+				memset(&evt, 0, sizeof(evt));
+				evt.big_handle = big->handle;
+				evt.reason = cmd->reason;
+				le_meta_event(remote,
+						BT_HCI_EVT_LE_BIG_SYNC_LOST,
+						&evt, sizeof(evt));
+			}
 		}
 
 		/* Unlink conn from remote BIS */
-- 
2.50.1


Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2E12FF95
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664165; cv=none; b=gsxRRlp61A+ZUTMi5/PuKPJB0jdoAITeBD9+4q78qPeGlOR75Hj6JWXA3J8PKECZzo2BnN5rtrXCx9EJFe9euEJRwvauVmGtGshwJueLEzRarSSc571v7hzuFN8cK5qMwaj/cPzQsQbM3NcWr/q5PDEVgvphZ6g7TZ15B8poIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664165; c=relaxed/simple;
	bh=BLrcB0xvkRp97h3Y7JA/rQisnKyHGDUk6UJg8ojHYwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DE5SXYcFZXPFs6mLL4zGCNnJeHcscEDas32sClcu1MwzfHQ8+lgG90QXr08Z+ayXA6SPw6DFMAYf/no8qjcKvGAjigFfpUo4/9gXia90Vkl3q4Il8VdI7JHA5Ja+Fol9C9Q/5DL5+LMn6Ew3RCFTl9lt4MTkSMvL2xAvg5p+i2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebxAR7KS; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebxAR7KS"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609eb3e5a56so15436937b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711664161; x=1712268961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9WKKkGmnpN0qC9dNhYNKhwuDy4qRvWLmyIA6UhgkLhY=;
        b=ebxAR7KSJash39xibpUxxjG62wmcYbNcmMDI+3e6VX+FNHARjXXho0XHq7zTZAUeb4
         b7YOO2ET5Og0AjC1PoThU7LRMakXmK5Rg+zTywBp/Ju82PVMxuew/rwgYlV8il7CXp60
         tCcqtFzHd8uv2vhHELzMFUjx5AJcXNl9Ah11Kro7yPQbBUcqjyLTC1n4iEiX4mZaYQpV
         3qAQ+JLaOHKKANZ66oQ10jX0Q4NwTOV+3sgCG8IdJ8gmUYSsuma8mDMCG482WjTZGzDr
         cqMNnij/gyM4xCUrdlkomxC3gi9yVmjihA+FHN+CK7rLgYet26XSz25xKJLGnL4DqdMx
         NQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711664161; x=1712268961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WKKkGmnpN0qC9dNhYNKhwuDy4qRvWLmyIA6UhgkLhY=;
        b=DqXRT5uUtKLqsPC4BPI6g2GY7kZ3BUs1JeVWZuOH+8ztcCI/n05W5vdzhFGesvuBTO
         GS9jGv39Rtu4vMEDXdP7Pk1/6q5h4ApRAyvn+PeDfjYrr7+kTvv7O826WErfE9CNSyPU
         igudn9KkgSR+mawME+6f8J8gN68fbdGI+oebNYZIpGawvWVUmbVfzj6VKRtVOuQazEbd
         eXVBL18Ld/7o/Qz/2pK0Y0hQc9/Z9+fh9aK4fRz8glKEJ6FnqaiYC4eQXrpda/HMzvuO
         kbcaSAGwDFfjuCt7kMbY6iHcprCFlyl+v50LLyjZiDIHL4kxYJkx9R2X9IyAgyCZIzTF
         errg==
X-Gm-Message-State: AOJu0Yzyp2rPdY8iYCuBoGdyU0ZCDXAEWOQsRHD4RCaFrf0Czm3WBhVM
	iitmNfDK8JiFKxQD0EtQJwRSJdg/t3hdETYFw9RPXGS/I7WNngD6MK5r61i2
X-Google-Smtp-Source: AGHT+IG/lUTTs52vgxu5q9lWqSTZv+jyHIxVTw1BKzJIzCnxfDZidFnLys/rTrboUB40BnI4OCJrTw==
X-Received: by 2002:a81:4897:0:b0:614:2bb8:51c5 with SMTP id v145-20020a814897000000b006142bb851c5mr798797ywa.41.1711664160850;
        Thu, 28 Mar 2024 15:16:00 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id c11-20020a81c94b000000b00610eaf46c6dsm516031ywl.117.2024.03.28.15.15.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:15:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Set DISCOVERY_FINDING on SCAN_ENABLED
Date: Thu, 28 Mar 2024 18:15:58 -0400
Message-ID: <20240328221558.1904865-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure that discovery state is properly synchronized otherwise
reports may not generate MGMT DeviceFound events as it would be assumed
that it was not initiated by a discovery session.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c  | 11 +++++++++--
 net/bluetooth/hci_event.c |  3 +--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dde333d9cfc1..e436737ca505 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -149,8 +149,6 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 {
 	int old_state = hdev->discovery.state;
 
-	BT_DBG("%s state %u -> %u", hdev->name, hdev->discovery.state, state);
-
 	if (old_state == state)
 		return;
 
@@ -166,6 +164,13 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	case DISCOVERY_STARTING:
 		break;
 	case DISCOVERY_FINDING:
+		/* If discovery was not started then it was initiated by the
+		 * MGMT interface so no MGMT event shall be generated either
+		 */
+		if (old_state != DISCOVERY_STARTING) {
+			hdev->discovery.state = old_state;
+			return;
+		}
 		mgmt_discovering(hdev, 1);
 		break;
 	case DISCOVERY_RESOLVING:
@@ -173,6 +178,8 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	case DISCOVERY_STOPPING:
 		break;
 	}
+
+	bt_dev_dbg(hdev, "state %u -> %u", old_state, state);
 }
 
 void hci_inquiry_cache_flush(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a8b8cfebe018..a6cc910ebc28 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1779,8 +1779,7 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 		hci_dev_set_flag(hdev, HCI_LE_SCAN);
 		if (hdev->le_scan_type == LE_SCAN_ACTIVE)
 			clear_pending_adv_report(hdev);
-		if (hci_dev_test_flag(hdev, HCI_MESH))
-			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
+		hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 		break;
 
 	case LE_SCAN_DISABLE:
-- 
2.44.0


Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A6394781
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951818; cv=none; b=uq2SR7YLOPkZ9cbNofgnpMKqrlVAA2+i9ePU/14/Af3bnmEzr2Zf/tmT4aC3cVaqn0TOxw06Ff1zw3x5EPz6JrH9xwrJNodiD346mGv4uscUatnWTZxOp9lLTXLLlvP7G5uvaDNYN5g59cGMN6pcH+W6HlrBxwifrAV9MYwA3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951818; c=relaxed/simple;
	bh=Eyg1qB2ND87UDt906F754+98uqFJDo32cPIehCum+K4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kpCL+3Y6NxWZENFLFBAxHp+NTPB/8+36RZwy7f8P9XTSup/XGDTU2/j2g1sfho43/H0o+CHgzF3b2tuviNnyahtlrtPNBLh/1av+iMIUtWlNJynQ5t8nP/YGBKUUe8QJeD49UZuJL/v5AlKe8Lf3Th48NFHONmphLSsdvS5g6JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3NnGSmc; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3NnGSmc"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59e8ededf4dso2836983e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 13:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951816; x=1781556616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4P1rDIEAfUnl32MCrkVgll/XBzPewHEIJLxrECzq6M=;
        b=k3NnGSmcSU3Vicad1ZJ3Y/ojJ7XvaQuWiCg4iuvqINKjIiSjsRx0yhiIE6le8xCq7f
         vEms2mB6pXpDH24IegEbbWYJYeZmiYdh/2bdgnbpa4+lcq02Hkx9WkALAnALVFmJ+2P4
         44yk+3PMPVJitC0EgJEG5OkGZyGfVDohxJfmY2mFsUvlyryeHfzPlL9dr+sSNCxphacX
         ZIXx6fve39kPdSnPyuj7lg+ZYwOaA1+jq6WscpBeocnpB3AQt/nCKasthPZ3iCcqdUMs
         OZAppOkbNVTjQN+5aYS5MpHy48ZH79gzzZmJzIPR5+lpq4c9J/ZDKP/CV/F5YKPG3SnJ
         82UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951816; x=1781556616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4P1rDIEAfUnl32MCrkVgll/XBzPewHEIJLxrECzq6M=;
        b=f5yax1s1hnnwv9zQHNFMs9nwyxQJ4icHHvzzWvsNv53sjRGnWDQnv+Sx5rdzEe76Rn
         AAnl2fJ6SfQ8IzMQcrWJfRmJQeznhw5LHNj7yqRHtWA5Tg3aHYNopMobqWj3Yt/yB6rh
         HwbCLUQtRh+Jz8kp31+lFmXdAbDUu8Z+e0mtX3oIC3H9qoftRtyNjg1vC+HrzD5/kNjI
         aLX1zwjIG5OYSmqdKk0zCpHmKMBzBfChs5zdrmZkazt3Tihr1Tv4JF//s1rVnILT38kU
         VtHSabeMtKb4Ia6w7QlqTbtI1BCYbYViVMhuo5QzWa6Cy5rGoVVuZKsIiSabWD1k5fDd
         NztQ==
X-Gm-Message-State: AOJu0Yyb02+ZARjxGvIEM70VsSopkEpX3sHTG8ZplHCpVgpLwGIl8lfC
	J0iXwCtkA611jKfRAEqaA36z4HRdmdf2JOs++NgVNrZ90GrGbOVm1zrD5/OtkYEo41U=
X-Gm-Gg: Acq92OGEMpxvVK6DsqgrAhz5KdHWif3NScYVWzNXulADQcHrqVBfur+QqNIe6BVYuH8
	XIZpPmwFsHd4EQKb5gLSo/eEytNRtxFDv4ws3MD0u87ZK/AbvKf00mJKMmQh/yNz1ODZjr4bAoP
	JVA6pi3dTXs3OUOSJyiO+dJRWKl3BC0/EL/SXteyHqy98FLPLzI7TOpr373KgjQI3v8ZpLGYO0A
	MrfCYkgWmPdqRO1PzlB35YQ5mbxekFD8wyeYLzSqmEm4sQsFRmTCxBnsK9Vg0IjNx9ci2SHVUJW
	AfHq6xWSxalmquw42Dq6P3UVvIURG8mRifF1qf+uWUbpIjGKi98gz2ziGOBswoLyxUPkBcw2ZM9
	STXzU0Kzkap8ZNqf0JLoPlM2WqYv+ieaiXv8hqRZHDrUGdWqJKXiEZVp9F/xP09n1ZMoHDrE//f
	wyYktyK9IDvdSDgITOWBur5zCx+6eOJKOkKNZIOp2ZgAQTgHPt6PMbWWqt/Z8PgP9ea4teTYCh/
	lKikvKlEMwB7q8yum4xrFNE+cpU
X-Received: by 2002:a05:6122:134c:b0:59e:71df:c64a with SMTP id 71dfb90a1353d-5ac56d63fe1mr8476481e0c.10.1780951816133;
        Mon, 08 Jun 2026 13:50:16 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6ddacc48bsm15679545e0c.18.2026.06.08.13.50.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:50:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/hci: Avoid redundant BPF filter updates on duplicate events
Date: Mon,  8 Jun 2026 16:50:08 -0400
Message-ID: <20260608205009.97585-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Skip updating the BPF socket filter in bt_hci_register and
bt_hci_register_subevent when the event/subevent is already
registered, since it is already part of the filter.

Similarly, skip updating the filter in bt_hci_unregister and
bt_hci_unregister_subevent when other handlers for the same
event/subevent still remain in the queue.

This avoids unnecessary setsockopt(SO_ATTACH_FILTER) calls when
multiple handlers are registered for the same event code.
---
 src/shared/hci.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 40326fc810e6..1aba7db1d995 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -765,15 +765,28 @@ static void update_evt_filter(struct bt_hci *hci)
 	free(filters);
 }
 
+static bool match_evt_event(const void *a, const void *b)
+{
+	const struct evt *evt = a;
+	uint8_t event = PTR_TO_UINT(b);
+
+	return evt->event == event;
+}
+
 unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 				bt_hci_callback_func_t callback,
 				void *user_data, bt_hci_destroy_func_t destroy)
 {
 	struct evt *evt;
+	bool update_filter;
 
 	if (!hci)
 		return 0;
 
+	/* Check if event already has a handler registered */
+	update_filter = !queue_find(hci->evt_list, match_evt_event,
+							UINT_TO_PTR(event));
+
 	evt = new0(struct evt, 1);
 	evt->event = event;
 
@@ -791,7 +804,8 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 		return 0;
 	}
 
-	update_evt_filter(hci);
+	if (update_filter)
+		update_evt_filter(hci);
 
 	return evt->id;
 }
@@ -849,6 +863,7 @@ static bool match_evt_id(const void *a, const void *b)
 bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
 {
 	struct evt *evt;
+	uint8_t event;
 
 	if (!hci || !id)
 		return false;
@@ -857,9 +872,12 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
 	if (!evt)
 		return false;
 
+	event = evt->event;
 	evt_free(evt);
 
-	update_evt_filter(hci);
+	/* Only update filter if no other handler for this event remains */
+	if (!queue_find(hci->evt_list, match_evt_event, UINT_TO_PTR(event)))
+		update_evt_filter(hci);
 
 	return true;
 }
@@ -871,10 +889,15 @@ unsigned int bt_hci_register_subevent(struct bt_hci *hci,
 				void *user_data, bt_hci_destroy_func_t destroy)
 {
 	struct evt *evt;
+	bool update_filter;
 
 	if (!hci)
 		return 0;
 
+	/* Check if subevent already has a handler registered */
+	update_filter = !queue_find(hci->subevt_list, match_evt_event,
+						UINT_TO_PTR(subevent));
+
 	evt = new0(struct evt, 1);
 	evt->event = subevent;
 
@@ -892,7 +915,8 @@ unsigned int bt_hci_register_subevent(struct bt_hci *hci,
 		return 0;
 	}
 
-	update_evt_filter(hci);
+	if (update_filter)
+		update_evt_filter(hci);
 
 	return evt->id;
 }
@@ -900,6 +924,7 @@ unsigned int bt_hci_register_subevent(struct bt_hci *hci,
 bool bt_hci_unregister_subevent(struct bt_hci *hci, unsigned int id)
 {
 	struct evt *evt;
+	uint8_t event;
 
 	if (!hci || !id)
 		return false;
@@ -909,9 +934,13 @@ bool bt_hci_unregister_subevent(struct bt_hci *hci, unsigned int id)
 	if (!evt)
 		return false;
 
+	event = evt->event;
 	evt_free(evt);
 
-	update_evt_filter(hci);
+	/* Only update filter if no other handler for this subevent remains */
+	if (!queue_find(hci->subevt_list, match_evt_event,
+							UINT_TO_PTR(event)))
+		update_evt_filter(hci);
 
 	return true;
 }
-- 
2.54.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9041B8F2
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663153; cv=none; b=EYVlW4gWhF3/StFX7qe3zS6iNAtbZXM6tXOvCAg1pFqwcSh2ZQaKEqCOh3i8js8VRFCnpR1afHoQlWcqKi3GJ4B1MQ3Z6Lky+8kUufgA2AV3ZKfJ0JORjnTYh8PYyc8CYPKdJNUl/sziQL7XMTQH+EHCiAp7+GMrio19rPADgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663153; c=relaxed/simple;
	bh=ZsgL4M3YF1Y3RKMtQViho/zrcHo+wocUcsFxHJCw+gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AoQ3oiVjc6p7Om3i0yZ4xWxn6SpufJPb+DNy4v3YZpx967JN/kutDpiAONm4nlrnOBs+ta6mK4Hs3VMzwzyj7gYvvVmwtBt99gNPdlTsYy7b8f5LC99AUhVy7aMN4F+o+z7DVhkMTCKf/X2dw8lf6Ua1XBAOXrgn8BGWxPfx6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMs6Y3je; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMs6Y3je"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790663152; x=1822199152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZsgL4M3YF1Y3RKMtQViho/zrcHo+wocUcsFxHJCw+gs=;
  b=GMs6Y3jeLqe3YoPSTwSHI8MaDRUmJtlJ/ukDHIUXn8aNrGDIJW5MuWQG
   rGJcg4oP7w6qrL0S1ieOnB7JWlH7hVr7dMMl8/Xwya/YX4VUompTSLFlA
   80ZegNlKRwnDVAoVF5x5uVcPFPSgkgaU8jVIdEEPmhSrTR4hwUu6CJowQ
   LYbddQhbhBvv30pp1ak13M5bfBeUll+H4UeSaAYUbLGOujBKNEl3OIbCM
   +H6I7m5RhyS+BapInfWttRFGTVFU6s4UIhby4kEvceeIA/mfE4JvlgDkF
   b4qeuIV6LxGis5Q87GvAo1PquN4YNTzTzhdeBa7WB0GJonraZLEWnudPt
   w==;
X-CSE-ConnectionGUID: 1icOPa6nRkOUFet6hOMsmQ==
X-CSE-MsgGUID: PqrriP4rRmabRMy+hXyVGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101538342"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101538342"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 23:25:52 -0700
X-CSE-ConnectionGUID: Dr9wOnjURJ+Fz27UTqSeYw==
X-CSE-MsgGUID: PSfUqSXjS1OCCsW4DW9uiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="279101476"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa005.jf.intel.com with ESMTP; 28 Sep 2026 23:25:51 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btusb: Preserve event and ACL packet ordering
Date: Tue, 29 Sep 2026 12:15:56 +0530
Message-ID: <20260929064556.1461915-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When force_poll_sync is enabled, commit 800fe5ec302e ("Bluetooth:
btusb: Add support for queuing during polling interval") defers ACL
delivery to the RX worker. The event path currently wakes that worker
before delivering the event, so queued ACL data can reach HCI first.

Deliver the event before waking the worker. This preserves the intended
event-first ordering and the event callback's return value.

Fixes: 800fe5ec302e ("Bluetooth: btusb: Add support for queuing during polling interval")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btusb_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 1ede12515bcc..cccdfb0461fe 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -1311,13 +1311,16 @@ static inline void btusb_free_frags(struct btusb_data *data)
 static int btusb_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	err = data->recv_event(hdev, skb);
 
 	if (data->intr_interval) {
 		/* Trigger dequeue immediately if an event is received */
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
-	return data->recv_event(hdev, skb);
+	return err;
 }
 
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
-- 
2.54.0


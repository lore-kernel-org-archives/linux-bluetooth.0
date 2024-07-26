Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7C17920C
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989745; cv=none; b=HP2mmYEUY8bwAo+LNDVHYif4utL7OwMhgE5tHt1LRIk+x9t7d/uGqvQ9SNesvwyy/lG6cfq1SIlagNP/Jl0TSArFXc5aj2AUQbzrvhjOg6ebz0Uua4boxHQRQ4cIsnNRY6YE8LxbxMHJAcCA1/WMCf1lrdmkAyuBDYcrgqCfAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989745; c=relaxed/simple;
	bh=j1qwJSx6p/LG5LI0UGfU+grmrYpHECObcu3Y9ArejE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RG8MFli0XFLfDpW9pANAcy7Qhc9fUEjV3ci2UtTHE8Fgc17yJlXE8qUupD/OTj4GvNTyTenlsGzQskmWZ0CWrA5FKGMmWKDQPzPA2y+BxvJpb26472tJ+s7za9zLBDNlbWekLFh2ZPkRDPc48vFZyYBMAxXO1jNoR9FhiIIII80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3G5cNh+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3G5cNh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721989743; x=1753525743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j1qwJSx6p/LG5LI0UGfU+grmrYpHECObcu3Y9ArejE4=;
  b=e3G5cNh+wPuhwhJfxDj4CsV9vJorLcsYQzRkxrqloWoLyFrkwsdqi/G8
   qU4Cj7Y6izw4SEWAkxH9ZVfAmOKNwEzZkym7SN/C7ZaC+3eJA6RMvYWO5
   ahpR+sVTBwFXKfimve2XbjGtOuR7Aj6e7ocWm/O1/ro//zAmyEOYKkjqj
   yaald0riYwDiuzTMMSahZiLH3vinNgv/QGrQzGinvsgruWmIZoGusRf4w
   MYwqXRlZofeJ5z6RXKtMQnVjlM3JUxA76g/K6eJFghbNCpCRWKZCimzGE
   V8Y9eKXNIngO8VzXQVI02bwxZNmGDIF3v+C71JOPTefVHu+hH3fFiT17r
   g==;
X-CSE-ConnectionGUID: kxwvK9gCSXSPz4TaDB3TCg==
X-CSE-MsgGUID: BwzvSv+xQLibKln701Yvvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19575417"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19575417"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 03:29:01 -0700
X-CSE-ConnectionGUID: TQF7D35vTKqTINO80TY1bg==
X-CSE-MsgGUID: dhwXXznUTYmwaKYgwfIhyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53146352"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa010.jf.intel.com with ESMTP; 26 Jul 2024 03:28:59 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/3] Bluetooth: Add tx/rx counters to track iso packets
Date: Fri, 26 Jul 2024 16:13:25 +0530
Message-Id: <20240726104326.459668-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240726104326.459668-1-kiran.k@intel.com>
References: <20240726104326.459668-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add counters in hci_dev_stats to track iso tx and rx packets.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 include/net/bluetooth/hci_sock.h | 2 ++
 net/bluetooth/hci_core.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
index 13e8cd4414a1..98991a11844a 100644
--- a/include/net/bluetooth/hci_sock.h
+++ b/include/net/bluetooth/hci_sock.h
@@ -101,6 +101,8 @@ struct hci_dev_stats {
 	__u32 acl_rx;
 	__u32 sco_tx;
 	__u32 sco_rx;
+	__u32 iso_tx;
+	__u32 iso_rx;
 	__u32 byte_rx;
 	__u32 byte_tx;
 };
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a4ebd93adfc..b0d40b62238b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3858,6 +3858,8 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
 		   handle, flags);
 
+	hdev->stat.iso_rx++;
+
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
 	hci_dev_unlock(hdev);
-- 
2.40.1


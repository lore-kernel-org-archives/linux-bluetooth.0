Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8A17920C
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989741; cv=none; b=iQ/HCw4LUwTOuU1C+NWjUEm+Qvbo0XyGIlSBdKc1iDQfFUJrUxoaqLyUjGr2CPAUEc39tv5HUfs2cdM/xxzuscSwuW+p/fGvCqMRjW27o/U2YSxwh08lIgOZHm9uCezbGbR9/2zJiqC6866/J57WXQFzOTS8QVlQaAhj6bk41bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989741; c=relaxed/simple;
	bh=aRd3sBsAWCMSsciIU23Y1I4LkWdDP/r3dXjmiFW7xh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WrTq+AAYAPW0csiks/R4sR0rDHpkll/6wDZ17HuAT9m8VxgbXGlSTI9EnqF8umw337+ZChR++k5EzW/urqVx8Jwu1ulWQ7sFqxs+XAoEkeTpm+iWuvf+PaFG8wcQq/FUTmHsjTUgCmy7amPFOg42Incc95jobEHNKtRKofjAVIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWvJzSBa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWvJzSBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721989739; x=1753525739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aRd3sBsAWCMSsciIU23Y1I4LkWdDP/r3dXjmiFW7xh4=;
  b=RWvJzSBavrUpEMtpjchUG6csEM1kwbDQByKKbOe1Yv0UCXVKFE+WkSWs
   HJTp7Myeir+C98bwE8maSzUJeSApAZwlPdDzZgTWL3X2bS6TcSgFR4z3w
   lrBtHMg+axHsXmzfpQUz6OR/biiWl6Qzd1A6jgTZVz7mnh/xlCg6SilGZ
   M8yqJHg5OeGLwAK4uP776WC96zWxyAjUItIvajP8hDnjrTKJWaBT5jL+3
   rE7wPy9DdvpuVXKQp7xQXxQAmrAqIxH4kNUXU86rNrAYZVFIo2+4eBCBa
   8exD9qZ5QOs9lklXffjSTJJJZhu/XkDESVp3M723hN+d5c5Viv9zPxGcE
   w==;
X-CSE-ConnectionGUID: X8NmGpa8RaSODmgDKbb8qw==
X-CSE-MsgGUID: jGjSrb5sSz6gaAEGygVR1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19575412"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19575412"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 03:28:59 -0700
X-CSE-ConnectionGUID: R7iKY0OcRJ6h3ae1SK6ohw==
X-CSE-MsgGUID: OX1xZQ/qRtOgLIGVvJE8vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53146335"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa010.jf.intel.com with ESMTP; 26 Jul 2024 03:28:57 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/3] Bluetooth: Add a helper function to extract iso header
Date: Fri, 26 Jul 2024 16:13:24 +0530
Message-Id: <20240726104326.459668-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function hci_iso_hdr() to extract iso header from skb.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 include/net/bluetooth/hci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e372a88e8c3f..ace5d210af38 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2898,6 +2898,11 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
 	return (struct hci_sco_hdr *) skb->data;
 }
 
+static inline struct hci_iso_hdr *hci_iso_hdr(const struct sk_buff *skb)
+{
+	return (struct hci_iso_hdr *)skb->data;
+}
+
 /* Command opcode pack/unpack */
 #define hci_opcode_pack(ogf, ocf)	((__u16) ((ocf & 0x03ff)|(ogf << 10)))
 #define hci_opcode_ogf(op)		(op >> 10)
-- 
2.40.1


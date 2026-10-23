Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792735335;
	b=kMFX696R7u9KrsvtG/UMENXdF7CQcq7yET9vjXj+ed15GUB/+VOYhOl2h5gdvMoi5DgQ
	 5cRaxwDrGNYMSpwJjLCtJxCr/L41HFHea11sgw7QEfM2Xo+Db9yI+0VMmVwZt6aBqQxbg
	 87U7jOJ7h/L+rxzZYgxanBGHOoT2PeogfNDCMxeIl/Zu6UVRLfLGwjaJGCPykAvF0Ji+T
	 by6S+HPhDweeOvYD0a2hH711xlJMJkt0suEbS4wkJD2XzKDslC+Qpntf4/QgP97ajPM7F
	 59VXa+xrZ8VU93vjYDAK/S9x+ZyWk/SIjNT3FgAMy+2FXQVD4ACQhNaoCAPX9Jwz3aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792735335;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vr/TEe5feds57ySTwJLh+pe6Fh6pOxYmxBA+Vu5KA54=;
	b=T5mOWDebsoK/mPzuAvCwE129+fjQ4fD8Fat4yEZeDTa+74Y34iHKLVHAHHxbdqoQpQaO
	 Z4gM+GEhyfpmNbWs05185eyh4CLIQedYIO5R9hNP68g/6tVwqzr3r6L4LhNrpWHWiyJXM
	 am3XVxIqjFcEroSE1Q+OdhofPeWMQnGJltTILvrNq0mKWW/20n1Wkd1xW4lGB4aEwS2T7
	 j4lFY6G/EprNlYnPa3IBAzCKBnS5DTivC+DmSt7kaXSJWL48bFtYr3z632WbML+M1Sk6d
	 QR1fvkFdi5DG70x6t6PN/O9D8/AaGoS4+i6zsW8rOzF1soZ1IxY6ybJFq5GMvocoP7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FAZuTchq;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD79606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 06:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DD79606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FAZuTchq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792735333; x=1824271333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nIvHaZ5/n6m75YQoJlVs5boj0x4uEAXJgthG3uxQxj4=;
  b=FAZuTchqs0Unv3XQXTpIPP9Df4rASpVkVOfVo0lrmURj7tpMwDPIW1pO
   VfrrqR6LTb8OJqJTIfEPozJIeP7HBtqzxsmnLkMbWAW+VO1smTuAfe9+H
   0torl7E5hG+mamtD/s+ypEKlcvHnLHDoAeRvirbdQv59R2Vw6rvUI1wgG
   JrDEh5u7bZuQoZGcGXH3xP6Eqa5JRhCl3tlvAO96qnLzgWYBTF4QjbPtI
   oosCWTDnAGVXIsvAFSk/t18/OPQvrip/RAcnB+JoBhlt0zAm3EiM9wHvd
   RfCkpQ3UOhVKrXc0sI2xV0XKrfFU3KF5BPHd+SYfoPCIk4Z97l3mUkG4r
   w==;
X-CSE-ConnectionGUID: 4RRVr+caQja459j2olsjrQ==
X-CSE-MsgGUID: 5HPWt1Z/SLqPgK+EiPxuSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1506573"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1506573"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 23:02:13 -0700
X-CSE-ConnectionGUID: FNbzaeAeSout13S3VfEm9w==
X-CSE-MsgGUID: h4JdkmQyTvGWWHkq4SSFtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3559705"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by orviesa004.jf.intel.com with ESMTP; 22 Oct 2026 23:02:11 -0700
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: fix buffer over-read in fw payload
Date: Fri, 23 Oct 2026 11:30:26 +0530
Message-ID: <20261023060026.524147-1-catherine.l@intel.com>
X-Mailer: git-send-email 2.43.0
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

The firmware decoder cast fw_ptr + frag_len to struct
hci_command_hdr and read cmd->plen before confirming the
header and payload still fit in the remaining firmware
buffer.

Add explicit bounds checks before each dereference:
1. Reject if the command header is not fully contained
   in remain.
2. Reject if the full command including payload exceeds
   remain.
3. Log the offending fragment length and remaining size
   before returning -EINVAL.

Fixes: fbbe83c52bc0d ("Bluetooth: btintel: Create common function for firmware download")
Signed-off-by: Catherine L <catherine.l@intel.com>
Tested-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index f298c91f4f4e..d245fe4fb1e9 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1185,7 +1185,29 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
 	err = -EINVAL;
 
 	while (fw_ptr - fw->data < fw->size) {
-		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
+		struct hci_command_hdr *cmd;
+		size_t remain = fw->size - (fw_ptr - fw->data);
+
+		/* Ensure the header fits before dereferencing */
+		if (frag_len + sizeof(*cmd) > remain) {
+			bt_dev_err(hdev,
+				   "Firmware buffer overrun at header (frag_len %u, need %zu, remain %zu)",
+				   frag_len, frag_len + sizeof(*cmd), remain);
+			err = -EINVAL;
+			goto done;
+		}
+
+		cmd = (void *)(fw_ptr + frag_len);
+
+		/* Ensure the full command (header + payload) fits before use */
+		if (frag_len + sizeof(*cmd) + cmd->plen > remain) {
+			bt_dev_err(hdev,
+				   "Firmware buffer overrun at payload (frag_len %u, plen %u, need %zu, remain %zu)",
+				   frag_len, cmd->plen,
+				   frag_len + sizeof(*cmd) + cmd->plen, remain);
+			err = -EINVAL;
+			goto done;
+		}
 
 		frag_len += sizeof(*cmd) + cmd->plen;
 
-- 
2.43.0


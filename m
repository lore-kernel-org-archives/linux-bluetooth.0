Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47E5349C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082692; cv=none; b=OxnbSXSUxEe1GfZHbCjNaHjGWO0VVCDxBAi7+uxf0ag9bK8I7H9KpfwM8jUuE7PEdAAausczM1nWigysOhgJZhc+fgGV6mhsvcsVeXVwTwFmI9teD8vG6+cDr0WfW+NQ+ARB9XjCGjBFSd3jnJSazEjblqXzFueKt7y95jGCJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082692; c=relaxed/simple;
	bh=z4kkF8/Lvnog9Owrxjrpa8QleGZmU5DBrqMytFtD4K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4r6dxuExPWkG0PnQwcJ0q2zP0M9zjD1EBT1LIy5OPUXQHzIRl/P3ocRUShKLChrcGa2i0YFbpWr13jcvGFRNH0MQ1SfUWuh7E9o5YK8MQJxhn82/MPyNPpLRi3db3ijgQsj6ZL96EDilBKB4OTfRVEpcrarYYgwgxmfZg/f4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ufe6Qdu3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ufe6Qdu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790082689; x=1821618689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z4kkF8/Lvnog9Owrxjrpa8QleGZmU5DBrqMytFtD4K4=;
  b=Ufe6Qdu3Kq0BvUt/3OLYEd7jl1HYc4xTcRuBzL1lKE6wIbcP+FYkPUld
   GdQe+oUmr1+PD813D1SglzmcBVnCLo4gS5/bYvbJbB92M3zDJVCjC8nvR
   OYkDj/R8aylgnMhh20vFRAD820VxUvjdOJ8X7zZPcO/Rz4D6FvJis806Y
   LuEaAlPAHFnVQxdE9t03zh+rTzdQ9u9919xPAaFX/YjyJjFF1KLnlEwbn
   /pbZhCApezwLkdGqywnVzJiYgJQ4tS/iPzYNDu0em4Kgrn2saliJrE/0R
   JuEew2SttxyYXnkS8yVbS6iRAgOX0Q3jqrhabthMSoi4HpN0ESpKuKdWr
   A==;
X-CSE-ConnectionGUID: xUnAQlXWRF2tr76H88ZT1w==
X-CSE-MsgGUID: xEYc7ySDTnmA2whNGpJNeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93185781"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="93185781"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 06:11:28 -0700
X-CSE-ConnectionGUID: QExQgIlHSXKgPWMMzOCNxA==
X-CSE-MsgGUID: SJSHAGD2Tiq6eAFXPj00oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271700637"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa006.fm.intel.com with ESMTP; 22 Sep 2026 06:11:27 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: validate DDC record lengths
Date: Tue, 22 Sep 2026 18:33:11 +0530
Message-ID: <20260922130312.24749-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse DDC record lengths in unsigned storage so 0xFF does not wrap.
Reject records smaller than the mandatory three-byte header, records
exceeding U8_MAX, and records exceeding remaining firmware bytes before
issuing Intel_Write_DDC.

This issue was reported by Claude Mythos.

Fixes: 145f2368c5fd ("Bluetooth: btintel: Add Device Configuration support")
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
Changes in v2:
 - Addressed Review comments of v1 and updated commit text
---
 drivers/bluetooth/btintel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e6d1ddc99c6..b05eedb2f5a5 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -409,8 +409,16 @@ int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name)
 	/* DDC file contains one or more DDC structure which has
 	 * Length (1 byte), DDC ID (2 bytes), and DDC value (Length - 2).
 	 */
-	while (fw->size > fw_ptr - fw->data) {
-		u8 cmd_plen = fw_ptr[0] + sizeof(u8);
+	while (fw->size > (size_t)(fw_ptr - fw->data)) {
+		size_t remaining = fw->size - (fw_ptr - fw->data);
+		unsigned int cmd_plen = fw_ptr[0] + 1U;
+
+		if (cmd_plen < 3 || cmd_plen > U8_MAX || cmd_plen > remaining) {
+			bt_dev_err(hdev, "Malformed DDC record (plen=%u, remaining=%zu)",
+				   cmd_plen, remaining);
+			release_firmware(fw);
+			return -EINVAL;
+		}
 
 		skb = __hci_cmd_sync(hdev, 0xfc8b, cmd_plen, fw_ptr,
 				     HCI_INIT_TIMEOUT);
-- 
2.53.0


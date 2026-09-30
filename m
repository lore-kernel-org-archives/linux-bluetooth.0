Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1A4570EC
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754646; cv=none; b=RG4CG1LJgCp57nxJq2FENqdKO8rJpWkPwcTD1jgGyasyyn9xnaR2OxQDWD6jmgrC/oKbeOJEHwSDsgJFxJkLMPUfdwuKylfUHD4E0Z8uTN2D8OUxvsFzH5PtvefilnlEwRVMyTnYKGtwX/8Zy5oKTFbaJ4pwQ8HI7t4CL6HFXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754646; c=relaxed/simple;
	bh=wu58jZ7TG6k7oadhtVivXgRcqvegAsRT6RGtUTQYlnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuT/MER82rRcGbYWSzjZbQ10iIdeKMWJ9x5U9oI9mH3CWDPUXL+ZUDpira8WrNVrqny+DWSGf0tKKMUQJIikLUxw367tCzTb/6INqp8l4zsYukKPWm2IzsFAwr8VJXJ1NFtlFflxwVtWeNpTXhwEFgorwvfGJ44XtcfqwSZqnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDgViNaf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDgViNaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754644; x=1822290644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wu58jZ7TG6k7oadhtVivXgRcqvegAsRT6RGtUTQYlnE=;
  b=WDgViNafSLmxpwzpcZLJRwOpjLX7fDPgUSHJ4hv/8zfJ5pv4OnsHk0B+
   5fJGKRHOIFwHIBk+qXpqEQCUKgsaIYh4gOHTVTYz4CtF+GS1tn37IC1nK
   wxngz0FdHwGl+O68Z14nAo8PJcRMQHvgAsxbNwiUGHJ6Emz9N36zroaC/
   2TI4GcMe1r4f2LzFPwxU7j5RXIqYFrU4MvefYF+vuKqbxbx83QPLU6m1e
   qS0iRkVHg3N6AjdDnjY2holUv9kQEr+cIg2CtDQhdptz7Gtn1fAlGHH70
   Y4sHd+r7m2hgimfFX8Sh3b1hxBl8JQjUjw/TI7+qbhwPEfIL3pRJmZUFt
   Q==;
X-CSE-ConnectionGUID: E4xMeCZJQg+YxwosHDhCOw==
X-CSE-MsgGUID: h5dnUv3mSs6BQkh8DiFOsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90386153"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90386153"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:50:44 -0700
X-CSE-ConnectionGUID: B7KfsphCS/KpCc3lNAy9EA==
X-CSE-MsgGUID: uBwLwr1KTSe9vZ5FfeHhlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274816265"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2026 00:50:42 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 2/4] Bluetooth: hci_core: clear hdev->rfkill after destroying it
Date: Wed, 30 Sep 2026 13:12:18 +0530
Message-ID: <46a0ed187cced4d73882c201521c36eb82287923.1790752799.git.aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790752799.git.aluvala.sai.teja@intel.com>
References: <cover.1790752799.git.aluvala.sai.teja@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_unregister_dev() unregisters and destroys hdev->rfkill but leaves
the pointer set. hdev itself, including its debugfs directory, can stay
alive after this point until the last reference is dropped and
hci_release_dev() runs, so hdev->rfkill points at freed memory for that
window.

Set hdev->rfkill to NULL after rfkill_destroy() so that code which can
still reach hdev after unregistration, such as hci_rfkill_set_hw_state()
or debugfs handlers, sees that no rfkill handle exists instead of
dereferencing a stale pointer.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ca75932acf84..be9f4997d315 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2743,6 +2743,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	if (hdev->rfkill) {
 		rfkill_unregister(hdev->rfkill);
 		rfkill_destroy(hdev->rfkill);
+		hdev->rfkill = NULL;
 	}
 	mutex_unlock(&hdev->unregister_lock);
 
-- 
2.53.0


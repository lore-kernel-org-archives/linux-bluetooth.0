Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35932D0275
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547612; cv=none; b=kYRRDo4KCyno3FbM9v3aY4wR8jaMvtlEcmMV1rsziAxabOh6H2JXeAiz+8fACnTbHWg0M/aZjdxdX+AuBF3cocsQTmrxaO0+NmVc4s+36T/kugrftLt/wDvJxFhya1xWb1RzfBHoUR+4KdwuZugywT9xifGb8+lxMpAg+uoBMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547612; c=relaxed/simple;
	bh=cQqFGXZlnaL9iS4FdRczD/xcQ5spDbdrAZJZDETZh+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gttDYtC/768K5Ko+I6KxRGplXl1AJ/w77h8TwGKTGaFHDoylhKJ+X9bmHDwDqbA6japtxo7DcGHGI5CCcizFsGy2HOpZSMrUcSYy0JWMfyqBZs3Qg6oyB9VUOkwkS8f8jL1/8LGw7yMZtcB/j/oWV6A6GNWejwem0aKcjrKQllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtfR8nYV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtfR8nYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752547611; x=1784083611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cQqFGXZlnaL9iS4FdRczD/xcQ5spDbdrAZJZDETZh+U=;
  b=UtfR8nYViKWRBVA+oUX/uVEfu7d7BEQAAiQeYEwhzQoxFcrt/DRtDF76
   o0WYk7V121hXThdcAuc8C7RR+24EA/l9pAAHxusnmI2tJVxLKIErzWjNw
   66k52WYoNDxoJYoBV0V3zqWMarGUP6xghcgO4zSuXncNKQB2hycOu5be0
   4xfVbzTdFUL9gUciyq5sL6OyxYBteiDlQUE9L4qab+72PEPvd5m2Of/PV
   +o2qG3/2MuG3BM9VG8e0x64OUzqJtGQo1PicTZ7K1RLgg+EkLRjC/UVH6
   3ujzp/zbONVt2MGzEvJhO1X5FBTgAx0RNVn0y43vDL5B+GjzmVv4Yd9sU
   w==;
X-CSE-ConnectionGUID: 6fTv5jZASeW6TVKELvHj/A==
X-CSE-MsgGUID: nOAubL58Qs+3UvyZ5+QZvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54461356"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54461356"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 19:46:51 -0700
X-CSE-ConnectionGUID: rXGrpyt9RPao2DGLZjRwEg==
X-CSE-MsgGUID: fb1bjkRzQpubf41fN0s88Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157195074"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jul 2025 19:46:48 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ceggers@arri.de,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: hci_ll: Fix compilation issue
Date: Tue, 15 Jul 2025 08:33:18 +0530
Message-ID: <20250715030318.1007009-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hci_ll.c: In function ‘ll_setup’:
hci_ll.c:656:68: error: ‘struct hci_dev’ has no member
                 named ‘quirks’
	set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);

Fixes: be736f5f89d5 ("Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bitmap")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/hci_ll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index e19e9bd49555..7044c86325ce 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -649,11 +649,11 @@ static int ll_setup(struct hci_uart *hu)
 		/* This means that there was an error getting the BD address
 		 * during probe, so mark the device as having a bad address.
 		 */
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
+		hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR);
 	} else if (bacmp(&lldev->bdaddr, BDADDR_ANY)) {
 		err = ll_set_bdaddr(hu->hdev, &lldev->bdaddr);
 		if (err)
-			set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
+			hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR);
 	}
 
 	/* Operational speed if any */
-- 
2.43.0


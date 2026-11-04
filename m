Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795624;
	b=uKcXZOoKpdcXjqjsOWEzJo0SiRcltotIwmaHye5MywqVVoFLNpSnLlVbDN6js2JcMJJs
	 CfdMhnJlzzXIIP59hS0Ase24bN/GlsFM6Wo7HidLYQxwKDqhuTERgLiGl0ATKJW+6yHHY
	 BW5J7ljUiHRibZ+hH+RMTcf3MZyFJk9qH8qDIyHtXGYA3yjT9WOnXcVzOnBEFY+gFAKf/
	 s/vkMsVee0A47xBFGPRncM3hN5Gz4tAadji6WwILZmGoaEeZ9UNINXJVPN0KQ53tF4mwr
	 D+7J16qQ7Q90lEK2uxIhhwJsev1D20axSUUdjp1WoGQz3s/zMqFUcVH7n4FBBvxggLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795624;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BrOeEF1VDXMe5n+5CZ+h4tyvtoRz/B5bF5W3D3Jz0U8=;
	b=4RmCvl8kf2ytCZqWiN0dKMx7PUbsR14Xdi70XyqN8n7JATASrzW1THIK7oSgdW056eUf
	 6daQLIx8IrdQ76mAcrEHmIHwzs3UFJdXNGk+Bk6tiwt5ceUZLomCq40wrxPY8wv49A/4w
	 HFaIIbjzdrJt112rMdZpCT+k8/y4Xp99xuEFTZ8qLhVQjyhKmHtCtc6fUcAFaOZvg56OZ
	 KyAUtkDeZ9i0ya57UMqfQGUYcNz+lqrDTdOjoK4TPaIiP8ogNuTro5OD0Ob/fERlo+MHh
	 YbsKv5qVPJJOEldtPF/a0FnkOHr6dCGt2BhUqV6O96g4QW1EZMMLYqMImwH3oJhECbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HIA+ItQS;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A84606A334
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 12:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A84606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HIA+ItQS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793795622; x=1825331622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5H/HIYlMgtNcPSw8xR2i3Ckn/NsW8ZajMQyuD0eE/dE=;
  b=HIA+ItQSWD84kwG2Elf3aH/JGssSHNBk2WnAJbKJ2C6lCTnbqsYS17/3
   DuN4uXFtHotuMFuFlOui2juMHIYLkwmbxxWGEjeSIqZCdhsixDFj8uD2d
   yjCGzQwlXSMkPteA/T/KFXUE3LnMw9lMjjy6+XIkp/5EfY/nEY7WpyzdO
   Y22qOAoGGUb+FetduBLTvhX5QzKhfF1pCc6WUM+LMc3CxsP88qRW5T9sF
   Aeytu1ep95rk+iqO3wO5PbRqKgkOhLhElZ/wD7ymlDR1VUbv5EdQCD1OQ
   RYN51RV1Y23ZeyvIS25azTak22PUZQdnZLkIaXrBQ6cyfY31QT0Dza66Z
   A==;
X-CSE-ConnectionGUID: EVtp4ux+RWGy1FG610PKyA==
X-CSE-MsgGUID: kLPBJwRBRlKZ9QhXLg0VNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2422493"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2422493"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:33:42 -0800
X-CSE-ConnectionGUID: H8ydy3VRQU+uBnIqiIH3vA==
X-CSE-MsgGUID: lAx4PEzwTmSuPcDGrUBqAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7099788"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa007.fm.intel.com with ESMTP; 04 Nov 2026 04:33:41 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v5 2/2] Bluetooth: btintel_pcie: Add fatal error injection test mode
Date: Wed,  4 Nov 2026 17:55:08 +0530
Message-ID: <20261104122508.241477-3-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104122508.241477-1-aluvala.sai.teja@intel.com>
References: <20261104122508.241477-1-aluvala.sai.teja@intel.com>
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

Add the FATAL_ERR_TESTMODE debug INI option to inject a firmware
exception for testing. The INI value selects the exception type and the
injection context (thread, IRQ or rfkill). Whether an injected
exception is expected to trigger recovery depends on its type.

The test mode is disabled when the OPFW API lock is set, unless the
unlocker firmware was loaded.

While HCI is up, the hardware rfkill button only triggers the
injection: an assertion injects the exception, a release is ignored,
and normal rfkill reporting to the HCI stack is disabled. While HCI is
down, normal rfkill handling applies.

The exception is also injected after every successful setup, with the
rfkill context and without sampling the rfkill state. The injection
stays pending until HCI is up, and open() reschedules it. After a
recovery re-probe it is injected again, until the INI entry is removed.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel.c            |   5 +-
 drivers/bluetooth/btintel.h            |   1 +
 drivers/bluetooth/btintel_pcie.c       |  39 +++++++
 drivers/bluetooth/btintel_pcie.h       |   5 +-
 drivers/bluetooth/btintel_pcie_debug.c | 155 ++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie_debug.h |  24 ++++
 6 files changed, 226 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index b9bb6980bada..a0aa110f4cdd 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3579,8 +3579,11 @@ static int btintel_try_load_unlocker(struct hci_dev *hdev,
 	if (err) {
 		bt_dev_err(hdev, "Failed to load intel/unlocker.sfi (%d)", err);
 		data->unlocker = false;
+		return err;
 	}
-	return err;
+
+	btintel_set_flag(hdev, INTEL_UNLOCKER_LOADED);
+	return 0;
 }
 
 int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d5e125ec5168..372c6d7d8cbe 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -259,6 +259,7 @@ enum {
 	INTEL_ROM_LEGACY_NO_WBS_SUPPORT,
 	INTEL_ACPI_RESET_ACTIVE,
 	INTEL_WAIT_FOR_D0,
+	INTEL_UNLOCKER_LOADED,
 
 	__INTEL_NUM_FLAGS,
 };
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 8b991ad2a107..5dd8e5083e88 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2954,6 +2954,14 @@ static void btintel_pcie_hw_rfkill_delay_work(struct work_struct *wk)
 	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
 		return;
 
+	/* Intentional: with the fatal error test mode enabled, the post-setup
+	 * injection consumes this rfkill pass, so the initial rfkill check is
+	 * deferred to the next pass. This avoids a second, back-to-back
+	 * injection while the recovery caused by the first one is running.
+	 */
+	if (btintel_pcie_fatal_err_post_setup_pending(data))
+		return;
+
 	/* Do not report an initial clear when rfkill was never asserted.
 	 * After resume, however, a previously asserted rfkill must be
 	 * cleared and reported to the HCI stack.
@@ -2968,10 +2976,18 @@ static void btintel_pcie_hw_rfkill_delay_work(struct work_struct *wk)
 		     !(ipc_ctrl & BTINTEL_PCIE_CSR_IPC_CONTROL_HW_RFKILL);
 	if (set_rfkill) {
 		bt_dev_dbg(data->hdev, "hw rfkill on");
+		/* Fatal error test mode: inject on every rfkill assertion seen
+		 * here, not only on a transition. A work run queued behind the
+		 * post-setup injection may inject once more.
+		 */
+		if (btintel_pcie_fatal_err_handle_rfkill(data, true))
+			return;
 		set_bit(BTINTEL_PCIE_HWRFKILL_ON, &data->flags);
 		hci_rfkill_set_hw_state(data->hdev, true);
 	} else {
 		bt_dev_dbg(data->hdev, "hw rfkill off");
+		if (btintel_pcie_fatal_err_handle_rfkill(data, false))
+			return;
 		/* Nothing changed at the initial post-setup check, so there
 		 * is no transition to report.
 		 */
@@ -3550,8 +3566,16 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 
 static int btintel_pcie_open(struct hci_dev *hdev)
 {
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+
 	bt_dev_dbg(hdev, "");
 
+	/* Fatal error test mode: send the post-setup injection that was
+	 * deferred because HCI was down.
+	 */
+	if (test_bit(BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING, &data->flags))
+		btintel_delayed_hw_rfkill(data, true);
+
 	return 0;
 }
 
@@ -3921,6 +3945,12 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev,
 		goto exit_error;
 	}
 
+	/* ver_tlv holds the operational firmware version after setup. A
+	 * locked platform with the unlocker loaded can run the test mode.
+	 */
+	btintel_pcie_fatal_err_check_api_lock(data, ver_tlv.api_lock &&
+					      !btintel_test_flag(hdev, INTEL_UNLOCKER_LOADED));
+
 	data->dmp_hdr.cnvi_top = ver_tlv.cnvi_top;
 	data->dmp_hdr.cnvr_top = ver_tlv.cnvr_top;
 	data->dmp_hdr.fw_timestamp = ver_tlv.timestamp;
@@ -3947,6 +3977,8 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
 	bool fips_crc_failed;
 
+	btintel_pcie_fatal_err_load(data);
+
 	while ((err = btintel_pcie_setup_internal(hdev, &fips_crc_failed)) &&
 	       fw_dl_retry++ < 1) {
 		if (fips_crc_failed)
@@ -3975,6 +4007,12 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 	}
 
 	if (!err) {
+		/* Fatal error test mode: arm the post-setup injection before
+		 * SETUP_DONE so the rfkill work cannot inject a fault ahead of
+		 * it.
+		 */
+		if (btintel_pcie_fatal_err_testmode_active(data))
+			set_bit(BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING, &data->flags);
 		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
 		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
 		btintel_pcie_unmask_hw_rfkill(data);
@@ -4567,6 +4605,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	data->img_resp_cache = 0x00;
 	data->dbg_path_cache = BTINTEL_PCIE_WIFI_DBGC;
 	data->log_mask = BTINTEL_PCIE_LOG_ALIVE_INTR | BTINTEL_PCIE_LOG_SX;
+	btintel_pcie_fatal_err_init(data);
 	data->pcie_alloc_init = false;
 	data->enable_ini = false;
 	btintel_pcie_yoyo_init(&data->yoyo);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index f04dfb0b30fa..4bffd95b6ec6 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -172,7 +172,8 @@ enum {
 	BTINTEL_PCIE_SETUP_DONE,
 	BTINTEL_PCIE_MAIL_BOX_INTR,
 	BTINTEL_PCIE_MBOX_PARSE_PENDING,
-	BTINTEL_PCIE_MBOX_PARSE_READY
+	BTINTEL_PCIE_MBOX_PARSE_READY,
+	BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING,
 };
 
 enum btintel_pcie_tlv_type {
@@ -719,6 +720,7 @@ struct btintel_pcie_ini_dump_info {
  * @dbg_path_cache: cached debug output routing mode (BT DRAM or WiFi DBGC)
  * @log_mask: runtime diagnostic logging mask loaded from LOG_MASK in the
  *	debug INI file (alive interrupt and Sx logging are enabled by default)
+ * @fatal_err: fatal-error injection testmode state
  * @cnvi: CNVi register value
  * @cnvr: CNVr register value
  * @gp0_received: condition for gp0 interrupt
@@ -775,6 +777,7 @@ struct btintel_pcie_data {
 	u32	dbg_path_cache;
 	u32	log_mask;
 	bool	enable_ini;
+	struct btintel_pcie_fatal_err_cfg fatal_err;
 	struct btintel_pcie_yoyo_ctx yoyo;
 
 	u32	cnvi;
diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
index f3409b8d70b5..d675d3ff63dc 100644
--- a/drivers/bluetooth/btintel_pcie_debug.c
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -7,7 +7,7 @@
  * Runtime-configurable TLV-based debug collection framework for loading and
  * parsing the optional YoYo firmware configuration used to enable debug
  * regions, triggers, HCI commands, and configuration sets. Also provides
- * debug INI configuration.
+ * debug INI configuration and fatal-error injection testmode.
  */
 
 #include <linux/errno.h>
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/unaligned.h>
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
 #include "btintel_pcie.h"
 #include "btintel_pcie_debug.h"
 
@@ -153,6 +154,158 @@ void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_load_dbg_path_from_ini);
 
+void btintel_pcie_fatal_err_init(struct btintel_pcie_data *data)
+{
+	data->fatal_err.testmode_enabled = false;
+	data->fatal_err.context = BTINTEL_PCIE_DEBUG_EXCEPTION_CONTEXT_THREAD;
+	data->fatal_err.type = BTINTEL_PCIE_DEBUG_EXCEPTION_FAILURE_TYPE_DEFAULT;
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_fatal_err_init);
+
+void btintel_pcie_fatal_err_load(struct btintel_pcie_data *data)
+{
+	char *buf, *cursor, *key, *val;
+	u32 parsed;
+
+	WRITE_ONCE(data->fatal_err.testmode_enabled, false);
+	clear_bit(BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING, &data->flags);
+	buf = btintel_pcie_read_debug_ini(data);
+	if (IS_ERR(buf)) {
+		BT_DBG("%s unavailable (%ld); fatal-error testmode disabled",
+		       BTINTEL_PCIE_DBG_INI_FILE, PTR_ERR(buf));
+		return;
+	}
+
+	cursor = buf;
+	while ((val = btintel_pcie_ini_next(&cursor, &key))) {
+		if (strcasecmp(key, "FATAL_ERR_TESTMODE"))
+			continue;
+
+		if (kstrtou32(val, 0, &parsed) ||
+		    BTINTEL_PCIE_FATAL_ERR_ENABLE(parsed) > 1 ||
+		    BTINTEL_PCIE_FATAL_ERR_CONTEXT(parsed) >
+				BTINTEL_PCIE_DEBUG_EXCEPTION_CONTEXT_RFKILL ||
+		    parsed >> 24) {
+			BT_ERR("Invalid FATAL_ERR_TESTMODE='%s' in %s; testmode disabled",
+			       val, BTINTEL_PCIE_DBG_INI_FILE);
+			break;
+		}
+
+		data->fatal_err.context = BTINTEL_PCIE_FATAL_ERR_CONTEXT(parsed);
+		data->fatal_err.type = BTINTEL_PCIE_FATAL_ERR_TYPE(parsed);
+		WRITE_ONCE(data->fatal_err.testmode_enabled,
+			   BTINTEL_PCIE_FATAL_ERR_ENABLE(parsed));
+		BT_INFO("FATAL_ERR_TESTMODE accepted: 0x%08x", parsed);
+		break;
+	}
+
+	kfree(buf);
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_fatal_err_load);
+
+void btintel_pcie_fatal_err_check_api_lock(struct btintel_pcie_data *data,
+					   bool api_lock)
+{
+	if (api_lock) {
+		if (READ_ONCE(data->fatal_err.testmode_enabled))
+			bt_dev_info(data->hdev,
+				    "OPFW API lock enabled; disabling fatal-error testmode");
+		WRITE_ONCE(data->fatal_err.testmode_enabled, false);
+	} else if (READ_ONCE(data->fatal_err.testmode_enabled)) {
+		bt_dev_info(data->hdev, "fatal-error testmode active: ctx=0x%02x type=0x%02x",
+			    data->fatal_err.context, data->fatal_err.type);
+	}
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_fatal_err_check_api_lock);
+
+static int btintel_pcie_inject_fatal_err(struct btintel_pcie_data *data,
+					 u8 context)
+{
+	struct hci_dev *hdev = data->hdev;
+	struct sk_buff *skb;
+	u8 param[2];
+	int err = 0;
+
+	/* Setup and the rest of HCI initialization hold req_lock. Wait for
+	 * them before testing HCI_UP; a delayed worker alone is not enough.
+	 */
+	hci_req_sync_lock(hdev);
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		err = -ENETDOWN;
+		goto unlock;
+	}
+
+	if (!READ_ONCE(data->fatal_err.testmode_enabled))
+		goto unlock;
+
+	param[0] = data->fatal_err.type;
+	param[1] = context;
+	skb = __hci_cmd_sync(hdev, 0xfc4d, sizeof(param), param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		goto unlock;
+	}
+
+	kfree_skb(skb);
+unlock:
+	hci_req_sync_unlock(hdev);
+	if (err && err != -ENETDOWN)
+		bt_dev_err(hdev, "fatal-error inject failed (ctx=0x%02x err=%d)",
+			   context, err);
+	return err;
+}
+
+bool btintel_pcie_fatal_err_handle_rfkill(struct btintel_pcie_data *data,
+					  bool rfkill_on)
+{
+	if (!READ_ONCE(data->fatal_err.testmode_enabled))
+		return false;
+
+	if (rfkill_on) {
+		/* HCI down: nothing to inject, use the normal handling */
+		if (btintel_pcie_inject_fatal_err(data, data->fatal_err.context) ==
+		    -ENETDOWN)
+			return false;
+		return true;
+	}
+
+	/* Release of an assertion handled by the normal path: let it through */
+	if (test_bit(BTINTEL_PCIE_HWRFKILL_ON, &data->flags))
+		return false;
+
+	bt_dev_dbg(data->hdev, "fatal-error testmode active: ignoring RF-KILL OFF");
+	return true;
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_fatal_err_handle_rfkill);
+
+bool btintel_pcie_fatal_err_post_setup_pending(struct btintel_pcie_data *data)
+{
+	int err;
+
+	if (!test_bit(BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING, &data->flags))
+		return false;
+
+	/* Intentional: RFKILL context tells the controller testmode is enabled */
+	err = btintel_pcie_inject_fatal_err(data,
+					    BTINTEL_PCIE_DEBUG_EXCEPTION_CONTEXT_RFKILL);
+	/* HCI is down: keep the injection pending for a later pass and let
+	 * the normal rfkill handling run.
+	 */
+	if (err == -ENETDOWN)
+		return false;
+
+	clear_bit(BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING, &data->flags);
+	return true;
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_fatal_err_post_setup_pending);
+
+bool btintel_pcie_fatal_err_testmode_active(struct btintel_pcie_data *data)
+{
+	return READ_ONCE(data->fatal_err.testmode_enabled);
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_fatal_err_testmode_active);
+
 /* TLV-specific parser DEBUG_INFO TLV type */
 static int btintel_pcie_yoyo_parse_dbg_info(struct btintel_pcie_yoyo_ctx *ctx,
 					    const struct btintel_pcie_tlv_dbg_info *info,
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
index 04cfcef6f65b..b4d1d329886b 100644
--- a/drivers/bluetooth/btintel_pcie_debug.h
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -18,7 +18,31 @@ struct btintel_pcie_data;
 
 #define BTINTEL_PCIE_DBG_INI_FILE	"ibt_bt_dbg_cfg.ini"
 
+/* FATAL_ERR_TESTMODE: B0 enable, B1 context, B2 type, B3 reserved. */
+#define BTINTEL_PCIE_FATAL_ERR_ENABLE(v)	((u8)((v) & 0xff))
+#define BTINTEL_PCIE_FATAL_ERR_CONTEXT(v)	((u8)(((v) >> 8) & 0xff))
+#define BTINTEL_PCIE_FATAL_ERR_TYPE(v)	((u8)(((v) >> 16) & 0xff))
+
+#define BTINTEL_PCIE_DEBUG_EXCEPTION_CONTEXT_THREAD	0x00
+#define BTINTEL_PCIE_DEBUG_EXCEPTION_CONTEXT_IRQ		0x01
+#define BTINTEL_PCIE_DEBUG_EXCEPTION_CONTEXT_RFKILL	0x02
+#define BTINTEL_PCIE_DEBUG_EXCEPTION_FAILURE_TYPE_DEFAULT	0x00
+
+struct btintel_pcie_fatal_err_cfg {
+	bool	testmode_enabled;
+	u8	context;
+	u8	type;
+};
+
 void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data);
+void btintel_pcie_fatal_err_init(struct btintel_pcie_data *data);
+void btintel_pcie_fatal_err_load(struct btintel_pcie_data *data);
+void btintel_pcie_fatal_err_check_api_lock(struct btintel_pcie_data *data,
+					   bool api_lock);
+bool btintel_pcie_fatal_err_handle_rfkill(struct btintel_pcie_data *data,
+					  bool rfkill_on);
+bool btintel_pcie_fatal_err_post_setup_pending(struct btintel_pcie_data *data);
+bool btintel_pcie_fatal_err_testmode_active(struct btintel_pcie_data *data);
 
 /* External YoYo binary file */
 #define BTINTEL_PCIE_YOYO_FW_NAME	"intel/ibt_debug_yoyo.bin"
-- 
2.53.0


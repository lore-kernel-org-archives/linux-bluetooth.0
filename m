Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163211;
	b=lPK8hPmdm5hRqygp8ZsWo/ILb5ONa85IusefwDFvl/Z3iENUe4Fi1ZWjMuwb7GhyH/0B
	 X+v0PmAGXs6JGUcTQ1yMe2dAScw/6DSsi+4fGIXMU0aEswKht2SiD2zXFXn2HWtCaWyej
	 PKepnX+4qUyECOSrjN0R92mtsKJfVF4o8jOjx4zY3lxnTFUOaLhek3xFgiEp3e8lbjfqR
	 QOcZ8Xo+owj3w9v+9D4W3IuyCaKHeGGVUIDsHNElZ74FEnBSsrRFCWo/0N/Zfo8QqwxRo
	 /smmwgvXOTNDpUizsUwAyLwF3Cs6EzUmlVlZC74gv2+CA2qO2qgnVJmzmfLhuPVGWuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163211;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zwAAPhjm5dlm1q7W8VIWsmEvDqAL2WDTBly47Qw671Q=;
	b=NOcpAhC1mxSB3fIkt1agck9ZLwUEPDMFeaUyZRXTOOdimjvBMr7G0CWC8mVjicbZUx/o
	 OyX9bvv7YTJ8pYdTOzHG1VL8GJbGAMbyYM3aJx9PKjJNmabSunhR4V8vC6UHgi/sWVofJ
	 oJ3Cg3Pjcd4yXgLuaBBPUx+bxk5u1RDNnh5h5++9GjP2QPPqV1BZ/blZqPY7kaZMGtRhI
	 CEvKiwKtFj+rO4dC3LaJ6TtpekrsxrAPA+cYqpboQt/2zllIwg1RdGPHl/8RrjfEMPSSn
	 6P6IZGxQm4eWvPvO3/PL+i6QFroSwWmZG2kv1j4AL7KM7uKxQjcpYTHbM7y2nNNM57w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=F0MbUoqb;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC9606A335;
	Fri, 20 Nov 2026 08:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47FC9606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=F0MbUoqb
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AK8QapK63249389, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1795163197; bh=zwAAPhjm5dlm1q7W8VIWsmEvDqAL2WDTBly47Qw671Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=F0MbUoqbtGx3QcagSee006zn+0mHzo/3bPCgWEmLAHnhhMLdaW1hQhSGiVReGHuMZ
	 bqZpDZb/i0rHPuL3fncNE51FnNtFpMO0dQBK2acleXfbX7MLlDBExduzsSZ6jQlvaG
	 FAbhvP4OoCkBexPeKfVxhwUZZGSX2hU64CKeXlPSXJt/NNVk/QMfYCB2oHxtaJGlBc
	 j7+Ze4+e8xpo9G5At3DLQkSpgcbOgnjkU2PoeuEcIVet1NK6m6je7+TMVaZXEDKuri
	 T6Gjmrfg0QduuaTREazippsxawRUewShN0/V7fjd+r2DsEP+yQEmmDfRs6Ef9IKDfy
	 izvuA31htSLCg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AK8QapK63249389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Nov 2026 16:26:37 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 16:26:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 16:26:36 +0800
Received: from localhost.localhost (172.24.54.48) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 16:26:36 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
	<jason_mao@realsil.com.cn>, <zoey_zhou@realsil.com.cn>,
	<max.chou@realtek.com>, <kidman@realtek.com>, <arunr@valvesoftware.com>
Subject: [PATCH v10 1/2] Bluetooth: btrtl: Add firmware format v3 support
Date: Fri, 20 Nov 2026 16:26:35 +0800
Message-ID: <20261120082636.3834168-2-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120082636.3834168-1-hildawu@realtek.com>
References: <20261120082636.3834168-1-hildawu@realtek.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Alex Lu <alex_lu@realsil.com.cn>

Realtek has introduced a new Bluetooth firmware format, firmware
format v3. This is a Realtek-internal specification; the format
differences from v2 are documented inline in this patch.

This patch extends the btrtl driver to recognize and parse the new v3
file format, including:
- New signature string and subsection ID definitions
- Extension of btrtl_device_info to store v3-specific metadata
- Logic to extract and load firmware data out of v3
- Maintains compatibility with the existing v2 firmware format

The RTL8922D is the first IC to use firmware format v3. The firmware
binary (rtl8922du_fw.bin) payload is approximately 260 KB (0x3f603
bytes), and on a typical boot the full sequence from rtl_load_file() to
rtl_finalize_download() completing takes average ~454 ms.

The following is RTL8922D log as expected fw format v3 output:

[  174.016830] Bluetooth: hci0: RTL: chip_id status=0x00 id=0x37
[  174.017083] Bluetooth: hci0: RTL: hci 0e.000d lmp 0e.8922
[  174.017359] Bluetooth: hci0: RTL: rom_version status=0 version=0
[  174.017776] Bluetooth: hci0: RTL: key id 0
[  174.017778] Bluetooth: hci0: RTL: loading rtl_bt/rtl8922du_fw.bin
[  174.019899] Bluetooth: hci0: RTL: loading rtl_bt/rtl8922du_config.bin
[  174.019929] Bluetooth: hci0: RTL: cfg rtl_bt/rtl8922du_config.bin not found, ignored
[  174.019931] Bluetooth: hci0: RTL: fw key id 0
[  174.019933] Bluetooth: hci0: RTL: sub f000:00 chip 55 cut 01 len 0000c2a1
[  174.019941] Bluetooth: hci0: RTL: subsection ver e6c9e544
[  174.019956] Bluetooth: hci0: RTL: cfg rtl_bt/rtl8922du_config_f000.bin not found, use default
[  174.019958] Bluetooth: hci0: RTL: sub f001:00 chip 55 cut 01 len 0001bac5
[  174.019976] Bluetooth: hci0: RTL: subsection ver e6c9e544
[  174.019991] Bluetooth: hci0: RTL: cfg rtl_bt/rtl8922du_config_f001.bin not found, use default
[  174.019992] Bluetooth: hci0: RTL: sub f002:00 chip 55 cut 01 len 0001789d
[  174.020008] Bluetooth: hci0: RTL: subsection ver 3cddadfd
[  174.020024] Bluetooth: hci0: RTL: cfg rtl_bt/rtl8922du_config_f002.bin found
[  174.020026] Bluetooth: hci0: RTL: skip f000:00: key_id 1 != 0
[  174.020027] Bluetooth: hci0: RTL: skip f001:00: key_id 1 != 0
[  174.020029] Bluetooth: hci0: RTL: skip f002:00: key_id 1 != 0
[  174.020030] Bluetooth: hci0: RTL: skip f000:00: key_id 2 != 0
[  174.020031] Bluetooth: hci0: RTL: skip f001:00: key_id 2 != 0
[  174.020033] Bluetooth: hci0: RTL: skip f002:00: key_id 2 != 0
[  174.020034] Bluetooth: hci0: RTL: fw payload len 0x0003f603
[  174.466130] Bluetooth: hci0: RTL: Watchdog reset status 00
[  174.471770] Bluetooth: hci0: RTL: fw version 0x3cddadfd

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Co-developed-by: Zoey Zhou <zoey_zhou@realsil.com.cn>
Signed-off-by: Zoey Zhou <zoey_zhou@realsil.com.cn>
Co-developed-by: Hilda Wu <hildawu@realtek.com>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
Tested-by: Veysi Özgün <veysiiozgun@gmail.com>
---
Note: checkpatch reports FILE_PATH_CHANGES for the new files. They are
already covered by "F: drivers/bluetooth/" in the BLUETOOTH SUBSYSTEM
entry, so MAINTAINERS is not updated.

About module naming:
This version keeps btrtl.c for the legacy/common code and adds
btrtl_enh.c for firmware format v3. Keep btrtl.c and build the composite
module as btrtl_core.ko, so that the existing btrtl.c keeps its
full history in git log / git blame without needing --follow, and the
diff of btrtl.c stays reviewable as changes to the existing code rather
than a file move. Because btrtl.o is a member of the composite module,
the module, the module is now built as btrtl_core.ko instead of
btrtl.ko. This changes a name visible to userspace.

Notes on Sashiko feedback:
The 0xfc6f probe is read-only and is sent before the existing version
probe for every chip.  A ROM that does not implement it answers
"Unknown HCI Command" (status 0x01) immediately and the result is
ignored unless the command succeeded and the id is >= 55, so legacy
probing is not affected.

The security-project (key id) register is now only read where it can
carry a non-zero value: V3 chips via the new DA4 sub-command and
RTL8922A via the old one.  All older parts keep key_id == 0, which
matches what they have always used.

Only the V3_2 container needs the download-state handshake (0xfdcf +
vendor event 0x77).  V3 firmware is shipped for USB parts only and
btrtl_recv_event() is wired up in btusb only, so this path is
unreachable on the UART transport today.

Firmware and config files are now requested with
firmware_request_nowarn(), and the config load does not warn when the
file is optional.

V9 -> V10:
- Only use the chip id from btrtl_read_chip_id() when the command
  succeeds; a non-zero status is already reported as an error by
  __hci_cmd_sync()
- Use DIV_ROUND_UP() for the V3 fragment count and keep a full-size last
  fragment when fw_len is a multiple of RTL_FRAG_LEN
- V3_1: reuse the config already loaded by btrtl_initialize() for the
  first image instead of loading it again
  V3_2: fall back to the 4-byte default config when cfg_name is NULL
  or the per-image config file is missing
- Log the config file name when it is not found
- Drop the now unnecessary EXPORT_SYMBOL_GPL() for the helpers that live
  in the same module
- Set -ENOMEM when the drop_fw skb allocation fails
- Refresh the sample log
- Keep Tested-by from Veysi Özgün (v8); no change to the firmware
   download flow for RTL8852BU

V8 -> V9:
- Adjust the length of each log message (< 80)
- Add Tested-by

V7 -> V8:
- Fix potential memory leak of v3 firmware patch images: merge
  btrtl_enh.c into the same btrtl_core.ko module via kbuild composite
  object, instead of a separate module accessed through
  symbol_get()/symbol_put(). This removes the mismatch between the
  module's reference count and the lifetime of the dynamically
  allocated patch image/config buffers (Reported by Sashiko)
- Add a bounds check on skb->len before accessing skb->data[0] in
  btusb_recv_event_realtek(), to avoid an out-of-bounds read when a
  zero-length packet is received (Reported by Sashiko)
- Return the error immediately instead of silently continuing to the
  next subsection when rtlbt_parse_section_v3() fails, to avoid
  loading incomplete firmware onto the controller (Reported by
  Sashiko)
- Fix a skb leak in the btrtl_recv_event() (Reported by Sashiko)
- Add a comment clarifying that the security project ID (key_id)
  register is only present starting from RTL8922A and V3-capable
  chips; legacy chips intentionally skip this read (Reported by
  Sashiko)

V6 -> V7:
- Fix smatch warning in btrtl_free(): move the NULL check on
  btrtl_dev to the very beginning of the function, before any
  dereference, instead of after it has already been dereferenced
  multiple times (Reported by kernel test / Dan Carpenter)
- Revise log message to use "subsection" terminology for clarity
- Add informational message when a config file is not found

V5 -> V6:
- Add missing parentheses around the entire is_v3_fw() macro
  expression to avoid incorrect evaluation with the logical NOT
  operator on legacy firmware types
- Add NULL check on ic_info->cfg_name before use in
  rtlbt_parse_config() to avoid NULL pointer dereference when
  a crafted firmware specifies FW_TYPE_V3_2 on legacy chips
  without configuration
- Add bounds check to reject patch_image_len < 4 before reading
  the image version, preventing an out-of-bounds read
- Propagate the return value of rtlbt_parse_config() and abort
  parsing on failure instead of silently continuing without
  the required configuration
- Fix a race condition in rtl_check_download_state() by setting
  the REALTEK_DOWNLOADING flag before issuing the check-download
  command, instead of after, to avoid missing the completion
  event
- Split v3 firmware parse/download logic into new btrtl_enh.c to
  keep btrtl.c size manageable

V4 -> V5:
- Add independent support for RTL8922D section
- Introduce macros to improve code readability
- Document firmware format v3 and its differences
- Align implementation with reviewer feedback

V3 -> V4:
- Rework skb->data access and add clarifying comments
- Fix latent issues

V2 -> V3:
- Address coccinelle warning

V1 -> V2:
- Add missing symbols
- Resolve build warnings
---
---
 drivers/bluetooth/Makefile     |   4 +-
 drivers/bluetooth/btrtl.c      | 213 ++++++---
 drivers/bluetooth/btrtl.h      |  87 +++-
 drivers/bluetooth/btrtl_enh.c  | 795 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/btusb_main.c |  25 +-
 5 files changed, 1043 insertions(+), 81 deletions(-)
 create mode 100644 drivers/bluetooth/btrtl_enh.c

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 7d933755b291..68f00a867fc8 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_BT_MTKSDIO)	+= btmtksdio.o
 obj-$(CONFIG_BT_MTKUART)	+= btmtkuart.o
 obj-$(CONFIG_BT_QCOMSMD)	+= btqcomsmd.o
 obj-$(CONFIG_BT_BCM)		+= btbcm.o
-obj-$(CONFIG_BT_RTL)		+= btrtl.o
+obj-$(CONFIG_BT_RTL)		+= btrtl_core.o
 obj-$(CONFIG_BT_QCA)		+= btqca.o
 obj-$(CONFIG_BT_MTK)		+= btmtk.o
 
@@ -36,6 +36,8 @@ obj-$(CONFIG_BT_HCIRSI)		+= btrsi.o
 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
 
+btrtl_core-y			:= btrtl.o btrtl_enh.o
+
 hci_uart-y				:= hci_ldisc.o
 hci_uart-$(CONFIG_BT_HCIUART_SERDEV)	+= hci_serdev.o
 hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 35a2c9d3380c..49a13049fc50 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -22,6 +22,7 @@
 #define RTL_CHIP_8723CS_XX	5
 #define RTL_EPATCH_SIGNATURE	"Realtech"
 #define RTL_EPATCH_SIGNATURE_V2	"RTBTCore"
+#define RTL_EPATCH_SIGNATURE_V3	"BTNIC003"
 #define RTL_ROM_LMP_8703B	0x8703
 #define RTL_ROM_LMP_8723A	0x1200
 #define RTL_ROM_LMP_8723B	0x8723
@@ -33,16 +34,14 @@
 #define RTL_ROM_LMP_8922A	0x8922
 #define RTL_CONFIG_MAGIC	0x8723ab55
 
-#define RTL_VSC_OP_COREDUMP	0xfcff
-
 #define IC_MATCH_FL_LMPSUBV	(1 << 0)
 #define IC_MATCH_FL_HCIREV	(1 << 1)
 #define IC_MATCH_FL_HCIVER	(1 << 2)
 #define IC_MATCH_FL_HCIBUS	(1 << 3)
 #define IC_MATCH_FL_CHIP_TYPE	(1 << 4)
 #define IC_INFO(lmps, hcir, hciv, bus) \
-	.match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV | \
-		       IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS, \
+	.match_flags = (IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV | \
+		       IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS), \
 	.lmp_subver = (lmps), \
 	.hci_rev = (hcir), \
 	.hci_ver = (hciv), \
@@ -50,7 +49,8 @@
 
 #define	RTL_CHIP_SUBVER (&(struct rtl_vendor_cmd) {{0x10, 0x38, 0x04, 0x28, 0x80}})
 #define	RTL_CHIP_REV    (&(struct rtl_vendor_cmd) {{0x10, 0x3A, 0x04, 0x28, 0x80}})
-#define	RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0xAD, 0x00, 0xb0}})
+#define	RTL_SEC_PROJ_V2    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0xAD, 0x00, 0xb0}})
+#define	RTL_SEC_PROJ_V3    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0x0D, 0x01, 0xa0}})
 
 #define RTL_PATCH_SNIPPETS		0x01
 #define RTL_PATCH_DUMMY_HEADER		0x02
@@ -75,34 +75,6 @@ enum btrtl_chip_id {
 	CHIP_ID_8761C = 51,
 };
 
-struct id_table {
-	__u16 match_flags;
-	__u16 lmp_subver;
-	__u16 hci_rev;
-	__u8 hci_ver;
-	__u8 hci_bus;
-	__u8 chip_type;
-	bool config_needed;
-	bool has_rom_version;
-	bool has_msft_ext;
-	char *fw_name;
-	char *cfg_name;
-	char *hw_info;
-};
-
-struct btrtl_device_info {
-	const struct id_table *ic_info;
-	u8 rom_version;
-	u8 *fw_data;
-	int fw_len;
-	u8 *cfg_data;
-	int cfg_len;
-	bool drop_fw;
-	int project_id;
-	u8 key_id;
-	struct list_head patch_subsecs;
-};
-
 static const struct id_table ic_id_table[] = {
 	/* 8723A */
 	{ IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
@@ -337,6 +309,7 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8852btu_fw",
 	  .cfg_name = "rtl_bt/rtl8852btu_config",
 	  .hw_info  = "rtl8852btu" },
+
 	};
 
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
@@ -371,7 +344,34 @@ static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
 	return &ic_id_table[i];
 }
 
-static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
+int btrtl_read_chip_id(struct hci_dev *hdev, u8 *chip_id)
+{
+	struct rtl_rp_read_chip_id *rp;
+	struct sk_buff *skb;
+	int ret = 0;
+
+	skb = __hci_cmd_sync(hdev, RTL_VSC_OP_READ_CHIP_ID, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	rp = skb_pull_data(skb, sizeof(*rp));
+	if (!rp) {
+		ret = -EIO;
+		goto out;
+	}
+
+	rtl_dev_info(hdev, "chip_id status=0x%02x id=0x%02x",
+		     rp->status, rp->chip_id);
+
+	if (chip_id)
+		*chip_id = rp->chip_id;
+
+out:
+	kfree_skb(skb);
+	return ret;
+}
+
+struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 
@@ -397,8 +397,7 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 	struct rtl_rom_version_evt *rom_version;
 	struct sk_buff *skb;
 
-	/* Read RTL ROM version command */
-	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, RTL_VSC_OP_READ_ROM_VER, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		rtl_dev_err(hdev, "Read ROM version failed (%ld)",
 			    PTR_ERR(skb));
@@ -427,11 +426,11 @@ static int btrtl_vendor_read_reg16(struct hci_dev *hdev,
 	struct sk_buff *skb;
 	int err = 0;
 
-	skb = __hci_cmd_sync(hdev, 0xfc61, sizeof(*cmd), cmd,
+	skb = __hci_cmd_sync(hdev, RTL_VSC_OP_READ_VENDOR, sizeof(*cmd), cmd,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		rtl_dev_err(hdev, "RTL: Read reg16 failed (%d)", err);
+		rtl_dev_err(hdev, "Read reg16 failed (%d)", err);
 		return err;
 	}
 
@@ -449,7 +448,7 @@ static int btrtl_vendor_read_reg16(struct hci_dev *hdev,
 	return 0;
 }
 
-static void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
+void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
 {
 	void *data = iov->data;
 
@@ -603,7 +602,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 			continue;
 		}
 		if (rc < 0) {
-			rtl_dev_err(hdev, "RTL: Parse section (%u) err %d",
+			rtl_dev_err(hdev, "Parse section (%u) err %d",
 				    opcode, rc);
 			return rc;
 		}
@@ -620,7 +619,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 
 	len = 0;
 	list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, list) {
-		rtl_dev_dbg(hdev, "RTL: opcode %08x, addr %p, len 0x%x",
+		rtl_dev_dbg(hdev, "opcode %08x, addr %p, len 0x%x",
 			    entry->opcode, entry->data, entry->len);
 		memcpy(ptr + len, entry->data, entry->len);
 		len += entry->len;
@@ -632,6 +631,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 	}
 
 	*_buf = ptr;
+	btrtl_dev->fw_type = FW_TYPE_V2;
 	return len;
 }
 
@@ -677,6 +677,9 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	if (btrtl_dev->fw_len <= 8)
 		return -EINVAL;
 
+	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V3, 8))
+		return rtlbt_parse_firmware_v3(hdev, btrtl_dev);
+
 	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8))
 		min_size = sizeof(struct rtl_epatch_header) +
 				sizeof(extension_sig) + 3;
@@ -813,11 +816,12 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	memcpy(buf + patch_length - 4, &epatch_info->fw_version, 4);
 
 	*_buf = buf;
+	btrtl_dev->fw_type = FW_TYPE_V1;
 	return len;
 }
 
-static int rtl_download_firmware(struct hci_dev *hdev,
-				 const unsigned char *data, int fw_len)
+int rtl_download_firmware(struct hci_dev *hdev, u8 fw_type,
+			 const unsigned char *data, int fw_len)
 {
 	struct rtl_download_cmd *dl_cmd;
 	int frag_num = fw_len / RTL_FRAG_LEN + 1;
@@ -827,6 +831,14 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	int j = 0;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *rp;
+	u8 dl_rp_len = sizeof(struct rtl_download_response);
+
+	if (is_v3_fw(fw_type)) {
+		frag_num = DIV_ROUND_UP(fw_len, RTL_FRAG_LEN);
+		j = 1;
+		if (fw_type == FW_TYPE_V3_2)
+			dl_rp_len++;
+	}
 
 	dl_cmd = kmalloc_obj(*dl_cmd);
 	if (!dl_cmd)
@@ -840,15 +852,18 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 			j = 1;
 
 		if (i == (frag_num - 1)) {
-			dl_cmd->index |= 0x80; /* data end */
-			frag_len = fw_len % RTL_FRAG_LEN;
+			if (!is_v3_fw(fw_type)) {
+				dl_cmd->index |= 0x80; /* data end */
+				frag_len = fw_len % RTL_FRAG_LEN;
+			} else if (fw_len % RTL_FRAG_LEN) {
+				frag_len = fw_len % RTL_FRAG_LEN;
+			}
 		}
 		rtl_dev_dbg(hdev, "download fw (%d/%d). index = %d", i,
 				frag_num, dl_cmd->index);
 		memcpy(dl_cmd->data, data, frag_len);
 
-		/* Send download command */
-		skb = __hci_cmd_sync(hdev, 0xfc20, frag_len + 1, dl_cmd,
+		skb = __hci_cmd_sync(hdev, RTL_VSC_OP_DOWNLOAD_CMD, frag_len + 1, dl_cmd,
 				     HCI_INIT_TIMEOUT);
 		if (IS_ERR(skb)) {
 			rtl_dev_err(hdev, "download fw command failed (%ld)",
@@ -857,7 +872,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 			goto out;
 		}
 
-		if (skb->len != sizeof(struct rtl_download_response)) {
+		if (skb->len != dl_rp_len) {
 			rtl_dev_err(hdev, "download fw event length mismatch");
 			kfree_skb(skb);
 			ret = -EIO;
@@ -868,6 +883,9 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 		data += RTL_FRAG_LEN;
 	}
 
+	if (is_v3_fw(fw_type))
+		goto out;
+
 	skb = btrtl_read_local_version(hdev);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
@@ -891,7 +909,7 @@ static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
 	int ret;
 
 	rtl_dev_info(hdev, "loading %s", name);
-	ret = request_firmware(&fw, name, &hdev->dev);
+	ret = firmware_request_nowarn(&fw, name, &hdev->dev);
 	if (ret < 0)
 		return ret;
 	ret = fw->size;
@@ -918,7 +936,7 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
-	return rtl_download_firmware(hdev, btrtl_dev->fw_data,
+	return rtl_download_firmware(hdev, FW_TYPE_V0, btrtl_dev->fw_data,
 				     btrtl_dev->fw_len);
 }
 
@@ -933,7 +951,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 	if (ret < 0)
 		goto out;
 
-	if (btrtl_dev->cfg_len > 0) {
+	if (!is_v3_fw(btrtl_dev->fw_type) && btrtl_dev->cfg_len > 0) {
 		tbuff = kvzalloc(ret + btrtl_dev->cfg_len, GFP_KERNEL);
 		if (!tbuff) {
 			ret = -ENOMEM;
@@ -949,9 +967,14 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 		fw_data = tbuff;
 	}
 
+	if (is_v3_fw(btrtl_dev->fw_type)) {
+		ret = rtl_download_firmware_v3(hdev, btrtl_dev);
+		goto out;
+	}
+
 	rtl_dev_info(hdev, "cfg_sz %d, total sz %d", btrtl_dev->cfg_len, ret);
 
-	ret = rtl_download_firmware(hdev, fw_data, ret);
+	ret = rtl_download_firmware(hdev, btrtl_dev->fw_type, fw_data, ret);
 
 out:
 	kvfree(fw_data);
@@ -1021,7 +1044,7 @@ static int rtl_read_chip_type(struct hci_dev *hdev, u8 *type)
 	const unsigned char cmd_buf[] = {0x00, 0x94, 0xa0, 0x00, 0xb0};
 
 	/* Read RTL chip type command */
-	skb = __hci_cmd_sync(hdev, 0xfc61, 5, cmd_buf, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, RTL_VSC_OP_READ_VENDOR, 5, cmd_buf, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		rtl_dev_err(hdev, "Read chip type failed (%ld)",
 			    PTR_ERR(skb));
@@ -1048,6 +1071,9 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
 	struct rtl_subsection *entry, *tmp;
 
+	if (!btrtl_dev)
+		return;
+
 	kvfree(btrtl_dev->fw_data);
 	kvfree(btrtl_dev->cfg_data);
 
@@ -1056,6 +1082,8 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev)
 		kfree(entry);
 	}
 
+	btrtl_free_patch_images(btrtl_dev);
+
 	kfree(btrtl_dev);
 }
 EXPORT_SYMBOL_GPL(btrtl_free);
@@ -1063,7 +1091,7 @@ EXPORT_SYMBOL_GPL(btrtl_free);
 struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 					   const char *postfix)
 {
-	struct btrealtek_data *coredump_info = hci_get_priv(hdev);
+	struct btrealtek_data *btrtl_data = hci_get_priv(hdev);
 	struct btrtl_device_info *btrtl_dev;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
@@ -1073,8 +1101,9 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
 	int ret;
-	u8 key_id;
+	u8 key_id = 0;
 	u8 reg_val[2];
+	u8 chip_id = 0;
 
 	btrtl_dev = kzalloc_obj(*btrtl_dev);
 	if (!btrtl_dev) {
@@ -1083,8 +1112,15 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	}
 
 	INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
+	INIT_LIST_HEAD(&btrtl_dev->patch_images);
 
 check_version:
+	ret = btrtl_read_chip_id(hdev, &chip_id);
+	if (!ret && chip_id >= CHIP_ID_V3_BASE) {
+		btrtl_dev->project_id = chip_id;
+		goto read_local_ver;
+	}
+
 	ret = btrtl_vendor_read_reg16(hdev, RTL_CHIP_SUBVER, reg_val);
 	if (ret < 0)
 		goto err_free;
@@ -1107,6 +1143,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		}
 	}
 
+read_local_ver:
 	skb = btrtl_read_local_version(hdev);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
@@ -1132,9 +1169,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 					    hdev->bus, chip_type);
 
 next:
-	rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
-		     hci_ver, hci_rev,
-		     lmp_ver, lmp_subver);
+	rtl_dev_info(hdev, "hci %02x.%04x lmp %02x.%04x",
+		     hci_ver, hci_rev, lmp_ver, lmp_subver);
 
 	if (!btrtl_dev->ic_info && !btrtl_dev->drop_fw)
 		btrtl_dev->drop_fw = true;
@@ -1170,8 +1206,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	}
 
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_info(hdev, "unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
-			    lmp_subver, hci_rev, hci_ver);
+		rtl_dev_info(hdev, "unknown IC, lmp_subver %04x hci_rev %04x hci_ver %02x",
+			     lmp_subver, hci_rev, hci_ver);
 		return btrtl_dev;
 	}
 
@@ -1186,13 +1222,23 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		goto err_free;
 	}
 
-	ret = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
-	if (ret < 0)
-		goto err_free;
+	/* The DA4 key id register only exists starting from 8922A, so older
+	 * chips below CHIP_ID_V3_BASE other than 8922A are skipped here.
+	 */
+	if (btrtl_dev->project_id >= CHIP_ID_V3_BASE) {
+		ret = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ_V3, reg_val);
+		if (ret < 0)
+			goto err_free;
+		key_id = reg_val[0];
+	} else if (lmp_subver == RTL_ROM_LMP_8922A) {
+		ret = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ_V2, reg_val);
+		if (ret < 0)
+			goto err_free;
+		key_id = reg_val[0];
+	}
 
-	key_id = reg_val[0];
 	btrtl_dev->key_id = key_id;
-	rtl_dev_info(hdev, "%s: key id %u", __func__, key_id);
+	rtl_dev_info(hdev, "key id %u", key_id);
 
 	btrtl_dev->fw_len = -EIO;
 	if (lmp_subver == RTL_ROM_LMP_8852A && hci_rev == 0x000c) {
@@ -1228,12 +1274,14 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 						   &btrtl_dev->cfg_data);
 		if (btrtl_dev->ic_info->config_needed &&
 		    btrtl_dev->cfg_len <= 0) {
-			rtl_dev_err(hdev, "mandatory config file %s not found",
-				    btrtl_dev->ic_info->cfg_name);
+			rtl_dev_err(hdev, "cfg %s required", cfg_name);
 			ret = btrtl_dev->cfg_len;
 			if (!ret)
 				ret = -EINVAL;
 			goto err_free;
+		} else if (btrtl_dev->cfg_len <= 0) {
+			rtl_dev_info(hdev, "cfg %s not found, ignored",
+				     cfg_name);
 		}
 	}
 
@@ -1244,7 +1292,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		hci_set_msft_opcode(hdev, 0xFCF0);
 
 	if (btrtl_dev->ic_info)
-		coredump_info->rtl_dump.controller = btrtl_dev->ic_info->hw_info;
+		btrtl_data->rtl_dump.controller = btrtl_dev->ic_info->hw_info;
 
 	return btrtl_dev;
 
@@ -1512,6 +1560,35 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
 
+
+int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
+	struct hci_event_hdr *hdr;
+	u8 *p;
+
+	if (!clone)
+		goto out;
+
+	hdr = skb_pull_data(clone, sizeof(*hdr));
+	if (!hdr || hdr->evt != HCI_EV_VENDOR)
+		goto out;
+
+	p = skb_pull_data(clone, 1);
+	if (!p)
+		goto out;
+	switch (*p) {
+	case 0x77:
+		if (btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADING))
+			btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING);
+		break;
+	}
+out:
+	consume_skb(clone);
+	return hci_recv_frame(hdev, skb);
+}
+EXPORT_SYMBOL_GPL(btrtl_recv_event);
+
 MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index a2d9d34f9fb0..401530f48681 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -12,7 +12,22 @@
 #define rtl_dev_info(dev, fmt, ...) bt_dev_info(dev, "RTL: " fmt, ##__VA_ARGS__)
 #define rtl_dev_dbg(dev, fmt, ...) bt_dev_dbg(dev, "RTL: " fmt, ##__VA_ARGS__)
 
-struct btrtl_device_info;
+#define RTL_VSC_OP_DOWNLOAD_CMD			0xfc20
+#define RTL_VSC_OP_READ_VENDOR			0xfc61
+#define RTL_VSC_OP_WRITE_VENDOR			0xfc62
+#define RTL_VSC_OP_READ_ROM_VER			0xfc6d
+#define RTL_VSC_OP_READ_CHIP_ID			0xfc6f
+#define RTL_VSC_OP_COREDUMP			0xfcff
+#define RTL_VSC_OP_CHECK_DOWNLOAD_STATE		0xfdcf
+#define RTL_VSC_OP_WDG_RESET_CMD		0xfc8e
+
+#define FW_TYPE_V0		0
+#define FW_TYPE_V1		1
+#define FW_TYPE_V2		2
+#define FW_TYPE_V3_1		3
+#define FW_TYPE_V3_2		4
+#define is_v3_fw(type)	((type) == FW_TYPE_V3_1 || (type) == FW_TYPE_V3_2)
+#define CHIP_ID_V3_BASE		55
 
 struct rtl_chip_type_evt {
 	__u8 status;
@@ -103,8 +118,14 @@ struct rtl_vendor_cmd {
 	__u8 param[5];
 } __packed;
 
+struct rtl_rp_read_chip_id {
+	__u8 status;
+	__u8 chip_id;
+} __packed;
+
 enum {
 	REALTEK_ALT6_CONTINUOUS_TX_CHIP,
+	REALTEK_DOWNLOADING,
 
 	__REALTEK_NUM_FLAGS,
 };
@@ -130,7 +151,64 @@ struct btrealtek_data {
 #define btrealtek_get_flag(hdev)					\
 	(((struct btrealtek_data *)hci_get_priv(hdev))->flags)
 
+#define btrealtek_wake_up_flag(hdev, nr)				\
+	do {								\
+		struct btrealtek_data *rtl = hci_get_priv((hdev));	\
+		wake_up_bit(rtl->flags, (nr));				\
+	} while (0)
 #define btrealtek_test_flag(hdev, nr)	test_bit((nr), btrealtek_get_flag(hdev))
+#define btrealtek_test_and_clear_flag(hdev, nr)				\
+		test_and_clear_bit((nr), btrealtek_get_flag(hdev))
+#define btrealtek_wait_on_flag_timeout(hdev, nr, m, to)			\
+		wait_on_bit_timeout(btrealtek_get_flag(hdev), (nr), m, to)
+#define btrealtek_clear_flag(hdev, nr)					\
+		do {							\
+			struct btrealtek_data *rtl = hci_get_priv((hdev));	\
+			clear_bit((nr), rtl->flags);			\
+		} while (0)
+
+struct id_table {
+	__u16 match_flags;
+	__u16 lmp_subver;
+	__u16 hci_rev;
+	__u8 hci_ver;
+	__u8 hci_bus;
+	__u8 chip_type;
+	bool config_needed;
+	bool has_rom_version;
+	bool has_msft_ext;
+	char *fw_name;
+	char *cfg_name;
+	char *hw_info;
+};
+
+struct btrtl_device_info {
+	const struct id_table *ic_info;
+	u8 rom_version;
+	u8 *fw_data;
+	int fw_len;
+	u8 *cfg_data;
+	int cfg_len;
+	bool drop_fw;
+	int project_id;
+	u32 opcode;
+	u8 fw_type;
+	u8 key_id;
+	struct list_head patch_subsecs;
+	struct list_head patch_images;
+};
+
+/* Internal functions shared between btrtl.c and btrtl_enh.c */
+void btrtl_free_patch_images(struct btrtl_device_info *btrtl_dev);
+void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len);
+struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev);
+int btrtl_read_chip_id(struct hci_dev *hdev, u8 *chip_id);
+int rtl_download_firmware(struct hci_dev *hdev, u8 fw_type,
+			  const unsigned char *data, int fw_len);
+int rtlbt_parse_firmware_v3(struct hci_dev *hdev,
+			    struct btrtl_device_info *btrtl_dev);
+int rtl_download_firmware_v3(struct hci_dev *hdev,
+			     struct btrtl_device_info *btrtl_dev);
 
 #if IS_ENABLED(CONFIG_BT_RTL)
 
@@ -148,6 +226,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    unsigned int *controller_baudrate,
 			    u32 *device_baudrate, bool *flow_control);
 void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name);
+int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
 
 #else
 
@@ -157,6 +236,12 @@ static inline struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* Must consume the skb: ownership was handed over by the caller. */
+	return hci_recv_frame(hdev, skb);
+}
+
 static inline void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
 }
diff --git a/drivers/bluetooth/btrtl_enh.c b/drivers/bluetooth/btrtl_enh.c
new file mode 100644
index 000000000000..f4e71d908ed4
--- /dev/null
+++ b/drivers/bluetooth/btrtl_enh.c
@@ -0,0 +1,795 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Bluetooth support for Realtek devices
+ *
+ *  Copyright (C) 2026 Realtek Semiconductor Corporation.
+ */
+
+#include <linux/firmware.h>
+#include <linux/unaligned.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btrtl.h"
+
+#define RTL_VENDOR_WRITEB_TYPE		0x00
+#define RTL_VENDOR_WRITE_TYPE		0x21
+#define RTL_VENDOR_REG32_TYPE		0x20
+#define RTL_CHIP_7090A			62
+#define RTL_WRZM_CNT			48
+#define RTL_WRZM_ADDR_A			0x00403BAC
+#define RTL_WRZM_ADDR_B			0x00400018
+#define RTL_WRZM_ADDR_C			0x00400014
+#define RTL_PATCH_V3_1		0x01
+#define RTL_PATCH_V3_2		0x02
+#define IMAGE_ID_F000		0xf000
+#define IMAGE_ID_F001		0xf001
+#define IMAGE_ID_F002		0xf002
+
+#define DL_FIX_CI_ID		0
+#define DL_FIX_CI_ADDR		1
+#define DL_FIX_PATCH_ADDR	2
+#define DL_FIX_SEC_HDR_ADDR	3
+#define DL_FIX_ADDR_MAX		4
+
+struct rtl_vendor_write_cmd {
+	u8 type;
+	__le32 addr;
+	__le32 val;
+} __packed;
+
+struct rtl_vendor_writeb_cmd {
+	u8 type;
+	__le32 addr;
+	u8 val;
+} __packed;
+
+struct rtl_vendor_read_cmd {
+	u8 type;
+	__le32 addr;
+} __packed;
+
+struct rtl_vendor_read_rsp {
+	u8 status;
+	__le32 val;
+} __packed;
+
+struct rtl_rp_dl_v3 {
+	__u8 status;
+	__u8 index;
+	__u8 err;
+} __packed;
+
+struct rtl_epatch_header_v3 {
+	__u8 signature[8];
+	__u8 timestamp[8];
+	__le32 ver_rsvd;
+	__le32 num_sections;
+} __packed;
+
+struct rtl_section_v3 {
+	__le32 opcode;
+	__le64 len;
+	u8 data[];
+} __packed;
+
+struct rtl_addr_fix {
+	u32 addr;
+	u32 value;
+};
+
+struct rtl_section_patch_image {
+	u16 image_id;
+	u8 index;
+	u8 config_rule;
+	u8 need_config;
+
+	struct rtl_addr_fix fix[DL_FIX_ADDR_MAX];
+
+	u32 image_len;
+	u8 *image_data;
+	u32 image_ver;
+
+	u8  *cfg_buf;
+	u32 cfg_len;
+
+	struct list_head list;
+};
+
+struct rtl_patch_image_hdr {
+	__le16 chip_id;
+	u8 ic_cut;
+	u8 key_id;
+	u8 enable_ota;
+	__le16 image_id;
+	u8 config_rule;
+	u8 need_config;
+	u8 rsv[950];
+
+	__le64 addr_fix[DL_FIX_ADDR_MAX * 2];
+	u8 index;
+
+	__le64 patch_image_len;
+	__u8 data[];
+} __packed;
+
+static int btrtl_vendor_write_mem(struct hci_dev *hdev, u32 addr, u32 val)
+{
+	struct rtl_vendor_write_cmd cp;
+	struct sk_buff *skb;
+	int err = 0;
+
+	cp.type = RTL_VENDOR_WRITE_TYPE;
+	cp.addr = cpu_to_le32(addr);
+	cp.val = cpu_to_le32(val);
+	skb = __hci_cmd_sync(hdev, RTL_VSC_OP_WRITE_VENDOR, sizeof(cp), &cp, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "RTL: Write mem32 failed (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int btrtl_vendor_read_reg32(struct hci_dev *hdev, u32 addr, u32 *val)
+{
+	struct rtl_vendor_read_cmd cp;
+	struct rtl_vendor_read_rsp *rp;
+	struct sk_buff *skb;
+	int err = 0;
+
+	cp.type = RTL_VENDOR_REG32_TYPE;
+	cp.addr = cpu_to_le32(addr);
+	skb = __hci_cmd_sync(hdev, RTL_VSC_OP_READ_VENDOR,
+			     sizeof(cp), &cp, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	rp = skb_pull_data(skb, sizeof(*rp));
+	if (!rp || rp->status)
+		err = -EIO;
+	else
+		*val = le32_to_cpu(rp->val);
+
+	kfree_skb(skb);
+	return err;
+}
+
+static int btrtl_vendor_write_reg32(struct hci_dev *hdev, u32 addr, u32 val)
+{
+	struct rtl_vendor_write_cmd cp;
+	struct sk_buff *skb;
+
+	cp.type = RTL_VENDOR_REG32_TYPE;
+	cp.addr = cpu_to_le32(addr);
+	cp.val  = cpu_to_le32(val);
+	skb = __hci_cmd_sync(hdev, RTL_VSC_OP_WRITE_VENDOR,
+			     sizeof(cp), &cp, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+	kfree_skb(skb);
+	return 0;
+}
+
+static int btrtl_vendor_write_reg8(struct hci_dev *hdev, u32 addr, u8 val)
+{
+	struct rtl_vendor_writeb_cmd cp;
+	struct sk_buff *skb;
+
+	cp.type = RTL_VENDOR_WRITEB_TYPE;
+	cp.addr = cpu_to_le32(addr);
+	cp.val  = val;
+	skb = __hci_cmd_sync(hdev, RTL_VSC_OP_WRITE_VENDOR,
+			     sizeof(cp), &cp, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+	kfree_skb(skb);
+	return 0;
+}
+
+static int btrtl_wrzm(struct hci_dev *hdev,
+		      struct btrtl_device_info *btrtl_dev)
+{
+	u32 val;
+	int ret;
+	int i;
+
+	for (i = 0; i < RTL_WRZM_CNT; i++) {
+		ret = btrtl_vendor_read_reg32(hdev, RTL_WRZM_ADDR_A + i * 4, &val);
+		if (ret) {
+			rtl_dev_err(hdev, "WRZM: read[%d] failed (%d)", i, ret);
+			return ret;
+		}
+		ret = btrtl_vendor_write_reg32(hdev, RTL_WRZM_ADDR_B + i * 4, val);
+		if (ret) {
+			rtl_dev_err(hdev, "WRZM: write[%d] failed (%d)", i, ret);
+			return ret;
+		}
+	}
+
+	ret = btrtl_vendor_read_reg32(hdev, RTL_WRZM_ADDR_C, &val);
+	if (ret) {
+		rtl_dev_err(hdev, "WRZM: read (part2) failed (%d)", ret);
+		return ret;
+	}
+
+	val |= 0x10;
+
+	ret = btrtl_vendor_write_reg8(hdev, RTL_WRZM_ADDR_C, val);
+	if (ret) {
+		rtl_dev_err(hdev, "WRZM: write (part2) failed (%d)", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void btrtl_insert_ordered_patch_image(struct rtl_section_patch_image *image,
+					     struct btrtl_device_info *btrtl_dev)
+{
+	struct list_head *pos;
+	struct list_head *next;
+	struct rtl_section_patch_image *node;
+
+	list_for_each_safe(pos, next, &btrtl_dev->patch_images) {
+		node = list_entry(pos, struct rtl_section_patch_image, list);
+
+		if (node->image_id > image->image_id) {
+			__list_add(&image->list, pos->prev, pos);
+			return;
+		}
+
+		if (node->image_id == image->image_id &&
+		    node->index > image->index) {
+			__list_add(&image->list, pos->prev, pos);
+			return;
+		}
+	}
+	__list_add(&image->list, pos->prev, pos);
+}
+
+static int rtlbt_parse_config(struct hci_dev *hdev,
+			      struct rtl_section_patch_image *patch_image,
+			      struct btrtl_device_info *btrtl_dev)
+{
+	const struct firmware *fw;
+	char tmp_name[32];
+	char filename[64];
+	u8 *cfg_buf;
+	char *str;
+	char *p;
+	size_t len;
+	int ret;
+
+	/* V3_1 appends the chip config, already loaded by btrtl_initialize(),
+	 * to the first image only.
+	 */
+	if (btrtl_dev->fw_type == FW_TYPE_V3_1) {
+		if (patch_image->image_id || patch_image->index ||
+		    btrtl_dev->cfg_len <= 0)
+			return 0;
+
+		cfg_buf = kvmemdup(btrtl_dev->cfg_data, btrtl_dev->cfg_len,
+				   GFP_KERNEL);
+		if (!cfg_buf)
+			return -ENOMEM;
+
+		patch_image->cfg_buf = cfg_buf;
+		patch_image->cfg_len = btrtl_dev->cfg_len;
+		return 0;
+	}
+
+	if (!patch_image->config_rule || !patch_image->need_config)
+		return 0;
+
+	switch (patch_image->image_id) {
+	case IMAGE_ID_F000:
+	case IMAGE_ID_F001:
+	case IMAGE_ID_F002:
+		break;
+	default:
+		return 0;
+	}
+
+	str = btrtl_dev->ic_info->cfg_name;
+	if (!str)
+		goto use_default;
+
+	len = strlen(str);
+	if (len > sizeof(tmp_name) - 1)
+		len = sizeof(tmp_name) - 1;
+	memcpy(tmp_name, str, len);
+	tmp_name[len] = '\0';
+
+	str = tmp_name;
+	p = strsep(&str, ".");
+
+	snprintf(filename, sizeof(filename), "%s_%04x.%s", p,
+		 patch_image->image_id, str ? str : "bin");
+
+	ret = firmware_request_nowarn(&fw, filename, &hdev->dev);
+	if (ret < 0) {
+		rtl_dev_info(hdev, "cfg %s not found, use default", filename);
+		goto use_default;
+	}
+
+	cfg_buf = kvmemdup(fw->data, fw->size, GFP_KERNEL);
+	len = fw->size;
+	release_firmware(fw);
+	if (!cfg_buf)
+		return -ENOMEM;
+
+	rtl_dev_info(hdev, "cfg %s found", filename);
+	patch_image->cfg_buf = cfg_buf;
+	patch_image->cfg_len = len;
+
+	return 0;
+
+use_default:
+	cfg_buf = kvmalloc(4, GFP_KERNEL);
+	if (!cfg_buf)
+		return -ENOMEM;
+
+	memset(cfg_buf, 0xff, 4);
+	patch_image->cfg_buf = cfg_buf;
+	patch_image->cfg_len = 4;
+	return 0;
+}
+
+static int rtlbt_parse_section_v3(struct hci_dev *hdev,
+				  struct btrtl_device_info *btrtl_dev,
+				  u32 opcode, u8 *data, u32 len)
+{
+	struct rtl_section_patch_image *patch_image;
+	struct rtl_patch_image_hdr *hdr;
+	u16 image_id;
+	u16 chip_id;
+	size_t patch_image_len;
+	u8 *ptr;
+	int ret = 0;
+	size_t i;
+	struct rtl_iovec iov = {
+		.data = data,
+		.len  = len,
+	};
+
+	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
+	if (!hdr)
+		return -EINVAL;
+
+	if (btrtl_dev->opcode && btrtl_dev->opcode != opcode) {
+		rtl_dev_err(hdev, "invalid opcode 0x%02x", opcode);
+		return -EINVAL;
+	}
+
+	if (!btrtl_dev->opcode) {
+		btrtl_dev->opcode = opcode;
+		switch (btrtl_dev->opcode) {
+		case RTL_PATCH_V3_1:
+			btrtl_dev->fw_type = FW_TYPE_V3_1;
+			break;
+		case RTL_PATCH_V3_2:
+			btrtl_dev->fw_type = FW_TYPE_V3_2;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	patch_image_len = (u32)le64_to_cpu(hdr->patch_image_len);
+	chip_id = le16_to_cpu(hdr->chip_id);
+	image_id = le16_to_cpu(hdr->image_id);
+
+	if (btrtl_dev->key_id != hdr->key_id) {
+		rtl_dev_info(hdev, "skip %04x:%02x: key_id %u != %u",
+			     image_id, hdr->index, hdr->key_id,
+			     btrtl_dev->key_id);
+		return 0;
+	}
+
+	if (hdr->ic_cut != btrtl_dev->rom_version + 1) {
+		rtl_dev_info(hdev, "skip %04x:%02x: ic_cut %u != %u",
+			     image_id, hdr->index, hdr->ic_cut,
+			     btrtl_dev->rom_version + 1);
+		return 0;
+	}
+
+	if (btrtl_dev->fw_type == FW_TYPE_V3_1 && !btrtl_dev->project_id)
+		btrtl_dev->project_id = chip_id;
+
+	if (btrtl_dev->fw_type == FW_TYPE_V3_2 &&
+	    chip_id != btrtl_dev->project_id) {
+		rtl_dev_info(hdev, "skip %04x:%02x: chip_id %u != %d",
+			     image_id, hdr->index, chip_id,
+			     btrtl_dev->project_id);
+		return 0;
+	}
+
+	rtl_dev_info(hdev, "sub %04x:%02x chip %u cut %02x len %08zx",
+		     image_id, hdr->index, chip_id, hdr->ic_cut,
+		     patch_image_len);
+
+	ptr = rtl_iov_pull_data(&iov, patch_image_len);
+	if (!ptr)
+		return -ENODATA;
+
+	patch_image = kzalloc_obj(*patch_image);
+	if (!patch_image)
+		return -ENOMEM;
+	patch_image->index = hdr->index;
+	patch_image->image_id = image_id;
+	patch_image->config_rule = hdr->config_rule;
+	patch_image->need_config = hdr->need_config;
+
+	for (i = 0; i < DL_FIX_ADDR_MAX; i++) {
+		patch_image->fix[i].addr =
+			(u32)le64_to_cpu(hdr->addr_fix[i * 2]);
+		patch_image->fix[i].value =
+			(u32)le64_to_cpu(hdr->addr_fix[i * 2 + 1]);
+	}
+
+	patch_image->image_len = patch_image_len;
+
+	if (patch_image_len < 4) {
+		rtl_dev_err(hdev, "subsection payload too short (%zu)",
+			    patch_image_len);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	patch_image->image_data = kvmalloc(patch_image_len, GFP_KERNEL);
+	if (!patch_image->image_data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	memcpy(patch_image->image_data, ptr, patch_image_len);
+	patch_image->image_ver =
+		get_unaligned_le32(ptr + patch_image->image_len - 4);
+	rtl_dev_info(hdev, "subsection ver %08x", patch_image->image_ver);
+
+	ret = rtlbt_parse_config(hdev, patch_image, btrtl_dev);
+	if (ret) {
+		rtl_dev_err(hdev, "config parse failed (%d)", ret);
+		goto err;
+	}
+
+	ret = patch_image->image_len;
+
+	btrtl_insert_ordered_patch_image(patch_image, btrtl_dev);
+
+	return ret;
+err:
+	kvfree(patch_image->image_data);
+	kvfree(patch_image->cfg_buf);
+	kfree(patch_image);
+	return ret;
+}
+
+int rtlbt_parse_firmware_v3(struct hci_dev *hdev,
+			    struct btrtl_device_info *btrtl_dev)
+{
+	struct rtl_epatch_header_v3 *hdr;
+	int rc;
+	u32 num_sections;
+	struct rtl_section_v3 *section;
+	u32 section_len;
+	u32 opcode;
+	int len = 0;
+	int i;
+	u8 *ptr;
+	struct rtl_iovec iov = {
+		.data = btrtl_dev->fw_data,
+		.len  = btrtl_dev->fw_len,
+	};
+
+	rtl_dev_info(hdev, "fw key id %u", btrtl_dev->key_id);
+
+	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
+	if (!hdr)
+		return -EINVAL;
+	num_sections = le32_to_cpu(hdr->num_sections);
+
+	rtl_dev_dbg(hdev, "timestamp %08x-%08x",
+		    get_unaligned_le32(hdr->timestamp),
+		    get_unaligned_le32(hdr->timestamp + 4));
+
+	for (i = 0; i < num_sections; i++) {
+		section = rtl_iov_pull_data(&iov, sizeof(*section));
+		if (!section)
+			return -EINVAL;
+
+		section_len = (u32)le64_to_cpu(section->len);
+		opcode = le32_to_cpu(section->opcode);
+
+		rtl_dev_dbg(hdev, "opcode 0x%04x", section->opcode);
+
+		ptr = rtl_iov_pull_data(&iov, section_len);
+		if (!ptr)
+			return -EINVAL;
+
+		rc = 0;
+		switch (opcode) {
+		case RTL_PATCH_V3_1:
+		case RTL_PATCH_V3_2:
+			rc = rtlbt_parse_section_v3(hdev, btrtl_dev, opcode,
+						    ptr, section_len);
+			break;
+		default:
+			rtl_dev_warn(hdev, "Unknown opcode %08x", opcode);
+			break;
+		}
+		if (rc < 0) {
+			rtl_dev_err(hdev, "Parse section (%u) err (%d)",
+				    opcode, rc);
+			return rc;
+		}
+		len += rc;
+	}
+
+	rtl_dev_info(hdev, "fw payload len 0x%08x", len);
+	if (!len) {
+		rtl_dev_err(hdev, "no matching firmware section found");
+		return -ENODATA;
+	}
+
+	return len;
+}
+
+static int rtl_check_download_state(struct hci_dev *hdev,
+				    struct btrtl_device_info *btrtl_dev)
+{
+	struct sk_buff *skb;
+	int ret = 0;
+
+	btrealtek_set_flag(hdev, REALTEK_DOWNLOADING);
+
+	skb = __hci_cmd_sync(hdev, RTL_VSC_OP_CHECK_DOWNLOAD_STATE, 0, NULL,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		/* Controller returns status 0x03 (mapped to -EIO by
+		 * bt_to_errno) when another driver is downloading the
+		 * combined firmware.
+		 */
+		if (ret != -EIO) {
+			rtl_dev_err(hdev, "write tb error %d", ret);
+			goto out;
+		}
+
+		ret = btrealtek_wait_on_flag_timeout(hdev, REALTEK_DOWNLOADING,
+						     TASK_INTERRUPTIBLE,
+						     msecs_to_jiffies(5000));
+		if (ret == -EINTR) {
+			bt_dev_err(hdev, "Firmware loading interrupted");
+			goto out;
+		}
+
+		if (ret) {
+			bt_dev_err(hdev, "Firmware loading timeout");
+			ret = -ETIMEDOUT;
+		} else {
+			ret = -EALREADY;
+		}
+		goto out;
+	}
+
+	kfree_skb(skb);
+out:
+	btrealtek_clear_flag(hdev, REALTEK_DOWNLOADING);
+	return ret;
+}
+
+static int rtl_finalize_download(struct hci_dev *hdev,
+				 struct btrtl_device_info *btrtl_dev)
+{
+	struct hci_rp_read_local_version *rp_ver;
+	u8 params[2] = { 0x03, 0xb2 };
+	struct sk_buff *skb;
+	int ret = 0;
+	u16 opcode;
+	u32 len;
+	u8 *p;
+
+	opcode = RTL_VSC_OP_WDG_RESET_CMD;
+	len = 2;
+	if (btrtl_dev->opcode == RTL_PATCH_V3_1) {
+		opcode = RTL_VSC_OP_DOWNLOAD_CMD;
+		params[0] = 0x80;
+		len = 1;
+	}
+	skb = __hci_cmd_sync(hdev, opcode, len, params, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		rtl_dev_err(hdev, "Watchdog reset err (%ld)", PTR_ERR(skb));
+		return -EIO;
+	}
+	p = skb_pull_data(skb, 1);
+	if (!p) {
+		ret = -ENODATA;
+		goto out;
+	}
+	rtl_dev_info(hdev, "Watchdog reset status %02x", *p);
+	kfree_skb(skb);
+
+	skb = btrtl_read_local_version(hdev);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		rtl_dev_err(hdev, "read local version failed (%d)", ret);
+		return ret;
+	}
+
+	rp_ver = skb_pull_data(skb, sizeof(*rp_ver));
+	if (rp_ver)
+		rtl_dev_info(hdev, "fw version 0x%04x%04x",
+			     __le16_to_cpu(rp_ver->hci_rev),
+			     __le16_to_cpu(rp_ver->lmp_subver));
+out:
+	kfree_skb(skb);
+	return ret;
+}
+
+static int rtl_security_check(struct hci_dev *hdev,
+			      struct btrtl_device_info *btrtl_dev)
+{
+	struct rtl_section_patch_image *tmp = NULL;
+	struct rtl_section_patch_image *image = NULL;
+	u32 val;
+	int ret;
+
+	list_for_each_entry_reverse(tmp, &btrtl_dev->patch_images, list) {
+		/* Check security hdr */
+		if (!tmp->fix[DL_FIX_SEC_HDR_ADDR].value ||
+		    !tmp->fix[DL_FIX_SEC_HDR_ADDR].addr ||
+		    tmp->fix[DL_FIX_SEC_HDR_ADDR].addr == 0xffffffff)
+			continue;
+		rtl_dev_info(hdev, "sec hdr addr 0x%08x val 0x%08x",
+			     tmp->fix[DL_FIX_SEC_HDR_ADDR].addr,
+			     tmp->fix[DL_FIX_SEC_HDR_ADDR].value);
+		image = tmp;
+		break;
+	}
+
+	if (!image)
+		return 0;
+
+	rtl_dev_info(hdev, "sec subsection %04x:%02x", image->image_id,
+		     image->index);
+	val = image->fix[DL_FIX_PATCH_ADDR].value + image->image_len -
+					image->fix[DL_FIX_SEC_HDR_ADDR].value;
+	ret = btrtl_vendor_write_mem(hdev, image->fix[DL_FIX_PATCH_ADDR].addr,
+				     val);
+	if (ret) {
+		rtl_dev_err(hdev, "write sec reg failed (%d)", ret);
+		return ret;
+	}
+	return 0;
+}
+
+int rtl_download_firmware_v3(struct hci_dev *hdev,
+			     struct btrtl_device_info *btrtl_dev)
+{
+	struct rtl_section_patch_image *image, *tmp;
+	struct rtl_rp_dl_v3 *rp;
+	struct sk_buff *skb;
+	u8 *fw_data;
+	int fw_len;
+	int ret = 0;
+	u8 i;
+
+	if (btrtl_dev->project_id == RTL_CHIP_7090A) {
+		ret = btrtl_wrzm(hdev, btrtl_dev);
+		if (ret) {
+			rtl_dev_err(hdev, "v3 WRZM failed (%d)", ret);
+			return ret;
+		}
+	}
+
+	if (btrtl_dev->fw_type == FW_TYPE_V3_2) {
+		ret = rtl_check_download_state(hdev, btrtl_dev);
+		if (ret) {
+			if (ret == -EALREADY)
+				return 0;
+			return ret;
+		}
+	}
+
+	list_for_each_entry_safe(image, tmp, &btrtl_dev->patch_images, list) {
+		rtl_dev_dbg(hdev, "image (%04x:%02x)", image->image_id,
+			    image->index);
+
+		for (i = DL_FIX_CI_ID; i < DL_FIX_ADDR_MAX; i++) {
+			if (!image->fix[i].addr ||
+			    image->fix[i].addr == 0xffffffff) {
+				rtl_dev_dbg(hdev, "no need to write addr %08x",
+					    image->fix[i].addr);
+				continue;
+			}
+			rtl_dev_dbg(hdev, "write addr and val, 0x%08x, 0x%08x",
+				    image->fix[i].addr, image->fix[i].value);
+			if (btrtl_vendor_write_mem(hdev, image->fix[i].addr,
+						   image->fix[i].value)) {
+				rtl_dev_err(hdev, "write reg failed");
+				ret = -EIO;
+				goto done;
+			}
+		}
+
+		fw_len = image->image_len + image->cfg_len;
+		fw_data = kvmalloc(fw_len, GFP_KERNEL);
+		if (!fw_data) {
+			rtl_dev_err(hdev, "Couldn't alloc buf for image data");
+			ret = -ENOMEM;
+			goto done;
+		}
+		memcpy(fw_data, image->image_data, image->image_len);
+		if (image->cfg_len > 0)
+			memcpy(fw_data + image->image_len, image->cfg_buf,
+			       image->cfg_len);
+
+		rtl_dev_dbg(hdev, "patch image (%04x:%02x). len: %d",
+			    image->image_id, image->index, fw_len);
+		rtl_dev_dbg(hdev, "fw_data %p, image buf %p, len %u", fw_data,
+			    image->image_data, image->image_len);
+
+		ret = rtl_download_firmware(hdev, btrtl_dev->fw_type, fw_data,
+					    fw_len);
+		kvfree(fw_data);
+		if (ret < 0) {
+			rtl_dev_err(hdev, "download firmware failed (%d)", ret);
+			goto done;
+		}
+
+		if (image->list.next != &btrtl_dev->patch_images &&
+		    image->image_id == tmp->image_id)
+			continue;
+
+		if (btrtl_dev->fw_type == FW_TYPE_V3_1)
+			continue;
+
+		i = 0x80;
+		skb = __hci_cmd_sync(hdev, RTL_VSC_OP_DOWNLOAD_CMD, 1, &i, HCI_CMD_TIMEOUT);
+		if (IS_ERR(skb)) {
+			ret = -EIO;
+			rtl_dev_err(hdev, "Failed to issue last cmd fc20, %ld",
+				    PTR_ERR(skb));
+			goto done;
+		}
+		ret = 2;
+		rp = skb_pull_data(skb, sizeof(*rp));
+		if (rp)
+			ret = rp->err;
+		kfree_skb(skb);
+		if (ret == 2) {
+			/* Verification failure */
+			ret = -EFAULT;
+			goto done;
+		}
+	}
+
+	if (btrtl_dev->fw_type == FW_TYPE_V3_1) {
+		ret = rtl_security_check(hdev, btrtl_dev);
+		if (ret) {
+			rtl_dev_err(hdev, "Security check failed (%d)", ret);
+			goto done;
+		}
+	}
+
+	ret = rtl_finalize_download(hdev, btrtl_dev);
+
+done:
+	return ret;
+}
+
+void btrtl_free_patch_images(struct btrtl_device_info *btrtl_dev)
+{
+	struct rtl_section_patch_image *image, *next;
+
+	list_for_each_entry_safe(image, next, &btrtl_dev->patch_images, list) {
+		list_del(&image->list);
+		kvfree(image->image_data);
+		kvfree(image->cfg_buf);
+		kfree(image);
+	}
+}
diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 95398e2ca098..812ff575a560 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -2976,20 +2976,23 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
 
 static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (skb->len >= HCI_EVENT_HDR_SIZE + 1 &&
-	    skb->data[0] == HCI_EV_VENDOR &&
-	    skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
-		struct rtk_dev_coredump_hdr hdr = {
-			.code = RTK_DEVCOREDUMP_CODE_MEMDUMP,
-		};
+	if (skb->len >= 1 && skb->data[0] == HCI_EV_VENDOR) {
+		if (skb->len >= HCI_EVENT_HDR_SIZE + 1 &&
+		    skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
+			struct rtk_dev_coredump_hdr hdr = {
+				.code = RTK_DEVCOREDUMP_CODE_MEMDUMP,
+			};
 
-		bt_dev_dbg(hdev, "RTL: received coredump vendor evt, len %u",
-			skb->len);
+			bt_dev_dbg(hdev, "RTL: received coredump vendor evt, len %u",
+				   skb->len);
 
-		btusb_rtl_alloc_devcoredump(hdev, &hdr, skb->data, skb->len);
-		kfree_skb(skb);
+			btusb_rtl_alloc_devcoredump(hdev, &hdr, skb->data, skb->len);
+			kfree_skb(skb);
 
-		return 0;
+			return 0;
+		}
+
+		return btrtl_recv_event(hdev, skb);
 	}
 
 	return hci_recv_frame(hdev, skb);
-- 
2.34.1


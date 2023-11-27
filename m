Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEDEhp2I"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4506E111
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Nov 2023 20:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701059388; x=1732595388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jKQ6lQfoYwBKaCQURyeN612gsc+AHcMCKe4AlB11gYQ=;
  b=XEDEhp2IdJaYXLA9WVmaWXs+JX+5Gac/smdLZtd0APGw/ow9FxvMQyP+
   GQ8TzajNMsGA1MOJcuKSoJIwYsYrkcealBFvnrhf+nyaPO8jSlpbJvz48
   TIdQtCVRGmzKzXJ1utsIs0luvqMdQPjfcuURLbgeJC6RnuKcnBQekCNg4
   uzPPdX6+kW4eIL0JDg7ZFB55EIouA+ch0t63oqmbFhGVC26wdVMVMv1EQ
   XG5C7mUi6k+9mtMJGg6tsKdC4h8N49MVyIiOldWuflZtf4e6MI8t/5kl8
   VBp+egyFIvtesh9Bmuo6RXpJa4QTCQXTsL7sv3WFpEU7sr24IEMoDQKYg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="395451632"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="395451632"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 20:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="834209747"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="834209747"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2023 20:29:46 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH] Bluetooth: btintel: Print firmware SHA1
Date: Mon, 27 Nov 2023 10:12:02 +0530
Message-Id: <20231127044202.2456465-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Read Version event contains a TLV(0x32) having firmware sha1 in
operational image.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 5 +++++
 drivers/bluetooth/btintel.h | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2462796a512a..cdc5c08824a0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -535,6 +535,8 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
 		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
 		    version->build_type, version->build_num);
+	if (version->img_type == 0x03)
+		bt_dev_info(hdev, "Firmware SHA1: 0x%8.8x", version->git_sha1);
 
 	return 0;
 }
@@ -630,6 +632,9 @@ static int btintel_parse_version_tlv(struct hci_dev *hdev,
 			memcpy(&version->otp_bd_addr, tlv->val,
 							sizeof(bdaddr_t));
 			break;
+		case INTEL_TLV_GIT_SHA1:
+			version->git_sha1 = get_unaligned_le32(tlv->val);
+			break;
 		default:
 			/* Ignore rest of information */
 			break;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 3a2d5b4219dd..d19fcdb9ff0b 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -41,7 +41,8 @@ enum {
 	INTEL_TLV_LIMITED_CCE,
 	INTEL_TLV_SBE_TYPE,
 	INTEL_TLV_OTP_BDADDR,
-	INTEL_TLV_UNLOCKED_STATE
+	INTEL_TLV_UNLOCKED_STATE,
+	INTEL_TLV_GIT_SHA1
 };
 
 struct intel_tlv {
@@ -69,6 +70,7 @@ struct intel_version_tlv {
 	u8	min_fw_build_yy;
 	u8	limited_cce;
 	u8	sbe_type;
+	u32	git_sha1;
 	bdaddr_t otp_bd_addr;
 };
 
-- 
2.34.1


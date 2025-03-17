Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB417A306
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226524; cv=none; b=QQ6KJ+PfUx+poqoaTW5Ia23HvsaKYjmeJUxSbLc9P/p1iF6iHrrRd0kmeT5nmpis0wn1c6JVtNuZ7e06jffSlzgAOolAdAaUefS3wlnFKRvj2hIWfn77FYW7aBiN7lzVypISPUyJ4nVjJ5V/ytFF5jdOXGx+WI0sEb/ZBRGEQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226524; c=relaxed/simple;
	bh=Zz+WCCXiHzMLyva4BSb01Z+SnaqfspwgGaXzYTHP2Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pS1SV8FWrcxciVT6ST3SCpaqGs27hEBwlnOVR4kqWoSDZIjF8SlNKdYXEXMwVkBXtzy/U2UsjIN0Nzoc2fnbYCXNsEG9cywWDEXvWwA/NzL6fJkGAfTCsT0x8QD/tfxQyxliQSys0H4DTx0r3l9L/8Rqxm1HqDlyX3RHdZJOEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LEH0gO8c; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LEH0gO8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742226495;
	bh=Zs4cpVMqM3ZFudIC35Oc9zlGWAXQROlePX/6nmzF3FI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LEH0gO8cvfyBafWyab//pETHwLz/oXPwYJGvDygZJrHuAccZool22qlan9qM8T33X
	 UrIMVBF+0/cOV0m6+zgpmNIQ0zKzwnWpf4+6Gvh575DifA4C8VJehCbpPQ/LTK1D71
	 Hd9XPH6EBX5c5s8admfpe7Gj45DKvJdzDBIUkVeg=
X-QQ-mid: bizesmtp85t1742226478telnw9a7
X-QQ-Originating-IP: T6j8Ppr5ITOJPWQ+ugYpvULi3LYk07TlyimTXME0qR8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 23:47:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6566465575593803571
From: Wentao Guan <guanwentao@uniontech.com>
To: luiz.von.dentz@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel
Date: Mon, 17 Mar 2025 23:47:16 +0800
Message-Id: <20250317154715.15023-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MW2WLBvYEeCvaIVkrEAlvtOJzc8PrioByYQL23wkwFhKB7uMcoX4esg7
	6WmSFWpp+4W1OPTXRI//8brQqyHT0gzBjk5G5KctHac1tDJd52NerMSP0aWFN5CX/8hUUAd
	oN5ep4ObjJkTkUV45OguIlfBlB9xTrvbiRPE8YstRukLqZSFjq+DgQGdGE2Y02SdhSDiVeq
	0HaRImxMSwgg5VJ2OqUSJHP9x2R1eVr3BJP1wNvE+okKee4nbgX+bb/nsKOHXhm7e2Nsac2
	JjhvMFNhGRF7GeCYK60zXslfCH2XEdrx0k4VTJKDI65icliPNtw6PyO1WDLC5TPCILB6GsI
	PyJGHomOOdghrTF7SuZimEKk+uyyPWW4xOkxJjU/JlbadrtrQUZjFDFIG5Wa/m1P2XWaW6F
	dWYLlgNWMu7DvfQYW3HDG4ZPVeIeHEULpTBnxR3Inv8qk7bv6bfhdD3sUt/bSNNMimf+JxV
	2WbIiPZ3qckqYSU/1626/GRo+JQx1BPEvwlY4tbgaplRp7wGC1PQFvD3A21gUvRBFqJaRBY
	3TxdXN4WZhsBPEx9uxaByfiZCxAsg57jXsWfHp/gFP6JgdANO6HH4ylVgC4YeFYNG5Qius3
	juvhCZRRZTKRqqJqFQWufUEDRjlgSg6MMCaaFzWWjsbRMIf9fA8WSmD4/FI3J2LQQ10tBui
	Pa8qXutmbSLVnsrVnxli+NCoezUJskmVsS1LtUC/ftVtTJcKnbBjhAG/z8Pcf4xjBF296ZJ
	IvktbviQShfJcFP9gmwELhqocMn5vRXggyLVRmrGwP9dLy42hwh43y7JMiNGfFCigBth6eN
	dnHvZbDGMfSrz6OdrQvQ9oPvTlOrJ+F4UrUfSWN1I/ODXFPRFjE/t9CJ5Iavv/jZxxiIwLt
	eDxO2bPJCdO8D6ykVwkUc5/bKWM+xYuY0YUXVZXuzJHD1WcDoxUrxwwI2DoPggSEEPMaLPE
	noOfDhIxoNGgrokehKZ7gt2YvxZSZRsxy6fTwMoE1Gff/FdWJy+YeEw7hPzptk+D2X1kCGm
	iak89TgSKg6RIfxmjG
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Return Parameters is not only status, also bdaddr:

BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E
page 1870:
BLUETOOTH CORE SPECIFICATION Version 5.0 | Vol 2, Part E
page 802:

Return parameters:
  Status:
  Size: 1 octet
  BD_ADDR:
  Size: 6 octets

Note that it also fixes the warning:
"Bluetooth: hci0: unexpected cc 0x041a length: 7 > 1"

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/net/bluetooth/hci.h | 5 +++++
 net/bluetooth/hci_event.c   | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0d51970d809f..b9a95c2735e0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -855,6 +855,11 @@ struct hci_cp_remote_name_req_cancel {
 	bdaddr_t bdaddr;
 } __packed;
 
+struct hci_rp_remote_name_req_cancel {
+	__u8     status;
+	bdaddr_t bdaddr;
+} __packed;
+
 #define HCI_OP_READ_REMOTE_FEATURES	0x041b
 struct hci_cp_read_remote_features {
 	__le16   handle;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2cc7a9306350..a7b0e36609d9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4005,8 +4005,8 @@ static const struct hci_cc {
 	HCI_CC_STATUS(HCI_OP_INQUIRY_CANCEL, hci_cc_inquiry_cancel),
 	HCI_CC_STATUS(HCI_OP_PERIODIC_INQ, hci_cc_periodic_inq),
 	HCI_CC_STATUS(HCI_OP_EXIT_PERIODIC_INQ, hci_cc_exit_periodic_inq),
-	HCI_CC_STATUS(HCI_OP_REMOTE_NAME_REQ_CANCEL,
-		      hci_cc_remote_name_req_cancel),
+	HCI_CC(HCI_OP_REMOTE_NAME_REQ_CANCEL,
+		      hci_cc_remote_name_req_cancel, sizeof(struct hci_rp_remote_name_req_cancel)),
 	HCI_CC(HCI_OP_ROLE_DISCOVERY, hci_cc_role_discovery,
 	       sizeof(struct hci_rp_role_discovery)),
 	HCI_CC(HCI_OP_READ_LINK_POLICY, hci_cc_read_link_policy,
-- 
2.20.1


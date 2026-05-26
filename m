Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0738401A32
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815035; cv=none; b=ltZR4ujNB68A50+JKJdF4v09E6uPGonmlM51o63EreFehMXaifS8vu1MDVx4ErXtASObDH+XYHm9tItCBoo/pzK+cDpTlD3JTI4dmwIJJu6QfyjpGsb4n3Gpz17I2DDcO4DeiwJ+eykPnBT0IvdDn4mgbybpjn7KkBCsL+sI/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815035; c=relaxed/simple;
	bh=kLK7n+vkcbNbpkN7XtfAaK1ANG/3jmVhnzeALSz9vc4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P8/y/efILts3gbvS+nPBxy02UtN3VQ5etp2f3WcM6IF6TdPrnYOsptbfUP4+ox9SqVW7PJEE7rxifMhWYiHkzhNcTQHOWgkAanAmi1V2R0F19jij3+yRET+i+qVydUzhGLhImA2AqQ3LzPOA3LvOMZGT8pILOcEE5I18habmVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebje1mxF; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebje1mxF"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-575320e6f2aso8817916e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779815032; x=1780419832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ub7zbATpGlY9mMap+Zj829sRZ8OviYmLdectZ67fEn4=;
        b=ebje1mxFe8gN8cwPHT9wrPTCEtXfMtVLMpZlLHG5zv8jIw9CybLBDiQtDQq7c6QJQg
         uzZOfCipe6xurpR/lwl6QSwkfQgIrlou4Trjt98LPedSp2Ga6UG8lXgFulbu1c7DoxFw
         HDLzxYX1CL/pUhB+b4NjvaFv5/yJ2oDBtdO6mTJ6bycrgYG1n32Kt+5/5EUDCCPTyGQc
         ZjLdSldRfRegRD1w28vHV0Fp1b9ZBNLrIaIe29UyuUxoO+ggM1UpxI66UMhX46glhM38
         pjUpWP9N5yM1pOOg0AE9rVlgXrBFArfqKtYMEAzM+9EVKm0KyVOPzW0ZaqvIwJhiejz7
         Ojww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815032; x=1780419832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ub7zbATpGlY9mMap+Zj829sRZ8OviYmLdectZ67fEn4=;
        b=bJ9V0K/MadfChPwOXomO+0tUw9NNRHLdMxwxNKtPkkBDwdTk31lRAIeZixry6GM3wv
         GkLKea5wybruY3mZ7jBDnUMVuAt9Kq3QCNjo0Im7dQukY6in4uBCSNFl+Z57qQofWwUn
         wL5flxU60o9pdLSp8mwCqqeZN/FLzXQSuAbhpSZb35UqagllrZ7JjMT2y4SAsEq2WcEs
         zB8ARxDfwjlhpgo4au47LMmSJbHmqJUR6LvXS5Zj9Ihhqs97nz7DRq/7JOZkcf9uTtfy
         o8ml3KeAJhGU50gIEtRMbCOxOmWQf0cGGpQpavjAPzHp4xRHCDJC2xYBrqzp0DzXZhYg
         o5zA==
X-Gm-Message-State: AOJu0YzeV4GWuAdA+aZHGVxO5lTiKuYdDQlbLNonaKQCMErZ1fQsapBr
	+PBS2/i6HxjU9yosboQz9IKOlgwdoKKQkUl4N79JRF+s9B/knLMi7LAH394Auw==
X-Gm-Gg: Acq92OGsI1ugHqj7Zwy6ISdbZt3MSHvSyEbYvdJeXdHJI02e6Bi8hTWBSQKd3WN73Jc
	HD7KaZ3gw9eziugJ2r9HYH2+hs3tvRIPmeQpmPaeObJbiGZrzx5OQ3EOeICp4uXIBDj8GQabzoT
	idcXUVbMFHcxVQGmrD0Nk6D0LJPXX2XCbIr7D1U5rDpMlsGKLBFXxySkVUpnuSdu/u+BjhI91Ll
	s8eLgXxU05TCAe01ZXQPFKQfuAYYoj8ErJQ+JXqZ3vRjNkaKnBCaYq/GcGkzA4fmlttsGFikdzg
	F7YlC/mjMq3hb4Be+aIha1I8o0Niz+e7BLqCwQTq/FBTgleMaBy8ePraBmvAQnP2N3tcoXNoQeh
	QxS/booSCtO2taFekY3nZBNxHRr87LSj0NeGExO7NrUKWxKGz7SVTPLayhrk8F0ltLUMYSr4sxC
	6NmFyuQStyxGDLG2u9I++hhZ5s0wqtfpvM4qJ78MeCITdB5oJMph4oUG/gm+8yd7pVsvhOGsGKB
	SPZWzm2OkcQ4sIxny23pPRvSQdm80l+9Y2z9KM=
X-Received: by 2002:a05:6122:4896:b0:575:27de:3eab with SMTP id 71dfb90a1353d-5866347ff44mr11214424e0c.9.1779815032368;
        Tue, 26 May 2026 10:03:52 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f79814sm17485247e0c.6.2026.05.26.10.03.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:03:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Add support for HCI_LE_Set_Host_Feature [v2]
Date: Tue, 26 May 2026 13:03:41 -0400
Message-ID: <20260526170341.3529825-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for using HCI_LE_Set_Host_Feature [v2] instead of v1
if LL Extented Features is supported and the controller supports the
command.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  6 ++++++
 net/bluetooth/hci_sync.c    | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d..26a84dbf548a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2486,6 +2486,12 @@ struct hci_rp_le_cs_test {
 
 #define HCI_OP_LE_CS_TEST_END			0x2096
 
+#define HCI_OP_LE_SET_HOST_FEATURE_V2		0x2097
+struct hci_cp_le_set_host_feature_v2 {
+	__u16	bit_number;
+	__u8	bit_value;
+} __packed;
+
 /* ---- HCI Events ---- */
 struct hci_ev_status {
 	__u8    status;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index aff8562a8690..944bd29394c2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4583,11 +4583,30 @@ static int hci_set_le_support_sync(struct hci_dev *hdev)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+/* LE Set Host Feature V2 */
+static int hci_le_set_host_feature_v2_sync(struct hci_dev *hdev, u16 bit,
+					   u8 value)
+{
+	struct hci_cp_le_set_host_feature_v2 cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	/* Connected Isochronous Channels (Host Support) */
+	cp.bit_number = bit;
+	cp.bit_value = value;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE_V2,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 /* LE Set Host Feature */
-static int hci_le_set_host_feature_sync(struct hci_dev *hdev, u8 bit, u8 value)
+static int hci_le_set_host_feature_sync(struct hci_dev *hdev, u16 bit, u8 value)
 {
 	struct hci_cp_le_set_host_feature cp;
 
+	if (ll_ext_feature_capable(hdev) && hdev->commands[47] & BIT(4))
+		return hci_le_set_host_feature_v2_sync(hdev, bit, value);
+
 	memset(&cp, 0, sizeof(cp));
 
 	/* Connected Isochronous Channels (Host Support) */
-- 
2.53.0


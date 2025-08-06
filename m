Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786611853
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509728; cv=none; b=NBT9V28tzvyl7EJ3EjFobjrxhq9rvYhyUswBfiy9JEMk8SmtIt9G37Q/xzbHobZt4vogJmkXqe/By5VTNcJr0tkozWpPtLRqGC3coOSseAEBK7b+2V5FZ23BC9FWghx5U7weLmYuaPEy0M3H8Q1PX8X2aig+D7rCMLOSiIUlYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509728; c=relaxed/simple;
	bh=F+RPFXz83IeKMZNpYkU+IdAA5JbHkFDc/lfjiOld7Q4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=vDjUgppZrHrI8QSjUHJDi+Xt88QHJ7w2HkizBHzXYqJZR/L/bk/DQjspBJly1gJ/SBBAjM2VaV4VjYV6IO1I8PQ3gfDRJp7YHdIvGGddGyZBIbxzSwasPjZc2jHv0k4gfQ0InVyPjlgDoAcbXDiMbfAM6gyW/ccw+o8j3bB/QJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF66u+L5; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF66u+L5"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4fc05400905so104140137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Aug 2025 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754509723; x=1755114523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zpKjBUXjY0y/pj8T4pGVZZyihv+hR68jJVtmSUbbTYk=;
        b=iF66u+L5KU8GM404liHj4yKM9XfbONDr3WCBiV1qNErM8JH0jA7RtHQ3iV8STYnANp
         RCt9ZhDlPTimyE1/dJqDW6Dmr/i4qdqDLlhMckIRvQDpG9PFS/cUL6W2VJUj8B5DaFkm
         w/EacbbtcsfenSXSn3pvC5F1ZrzTb9VAaY5zTNFA6PAGBmMlYpvgdpQGGqC9vzWGqFcB
         2ju96Gils0fZsEa4t2rUKlVYW1m3lFcSZqpWzZ6cYW71+fAwMSiAy5wwMXOFxPhN/xM7
         NkeV8iemcByR5oxrRIRi1SMp+wI3IafLHj4vaLthU/hQ3RiPnB2CHP0ST5bV8nXdDIs0
         BPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754509723; x=1755114523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpKjBUXjY0y/pj8T4pGVZZyihv+hR68jJVtmSUbbTYk=;
        b=chmqGatvllD3KNVYU+TjXDim83oLwFPeJoAH3oQhg339BBM8m0AHVndanAhuaS57Xz
         1oiI1gu8A8TJ1U8JcEufRvsaVoy+ysNiNF+nMFwrCdyFa87ciMRSSeokF7ZppeSNQOAl
         6vhKTfgmFZ9jd5+LXmuxaKUj/SrcyqaMk1J+kz2L/zFjI3q5UkAlvVfCBuikPtfwJOuS
         YH1FxgkXEaLmfEDkhL0nD2x7QceAGv/SDudefOTDW8ZQpgjyMo/mfuUdoAlv4SGzhp6x
         8K4pIQ6Y0xesNwK2j67ihey/+rqn88JN/bl6CWlrsxhLxOH60DCXVZLU7OCEZs99STO2
         1p8g==
X-Gm-Message-State: AOJu0YyjrDuxwYsViI5U8d3Q8MI8s8Cgt7xzJgg3jxtuSWBKh80wzZ5P
	uKInrvIq0Z7TwS/RqMR0xAJRIJrkVQaFHKt0pWFgDfmSjTcB4zSsk3iF2HXLobTu
X-Gm-Gg: ASbGncv3+td67ZPUpy7A8/kduVFYKsJqL/2632JDGYcSmuL/o4Xk9p3uqaydRalEvyO
	BXknoFeduHDkO38ABdjIxtLIiNUbGBOm42SLNAHL7BqxqN+JrSbQmcb7pENCzOM9Wr/XmEeKZ0D
	D7BlCrcgMiSXA/9zP5abS73RGgYwmGKXmu8co4JY3L4JmHhFKy5lEwITxMYjpWgEz0sTy7/Fq8j
	PFA1OaHGlsJOkfVGd/3rawVmeYqeQ/wJkd3xHEMim66esIWP5EcgI4Y/PLZm89BanDo1z7lTwPE
	04slDuuu9KQGtdXLyxBK1Nl2mzey6++elBute0dzkzqgsFdlKsSrFOgjo5jN4eumkBpcAjwA7Qv
	OxbaeGxyNih6oyEDD80Ci7bzNmKIx1p8Is+/eUzLh+2wz7BwhrFebrh2q6amw5jFhYBKt61WF37
	8=
X-Google-Smtp-Source: AGHT+IE4uei7FlokF8kLiE3HR/wtO4pGZ7H6K0STGpSnSFr/wzqAn4G0iwSLNL1LJw0Ts+FxN7Xtpw==
X-Received: by 2002:a05:6102:945:b0:4fa:156c:b814 with SMTP id ada2fe7eead31-5037370c9d3mr2147106137.23.1754509723017;
        Wed, 06 Aug 2025 12:48:43 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f324b3csm3607920241.6.2025.08.06.12.48.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 12:48:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings
Date: Wed,  6 Aug 2025 15:48:35 -0400
Message-ID: <20250806194836.291949-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

{cis,bis}_capable only indicates the controller supports the feature
since it doesn't check that LE is enabled so it shall not be used for
current setting, instead this introduces {cis,bis}_enabled macros that
can be used to indicate that these features are currently enabled.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Fixes: ae7533613133 ("Bluetooth: Check for ISO support in controller")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  4 ++--
 include/net/bluetooth/hci_core.h  | 13 ++++++++++++-
 net/bluetooth/hci_sync.c          |  4 ++--
 net/bluetooth/iso.c               | 14 +++++++-------
 net/bluetooth/mgmt.c              | 10 +++++-----
 5 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ada5b56a4413..e5751f3070b8 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -647,7 +647,7 @@ static inline void sco_exit(void)
 #if IS_ENABLED(CONFIG_BT_LE)
 int iso_init(void);
 int iso_exit(void);
-bool iso_enabled(void);
+bool iso_inited(void);
 #else
 static inline int iso_init(void)
 {
@@ -659,7 +659,7 @@ static inline int iso_exit(void)
 	return 0;
 }
 
-static inline bool iso_enabled(void)
+static inline bool iso_inited(void)
 {
 	return false;
 }
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4dc11c66f7b8..bc29f2e2e16f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1915,6 +1915,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 				!hci_dev_test_flag(dev, HCI_RPA_EXPIRED))
 #define adv_rpa_valid(adv)     (bacmp(&adv->random_addr, BDADDR_ANY) && \
 				!adv->rpa_expired)
+#define le_enabled(dev)        (lmp_le_capable(dev) && \
+				hci_dev_test_flag(dev, HCI_LE_ENABLED))
 
 #define scan_1m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_1M) || \
 		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_1M))
@@ -1981,14 +1983,23 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 /* CIS Master/Slave and BIS support */
 #define iso_capable(dev) (cis_capable(dev) || bis_capable(dev))
+#define iso_enabled(dev) (le_enabled(dev) && iso_capable(dev))
 #define cis_capable(dev) \
 	(cis_central_capable(dev) || cis_peripheral_capable(dev))
+#define cis_enabled(dev) (le_enabled(dev) && cis_capable(dev))
 #define cis_central_capable(dev) \
 	((dev)->le_features[3] & HCI_LE_CIS_CENTRAL)
+#define cis_central_enabled(dev) \
+	(le_enabled(dev) && cis_central_capable(dev))
 #define cis_peripheral_capable(dev) \
 	((dev)->le_features[3] & HCI_LE_CIS_PERIPHERAL)
+#define cis_peripheral_enabled(dev) \
+	(le_enabled(dev) && cis_peripheral_capable(dev))
 #define bis_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_BROADCASTER)
-#define sync_recv_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
+#define bis_enabled(dev) (le_enabled(dev) && bis_capable(dev))
+#define sync_recv_capable(dev) \
+	((dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
+#define sync_recv_enabled(dev) (le_enabled(dev) && sync_recv_capable(dev))
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 387c128f2ba0..aa7d7a8ec3ee 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4531,14 +4531,14 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_host_feature cp;
 
-	if (!cis_capable(hdev))
+	if (!iso_capable(hdev))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
 
 	/* Connected Isochronous Channels (Host Support) */
 	cp.bit_number = 32;
-	cp.bit_value = 1;
+	cp.bit_value = iso_enabled(hdev) ? 0x01 : 0x00;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index eaffd25570e3..5ce823ca3aaf 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2483,11 +2483,11 @@ static const struct net_proto_family iso_sock_family_ops = {
 	.create	= iso_sock_create,
 };
 
-static bool iso_inited;
+static bool inited;
 
-bool iso_enabled(void)
+bool iso_inited(void)
 {
-	return iso_inited;
+	return inited;
 }
 
 int iso_init(void)
@@ -2496,7 +2496,7 @@ int iso_init(void)
 
 	BUILD_BUG_ON(sizeof(struct sockaddr_iso) > sizeof(struct sockaddr));
 
-	if (iso_inited)
+	if (inited)
 		return -EALREADY;
 
 	err = proto_register(&iso_proto, 0);
@@ -2524,7 +2524,7 @@ int iso_init(void)
 		iso_debugfs = debugfs_create_file("iso", 0444, bt_debugfs,
 						  NULL, &iso_debugfs_fops);
 
-	iso_inited = true;
+	inited = true;
 
 	return 0;
 
@@ -2535,7 +2535,7 @@ int iso_init(void)
 
 int iso_exit(void)
 {
-	if (!iso_inited)
+	if (!inited)
 		return -EALREADY;
 
 	bt_procfs_cleanup(&init_net, "iso");
@@ -2549,7 +2549,7 @@ int iso_exit(void)
 
 	proto_unregister(&iso_proto);
 
-	iso_inited = false;
+	inited = false;
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1ce682038b51..c42dffe77daf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -922,16 +922,16 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED))
 		settings |= MGMT_SETTING_WIDEBAND_SPEECH;
 
-	if (cis_central_capable(hdev))
+	if (cis_central_enabled(hdev))
 		settings |= MGMT_SETTING_CIS_CENTRAL;
 
-	if (cis_peripheral_capable(hdev))
+	if (cis_peripheral_enabled(hdev))
 		settings |= MGMT_SETTING_CIS_PERIPHERAL;
 
-	if (bis_capable(hdev))
+	if (bis_enabled(hdev))
 		settings |= MGMT_SETTING_ISO_BROADCASTER;
 
-	if (sync_recv_capable(hdev))
+	if (sync_recv_enabled(hdev))
 		settings |= MGMT_SETTING_ISO_SYNC_RECEIVER;
 
 	if (ll_privacy_capable(hdev))
@@ -4513,7 +4513,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (IS_ENABLED(CONFIG_BT_LE)) {
-		flags = iso_enabled() ? BIT(0) : 0;
+		flags = iso_inited() ? BIT(0) : 0;
 		memcpy(rp->features[idx].uuid, iso_socket_uuid, 16);
 		rp->features[idx].flags = cpu_to_le32(flags);
 		idx++;
-- 
2.50.1


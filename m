Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744369;
	b=iqe9pozy6sWwEzeZijAq5Iv5TEVzOag9vW4+ojCFMS5fnhyQIVB4/9OLy6f1F0vbhGwE
	 9dCmGAjmJSPTL5qskU7GR6ATuNkPAcL2fAecVD8erNfR8uiCLaT0a9zy85ohOn1OLVB74
	 2Zgx9HrIWzYuRPiTXdkRBidcwuD3BCGAcx7BFg49ZYebpm7yzg7h7Nq/Kmu+8ittpfGFv
	 /3TJyCvTtYlNjVK85aP+7JLnHKX70Fwz0+rJTDVvCpblykbyD0hXogIvfnsyb0wh0n1S7
	 /blKnXvyxS0awTvh7zvvzSLeqqaDEoyejdqSdEEvJ4wjaM3g4tGS4NYPCcU9HjrjmMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tMiLVd2/D6wrOijwORCysh+2Jo9wjCueL7zsXNYL1t4=;
	b=Knmq3M4gH60CUUwVMq8lo9sYotnI0OVlVE8D0zoOI9fVZQMMOd5q95WNObnw3lKRsbzJ
	 6f6CHpl5esArY6LDsozNnT/cWkuK08rBae6wSP1hlMfRjEbENO+psVLc+q69R86VPcgiJ
	 /iUx8hWuzmwq7fD4EZtxi0ZFIoBhGbBIhDEcTqIjkSZQeBWNpqRD5PyK2Uzu0HXlDPhgm
	 exWUZIoIsfjQKUo0cCmv16XzGIP5F4EJEVRPeKkdj48GE8l01XdG7NMbk+7xaQ3HF1L+h
	 lqeJSCH+Qbyt++EX4FmQaXvqpcJkM9W2XeL7p7psQoJurMSjKz1bj+3+HTRGiw0uEAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Os3UWXfT;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACA606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19ACA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Os3UWXfT
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so29818241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744368; x=1794349168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tMiLVd2/D6wrOijwORCysh+2Jo9wjCueL7zsXNYL1t4=;
        b=Os3UWXfTLCldnNWiCWs6APDpAdIReRLdaDwqO40kp61tRCHuMtfzBvdYcXT7ioXmGJ
         al1ilBB0/NSRCqgKyaDUAItNQri5jI2f77wws+rz1/DaFE+RYHgZGe/XnaF4qFqUApQR
         nUnFVmS9Q1B19pBk64vQyCKVN+9DwPYqI1+qrmwIXTh1U6TMm0X7QPOTTuiA/Ovqkxwc
         dCObOFQQISusLlVZg6m9zvJeqIUv8vnDmmGmG5Q/w7eLJ9RDZxINxhwEAWMaIUZMoV5z
         St6YqLfppy3gGKTc8VoeM2XLxfevpUBHRTTFIbOA9JaA/UIg6EV7jmdwy2P/7RJCPzyL
         B8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744368; x=1794349168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tMiLVd2/D6wrOijwORCysh+2Jo9wjCueL7zsXNYL1t4=;
        b=wg9uiA5OV+EfXXpsZ9XvsNw4fJHg7jkzcSfXUMypxJf198uN7tI7VQW+nudrdlJc+b
         NRIBGIrIEMoEQwBm2sECRdhhHD57beUYB50SE28KRZaPXx5n3LjeK/mQqpm2JLvMmgjS
         35yTeb4pAoA+3vvFAHXFYtGJ5Qswn54R1mzBSy9CmdvD7tXMnm2oEvHO4/P+9VudfD06
         /DIjUaRRhQ1sF/5hjH0SJkrnBQFrHBcNxVOaMQgjcxrCn74ukeVLEY2Y+Bm0Erz0bWvS
         khl9fbRIgRpyLp/oNrI1JhTV3jHxWIGSGmTAyR6qNSYFSLT6nZ83pNsWCSSu6Sx8QKjS
         iGKA==
X-Gm-Message-State: APuU4Z/paQUzNMhUoEBYhJki+e0mXPf4hHvwmZs2lsW8vCznrqi5D2vq
	Tb2nG6PO4itEP7OL4A1DGUzZS1QFyEGN7+ElCgisAMegHfJbz2d6s457xvbDdw==
X-Gm-Gg: AYBFou1t6gBSjGseQYZSWJQpH/5E9zHNwFBB1L7Xx5HA4FeYpKYs8xi8LjDlYGflL8Z
	9wrNVAPNCSDElWK5ffVrn9dLN4N2bKJP3PNplLEBauLsvD+mVkElgxSZiG5t3EYJcn/qpoBwjmu
	lPk1xJdNifLxFfnSwMjizAYVIcoaYwtEovrQTgCu/5hgPPcWCXJrDFLlPCjwAftFGFOnbu9YuuU
	HmHRHUa0Z8pLPNwpruxusSBlZmahGmX3B8/ywWJm2v7dkNcuLCtxmmSILAucKN0HOH7rrYyUEyM
	7hbS5/8ky8P5TXXA6J5T31mzWjVV/B2Qo722HomTivKyI+KxVA3y6G8DR7klDpuyeyxQ1yLA0va
	HGVj5evZiQDByN6idjPMVLOxz3I07im2/GQCAsXXjecuQpX9pjsz7qfQOa3bsasTFbazY2GiwXf
	3RQsVSEZF4Y62asCYMswZyseNrjXeHZGcnM1zc/C0sHm4lncCGcb2rU9C7M0S4A5epdvsSlYxBi
	5vTij5XqgzcDcA+PCx/yUAhl3nsma9MMgqeYg93KpQ/qfIdPuSoNX9KHg0glhTbR3CNvQrvhVOZ
	Rw/AEE9e2Yx1+Ng++qBpiD+VUshIeHL5uN/3SvemMtYs+6F8j7rnjFz6Kf8hBs5zvKGkNAo2gbP
	QcvFKARhwCB61R+iLKdbOYIFHbEIWGdSeuQ3+vP4tGGVDkqHASqhSyFnQo/CIyaBXnR4f9zc69R
	OeWSQ=
X-Received: by 2002:a05:6102:5126:b0:7cc:9f01:1378 with SMTP id ada2fe7eead31-7d07227aa1bmr5395279137.1.1793744367746;
        Tue, 03 Nov 2026 14:19:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm306572137.11.2026.11.03.14.19.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/6] Bluetooth: ISO: Add new QoS v2 adding rate field
Date: Tue,  3 Nov 2026 17:19:17 -0500
Message-ID: <20261103221921.4071765-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221921.4071765-1-luiz.dentz@gmail.com>
References: <20261103221921.4071765-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add struct bt_iso_qos_v2, which extends the I/O QoS of BT_ISO_QOS with
a rates field so userspace can select the HDT rates of a CIS or BIS
along with BT_ISO_PHY_HDT. BT_ISO_QOS accepts either version, telling
them apart by the length of the option, and the ISO sockets keep the v2
form internally so the rates are passed to LE Set CIG Parameters v2 and
LE Create BIG v2 and reported back from the CIS Established and Create
BIG Complete events.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  44 ++++++++++
 include/net/bluetooth/hci_core.h  |  15 ++--
 include/net/bluetooth/hci_sync.h  |   2 +-
 net/bluetooth/hci_conn.c          |  26 +++---
 net/bluetooth/hci_event.c         |   8 +-
 net/bluetooth/hci_sync.c          |  44 ++++++----
 net/bluetooth/iso.c               | 138 ++++++++++++++++++++++++++----
 7 files changed, 218 insertions(+), 59 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index aab6a1ac9a3e..945c0bc58a95 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -235,6 +235,50 @@ struct bt_iso_qos {
 	};
 };
 
+struct bt_iso_io_qos_v2 {
+	__u32 interval;
+	__u16 latency;
+	__u16 sdu;
+	__u8  phys;
+	__u8  rtn;
+	__u16 rates;
+};
+
+struct bt_iso_ucast_qos_v2 {
+	__u8  cig;
+	__u8  cis;
+	__u8  sca;
+	__u8  packing;
+	__u8  framing;
+	struct bt_iso_io_qos_v2 in;
+	struct bt_iso_io_qos_v2 out;
+};
+
+struct bt_iso_bcast_qos_v2 {
+	__u8  big;
+	__u8  bis;
+	__u8  sync_factor;
+	__u8  packing;
+	__u8  framing;
+	struct bt_iso_io_qos_v2 in;
+	struct bt_iso_io_qos_v2 out;
+	__u8  encryption;
+	__u8  bcode[16];
+	__u8  options;
+	__u16 skip;
+	__u16 sync_timeout;
+	__u8  sync_cte_type;
+	__u8  mse;
+	__u16 timeout;
+};
+
+struct bt_iso_qos_v2 {
+	union {
+		struct bt_iso_ucast_qos_v2 ucast;
+		struct bt_iso_bcast_qos_v2 bcast;
+	};
+};
+
 #define BT_ISO_PHY_1M		BIT(0)
 #define BT_ISO_PHY_2M		BIT(1)
 #define BT_ISO_PHY_CODED	BIT(2)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6a16bc1e775c..f6e2a414bf2a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -797,7 +797,7 @@ struct hci_conn {
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
-	struct bt_iso_qos iso_qos;
+	struct bt_iso_qos_v2 iso_qos;
 	__u8		num_bis;
 	__u8		bis[HCI_MAX_ISO_BIS];
 
@@ -1678,23 +1678,24 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting, struct bt_codec *codec,
 				 u16 timeout);
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos,
+			      __u8 dst_type, struct bt_iso_qos_v2 *qos,
 			      u16 timeout);
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
-			      struct bt_iso_qos *qos,
+			      struct bt_iso_qos_v2 *qos,
 			      __u8 base_len, __u8 *base, u16 timeout);
 int hci_past_bis(struct hci_conn *conn, bdaddr_t *dst, __u8 dst_type);
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, struct bt_iso_qos_v2 *qos,
 				 u16 timeout);
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, __u8 sid,
-				 struct bt_iso_qos *qos,
+				 struct bt_iso_qos_v2 *qos,
 				 __u8 data_len, __u8 *data, u16 timeout);
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
-		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
+				    __u8 dst_type, __u8 sid,
+				    struct bt_iso_qos_v2 *qos);
 int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     struct bt_iso_qos_v2 *qos, __u16 sync_handle,
 			     __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index a24f6a84a447..ca21fe81a06e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -195,5 +195,5 @@ int hci_le_read_remote_features(struct hci_conn *conn);
 int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
 int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys, u16 phy_opts);
 int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id);
-int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos *qos,
+int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_v2 *qos,
 			   u8 num_bis);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index edf7be18a0cc..8524fca9f273 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1637,7 +1637,7 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 	return 0;
 }
 
-static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
+static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos_v2 *qos)
 {
 	struct hci_conn *conn;
 	u8  big;
@@ -1661,7 +1661,7 @@ static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
 	return 0;
 }
 
-static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
+static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos_v2 *qos)
 {
 	struct hci_conn *conn;
 	u8  bis;
@@ -1703,7 +1703,7 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				    __u8 sid, struct bt_iso_qos *qos,
+				    __u8 sid, struct bt_iso_qos_v2 *qos,
 				    __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
@@ -1938,7 +1938,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
-static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
+static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos_v2 *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
@@ -1961,7 +1961,7 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	return hci_le_set_cig_params_sync(hdev, cig_id);
 }
 
-static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
+static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos_v2 *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
@@ -2023,7 +2023,7 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 }
 
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos,
+			      __u8 dst_type, struct bt_iso_qos_v2 *qos,
 			      u16 timeout)
 {
 	struct hci_conn *cis;
@@ -2166,7 +2166,7 @@ int hci_le_create_cis_pending(struct hci_dev *hdev)
 }
 
 static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
-			      struct bt_iso_io_qos *qos, __u8 phys)
+			      struct bt_iso_io_qos_v2 *qos, __u8 phys)
 {
 	/* Only set MTU if PHY is enabled */
 	if (!qos->sdu && qos->phys)
@@ -2189,7 +2189,7 @@ static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos_v2 *qos = &conn->iso_qos;
 	u16 interval, sync_interval = 0;
 	u32 flags = 0;
 	int err;
@@ -2218,7 +2218,7 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 				    __u8 dst_type, __u8 sid,
-				    struct bt_iso_qos *qos)
+				    struct bt_iso_qos_v2 *qos)
 {
 	struct hci_conn *conn;
 
@@ -2241,7 +2241,7 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     struct bt_iso_qos_v2 *qos, __u16 sync_handle,
 			     __u8 num_bis, __u8 bis[])
 {
 	int err;
@@ -2292,7 +2292,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
-			      struct bt_iso_qos *qos,
+			      struct bt_iso_qos_v2 *qos,
 			      __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
@@ -2380,7 +2380,7 @@ static void bis_mark_per_adv(struct hci_conn *conn, void *data)
 
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, __u8 sid,
-				 struct bt_iso_qos *qos,
+				 struct bt_iso_qos_v2 *qos,
 				 __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
@@ -2431,7 +2431,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, struct bt_iso_qos_v2 *qos,
 				 u16 timeout)
 {
 	struct hci_conn *le;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 466f09124fcd..7b1c2ce58d73 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7372,7 +7372,7 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_v2 *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 	u32 c_sdu_interval, p_sdu_interval;
@@ -7869,7 +7869,7 @@ static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established_v3 *ev = data;
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_v2 *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 	u32 c_sdu_interval, p_sdu_interval;
@@ -7915,6 +7915,8 @@ static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
 		qos->ucast.out.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
 		qos->ucast.in.phys = le_phy_qos(ev->c_phy);
 		qos->ucast.out.phys = le_phy_qos(ev->p_phy);
+		qos->ucast.in.rates = le16_to_cpu(ev->c_rates);
+		qos->ucast.out.rates = le16_to_cpu(ev->p_rates);
 		break;
 	case HCI_ROLE_MASTER:
 		qos->ucast.in.interval = p_sdu_interval;
@@ -7930,6 +7932,8 @@ static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
 		qos->ucast.in.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
 		qos->ucast.out.phys = le_phy_qos(ev->c_phy);
 		qos->ucast.in.phys = le_phy_qos(ev->p_phy);
+		qos->ucast.out.rates = le16_to_cpu(ev->c_rates);
+		qos->ucast.in.rates = le16_to_cpu(ev->p_rates);
 		break;
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a076ff131bc4..f5ee261af67a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3187,7 +3187,7 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 			conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
 						       &bdaddr);
 			if (conn) {
-				struct bt_iso_qos *qos = &conn->iso_qos;
+				struct bt_iso_qos_v2 *qos = &conn->iso_qos;
 
 				if (qos->bcast.in.phys & BT_ISO_PHY_1M ||
 				    qos->bcast.in.phys & BT_ISO_PHY_2M) {
@@ -7871,7 +7871,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
-				   u16 acl_handle, struct bt_iso_qos *qos)
+				   u16 acl_handle, struct bt_iso_qos_v2 *qos)
 {
 	struct hci_cp_le_past_params cp;
 	int err;
@@ -7905,7 +7905,7 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_pa_create_sync cp;
 	struct hci_conn *conn = data, *le;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos_v2 *qos = &conn->iso_qos;
 	int err;
 
 	if (!hci_conn_valid(hdev, conn))
@@ -8046,7 +8046,7 @@ static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis,
 		    HCI_MAX_ISO_BIS);
 	struct hci_conn *conn = data;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos_v2 *qos = &conn->iso_qos;
 	int err;
 
 	if (!hci_conn_valid(hdev, conn))
@@ -8374,7 +8374,7 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 	DEFINE_FLEX(struct hci_cp_le_set_cig_params_v2, pdu, cis, num_cis,
 		    0x1f);
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_v2 *qos;
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
@@ -8420,8 +8420,15 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 			      qos->ucast.out.phys;
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
+		cis->c_hdt_rates = qos->ucast.out.rates ? qos->ucast.out.rates :
+				   qos->ucast.in.rates;
+		cis->p_hdt_rates = qos->ucast.in.rates ? qos->ucast.in.rates :
+				   qos->ucast.out.rates;
 
-		if (cis->c_phys & BIT(4)) {
+		/* If HDT PHY is set but rates are not set then enable all HDT
+		 * supported rates.
+		 */
+		if (cis->c_phys & BIT(4) && !cis->c_hdt_rates) {
 			cis->c_hdt_rates |= BIT(0); /* HDT 2M */
 			cis->c_hdt_rates |= BIT(1); /* HDT 3M */
 			cis->c_hdt_rates |= BIT(2); /* HDT 4M */
@@ -8433,7 +8440,7 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 				cis->c_hdt_rates |= BIT(4); /* HDT 7.5M */
 		}
 
-		if (cis->p_phys & BIT(4)) {
+		if (cis->p_phys & BIT(4) && !cis->p_hdt_rates) {
 			cis->p_hdt_rates |= BIT(0); /* HDT 2M */
 			cis->p_hdt_rates |= BIT(1); /* HDT 3M */
 			cis->p_hdt_rates |= BIT(2); /* HDT 4M */
@@ -8462,7 +8469,7 @@ int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_cig_params, pdu, cis, num_cis, 0x1f);
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_v2 *qos;
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
@@ -8525,7 +8532,7 @@ int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id)
 }
 
 static int hci_le_create_big_v2_sync(struct hci_conn *conn,
-				     struct bt_iso_qos *qos, u8 num_bis)
+				     struct bt_iso_qos_v2 *qos, u8 num_bis)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_big_v2 cp;
@@ -8543,25 +8550,28 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 	cp.bis.framing = qos->bcast.framing;
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
+	cp.bis.hdt_rates = qos->bcast.out.rates ? qos->bcast.out.rates : 0x00;
 
-	/* Check if HDT PHY is set then enable HDT supported rates */
-	if (cp.bis.phys & BIT(4)) {
-		cp.bis.coded_rates |= BIT(0); /* HDT 2M */
-		cp.bis.coded_rates |= BIT(1); /* HDT 3M */
-		cp.bis.coded_rates |= BIT(2); /* HDT 4M */
+	/* If HDT PHY is set but rates are not set then enable all HDT
+	 * supported rates.
+	 */
+	if (cp.bis.phys & BIT(4) && !cp.bis.hdt_rates) {
+		cp.bis.hdt_rates |= BIT(0); /* HDT 2M */
+		cp.bis.hdt_rates |= BIT(1); /* HDT 3M */
+		cp.bis.hdt_rates |= BIT(2); /* HDT 4M */
 
 		if (hdt_6_tx_capable(hdev))
-			cp.bis.coded_rates |= BIT(3); /* HDT 6M */
+			cp.bis.hdt_rates |= BIT(3); /* HDT 6M */
 
 		if (hdt_7_5_tx_capable(hdev))
-			cp.bis.coded_rates |= BIT(4); /* HDT 7.5M */
+			cp.bis.hdt_rates |= BIT(4); /* HDT 7.5M */
 	}
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG_V2,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos *qos,
+int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_v2 *qos,
 			   u8 num_bis)
 {
 	struct hci_dev *hdev = conn->hdev;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 06f1e7ba2cb1..15b3448ccd70 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -75,7 +75,7 @@ struct iso_pinfo {
 	__u8			bc_bis[ISO_MAX_NUM_BIS];
 	__u16			sync_handle;
 	unsigned long		flags;
-	struct bt_iso_qos	qos;
+	struct bt_iso_qos_v2	qos;
 	bool			qos_user_set;
 	__u8			base_len;
 	__u8			base[BASE_MAX_LENGTH];
@@ -83,10 +83,10 @@ struct iso_pinfo {
 	struct delayed_work	timeout_work;
 };
 
-static struct bt_iso_qos default_qos;
+static struct bt_iso_qos_v2 default_qos;
 
-static bool check_ucast_qos(struct bt_iso_qos *qos);
-static bool check_bcast_qos(struct bt_iso_qos *qos);
+static bool check_ucast_qos(struct bt_iso_qos_v2 *qos);
+static bool check_bcast_qos(struct bt_iso_qos_v2 *qos);
 static bool iso_match_sid(struct sock *sk, void *data);
 static bool iso_match_sid_past(struct sock *sk, void *data);
 static bool iso_match_sync_handle(struct sock *sk, void *data);
@@ -620,7 +620,7 @@ static int iso_connect_cis(struct sock *sk)
 	return err;
 }
 
-static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
+static struct bt_iso_qos_v2 *iso_sock_get_qos(struct sock *sk)
 {
 	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
 		return &iso_pi(sk)->conn->hcon->iso_qos;
@@ -628,11 +628,49 @@ static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
 	return &iso_pi(sk)->qos;
 }
 
+static void iso_qos_io_v1(struct bt_iso_io_qos_v2 *qos,
+			  struct bt_iso_io_qos *old)
+{
+	memcpy(old, qos, sizeof(*old));
+}
+
+static void iso_bcast_qos_v1(struct bt_iso_qos_v2 *qos, struct bt_iso_qos *old)
+{
+	memcpy(&old->bcast, &qos->bcast,
+	       offsetof(struct bt_iso_bcast_qos, in));
+	iso_qos_io_v1(&qos->bcast.in, &old->bcast.in);
+	iso_qos_io_v1(&qos->bcast.out, &old->bcast.out);
+	memcpy(&old->bcast + offsetof(struct bt_iso_bcast_qos, out),
+	       &qos->bcast + offsetof(struct bt_iso_bcast_qos_v2, out),
+	       offsetofend(struct bt_iso_bcast_qos, timeout));
+}
+
+static void iso_ucast_qos_v1(struct bt_iso_qos_v2 *qos, struct bt_iso_qos *old)
+{
+	memcpy(&old->ucast, &qos->ucast,
+	       offsetof(struct bt_iso_ucast_qos, in));
+	iso_qos_io_v1(&qos->ucast.in, &old->ucast.in);
+	iso_qos_io_v1(&qos->ucast.out, &old->ucast.out);
+	memcpy(&old->ucast + offsetof(struct bt_iso_bcast_qos, out),
+	       &qos->ucast + offsetof(struct bt_iso_bcast_qos_v2, out),
+	       offsetofend(struct bt_iso_bcast_qos, timeout));
+}
+
+static void iso_sock_get_qos_v1(struct sock *sk, struct bt_iso_qos *old)
+{
+	struct bt_iso_qos_v2 *qos = iso_sock_get_qos(sk);
+
+	if (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
+		iso_bcast_qos_v1(qos, old);
+	else
+		iso_ucast_qos_v1(qos, old);
+}
+
 static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
 			  const struct sockcm_cookie *sockc)
 {
 	struct iso_conn *conn = iso_pi(sk)->conn;
-	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
+	struct bt_iso_qos_v2 *qos = iso_sock_get_qos(sk);
 	struct hci_iso_data_hdr *hdr;
 	int len = 0;
 
@@ -1009,7 +1047,7 @@ static struct proto iso_proto = {
 	.rtn		= 2u, \
 }
 
-static struct bt_iso_qos default_qos = {
+static struct bt_iso_qos_v2 default_qos = {
 	.bcast = {
 		.big			= BT_ISO_QOS_BIG_UNSET,
 		.bis			= BT_ISO_QOS_BIS_UNSET,
@@ -1863,7 +1901,7 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return bt_sock_recvmsg(sock, msg, len, flags);
 }
 
-static bool check_io_qos(struct bt_iso_io_qos *qos)
+static bool check_io_qos(struct bt_iso_io_qos_v2 *qos)
 {
 	/* If no PHY is enable SDU must be 0 */
 	if (!qos->phys && qos->sdu)
@@ -1881,7 +1919,7 @@ static bool check_io_qos(struct bt_iso_io_qos *qos)
 	return true;
 }
 
-static bool check_ucast_qos(struct bt_iso_qos *qos)
+static bool check_ucast_qos(struct bt_iso_qos_v2 *qos)
 {
 	if (qos->ucast.cig > 0xef && qos->ucast.cig != BT_ISO_QOS_CIG_UNSET)
 		return false;
@@ -1907,7 +1945,7 @@ static bool check_ucast_qos(struct bt_iso_qos *qos)
 	return true;
 }
 
-static bool check_bcast_qos(struct bt_iso_qos *qos)
+static bool check_bcast_qos(struct bt_iso_qos_v2 *qos)
 {
 	if (!qos->bcast.sync_factor)
 		qos->bcast.sync_factor = 0x01;
@@ -1954,12 +1992,51 @@ static bool check_bcast_qos(struct bt_iso_qos *qos)
 	return true;
 }
 
+static void iso_qos_io_v2(struct bt_iso_io_qos_v2 *qos,
+			  struct bt_iso_io_qos *old)
+{
+	memcpy(qos, old, sizeof(*old));
+	qos->rates = 0x00;
+}
+
+static void iso_bcast_qos_v2(struct bt_iso_qos_v2 *qos, struct bt_iso_qos *old)
+{
+	memcpy(&qos->bcast, &old->bcast,
+	       offsetof(struct bt_iso_bcast_qos_v2, in));
+	iso_qos_io_v2(&qos->bcast.in, &old->bcast.in);
+	iso_qos_io_v2(&qos->bcast.out, &old->bcast.out);
+	memcpy(&qos->bcast + offsetof(struct bt_iso_bcast_qos_v2, out),
+	       &old->bcast + offsetof(struct bt_iso_bcast_qos, out),
+	       offsetofend(struct bt_iso_bcast_qos_v2, timeout));
+}
+
+static void iso_ucast_qos_v2(struct bt_iso_qos_v2 *qos, struct bt_iso_qos *old)
+{
+	memcpy(&qos->ucast, &old->ucast,
+	       offsetof(struct bt_iso_ucast_qos_v2, in));
+	iso_qos_io_v2(&qos->ucast.in, &old->ucast.in);
+	iso_qos_io_v2(&qos->ucast.out, &old->ucast.out);
+	memcpy(&qos->ucast + offsetof(struct bt_iso_bcast_qos_v2, out),
+	       &old->ucast + offsetof(struct bt_iso_bcast_qos, out),
+	       offsetofend(struct bt_iso_bcast_qos_v2, timeout));
+}
+
+static void iso_qos_v2(struct sock *sk, struct bt_iso_qos_v2 *qos,
+		       struct bt_iso_qos *old)
+{
+	if (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
+		iso_bcast_qos_v2(qos, old);
+	else
+		iso_ucast_qos_v2(qos, old);
+}
+
 static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
-	struct bt_iso_qos qos = default_qos;
+	struct bt_iso_qos_v2 qos = default_qos;
+	struct bt_iso_qos qos_old;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -2005,9 +2082,21 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = copy_safe_from_sockptr(&qos, sizeof(qos), optval, optlen);
-		if (err)
+		if (optlen == sizeof(qos)) {
+			err = copy_safe_from_sockptr(&qos, sizeof(qos), optval,
+						     optlen);
+			if (err)
+				break;
+		} else if (optlen == sizeof(qos_old)) {
+			err = copy_safe_from_sockptr(&qos_old, sizeof(qos_old),
+						     optval, optlen);
+			if (err)
+				break;
+			iso_qos_v2(sk, &qos, &qos_old);
+		} else {
+			err = -EINVAL;
 			break;
+		}
 
 		iso_pi(sk)->qos = qos;
 		iso_pi(sk)->qos_user_set = true;
@@ -2048,7 +2137,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 			       sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_v2 *qos;
+	struct bt_iso_qos qos_old;
 	int len, val, err = 0;
 	u8 base_len;
 	u8 *base;
@@ -2081,11 +2171,21 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_ISO_QOS:
-		qos = iso_sock_get_qos(sk);
-
-		len = min_t(unsigned int, len, sizeof(*qos));
-		if (copy_to_iter(qos, len, &opt->iter_out) != len)
-			err = -EFAULT;
+		if (len == sizeof(*qos)) {
+			qos = iso_sock_get_qos(sk);
+
+			len = min_t(unsigned int, len, sizeof(*qos));
+			if (copy_to_iter(qos, len, &opt->iter_out) != len)
+				err = -EFAULT;
+		} else if (len == sizeof(qos_old)) {
+			iso_sock_get_qos_v1(sk, &qos_old);
+
+			len = min_t(unsigned int, len, sizeof(qos_old));
+			if (copy_to_iter(&qos_old, len, &opt->iter_out) != len)
+				err = -EFAULT;
+		} else {
+			err = -EINVAL;
+		}
 
 		break;
 
-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817393;
	b=DFyCEPjdotiRBNJlgJVw9vCHTKMioIPsCHuii+B35LE1d2JLTrQr5QV8yYpnh62d3wmb
	 tsuw9DWJr6x3mt8fr+yX+L5S6bO0QNSIvEyhg/iFuGD4NUKsFJMvqG9Gtk0obrIwqW/pp
	 UgzGAyzJ5xMgtAckY25ftvJospb6UoWe6iultzhcp9O7cFaROkyljh6kXP6i+vfaKX8bc
	 5FHixOWolhYftQE3ypbrzCZubZlfZnH7Z5Jeyyqlmpjmf9vvvoWKdDUZ+js170yDJbsy5
	 6WdYS6D3gCfYCrfW7+kK1PFxbTfZyN2Duy2C9tSc5xiUh9CZs+dl4AfjKvoJ1Nv1uEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hoSqz9FAshZGnSrFHcsA6j+DZgB6HuIaxuLoZ54nkG0=;
	b=omkbcnOhanSv99a6o4QWec31NrOjyXvgX8VIBGoOfRW6L4HdUEKx8N2IXlKj9287MkAn
	 bGDYYBlDF9lzKJ50xnsj8Q56d7DFDgxHgsDRqqF4dPzUjoban7FMtLK3BmaxiOysnDeWJ
	 lavrvhvoC84aXENE05WBkskxbDftDte/TSNtHNufAc0QbH17CK71clqlR/bmqacRjnJPl
	 Ujk4n4R1O793RIpAsxFB0IYwfaJpFhHahbV3osz9tukTkGu2L38q+tqNSKPVaG5X0FYP8
	 dYO3aksOJJ3GL77GBKSMGSap1oq3iCyUkg7bV63agfzJcGEz7gnIpiJOWdKz6vJPAuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRJ8DOSg;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52307606A326
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 18:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52307606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRJ8DOSg
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9906c85122cso351319241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817391; x=1794422191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hoSqz9FAshZGnSrFHcsA6j+DZgB6HuIaxuLoZ54nkG0=;
        b=oRJ8DOSg6hoZ0XqtzupLJ2dezAeG4k47gwe27ZbDAVuQYBMu3DUNVIxraqnH35DTR5
         uscEplhjJat4jrEHN+AhJoXksEPHDIcH3iBdh6+DJwGNJaGfVXRUh5ixRPOFE4OmvIi0
         16No3xfoh8KPgZOOYaJxhBNLMae/5w0E8CjD2YVVPhRKBfiV2ARr36FUG5v3jyRrz0Uy
         ulQgEa7pKBc28lC+ukL3K33/u0LiAWk2QxGWwnQcguOQnX0Y93UtlxSSUuj+X0BXyhCq
         ehqfPrdkn3utUClzGSxn1rq6Hfs5LeiCufa1SmHj9jVowbGOtG0R6eJTRuCkCL6ZFHeA
         M5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817391; x=1794422191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hoSqz9FAshZGnSrFHcsA6j+DZgB6HuIaxuLoZ54nkG0=;
        b=zyyTg+oBh95rc0rrxF2ScgY0GsqwTnPX1rJ9C+iZ8h0wYtz+qhVORgaKZCgklvsfm4
         DBT72HB8eaegQVVZqzTTT3gM1A8OhqTXlEMoO8XxUcQb8vPYWCe3BnHTsgu9qzD/H2EZ
         Q0iwO8R+rmcW4fW9m1lNDspMn6a1kxV/kzSkPdEGaK44j4iU9XkXnO709iYFcUtpTRI2
         DXcWMNwIToA8fE2mOyQBVedGJnC7JTT26YALNnlV2Hj2turUY7YNWQCnN17AWwwV0GSk
         5nTiCkqleYkutlyub+P8QK752MCzUTCKnb0IAFKrIh+AieaABe6bB2z15l0IGKlzu46h
         dnGg==
X-Gm-Message-State: APuU4Z8C9m5NuyoZk+efSBYoCZFKpTxdsm/uS0gm+dhXKXzFbP0yEH4D
	NmshXeeuOPmITmMIDn081KA5Z5dhsY5MAbQnjAgxZMJeGA7EKO+Ein2iBv6Mjg==
X-Gm-Gg: AYBFou35TLO8sTV0d8UntW3mYtwCA76ej0zW5HzJvA9JqQQoHFINddzoFlD2ayx5Ua1
	sxJWBUN3Cu8OpRWM5heLEyv3Pk2TcRSMVudDePb4lhnNWEU2edjcjUJpJfEkMAS8HLGCBsPWhyl
	6li9u0OuMQc2LCYssQGEhm5DOcnyoQl011kpiVCWiRqDZeiZa9riW9M6wBTd+8D4bIBYdcHYUlf
	nU3CNY/g9tqQ6tyfpRWpqXpBOJ6ye05qSiWKokNV4OC0mPXc7wDwRyTabbOcoEC8pxkQSwA0K3k
	rsptw7M4/IfORvCtx43NnXUNVxNsX0cIz3Nfu2OcTx4xh1ayNtFEwP/C8DR5Tpjyb47V+zFN9Vk
	0xp62zhwMAEtjeNoRstn2Z0to96H0eJ9dvffe2rdoEP0YMChq0SxuIId0AwwPdEj7MbjV+qUP+O
	nUKPbNYkBAcrAxzoc3jROBnOmsG1Fd0lKWVKEju/m81noLQy6Nj1SRy8VHyGyXf/+1z0DiZXUH1
	Pvhx2kKkib0XA+VfzcJNAFuN6tEX6jMRt7Xo/TIziu0IZYwk9Ti41UI2YtwXgrvu4TkAPFMz2Pi
	/AjJ7VpaXABM3FOIg3EPzv2IO/DNPGDD9aU1x0FqxjIkQXcGvrsNq4DHOJghQ47tbIRJpalat0P
	DVjLVszxrvkTXPRijuLnnHQD484piek8GvtocAE9fGBnARlkc8fNZ4WH9Lp/hHEGS6an1LuAjvT
	g5a0rJonXch8EUI6KxoNF5bZ8E
X-Received: by 2002:a05:6102:4186:b0:7cc:95ed:3147 with SMTP id ada2fe7eead31-7d072d305d6mr6929996137.34.1793817390906;
        Wed, 04 Nov 2026 10:36:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d9a9ca31sm2509812241.10.2026.11.04.10.36.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:36:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/6] Bluetooth: ISO: Add extended QoS with the HDT rates
Date: Wed,  4 Nov 2026 13:36:22 -0500
Message-ID: <20261104183626.838825-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104183626.838825-1-luiz.dentz@gmail.com>
References: <20261104183626.838825-1-luiz.dentz@gmail.com>
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

Add struct bt_iso_qos_ext, an extensible version of struct bt_iso_qos
which starts with a version field, so new fields can be added in later
versions without defining a new struct for each. Version 1 adds the
rates of each direction, so userspace can select the HDT rates of a CIS
or BIS along with BT_ISO_PHY_HDT.

BT_ISO_QOS accepts either form: the length of struct bt_iso_qos selects
it, as before, and any other length must carry struct bt_iso_qos_ext of
a known version. Reading BT_ISO_QOS with a buffer shorter than struct
bt_iso_qos_ext returns struct bt_iso_qos, so existing userspace is not
affected.

The ISO sockets keep the extended form internally, so the rates are
passed to LE Set CIG Parameters v2 and LE Create BIG v2, defaulting to
all the HDT rates the controller supports, and reported back from LE
CIS Established v3 and LE Create BIG Complete v2.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  54 +++++++++++
 include/net/bluetooth/hci_core.h  |  15 +--
 include/net/bluetooth/hci_sync.h  |   2 +-
 net/bluetooth/hci_conn.c          |  26 +++---
 net/bluetooth/hci_event.c         |  16 +++-
 net/bluetooth/hci_sync.c          |  32 ++++---
 net/bluetooth/iso.c               | 149 ++++++++++++++++++++++++++----
 7 files changed, 238 insertions(+), 56 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fbedd1ebd051..fd5590b0e125 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -235,6 +235,60 @@ struct bt_iso_qos {
 	};
 };
 
+/* Extended ISO QoS, set and read with BT_ISO_QOS: the option length tells it
+ * apart from struct bt_iso_qos, and version tells which fields follow.
+ *
+ * Version 1 adds the rates of each direction, set when the PHY is
+ * BT_ISO_PHY_HDT.
+ */
+#define BT_ISO_QOS_VERSION_1	0x01
+
+struct bt_iso_io_qos_ext {
+	__u32 interval;
+	__u16 latency;
+	__u16 sdu;
+	__u8  phys;
+	__u8  rtn;
+	__u16 rates;
+};
+
+struct bt_iso_ucast_qos_ext {
+	__u8  cig;
+	__u8  cis;
+	__u8  sca;
+	__u8  packing;
+	__u8  framing;
+	struct bt_iso_io_qos_ext in;
+	struct bt_iso_io_qos_ext out;
+};
+
+struct bt_iso_bcast_qos_ext {
+	__u8  big;
+	__u8  bis;
+	__u8  sync_factor;
+	__u8  packing;
+	__u8  framing;
+	struct bt_iso_io_qos_ext in;
+	struct bt_iso_io_qos_ext out;
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
+struct bt_iso_qos_ext {
+	__u8  version;
+	__u8  rfu[3];
+	union {
+		struct bt_iso_ucast_qos_ext ucast;
+		struct bt_iso_bcast_qos_ext bcast;
+	};
+};
+
 #define BT_ISO_PHY_1M		BIT(0)
 #define BT_ISO_PHY_2M		BIT(1)
 #define BT_ISO_PHY_CODED	BIT(2)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e48f032bcd62..dd4c846343d6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -797,7 +797,7 @@ struct hci_conn {
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
-	struct bt_iso_qos iso_qos;
+	struct bt_iso_qos_ext iso_qos;
 	__u8		num_bis;
 	__u8		bis[HCI_MAX_ISO_BIS];
 
@@ -1678,23 +1678,24 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting, struct bt_codec *codec,
 				 u16 timeout);
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos,
+			      __u8 dst_type, struct bt_iso_qos_ext *qos,
 			      u16 timeout);
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
-			      struct bt_iso_qos *qos,
+			      struct bt_iso_qos_ext *qos,
 			      __u8 base_len, __u8 *base, u16 timeout);
 int hci_past_bis(struct hci_conn *conn, bdaddr_t *dst, __u8 dst_type);
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, struct bt_iso_qos_ext *qos,
 				 u16 timeout);
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, __u8 sid,
-				 struct bt_iso_qos *qos,
+				 struct bt_iso_qos_ext *qos,
 				 __u8 data_len, __u8 *data, u16 timeout);
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
-		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
+				    __u8 dst_type, __u8 sid,
+				    struct bt_iso_qos_ext *qos);
 int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     struct bt_iso_qos_ext *qos, __u16 sync_handle,
 			     __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index a24f6a84a447..aa12250eca52 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -195,5 +195,5 @@ int hci_le_read_remote_features(struct hci_conn *conn);
 int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
 int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys, u16 phy_opts);
 int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id);
-int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos *qos,
+int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 			   u8 num_bis);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c6f083b481be..c5eeb28ed135 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1637,7 +1637,7 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 	return 0;
 }
 
-static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
+static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos_ext *qos)
 {
 	struct hci_conn *conn;
 	u8  big;
@@ -1661,7 +1661,7 @@ static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
 	return 0;
 }
 
-static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
+static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos_ext *qos)
 {
 	struct hci_conn *conn;
 	u8  bis;
@@ -1703,7 +1703,7 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				    __u8 sid, struct bt_iso_qos *qos,
+				    __u8 sid, struct bt_iso_qos_ext *qos,
 				    __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
@@ -1938,7 +1938,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
-static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
+static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos_ext *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
@@ -1961,7 +1961,7 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	return hci_le_set_cig_params_sync(hdev, cig_id);
 }
 
-static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
+static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos_ext *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
@@ -2023,7 +2023,7 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 }
 
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos,
+			      __u8 dst_type, struct bt_iso_qos_ext *qos,
 			      u16 timeout)
 {
 	struct hci_conn *cis;
@@ -2166,7 +2166,7 @@ int hci_le_create_cis_pending(struct hci_dev *hdev)
 }
 
 static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
-			      struct bt_iso_io_qos *qos, __u8 phys)
+			      struct bt_iso_io_qos_ext *qos, __u8 phys)
 {
 	/* Only set MTU if PHY is enabled */
 	if (!qos->sdu && qos->phys)
@@ -2189,7 +2189,7 @@ static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos_ext *qos = &conn->iso_qos;
 	u16 interval, sync_interval = 0;
 	u32 flags = 0;
 	int err;
@@ -2218,7 +2218,7 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 				    __u8 dst_type, __u8 sid,
-				    struct bt_iso_qos *qos)
+				    struct bt_iso_qos_ext *qos)
 {
 	struct hci_conn *conn;
 
@@ -2241,7 +2241,7 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     struct bt_iso_qos_ext *qos, __u16 sync_handle,
 			     __u8 num_bis, __u8 bis[])
 {
 	int err;
@@ -2292,7 +2292,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
-			      struct bt_iso_qos *qos,
+			      struct bt_iso_qos_ext *qos,
 			      __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
@@ -2380,7 +2380,7 @@ static void bis_mark_per_adv(struct hci_conn *conn, void *data)
 
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, __u8 sid,
-				 struct bt_iso_qos *qos,
+				 struct bt_iso_qos_ext *qos,
 				 __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
@@ -2431,7 +2431,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, struct bt_iso_qos_ext *qos,
 				 u16 timeout)
 {
 	struct hci_conn *le;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8c46d742bbee..c95e092a832c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7379,7 +7379,7 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 	u32 c_sdu_interval, p_sdu_interval;
@@ -7554,7 +7554,7 @@ static int hci_iso_term_big_sync(struct hci_dev *hdev, void *data)
 
 static void hci_le_create_big_complete(struct hci_dev *hdev, u8 status,
 				       u8 handle, u8 num_bis,
-				       const __le16 *bis_handle)
+				       const __le16 *bis_handle, u16 rates)
 {
 	struct hci_conn *conn;
 	__u8 i = 0;
@@ -7596,6 +7596,7 @@ static void hci_le_create_big_complete(struct hci_dev *hdev, u8 status,
 		}
 
 		conn->state = BT_CONNECTED;
+		conn->iso_qos.bcast.out.rates = rates;
 		set_bit(HCI_CONN_BIG_CREATED, conn->flags);
 		hci_debugfs_create_conn(conn);
 		hci_conn_add_sysfs(conn);
@@ -7629,7 +7630,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 
 	hci_le_create_big_complete(hdev, ev->status, ev->handle, ev->num_bis,
-				   ev->bis_handle);
+				   ev->bis_handle, 0x0000);
 }
 
 static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
@@ -7885,7 +7886,7 @@ static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established_v3 *ev = data;
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 	u32 c_sdu_interval, p_sdu_interval;
@@ -7931,6 +7932,8 @@ static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
 		qos->ucast.out.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
 		qos->ucast.in.phys = le_phy_qos(ev->c_phy);
 		qos->ucast.out.phys = le_phy_qos(ev->p_phy);
+		qos->ucast.in.rates = le16_to_cpu(ev->c_rates);
+		qos->ucast.out.rates = le16_to_cpu(ev->p_rates);
 		break;
 	case HCI_ROLE_MASTER:
 		qos->ucast.in.interval = p_sdu_interval;
@@ -7946,6 +7949,8 @@ static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
 		qos->ucast.in.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
 		qos->ucast.out.phys = le_phy_qos(ev->c_phy);
 		qos->ucast.in.phys = le_phy_qos(ev->p_phy);
+		qos->ucast.out.rates = le16_to_cpu(ev->c_rates);
+		qos->ucast.in.rates = le16_to_cpu(ev->p_rates);
 		break;
 	}
 
@@ -7980,7 +7985,8 @@ static void hci_le_create_big_complete_v2_evt(struct hci_dev *hdev, void *data,
 		return;
 
 	hci_le_create_big_complete(hdev, ev->status, ev->handle, ev->num_bis,
-				   ev->bis_handle);
+				   ev->bis_handle,
+				   le16_to_cpu(ev->rates));
 }
 
 #define HCI_LE_EV_VL(_op, _func, _min_len, _max_len) \
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 30766dc8c1a0..adbb33709885 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3187,7 +3187,7 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 			conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
 						       &bdaddr);
 			if (conn) {
-				struct bt_iso_qos *qos = &conn->iso_qos;
+				struct bt_iso_qos_ext *qos = &conn->iso_qos;
 
 				if (qos->bcast.in.phys & BT_ISO_PHY_1M ||
 				    qos->bcast.in.phys & BT_ISO_PHY_2M) {
@@ -7874,7 +7874,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
-				   u16 acl_handle, struct bt_iso_qos *qos)
+				   u16 acl_handle, struct bt_iso_qos_ext *qos)
 {
 	struct hci_cp_le_past_params cp;
 	int err;
@@ -7908,7 +7908,7 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_pa_create_sync cp;
 	struct hci_conn *conn = data, *le;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos_ext *qos = &conn->iso_qos;
 	int err;
 
 	if (!hci_conn_valid(hdev, conn))
@@ -8049,7 +8049,7 @@ static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis,
 		    HCI_MAX_ISO_BIS);
 	struct hci_conn *conn = data;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos_ext *qos = &conn->iso_qos;
 	int err;
 
 	if (!hci_conn_valid(hdev, conn))
@@ -8406,7 +8406,7 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 	DEFINE_FLEX(struct hci_cp_le_set_cig_params_v2, pdu, cis, num_cis,
 		    0x1f);
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
@@ -8453,11 +8453,16 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
 
+		/* Use the rates of each direction, or all the HDT rates the
+		 * controller supports if none were set.
+		 */
 		if (cis->c_phys & HCI_LE_SET_PHY_HDT)
-			cis->c_hdt_rates = cpu_to_le16(hci_hdt_tx_rates(hdev));
+			cis->c_hdt_rates = cpu_to_le16(qos->ucast.out.rates ? :
+						       hci_hdt_tx_rates(hdev));
 
 		if (cis->p_phys & HCI_LE_SET_PHY_HDT)
-			cis->p_hdt_rates = cpu_to_le16(hci_hdt_rx_rates(hdev));
+			cis->p_hdt_rates = cpu_to_le16(qos->ucast.in.rates ? :
+						       hci_hdt_rx_rates(hdev));
 	}
 	pdu->num_cis = aux_num_cis;
 
@@ -8476,7 +8481,7 @@ int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_cig_params, pdu, cis, num_cis, 0x1f);
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
@@ -8539,7 +8544,7 @@ int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id)
 }
 
 static int hci_le_create_big_v2_sync(struct hci_conn *conn,
-				     struct bt_iso_qos *qos, u8 num_bis)
+				     struct bt_iso_qos_ext *qos, u8 num_bis)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_big_v2 cp;
@@ -8558,15 +8563,18 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
 
-	/* Check if HDT PHY is set then enable HDT supported rates */
+	/* Use the rates set, or all the HDT rates the controller supports if
+	 * none were set.
+	 */
 	if (cp.bis.phys & HCI_LE_SET_PHY_HDT)
-		cp.bis.hdt_rates = cpu_to_le16(hci_hdt_tx_rates(hdev));
+		cp.bis.hdt_rates = cpu_to_le16(qos->bcast.out.rates ? :
+					       hci_hdt_tx_rates(hdev));
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG_V2,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos *qos,
+int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 			   u8 num_bis)
 {
 	struct hci_dev *hdev = conn->hdev;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index cc6c8b7ba027..cab3c727514b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -75,7 +75,7 @@ struct iso_pinfo {
 	__u8			bc_bis[ISO_MAX_NUM_BIS];
 	__u16			sync_handle;
 	unsigned long		flags;
-	struct bt_iso_qos	qos;
+	struct bt_iso_qos_ext	qos;
 	bool			qos_user_set;
 	__u8			base_len;
 	__u8			base[BASE_MAX_LENGTH];
@@ -83,10 +83,10 @@ struct iso_pinfo {
 	struct delayed_work	timeout_work;
 };
 
-static struct bt_iso_qos default_qos;
+static struct bt_iso_qos_ext default_qos;
 
-static bool check_ucast_qos(struct bt_iso_qos *qos);
-static bool check_bcast_qos(struct bt_iso_qos *qos);
+static bool check_ucast_qos(struct bt_iso_qos_ext *qos);
+static bool check_bcast_qos(struct bt_iso_qos_ext *qos);
 static bool iso_match_sid(struct sock *sk, void *data);
 static bool iso_match_sid_past(struct sock *sk, void *data);
 static bool iso_match_sync_handle(struct sock *sk, void *data);
@@ -620,7 +620,7 @@ static int iso_connect_cis(struct sock *sk)
 	return err;
 }
 
-static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
+static struct bt_iso_qos_ext *iso_sock_get_qos(struct sock *sk)
 {
 	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
 		return &iso_pi(sk)->conn->hcon->iso_qos;
@@ -628,11 +628,87 @@ static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
 	return &iso_pi(sk)->qos;
 }
 
+/* The unicast QoS is a prefix of the broadcast one, with the same fields at
+ * the same offsets, in both struct bt_iso_qos and struct bt_iso_qos_ext, so
+ * converting the broadcast view converts either.
+ */
+static void iso_io_qos_to_ext(const struct bt_iso_io_qos *io,
+			      struct bt_iso_io_qos_ext *ext)
+{
+	ext->interval = io->interval;
+	ext->latency = io->latency;
+	ext->sdu = io->sdu;
+	ext->phys = io->phys;
+	ext->rtn = io->rtn;
+	ext->rates = 0x0000;
+}
+
+static void iso_io_qos_from_ext(const struct bt_iso_io_qos_ext *ext,
+				struct bt_iso_io_qos *io)
+{
+	io->interval = ext->interval;
+	io->latency = ext->latency;
+	io->sdu = ext->sdu;
+	io->phys = ext->phys;
+	io->rtn = ext->rtn;
+}
+
+static void iso_qos_to_ext(const struct bt_iso_qos *qos,
+			   struct bt_iso_qos_ext *ext)
+{
+	const struct bt_iso_bcast_qos *b = &qos->bcast;
+	struct bt_iso_bcast_qos_ext *e = &ext->bcast;
+
+	memset(ext, 0, sizeof(*ext));
+	ext->version = BT_ISO_QOS_VERSION_1;
+
+	e->big = b->big;
+	e->bis = b->bis;
+	e->sync_factor = b->sync_factor;
+	e->packing = b->packing;
+	e->framing = b->framing;
+	iso_io_qos_to_ext(&b->in, &e->in);
+	iso_io_qos_to_ext(&b->out, &e->out);
+	e->encryption = b->encryption;
+	memcpy(e->bcode, b->bcode, sizeof(e->bcode));
+	e->options = b->options;
+	e->skip = b->skip;
+	e->sync_timeout = b->sync_timeout;
+	e->sync_cte_type = b->sync_cte_type;
+	e->mse = b->mse;
+	e->timeout = b->timeout;
+}
+
+static void iso_qos_from_ext(const struct bt_iso_qos_ext *ext,
+			     struct bt_iso_qos *qos)
+{
+	const struct bt_iso_bcast_qos_ext *e = &ext->bcast;
+	struct bt_iso_bcast_qos *b = &qos->bcast;
+
+	memset(qos, 0, sizeof(*qos));
+
+	b->big = e->big;
+	b->bis = e->bis;
+	b->sync_factor = e->sync_factor;
+	b->packing = e->packing;
+	b->framing = e->framing;
+	iso_io_qos_from_ext(&e->in, &b->in);
+	iso_io_qos_from_ext(&e->out, &b->out);
+	b->encryption = e->encryption;
+	memcpy(b->bcode, e->bcode, sizeof(b->bcode));
+	b->options = e->options;
+	b->skip = e->skip;
+	b->sync_timeout = e->sync_timeout;
+	b->sync_cte_type = e->sync_cte_type;
+	b->mse = e->mse;
+	b->timeout = e->timeout;
+}
+
 static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
 			  const struct sockcm_cookie *sockc)
 {
 	struct iso_conn *conn = iso_pi(sk)->conn;
-	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
+	struct bt_iso_qos_ext *qos = iso_sock_get_qos(sk);
 	struct hci_iso_data_hdr *hdr;
 	int len = 0;
 
@@ -1009,7 +1085,8 @@ static struct proto iso_proto = {
 	.rtn		= 2u, \
 }
 
-static struct bt_iso_qos default_qos = {
+static struct bt_iso_qos_ext default_qos = {
+	.version = BT_ISO_QOS_VERSION_1,
 	.bcast = {
 		.big			= BT_ISO_QOS_BIG_UNSET,
 		.bis			= BT_ISO_QOS_BIS_UNSET,
@@ -1863,7 +1940,7 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return bt_sock_recvmsg(sock, msg, len, flags);
 }
 
-static bool check_io_qos(struct bt_iso_io_qos *qos)
+static bool check_io_qos(struct bt_iso_io_qos_ext *qos)
 {
 	/* If no PHY is enable SDU must be 0 */
 	if (!qos->phys && qos->sdu)
@@ -1881,7 +1958,7 @@ static bool check_io_qos(struct bt_iso_io_qos *qos)
 	return true;
 }
 
-static bool check_ucast_qos(struct bt_iso_qos *qos)
+static bool check_ucast_qos(struct bt_iso_qos_ext *qos)
 {
 	if (qos->ucast.cig > 0xef && qos->ucast.cig != BT_ISO_QOS_CIG_UNSET)
 		return false;
@@ -1907,7 +1984,7 @@ static bool check_ucast_qos(struct bt_iso_qos *qos)
 	return true;
 }
 
-static bool check_bcast_qos(struct bt_iso_qos *qos)
+static bool check_bcast_qos(struct bt_iso_qos_ext *qos)
 {
 	if (!qos->bcast.sync_factor)
 		qos->bcast.sync_factor = 0x01;
@@ -1959,7 +2036,8 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
-	struct bt_iso_qos qos = default_qos;
+	struct bt_iso_qos_ext qos = default_qos;
+	struct bt_iso_qos qos_old;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -2005,9 +2083,32 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = copy_safe_from_sockptr(&qos, sizeof(qos), optval, optlen);
-		if (err)
-			break;
+		/* The length of struct bt_iso_qos selects it, any other
+		 * length is struct bt_iso_qos_ext of a known version.
+		 */
+		if (optlen == sizeof(qos_old)) {
+			err = copy_safe_from_sockptr(&qos_old, sizeof(qos_old),
+						     optval, optlen);
+			if (err)
+				break;
+
+			iso_qos_to_ext(&qos_old, &qos);
+		} else {
+			if (optlen < sizeof(qos)) {
+				err = -EINVAL;
+				break;
+			}
+
+			err = copy_struct_from_sockptr(&qos, sizeof(qos),
+						       optval, optlen);
+			if (err)
+				break;
+
+			if (qos.version != BT_ISO_QOS_VERSION_1) {
+				err = -EINVAL;
+				break;
+			}
+		}
 
 		iso_pi(sk)->qos = qos;
 		iso_pi(sk)->qos_user_set = true;
@@ -2048,7 +2149,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 			       sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
+	struct bt_iso_qos qos_old;
 	int len, val, err = 0;
 	u8 base_len;
 	u8 *base;
@@ -2083,9 +2185,20 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 	case BT_ISO_QOS:
 		qos = iso_sock_get_qos(sk);
 
-		len = min_t(unsigned int, len, sizeof(*qos));
-		if (copy_to_iter(qos, len, &opt->iter_out) != len)
-			err = -EFAULT;
+		/* A buffer too short for struct bt_iso_qos_ext gets
+		 * struct bt_iso_qos, as it did before the extension.
+		 */
+		if (len < sizeof(*qos)) {
+			iso_qos_from_ext(qos, &qos_old);
+
+			len = min_t(unsigned int, len, sizeof(qos_old));
+			if (copy_to_iter(&qos_old, len, &opt->iter_out) != len)
+				err = -EFAULT;
+		} else {
+			len = sizeof(*qos);
+			if (copy_to_iter(qos, len, &opt->iter_out) != len)
+				err = -EFAULT;
+		}
 
 		break;
 
-- 
2.56.0


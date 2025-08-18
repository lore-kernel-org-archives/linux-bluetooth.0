Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3920A5E5
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550097; cv=none; b=IjqrhMrIB9NT426TQpcHkbOV0ccAr5b1CFLtDAGilfLPJUBXSRdl5oLtb9izLwlq/d7jD0Sknyiy1o8HRhvxl6UJ9tUokkd6+6HBeUeMsk15LNYW91wuwsfP2u7lrhcVsb+8KZVz4hQl4ujSRdoLBxdYPWMFZBMdpjifPTki9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550097; c=relaxed/simple;
	bh=hp3apI8R3K9Wzo5m6b+XGqGzzHcG7BOScTmnIOBJ8KI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yc27uGxQk5X/JBONLr67ijpTdCQUgjS3CRVp1RORW+9AsGlhgGtTTo4hr8UnvRPpC5PVmZKoxASQ6joUF4ib7wXYA6/RtGcebo6VsHUR5wMZR4nydJGgiwTjci3JOkc1r66FWiT65ERv9OpCe2rQt8yCnXj6BIH4FBp/RfU+ty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjo+wCqm; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjo+wCqm"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-53b17498109so1619103e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755550093; x=1756154893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TA7rCqdWfq1Lu8cmykp1K4AwN69NpoCBP+oajTs3DlI=;
        b=bjo+wCqmhhMbKvBITvubZI7fwflBd4cdg3mkz2PW5/r5a0zlU/EGUBzJQcMpsUPukF
         PFxwHtgfsBE0NXYRVvwAoMJtpBtsOqLw9Tw7pRmNoedcQkDWlC01YY+upNfUtukIToFe
         RjCCX+RCnNQ3n6wE40fMHp8snI3tMmSc2FwOB7ksjmk6pedMXvEorHuksQXJc97/9Ss/
         ioYl1TzBfIaeXxmONVQmlCp/A9uaqhTJ2o1dwHuxD/vvFp2wuzn5lsGCg6OCPZfuC3eX
         aQ65a99E3Z/JHJzIQREzHIcPOBmUlCRbpawlw9JJtf60EdJuDahy4MaRIsVIU11AW6dr
         +E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550093; x=1756154893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TA7rCqdWfq1Lu8cmykp1K4AwN69NpoCBP+oajTs3DlI=;
        b=XPYznv3cbyR6wLt95bDjdAtHdLmMpLxzzlH73xacqmVl5bFq9OD8jjVev/+T15lT6N
         xNfBvjHo3coMa3j10hN/ieWrTFEF6AI3rEsMJL5kQCWgvR0hH0LK0W7plvtWLdpfm64f
         xstjqgyZ5TwG1RIfdsja+T0bkUCr936GLD5GYOz9u6ka7OzU30oznih4xLGyTGo9gv8c
         GJDhn43YJc8wFXEMk0vJCEZVtAR6wPlh3KDdrZ4pZGusZkUr8E9g3NofD26zLy+SWawa
         QxSsoCMHm/UtBXJ4D/ssXqgV/QTAx75UR2egXXn/WY/vwFrosnCmjKaa+Jp5A866UoLV
         Id4A==
X-Gm-Message-State: AOJu0YzkX8gVJtfRJjWQx8sQIeZCjCrkEeW3INoyGCLTzfOKwmJ6XTJZ
	vTBvxOT/+pomqPv3e43K6IwvlDnkPJlnQ9UZkDP81SBlycRDHNEClOmhg2trqIQX
X-Gm-Gg: ASbGncsdcaTbaheoOS91T0wa1NSV3JAMRhBUxkFcVKsvC/Afa9K7JD9ZDNr2asIcknB
	72sACcAMGh6FdRw8Qbj60s+kEsBT4nNLJZiHOI5wkvFMU9LW297pTgiNWth0dqNjRQVoj4rfded
	RgF2aux8q3aUWGMC9BtTs3Km3uQC7hj1ZMN0jH5yC8G6LXsbYDRETEJkeUa8ixZEM/CNUzK2G82
	MQrQ7ODCihUytc4oUiGCyBo6+1jk5XooPaHyRi26UlSrPYK4opfylGm0yrJ3/EWBAQmWAswztvt
	v4Xhq4eUnfSIkfx47acHHWv1V/ZQNmocdT8U4WxAzy9eCTb9HjEJjX/L/qCSlRZO/9IDv3pzgDb
	4W+UFLQ1VAKrBCEb7JsEtIraFwLgvvvtiLIKeGjJlglYdvOAkdw8yE38vJVGp4qy1
X-Google-Smtp-Source: AGHT+IEBhXxlzbMS9ss0AATUmvTyv8eC8O2/P0zxiPG4T6FlvOUrMA/AMjZaNtaekYNZzH+TYO7ZwA==
X-Received: by 2002:a05:6122:2507:b0:538:dbd2:2ece with SMTP id 71dfb90a1353d-53b5d306efamr81077e0c.11.1755550093346;
        Mon, 18 Aug 2025 13:48:13 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd553casm2101079e0c.2.2025.08.18.13.48.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:48:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/8] Bluetooth: hci_conn: Add bt_conn_dbg
Date: Mon, 18 Aug 2025 16:47:52 -0400
Message-ID: <20250818204753.1203949-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818204753.1203949-1-luiz.dentz@gmail.com>
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_conn_dbg macro which wraps bt_dev_dbg adding handle and
state information which might be useful while debugging.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 73 +++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0bb7142bcac5..131f4fbecb1b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -38,6 +38,14 @@
 #include "smp.h"
 #include "eir.h"
 
+#define bt_conn_hdev(conn) ((conn) ? (conn)->hdev : NULL)
+#define bt_conn_handle(conn) ((conn) ? (conn)->handle : 0)
+#define bt_conn_state_str(conn) ((conn) ? state_to_string((conn)->state) : NULL)
+#define bt_conn_dbg(conn, fmt, ...) \
+	bt_dev_dbg(bt_conn_hdev(conn), "hcon %p handle 0x%4.4x state %s" fmt, \
+		   conn, bt_conn_handle(conn), bt_conn_state_str(conn), \
+		   ##__VA_ARGS__)
+
 struct sco_param {
 	u16 pkt_type;
 	u16 max_latency;
@@ -177,7 +185,7 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 
 int hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
-	bt_dev_dbg(conn->hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	/* When we are central of an established connection and it enters
 	 * the disconnect timeout, then go ahead and try to read the
@@ -202,7 +210,7 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_add_sco cp;
 
-	bt_dev_dbg(hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	hci_conn_set_state(conn, BT_CONNECT);
 	conn->out = true;
@@ -225,9 +233,8 @@ static bool find_next_esco_param(struct hci_conn *conn,
 		if (lmp_esco_2m_capable(conn->parent) ||
 		    (esco_param[conn->attempt - 1].pkt_type & ESCO_2EV3))
 			break;
-		bt_dev_dbg(conn->hdev,
-			   "hcon %p skipped attempt %d, eSCO 2M not supported",
-			   conn, conn->attempt);
+		bt_conn_dbg(conn, "skipped attempt %d, eSCO 2M not supported",
+			    conn->attempt);
 	}
 
 	return conn->attempt <= size;
@@ -292,7 +299,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	if (!hci_conn_valid(hdev, conn))
 		return -ECANCELED;
 
-	bt_dev_dbg(hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	configure_datapath_sync(hdev, &conn->codec);
 
@@ -411,7 +418,7 @@ static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 	struct hci_cp_setup_sync_conn cp;
 	const struct sco_param *param;
 
-	bt_dev_dbg(hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	hci_conn_set_state(conn, BT_CONNECT);
 	conn->out = true;
@@ -523,7 +530,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_start_enc cp;
 
-	bt_dev_dbg(hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	memset(&cp, 0, sizeof(cp));
 
@@ -544,7 +551,7 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 	if (!link || !link->conn)
 		return;
 
-	bt_dev_dbg(conn->hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	if (!status) {
 		if (lmp_esco_capable(conn->hdev))
@@ -563,8 +570,7 @@ static void hci_conn_timeout(struct work_struct *work)
 					     disc_work.work);
 	int refcnt = atomic_read(&conn->refcnt);
 
-	bt_dev_dbg(conn->hdev, "hcon %p state %s", conn,
-		   state_to_string(conn->state));
+	bt_conn_dbg(conn, "state %s", state_to_string(conn->state));
 
 	WARN_ON(refcnt < 0);
 
@@ -588,7 +594,7 @@ static void hci_conn_idle(struct work_struct *work)
 					     idle_work.work);
 	struct hci_dev *hdev = conn->hdev;
 
-	bt_dev_dbg(hdev, "hcon %p mode %d", conn, conn->mode);
+	bt_conn_dbg(conn, "mode %d", conn->mode);
 
 	if (!lmp_sniff_capable(hdev) || !lmp_sniff_capable(conn))
 		return;
@@ -648,7 +654,7 @@ static void le_conn_timeout(struct work_struct *work)
 					     le_conn_timeout.work);
 	struct hci_dev *hdev = conn->hdev;
 
-	bt_dev_dbg(hdev, "");
+	bt_conn_dbg(conn, "");
 
 	/* We could end up here due to having done directed advertising,
 	 * so clean up the state if necessary. This should however only
@@ -823,7 +829,7 @@ static void bis_cleanup(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_conn *bis;
 
-	bt_dev_dbg(hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	if (conn->role == HCI_ROLE_MASTER) {
 		if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
@@ -1102,7 +1108,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	bt_dev_dbg(hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	if (!conn->parent) {
 		struct hci_link *link, *t;
@@ -1144,7 +1150,7 @@ void hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	bt_dev_dbg(hdev, "hcon %p handle %d", conn, conn->handle);
+	bt_conn_dbg(conn, "");
 
 	hci_conn_unlink(conn);
 
@@ -1294,7 +1300,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+	bt_conn_dbg(conn, "status 0x%2.2x", status);
 
 	switch (conn->type) {
 	case LE_LINK:
@@ -1321,7 +1327,7 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	bt_dev_dbg(hdev, "hcon %p handle 0x%4.4x", conn, handle);
+	bt_conn_dbg(conn, "");
 
 	if (conn->handle == handle)
 		return 0;
@@ -2170,7 +2176,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn = data;
 
-	bt_dev_dbg(hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
@@ -2352,7 +2358,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 /* Check link security requirement */
 int hci_conn_check_link_mode(struct hci_conn *conn)
 {
-	bt_dev_dbg(conn->hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	/* In Secure Connections Only mode, it is required that Secure
 	 * Connections is used and the link is encrypted with AES-CCM
@@ -2392,7 +2398,7 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 /* Authenticate remote device */
 static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 {
-	bt_dev_dbg(conn->hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	if (conn->pending_sec_level > sec_level)
 		sec_level = conn->pending_sec_level;
@@ -2427,7 +2433,7 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 /* Encrypt the link */
 static void hci_conn_encrypt(struct hci_conn *conn)
 {
-	bt_dev_dbg(conn->hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	if (!test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags)) {
 		struct hci_cp_set_conn_encrypt cp;
@@ -2442,8 +2448,8 @@ static void hci_conn_encrypt(struct hci_conn *conn)
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 		      bool initiator)
 {
-	bt_dev_dbg(conn->hdev, "hcon %p sec_level %d auth_type %d initiator %d",
-		   conn, sec_level, auth_type, initiator);
+	bt_conn_dbg(conn, "sec_level %d auth_type %d initiator %d",
+		    sec_level, auth_type, initiator);
 
 	if (conn->type == LE_LINK)
 		return smp_conn_security(conn, sec_level);
@@ -2527,7 +2533,7 @@ EXPORT_SYMBOL(hci_conn_security);
 /* Check secure link requirement */
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level)
 {
-	bt_dev_dbg(conn->hdev, "hcon %p sec_level %u", conn, sec_level);
+	bt_conn_dbg(conn, "sec_level %u", sec_level);
 
 	/* Accept if non-secure or higher security level is required */
 	if (sec_level != BT_SECURITY_HIGH && sec_level != BT_SECURITY_FIPS)
@@ -2546,7 +2552,7 @@ EXPORT_SYMBOL(hci_conn_check_secure);
 /* Switch role */
 int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
 {
-	bt_dev_dbg(conn->hdev, "hcon %p role %u", conn, role);
+	bt_conn_dbg(conn, "role %u", role);
 
 	if (role == conn->role)
 		return 1;
@@ -2567,7 +2573,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	bt_dev_dbg(hdev, "hcon %p mode %d", conn, conn->mode);
+	bt_conn_dbg(conn, "mode %d", conn->mode);
 
 	if (conn->mode != HCI_CM_SNIFF)
 		goto timer;
@@ -2733,13 +2739,12 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
 
 struct hci_chan *hci_chan_create(struct hci_conn *conn)
 {
-	struct hci_dev *hdev = conn->hdev;
 	struct hci_chan *chan;
 
-	bt_dev_dbg(hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	if (test_bit(HCI_CONN_DROP, &conn->flags)) {
-		bt_dev_dbg(hdev, "Refusing to create new hci_chan");
+		bt_conn_dbg(conn, "Refusing to create new hci_chan");
 		return NULL;
 	}
 
@@ -2759,9 +2764,8 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 void hci_chan_del(struct hci_chan *chan)
 {
 	struct hci_conn *conn = chan->conn;
-	struct hci_dev *hdev = conn->hdev;
 
-	bt_dev_dbg(hdev, "hcon %p chan %p", conn, chan);
+	bt_conn_dbg(conn, "chan %p", chan);
 
 	list_del_rcu(&chan->list);
 
@@ -2780,7 +2784,7 @@ void hci_chan_list_flush(struct hci_conn *conn)
 {
 	struct hci_chan *chan, *n;
 
-	bt_dev_dbg(conn->hdev, "hcon %p", conn);
+	bt_conn_dbg(conn, "");
 
 	list_for_each_entry_safe(chan, n, &conn->chan_list, list)
 		hci_chan_del(chan);
@@ -2941,8 +2945,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	if (conn->abort_reason)
 		return 0;
 
-	bt_dev_dbg(hdev, "hcon %p handle 0x%2.2x reason 0x%2.2x", conn,
-		   conn->handle, reason);
+	bt_conn_dbg(conn, "reason 0x%2.2x", reason);
 
 	conn->abort_reason = reason;
 
-- 
2.50.1


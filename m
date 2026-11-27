Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769661;
	b=E6JXgWhC/fESEV6cSFOgPFiwSvzItwtJmFCrr6nnDOE3h5qB2W+9XXUiQ8fnFfqZmUgr
	 aX21W5rPKsF1OOSSAJnkgJomG/vW9uD8rEgF0Le/nYGG5ZzfU9jyFql7APK0aVXucBWNQ
	 PoaJ9OS/ZY9ajQGC6r6PS/Ou276914XEYQJUHYi5kLvcobUl17r/v+5QTNh5mennvZdO6
	 1XJl01g2n7F5uutr0JOvkcZLHxcyIDpfuXq2BQpohtD457YbatAtQl4UJCA/pmbdRmiXr
	 btjLc1XjYAtlhgWGoDA9abPpVqtTHkhD+O0W0RspqG3p4+FXNkwqGMwNeNojFPdULOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PApCILsG8T/qahkX+mtiSOyYvjDwu3+/cJ8XM53FRkU=;
	b=ihLseZkmZKCz46fFqjSdICS+tojhtooFCF6ucAZfXBQXatikLe2FySPXbHfMtFDnNYfn
	 5YmuNA9bwomgC+T+thUwde1bXMs2LOepIhhqj7SK+oSoueHFReo6mlPksxUYLrVWvsWKp
	 zk1G5oLjJ6n3UQWAKP1FrdtaSDLyPKhp29QKZw8Ltduv1f7j8jQIEn/7Mz3ibVfvjDhTc
	 NXP1nxKKcZpgIeWhcaD0TwVBRfW6Ur+rkt7Wwzdnc+j/IuajeChtqpZDTRqjEhU96Zf9v
	 LDv+hUR/kfNSmzo3Bg0khWt0UUyiquOCWQ02qne0ejIr81rYzpe2LFHu3QcpF8NNjHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pTXpXtxd;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827B606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0827B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pTXpXtxd
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c499b5be0f1so109854166b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769659; x=1796374459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PApCILsG8T/qahkX+mtiSOyYvjDwu3+/cJ8XM53FRkU=;
        b=pTXpXtxdNiHAEbqVIMPtMxvxSnCJUj678j/qqdq3GumaNw4jIfpyxP4uWL/IN+31Hw
         EmonQIpLL98fpy+MjYHjdSBjEPHTdWppt2syAvVpvTSu5MNphG8rEUmSuv1QytyMzCq/
         fPjJoVT/ZhZ+wdAnHC5plFzY6O+ILAJA8Gw51VCJd5bed9XkWpT2YndBdFjrDkEO8Edt
         1htzn/myZOqGDarqMw6BmzivKFAbt2SrbGgLqNlUD1A/o7Y+djBw6DSIK0PaMy9g1ucx
         irrqDVp8Ia0xyURBMm8DABO4zPYjV3oo8XnjhwozSljy6r9k72cMlKfWf0428h1Ku+4a
         ufvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769659; x=1796374459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PApCILsG8T/qahkX+mtiSOyYvjDwu3+/cJ8XM53FRkU=;
        b=tNkx0AOnifPmeh1wcqnBnxTPRqZXGp+bx+rQzZnPyekLNFcmnqTQIS1dahS17976ze
         9drG2o79Rfn3NBoJy6oZzTSkqLZBJagOgtIWvWEgFXW85hsZA8QpLgbmQA2aOKlHxoEd
         hKwlGenyIcX6zUaLTSTUaH4G/nnZiABdR3VWH8r72Rfc1GbvvhAaXiHDIFLLqnn1maxA
         enbFAB2CQ8lPweTTF+De20ZTNernPVdgR6xHXGIs88uGzDtkXw+SkGokEMwxlVImEUrJ
         Hpmp6pfZDXlah/G8fx2mC3sKQoo1C77AllSlGWXF5R/A0VYiB0UFoCsvHDFLNJAuQYYb
         zjlA==
X-Gm-Message-State: APuU4Z8NKa4S+PH88LqlD77eMLnN6DrZinpxubSZ+M6yPMqKLxNkgxeR
	3nt42/q/+G5jXeiA0ujldJDpGp+BEILEvUGQAuh+ymU22lq5kybDvgkpHJvjVC0B
X-Gm-Gg: AZFdTZcOOMsxpsW+P1VNBMQaTFJuyxQK72iqzziomH3xgJVj6lKlUyI1tBsFsV+yUpG
	HchsVF5+nm0WKTBMpuH7argk9IdZjTaP4D1PZxrFoab2D9zCDoXUX37n+zXHI11wxZptu7xWDb3
	W8xUX0gLzLFw42T3ewsYnJVz8dvk7NnWqDI+urjwILF1IkrvvWzvVwZNnbOwAiJ1mj4ONmXYVpt
	xw8ZBXM+SofZOzGee/sIB6G9crkZa7GN+z6EfE3Rin6OCdLrShFobSxf0oAeiUvZ7UiYRd66vtN
	4Cfy26FsrhAYQZ/fBpFjhMiEqIeKFTRWjtMEhzrJc2/0WWSQAKOWXAVI2eu5r9FGwGZNuMn2xaE
	AafK/0rgPBpM1Ygif3n8wkWsa3NG2IYOaXL9vW5uyN0cMDZ3uF11PSc0cqCZ6g+WalNVGbU0N1X
	TX09wImXg7CswRotyYVc0HmA38zaWbu1C9O+OvofuD/H8MXNck4sHmMiJKpphVL3wBeub3GeHoj
	NuQn4Bx0LMFdZYDlTsIqKv8QkNeFmXv83DceOvjLz277rawKe/3iPJ2NlhD0DkJWQ9ya0azqzfX
	I0CGsEpI0gQYjBtOf6+h7mXuSR0LMI1U334=
X-Received: by 2002:a17:906:26c5:b0:c51:3b84:6fb8 with SMTP id a640c23a62f3a-c513b84886cmr1725813566b.4.1795769659234;
        Fri, 27 Nov 2026 00:54:19 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm870688166b.33.2026.11.27.00.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:54:18 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH 5/5] Bluetooth: MGMT: Add PAwR subevent data and response reports
Date: Fri, 27 Nov 2026 09:54:00 +0100
Message-ID: <20261127085401.263615-6-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085401.263615-1-rolandschober1968@gmail.com>
References: <20261127085401.263615-1-rolandschober1968@gmail.com>
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

Complete the advertiser side of Periodic Advertising with Responses
(PAwR) over MGMT:

  PA Subevent Data Request event    the controller asks for the data
                                    of a range of subevents
  Set PA Subevent Data command      user space answers with that data
  PA Response Report event          the responses received in the
                                    response slots of a subevent

The LE events behind the two MGMT events are enabled if the controller
supports the PAwR advertiser feature, and are forwarded for instances
with subevents only.

The controller wants the subevent data within its lead time, a few tens
of milliseconds before the subevent. Set PA Subevent Data is therefore
sent with hci_send_cmd() and answered from the Command Complete handler,
not queued with hci_cmd_sync_queue(), where it would wait behind
sequences which block for an event, such as creating a connection.

Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Roland Schober <rolandschober1968@gmail.com>
---
 include/net/bluetooth/hci_core.h |   6 ++
 include/net/bluetooth/mgmt.h     |  49 ++++++++++
 net/bluetooth/hci_event.c        |  90 +++++++++++++++++
 net/bluetooth/hci_sync.c         |   5 +
 net/bluetooth/mgmt.c             | 162 +++++++++++++++++++++++++++++++
 5 files changed, 312 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 117408645b9b..37ac912fbb85 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2661,6 +2661,12 @@ void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 				  bdaddr_t *bdaddr, u8 addr_type);
 void mgmt_conn_subrate_notify(struct hci_dev *hdev, struct hci_conn *conn,
 			      u8 status);
+void mgmt_pa_subevent_data_request(struct hci_dev *hdev, u8 instance,
+				   u8 subevent_start, u8 subevent_data_count);
+void mgmt_set_pa_subevent_data_complete(struct hci_dev *hdev, u8 status);
+void mgmt_pa_response_report(struct hci_dev *hdev, u8 instance, u8 subevent,
+			     u8 tx_status, u8 num_responses,
+			     const void *responses, u16 len);
 
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a46e87a9152c..b85ff94e518c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -952,6 +952,28 @@ struct mgmt_rp_add_periodic_adv_data {
 	__u8	instance;
 } __packed;
 
+struct mgmt_pa_subevent_data {
+	__u8	subevent;
+	__u8	response_slot_start;
+	__u8	response_slot_count;
+	__u8	data_len;
+	__u8	data[] __counted_by(data_len);
+} __packed;
+
+/* The answer to MGMT_EV_PA_SUBEVENT_DATA_REQUEST: num_subevents entries of
+ * struct mgmt_pa_subevent_data.
+ */
+#define MGMT_OP_SET_PA_SUBEVENT_DATA	0x005F
+struct mgmt_cp_set_pa_subevent_data {
+	__u8	instance;
+	__u8	num_subevents;
+	__u8	subevents[];
+} __packed;
+#define MGMT_SET_PA_SUBEVENT_DATA_SIZE	2
+struct mgmt_rp_set_pa_subevent_data {
+	__u8	instance;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -1276,3 +1298,30 @@ struct mgmt_ev_security_level_changed {
 	__u8	tlv_length;
 	__u8	tlv_data[] __counted_by(tlv_length);
 } __packed;
+
+#define MGMT_EV_PA_SUBEVENT_DATA_REQUEST	0x0035
+struct mgmt_ev_pa_subevent_data_request {
+	__u8	instance;
+	__u8	subevent_start;
+	__u8	subevent_data_count;
+} __packed;
+
+struct mgmt_pa_response {
+	__s8	tx_power;
+	__s8	rssi;
+	__u8	cte_type;
+	__u8	response_slot;
+	__u8	data_status;
+	__u8	data_len;
+	__u8	data[] __counted_by(data_len);
+} __packed;
+
+/* num_responses entries of struct mgmt_pa_response */
+#define MGMT_EV_PA_RESPONSE_REPORT		0x0036
+struct mgmt_ev_pa_response_report {
+	__u8	instance;
+	__u8	subevent;
+	__u8	tx_status;
+	__u8	num_responses;
+	__u8	responses[];
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a9b6a6ccaa03..b88dad2eadf3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4598,6 +4598,20 @@ static u8 hci_cc_le_set_per_adv_enable(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_le_set_per_adv_subevent_data(struct hci_dev *hdev, void *data,
+					      struct sk_buff *skb)
+{
+	struct hci_ev_status *rp = data;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	hci_dev_lock(hdev);
+	mgmt_set_pa_subevent_data_complete(hdev, rp->status);
+	hci_dev_unlock(hdev);
+
+	return rp->status;
+}
+
 #define HCI_CC_VL(_op, _func, _min, _max) \
 { \
 	.op = _op, \
@@ -4774,6 +4788,10 @@ static const struct hci_cc {
 	HCI_CC_STATUS(HCI_OP_LE_SET_PER_ADV_PARAMS, hci_cc_set_per_adv_param),
 	HCI_CC_STATUS(HCI_OP_LE_SET_PER_ADV_ENABLE,
 		      hci_cc_le_set_per_adv_enable),
+	/* Status and advertising handle */
+	HCI_CC_VL(HCI_OP_LE_SET_PER_ADV_SUBEVENT_DATA,
+		  hci_cc_le_set_per_adv_subevent_data,
+		  sizeof(struct hci_ev_status), HCI_MAX_CC_PLEN),
 	HCI_CC(HCI_OP_LE_READ_TRANSMIT_POWER, hci_cc_le_read_transmit_power,
 	       sizeof(struct hci_rp_le_read_transmit_power)),
 	HCI_CC_STATUS(HCI_OP_LE_SET_PRIVACY_MODE, hci_cc_le_set_privacy_mode),
@@ -8128,6 +8146,69 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_per_adv_subevent_data_req_evt(struct hci_dev *hdev,
+						 void *data,
+						 struct sk_buff *skb)
+{
+	struct hci_ev_le_per_adv_subevent_data_req *ev = data;
+	struct adv_info *adv;
+
+	bt_dev_dbg(hdev, "handle 0x%2.2x start %u count %u", ev->handle,
+		   ev->subevent_start, ev->subevent_data_count);
+
+	hci_dev_lock(hdev);
+
+	adv = hci_le_ext_adv_owner(hdev, ev->handle);
+	if (adv && adv->num_subevents)
+		mgmt_pa_subevent_data_request(hdev, adv->instance,
+					      ev->subevent_start,
+					      ev->subevent_data_count);
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_le_per_adv_response_report_evt(struct hci_dev *hdev,
+					       void *data, struct sk_buff *skb)
+{
+	struct hci_ev_le_per_adv_response_report *ev = data;
+	struct hci_le_per_adv_response *rsp;
+	struct adv_info *adv;
+	void *responses = skb->data;
+	u16 len = skb->len;
+	u8 i;
+
+	bt_dev_dbg(hdev, "handle 0x%2.2x subevent %u num %u", ev->handle,
+		   ev->subevent, ev->num_responses);
+
+	/* The responses go to user space as they are: check that they are
+	 * all there.
+	 */
+	for (i = 0; i < ev->num_responses; i++) {
+		rsp = hci_le_ev_skb_pull(hdev, skb,
+					 HCI_EV_LE_PER_ADV_RESPONSE_REPORT,
+					 sizeof(*rsp));
+		if (!rsp)
+			return;
+
+		if (!hci_le_ev_skb_pull(hdev, skb,
+					HCI_EV_LE_PER_ADV_RESPONSE_REPORT,
+					rsp->data_len))
+			return;
+	}
+
+	len -= skb->len;
+
+	hci_dev_lock(hdev);
+
+	adv = hci_le_ext_adv_owner(hdev, ev->handle);
+	if (adv && adv->num_subevents)
+		mgmt_pa_response_report(hdev, adv->instance, ev->subevent,
+					ev->tx_status, ev->num_responses,
+					responses, len);
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 						void *data, struct sk_buff *skb)
 {
@@ -8437,6 +8518,15 @@ static const struct hci_le_ev {
 		     hci_le_big_info_adv_report_evt,
 		     sizeof(struct hci_evt_le_big_info_adv_report),
 		     HCI_MAX_LE_SUBEVT_PLEN),
+	/* [0x27 = HCI_EV_LE_PER_ADV_SUBEVENT_DATA_REQ] */
+	HCI_LE_EV(HCI_EV_LE_PER_ADV_SUBEVENT_DATA_REQ,
+		  hci_le_per_adv_subevent_data_req_evt,
+		  sizeof(struct hci_ev_le_per_adv_subevent_data_req)),
+	/* [0x28 = HCI_EV_LE_PER_ADV_RESPONSE_REPORT] */
+	HCI_LE_EV_VL(HCI_EV_LE_PER_ADV_RESPONSE_REPORT,
+		     hci_le_per_adv_response_report_evt,
+		     sizeof(struct hci_ev_le_per_adv_response_report),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x2b = HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE] */
 	HCI_LE_EV_VL(HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE,
 		     hci_le_read_all_remote_features_evt,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 05151cf6f413..71005596f7df 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5099,6 +5099,11 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (ll_ext_feature_capable(hdev))
 		events[5] |= BIT(2);
 
+	if (pawr_adv_capable(hdev)) {
+		events[4] |= 0x40;	/* LE PA Subevent Data Request */
+		events[4] |= 0x80;	/* LE PA Response Report */
+	}
+
 	if (le_cs_capable(hdev)) {
 		/* Channel Sounding events */
 		events[5] |= 0x08;	/* LE CS Read Remote Supported Cap Complete event */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0f8a58ad1e3c..037cb8513a11 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -132,6 +132,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_HCI_CMD_SYNC,
 	MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
 	MGMT_OP_ADD_PERIODIC_ADV_DATA,
+	MGMT_OP_SET_PA_SUBEVENT_DATA,
 };
 
 static const u16 mgmt_events[] = {
@@ -180,6 +181,8 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
 	MGMT_EV_ADV_MONITOR_DEVICE_LOST,
 	MGMT_EV_SECURITY_LEVEL_CHANGED,
+	MGMT_EV_PA_SUBEVENT_DATA_REQUEST,
+	MGMT_EV_PA_RESPONSE_REPORT,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -10014,6 +10017,122 @@ static int add_periodic_adv_data(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+/* The controller's answer to LE Set Periodic Advertising Subevent Data. The
+ * commands are answered in the order they were sent.
+ */
+void mgmt_set_pa_subevent_data_complete(struct hci_dev *hdev, u8 status)
+{
+	struct mgmt_cp_set_pa_subevent_data *cp;
+	struct mgmt_rp_set_pa_subevent_data rp;
+	struct mgmt_pending_cmd *cmd;
+
+	cmd = pending_find(MGMT_OP_SET_PA_SUBEVENT_DATA, hdev);
+	if (!cmd)
+		return;
+
+	cp = cmd->param;
+
+	if (status) {
+		mgmt_cmd_status(cmd->sk, hdev->id, cmd->opcode,
+				mgmt_status(status));
+	} else {
+		rp.instance = cp->instance;
+		mgmt_cmd_complete(cmd->sk, hdev->id, cmd->opcode,
+				  MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+	}
+
+	mgmt_pending_remove(cmd);
+}
+
+static int set_pa_subevent_data(struct sock *sk, struct hci_dev *hdev,
+				void *data, u16 data_len)
+{
+	DEFINE_RAW_FLEX(struct hci_cp_le_set_per_adv_subevent_data, hci_cp,
+			subevents, HCI_MAX_PER_ADV_SUBEVENT_DATA_LEN);
+	struct mgmt_cp_set_pa_subevent_data *cp = data;
+	struct mgmt_pa_subevent_data *subevent;
+	struct mgmt_pending_cmd *cmd;
+	struct adv_info *adv;
+	u16 len = data_len - sizeof(*cp);
+	u16 left = len;
+	u8 *ptr = cp->subevents;
+	int err;
+	u8 i;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	BUILD_BUG_ON(sizeof(struct mgmt_pa_subevent_data) !=
+		     sizeof(struct hci_le_per_adv_subevent_data));
+
+	/* One HCI command takes it all, or nothing is sent */
+	if (left > HCI_MAX_PER_ADV_SUBEVENT_DATA_LEN)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_PA_SUBEVENT_DATA,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	for (i = 0; i < cp->num_subevents; i++) {
+		subevent = (void *)ptr;
+
+		if (left < sizeof(*subevent) ||
+		    left < sizeof(*subevent) + subevent->data_len)
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_PA_SUBEVENT_DATA,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		ptr += sizeof(*subevent) + subevent->data_len;
+		left -= sizeof(*subevent) + subevent->data_len;
+	}
+
+	if (!cp->num_subevents || left)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_PA_SUBEVENT_DATA,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_PA_SUBEVENT_DATA,
+				      MGMT_STATUS_REJECTED);
+		goto unlock;
+	}
+
+	adv = hci_find_adv_instance(hdev, cp->instance);
+	if (!adv || !adv->periodic || !adv->num_subevents) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_PA_SUBEVENT_DATA,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_PA_SUBEVENT_DATA, hdev, data,
+			       data_len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	/* struct mgmt_pa_subevent_data has the layout of the HCI one */
+	hci_cp->handle = adv->handle;
+	hci_cp->num_subevents = cp->num_subevents;
+	memcpy(hci_cp->subevents, cp->subevents, len);
+
+	/* The controller wants the data within its lead time, a few tens of
+	 * milliseconds. The command is therefore not queued with
+	 * hci_cmd_sync_queue(): it would wait behind sequences which block
+	 * for an event, such as creating a connection.
+	 */
+	err = hci_send_cmd(hdev, HCI_OP_LE_SET_PER_ADV_SUBEVENT_DATA,
+			   struct_size(hci_cp, subevents, len), hci_cp);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static void remove_advertising_complete(struct hci_dev *hdev, void *data,
 					int err)
 {
@@ -10278,6 +10397,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ add_periodic_adv_params, MGMT_ADD_PERIODIC_ADV_PARAMS_SIZE },
 	{ add_periodic_adv_data,   MGMT_ADD_PERIODIC_ADV_DATA_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ set_pa_subevent_data,    MGMT_SET_PA_SUBEVENT_DATA_SIZE,
+						HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
@@ -11131,6 +11252,47 @@ void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 		   NULL);
 }
 
+void mgmt_pa_subevent_data_request(struct hci_dev *hdev, u8 instance,
+				   u8 subevent_start, u8 subevent_data_count)
+{
+	struct mgmt_ev_pa_subevent_data_request ev;
+
+	ev.instance = instance;
+	ev.subevent_start = subevent_start;
+	ev.subevent_data_count = subevent_data_count;
+
+	mgmt_event(MGMT_EV_PA_SUBEVENT_DATA_REQUEST, hdev, &ev, sizeof(ev),
+		   NULL);
+}
+
+/* responses: num_responses entries of struct hci_le_per_adv_response, which
+ * has the layout of struct mgmt_pa_response, len octets in total.
+ */
+void mgmt_pa_response_report(struct hci_dev *hdev, u8 instance, u8 subevent,
+			     u8 tx_status, u8 num_responses,
+			     const void *responses, u16 len)
+{
+	struct mgmt_ev_pa_response_report *ev;
+	struct sk_buff *skb;
+
+	BUILD_BUG_ON(sizeof(struct mgmt_pa_response) !=
+		     sizeof(struct hci_le_per_adv_response));
+
+	skb = mgmt_alloc_skb(hdev, MGMT_EV_PA_RESPONSE_REPORT,
+			     sizeof(*ev) + len);
+	if (!skb)
+		return;
+
+	ev = skb_put(skb, sizeof(*ev));
+	ev->instance = instance;
+	ev->subevent = subevent;
+	ev->tx_status = tx_status;
+	ev->num_responses = num_responses;
+	skb_put_data(skb, responses, len);
+
+	mgmt_event_skb(skb, NULL);
+}
+
 static void mgmt_send_adv_monitor_device_found(struct hci_dev *hdev,
 					       struct sk_buff *skb,
 					       struct sock *skip_sk,
-- 
2.47.3


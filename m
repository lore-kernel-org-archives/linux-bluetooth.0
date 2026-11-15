Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794737955;
	b=T6zvV8zCd6j/+y7QNE+kr1H8Ttfqsj7ZFVgULDDeAHGJU/Fp3tOljwSIqUpBEadRUqg1
	 2j3dXvCedAzf1oL3BeTn2323qc0xqDDQengGq3ti5HjHjLPeV5eWGrv/nsxc4Vg6aA2TB
	 ueiJft1Evndk5h6Q00IOiWq2WqTr5ukDP3xJGJhukgxBLaAgTzes/OVZG7+Th5A3Lm8w3
	 AAMaWKD6fINJjzDn5Mi2Dw0lIucpsJjDcRkiyngXuSWqNtLA4miKOJNcldZAW/tjap6CQ
	 g+Sf5DQTI9sEckNGQ/ehHgTIGK7lXAs8iUow160JHhcSBj3GLvjaqdnbExh+z5kOCCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794737955;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3r55KL7eBrHrbeDPiMXmVW2NaDcym3nxHa/NS9skFpg=;
	b=qz5UPAC1YCeZWeT9H2Uq2H1aArCrqCYZ7snzraPasVWRvueayp5y4PpGW9K5fuye7wrs
	 /SooWKbiH/4+bZ+zFUeaZFRtf4R9UkTVReDHajuwtj02xNz9Y/UZkWMohLJDYa4n4zKvA
	 dQaR2nxYQZPfbHfK/fO/Vs/Niv1IP1f7WQv2qgpTQhUkujHepXDCL2Q1MckuZ55c6T3tu
	 R83VP4bpnYiU0y5NMYnBZg/8wp6PmSQN+7yFTCP/namL4w+wbnNXnF8BDIkWzFRd+YcK/
	 t1Z9tK8sSMyq3yD6tgw4kABhsvODjyLJIeVz4T4xLswDsU91TAG2OHcDHUlaoroMjNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VArkl0tp;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC0606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 10:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFEC0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VArkl0tp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794737953;
	bh=gI/18Kv02kh2bTJkvK2HmZaN/ANQQlR34RO+qssJSzU=;
	h=From:To:Subject:Date:From;
	b=VArkl0tpF4hgtHxs51Kpi9chIR99WkN3IDt5GNAFtwW8+nj4xyu7ih9fTmQxgEWDU
	 esxFR5+XVPpfNl24tgrLvv1Srg7wr5KCBD2wWwJSiu2SrrGqtcow9Q1WBNclhZbHxC
	 QJ453G8XkPedb4UrSqfuoS77CcNpskJuRywMm+boyMbLCClFeBQ+S+USee3HnGzrkM
	 wtnM8dbOCw0qzq1w4bHY3I2m2DnuaPK1tgGs0bz2+2Vem1CoqCvMscQ4y9A/ozctH1
	 3QLz2StnW2XPR4BTdIaysv9wrB7pPTI7mc7iVv8iM+o0fZDfAdXHKKh/1rplbkuqbI
	 TFCsogkY2BSMA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD06217E04B4
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 11:19:12 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/hfp-hf: Fix org.bluez.Telephony1.Dial reply message
Date: Sun, 15 Nov 2026 11:19:07 +0100
Message-ID: <20261115101907.68963-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

An org.bluez.Call1 object is expected to be returned on
org.bluez.Telephony1.Dial() success.
---
 profiles/audio/hfp-hf.c | 51 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 4e626653d..bc6d7229f 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -90,6 +90,7 @@ struct hfp_device {
 	uint8_t			codec;
 	unsigned int		resume_id;
 	struct connect_data	*pending_connect;
+	DBusMessage		*dial_msg;
 	hfp_hf_sco_closed_cb	sco_closed_cb;
 	void			*sco_closed_data;
 };
@@ -192,6 +193,29 @@ static void sco_connect_complete(struct connect_data *connect_data, int status)
 	g_free(connect_data);
 }
 
+static void dial_complete(enum hfp_result res, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	if (dev->dial_msg == NULL)
+		return;
+
+	if (res != HFP_RESULT_OK) {
+		DBusMessage *reply;
+		const char *name = dbus_message_get_member(dev->dial_msg);
+
+		error("Command %s error: %d", name, res);
+		reply = g_dbus_create_error(dev->dial_msg, ERROR_INTERFACE
+					".Failed",
+					"Command %s failed: %d", name, res);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+		dbus_message_unref(dev->dial_msg);
+		dev->dial_msg = NULL;
+		return;
+	}
+}
+
 static void device_destroy(struct hfp_device *dev)
 {
 	struct hfp_server *server;
@@ -200,6 +224,10 @@ static void device_destroy(struct hfp_device *dev)
 
 	telephony_set_state(dev->telephony, DISCONNECTING);
 
+	if (dev->dial_msg)
+		dial_complete(HFP_RESULT_ERROR,
+				HFP_ERROR_NO_CONNECTION_TO_PHONE, dev);
+
 	if (dev->pending_connect)
 		sco_connect_complete(dev->pending_connect, -ENOTCONN);
 
@@ -288,10 +316,23 @@ static void hfp_hf_call_added(uint id, enum hfp_call_status status,
 		call->multiparty = mpty;
 	if (telephony_call_register_interface(call)) {
 		telephony_free_call(call);
+		if (status == CALL_STATUS_DIALING ||
+				status == CALL_STATUS_ALERTING)
+			dial_complete(HFP_RESULT_ERROR, HFP_ERROR_MEMORY_FULL,
+									dev);
 		return;
 	}
 
 	queue_push_tail(dev->calls, call);
+
+	if ((status == CALL_STATUS_DIALING || status == CALL_STATUS_ALERTING)
+			&& dev->dial_msg) {
+		g_dbus_send_reply(btd_get_dbus_connection(), dev->dial_msg,
+					DBUS_TYPE_OBJECT_PATH, &call->path,
+					DBUS_TYPE_INVALID);
+		dbus_message_unref(dev->dial_msg);
+		dev->dial_msg = NULL;
+	}
 }
 
 static void hfp_hf_call_removed(uint id, void *user_data)
@@ -566,10 +607,14 @@ static DBusMessage *dial(DBusConnection *conn, DBusMessage *msg,
 	if (strncmp(number, URI_PREFIX, strlen(URI_PREFIX)) != 0)
 		return btd_error_invalid_args(msg);
 
-	ret = hfp_hf_dial(dev->hf, number + strlen(URI_PREFIX), cmd_complete,
-					dbus_message_ref(msg));
-	if (!ret)
+	dev->dial_msg = dbus_message_ref(msg);
+	ret = hfp_hf_dial(dev->hf, number + strlen(URI_PREFIX), dial_complete,
+									dev);
+	if (!ret) {
+		dbus_message_unref(dev->dial_msg);
+		dev->dial_msg = NULL;
 		return btd_error_failed(msg, "Dial command failed");
+	}
 
 	return NULL;
 }
-- 
2.43.0


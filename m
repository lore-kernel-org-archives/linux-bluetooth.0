Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553472;
	b=xuRk8DQiiPUztY9g2NIEqrEmR25qigkQiq78WbfCSm6IWYvEA06+ODUVvhZkdgRT2XcX
	 +rZJwufHuNlHp8oiknlDJC+me5xMDHnyaMgOvefxQqlQF9onjA33VSiFfo0jF5OkoInN+
	 v0byEsydZazlcPxh8evQUc9nWIOnKicP3SpMWuuyrXC1i0aZuz6sjNjRj8kTpUjPCnhLY
	 eZ2z2eNMzy+0VM56jG2za2lKH41mBviTv51HWSvzusymQK0VA4IW0PjryKrhq+PIwxiJm
	 /KRx4PbW/MiQj7/9U+kbEm52FOgOa/1rW5lnZvEXvQPy5URcDiYmtFNGJw+BntnJWOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y/lT1QMwfD/p55bxm9COt6HPjh2mAtJlm27/jufBbKg=;
	b=17i3ONPkCCMIoBqP7CFz12jrE5GNSYknek5TCBUC2dr2W9TCeInSZx+ahDTM80EGVfgA
	 /xDCApVyd56N/n50tR15uB1T6enzD97TfcG65voAjhnjQpcL9Kae59qx+4p0JSsbj33Tr
	 MBCfiQYLKrh9c9XMXU9NELbeMzcng+kWqaQ2M0xfSH6rmHt7bn/JB2i9at50lMtUPUjnX
	 d9+5/Pz/0zcOosH5XvhpIkME3/iBvpNAbuVKqkDFeKwvVlaXuOGslaZ4EIuHrDH0jODIi
	 3Q26a+FpDk9bR66E4X79mBqXW7KsTrokSL67gGon6DhXgmXLOaO8ZPHsIzuxxgIMBZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hMgqJxr/";
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079D606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5079D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hMgqJxr/
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5ee3e658c70so1545699e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553471; x=1796158271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y/lT1QMwfD/p55bxm9COt6HPjh2mAtJlm27/jufBbKg=;
        b=hMgqJxr/IMw08IAAYEJ9HGui25bJc4a/YfIERP4s+BLuXlux5t+z08W3LscP/UL9xr
         3Fft7N1ml1xG7wxh7gjHABeoSxwYdx2f8il4+NuaddlpJOqYa+V1FOPkapCCdUksuJl5
         gvhSvsUMbBhcXx3BkJB65/R7QZV3r4c3EY/Lc8+0pPbzyupLzKB8DiLaBn0C6EJa7/1c
         hVW45DWlsryymS9nBtl4XI6XOerjT+PReMeRhRhBRvXa5ZXdRn7xQRvpteGPGmkOVmie
         ZBBB004DFaoO8tIj+bxIsR8XmfkaPOmQFdoxnKBgPBkVstigTKPh+hHvlHNLafqmHWTI
         U0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553471; x=1796158271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y/lT1QMwfD/p55bxm9COt6HPjh2mAtJlm27/jufBbKg=;
        b=wCj1Rdg3uV69DH8MUtSdsgkJ/fyrW6YKf5UmNdyZ4NOv4PELsalmFwmR9RktUhy2e6
         +onK5vxLblPkJuKFTpJ9XrAjELcj811yVA+qyY/Uoez1J0F+17V4A14Ia20ogFWnPKGF
         dStsn9awCagBgnhsrc3yZyW25yVqof63BpRxei6euAjnE3CE+i1hE3lPp8J+ZWVk9ULe
         AIF1KQjkc+yeAyfHCltrJUElCalU8asY8OXFuBXYCA0j7al9MTpxQMGmk5iVTr1hi8qW
         fP+XSewdVyRG3twLbF2onxz1yY5i1TX6kAcRsnP9mDcF4LKoQTIV0U0+ESOzZ7KeiwI5
         MZvQ==
X-Gm-Message-State: APuU4Z9J+m4XjSXcX11hptJpqcAZ81k+FOJ7u7rHCt3HgImG/nY4isxi
	wh9LFxinNlC3rhVnrIt2kIlYYFS8+jU/JmG3Hl/H+TBCavPVY45/EHk+UyKzEA==
X-Gm-Gg: AZFdTZd1a14xcLvhPLSDppfVFtPkdGRYzx+MIvS0ZGnQibbkcfVMp15hb+BvxJYgHg0
	wCFPhuv04fewcSWEmop60pzoOvG37l+EfFsrnl51L7kDN7zJkVClGUN8LCDefMg+RdWcnMy23N2
	sFF9naBGPHIKa/JW4ck4DeTiDyTgR3cY1MKt/9cnvtW11WDoXCLlatBoFczHMGblkUANWuvDlMD
	sy6y+ov2mDEO8yXB3gmavijvJGzAp8wR+DvbogYjMCx+AKjvx6+0zxS0p4i2GPLooISuobU7yQy
	QKBlyeT9ty55sYA/Gz+lKwqw2X71VDNjDv0rHNlTOL8UU8pDsUCqzdyh8GZ4DYhZyueIngLWfVj
	xqbAs09hAjwIOVUHjB3yyS6PsupvjC18+ZgD5938ukHT7hqJwFSF/+nLGGPxlOVbRgESWS84gnR
	nBGHWrFbM4CYv8DxCnJAYIAsYOozBQWzqn3ixkJZttCtrvptEqJRXsdd4NOO5BDaeKeQGDoSIQv
	nDGA7njGNqQFeyPhF2EvkGxJjlRnHdcOy7tM26aoG3u/HsG+qDssTLTriU4vNd5mXoVT3MerO+N
	K9wLxx1WXJmTz+17Ad5+3N0ufDFo6R7Ye6kU4EeVPq7S3XQAbFe9gsBWb8CNsX5FU9lNOGlD920
	lNlcXc5W4aJsGrwk+digQrE4QFu9B9glC0F/SUaSBPXc7TygpnK02gFnDEpHLjOcuw9aYLkmMdt
	on3ts=
X-Received: by 2002:a05:6122:288a:b0:5c9:c60e:3a40 with SMTP id 71dfb90a1353d-5ee8af56a83mr10278525e0c.18.1795553470791;
        Tue, 24 Nov 2026 12:51:10 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee91a4e0cfsm13929876e0c.13.2026.11.24.12.51.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:51:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/5] rfcomm-tester: Add tests for deferred setup
Date: Tue, 24 Nov 2026 15:51:01 -0500
Message-ID: <20261124205102.737384-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124205102.737384-1-luiz.dentz@gmail.com>
References: <20261124205102.737384-1-luiz.dentz@gmail.com>
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

Add the following tests:

Basic RFCOMM Socket Server - Defer Success
Basic RFCOMM Socket Server - Defer Early Accept

Defer Early Accept has the listener accepting and authorizing the
connection while authentication, which then fails, is still pending and
expects the connection to be refused.

Assisted-by: OpenCode:claude-fable-5.2
---
 tools/rfcomm-tester.c | 146 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 998d698c1bb2..ae4f3c7ee7ac 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -43,6 +43,7 @@ struct test_data {
 	struct tester_io *io;
 	unsigned int io_id;
 	uint16_t conn_handle;
+	int listen_sk;
 	uint16_t send_len;
 	uint16_t recv_len;
 };
@@ -61,6 +62,12 @@ struct rfcomm_server_data {
 	uint8_t server_channel;
 	uint8_t client_channel;
 	bool expected_status;
+	bool defer;
+	int sec_level;
+	const uint8_t *pin;
+	uint8_t pin_len;
+	const uint8_t *client_pin;
+	uint8_t client_pin_len;
 	const uint8_t *send_data;
 	const uint8_t *read_data;
 	uint16_t data_len;
@@ -286,13 +293,81 @@ static void setup_powered_server_callback(uint8_t status, uint16_t length,
 	tester_setup_complete();
 }
 
+/* Authorize a deferred connection, the socket is kept open in data->io */
+static void defer_authorize(struct test_data *data, int sk)
+{
+	ssize_t ret;
+	char c;
+
+	ret = recv(sk, &c, 1, MSG_DONTWAIT);
+
+	tester_print("Authorize deferred setup sk = %d: %zd (%s)", sk, ret,
+					ret < 0 ? strerror(errno) : "ok");
+
+	if (data->io)
+		tester_io_unref(data->io);
+
+	data->io = tester_io_new(sk);
+	tester_io_set_close_on_unref(data->io, true);
+}
+
+static void pin_code_request_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_pin_code_request *ev = param;
+	struct test_data *data = user_data;
+	const struct rfcomm_server_data *srv = data->test_data;
+	struct mgmt_cp_pin_code_reply cp;
+
+	/* Behave like a listener that does not wait to be notified: accept
+	 * and authorize whatever is queued while authentication is pending.
+	 */
+	if (srv->defer) {
+		int new_sk;
+
+		new_sk = accept(data->listen_sk, NULL, NULL);
+		if (new_sk < 0) {
+			tester_print("Nothing to accept while authentication "
+					"is pending: %s (%d)", strerror(errno),
+					errno);
+		} else {
+			tester_print("Accepted sk = %d while authentication "
+					"is pending", new_sk);
+			defer_authorize(data, new_sk);
+		}
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.addr, &ev->addr, sizeof(cp.addr));
+	cp.pin_len = srv->pin_len;
+	memcpy(cp.pin_code, srv->pin, srv->pin_len);
+
+	mgmt_reply(data->mgmt, MGMT_OP_PIN_CODE_REPLY, data->mgmt_index,
+					sizeof(cp), &cp, NULL, NULL, NULL);
+}
+
 static void setup_powered_server(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct rfcomm_server_data *srv = test_data;
 	unsigned char param[] = { 0x01 };
 
 	tester_print("Powering on controller");
 
+	if (srv && srv->pin) {
+		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+		mgmt_register(data->mgmt, MGMT_EV_PIN_CODE_REQUEST,
+				data->mgmt_index, pin_code_request_callback,
+				data, NULL);
+
+		bthost_set_pin_code(bthost, srv->client_pin,
+							srv->client_pin_len);
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_BONDABLE, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+	}
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 				sizeof(param), param,
 				NULL, NULL, NULL);
@@ -374,6 +449,33 @@ const struct rfcomm_server_data listen_read_success = {
 	.read_data = data
 };
 
+const struct rfcomm_server_data listen_defer_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.expected_status = true,
+	.defer = true,
+};
+
+static const uint8_t pair_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
+/* "1111" */
+static const uint8_t pair_wrong_pin[] = { 0x31, 0x31, 0x31, 0x31 };
+
+/* The listener accepts and authorizes the connection while authentication is
+ * still pending and then authentication fails, the connection shall be
+ * refused.
+ */
+const struct rfcomm_server_data listen_defer_early_accept = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.expected_status = false,
+	.defer = true,
+	.sec_level = BT_SECURITY_MEDIUM,
+	.pin = pair_pin,
+	.pin_len = sizeof(pair_pin),
+	.client_pin = pair_wrong_pin,
+	.client_pin_len = sizeof(pair_wrong_pin),
+};
+
 const struct rfcomm_server_data listen_nval = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0e,
@@ -721,6 +823,13 @@ static bool rfcomm_listen_cb(struct tester_io *io, uint32_t cond,
 		return false;
 	}
 
+	/* The result is checked once the client connection completes */
+	if (srv->defer) {
+		tester_print("Accept deferred setup sk = %d", new_sk);
+		defer_authorize(data, new_sk);
+		return false;
+	}
+
 	if (srv->send_data) {
 		ssize_t ret;
 
@@ -803,6 +912,37 @@ static void test_server(const void *test_data)
 		return;
 	}
 
+	if (srv->sec_level) {
+		struct bt_security sec;
+
+		memset(&sec, 0, sizeof(sec));
+		sec.level = srv->sec_level;
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) < 0) {
+			tester_warn("Can't set security level: %s (%d)",
+						strerror(errno), errno);
+			tester_test_failed();
+			close(sk);
+			return;
+		}
+	}
+
+	if (srv->defer) {
+		int opt = 1;
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &opt,
+							sizeof(opt)) < 0) {
+			tester_warn("Can't enable deferred setup: %s (%d)",
+						strerror(errno), errno);
+			tester_test_failed();
+			close(sk);
+			return;
+		}
+	}
+
+	data->listen_sk = sk;
+
 	if (listen(sk, 5) < 0) {
 		tester_warn("listening on socket failed: %s (%u)",
 				strerror(errno), errno);
@@ -868,6 +1008,12 @@ int main(int argc, char *argv[])
 	test_rfcomm("Basic RFCOMM Socket Server - Read Success",
 				&listen_read_success, setup_powered_server,
 				test_server);
+	test_rfcomm("Basic RFCOMM Socket Server - Defer Success",
+				&listen_defer_success, setup_powered_server,
+				test_server);
+	test_rfcomm("Basic RFCOMM Socket Server - Defer Early Accept",
+				&listen_defer_early_accept,
+				setup_powered_server, test_server);
 	test_rfcomm("Basic RFCOMM Socket Server - Conn Refused", &listen_nval,
 					setup_powered_server, test_server);
 
-- 
2.56.0


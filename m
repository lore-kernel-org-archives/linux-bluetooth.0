Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D542048E
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496691; cv=none; b=RgXXpo8uNF9Hhyh3IYdPG0wAyprfUJX75d0st7b9Cy/NDPZdbt870IelV4EndU2eJ+MbM7ZhahTS7f4plUs8LsALT7YUZOcR25hX1j8Iyn4/GsdV6i07MzQngKIa1cimQVvXZS5NB0Ck+7PBw05YwjKh67zrkNV+kKkHguHeoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496691; c=relaxed/simple;
	bh=2fK1rwc3mxM1F71yRZM9r+DJ+ut5nJRWOvFM1/DD29I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1TlPVG8MwpCqSqn6PUdLWhqesCpXriSi7IIYfR4uE9qfuHuxez772n5slgnl3IHeTdziewfCAguATKHl9IslUy6svcG6YQU/gwItaHiOf7e3tA6UpUhbFl83nR5EPJu+zp7AyRAUrJFsqa0im7EemR6iJEkXtFNDNLk3aMQJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m26GDJaI; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m26GDJaI"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535daddac2so43866eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791496689; x=1792101489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5easX86UEMU2ko0SxNhGfRuqkSdDtSYWehjtrSK1i7M=;
        b=m26GDJaID21Tio7B/6X7ExNXrtZO9pvaoORTTtvpMrTCkMBgFmlKN3g/kLcKUrJFct
         UMmjMnwlarGd4XsLiQDnrCBVWgjjb9KOZ4rKuXDB0C6RZdH4ckRe4dxPBsCQfl3Peqjr
         jAYijpKRxMdhJhcBPc/h8c90dj8iMazvRRuFHUpFcavAPDFVuakJdmn+vTWfInxTkJ1D
         56NS6Z1ISDBY7GLBRdDArquawCcUuKxikFYEB+VjefcyX/8frV+GH4DUYUfSmmkuCMq5
         UuFT+kz3SE7aKGocyZbUitzV2B968nxyC7aJlFC1WKkU3v0JryG/6Kmn662k77dmHjgP
         GX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791496689; x=1792101489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5easX86UEMU2ko0SxNhGfRuqkSdDtSYWehjtrSK1i7M=;
        b=XauQPiodKcJcJcItRtH3tU8ZgpfuUeQlVw4F3BPv+V/cgmykQmiiDXjsE4TjXqu7se
         wV2+vmXna527g5ggxejJDx0Y1N9He5z7L3cjiDBxUk6v8w0EsAJvFAhxdLL9DMjKMaYS
         AcB+hHU9lQHFdXSQ8rk7O2RQHMSm1j6vIXbkpHObIn0+wUup5EvoIx45q+GW+nzAMrkO
         kUm2JRR3a1/iofTwbXVWRb3+GoDL8L+9ANZxdmtU4qF/OXIBhrrPGe3O3md4r815MRS4
         xNhgD+uWP6F901uB0FfoFN/nodbnG+1S0pZEKVYx/qUmVVvhTdENKno18RbmtJy2YiY2
         T3Cw==
X-Gm-Message-State: AFuF++kh72Czozl2yrdnhwLwpERHtL6LbiKuvoDg0rJaXx6YMokGCrRj
	XZVtr4mNG/OvaU96n0bs6yW1s1SODAQ7KhX6frxnaztGZfpuKLEPMRx1Dyrp6046fHQ=
X-Gm-Gg: AYBFou1+G5b47DjWX6NUxDtxMFQUBo5v4da044bkEv4h83iSRQYILV3f2e4MsbRO2yw
	a0Yslll7jvqLeY9iXN4fNYQZ4jAsg/Jc1s25GiI59S+5CvcdmjAzozgUHJencD/XW1W8Lk4cqjk
	267NWfLtP2u+8zasL+9a9p7nEKwUhtUNz12FtQOKsac1SUykEBtd8RAJGFOw98VPvcFdyNhZ5Jm
	Bi3xp6Q/nZYOdXHOZhcAzFU4bTfwY6fFmFZefXQpMdIKBQCQE6e6Hh7D14bYlNEvkjBHUl2hHTc
	Yp1LjeoW9FBOObsSKxbMzEbB+xmLWgI/r8ZSJbYm9XOKuriiHhWHW5qFi0XaqqecRqxghMIj1a8
	FmPoguwj/liSrIFwgEVcOrhQhh+1/0ek4aFOEzBsNecfdT3gEuIQv52fVhnZj8KfQZWLpFQUTy6
	4xkJINGqRYGeE/KLpHafX9eG6iwOR7+CrIzcL5VdzYaPIoLBiCgKJIf2IB0n0tLApfEBiI5CJuP
	m+F7kcH3AdzaWBYgiTsYQIFXDrAstJViDH9ikcF
X-Received: by 2002:a05:7022:7f06:b0:14c:cc55:aba1 with SMTP id a92af1059eb24-165893e6b89mr6520969c88.1.1791496688789;
        Thu, 08 Oct 2026 14:58:08 -0700 (PDT)
Received: from hitalo (208-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1dd5cb5sm899823c88.6.2026.10.08.14.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:58:08 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH BlueZ 2/2] tools/l2cap-tester: Add tests closing the socket before the link is up
Date: Thu,  8 Oct 2026 17:57:56 -0400
Message-ID: <20261008215756.2710812-3-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008215756.2710812-1-enghitalo@gmail.com>
References: <20261008215756.2710812-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BR/EDR and LE client tests that close the socket while the emulator
holds the Connection Complete or LE Connection Complete event, so that
the kernel aborts the connection before the link comes up. No
connection takes the link then, so the tests expect the kernel to
disconnect it instead of leaving it up in the controller.

L2CAP BR/EDR Client - Close Before Complete
L2CAP LE Client - Close Before Complete

Assisted-by: Claude:claude-opus-5-5
---
 tools/l2cap-tester.c | 107 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index f2d3e56..41e6721 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -2571,6 +2571,105 @@ static void test_connect_timeout(const void *test_data)
 	g_io_channel_unref(io);
 }
 
+static bool close_before_complete(uint8_t status, uint16_t handle)
+{
+	struct test_data *data = tester_get_data();
+
+	if (status || data->sk < 0) {
+		tester_warn("Unexpected connection complete");
+		tester_test_failed();
+		return true;
+	}
+
+	data->handle = handle;
+	tester_print("Closing socket before handle 0x%04x is up", handle);
+
+	/* Abort the connection while its link is coming up, and let the
+	 * kernel process it before the event is sent.
+	 */
+	close(data->sk);
+	data->sk = -1;
+	g_usleep(500000);
+
+	return true;
+}
+
+static bool hook_close_conn_complete(const void *msg, uint16_t len,
+							void *user_data)
+{
+	const struct bt_hci_evt_conn_complete *ev = msg;
+
+	if (len < sizeof(*ev))
+		return true;
+
+	return close_before_complete(ev->status, le16_to_cpu(ev->handle));
+}
+
+static bool hook_close_le_conn_complete(const void *msg, uint16_t len,
+							void *user_data)
+{
+	const uint8_t *subevent = msg;
+	const struct bt_hci_evt_le_conn_complete *ev = msg + 1;
+
+	if (len < 1 + sizeof(*ev) || *subevent != BT_HCI_EVT_LE_CONN_COMPLETE)
+		return true;
+
+	return close_before_complete(ev->status, le16_to_cpu(ev->handle));
+}
+
+static void close_complete_disconnect(uint16_t opcode, const void *param,
+					uint8_t len, void *user_data)
+{
+	const struct bt_hci_cmd_disconnect *cmd = param;
+	struct test_data *data = user_data;
+
+	if (opcode != BT_HCI_CMD_DISCONNECT || len < sizeof(*cmd))
+		return;
+
+	tester_print("Disconnect handle 0x%04x", le16_to_cpu(cmd->handle));
+
+	/* The link shall be disconnected, as no connection takes it */
+	if (le16_to_cpu(cmd->handle) == data->handle)
+		tester_test_passed();
+}
+
+static void test_connect_close_complete(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	int sk;
+
+	if (data->hciemu_type == HCIEMU_TYPE_LE)
+		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_LE_META_EVENT,
+					hook_close_le_conn_complete, NULL);
+	else
+		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_CONN_COMPLETE,
+					hook_close_conn_complete, NULL);
+
+	hciemu_add_central_post_command_hook(data->hciemu,
+					close_complete_disconnect, data);
+
+	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
+							l2data->mode);
+	if (sk < 0) {
+		tester_test_failed();
+		return;
+	}
+
+	if (connect_l2cap_sock(data, sk, l2data->client_psm,
+							l2data->cid) < 0) {
+		close(sk);
+		tester_test_failed();
+		return;
+	}
+
+	data->sk = sk;
+
+	tester_print("Connect in progress");
+}
+
 static void test_connect_reject(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3526,6 +3625,10 @@ int main(int argc, char *argv[])
 					&client_connect_timeout_test,
 					setup_powered_client,
 					test_connect_timeout);
+	test_l2cap_bredr("L2CAP BR/EDR Client - Close Before Complete",
+					&client_connect_close_test,
+					setup_powered_client,
+					test_connect_close_complete);
 
 	test_l2cap_bredr("L2CAP BR/EDR Client SSP - Success 1",
 					&client_connect_ssp_success_test_1,
@@ -3689,6 +3792,10 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE Client - Timeout",
 				&le_client_connect_timeout_test_1,
 				setup_powered_client, test_connect_timeout);
+	test_l2cap_le("L2CAP LE Client - Close Before Complete",
+				&le_client_connect_close_test_1,
+				setup_powered_client,
+				test_connect_close_complete);
 	test_l2cap_le("L2CAP LE Client - Read Success",
 				&le_client_connect_read_success_test,
 				setup_powered_client, test_connect);
-- 
2.55.0


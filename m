Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7391922DD
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745753187; cv=pass; b=OCXSHoL8NJcdNiaoPjLCgAdpc5ZH1EzYCMXt9TqV1LqInI9UooFQkEpJBOL6nYA1NV3rbs+y8VDADekZn224A2OM/v2SuXtphq+O+MEzi7IzgZNZgBmmlfPZ+/Rar5GZvRgajyLe6kSlzR7uHbIbnVdAEOHDxJZq0/g+U/VEfQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745753187; c=relaxed/simple;
	bh=2fjpN3b57qpKwDcsC6fUvK/csSh1Nn7ZbhBuZyngqkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQWVFyENyLVeA6fK352HKOD7zLD3gYIPqbiidUMVx1andJ6ut7wIPx99XfXEmjvEVNtdbOPr5l+d0qrNvWauBsAYawi0PQWCutWii8p4Dvyyx0glCE5EVcF6R9c8HOkaWB0ZlD0FiH+lNP/+5DrXptAuU/Nj9cahfq7uKAVd6zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=NJE0T7xj; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="NJE0T7xj"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZlkmV3DzDz49QJY;
	Sun, 27 Apr 2025 14:26:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745753179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D7VEvfwd9SkCW4X254zV5EomqMMv4elWHppQfX3RfJc=;
	b=NJE0T7xjvJeWu/cKYWeC8v7NUbiRYKZund3fNzRWmgKj/hZPHt+9foVf41sgiK6HjJAl8U
	hw1hR67jIrNMmBwSug315hPiaXSkwdYoJtuLaFgm0TO7nI/aXbybPk+Fw3yBmixZDnySQo
	rh960ExALfNhLGv1kXnbjQsvT1uUt1O2KSm5dmXVR/SoHFxU1TQKJu6yTszzLu/KnMPaZr
	TZD0Lal0Z2/U8DKbgp97u1jYFAYb5W7WtwJVJdkxwIWwzJxkA19VtHLbmL9paoOm2J+KUa
	uugPGfW8LZw1xqiiDUuqUPvwMdRTLuPv/xB/7ampIsdjl7XHb1iKfgueqqqi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745753178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D7VEvfwd9SkCW4X254zV5EomqMMv4elWHppQfX3RfJc=;
	b=gd09/lVmx5kpP+AYYDSTqxPuzDav2BPWXikWxEYqCzX8VnZFSIZ3m9JPJccW0ROSwKFY47
	5xiex+tV0ee7CFnPPhK+moPNaKVMacgw62gZMQh6xB1F0mT31VUjdvWUZ+Zcw43ijuXUnA
	o9DTRL9JbsOhtMteNL+W58A5g0SYeZh8Hm1KeT6poEcYOtXRDwcUIhPYIL4lU9LTq1i7Tx
	kFwBK8MvB4SfVnt9L+Haa9tSZySCHCIbuy5nxHbB7oKeMVI9uAm+aqMsUcc23rKB7xdJc2
	BpPMCaj61TDIkvs49Wy7hr2Mm32hiJhWKyMaYWK0iLB+opHe0VZekkUqypRHvQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745753179; a=rsa-sha256;
	cv=none;
	b=KRX68jaPAK7dmT+vbOjlyuhPhuI2doV8PJbS/sObchuQ/uhZtkyrtrW0zOY3i1JJiXaLec
	aI/xaryHtKX9vBMNxG1WVvWT2HKPM8Eyy7gDIeUkK9hArhgk0c18TpcpIWMnNNX5tmoX6o
	GMxWZwDobdQZi6gvybecOeeA0+b3/0YAZ0WHUqhuqVFGvfFsSabrzq3kWEikAN9kjaw9Ya
	FB+0Ei3licpzcTYok8wBfAUYomc7oeIH2ZuZ8j7UiZqj1RbHe4ETJJ91ONu+KFSp/VWeIT
	lSQUyKnztLK6iosMm8MxL5oPIGaJb9BSoqRjFasE35Odx6M9E5nawYSHYBKZzw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] tools: add tests for SIOCETHTOOL ETHTOOL_GET_TS_INFO
Date: Sun, 27 Apr 2025 14:26:15 +0300
Message-ID: <fb7b09305a729369d1755569d4e7bdda48d94327.1745751513.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for obtaining timestamping capabilities via ethtool ioctl:

L2CAP BR/EDR Ethtool Get Ts Info - Success
L2CAP LE Ethtool Get Ts Info - Success
SCO Ethtool Get Ts Info - Success
SCO Ethtool Get Ts Info No Flowctl - Success
ISO Ethtool Get Ts Info - Success
---

Notes:
    v2:
    - change expected timestamping flags to match kernel.

 tools/iso-tester.c   | 10 +++++++++
 tools/l2cap-tester.c | 15 ++++++++++++-
 tools/sco-tester.c   | 14 ++++++++++++
 tools/tester.h       | 52 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 63f6951e3..96467a973 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -3495,6 +3495,13 @@ static void test_connect2_suspend(const void *test_data)
 	trigger_force_suspend((void *)test_data);
 }
 
+static void test_iso_ethtool_get_ts_info(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	test_ethtool_get_ts_info(data->mgmt_index, BTPROTO_ISO, false);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -3919,5 +3926,8 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster AC 14 - Success", &bcast_ac_14, setup_powered,
 							test_bcast);
 
+	test_iso("ISO Ethtool Get Ts Info - Success", NULL, setup_powered,
+						test_iso_ethtool_get_ts_info);
+
 	return tester_run();
 }
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 41ef62578..53b7d6f1a 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -994,7 +994,7 @@ static void setup_powered_server_callback(uint8_t status, uint16_t length,
 
 	tester_print("Controller powered on");
 
-	if (!test->enable_ssp) {
+	if (!test || !test->enable_ssp) {
 		tester_setup_complete();
 		return;
 	}
@@ -2494,6 +2494,13 @@ done:
 	close(sk);
 }
 
+static void test_l2cap_ethtool_get_ts_info(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	test_ethtool_get_ts_info(data->mgmt_index, BTPROTO_L2CAP, false);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -2604,6 +2611,9 @@ int main(int argc, char *argv[])
 				&l2cap_server_nval_cid_test2,
 				setup_powered_server, test_server);
 
+	test_l2cap_bredr("L2CAP BR/EDR Ethtool Get Ts Info - Success", NULL,
+			setup_powered_server, test_l2cap_ethtool_get_ts_info);
+
 	test_l2cap_le("L2CAP LE Client - Success",
 				&le_client_connect_success_test_1,
 				setup_powered_client, test_connect);
@@ -2723,5 +2733,8 @@ int main(int argc, char *argv[])
 				&le_eatt_server_reject_test_1,
 				setup_powered_server, test_server);
 
+	test_l2cap_le("L2CAP LE Ethtool Get Ts Info - Success", NULL,
+			setup_powered_server, test_l2cap_ethtool_get_ts_info);
+
 	return tester_run();
 }
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 650f8bab3..8db424815 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -1098,6 +1098,14 @@ static void test_connect_acl_disc(const void *test_data)
 	test_connect(test_data);
 }
 
+static void test_sco_ethtool_get_ts_info(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	test_ethtool_get_ts_info(data->mgmt_index, BTPROTO_SCO,
+				!data->disable_sco_flowctl);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -1166,5 +1174,11 @@ int main(int argc, char *argv[])
 	test_offload_sco("eSCO mSBC - Offload - Success",
 		&connect_success, setup_powered, test_connect_offload_msbc);
 
+	test_sco("SCO Ethtool Get Ts Info - Success",
+			NULL, setup_powered, test_sco_ethtool_get_ts_info);
+
+	test_sco_no_flowctl("SCO Ethtool Get Ts Info No Flowctl - Success",
+			NULL, setup_powered, test_sco_ethtool_get_ts_info);
+
 	return tester_run();
 }
diff --git a/tools/tester.h b/tools/tester.h
index 4e7d7226b..1ba7a01a2 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -15,6 +15,11 @@
 #include <linux/errqueue.h>
 #include <linux/net_tstamp.h>
 
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
+#include <net/if.h>
+#include <sys/ioctl.h>
+
 #include <glib.h>
 
 #define SEC_NSEC(_t)  ((_t) * 1000000000LL)
@@ -198,3 +203,50 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 
 	return data->count - data->pos;
 }
+
+static inline void test_ethtool_get_ts_info(unsigned int index, int proto,
+							bool sco_flowctl)
+{
+	struct ifreq ifr = {};
+	struct ethtool_ts_info cmd = {};
+	uint32_t so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE |
+		SOF_TIMESTAMPING_TX_COMPLETION;
+	int sk;
+
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, proto);
+	if (sk < 0) {
+		if (sk == -EPROTONOSUPPORT)
+			tester_test_abort();
+		else
+			tester_test_failed();
+		return;
+	}
+
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "hci%u", index);
+	ifr.ifr_data = (void *)&cmd;
+	cmd.cmd = ETHTOOL_GET_TS_INFO;
+
+	if (ioctl(sk, SIOCETHTOOL, &ifr) == -1) {
+		tester_warn("SIOCETHTOOL failed");
+		tester_test_failed();
+		return;
+	}
+	close(sk);
+
+	if (proto == BTPROTO_SCO && !sco_flowctl)
+		so_timestamping &= ~SOF_TIMESTAMPING_TX_COMPLETION;
+
+	if (cmd.cmd != ETHTOOL_GET_TS_INFO ||
+			cmd.so_timestamping != so_timestamping ||
+			cmd.phc_index != -1 ||
+			cmd.tx_types != (1 << HWTSTAMP_TX_OFF) ||
+			cmd.rx_filters != (1 << HWTSTAMP_FILTER_NONE)) {
+		tester_warn("bad ethtool_ts_info");
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
-- 
2.49.0


Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C01F5833
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273018; cv=pass; b=YVvJuk3mfPBJng6c5EK0a8IUABowgv6bygxbAAtJKmbB+M1jL2e4Y+70P/ThRWr2xa+GGMZeTjXlhe7UenWH1ZYMEmzLkwMJJ3A3ndEdos0Y6oc6ObY7ZZsHHcPfvNY5D0kCTzU7bwMvraMTXhWGRYOQlZjbgRkHwwrcP11emZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273018; c=relaxed/simple;
	bh=gCdXMA09YJzwqknGWWUyS0e05AMngyWR6fb3ROJFWsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDkwQTYSL4SucMfgLTgdv3sgN8dM+gzwmouLmMdxYKKPH9Y2mYLKgBBSOllKnkFumc4uWX80x5KVWISQO0CQpOnYSbHzaXx7e6brXzL0ueQN+iUsGrWWfc3Qegz4HOWbX4BzPh+kLHx1eKdoTMQs3EEFKIUZHvgdOlcbMpKtrsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=s93Qb+ae; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="s93Qb+ae"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZhKBT49smz49PyD;
	Tue, 22 Apr 2025 01:03:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745273009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fdwJkixs9RYYqK3KVBCxCcaFdU0sPJC4DJJgD3Kb018=;
	b=s93Qb+aetP2SF29u+pV7zXxtIuDWGAphJb+KbeLhbY5tGMARX63q9DrTy3cZHlocdvdqQg
	qVyDdd1lSuv9QldLDNM0kxtvo7r0J0/ledSbsQUBHEpYIPA3A5lcwzg8PHUhRHgDsKeuNx
	mv7BySouXsQKzCxF5NNhDowPRETPPxVoGVmCdVLUC+9SB9fw8UveILQWBHZTUqSjb9JTWK
	MfAtLkv4GtFyQ8P2d8coQt3iF+R7KkVE8l5twBhO+pgGbO5G+GVgYdCDCgelLXMGcVuL/3
	LEu/iwrQv2lCqxqNcGJhGdnWQ2jIUFFToC+XfKq0/0M/sBkInC/X85qgI3vRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745273009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fdwJkixs9RYYqK3KVBCxCcaFdU0sPJC4DJJgD3Kb018=;
	b=hgQdH2Tyg5+ivvSf8CMZp6u2WfqYJirPV1K08d7DLCP68zIPCJCvoLH3Wq08BAAOpdT0eO
	f2vivTQPZ2uKR+hUj+UzLklFnOHQQCJHSggL3GQ9HfEiQI9nK62bQz87CSjRMZEC3Yia5l
	M5LNYv5rC1fDKYDz3BGEKo67JHxNRQLOEKg/KAMG9Yiw+nJcANAaEzDyX4oQypF3/qU5jC
	elzsMgkdFHbA8NXu4WYln5qo+AlRfDHQDvKp01NAkLiJAhgXtsTQK3QJYBWjZKqMq+3H4s
	uVlGU+pzfetawQE1D+a/YihAMv2TDkb45I/0SMgwc6V9p3BgPdZ3B+FF7G+A+w==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745273009; a=rsa-sha256;
	cv=none;
	b=njXjyYjiO+hsmwYhXXvQiECmmMHyNtdPiJhd9uHVDF2IPqbnFknKoQownSXcnItBvXt6Pe
	YWXgU3eO6fMXT1LftGO0QlDTcQDdeko0rkrWeOD+LSnwUDj89Qiu58anTJI3HeBzwcJHdC
	6LmBydM10vrcE5YPHtldync0K4sEBwNusSclXkvytDSM4/9S1GT8uneMBQIyO/78a6W+Oh
	PKyi+jH0FyLtpTq4LK0nNBhVMB7PoutebEjjzt/A280ApCPeD8963Sl9z4CB22drZecDAg
	wgAbaobFuelWYi5opTFnQEJ/NRNtHHO4j9Cp+GoHNpRnQ4MIGC4qKp8gHMsw+w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] tools: add tests for SIOCETHTOOL ETHTOOL_GET_TS_INFO
Date: Tue, 22 Apr 2025 01:03:27 +0300
Message-ID: <34c98b16c31ff4e5eb1a6d23326e7e2d7763a0ee.1745272994.git.pav@iki.fi>
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
 tools/iso-tester.c   | 10 ++++++++
 tools/l2cap-tester.c | 15 +++++++++++-
 tools/sco-tester.c   | 14 +++++++++++
 tools/tester.h       | 57 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)

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
index 4e7d7226b..241fba559 100644
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
@@ -198,3 +203,55 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 
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
+		SOF_TIMESTAMPING_OPT_ID |
+		SOF_TIMESTAMPING_OPT_CMSG |
+		SOF_TIMESTAMPING_OPT_TSONLY |
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
+	if (proto == BTPROTO_L2CAP)
+		so_timestamping &= ~SOF_TIMESTAMPING_RX_SOFTWARE;
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


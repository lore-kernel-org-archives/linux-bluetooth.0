Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF52512E4
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745750702; cv=pass; b=DZzw4g4ueuB8VyK25LIwc6K39rMXYalzNn4y4b+tfTTcb0GoO3ce3F7RWqxKv6BNRQdR7SlRYrXiERc+myH6lSwasJc/E6R9FsraZMTcBa2Ewpvoyn6pwby5jzuwapySMqpBIAX+z1jdttMI95rK1IU1f7RIK0O4xGxEDJ9gA+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745750702; c=relaxed/simple;
	bh=YrqV2D7ZW3vuR/dCBmJ9pLzNzJXTDpHpGcPPX42+Qzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVzPhVF4zeoSrMrEoBx0SKPCOQU2gibdWBX5Df0FzlDp3sEbmCa4dbC5jCOsXB1f6qlyIi17lZV/Uj6vqRO4AFdWibqL6RoOwnwZEIk/wCJfhxbBcs4d/H+aKuAHhmptkYGz7kfh52F4pJq9LMOww/bYZmEdgAN4rVl0udk+FSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ot+HpprU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ot+HpprU"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zljrk6PSjz49QKQ;
	Sun, 27 Apr 2025 13:44:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745750695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQvZDlrK04YhL4nNHdrZayEpEJlAjOptRgSIV2zeNGk=;
	b=Ot+HpprUhk4av9b4JZKi08aSKhpd2FwtKKa0IjQ2cuyYs7zrBVHqfI9ex9EKz6/ttRVS/u
	9CNNQ4F9PC8EvX7fCJaidVrqV0SeMYfLtvRmnszPwy7d9fTmlRx0qA6bXRH6zxBJiKph05
	cu/Tk0TAq3YrikkUiYlv4eR6H0pIW5kQFwPtHrKX6JZ8NGG7LTS0JOXEEa104yNM6+E1XV
	OVx23nPCGu96b2NVuXkx7sLR6DPL388Z9suzONBbhiUVPlIa64RuTTlFZkcdrKTovuwcVp
	gQ0Otd4bFkbEL205nV08q/VEb4wlguPZip9EKxTpBX37bJiq6csV4WEGjPSkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745750695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQvZDlrK04YhL4nNHdrZayEpEJlAjOptRgSIV2zeNGk=;
	b=evURzy5pAGHih3YiPOfI1ZvdKBbn/ih5AHpeCQPI3oEwtS1zy51UaYtPtETJhXZoDf5Zmu
	1xHcG7G2lpfjKhKSUSIpO21OXdfOOwvu8uI9gnwHjl5evW04HGxWm4IR+aH5W9zthjrSgD
	IiO59WcCBaG6EML9d6YUVhYqJ6uz4OpAf4uCIBibrqFq97Rc8sxW0sDmOlQwW2kCaitiFa
	7gnuVdK/XkRs+X4TlEKB2P0BUTrmMcAs7uCptEOO75gjs9CGo5pbFMjeUk63shDkuBJd7o
	FJfjRSQKiCMbAs6bUFIP2x3Yf5eaFD0+kpun2NSiPBQSyDOz1iS5MtFLbAm4zA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745750695; a=rsa-sha256;
	cv=none;
	b=QKjmOCxoaOxDT7zAfhgbFedjDdKJrqlspbYKE8B9Z2V/K2dG4fyrT6cHSHZyCyxrTW7r36
	Mpdy1VkX0K7cG/hGlpGB2pwc1HX8+nKslSksEv+AWiyKYkZZFd5z8MNA5B2yQ3SKaXOmgU
	z1kUNmKREDsSF2uuXhQknueK97VJpqAR2Zd4P3AQi95pwUxmXcYEeKdKOjb9e1wPXgTEVh
	2gm6TySOI3npHxqLCXBWXglZLpaNSu0nTVh312BC9kaYrBLRbfLh4Z0pL6LriBe5jQC72c
	XY2K54zbyoUMMMW/hLkd+SRjomOV4IqdlIG4j8V1vQjZ0UC2Yjw6kOOZUdSdmg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/5] sco-tester: add SCO receive and RX timestamping tests
Date: Sun, 27 Apr 2025 13:44:39 +0300
Message-ID: <7bfc6765fd01c72c49c9b926d86d7b4d3b0030de.1745750626.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
References: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests:

SCO CVSD Recv - Success
SCO CVSD Recv - RX Timestamping
---
 tools/sco-tester.c | 84 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 650f8bab3..fc89d1d29 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -52,6 +52,7 @@ struct test_data {
 
 struct sco_client_data {
 	int expect_err;
+	const uint8_t *recv_data;
 	const uint8_t *send_data;
 	uint16_t data_len;
 
@@ -300,6 +301,20 @@ static const struct sco_client_data connect_failure_reset = {
 
 const uint8_t data[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
 
+static const struct sco_client_data connect_recv_success = {
+	.expect_err = 0,
+	.data_len = sizeof(data),
+	.recv_data = data,
+};
+
+static const struct sco_client_data connect_recv_rx_ts_success = {
+	.expect_err = 0,
+	.data_len = sizeof(data),
+	.recv_data = data,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_RX_SOFTWARE),
+};
+
 static const struct sco_client_data connect_send_success = {
 	.expect_err = 0,
 	.data_len = sizeof(data),
@@ -401,7 +416,7 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 	bthost_set_cmd_complete_cb(bthost, client_connectable_complete, data);
 	bthost_write_scan_enable(bthost, 0x03);
 
-	if (scodata && scodata->send_data)
+	if (scodata && (scodata->send_data || scodata->recv_data))
 		bthost_set_sco_cb(bthost, sco_new_conn, data);
 }
 
@@ -783,6 +798,64 @@ static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
 	data->err_io_id = g_io_add_watch(io, G_IO_ERR, recv_errqueue, data);
 }
 
+static gboolean sock_received_data(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct sco_client_data *scodata = data->test_data;
+	bool tstamp = scodata->so_timestamping & SOF_TIMESTAMPING_RX_SOFTWARE;
+	char buf[1024];
+	int sk;
+	ssize_t len;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	len = recv_tstamp(sk, buf, sizeof(buf), tstamp);
+	if (len < 0) {
+		tester_warn("Unable to read: %s (%d)", strerror(errno), errno);
+		tester_test_failed();
+		return FALSE;
+	}
+
+	tester_debug("read: %d", (int)len);
+
+	if (len != scodata->data_len) {
+		tester_test_failed();
+		return FALSE;
+	}
+
+	--data->step;
+
+	if (len != scodata->data_len ||
+			memcmp(buf, scodata->recv_data, scodata->data_len))
+		tester_test_failed();
+	else if (!data->step)
+		tester_test_passed();
+	else
+		return TRUE;
+
+	return FALSE;
+}
+
+static void sco_recv_data(struct test_data *data, GIOChannel *io)
+{
+	const struct sco_client_data *scodata = data->test_data;
+	struct iovec iov = { (void *)scodata->recv_data, scodata->data_len };
+	struct bthost *bthost;
+
+	data->step = 0;
+
+	if (rx_timestamping_init(g_io_channel_unix_get_fd(io),
+						scodata->so_timestamping))
+		return;
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	g_io_add_watch(io, G_IO_IN, sock_received_data, NULL);
+
+	bthost_send_sco(bthost, data->handle, 0x00, &iov, 1);
+	++data->step;
+}
+
 static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -805,6 +878,9 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 	else
 		tester_print("Successfully connected");
 
+	if (scodata->recv_data)
+		sco_recv_data(data, io);
+
 	if (scodata->send_data) {
 		ssize_t ret = 0;
 		unsigned int count;
@@ -1137,6 +1213,12 @@ int main(int argc, char *argv[])
 	test_sco_11("SCO mSBC 1.1 - Failure", &connect_failure, setup_powered,
 							test_connect_transp);
 
+	test_sco("SCO CVSD Recv - Success", &connect_recv_success,
+					setup_powered, test_connect);
+
+	test_sco("SCO CVSD Recv - RX Timestamping", &connect_recv_rx_ts_success,
+					setup_powered, test_connect);
+
 	test_sco("SCO CVSD Send - Success", &connect_send_success,
 					setup_powered, test_connect);
 
-- 
2.49.0


Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBFE82C60
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296096; cv=pass; b=ZZHcFl+NNMOGrifk5zzffY9GA8R1e8XDT5IhrcUFdGgUBFX6nDuOPLyFsUsxo9QJH2XHP5a5ao1TrtDyoLnVmXZvabHmJjeWQAzNiae7j71KfN/zmQS1AAADOf/PAYDxfm06xVrLd73kQFO217hf/yEvSxJeiYv7cwkOwdDOQhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296096; c=relaxed/simple;
	bh=SXjy1ah0D7JaTWecpn0eRaPBlTQ9ylRp73au/A89waM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Igiqis0Zcj3gfemmnePsEKjqu2RjqFODm6GCSfJfy9kgdqoworpLHugEf6/7aDACIP8w3c6DhPmKVC3BWaUgJy5ICtkGBfoZm+7ebQEnTLIIW+u2jdYrXwop+rXKTzfa+m/k2jzBErL6Ai4DYLsCAB+o+fngsBt/RE+fxA+z7pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=e2eYU9xS; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rhTM14HH; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="e2eYU9xS";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rhTM14HH"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4bnN7X6f0Tz49PyD
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 21:33:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1753295624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=degPuEVJJAK9Z+DACURE/6l8ckiNYPaFjm4s+dpGYzg=;
	b=e2eYU9xSR347rYixiSt3j7kTeDR64lQh0+eQBEqRXM6Y9QDcAfdhDXm7tbWd40iFLLDnNQ
	+4aYALjTLhCWHPt2BehC5dpU9cx7HiYimzGyYme9ixKeWt7snI43FAF7ZRrqEUvxQIRtE2
	bWT+LXbdV01eTXsNY2U7Vxoz8Ug2nvRyASxh4TE+2JwIibjp1oTbYji3md/LIoWgrmFda+
	yn3l/hYAoFMmnv4GaQHUZz7Ukc8CK4/8Uvvshj+YrHBYNjahzViVbG0NDse9j8kqzxqjim
	07qc+ILitry2tqH2DygwL//r1F6l8dUEOLLaZhDBeh7khGcpzjwifS8hVEr3IQ==
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bnN7P3XNxzybB;
	Wed, 23 Jul 2025 21:33:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1753295617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=degPuEVJJAK9Z+DACURE/6l8ckiNYPaFjm4s+dpGYzg=;
	b=rhTM14HHXChm9XhWsBngmUvu2unOYKoxDzR5RzLmh7xYZuWdcTAn0HogDZ9iSXseLWuMiG
	IHQD+ugTzu8TY6Xq4th9SvErzf5wANbi4w6Tl+tV/WuQp+9h2xj0xBY03ACZc9iky/Lvug
	WK2uW/yxJnt+4WtnEidsjiY8xIpqMMU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1753295617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=degPuEVJJAK9Z+DACURE/6l8ckiNYPaFjm4s+dpGYzg=;
	b=O+E4//uIM6DmE40R+yB9C6ejB/2jigKFxdMHqZCHgsY+NeOKsyc54Se7cuVWDnQcd2MO9u
	gh7NrMvdaJ2Y5ikhNg+4nESQLhtkj63/dYpw9sbkyrIoaOzlUtYNtVYnnfoLlEER0GxmDd
	ePUbg9gxhNTRkI9LqdD7jXhcRBSmxpg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1753295617; a=rsa-sha256; cv=none;
	b=MvE6xHKU77gRnxW1N9IyNEAbRy85JpuCVTXMproZQuKYwfLCDfFzfrtmSRVmbEGU3p/4sp
	hIzfb+BZSufcXor0GLLNq8XNUDpJHmwYbT88tYDJPfGYFBXc8BdVvDO2q/ASBc9Mly353+
	Ff38VG8ssmJVPOpjVPKkfsBp7Bg77gE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] iso-tester: add tests for hardware RX timestamps
Date: Wed, 23 Jul 2025 21:33:34 +0300
Message-ID: <950d63f857ae87b99bd11c10c2313d5faf041d3c.1753295558.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <8b803274627f277cdb987b5ea5695f62247b6d3f.1753295558.git.pav@iki.fi>
References: <8b803274627f277cdb987b5ea5695f62247b6d3f.1753295558.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for HW RX timestamping.  Also add test that sends large
packets to test ISO fragmentation.

Add tests:

ISO Receive - HW Timestamping
ISO Receive Fragmented - Success
ISO Receive Fragmented - HW Timestamping
---
 tools/iso-tester.c | 53 +++++++++++++++++++++++++++++++++++++++++++---
 tools/tester.h     | 45 +++++++++++++++++++++++++++++----------
 2 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 6aefb5196..40465a5f7 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1013,6 +1013,12 @@ static const struct iovec send_48_2_1 = {
 	.iov_len = sizeof(data_48_2_1),
 };
 
+static const uint8_t data_large[512] = { [0 ... 511] = 0xff };
+static const struct iovec send_large = {
+	.iov_base = (void *)data_large,
+	.iov_len = sizeof(data_large),
+};
+
 static const struct iso_client_data connect_16_2_1_send = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -1049,6 +1055,13 @@ static const struct iso_client_data listen_16_2_1_recv = {
 	.server = true,
 };
 
+static const struct iso_client_data listen_16_2_1_recv_frag = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.recv = &send_large,
+	.server = true,
+};
+
 static const struct iso_client_data listen_16_2_1_recv_ts = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -1082,6 +1095,26 @@ static const struct iso_client_data listen_16_2_1_recv_rx_timestamping = {
 					SOF_TIMESTAMPING_RX_SOFTWARE),
 };
 
+static const struct iso_client_data listen_16_2_1_recv_hw_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+	.ts = true,
+	.so_timestamping = (SOF_TIMESTAMPING_RAW_HARDWARE |
+					SOF_TIMESTAMPING_RX_HARDWARE),
+};
+
+static const struct iso_client_data listen_16_2_1_recv_frag_hw_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.recv = &send_large,
+	.server = true,
+	.ts = true,
+	.so_timestamping = (SOF_TIMESTAMPING_RAW_HARDWARE |
+					SOF_TIMESTAMPING_RX_HARDWARE),
+};
+
 static const struct iso_client_data defer_16_2_1 = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -2247,8 +2280,10 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
-	if (isodata->so_timestamping & SOF_TIMESTAMPING_RX_SOFTWARE)
-		rx_timestamp_check(&msg);
+	if (rx_timestamp_check(&msg, isodata->so_timestamping, 1000) < 0) {
+		tester_test_failed();
+		return FALSE;
+	}
 
 	if (data->step) {
 		data->step--;
@@ -2290,7 +2325,7 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 
 	count = isodata->pkt_seqnum ? 2 : 1;
 	for (j = 0; j < count; ++j) {
-		bthost_send_iso(host, data->handle, isodata->ts, sn++, 0,
+		bthost_send_iso(host, data->handle, isodata->ts, sn++, j + 1,
 					isodata->pkt_status, isodata->recv, 1);
 		data->step++;
 	}
@@ -3718,6 +3753,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
+	test_iso("ISO Receive Fragmented - Success", &listen_16_2_1_recv_frag,
+							setup_powered,
+							test_listen);
+
 	test_iso("ISO Receive Timestamped - Success", &listen_16_2_1_recv_ts,
 							setup_powered,
 							test_listen);
@@ -3734,6 +3773,14 @@ int main(int argc, char *argv[])
 					&listen_16_2_1_recv_rx_timestamping,
 					setup_powered, test_listen);
 
+	test_iso("ISO Receive - HW Timestamping",
+					&listen_16_2_1_recv_hw_timestamping,
+					setup_powered, test_listen);
+
+	test_iso("ISO Receive Fragmented - HW Timestamping",
+				&listen_16_2_1_recv_frag_hw_timestamping,
+				setup_powered, test_listen);
+
 	test_iso("ISO Defer - Success", &defer_16_2_1, setup_powered,
 							test_defer);
 
diff --git a/tools/tester.h b/tools/tester.h
index 647c35485..896475110 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -204,11 +204,14 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 	return data->count - data->pos;
 }
 
-static inline int rx_timestamp_check(struct msghdr *msg)
+static inline int rx_timestamp_check(struct msghdr *msg, uint32_t flags,
+							int64_t expect_t_hw)
 {
+	bool soft_tstamp = flags & SOF_TIMESTAMPING_RX_SOFTWARE;
+	bool hw_tstamp = flags & SOF_TIMESTAMPING_RX_HARDWARE;
 	struct cmsghdr *cmsg;
 	struct timespec now;
-	int64_t t = 0;
+	int64_t t = 0, t_hw = 0;
 
 	for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg)) {
 		struct scm_timestamping *tss;
@@ -220,21 +223,40 @@ static inline int rx_timestamp_check(struct msghdr *msg)
 
 		tss = (struct scm_timestamping *)CMSG_DATA(cmsg);
 		t = TS_NSEC(&tss->ts[0]);
+		t_hw = TS_NSEC(&tss->ts[2]);
 		break;
 	}
+
 	if (!cmsg) {
+		if (!soft_tstamp && !hw_tstamp)
+			return 0;
 		tester_warn("RX timestamp missing");
 		return -EINVAL;
-	}
-
-	clock_gettime(CLOCK_REALTIME, &now);
-
-	if (TS_NSEC(&now) < t || TS_NSEC(&now) > t + SEC_NSEC(10)) {
-		tester_warn("RX timestamp bad time");
+	} else if (!soft_tstamp && !hw_tstamp) {
+		tester_warn("Spurious RX timestamp");
 		return -EINVAL;
 	}
 
-	tester_print("Got valid RX timestamp");
+	if (soft_tstamp) {
+		clock_gettime(CLOCK_REALTIME, &now);
+
+		if (TS_NSEC(&now) < t || TS_NSEC(&now) > t + SEC_NSEC(10)) {
+			tester_warn("Software RX timestamp bad time");
+			return -EINVAL;
+		}
+
+		tester_print("Got valid RX software timestamp");
+	}
+
+	if (hw_tstamp) {
+		if (t_hw != expect_t_hw) {
+			tester_warn("Bad hardware RX timestamp: %d != %d",
+						(int)t_hw, (int)expect_t_hw);
+			return -EINVAL;
+		}
+		tester_print("Got valid hardware RX timestamp");
+	}
+
 	return 0;
 }
 
@@ -260,7 +282,7 @@ static inline ssize_t recv_tstamp(int sk, void *buf, size_t size, bool tstamp)
 	if (ret < 0 || !tstamp)
 		return ret;
 
-	if (rx_timestamp_check(&msg)) {
+	if (rx_timestamp_check(&msg, SOF_TIMESTAMPING_RX_SOFTWARE, 0)) {
 		errno = EIO;
 		return -1;
 	}
@@ -272,7 +294,8 @@ static inline int rx_timestamping_init(int fd, int flags)
 {
 	socklen_t len = sizeof(flags);
 
-	if (!(flags & SOF_TIMESTAMPING_RX_SOFTWARE))
+	if (!(flags & (SOF_TIMESTAMPING_RX_SOFTWARE |
+						SOF_TIMESTAMPING_RX_HARDWARE)))
 		return 0;
 
 	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &flags, len) < 0) {
-- 
2.50.1


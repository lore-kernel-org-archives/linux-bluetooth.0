Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4ED30C144
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781431379; cv=none; b=T1Rt7n0MY6q8Avf0tiPoR5o/MSBYeg3yK/csYqoutNZY9eNHoeDbg8roFyFYm8CzVMdx4e5hKUrwNAUc7oEWP3cmGdGGaiFfTyKXnrSGUEBL2RiX7OFSablQwsQmnHUxZCTQIMlqk4yX/uFIchMaN6oFDqRwU+1hgQoJfmWqD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781431379; c=relaxed/simple;
	bh=YKwhFqinIyYwK9fmH+z6E3ZgX3LfdmImrinA0FHAnGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpjNhL+y2Xw+osng0PF+57uHUr/mjIQAUHlsK43QDLzxscPmOwOHZajoQqOS1BNdOVtFoYsfzoE7t115rmQzDcLhnpD7OqP+NTIB9IQogxjQPZ46jfYjml3rMhabearajyFfvhm4OwmissgOqgjQRtcjHLUNs7HmZB0DmdmpoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=cxC6ck+b; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="cxC6ck+b"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490afc47455so9730025e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781431376; x=1782036176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9CC9RUiAKbdeglBTwtRjfco4bSYxhiFDjgrCMBISik=;
        b=cxC6ck+b024Fxg5Tv/Jqja4KvPzSkQ/+H5EA+0Ji0Emca0dKN7p2uI+fXHsJ9atxo+
         Wp9JHbnS35fBBT1uRfB7EIdZWvyOwyfnVfi5xym7Xho2ufl19QXSynvNmjYdMEWLwvTA
         EJt13ZgqgwWCKqR1UJQPQIw44+RrD7aOqEm3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781431376; x=1782036176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G9CC9RUiAKbdeglBTwtRjfco4bSYxhiFDjgrCMBISik=;
        b=J4xgJgzbITUA4MY5qM9ei4L1RCDFIZEE5TKavmVEeC3Vg4d61Ep4olz9VxZPhf5oZV
         zVaZdafjjlbUkZUo7yvmXV/39u7mEOnLMAJnFw1BUfY1+9Or55jqDRwSRnHcnlN1jOEz
         kbk9Ipum6xDylLb7eyaTlsWW+ThfmXh/4qe8ec2FqpjaxKESvlPqW5TVFglQ+sOsoZIN
         Lh4bCe9l6wjxushg+Mn5Feaj8uF2fYDEgK958A9hJsIr0O9K7a7+7sH6CIiAZj1euAF+
         KjEyK2WmPcZSsMLbDUHYOhKTZ0OU6tjVKgpFKiyTkwSmHhyI4OLoz76g3xUV6lgeYZFv
         nm3A==
X-Gm-Message-State: AOJu0YzYCb0nGZvJ+P3WmEGCECh1XnQYQb/HrYJ3bSmOJNbxnQ6buuUZ
	AFrk9isihMK1vJr2+j7ATDi1UT5WG/17eDAy10sW9HkOpQVyqEPhBtzTbVuhoJaCCz2DjW0o6g4
	zY6hm
X-Gm-Gg: Acq92OEaKyot8MznXaNAZd5Wg+JlNX/GL4ROBMGQAH8K13F03YmNa1E6mcffCybZXZ4
	U1rTe+FzrFqtoCAHHGwJ6f9IaNcfQnhQf5GxRofrTa+3hBmRv1QlFl1JTQ8/0OKbrJ/KS1yeJjt
	QA0L5cpRHzCxL+8jR2WQJqPqp8P1tcrAH/Z7wsmwciJr24EsJP2gm3J7mS46pvZER8WF8Rw0t2G
	tBiAkYZGJrXx9sZIBCDsFzT0ioInzA81n1sByKMh1dPKn1tyqKu667nEgSM9UM0+AT1TKA/l3DY
	BMPTFHgzbFuvI5rWKyRgIEyxpfCUyQqBbcq5/37WC02VUoTzunsf9v4G4oECphnSlRnR+5NYj9h
	Ml9cghbZXYNbXvgfVXH/K3BwJaYShLC9LDaMcovhUVeX6oYg0AZxZjT2cJgKvLM6+wiPrzO9ZVZ
	rgm5obxuj32mIUE5xSHNsirsJ+b4NtyvpUbdQI1U0b6iVoI2P9AL+SRLU=
X-Received: by 2002:a05:600c:c04b:10b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-490ec4d6ae3mr90073945e9.9.1781431376075;
        Sun, 14 Jun 2026 03:02:56 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:eb61:bfa9:279d:6464])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm154231055e9.13.2026.06.14.03.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 03:02:55 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/2] unit/bap: Add CIS loss test
Date: Sun, 14 Jun 2026 12:02:08 +0200
Message-ID: <20260614100208.1091560-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614100208.1091560-1-simon.mikuda@streamunlimited.com>
References: <CABBYNZ+3vm1APyYtKYbXSVYMDC4YjXDrZEmNHeTKEGMg_Stpyg@mail.gmail.com>
 <20260614100208.1091560-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify a Source ASE in the Enabling state transitions to QoS Configured
rather than Disabling when its CIS is lost.

Assisted-by: ClaudeCode:claude-opus-4.8
---
 unit/test-bap.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 03b19678e..2847f5743 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -1486,6 +1486,37 @@ static void test_server(const void *user_data)
 	tester_io_send();
 }
 
+static void bap_attached_state(struct bt_bap *bap, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->bap = bap;
+
+	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
+
+	bt_bap_state_register(data->bap, data->cfg->state_func, NULL, data,
+									NULL);
+}
+
+/* Like test_server() but registers the config's state callback so the test can
+ * drive autonomous server transitions (e.g. loss of the CIS).
+ */
+static void test_server_state(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct io *io;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(test_complete_cb);
+
+	data->id = bt_bap_register(bap_attached_state, NULL, data);
+	g_assert(data->id);
+
+	tester_io_send();
+}
+
 static void test_usr_disc(void)
 {
 	/* BAP/USR/DISC/BV-01-C [Expose Audio Sink Capabilities]
@@ -4427,6 +4458,48 @@ static void test_spe(void)
 	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x04, 0x00, 0x00, 0x04, 0x03, 0x02, \
 			0x01, 0x00)
 
+static void state_cis_loss(struct bt_bap_stream *stream, uint8_t old_state,
+					uint8_t new_state, void *user_data)
+{
+	struct test_data *data = user_data;
+	int fds[2];
+	int err;
+
+	if (new_state != data->cfg->state)
+		return;
+
+	/* Attach a CIS and tear it down to simulate its loss. */
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, fds);
+	g_assert(err == 0);
+	g_assert(bt_bap_stream_io_connecting(stream, fds[0]) == 0);
+	close(fds[1]);
+}
+
+static struct test_config cfg_src_enabling_cis_loss = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_ENABLING,
+	.state_func = state_cis_loss,
+};
+
+/* On loss of the CIS a Source ASE in Enabling moves to QoS Configured, not
+ * Disabling.
+ */
+#define SCC_SRC_ENABLING_CIS_LOSS \
+	SCC_SRC_16_2_1, \
+	ENABLE_ASE(SRC_ID(0)), \
+	QOS_SRC_NOTIFY(0, 0, 0x10, 0x27, 0x00, 0x00, 0x02, 0x28, 0x00, \
+			0x02, 0x0a, 0x00, 0x40, 0x9c, 0x00)
+
+static void test_usr_scc_cis_loss(void)
+{
+	define_test("BAP/USR/SCC/BV-167-C [USR SRC QoS Configured on CIS loss]",
+			test_setup_server, test_server_state,
+			&cfg_src_enabling_cis_loss,
+			SCC_SRC_ENABLING_CIS_LOSS);
+}
+
 static struct test_config str_snk_ac2_8_1_1 = {
 	.cc = LC3_CONFIG_8_1_AC(1),
 	.qos = LC3_QOS_8_1_1_AC(1),
@@ -7287,6 +7360,7 @@ static void test_scc(void)
 	test_scc_enable();
 	test_scc_disable();
 	test_scc_release();
+	test_usr_scc_cis_loss();
 	test_scc_metadata();
 	test_str_1_1_1_lc3();
 }
-- 
2.43.0


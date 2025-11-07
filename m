Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342A2D9EE0
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546726; cv=none; b=C/1VHlc+W4/ScaTlRqMz1YiwZ8yEqjzYOaImxebSek8nB5MddKWNp8eZxC6qTew8IzJu+Q3awK0eyvcLmd+QMRyJG7/V4j+zJ7e5a30AvFfvVZ4wsvZyIZvZD9bTgCOTmbj8LnqhVAcXQM/E4QfLUfWpjMIkEECIlfqtsC8PdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546726; c=relaxed/simple;
	bh=6Iy9026tNC+FBPgnw747572svxg5Us0eBfvh2fVkAJk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ypa5xQ6ygEwNSQOtzXdi8yIv7ZkUOOaawTFejdRHG3YtafTpAz6A9i7iOJ5JSylA2tEfdTuviU2cXnldg/6b4uBlj0jTWfR5sjiJMBT67OQO9R6eHvc6iSSmmz+F0tgd5MXKfFsD9NV/ReKiI00tgh3bg086AFyEj0vA/vZuY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcRXVzRZ; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcRXVzRZ"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93720fd0723so153951241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546723; x=1763151523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuWOHa2Fe+Tof96Dgq9pDFL2C+PpZDu1m+K1OJnpcRw=;
        b=CcRXVzRZQ/LVZsEgY+R0FSB7xrvmoLmNW4OBgjWE6M9wtvbt0EbLPkkKMPUQirrqce
         3q4hXNxQ3f3owpMtXzTaIxHc1liZD4WKuRTKy9m+2t3gAruasx4CdjXAbJckg6SH4jlC
         mQsEYvp7kqYEL0R7kKyO79gLJXbfxOakQPH/pRrAPLhz1BcpN0Xhctd4/rKYFnsIiTQ2
         RT9ddANWX9M/M87wdtmjFPoHbBDjLc+jVBMogurtVBaX38stQaU77fw6F5jf9xyn15uq
         hC+hbU/bsQ2Ea+QKJWPl7ZCX/jfZ+bjpJCqYMem5+hmN4AGISWKSy/wnsWSR2jjVj8vZ
         pDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546723; x=1763151523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CuWOHa2Fe+Tof96Dgq9pDFL2C+PpZDu1m+K1OJnpcRw=;
        b=M2Oi5rZ54oKeYN6KZ1jumfmAE/S4+m9Pb4Xi4SeSh4M/0ajPqLU448T/TAH2IDCBg5
         d7t+uEn3MIpkHTCUydgtQLKLSekAYJGkGx2Obj66s8t8JHvA+ak5vyjwm5E8SmsaYMC9
         tOdG78XZqhPzTthHw/CtssnCiyqm+friTN2/7AxnQ6w3EsQKXEv/F5j+89CFg/wXPj1g
         BgzYLKTO2u9GWt5hU/gAGlJYHBCuzZpNmotsQZURxtxTdFZzalbLv8I/DQratm/puTWH
         wcKEh7s51jEn9Ypk0nOLbc7mJ6jWLIuliuy4BVEzjMo9W7eK7S4Z3a/QxFVA8V/Tv1Qj
         Ukew==
X-Gm-Message-State: AOJu0Yw8hQpsnRQ5YtYlnkr4ERuBZJi8axFq8hAVd1kZMm0IgkMPoEMd
	GRgNG6f7YOEH/kv1pTWt+xvaDgZoNDPBxfKimg09+TQsvNwtzfckhVd8E4EitA==
X-Gm-Gg: ASbGncticSWLlalGdC4GoStBtWEyxZOlRf+T6GEWKO8X4ZUhLqFAM4V4iGXFLidAtTx
	NzMsYU8HO4CsZc6XnfnPGuMt2gidxvs5v14KfN1TY0q1mTG8/MBTKtZ3PcQvG8fy4YRbNAm2bG9
	MApByeNV/8Dj5Qq1nUyNcUUGYJNa74cTG5OReBBwLfduq8CXhxDq4VCNooeF65WQm9yrx3+nRUp
	kVXTdAq2YOe5+KlDOFdApjv354N7Lhx7WuA8aM1dOjfSLg3OidLGil2/nbYjx7pQOCvL6Wlw1yR
	ck+7sO0XNjJ0O9BlIlrEqKQGfXl2Wwe8SrtzVYol8Ufd17QzbFQbhNHDb5hxBa/GsgKwwT+It0l
	370WplbAanqyE8ifw+a7sH/Avq/N5lelPpEcIYOWv9th537j2FrzvpOfyzMdVquC2OYK5J19OUz
	bC5a8=
X-Google-Smtp-Source: AGHT+IHM6cveRoTWTdlzkXdCcH+EmNRfWyy/JHMbfbQS0kV9xzO+6cDhV5l/I2EgW1mRzHU6HMky5Q==
X-Received: by 2002:a05:6102:370c:b0:5db:f8aa:3a41 with SMTP id ada2fe7eead31-5ddc47e3395mr314056137.27.1762546723175;
        Fri, 07 Nov 2025 12:18:43 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm3562921e0c.16.2025.11.07.12.18.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:18:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/5] iso-tester: Add tests for checking proper handling of Sync Lost
Date: Fri,  7 Nov 2025 15:18:25 -0500
Message-ID: <20251107201827.1235953-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107201827.1235953-1-luiz.dentz@gmail.com>
References: <20251107201827.1235953-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the following tests to check if BIG/PA Sync Lost are
handled properly:

ISO Broadcaster Receiver Sync Lost - Success
ISO Broadcaster PAST Receiver Sync Lost - Success
---
 tools/iso-tester.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 4bf1a287bc68..ff5c85ae410c 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -502,6 +502,7 @@ struct iso_client_data {
 	bool listen_bind;
 	bool pa_bind;
 	bool big;
+	bool terminate;
 
 	/* Enable BT_PKT_SEQNUM for RX packet sequence numbers */
 	bool pkt_seqnum;
@@ -1578,6 +1579,27 @@ static const struct iso_client_data bcast_16_2_1_recv_defer_get_base = {
 	.base_len = sizeof(base_lc3_ac_12),
 };
 
+static const struct iso_client_data bcast_16_2_1_recv_terminate = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+	.terminate = true,
+};
+
+static const struct iso_client_data past_16_2_1_recv_terminate = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.past = true,
+	.server = true,
+	.big = true,
+	.terminate = true,
+};
+
 static const struct iso_client_data bcast_ac_12 = {
 	.qos = BCAST_AC_12,
 	.expect_err = 0,
@@ -2389,6 +2411,21 @@ static void iso_shutdown(struct test_data *data, GIOChannel *io)
 	tester_print("Disconnecting...");
 }
 
+static void iso_terminate(struct test_data *data, GIOChannel *io)
+{
+	struct bthost *host;
+
+	/* Setup watcher to check if fd is closed properly after termination */
+	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_disconnected, data);
+
+	tester_print("Terminating...");
+
+	host = hciemu_client_get_host(data->hciemu);
+
+	bthost_set_pa_enable(host, 0x00);
+	bthost_terminate_big(host, BT_HCI_ERR_LOCAL_HOST_TERM);
+}
+
 static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -2498,6 +2535,8 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 		return TRUE;
 	else if (isodata->disconnect)
 		iso_shutdown(data, io);
+	else if (isodata->terminate)
+		iso_terminate(data, io);
 	else
 		tester_test_passed();
 
@@ -4311,6 +4350,16 @@ int main(int argc, char *argv[])
 					setup_powered,
 					test_bcast_recv);
 
+	test_iso("ISO Broadcaster Receiver Sync Lost - Success",
+					&bcast_16_2_1_recv_terminate,
+					setup_powered,
+					test_bcast_recv);
+
+	test_iso("ISO Broadcaster PAST Receiver Sync Lost - Success",
+					&past_16_2_1_recv_terminate,
+					setup_powered,
+					test_bcast_recv);
+
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
 
-- 
2.51.1


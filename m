Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769744;
	b=M4jaed/+h+Xb/OI3i28Hme+8MjtpDwcrJs61/cGBnDtIxd0FwlIZlfhhte0pC0Lfe81W
	 WiriDX2gdXZ7lriMtIqjWGotG8jFq51bbu8/yLqNY49r2/KhfEk9mvEFGYgu9s9Cv4rzI
	 N3b2FXQG2ZSuKfCE1aoYJvRd7T3ZJ06N8p2zx/phdbbLKDYq6DdgVR4EKaRtvTuG2R7nE
	 1+psqGdviuGuIpMLb0K04ct0i4wQYs95mMuo+CidTrWTe3BKGVB7RefhLzWcDM1oYbdfC
	 0xGNi7XG5cdq1PYSbo5ofO7VngMvAD1d8Exkq0oPLcGGtOJfIuMbgI2QDGx0sdnp4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sQjGQPB3t+vUpPn8H0/vg/l/SqIjAPLrBSP9nxJzrRY=;
	b=i7AP5BN1zXKpGowu6PbfnpWisNvXQnetlXe6oyMAhx7Wr/itPDpRiYXgUQAzdf2w21kt
	 bZMTM5e8Wr4pQRV2JsHrZ5eY28ZsUQFl02/w83CYNQHYOvOSGb45qzIijFeN8Hq3/ZT/H
	 eikD5Mj06A97uVKHhx3H8coRWb1BG6EcskwSQD710pEt6rKf+E6kzfwhpAQMIwgx2RWRc
	 VdMrUKsvLKjYOoJVP/XJk1Lvoo8NAAf4UAQPUygeRbNiqaEAGbQEoEWUBWQa8JwQ/NMmU
	 pkvxx5gmeJwRGoQk1v2PEccQgPrSoNCO3ym68Jqp1YwLWKUZnDCd38zflRX24XhxuWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UP20gIOi;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DF606A32A
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 299DF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UP20gIOi
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb76bb36c7so5999595e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769741; x=1796374541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQjGQPB3t+vUpPn8H0/vg/l/SqIjAPLrBSP9nxJzrRY=;
        b=UP20gIOi5NPWfc6c49UelyQXtCGz68img/SX8Bs1F+IEA0rcCjAtEVHjqybIovEr3v
         MoN3Scf58P5efvusaB2f3Xv7mFUtJviH/+MPSI/qgfFgxFKWjqhGhVHODT16CSKkhaXK
         XydkvOd4q4rqXDotDE7z2p8TQwTvQFLlrKw5ay0Tla67iqdwxilKiw6mMCVajosxp8lG
         a45hE5BzFl2ghkeD1ctq0zKWGh58imangvCd0SBa3CATGg6WvBTIen8NJjcNhE2t/cIG
         eNvYBJl1odE7qbsanFSlC40xS605xJ1LURAENCXCn1G8qexNAMd75+DwS7YPsFXlRdTB
         lU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769741; x=1796374541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQjGQPB3t+vUpPn8H0/vg/l/SqIjAPLrBSP9nxJzrRY=;
        b=HUj4sWUtCr0sn0tEKlQAV4vFTyJsOWUjffbqH8EDihRmnd+h59u+HLtY2fvhwoctJu
         w+0jWWIqZxZqsFk7y2FbDFtpYSqKmuCetuKU7oqIlE8L1zSlZiKzXbQJhRAWaUqIH2/p
         +W5SsgXyRPR31rzz8wT81bjApv5wAhQpLJICdTHghj3HmwaDuSKCH51pJ9r46QCVVNxc
         qNHSoBXPyx+CluFCLrRntHTpoeQNHQIKBjL9giIlKpKESGMEQO6ZHH3AXph15V4mTv8u
         oX5+y8CscxayQdE8JGDVUvotY9bI4gMZKnRxEWRggzMwLTsglDmvGpv6PnYcPLqak8eo
         jYKg==
X-Gm-Message-State: APuU4Z/xk8mPka4sL6+79IrZJiZyuvzUbzKs8oHJojcd7VNTk4tbu+0f
	ABmSWcFOivrOO0DNUP0rXmXr1OGtJNVGdGg6wNp5NMR+QM7YuFBmrqSCHGMbBw3Q
X-Gm-Gg: AZFdTZfkX4FdBydRY5M4tQVw7Zy2QcUDxZGLNcfV1/CuvbzxG5SKWND+yFwu611M8M0
	wHOrJ1nLJ0S9RblnvSYlYZV/HMSkMws6Zo5dawox424Ib9mS2d2MX3VW36HQVAbCiGC7Z8Vpged
	Zk/cbyf3fehkgUrsxGOoVPmTqOjMDnSPcFjpzi/sqHva4DmyBBCvKGqd1+spf+iYbLwhuzQlrQD
	dKXKFMF0UnaGDCffleiovVg+6bhweHAIVi78jlaoRQJocConpCk5V7FZKXwTtv0r/OoT1fb+Wzh
	/q9qdzgqG33DyX3t4b2h85wfs2xetyBqh2E64JfOp1dAlBde7wAIMxc98guMIf15dTUGfNl2eyF
	N+YE4c0/T5xEkJXn2yE/+h89G17b0Sr1qIwKUgTlCPPDT11smZhstLLhtoh+6fMwKhuG4FznOrX
	PN8OSm3+sxQvVmyIjwr+y3nolGj6oLR4cc5zj5LOZE+ViXcZyJimmDZ02AM/8m0iYcQKlKfm2nC
	Mwtiv3pEjM3uanV3+JEfw0Z189imPzSfR1FZZdDURYhQHVVW65D/l4Pg7UYx//5EOoQG9yE/AB6
	229aMPhXlPQEgD30+FRihkldVV+31j/eoeWWRM8AvwIrqTOy9DxQQluw
X-Received: by 2002:a05:600c:8284:b0:4bb:6c01:de9c with SMTP id 5b1f17b1804b1-4bb887f55c1mr426630385e9.2.1795769741360;
        Fri, 27 Nov 2026 00:55:41 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:41 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 9/9] mgmt-tester: Add periodic advertising and PAwR tests
Date: Fri, 27 Nov 2026 09:55:25 +0100
Message-ID: <20261127085525.264299-10-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085525.264299-1-rolandschober1968@gmail.com>
References: <20261127085525.264299-1-rolandschober1968@gmail.com>
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

Add tests for Add Periodic Advertising Parameters, Add Periodic
Advertising Data, Set Periodic Advertising Subevent Data and the
Periodic Advertising Subevent Data Request event:

 - the HCI commands sent for plain periodic advertising and for
   Periodic Advertising with Responses, on a second instance as well;
 - parameters and states which are refused, and controllers without
   the features;
 - Remove Advertising and Set Powered off with a train running, where
   periodic advertising has to be disabled before the advertising set
   is removed;
 - subevent data sent before the controller asked for it, in answer to
   its request, in two commands at once and twice for one subevent.

Assisted-by: Claude:claude-fable-5-2
---
 tools/mgmt-tester.c | 1024 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1024 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 18dbd3f89..2a1771ea8 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -8191,6 +8191,906 @@ static void setup_command_generic(const void *test_data)
 	}
 }
 
+/* Periodic advertising and Periodic Advertising with Responses over MGMT */
+static const uint8_t pa_ext_adv_params[] = {
+	0x01, /* instance */
+	0x80, 0x00, 0x00, 0x00, /* flags: secondary channel LE 1M */
+	0x00, 0x00, /* duration */
+	0x00, 0x00, /* timeout */
+	0x00, 0x00, 0x00, 0x00, /* min_interval */
+	0x00, 0x00, 0x00, 0x00, /* max_interval */
+	0x7f, /* tx_power */
+};
+
+static const uint8_t pa_ext_adv_params_2[] = {
+	0x02, /* instance */
+	0x80, 0x00, 0x00, 0x00, /* flags: secondary channel LE 1M */
+	0x00, 0x00, /* duration */
+	0x00, 0x00, /* timeout */
+	0x00, 0x00, 0x00, 0x00, /* min_interval */
+	0x00, 0x00, 0x00, 0x00, /* max_interval */
+	0x7f, /* tx_power */
+};
+
+static const uint8_t pa_ext_adv_params_conn[] = {
+	0x01, /* instance */
+	0x81, 0x00, 0x00, 0x00, /* flags: connectable, LE 1M */
+	0x00, 0x00, /* duration */
+	0x00, 0x00, /* timeout */
+	0x00, 0x00, 0x00, 0x00, /* min_interval */
+	0x00, 0x00, 0x00, 0x00, /* max_interval */
+	0x7f, /* tx_power */
+};
+
+static const uint8_t pa_ext_adv_params_legacy[] = {
+	0x01, /* instance */
+	0x00, 0x00, 0x00, 0x00, /* flags: none, legacy PDUs */
+	0x00, 0x00, /* duration */
+	0x00, 0x00, /* timeout */
+	0x00, 0x00, 0x00, 0x00, /* min_interval */
+	0x00, 0x00, 0x00, 0x00, /* max_interval */
+	0x7f, /* tx_power */
+};
+
+static const uint8_t pa_ext_adv_data[] = {
+	0x01, /* instance */
+	0x04, /* Ad data len */
+	0x00, /* Scan response data len */
+	0x03, /* Section length */
+	0x19, /* GAP Appearance */
+	0x01,
+	0x23,
+};
+
+static const uint8_t pa_ext_adv_data_2[] = {
+	0x02, /* instance */
+	0x04, /* Ad data len */
+	0x00, /* Scan response data len */
+	0x03, /* Section length */
+	0x19, /* GAP Appearance */
+	0x01,
+	0x23,
+};
+
+static const uint8_t pa_instance_1[] = { 0x01 };
+static const uint8_t pa_instance_2[] = { 0x02 };
+static const uint8_t pa_instance_all[] = { 0x00 };
+
+static const uint8_t pa_params[] = {
+	0x01, /* instance */
+	0x50, 0x00, /* min_interval: 100 ms */
+	0x50, 0x00, /* max_interval */
+	0x00, /* num_subevents */
+	0x00, /* subevent_interval */
+	0x00, /* response_slot_delay */
+	0x00, /* response_slot_spacing */
+	0x00, /* num_response_slots */
+};
+
+static const uint8_t pa_params_2[] = {
+	0x02, /* instance */
+	0x50, 0x00, /* min_interval: 100 ms */
+	0x50, 0x00, /* max_interval */
+	0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t pa_params_short[] = {
+	0x01, /* instance */
+	0x05, 0x00, /* min_interval: below 7.5 ms */
+	0x50, 0x00, /* max_interval */
+	0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t pa_params_min_max[] = {
+	0x01, /* instance */
+	0x51, 0x00, /* min_interval: above the maximum */
+	0x50, 0x00, /* max_interval */
+	0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t pawr_params[] = {
+	0x01, /* instance */
+	0x50, 0x00, /* min_interval: 100 ms */
+	0x50, 0x00, /* max_interval */
+	0x05, /* num_subevents */
+	0x06, /* subevent_interval: 7.5 ms */
+	0x02, /* response_slot_delay: 2.5 ms */
+	0x08, /* response_slot_spacing: 1 ms */
+	0x05, /* num_response_slots */
+};
+
+/* The first data request comes after one interval: time to be too early */
+static const uint8_t pawr_params_slow[] = {
+	0x01, /* instance */
+	0x40, 0x06, /* min_interval: 2 s */
+	0x40, 0x06, /* max_interval */
+	0x05, /* num_subevents */
+	0x06, /* subevent_interval: 7.5 ms */
+	0x02, /* response_slot_delay: 2.5 ms */
+	0x08, /* response_slot_spacing: 1 ms */
+	0x05, /* num_response_slots */
+};
+
+static const uint8_t pawr_params_subevents[] = {
+	0x01, /* instance */
+	0x50, 0x00, /* min_interval */
+	0x50, 0x00, /* max_interval */
+	0x81, /* num_subevents: more than 128 */
+	0x06, 0x02, 0x08, 0x05,
+};
+
+static const uint8_t hci_pa_params[] = {
+	0x01, /* handle */
+	0x50, 0x00, /* min_interval */
+	0x50, 0x00, /* max_interval */
+	0x00, 0x00, /* properties */
+};
+
+static const uint8_t hci_pa_params_2[] = {
+	0x02, /* handle */
+	0x50, 0x00, /* min_interval */
+	0x50, 0x00, /* max_interval */
+	0x00, 0x00, /* properties */
+};
+
+static const uint8_t hci_pa_params_v2[] = {
+	0x01, /* handle */
+	0x50, 0x00, /* min_interval */
+	0x50, 0x00, /* max_interval */
+	0x00, 0x00, /* properties */
+	0x05, /* num_subevents */
+	0x06, /* subevent_interval */
+	0x02, /* response_slot_delay */
+	0x08, /* response_slot_spacing */
+	0x05, /* num_response_slots */
+};
+
+static const uint8_t hci_pa_enable[] = { 0x01, 0x01 };
+static const uint8_t hci_pa_enable_2[] = { 0x01, 0x02 };
+static const uint8_t hci_pa_disable[] = { 0x00, 0x01 };
+static const uint8_t hci_pa_remove_set[] = { 0x01 };
+
+static const uint8_t pa_data[] = {
+	0x01, /* instance */
+	0x04, /* data_len */
+	0x03, 0xff, 0x59, 0x00, /* Manufacturer data */
+};
+
+static const uint8_t pa_data_len[] = {
+	0x01, /* instance */
+	0x05, /* data_len: one more than there is */
+	0x03, 0xff, 0x59, 0x00,
+};
+
+static const uint8_t hci_pa_data[] = {
+	0x01, /* handle */
+	0x03, /* operation: complete */
+	0x04, /* data_len */
+	0x03, 0xff, 0x59, 0x00,
+};
+
+static const uint8_t pa_subevent_data_0[] = {
+	0x01, /* instance */
+	0x01, /* num_subevents */
+	0x00, /* subevent */
+	0x00, /* response_slot_start */
+	0x05, /* response_slot_count */
+	0x04, /* data_len */
+	0x03, 0xff, 0x59, 0x00,
+};
+
+static const uint8_t pa_subevent_data_1[] = {
+	0x01, /* instance */
+	0x01, /* num_subevents */
+	0x01, /* subevent */
+	0x00, /* response_slot_start */
+	0x05, /* response_slot_count */
+	0x04, /* data_len */
+	0x03, 0xff, 0x59, 0x01,
+};
+
+static const uint8_t hci_pa_subevent_data_0[] = {
+	0x01, /* handle */
+	0x01, /* num_subevents */
+	0x00, /* subevent */
+	0x00, /* response_slot_start */
+	0x05, /* response_slot_count */
+	0x04, /* data_len */
+	0x03, 0xff, 0x59, 0x00,
+};
+
+static const uint8_t pa_subevent_data_none[] = {
+	0x01, /* instance */
+	0x00, /* num_subevents */
+};
+
+static const uint8_t pa_subevent_data_short[] = {
+	0x01, /* instance */
+	0x01, /* num_subevents */
+	0x00, 0x00, 0x05,
+	0x05, /* data_len: one more than there is */
+	0x03, 0xff, 0x59, 0x00,
+};
+
+static const uint8_t pa_subevent_data_long[] = {
+	0x01, /* instance */
+	0x01, /* num_subevents */
+	0x00, 0x00, 0x05,
+	0x04, /* data_len */
+	0x03, 0xff, 0x59, 0x00,
+	0x00, /* an octet after the last entry */
+};
+
+static const struct setup_mgmt_cmd pa_setup_instance[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params,
+		.send_len = sizeof(pa_ext_adv_params),
+	},
+};
+
+static const struct setup_mgmt_cmd pa_setup_instance_conn[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params_conn,
+		.send_len = sizeof(pa_ext_adv_params_conn),
+	},
+};
+
+static const struct setup_mgmt_cmd pa_setup_instance_legacy[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params_legacy,
+		.send_len = sizeof(pa_ext_adv_params_legacy),
+	},
+};
+
+static const struct setup_mgmt_cmd pa_setup_instances[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params,
+		.send_len = sizeof(pa_ext_adv_params),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params_2,
+		.send_len = sizeof(pa_ext_adv_params_2),
+	},
+};
+
+static const struct setup_mgmt_cmd pa_setup_periodic[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params,
+		.send_len = sizeof(pa_ext_adv_params),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+		.send_param = pa_params,
+		.send_len = sizeof(pa_params),
+	},
+};
+
+static const struct setup_mgmt_cmd pa_setup_train[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params,
+		.send_len = sizeof(pa_ext_adv_params),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+		.send_param = pa_params,
+		.send_len = sizeof(pa_params),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+		.send_param = pa_ext_adv_data,
+		.send_len = sizeof(pa_ext_adv_data),
+	},
+};
+
+/* Instance 1 advertises, instance 2 has the periodic advertising train */
+static const struct setup_mgmt_cmd pa_setup_trains[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params,
+		.send_len = sizeof(pa_ext_adv_params),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+		.send_param = pa_ext_adv_data,
+		.send_len = sizeof(pa_ext_adv_data),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params_2,
+		.send_len = sizeof(pa_ext_adv_params_2),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+		.send_param = pa_params_2,
+		.send_len = sizeof(pa_params_2),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+		.send_param = pa_ext_adv_data_2,
+		.send_len = sizeof(pa_ext_adv_data_2),
+	},
+};
+
+static const struct setup_mgmt_cmd pawr_setup_periodic[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params,
+		.send_len = sizeof(pa_ext_adv_params),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+		.send_param = pawr_params,
+		.send_len = sizeof(pawr_params),
+	},
+};
+
+static const struct setup_mgmt_cmd pawr_setup_train[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params,
+		.send_len = sizeof(pa_ext_adv_params),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+		.send_param = pawr_params,
+		.send_len = sizeof(pawr_params),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+		.send_param = pa_ext_adv_data,
+		.send_len = sizeof(pa_ext_adv_data),
+	},
+};
+
+static const struct setup_mgmt_cmd pawr_setup_train_slow[] = {
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_PARAMS,
+		.send_param = pa_ext_adv_params,
+		.send_len = sizeof(pa_ext_adv_params),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+		.send_param = pawr_params_slow,
+		.send_len = sizeof(pawr_params_slow),
+	},
+	{
+		.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+		.send_param = pa_ext_adv_data,
+		.send_len = sizeof(pa_ext_adv_data),
+	},
+};
+
+static const struct hci_cmd_data pa_params_hci_cmds[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PA_PARAMS,
+		.len = sizeof(hci_pa_params),
+		.param = hci_pa_params,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PA_ENABLE,
+		.len = sizeof(hci_pa_enable),
+		.param = hci_pa_enable,
+	},
+	{},
+};
+
+static const struct hci_cmd_data pa_params_2_hci_cmds[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PA_PARAMS,
+		.len = sizeof(hci_pa_params_2),
+		.param = hci_pa_params_2,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PA_ENABLE,
+		.len = sizeof(hci_pa_enable_2),
+		.param = hci_pa_enable_2,
+	},
+	{},
+};
+
+static const struct hci_cmd_data pawr_params_hci_cmds[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PA_PARAMS_V2,
+		.len = sizeof(hci_pa_params_v2),
+		.param = hci_pa_params_v2,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PA_ENABLE,
+		.len = sizeof(hci_pa_enable),
+		.param = hci_pa_enable,
+	},
+	{},
+};
+
+/* Periodic advertising has to be disabled before the set is removed */
+static const struct hci_cmd_data pa_remove_hci_cmds[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PA_ENABLE,
+		.len = sizeof(hci_pa_disable),
+		.param = hci_pa_disable,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_REMOVE_ADV_SET,
+		.len = sizeof(hci_pa_remove_set),
+		.param = hci_pa_remove_set,
+	},
+	{},
+};
+
+static const uint8_t hci_pa_disable_2[] = { 0x00, 0x02 };
+
+static const struct hci_cmd_data pa_remove_all_hci_cmds[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PA_ENABLE,
+		.len = sizeof(hci_pa_disable_2),
+		.param = hci_pa_disable_2,
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_CLEAR_ADV_SETS,
+		.len = 0,
+	},
+	{},
+};
+
+static const struct generic_data pa_params_success = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_instance,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_instance),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pa_params,
+	.send_len = sizeof(pa_params),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = pa_instance_1,
+	.expect_len = sizeof(pa_instance_1),
+	.expect_hci_list = pa_params_hci_cmds,
+};
+
+static const struct generic_data pa_params_success_2 = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_instances,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_instances),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pa_params_2,
+	.send_len = sizeof(pa_params_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = pa_instance_2,
+	.expect_len = sizeof(pa_instance_2),
+	.expect_hci_list = pa_params_2_hci_cmds,
+};
+
+static const struct generic_data pa_params_not_powered = {
+	.setup_settings = settings_le,
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pa_params,
+	.send_len = sizeof(pa_params),
+	.expect_status = MGMT_STATUS_REJECTED,
+};
+
+static const struct generic_data pa_params_no_instance = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pa_params,
+	.send_len = sizeof(pa_params),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_params_connectable = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_instance_conn,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_instance_conn),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pa_params,
+	.send_len = sizeof(pa_params),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_params_legacy = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_instance_legacy,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_instance_legacy),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pa_params,
+	.send_len = sizeof(pa_params),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_params_short_interval = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_instance,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_instance),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pa_params_short,
+	.send_len = sizeof(pa_params_short),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_params_min_above_max = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_instance,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_instance),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pa_params_min_max,
+	.send_len = sizeof(pa_params_min_max),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+/* For a controller without the feature, with or without an instance */
+static const struct generic_data pa_params_not_supported = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pa_params,
+	.send_len = sizeof(pa_params),
+	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
+};
+
+static const struct generic_data pawr_params_not_supported = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pawr_params,
+	.send_len = sizeof(pawr_params),
+	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
+};
+
+static const struct generic_data pawr_params_success = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_instance,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_instance),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pawr_params,
+	.send_len = sizeof(pawr_params),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = pa_instance_1,
+	.expect_len = sizeof(pa_instance_1),
+	.expect_hci_list = pawr_params_hci_cmds,
+};
+
+static const struct generic_data pawr_params_too_many_subevents = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_instance,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_instance),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	.send_param = pawr_params_subevents,
+	.send_len = sizeof(pawr_params_subevents),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_data_success = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_periodic,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_periodic),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_DATA,
+	.send_param = pa_data,
+	.send_len = sizeof(pa_data),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = pa_instance_1,
+	.expect_len = sizeof(pa_instance_1),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_PA_DATA,
+	.expect_hci_param = hci_pa_data,
+	.expect_hci_len = sizeof(hci_pa_data),
+};
+
+/* The data can be changed while the train runs */
+static const struct generic_data pa_data_success_running = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_train),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_DATA,
+	.send_param = pa_data,
+	.send_len = sizeof(pa_data),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = pa_instance_1,
+	.expect_len = sizeof(pa_instance_1),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_PA_DATA,
+	.expect_hci_param = hci_pa_data,
+	.expect_hci_len = sizeof(hci_pa_data),
+};
+
+static const struct generic_data pa_data_not_periodic = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_instance,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_instance),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_DATA,
+	.send_param = pa_data,
+	.send_len = sizeof(pa_data),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_data_invalid_len = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_periodic,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_periodic),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_DATA,
+	.send_param = pa_data_len,
+	.send_len = sizeof(pa_data_len),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_data_subevents = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_periodic,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_periodic),
+	.send_opcode = MGMT_OP_ADD_PERIODIC_ADV_DATA,
+	.send_param = pa_data,
+	.send_len = sizeof(pa_data),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_remove_success = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_train),
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = pa_instance_1,
+	.send_len = sizeof(pa_instance_1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = pa_instance_1,
+	.expect_len = sizeof(pa_instance_1),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = pa_instance_1,
+	.expect_alt_ev_len = sizeof(pa_instance_1),
+	.expect_hci_list = pa_remove_hci_cmds,
+};
+
+static const struct generic_data pawr_remove_success = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train),
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = pa_instance_1,
+	.send_len = sizeof(pa_instance_1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = pa_instance_1,
+	.expect_len = sizeof(pa_instance_1),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = pa_instance_1,
+	.expect_alt_ev_len = sizeof(pa_instance_1),
+	.expect_hci_list = pa_remove_hci_cmds,
+};
+
+static const struct generic_data pa_remove_all_success = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_trains,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_trains),
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = pa_instance_all,
+	.send_len = sizeof(pa_instance_all),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = pa_instance_all,
+	.expect_len = sizeof(pa_instance_all),
+	.expect_hci_list = pa_remove_all_hci_cmds,
+};
+
+static const struct generic_data pawr_power_off = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train),
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_off_param,
+	.send_len = sizeof(set_powered_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_ignore_param = true,
+};
+
+static const struct generic_data pa_subevent_data_no_subevents = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pa_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pa_setup_train),
+	.send_opcode = MGMT_OP_SET_PA_SUBEVENT_DATA,
+	.send_param = pa_subevent_data_0,
+	.send_len = sizeof(pa_subevent_data_0),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_subevent_data_not_powered = {
+	.setup_settings = settings_le,
+	.send_opcode = MGMT_OP_SET_PA_SUBEVENT_DATA,
+	.send_param = pa_subevent_data_0,
+	.send_len = sizeof(pa_subevent_data_0),
+	.expect_status = MGMT_STATUS_REJECTED,
+};
+
+static const struct generic_data pa_subevent_data_no_entries = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train),
+	.send_opcode = MGMT_OP_SET_PA_SUBEVENT_DATA,
+	.send_param = pa_subevent_data_none,
+	.send_len = sizeof(pa_subevent_data_none),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_subevent_data_short_entry = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train),
+	.send_opcode = MGMT_OP_SET_PA_SUBEVENT_DATA,
+	.send_param = pa_subevent_data_short,
+	.send_len = sizeof(pa_subevent_data_short),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data pa_subevent_data_trailing = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train),
+	.send_opcode = MGMT_OP_SET_PA_SUBEVENT_DATA,
+	.send_param = pa_subevent_data_long,
+	.send_len = sizeof(pa_subevent_data_long),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+/* The controller refuses data it has not asked for yet */
+static const struct generic_data pa_subevent_data_too_early = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train_slow,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train_slow),
+	.send_opcode = MGMT_OP_SET_PA_SUBEVENT_DATA,
+	.send_param = pa_subevent_data_0,
+	.send_len = sizeof(pa_subevent_data_0),
+	.expect_status = MGMT_STATUS_FAILED,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_PA_SUBEVENT_DATA,
+	.expect_hci_param = hci_pa_subevent_data_0,
+	.expect_hci_len = sizeof(hci_pa_subevent_data_0),
+};
+
+/* What a test sends when the controller asks for subevent data, and the
+ * status it expects for each command.
+ */
+struct pawr_answer {
+	const void *param;
+	uint16_t len;
+	uint8_t status;
+};
+
+static const uint8_t pawr_data_request_all[] = {
+	0x01, /* instance */
+	0x00, /* subevent_start */
+	0x05, /* subevent_data_count */
+};
+
+static const struct pawr_answer pawr_answers_one[] = {
+	{ pa_subevent_data_0, sizeof(pa_subevent_data_0),
+						MGMT_STATUS_SUCCESS },
+	{ }
+};
+
+/* Both commands are out before the controller answers the first */
+static const struct pawr_answer pawr_answers_two[] = {
+	{ pa_subevent_data_0, sizeof(pa_subevent_data_0),
+						MGMT_STATUS_SUCCESS },
+	{ pa_subevent_data_1, sizeof(pa_subevent_data_1),
+						MGMT_STATUS_SUCCESS },
+	{ }
+};
+
+/* The controller takes the data of a subevent once */
+static const struct pawr_answer pawr_answers_too_late[] = {
+	{ pa_subevent_data_0, sizeof(pa_subevent_data_0),
+						MGMT_STATUS_SUCCESS },
+	{ pa_subevent_data_0, sizeof(pa_subevent_data_0),
+						MGMT_STATUS_FAILED },
+	{ pa_subevent_data_1, sizeof(pa_subevent_data_1),
+						MGMT_STATUS_SUCCESS },
+	{ }
+};
+
+static const struct generic_data pawr_data_request = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train),
+};
+
+static const struct generic_data pawr_answer_success = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_PA_SUBEVENT_DATA,
+	.expect_hci_param = hci_pa_subevent_data_0,
+	.expect_hci_len = sizeof(hci_pa_subevent_data_0),
+	.send_param = pawr_answers_one,
+};
+
+static const struct generic_data pawr_answer_two = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train),
+	.send_param = pawr_answers_two,
+};
+
+static const struct generic_data pawr_answer_too_late = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = pawr_setup_train,
+	.setup_mgmt_cmd_arr_size = ARRAY_SIZE(pawr_setup_train),
+	.send_param = pawr_answers_too_late,
+};
+
+static void pawr_answer_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct pawr_answer *answer = user_data;
+
+	tester_print("Set PA Subevent Data: %s (0x%02x)",
+					mgmt_errstr(status), status);
+
+	if (status != answer->status) {
+		tester_warn("Expected status 0x%02x", answer->status);
+		tester_test_failed();
+		return;
+	}
+
+	if (status == MGMT_STATUS_SUCCESS &&
+			(length != sizeof(pa_instance_1) ||
+			memcmp(param, pa_instance_1, length))) {
+		tester_warn("Unexpected return parameters");
+		tester_test_failed();
+		return;
+	}
+
+	test_condition_complete(data);
+}
+
+static void pawr_data_request_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const struct pawr_answer *answer = test->send_param;
+
+	/* Only the first request of the train is answered */
+	if (!data->mgmt_alt_ev_id)
+		return;
+
+	mgmt_unregister(data->mgmt_alt, data->mgmt_alt_ev_id);
+	data->mgmt_alt_ev_id = 0;
+
+	if (length != sizeof(pawr_data_request_all) ||
+			memcmp(param, pawr_data_request_all, length)) {
+		tester_warn("Unexpected data request:");
+		util_hexdump('>', param, length, print_debug, "");
+		tester_test_failed();
+		return;
+	}
+
+	for (; answer && answer->param; answer++) {
+		test_add_condition(data);
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_PA_SUBEVENT_DATA,
+					data->mgmt_index, answer->len,
+					answer->param, pawr_answer_callback,
+					(void *) answer, NULL);
+	}
+
+	test_condition_complete(data);
+}
+
+/* Wait for the first data request of the train and answer it */
+static void test_pawr_answer(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (test->expect_hci_command) {
+		hciemu_add_central_post_command_hook(data->hciemu,
+						command_hci_callback, data);
+		test_add_condition(data);
+	}
+
+	data->mgmt_alt_ev_id = mgmt_register(data->mgmt_alt,
+					MGMT_EV_PA_SUBEVENT_DATA_REQUEST,
+					data->mgmt_index,
+					pawr_data_request_callback,
+					NULL, NULL);
+	test_add_condition(data);
+}
+
 static const uint8_t add_advertising_param_empty[] = {
 	0x01,			/* adv instance */
 	0x00, 0x00, 0x00, 0x00,	/* flags: none */
@@ -16211,6 +17111,130 @@ int main(int argc, char *argv[])
 				setup_add_ext_adv_on_off,
 				test_command_generic);
 
+	test_bredrle52("Add Periodic Adv Params - Success",
+				&pa_params_success,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Params - Success (2nd instance)",
+				&pa_params_success_2,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Params - Not powered",
+				&pa_params_not_powered,
+				NULL, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Params - No instance",
+				&pa_params_no_instance,
+				NULL, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Params - Connectable",
+				&pa_params_connectable,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Params - Legacy PDUs",
+				&pa_params_legacy,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Params - Interval too short",
+				&pa_params_short_interval,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Params - Min above max interval",
+				&pa_params_min_above_max,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle50("Add Periodic Adv Params - Not supported (5.0)",
+				&pa_params_not_supported,
+				NULL, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Params - PAwR not supported (5.2)",
+				&pawr_params_not_supported,
+				NULL, test_command_generic);
+
+	test_bredrle60("Add Periodic Adv Params - PAwR Success",
+				&pawr_params_success,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("Add Periodic Adv Params - PAwR too many subevents",
+				&pawr_params_too_many_subevents,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Data - Success",
+				&pa_data_success,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Data - Success (train running)",
+				&pa_data_success_running,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Data - Not periodic",
+				&pa_data_not_periodic,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Add Periodic Adv Data - Invalid length",
+				&pa_data_invalid_len,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("Add Periodic Adv Data - Instance with subevents",
+				&pa_data_subevents,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Remove Advertising - Periodic Success",
+				&pa_remove_success,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle52("Remove Advertising - Periodic Success (All)",
+				&pa_remove_all_success,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("Remove Advertising - PAwR Success",
+				&pawr_remove_success,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("Set Powered - Off with PAwR train",
+				&pawr_power_off,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("Set PA Subevent Data - No subevents",
+				&pa_subevent_data_no_subevents,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("Set PA Subevent Data - Not powered",
+				&pa_subevent_data_not_powered,
+				NULL, test_command_generic);
+
+	test_bredrle60("Set PA Subevent Data - No entries",
+				&pa_subevent_data_no_entries,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("Set PA Subevent Data - Entry beyond the packet",
+				&pa_subevent_data_short_entry,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("Set PA Subevent Data - Octets after the entries",
+				&pa_subevent_data_trailing,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("Set PA Subevent Data - Too early",
+				&pa_subevent_data_too_early,
+				setup_command_generic, test_command_generic);
+
+	test_bredrle60("PA Subevent Data Request - Success",
+				&pawr_data_request,
+				setup_command_generic, test_pawr_answer);
+
+	test_bredrle60("Set PA Subevent Data - Success",
+				&pawr_answer_success,
+				setup_command_generic, test_pawr_answer);
+
+	test_bredrle60("Set PA Subevent Data - Success (two commands)",
+				&pawr_answer_two,
+				setup_command_generic, test_pawr_answer);
+
+	test_bredrle60("Set PA Subevent Data - Too late",
+				&pawr_answer_too_late,
+				setup_command_generic, test_pawr_answer);
+
 
 	/* MGMT_OP_SET_DEVICE_ID
 	 * Using Bluetooth SIG for source.
-- 
2.47.3


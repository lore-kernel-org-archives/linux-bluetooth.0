Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06E388E59
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920364; cv=none; b=hn6lSMzbkp0ma7SUl0pSEz98SEKznLWvjLjrcmPmQEiyJa0QhF5htP3XFG8GBOji37AN1CU7v979iZi2ETPILPsE7m2obCFGwM3Iw40A1buryC2Z6O/g5zUwJVfMW5ExfLLpkereovPhd6kPUrw9YacDdBUTb0RxFgw8F8cofXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920364; c=relaxed/simple;
	bh=e93OsVryTlPEyuFKYJhe+iyj1K0ueuJ5vVx1aresM/k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nkw+ZuZkeiRSqYnbXcr5d1ZCJhDwr3j3nfI1cspjT9EOE4X5OersjjHYJ0QXlxvi3cYxU0s2noZTT543xAnY12sW+Z0qKC+QaNWTru9GPPpN2och8rZIGPZss3JxDclUABcnbTmeZ90i+zou49VEtQ4cXZga/KymkAc3EYFmjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV0c8/Og; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV0c8/Og"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-73a442f7cd3so501894137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920362; x=1785525162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o3ek8X/dQIrL5JRdvOQGlOrkTv+B4TfrTsOWVOJ3nT8=;
        b=lV0c8/OgEpUObhyBwKE+qrkvKDltVEA8DnmxL8sQak2sCCJc+2Om2ZbCbBAmgVcDxl
         KKWdjchsFAisQ+YeafvgiyI1mLlBKh3NsRdlPi2Amdau++orsT0R25lm95ayuDu5Zhb8
         PLcde6W/AwAFxQygRs8olBdEKP9HqG8FRuc90KegOGAH4oHj1xzGzLn0cHBhsGF6gL8p
         /xBw9XqEJ8xRy69Q9k2QO+XyThZ8sKIzH44nuERiaKgKFfwdFNbp7INYWE9KPBblJ7nU
         L23+mwhDgNIaRdTzGIdpSQhuUymG/XcCJGEcyif5Fgf2FgNk6tDiDzedlUINpg+QGrsn
         opIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920362; x=1785525162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o3ek8X/dQIrL5JRdvOQGlOrkTv+B4TfrTsOWVOJ3nT8=;
        b=VrJ/oUjopso458BRwK8kamSG8Ch/A5PPb51JW3cpmMtedt+HnH9auxDM9x+VQ5Ud/J
         vbIO9BAQxmMuByIrqwYRL31Aq8a4snf8cb2QeOVL6xEnzTrYM6ig6pAjHHsaE4oA28Ku
         i3y5qN+hSku78//mLbQ1Z3mZ1OgUmDANTuQM2wrLluKCyU+w0cNiBsp6DeAH5xb3fxkV
         jKxG8vOB+Ow2rUkFRz7dhqBWldMHM5DpKO4zrxyBbFHcSznsaShMLnnw4cGqbl8hrKjy
         DiCQVpFqschIHnwFHkRKDRBsY3gAm4p08qczi0UFf5AwcOCNjFQcXb6A7pgsHvDbdsKr
         aEeQ==
X-Gm-Message-State: AOJu0YxeGjxgA98S6Hnn3AIs3A6MYVA8A8lThF9IjX2ME7O8EZDTnXQs
	cBtzcTZbYF8zAdn4Gs5KZYZvf4KCXFCzsov8rzUQOM3A9eCqszrUCrfXj3uDfvEa
X-Gm-Gg: AR+sD112w/d67vhCIOuFgKW0iqkZ8lFJQJiVfvIOiqzvZDWKeLCshxuyb1eWHC+gnaW
	44mtPzqn4ZNTGJe3xOEi/YiomlGYkxUdJcY/RuIlt5/9qCg7eZ1F9xZQaTSdIdGZjfxOmce+NPD
	J7dKy/1QIBx9J9C207gQpbmJfNbXWm+B7S7cy3QjeXZNghjbPmeve3YXfMC+d4rgj7MX0ulPOyJ
	ZM2w8aK8DhnDrBD/kqHvUHfB9SSVZnPvAhqmZQkhuaRNK38p6y7facFVtKC0YNTQMUpq5WUStIA
	CyGJr2Y8Qyba4Bt/BWGa1J3S2W7f6efp84oElJTIytdit1kwsWSof7ocCanzNZjgMWsvImom+PI
	zc7jsdxAY7iS9l68A1tyaSeLfN5cWULcpgO508+zxX3MTQaz5qt5Coyeg2wMxPVs4wvCxLGPM8G
	HVuM5EgWyAoYcjJ83SWYtOFP/i0cmJkNaSWj3I9JYcfWYCoO/OfL1FIZynB2Az0513vTKN+wsX
X-Received: by 2002:a05:6102:f9b:b0:737:5c42:858b with SMTP id ada2fe7eead31-74d5e3d4033mr5283907137.11.1784920362225;
        Fri, 24 Jul 2026 12:12:42 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 06/12] monitor: Add decoding for Load Connection Subrate, SCI setting and event
Date: Fri, 24 Jul 2026 15:12:19 -0400
Message-ID: <20260724191225.1815634-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add decoding support for the new MGMT_OP_LOAD_CONN_SUBRATE (0x005C)
command, the MGMT_EV_CONN_SUBRATE (0x0033) event and the Shorter
Connection Interval setting bit (25) to btmon.
---
 monitor/packet.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 82afef6011d2..0d3b23cc3fb7 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14941,6 +14941,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 22, "LL Privacy"		},
 	{ 23, "PAST Sender"		},
 	{ 24, "PAST Receiver"		},
+	{ 25, "Shorter Connection Interval"	},
 	{}
 };
 
@@ -15101,6 +15102,27 @@ static void mgmt_print_connection_parameter(const void *data)
 	print_field("Supervision timeout: %u", supv_timeout);
 }
 
+static void mgmt_print_connection_subrate(const void *data)
+{
+	uint8_t address_type = get_u8(data + 6);
+	uint16_t min_interval = get_le16(data + 7);
+	uint16_t max_interval = get_le16(data + 9);
+	uint16_t subrate_min = get_le16(data + 11);
+	uint16_t subrate_max = get_le16(data + 13);
+	uint16_t max_latency = get_le16(data + 15);
+	uint16_t cont_num = get_le16(data + 17);
+	uint16_t supv_timeout = get_le16(data + 19);
+
+	mgmt_print_address(data, address_type);
+	print_field("Min connection interval: %u", min_interval);
+	print_field("Max connection interval: %u", max_interval);
+	print_field("Subrate min: %u", subrate_min);
+	print_field("Subrate max: %u", subrate_max);
+	print_field("Max latency: %u", max_latency);
+	print_field("Continuation number: %u", cont_num);
+	print_field("Supervision timeout: %u", supv_timeout);
+}
+
 static void mgmt_print_link_key(const void *data)
 {
 	uint8_t address_type = get_u8(data + 6);
@@ -16026,6 +16048,22 @@ static void mgmt_load_connection_parameters_cmd(const void *data, uint16_t size)
 		mgmt_print_connection_parameter(data + 2 + (i * 15));
 }
 
+static void mgmt_load_conn_subrate_cmd(const void *data, uint16_t size)
+{
+	uint16_t num_parameters = get_le16(data);
+	int i;
+
+	print_field("Parameters: %u", num_parameters);
+
+	if (size - 2 != num_parameters * 21) {
+		packet_hexdump(data + 2, size - 2);
+		return;
+	}
+
+	for (i = 0; i < num_parameters; i++)
+		mgmt_print_connection_subrate(data + 2 + (i * 21));
+}
+
 static void mgmt_read_unconf_index_list_rsp(const void *data, uint16_t size)
 {
 	uint16_t num_controllers = get_le16(data);
@@ -17096,6 +17134,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x005B, "Send HCI command and wait for event",
 				mgmt_hci_cmd_sync_cmd, 6, false,
 				mgmt_hci_cmd_sync_rsp, 0, false},
+	{ 0x005C, "Load Connection Subrate",
+				mgmt_load_conn_subrate_cmd, 2, false,
+				mgmt_null_rsp, 0, true },
 	{ }
 };
 
@@ -17620,6 +17661,25 @@ static void mgmt_mesh_packet_cmplt_evt(const void *data, uint16_t size)
 	print_field("Handle: %d", handle);
 }
 
+static void mgmt_conn_subrate_evt(const void *data, uint16_t size)
+{
+	uint8_t address_type = get_u8(data + 6);
+	uint8_t status = get_u8(data + 7);
+	uint16_t interval = get_le16(data + 8);
+	uint16_t subrate = get_le16(data + 10);
+	uint16_t latency = get_le16(data + 12);
+	uint16_t cont_num = get_le16(data + 14);
+	uint16_t supv_timeout = get_le16(data + 16);
+
+	mgmt_print_address(data, address_type);
+	mgmt_print_status(status);
+	print_field("Interval: %u", interval);
+	print_field("Subrate: %u", subrate);
+	print_field("Latency: %u", latency);
+	print_field("Continuation number: %u", cont_num);
+	print_field("Supervision timeout: %u", supv_timeout);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -17717,6 +17777,8 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_mesh_device_found_evt, 22, false },
 	{ 0x0032, "Mesh Packet Complete",
 			mgmt_mesh_packet_cmplt_evt, 1, true },
+	{ 0x0033, "Connection Subrate",
+			mgmt_conn_subrate_evt, 18, true },
 	{ }
 };
 
-- 
2.54.0


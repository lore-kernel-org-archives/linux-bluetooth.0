Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E8763EE
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2024 05:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785151; cv=none; b=THOGg/calL26mxyMuTmZsAO+dlN3yg3Z5PbxasfxcRzJWq+zJCyzoGpF3ZTbf1MlbcWr1Ich1lEkNF0HD550tKvJCHSw5FoCqwIOHLacW9SiCyeHvrOCpqdWkG9SPHSAWdn88MBLvZsD6JeYZo0zf6S7AkMgRtUoVVZy9AJtcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785151; c=relaxed/simple;
	bh=aSHTgzDxVVfAHQ4c6NA3YFho78M5uqN5rX27wa/7cPk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VzIznWSNY3r6UakIEl6hdu0hCjMJElEMLnrfhA+lWLODbomhOnSNt+ynOWU9ybFdV4otQvUPtEIgIXt4UrcPdFB1sawL4/ctiWAozxkB6nyRot4hbLUgI0Kt24HERC2EaMkarb0vRB10i64n05Ng2zhw/XGtnJrbMgfPNdBCB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAeVZmQ9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAeVZmQ9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7126ca1ece1so1646616b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 22:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723785149; x=1724389949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=10xsiE518qp4wK5dUsfogdDvmCnMIa6eHGTXTRflSwY=;
        b=EAeVZmQ9pPzmmyOWqITSdbbsX8vWBV21Xk6wnYQ/PY1PxbImwXuP/N7DdSSvDVHAqz
         tZdSwvohRZZ/t4Og1PLfNc0cjBfG133bHtXnPJixh3FgmchTJDXzia87oTrd1WbtgE3N
         KVvqSN5b0hjpABBRd8FXh9yZ5MbQrGd6XNjoLc8X6WToMQEsrNfIURjUPdVUqRMvxVra
         PUUbflDwsCYLXop0ozImm8bNbuVuuWTkJ6QyiI6h+1FtTCRuumbAVZbTlsqXJEF1zznj
         4U98ujUHnMkGf83Ji+K2XCGPOK5dToQa2LNLDwrp7PPpel7QWwTajEP6WTmTIQI6sCUD
         qCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723785149; x=1724389949;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10xsiE518qp4wK5dUsfogdDvmCnMIa6eHGTXTRflSwY=;
        b=AGULJw5cz5mPo8zVe0OaYosomZrrR6Z8aoySbx6qwsHwYWxtAsdF7lpNuW3RB5C9Oq
         +SKLMN/rJKDLCL+W26o4E1xTxLtW3VP4G9iAaIbUz9ev31+tylamLqOtsvrkes94Ok+T
         dRp/dpr09n+gMNfGshCxv3Y1/mojETPb7gsdXbjjxFwKunzxWc0S7DKWA4e1Ghzwnhk2
         geHwf4boMg5RQr12W5ibxmc6Vr4fHxvbummpi3IaykQL5yAJow+72m226uBFgjQxqTU4
         TTUUlMbt5f7QC+Wqwzt/MmTqvCqgdIcdEx2LPQlA8fY3K0L1GW4KgnyyQ08uyDYGDpFf
         TAkg==
X-Gm-Message-State: AOJu0Yw4UsPjo8+wnk5qS65xm3CtuylxriJDr47TIAN24d2ZXuSx4tkQ
	njIisx/pWyfpuyDCLjAVp122UzZvevhcyePepkNvY8AeTA9p9DslaBCQBw7TaBe0GbiMnRRigOG
	jp6mPI8WkIcLnfQYcAsbFli2j7mAUTwrd+s6OHWRZE7NS7+8viJwPrghYgSbMv7MIzAJeBNLPLi
	7DguF3MghrZeLv2QCJVXlzmjCL4T5uWpElVO6A7PPbyLIWt9SqYNwecNYvuIbiUSzyVPgiEpM=
X-Google-Smtp-Source: AGHT+IFuTVHTI5h9TpkWMzgTmnJrMBdwzQa7N+bcs15x1tKL4gsq7+UNV7dOSjjP6k15ol84r32w3zrAMFcUG4s2Ng==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:ddc:e88c:53fe:14b6])
 (user=howardchung job=sendgmr) by 2002:a05:6a00:6f0a:b0:70d:323f:d0aa with
 SMTP id d2e1a72fcca58-71277167a25mr55264b3a.2.1723785148395; Thu, 15 Aug 2024
 22:12:28 -0700 (PDT)
Date: Fri, 16 Aug 2024 13:11:45 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816131145.Bluez.v1.1.I6eb6574a1f0abd21e735618d5e8936fd230a4fa3@changeid>
Subject: [Bluez PATCH v1] Monitor: Complete missing fields in ESco Connection
From: Howard Chung <howardchung@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Yun-Hao Chung <howardchung@google.com>

This implements the missing fields in the ESCO connection setup and
accept commands.
---
An example of output looks like below:
< HCI Command: Enhanced Setup Synchronous Connection (0x01|0x003d) plen 59
        Handle: 256 Address: 00:11:22:33:44:55 (Google, Inc.)
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Transmit Coding Format:
          Codec: Transparent (0x03)
        Receive Coding Format:
          Codec: Transparent (0x03)
        Transmit Codec Frame Size: 60
        Receive Codec Frame Size: 60
        Input Coding Format:
          Codec: Transparent (0x03)
        Output Coding Format:
          Codec: Transparent (0x03)
        Input Coded Data Size: 16
        Output Coded Data Size: 16
        Input PCM Data Format: 2's complement
        Output PCM Data Format: 2's complement
        Input PCM Sample Payload MSB Position: 0
        Output PCM Sample Payload MSB Position: 0
        Input Data Path: HCI
        Output Data Path: HCI
        Input Transport Unit Size: 0
        Output Transport Unit Size: 0
        Max latency: 13
        Packet type: 0x0380
          3-EV3 may not be used
          2-EV5 may not be used
          3-EV5 may not be used
        Retransmission effort: Optimize for link quality (0x02)

 monitor/packet.c | 98 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 5abf164eb..c2599fe68 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4845,6 +4845,50 @@ static void flow_spec_modify_cmd(uint16_t index, const void *data, uint8_t size)
 	print_flow_spec("RX", cmd->rx_flow_spec);
 }
 
+static void print_coding_format(const char *label,
+						const uint8_t coding_format[5])
+{
+	print_field("%s:", label);
+	packet_print_codec_id("  Codec", coding_format[0]);
+	if (coding_format[0] == 0xff) {
+		print_field("  Company: %s",
+				bt_compidtostr(get_le16(coding_format + 1)));
+		print_field("  Vendor Specific Codec: 0x%4.4x",
+						get_le16(coding_format + 3));
+	}
+}
+
+static void print_pcm_data_format(const char *label, uint8_t pcm)
+{
+	switch (pcm) {
+	case 0:
+		print_field("%s: NA", label);
+		break;
+	case 1:
+		print_field("%s: 1's complement", label);
+		break;
+	case 2:
+		print_field("%s: 2's complement", label);
+		break;
+	case 3:
+		print_field("%s: Sign-magnitude", label);
+		break;
+	case 4:
+		print_field("%s: Unsigned", label);
+		break;
+	default:
+		print_field("%s: Unknown (0x%2.2x)", label, pcm);
+	}
+}
+
+static void print_data_path(const char *label, uint8_t data_path)
+{
+	if (data_path == 0)
+		print_field("%s: HCI", label);
+	else
+		print_field("%s: Vendor Specific (0x%2.2x)", label, data_path);
+}
+
 static void enhanced_setup_sync_conn_cmd(uint16_t index, const void *data,
 							uint8_t size)
 {
@@ -4853,9 +4897,30 @@ static void enhanced_setup_sync_conn_cmd(uint16_t index, const void *data,
 	print_handle(cmd->handle);
 	print_field("Transmit bandwidth: %d", le32_to_cpu(cmd->tx_bandwidth));
 	print_field("Receive bandwidth: %d", le32_to_cpu(cmd->rx_bandwidth));
-
-	/* TODO */
-
+	print_coding_format("Transmit Coding Format", cmd->tx_coding_format);
+	print_coding_format("Receive Coding Format", cmd->rx_coding_format);
+	print_field("Transmit Codec Frame Size: %d",
+					le16_to_cpu(cmd->tx_codec_frame_size));
+	print_field("Receive Codec Frame Size: %d",
+					le16_to_cpu(cmd->rx_codec_frame_size));
+	print_coding_format("Input Coding Format", cmd->input_coding_format);
+	print_coding_format("Output Coding Format", cmd->output_coding_format);
+	print_field("Input Coded Data Size: %d",
+				le16_to_cpu(cmd->input_coded_data_size));
+	print_field("Output Coded Data Size: %d",
+				le16_to_cpu(cmd->output_coded_data_size));
+	print_pcm_data_format("Input PCM Data Format",
+						cmd->input_pcm_data_format);
+	print_pcm_data_format("Output PCM Data Format",
+						cmd->output_pcm_data_format);
+	print_field("Input PCM Sample Payload MSB Position: %d",
+						cmd->input_pcm_msb_position);
+	print_field("Output PCM Sample Payload MSB Position: %d",
+						cmd->output_pcm_msb_position);
+	print_data_path("Input Data Path", cmd->input_data_path);
+	print_data_path("Output Data Path", cmd->output_data_path);
+	print_field("Input Transport Unit Size: %d", cmd->input_unit_size);
+	print_field("Output Transport Unit Size: %d", cmd->output_unit_size);
 	print_field("Max latency: %d", le16_to_cpu(cmd->max_latency));
 	print_pkt_type_sco(cmd->pkt_type);
 	print_retransmission_effort(cmd->retrans_effort);
@@ -4870,9 +4935,30 @@ static void enhanced_accept_sync_conn_request_cmd(uint16_t index,
 	print_bdaddr(cmd->bdaddr);
 	print_field("Transmit bandwidth: %d", le32_to_cpu(cmd->tx_bandwidth));
 	print_field("Receive bandwidth: %d", le32_to_cpu(cmd->rx_bandwidth));
-
-	/* TODO */
-
+	print_coding_format("Transmit Coding Format", cmd->tx_coding_format);
+	print_coding_format("Receive Coding Format", cmd->rx_coding_format);
+	print_field("Transmit Codec Frame Size: %d",
+					le16_to_cpu(cmd->tx_codec_frame_size));
+	print_field("Receive Codec Frame Size: %d",
+					le16_to_cpu(cmd->rx_codec_frame_size));
+	print_coding_format("Input Coding Format", cmd->input_coding_format);
+	print_coding_format("Output Coding Format", cmd->output_coding_format);
+	print_field("Input Coded Data Size: %d",
+				le16_to_cpu(cmd->input_coded_data_size));
+	print_field("Output Coded Data Size: %d",
+				le16_to_cpu(cmd->output_coded_data_size));
+	print_pcm_data_format("Input PCM Data Format",
+						cmd->input_pcm_data_format);
+	print_pcm_data_format("Output PCM Data Format",
+						cmd->output_pcm_data_format);
+	print_field("Input PCM Sample Payload MSB Position: %d",
+						cmd->input_pcm_msb_position);
+	print_field("Output PCM Sample Payload MSB Position: %d",
+						cmd->output_pcm_msb_position);
+	print_data_path("Input Data Path", cmd->input_data_path);
+	print_data_path("Output Data Path", cmd->output_data_path);
+	print_field("Input Transport Unit Size: %d", cmd->input_unit_size);
+	print_field("Output Transport Unit Size: %d", cmd->output_unit_size);
 	print_field("Max latency: %d", le16_to_cpu(cmd->max_latency));
 	print_pkt_type_sco(cmd->pkt_type);
 	print_retransmission_effort(cmd->retrans_effort);
-- 
2.46.0.184.g6999bdac58-goog


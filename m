Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60418514758
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748070; cv=none; b=ag9gg0gUAl4UORVXPlH6gkW1D1Apfsdu/yCLLLJzx2K8jlryruAmQtTHTsW5+FmLcY0VRk3+hRlJ8q/+PWcleo1DdeYxSPfr5eeLvO63YOy2Z3n7WkQjIGcUOAouG5Xze41mRrSmo7iH8BLiS1D0ki5CkaCIJBjXklV4+2kOzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748070; c=relaxed/simple;
	bh=pIxCm+8acj9KrNmQa3nUU9AasEhi4Lw+E1waNAEvqe8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHICCxnZpK8ypi0lcwrbCdRBiMZMAarOU2hZ6Ezgr6Apnth3pioKFf/jnqD4HWtO+sUPZiEzpu765pDPNm+x1tCj4OEnE2dUhelMHcnbjY3MrlzqiBH8BP3LT6VaQBzDgimWEUCl9DnqtSqu5UcpZgHFy+uNgXF64g3b1G7fgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk8PuXqx; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk8PuXqx"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a03fe69236so354196137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748065; x=1790352865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mV6HXDkTYCpj0RTm8OY19fLzzfSa4gIGVdOz+zRHYrM=;
        b=kk8PuXqxv6R5oXMO0VCAawk0O5/HTU7RamytHBGzyOWYBAgug3JkZa1BmINTZj9E+T
         XvWdlY5KOnApTHc+HA92fI653mZsuctX7lF/ftKGDhwrzaM6VttRG+7jBIblLY8gSaxr
         WcKbv/zjjeCUwtyRi3ZBeuF4+k4b3hV7/mGpvg4z2ox8dP9Ywq5z2ZZcaUEcAk524ZSA
         mpWJMKfeidNLFDPhx27H3df3MhDzttAm9qeiIO7thBpv2yff20VJfOfru9mZ/v6Nj7Rn
         dgTMy5J+Ke9G74umENE35kxFFQmtRSQhT6pajb8dCijG14r3cpH0XyPCir0v9Fzvvl2P
         50/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748065; x=1790352865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mV6HXDkTYCpj0RTm8OY19fLzzfSa4gIGVdOz+zRHYrM=;
        b=NQs9sLSV+iqWjbk+X0jAuWrVDMxXm60h3pX4VDXjp3+B77ZYXsLGkTU/Jn7n4Gx1W/
         foRILF+AbCFNePwn4ktUooySiEdLARD/YmI1DbvWcep2sTqm3HdZyOLRTf4XvFr6Po3u
         HcKfzHoHwEicZLEaO657+DJ++K1RneNLQn/IH07VL6Q1OIBdXbyt6z59TjSunlxAECOx
         AsR3c1PiIbwrAb9HW3GgUHr+m2CsMABsqvNs/KGkItFZBpjyQIeqjlFWdf6wB3+YdBCA
         jUT+ITb9C66keEDwxTEaDuZXDLnLx6xh609Mvk/BjmaOVrXBASMUP0qnf68icpF8JzFa
         pSAg==
X-Gm-Message-State: AFuF++mYzeqNejtOD4VIjXUecKtxhGKMSIr7XB4X+ys6sOayFUMs1FPa
	gUqVpcKqn1gAL3RpAgWQOXH4woA5muTyasSa9SXyh1i8L7vznucR5VOpNigQmbu4
X-Gm-Gg: AYBFou0f347hkbhVKUovG/+6qQJk3SCJElLTZPxWo6u/G4sZH+yMqjwyrm8X3oGGzKF
	u870+mojXb/O888LhrtTfrocUqXqNkHzAfvCmpHn0vkoqHHMCdB0k1zDk6NIN5PMdsATzs73IcY
	4WJLOj0lPHrEfTeE1F31sWUy046yUbfXs2kPpm9715cewA4Zct/h32+oZRl85Dl9+w5lx0lznV4
	ZG0j/WZ/QvOwYgaplkG1S6mhDf4hit85cpxxJcQabFNg3vObBr2AP99uNd4ew3qShX00ivyTP0U
	GeT6eMh8WyiNOyZpK3TjAqXL6exfRsDyUHylV9vuZvg0rppNCDAVC8PaCt+2I/1ZQBBKiCeDzN+
	DgEwzqhde7HO8iaQwajwjZSWngULVqUaN4bWGTohtRLAeqqBuanPO0sbYc1rVa+JDRj879Gxxsk
	kuVeNHceVwj4jsSLniIPf02X8XSbpFBvx08z3cqt06EAYkI1ABjXvGFJ7L03x9xyU+Wj+YnsO7G
	9EtX81UfoqOkwB458ovHQPn6ZIvwGNIzTFQCOdscUqt+HfwCZCCi7XEuRCyyeJd
X-Received: by 2002:a05:6102:5f07:b0:7a2:6b90:3dbb with SMTP id ada2fe7eead31-7a55d7998a7mr1425456137.25.1789748064543;
        Fri, 18 Sep 2026 09:14:24 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/9] monitor: Route the decoding output through a single function
Date: Fri, 18 Sep 2026 12:14:03 -0400
Message-ID: <20260918161408.2464981-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918161408.2464981-1-luiz.dentz@gmail.com>
References: <20260918161408.2464981-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The decoding output is written straight to stdout, partly through the
print_indent() macro and partly through some 167 direct printf() calls,
several of which build a single line across multiple calls. There is no
point at which the output of a frame can be observed as a whole.

Send all of it through display_printf(), which writes to a redirectable
stream, so that a caller can capture a frame and decide what to do with
it rather than having it go straight to the terminal. Capturing at the
stream level keeps the partially built lines working without having to
find and restructure them.

This is a pure redirection and the output is unchanged. The messages
jlink emits while connecting are left alone, as they are not part of the
decoding.

l2test uses the printing helpers from the header without linking the
monitor, so it gains its own display_printf() next to the use_color() it
already defines for the same reason.

Assisted-by: opencode:claude-opus-5
---
 monitor/analyze.c |  47 +++++++-------
 monitor/avctp.c   |  68 ++++++++++----------
 monitor/control.c | 161 +++++++++++++++++++++++++---------------------
 monitor/display.c |  20 ++++++
 monitor/display.h |  11 +++-
 monitor/l2cap.c   |  35 +++++-----
 monitor/lmp.c     |   4 +-
 monitor/main.c    |  12 ++--
 monitor/packet.c  |  19 +++---
 monitor/rfcomm.c  |   6 +-
 tools/l2test.c    |  10 +++
 11 files changed, 225 insertions(+), 168 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 8b11b64ace15..5d54ad61b7b6 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -277,11 +277,11 @@ static void chan_destroy(void *data)
 
 	fixed = fixed_channel_name(chan->cid);
 	if (fixed)
-		printf("  Found %s L2CAP channel with CID %u (%s)\n",
+		display_printf("  Found %s L2CAP channel with CID %u (%s)\n",
 					chan->out ? "TX" : "RX", chan->cid,
 					fixed);
 	else
-		printf("  Found %s L2CAP channel with CID %u\n",
+		display_printf("  Found %s L2CAP channel with CID %u\n",
 					chan->out ? "TX" : "RX", chan->cid);
 
 	if (chan->psm)
@@ -298,6 +298,8 @@ static void chan_destroy(void *data)
 	print_stats(&chan->tx, "TX");
 
 done:
+	queue_destroy(chan->rx.plot, free);
+	queue_destroy(chan->tx.plot, free);
 	free(chan);
 }
 
@@ -370,7 +372,8 @@ static void conn_destroy(void *data)
 		break;
 	}
 
-	printf("  Found %s connection with handle %u\n", str, conn->handle);
+	display_printf("  Found %s connection with handle %u\n", str,
+				conn->handle);
 	packet_print_addr("Address", conn->bdaddr, conn->bdaddr_type);
 	if (!conn->setup_seen)
 		print_field("Connection setup missing");
@@ -482,29 +485,29 @@ static void dev_destroy(void *data)
 		break;
 	}
 
-	printf("Found %s controller with index %u\n", str, dev->index);
-	printf("  BD_ADDR %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+	display_printf("Found %s controller with index %u\n", str, dev->index);
+	display_printf("  BD_ADDR %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
 			dev->bdaddr[5], dev->bdaddr[4], dev->bdaddr[3],
 			dev->bdaddr[2], dev->bdaddr[1], dev->bdaddr[0]);
 	if (dev->manufacturer != 0xffff)
-		printf(" (%s)", bt_compidtostr(dev->manufacturer));
-	printf("\n");
+		display_printf(" (%s)", bt_compidtostr(dev->manufacturer));
+	display_printf("\n");
 
 
-	printf("  %lu commands\n", dev->num_cmd);
-	printf("  %lu events\n", dev->num_evt);
-	printf("  %lu ACL packets\n", dev->num_acl);
-	printf("  %lu SCO packets\n", dev->num_sco);
-	printf("  %lu ISO packets\n", dev->num_iso);
-	printf("  %lu vendor packets\n", dev->num_vendor);
-	printf("  %lu vendor diagnostics\n", dev->vendor_diag);
-	printf("  %lu system notes\n", dev->system_note);
-	printf("  %lu user logs\n", dev->user_log);
-	printf("  %lu control messages\n", dev->ctrl_msg);
-	printf("  %lu unknown opcodes\n", dev->unknown);
+	display_printf("  %lu commands\n", dev->num_cmd);
+	display_printf("  %lu events\n", dev->num_evt);
+	display_printf("  %lu ACL packets\n", dev->num_acl);
+	display_printf("  %lu SCO packets\n", dev->num_sco);
+	display_printf("  %lu ISO packets\n", dev->num_iso);
+	display_printf("  %lu vendor packets\n", dev->num_vendor);
+	display_printf("  %lu vendor diagnostics\n", dev->vendor_diag);
+	display_printf("  %lu system notes\n", dev->system_note);
+	display_printf("  %lu user logs\n", dev->user_log);
+	display_printf("  %lu control messages\n", dev->ctrl_msg);
+	display_printf("  %lu unknown opcodes\n", dev->unknown);
 
 	if (dev->num_cmd_rsp)
-		printf("  Command latency: %lld-%lld msec "
+		display_printf("  Command latency: %lld-%lld msec "
 				"(~%lld msec +/- %lld msec)\n",
 				TV_MSEC(dev->cmd_latency.min),
 				TV_MSEC(dev->cmd_latency.max),
@@ -513,12 +516,12 @@ static void dev_destroy(void *data)
 
 	/* Whatever is left never got a Command Complete or Command Status */
 	if (!queue_isempty(dev->cmd_list))
-		printf("  Commands without response: %u\n",
+		display_printf("  Commands without response: %u\n",
 					queue_length(dev->cmd_list));
 
 	queue_destroy(dev->cmd_list, free);
 	queue_destroy(dev->conn_list, conn_destroy);
-	printf("\n");
+	display_printf("\n");
 
 	free(dev);
 }
@@ -1639,7 +1642,7 @@ void analyze_trace(const char *path)
 		num_packets++;
 	}
 
-	printf("Trace contains %lu packets\n\n", num_packets);
+	display_printf("Trace contains %lu packets\n\n", num_packets);
 
 	queue_destroy(dev_list, dev_destroy);
 
diff --git a/monitor/avctp.c b/monitor/avctp.c
index 75afaca8342f..d6eb603d2905 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1049,16 +1049,16 @@ response:
 
 		print_field("%*cStringLength: 0x%02x", (indent - 8), ' ', len);
 
-		printf("String: ");
+		display_printf("String: ");
 		for (; len > 0; len--) {
 			uint8_t c;
 
 			if (!l2cap_frame_get_u8(frame, &c))
 				return false;
 
-			printf("%1c", isprint(c) ? c : '.');
+			display_printf("%1c", isprint(c) ? c : '.');
 		}
-		printf("\n");
+		display_printf("\n");
 	}
 
 	return true;
@@ -1125,16 +1125,16 @@ response:
 
 		print_field("%*cStringLength: 0x%02x", (indent - 8), ' ', len);
 
-		printf("String: ");
+		display_printf("String: ");
 		for (; len > 0; len--) {
 			uint8_t c;
 
 			if (!l2cap_frame_get_u8(frame, &c))
 				return false;
 
-			printf("%1c", isprint(c) ? c : '.');
+			display_printf("%1c", isprint(c) ? c : '.');
 		}
-		printf("\n");
+		display_printf("\n");
 	}
 
 	return true;
@@ -1405,16 +1405,16 @@ response:
 								' ', status);
 		switch (status) {
 		case 0x00:
-			printf("(POWER_ON)\n");
+			display_printf("(POWER_ON)\n");
 			break;
 		case 0x01:
-			printf("(POWER_OFF)\n");
+			display_printf("(POWER_OFF)\n");
 			break;
 		case 0x02:
-			printf("(UNPLUGGED)\n");
+			display_printf("(UNPLUGGED)\n");
 			break;
 		default:
-			printf("(UNKNOWN)\n");
+			display_printf("(UNKNOWN)\n");
 			break;
 		}
 		break;
@@ -1873,16 +1873,16 @@ static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 	print_field("%*cPlayStatus: 0x%02x (%s)", indent, ' ',
 						status, playstatus2str(status));
 
-	printf("%*cFeatures: 0x", indent+8, ' ');
+	display_printf("%*cFeatures: 0x", indent+8, ' ');
 
 	for (i = 0; i < 16; i++) {
 		if (!l2cap_frame_get_u8(frame, &features[i]))
 			return false;
 
-		printf("%02x", features[i]);
+		display_printf("%02x", features[i]);
 	}
 
-	printf("\n");
+	display_printf("\n");
 
 	print_features(features, indent + 2);
 
@@ -1898,15 +1898,15 @@ static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 	print_field("%*cNameLength: 0x%04x (%u)", indent, ' ',
 						namelen, namelen);
 
-	printf("%*cName: ", indent+8, ' ');
+	display_printf("%*cName: ", indent+8, ' ');
 	for (; namelen > 0; namelen--) {
 		uint8_t c;
 
 		if (!l2cap_frame_get_u8(frame, &c))
 			return false;
-		printf("%1c", isprint(c) ? c : '.');
+		display_printf("%1c", isprint(c) ? c : '.');
 	}
-	printf("\n");
+	display_printf("\n");
 
 	return true;
 }
@@ -1920,7 +1920,7 @@ static bool avrcp_folder_item(struct avctp_frame *avctp_frame,
 	uint64_t uid;
 
 	if (frame->size < 14) {
-		printf("PDU Malformed\n");
+		display_printf("PDU Malformed\n");
 		return false;
 	}
 
@@ -1954,15 +1954,15 @@ static bool avrcp_folder_item(struct avctp_frame *avctp_frame,
 	print_field("%*cNameLength: 0x%04x (%u)", indent, ' ',
 					namelen, namelen);
 
-	printf("%*cName: ", indent+8, ' ');
+	display_printf("%*cName: ", indent+8, ' ');
 	for (; namelen > 0; namelen--) {
 		uint8_t c;
 		if (!l2cap_frame_get_u8(frame, &c))
 			return false;
 
-		printf("%1c", isprint(c) ? c : '.');
+		display_printf("%1c", isprint(c) ? c : '.');
 	}
-	printf("\n");
+	display_printf("\n");
 
 	return true;
 }
@@ -1994,16 +1994,16 @@ static bool avrcp_attribute_entry_list(struct avctp_frame *avctp_frame,
 		print_field("%*cAttributeLength: 0x%04x (%u)", indent, ' ',
 						len, len);
 
-		printf("%*cAttributeValue: ", indent+8, ' ');
+		display_printf("%*cAttributeValue: ", indent+8, ' ');
 		for (; len > 0; len--) {
 			uint8_t c;
 
 			if (!l2cap_frame_get_u8(frame, &c))
 				return false;
 
-			printf("%1c", isprint(c) ? c : '.');
+			display_printf("%1c", isprint(c) ? c : '.');
 		}
-		printf("\n");
+		display_printf("\n");
 	}
 
 	return true;
@@ -2041,15 +2041,15 @@ static bool avrcp_media_element_item(struct avctp_frame *avctp_frame,
 	print_field("%*cNameLength: 0x%04x (%u)", indent, ' ',
 					namelen, namelen);
 
-	printf("%*cName: ", indent+8, ' ');
+	display_printf("%*cName: ", indent+8, ' ');
 	for (; namelen > 0; namelen--) {
 		uint8_t c;
 		if (!l2cap_frame_get_u8(frame, &c))
 			return false;
 
-		printf("%1c", isprint(c) ? c : '.');
+		display_printf("%1c", isprint(c) ? c : '.');
 	}
-	printf("\n");
+	display_printf("\n");
 
 	if (!l2cap_frame_get_u8(frame, &count))
 		return false;
@@ -2097,7 +2097,7 @@ static bool avrcp_get_total_number_of_items(struct avctp_frame *avctp_frame)
 		goto response;
 
 	if (frame->size < 4) {
-		printf("PDU Malformed\n");
+		display_printf("PDU Malformed\n");
 		packet_hexdump(frame->data, frame->size);
 		return false;
 	}
@@ -2146,7 +2146,7 @@ static bool avrcp_search_item(struct avctp_frame *avctp_frame)
 		goto response;
 
 	if (frame->size < 4) {
-		printf("PDU Malformed\n");
+		display_printf("PDU Malformed\n");
 		packet_hexdump(frame->data, frame->size);
 		return false;
 	}
@@ -2162,17 +2162,17 @@ static bool avrcp_search_item(struct avctp_frame *avctp_frame)
 
 	print_field("%*cLength: 0x%04x (%u)", indent, ' ', namelen, namelen);
 
-	printf("%*cString: ", indent+8, ' ');
+	display_printf("%*cString: ", indent+8, ' ');
 	for (; namelen > 0; namelen--) {
 		uint8_t c;
 
 		if (!l2cap_frame_get_u8(frame, &c))
 			return false;
 
-		printf("%1c", isprint(c) ? c : '.');
+		display_printf("%1c", isprint(c) ? c : '.');
 	}
 
-	printf("\n");
+	display_printf("\n");
 
 	return true;
 
@@ -2426,16 +2426,16 @@ response:
 			continue;
 		}
 
-		printf("%*cFolder: ", indent+8, ' ');
+		display_printf("%*cFolder: ", indent+8, ' ');
 		for (; len > 0; len--) {
 			uint8_t c;
 
 			if (!l2cap_frame_get_u8(frame, &c))
 				return false;
 
-			printf("%1c", isprint(c) ? c : '.');
+			display_printf("%1c", isprint(c) ? c : '.');
 		}
-		printf("\n");
+		display_printf("\n");
 	}
 
 	return true;
diff --git a/monitor/control.c b/monitor/control.c
index 1eab9c4fe0bd..bff70c0cce75 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -69,28 +69,28 @@ static void free_data(void *user_data)
 
 static void mgmt_index_added(uint16_t len, const void *buf)
 {
-	printf("@ Index Added\n");
+	display_printf("@ Index Added\n");
 
 	packet_hexdump(buf, len);
 }
 
 static void mgmt_index_removed(uint16_t len, const void *buf)
 {
-	printf("@ Index Removed\n");
+	display_printf("@ Index Removed\n");
 
 	packet_hexdump(buf, len);
 }
 
 static void mgmt_unconf_index_added(uint16_t len, const void *buf)
 {
-	printf("@ Unconfigured Index Added\n");
+	display_printf("@ Unconfigured Index Added\n");
 
 	packet_hexdump(buf, len);
 }
 
 static void mgmt_unconf_index_removed(uint16_t len, const void *buf)
 {
-	printf("@ Unconfigured Index Removed\n");
+	display_printf("@ Unconfigured Index Removed\n");
 
 	packet_hexdump(buf, len);
 }
@@ -100,11 +100,11 @@ static void mgmt_ext_index_added(uint16_t len, const void *buf)
 	const struct mgmt_ev_ext_index_added *ev = buf;
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Extended Index Added control\n");
+		display_printf("* Malformed Extended Index Added control\n");
 		return;
 	}
 
-	printf("@ Extended Index Added: %u (%u)\n", ev->type, ev->bus);
+	display_printf("@ Extended Index Added: %u (%u)\n", ev->type, ev->bus);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -117,11 +117,12 @@ static void mgmt_ext_index_removed(uint16_t len, const void *buf)
 	const struct mgmt_ev_ext_index_removed *ev = buf;
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Extended Index Removed control\n");
+		display_printf("* Malformed Extended Index Removed control\n");
 		return;
 	}
 
-	printf("@ Extended Index Removed: %u (%u)\n", ev->type, ev->bus);
+	display_printf("@ Extended Index Removed: %u (%u)\n", ev->type,
+				ev->bus);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -134,11 +135,11 @@ static void mgmt_controller_error(uint16_t len, const void *buf)
 	const struct mgmt_ev_controller_error *ev = buf;
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Controller Error control\n");
+		display_printf("* Malformed Controller Error control\n");
 		return;
 	}
 
-	printf("@ Controller Error: 0x%2.2x\n", ev->error_code);
+	display_printf("@ Controller Error: 0x%2.2x\n", ev->error_code);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -160,21 +161,22 @@ static void mgmt_new_config_options(uint16_t len, const void *buf)
 	unsigned int i;
 
 	if (len < 4) {
-		printf("* Malformed New Configuration Options control\n");
+		display_printf("* Malformed New Configuration Options "
+				"control\n");
 		return;
 	}
 
 	options = get_le32(buf);
 
-	printf("@ New Configuration Options: 0x%4.4x\n", options);
+	display_printf("@ New Configuration Options: 0x%4.4x\n", options);
 
 	if (options) {
-		printf("%-12c", ' ');
+		display_printf("%-12c", ' ');
 		for (i = 0; i < NELEM(config_options_str); i++) {
 			if (options & (1 << i))
-				printf("%s ", config_options_str[i]);
+				display_printf("%s ", config_options_str[i]);
 		}
-		printf("\n");
+		display_printf("\n");
 	}
 
 	buf += 4;
@@ -196,21 +198,21 @@ static void mgmt_new_settings(uint16_t len, const void *buf)
 	unsigned int i;
 
 	if (len < 4) {
-		printf("* Malformed New Settings control\n");
+		display_printf("* Malformed New Settings control\n");
 		return;
 	}
 
 	settings = get_le32(buf);
 
-	printf("@ New Settings: 0x%4.4x\n", settings);
+	display_printf("@ New Settings: 0x%4.4x\n", settings);
 
 	if (settings) {
-		printf("%-12c", ' ');
+		display_printf("%-12c", ' ');
 		for (i = 0; i < NELEM(settings_str); i++) {
 			if (settings & (1 << i))
-				printf("%s ", settings_str[i]);
+				display_printf("%s ", settings_str[i]);
 		}
-		printf("\n");
+		display_printf("\n");
 	}
 
 	buf += 4;
@@ -224,11 +226,11 @@ static void mgmt_class_of_dev_changed(uint16_t len, const void *buf)
 	const struct mgmt_ev_class_of_dev_changed *ev = buf;
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Class of Device Changed control\n");
+		display_printf("* Malformed Class of Device Changed control\n");
 		return;
 	}
 
-	printf("@ Class of Device Changed: 0x%2.2x%2.2x%2.2x\n",
+	display_printf("@ Class of Device Changed: 0x%2.2x%2.2x%2.2x\n",
 						ev->dev_class[2],
 						ev->dev_class[1],
 						ev->dev_class[0]);
@@ -244,11 +246,12 @@ static void mgmt_local_name_changed(uint16_t len, const void *buf)
 	const struct mgmt_ev_local_name_changed *ev = buf;
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Local Name Changed control\n");
+		display_printf("* Malformed Local Name Changed control\n");
 		return;
 	}
 
-	printf("@ Local Name Changed: %s (%s)\n", ev->name, ev->short_name);
+	display_printf("@ Local Name Changed: %s (%s)\n", ev->name,
+				ev->short_name);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -274,7 +277,7 @@ static void mgmt_new_link_key(uint16_t len, const void *buf)
 	};
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed New Link Key control\n");
+		display_printf("* Malformed New Link Key control\n");
 		return;
 	}
 
@@ -285,7 +288,7 @@ static void mgmt_new_link_key(uint16_t len, const void *buf)
 
 	ba2str(&ev->key.addr.bdaddr, str);
 
-	printf("@ New Link Key: %s (%d) %s (%u)\n", str,
+	display_printf("@ New Link Key: %s (%d) %s (%u)\n", str,
 				ev->key.addr.type, type, ev->key.type);
 
 	buf += sizeof(*ev);
@@ -301,7 +304,7 @@ static void mgmt_new_long_term_key(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed New Long Term Key control\n");
+		display_printf("* Malformed New Long Term Key control\n");
 		return;
 	}
 
@@ -335,7 +338,7 @@ static void mgmt_new_long_term_key(uint16_t len, const void *buf)
 
 	ba2str(&ev->key.addr.bdaddr, str);
 
-	printf("@ New Long Term Key: %s (%d) %s 0x%02x\n", str,
+	display_printf("@ New Long Term Key: %s (%d) %s 0x%02x\n", str,
 			ev->key.addr.type, type, ev->key.type);
 
 	buf += sizeof(*ev);
@@ -351,14 +354,14 @@ static void mgmt_device_connected(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Device Connected control\n");
+		display_printf("* Malformed Device Connected control\n");
 		return;
 	}
 
 	flags = le32_to_cpu(ev->flags);
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Connected: %s (%d) flags 0x%4.4x\n",
+	display_printf("@ Device Connected: %s (%d) flags 0x%4.4x\n",
 						str, ev->addr.type, flags);
 
 	buf += sizeof(*ev);
@@ -375,7 +378,7 @@ static void mgmt_device_disconnected(uint16_t len, const void *buf)
 	uint16_t consumed_len;
 
 	if (len < sizeof(struct mgmt_addr_info)) {
-		printf("* Malformed Device Disconnected control\n");
+		display_printf("* Malformed Device Disconnected control\n");
 		return;
 	}
 
@@ -389,7 +392,8 @@ static void mgmt_device_disconnected(uint16_t len, const void *buf)
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Disconnected: %s (%d) reason %u\n", str, ev->addr.type,
+	display_printf("@ Device Disconnected: %s (%d) reason %u\n", str,
+					ev->addr.type,
 									reason);
 
 	buf += consumed_len;
@@ -404,13 +408,13 @@ static void mgmt_connect_failed(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Connect Failed control\n");
+		display_printf("* Malformed Connect Failed control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Connect Failed: %s (%d) status 0x%2.2x\n",
+	display_printf("@ Connect Failed: %s (%d) status 0x%2.2x\n",
 					str, ev->addr.type, ev->status);
 
 	buf += sizeof(*ev);
@@ -425,13 +429,13 @@ static void mgmt_pin_code_request(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed PIN Code Request control\n");
+		display_printf("* Malformed PIN Code Request control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ PIN Code Request: %s (%d) secure 0x%2.2x\n",
+	display_printf("@ PIN Code Request: %s (%d) secure 0x%2.2x\n",
 					str, ev->addr.type, ev->secure);
 
 	buf += sizeof(*ev);
@@ -446,13 +450,15 @@ static void mgmt_user_confirm_request(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed User Confirmation Request control\n");
+		display_printf("* Malformed User Confirmation Request "
+				"control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ User Confirmation Request: %s (%d) hint %d value %d\n",
+	display_printf("@ User Confirmation Request: %s (%d) hint %d "
+			"value %d\n",
 			str, ev->addr.type, ev->confirm_hint, ev->value);
 
 	buf += sizeof(*ev);
@@ -467,13 +473,13 @@ static void mgmt_user_passkey_request(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed User Passkey Request control\n");
+		display_printf("* Malformed User Passkey Request control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ User Passkey Request: %s (%d)\n", str, ev->addr.type);
+	display_printf("@ User Passkey Request: %s (%d)\n", str, ev->addr.type);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -487,13 +493,13 @@ static void mgmt_auth_failed(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Authentication Failed control\n");
+		display_printf("* Malformed Authentication Failed control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Authentication Failed: %s (%d) status 0x%2.2x\n",
+	display_printf("@ Authentication Failed: %s (%d) status 0x%2.2x\n",
 					str, ev->addr.type, ev->status);
 
 	buf += sizeof(*ev);
@@ -509,14 +515,14 @@ static void mgmt_device_found(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Device Found control\n");
+		display_printf("* Malformed Device Found control\n");
 		return;
 	}
 
 	flags = le32_to_cpu(ev->flags);
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Found: %s (%d) rssi %d flags 0x%4.4x\n",
+	display_printf("@ Device Found: %s (%d) rssi %d flags 0x%4.4x\n",
 					str, ev->addr.type, ev->rssi, flags);
 
 	buf += sizeof(*ev);
@@ -530,11 +536,12 @@ static void mgmt_discovering(uint16_t len, const void *buf)
 	const struct mgmt_ev_discovering *ev = buf;
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Discovering control\n");
+		display_printf("* Malformed Discovering control\n");
 		return;
 	}
 
-	printf("@ Discovering: 0x%2.2x (%d)\n", ev->discovering, ev->type);
+	display_printf("@ Discovering: 0x%2.2x (%d)\n", ev->discovering,
+				ev->type);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -548,13 +555,13 @@ static void mgmt_device_blocked(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Device Blocked control\n");
+		display_printf("* Malformed Device Blocked control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Blocked: %s (%d)\n", str, ev->addr.type);
+	display_printf("@ Device Blocked: %s (%d)\n", str, ev->addr.type);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -568,13 +575,13 @@ static void mgmt_device_unblocked(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Device Unblocked control\n");
+		display_printf("* Malformed Device Unblocked control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Unblocked: %s (%d)\n", str, ev->addr.type);
+	display_printf("@ Device Unblocked: %s (%d)\n", str, ev->addr.type);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -588,13 +595,13 @@ static void mgmt_device_unpaired(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Device Unpaired control\n");
+		display_printf("* Malformed Device Unpaired control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Unpaired: %s (%d)\n", str, ev->addr.type);
+	display_printf("@ Device Unpaired: %s (%d)\n", str, ev->addr.type);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -609,7 +616,7 @@ static void mgmt_passkey_notify(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Passkey Notify control\n");
+		display_printf("* Malformed Passkey Notify control\n");
 		return;
 	}
 
@@ -617,7 +624,7 @@ static void mgmt_passkey_notify(uint16_t len, const void *buf)
 
 	passkey = le32_to_cpu(ev->passkey);
 
-	printf("@ Passkey Notify: %s (%d) passkey %06u entered %u\n",
+	display_printf("@ Passkey Notify: %s (%d) passkey %06u entered %u\n",
 				str, ev->addr.type, passkey, ev->entered);
 
 	buf += sizeof(*ev);
@@ -632,14 +639,14 @@ static void mgmt_new_irk(uint16_t len, const void *buf)
 	char addr[18], rpa[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed New IRK control\n");
+		display_printf("* Malformed New IRK control\n");
 		return;
 	}
 
 	ba2str(&ev->rpa, rpa);
 	ba2str(&ev->key.addr.bdaddr, addr);
 
-	printf("@ New IRK: %s (%d) %s\n", addr, ev->key.addr.type, rpa);
+	display_printf("@ New IRK: %s (%d) %s\n", addr, ev->key.addr.type, rpa);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -654,7 +661,7 @@ static void mgmt_new_csrk(uint16_t len, const void *buf)
 	char addr[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed New CSRK control\n");
+		display_printf("* Malformed New CSRK control\n");
 		return;
 	}
 
@@ -678,7 +685,7 @@ static void mgmt_new_csrk(uint16_t len, const void *buf)
 		break;
 	}
 
-	printf("@ New CSRK: %s (%d) %s (%u)\n", addr, ev->key.addr.type,
+	display_printf("@ New CSRK: %s (%d) %s (%u)\n", addr, ev->key.addr.type,
 							type, ev->key.type);
 
 	buf += sizeof(*ev);
@@ -693,13 +700,14 @@ static void mgmt_device_added(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Device Added control\n");
+		display_printf("* Malformed Device Added control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Added: %s (%d) %d\n", str, ev->addr.type, ev->action);
+	display_printf("@ Device Added: %s (%d) %d\n", str, ev->addr.type,
+				ev->action);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -713,13 +721,13 @@ static void mgmt_device_removed(uint16_t len, const void *buf)
 	char str[18];
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Device Removed control\n");
+		display_printf("* Malformed Device Removed control\n");
 		return;
 	}
 
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Removed: %s (%d)\n", str, ev->addr.type);
+	display_printf("@ Device Removed: %s (%d)\n", str, ev->addr.type);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -734,7 +742,8 @@ static void mgmt_new_conn_param(uint16_t len, const void *buf)
 	uint16_t min, max, latency, timeout;
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed New Connection Parameter control\n");
+		display_printf("* Malformed New Connection Parameter "
+				"control\n");
 		return;
 	}
 
@@ -744,7 +753,8 @@ static void mgmt_new_conn_param(uint16_t len, const void *buf)
 	latency = le16_to_cpu(ev->latency);
 	timeout = le16_to_cpu(ev->timeout);
 
-	printf("@ New Conn Param: %s (%d) hint %d min 0x%4.4x max 0x%4.4x "
+	display_printf("@ New Conn Param: %s (%d) hint %d min 0x%4.4x "
+			"max 0x%4.4x "
 		"latency 0x%4.4x timeout 0x%4.4x\n", addr, ev->addr.type,
 		ev->store_hint, min, max, latency, timeout);
 
@@ -759,11 +769,11 @@ static void mgmt_advertising_added(uint16_t len, const void *buf)
 	const struct mgmt_ev_advertising_added *ev = buf;
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Advertising Added control\n");
+		display_printf("* Malformed Advertising Added control\n");
 		return;
 	}
 
-	printf("@ Advertising Added: %u\n", ev->instance);
+	display_printf("@ Advertising Added: %u\n", ev->instance);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -776,11 +786,11 @@ static void mgmt_advertising_removed(uint16_t len, const void *buf)
 	const struct mgmt_ev_advertising_removed *ev = buf;
 
 	if (len < sizeof(*ev)) {
-		printf("* Malformed Advertising Removed control\n");
+		display_printf("* Malformed Advertising Removed control\n");
 		return;
 	}
 
-	printf("@ Advertising Removed: %u\n", ev->instance);
+	display_printf("@ Advertising Removed: %u\n", ev->instance);
 
 	buf += sizeof(*ev);
 	len -= sizeof(*ev);
@@ -894,7 +904,8 @@ void control_message(uint16_t opcode, const void *data, uint16_t size)
 		mgmt_advertising_removed(size, data);
 		break;
 	default:
-		printf("* Unknown control (code %d len %d)\n", opcode, size);
+		display_printf("* Unknown control (code %d len %d)\n", opcode,
+					size);
 		packet_hexdump(data, size);
 		break;
 	}
@@ -1200,7 +1211,7 @@ static void server_accept_callback(int fd, uint32_t events, void *user_data)
 		return;
 	}
 
-	printf("--- New monitor connection ---\n");
+	display_printf("--- New monitor connection ---\n");
 
 	data = malloc(sizeof(*data));
 	if (!data) {
@@ -1339,14 +1350,16 @@ static bool tty_parse_header(uint8_t *hdr, uint8_t len, struct timeval **tv,
 			*tv = ctv;
 			break;
 		default:
-			printf("Unknown extended header type %u\n", type);
+			display_printf("Unknown extended header type %u\n",
+					type);
 			return false;
 		}
 	}
 
 	if (total) {
 		*drops += total;
-		printf("* Drops: cmd %u evt %u acl_tx %u acl_rx %u sco_tx %u "
+		display_printf("* Drops: cmd %u evt %u acl_tx %u acl_rx %u "
+			"sco_tx %u "
 			"sco_rx %u other %u\n", cmd, evt, acl_tx, acl_rx,
 			sco_tx, sco_rx, other);
 	}
@@ -1453,7 +1466,7 @@ int control_tty(const char *path, unsigned int speed)
 		return err;
 	}
 
-	printf("--- %s opened ---\n", path);
+	display_printf("--- %s opened ---\n", path);
 
 	data = malloc(sizeof(*data));
 	if (!data) {
@@ -1510,7 +1523,7 @@ int control_rtt(char *jlink, char *rtt)
 		return -ENODEV;
 	}
 
-	printf("--- RTT opened ---\n");
+	display_printf("--- RTT opened ---\n");
 
 	data = new0(struct control_data, 1);
 	data->channel = HCI_CHANNEL_MONITOR;
diff --git a/monitor/display.c b/monitor/display.c
index d61a79a383f5..f8ece0a3a755 100644
--- a/monitor/display.c
+++ b/monitor/display.c
@@ -15,6 +15,7 @@
 
 #define _GNU_SOURCE
 #include <stdio.h>
+#include <stdarg.h>
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -28,6 +29,25 @@
 #include "display.h"
 
 static pid_t pager_pid = 0;
+static FILE *display_out;
+
+/*
+ * Redirect the decoding output, so that a caller can capture a frame and
+ * decide what to do with it. Passing NULL restores the normal output.
+ */
+void display_set_output(FILE *fp)
+{
+	display_out = fp;
+}
+
+void display_printf(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(display_out ? display_out : stdout, fmt, ap);
+	va_end(ap);
+}
 int default_pager_num_columns = FALLBACK_TERMINAL_WIDTH;
 enum monitor_color setting_monitor_color = COLOR_AUTO;
 
diff --git a/monitor/display.h b/monitor/display.h
index 5f83a9a18273..93773e651ef1 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -12,9 +12,18 @@
 #include <stdbool.h>
 #include <inttypes.h>
 #include <ctype.h>
+#include <stdio.h>
 
 bool use_color(void);
 
+/*
+ * All decoding output goes through here so that it can be captured, for
+ * example to match a whole frame against a query before showing it.
+ */
+void display_printf(const char *fmt, ...)
+			__attribute__((format(printf, 1, 2)));
+void display_set_output(FILE *fp);
+
 enum monitor_color { COLOR_AUTO, COLOR_ALWAYS, COLOR_NEVER };
 void set_monitor_color(enum monitor_color);
 
@@ -44,7 +53,7 @@ void set_monitor_color(enum monitor_color);
 
 #define print_indent(indent, color1, prefix, title, color2, fmt, args...) \
 do { \
-	printf("%*c%s%s%s%s" fmt "%s\n", (indent), ' ', \
+	display_printf("%*c%s%s%s%s" fmt "%s\n", (indent), ' ', \
 		use_color() ? (color1) : "", prefix, title, \
 		use_color() ? (color2) : "", ## args, \
 		use_color() ? COLOR_OFF : ""); \
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 3eaca5bc226b..d94d996010ff 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -443,73 +443,74 @@ static char *mode2str(uint8_t mode)
 
 static void l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl)
 {
-	printf("      %s:",
+	display_printf("      %s:",
 		ctrl & L2CAP_EXT_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
 
 	if (ctrl & L2CAP_EXT_CTRL_FRAME_TYPE) {
-		printf(" %s",
+		display_printf(" %s",
 		supervisory2str((ctrl & L2CAP_EXT_CTRL_SUPERVISE_MASK) >>
 						L2CAP_EXT_CTRL_SUPER_SHIFT));
 
 		if (ctrl & L2CAP_EXT_CTRL_POLL)
-			printf(" P-bit");
+			display_printf(" P-bit");
 	} else {
 		uint8_t sar = (ctrl & L2CAP_EXT_CTRL_SAR_MASK) >>
 						L2CAP_EXT_CTRL_SAR_SHIFT;
-		printf(" %s", sar2str(sar));
+		display_printf(" %s", sar2str(sar));
 		if (sar == L2CAP_SAR_START) {
 			uint16_t len;
 
 			if (!l2cap_frame_get_le16(frame, &len))
 				return;
 
-			printf(" (len %d)", len);
+			display_printf(" (len %d)", len);
 		}
-		printf(" TxSeq %d", (ctrl & L2CAP_EXT_CTRL_TXSEQ_MASK) >>
+		display_printf(" TxSeq %d",
+			(ctrl & L2CAP_EXT_CTRL_TXSEQ_MASK) >>
 						L2CAP_EXT_CTRL_TXSEQ_SHIFT);
 	}
 
-	printf(" ReqSeq %d", (ctrl & L2CAP_EXT_CTRL_REQSEQ_MASK) >>
+	display_printf(" ReqSeq %d", (ctrl & L2CAP_EXT_CTRL_REQSEQ_MASK) >>
 						L2CAP_EXT_CTRL_REQSEQ_SHIFT);
 
 	if (ctrl & L2CAP_EXT_CTRL_FINAL)
-		printf(" F-bit");
+		display_printf(" F-bit");
 }
 
 static void l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl)
 {
-	printf("      %s:",
+	display_printf("      %s:",
 			ctrl & L2CAP_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
 
 	if (ctrl & 0x01) {
-		printf(" %s",
+		display_printf(" %s",
 			supervisory2str((ctrl & L2CAP_CTRL_SUPERVISE_MASK) >>
 						L2CAP_CTRL_SUPER_SHIFT));
 
 		if (ctrl & L2CAP_CTRL_POLL)
-			printf(" P-bit");
+			display_printf(" P-bit");
 	} else {
 		uint8_t sar;
 
 		sar = (ctrl & L2CAP_CTRL_SAR_MASK) >> L2CAP_CTRL_SAR_SHIFT;
-		printf(" %s", sar2str(sar));
+		display_printf(" %s", sar2str(sar));
 		if (sar == L2CAP_SAR_START) {
 			uint16_t len;
 
 			if (!l2cap_frame_get_le16(frame, &len))
 				return;
 
-			printf(" (len %d)", len);
+			display_printf(" (len %d)", len);
 		}
-		printf(" TxSeq %d", (ctrl & L2CAP_CTRL_TXSEQ_MASK) >>
+		display_printf(" TxSeq %d", (ctrl & L2CAP_CTRL_TXSEQ_MASK) >>
 						L2CAP_CTRL_TXSEQ_SHIFT);
 	}
 
-	printf(" ReqSeq %d", (ctrl & L2CAP_CTRL_REQSEQ_MASK) >>
+	display_printf(" ReqSeq %d", (ctrl & L2CAP_CTRL_REQSEQ_MASK) >>
 						L2CAP_CTRL_REQSEQ_SHIFT);
 
 	if (ctrl & L2CAP_CTRL_FINAL)
-		printf(" F-bit");
+		display_printf(" F-bit");
 }
 
 #define MAX_INDEX 16
@@ -2732,7 +2733,7 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 				l2cap_ctrl_parse(&frame, ctrl16);
 			}
 
-			printf("\n");
+			display_printf("\n");
 			break;
 		}
 
diff --git a/monitor/lmp.c b/monitor/lmp.c
index d415699e4607..f58dde13de87 100644
--- a/monitor/lmp.c
+++ b/monitor/lmp.c
@@ -913,12 +913,12 @@ void lmp_todo(void)
 {
 	int i;
 
-	printf("LMP operations with missing decodings:\n");
+	display_printf("LMP operations with missing decodings:\n");
 
 	for (i = 0; lmp_table[i].str; i++) {
 		if (lmp_table[i].func)
 			continue;
 
-		printf("\t%s\n", lmp_table[i].str);
+		display_printf("\t%s\n", lmp_table[i].str);
 	}
 }
diff --git a/monitor/main.c b/monitor/main.c
index cc947af1ffc4..dc37294c5c27 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -44,10 +44,10 @@ static void signal_callback(int signum, void *user_data)
 
 static void usage(void)
 {
-	printf("btmon - Bluetooth monitor\n"
+	display_printf("btmon - Bluetooth monitor\n"
 		"Usage:\n");
-	printf("\tbtmon [options]\n");
-	printf("options:\n"
+	display_printf("\tbtmon [options]\n");
+	display_printf("options:\n"
 		"\t-r, --read <file>      Read traces in btsnoop format\n"
 		"\t-w, --write <file>     Save traces in btsnoop format\n"
 		"\t-a, --analyze <file>   Analyze traces in btsnoop format\n"
@@ -244,7 +244,7 @@ int main(int argc, char *argv[])
 			lmp_todo();
 			return EXIT_SUCCESS;
 		case 'v':
-			printf("%s\n", VERSION);
+			display_printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
 		case 'h':
 			usage();
@@ -264,7 +264,7 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	printf("Bluetooth monitor ver %s\n", VERSION);
+	display_printf("Bluetooth monitor ver %s\n", VERSION);
 
 	keys_setup();
 
@@ -284,7 +284,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (writer_path && !control_writer(writer_path)) {
-		printf("Failed to open '%s'\n", writer_path);
+		display_printf("Failed to open '%s'\n", writer_path);
 		return EXIT_FAILURE;
 	}
 
diff --git a/monitor/packet.c b/monitor/packet.c
index 3ee53c2340a5..4db80dc1b0fe 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -709,7 +709,7 @@ void packet_select_index(uint16_t index)
 	index_filter = true;
 }
 
-#define print_space(x) printf("%*c", (x), ' ');
+#define print_space(x) display_printf("%*c", (x), ' ')
 
 void packet_set_fallback_manufacturer(uint16_t manufacturer)
 {
@@ -919,12 +919,13 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 	}
 
 	if (ts_len > 0) {
-		printf("%s", line);
+		display_printf("%s", line);
 		if (len < col)
 			print_space(col - len - ts_len - 1);
-		printf("%s%s\n", use_color() ? COLOR_TIMESTAMP : "", ts_str);
+		display_printf("%s%s\n", use_color() ? COLOR_TIMESTAMP : "",
+				ts_str);
 	} else
-		printf("%s\n", line);
+		display_printf("%s\n", line);
 }
 
 static const struct {
@@ -18654,7 +18655,7 @@ void packet_todo(void)
 {
 	int i;
 
-	printf("HCI commands with missing decodings:\n");
+	display_printf("HCI commands with missing decodings:\n");
 
 	for (i = 0; opcode_table[i].str; i++) {
 		if (opcode_table[i].bit < 0)
@@ -18663,22 +18664,22 @@ void packet_todo(void)
 		if (opcode_table[i].cmd_func)
 			continue;
 
-		printf("\t%s\n", opcode_table[i].str);
+		display_printf("\t%s\n", opcode_table[i].str);
 	}
 
-	printf("HCI events with missing decodings:\n");
+	display_printf("HCI events with missing decodings:\n");
 
 	for (i = 0; event_table[i].str; i++) {
 		if (event_table[i].func)
 			continue;
 
-		printf("\t%s\n", event_table[i].str);
+		display_printf("\t%s\n", event_table[i].str);
 	}
 
 	for (i = 0; le_meta_event_table[i].str; i++) {
 		if (le_meta_event_table[i].func)
 			continue;
 
-		printf("\t%s\n", le_meta_event_table[i].str);
+		display_printf("\t%s\n", le_meta_event_table[i].str);
 	}
 }
diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index b03f44fe90c9..4199101275a2 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -139,15 +139,15 @@ static inline bool mcc_test(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
 	uint8_t data;
 
-	printf("%*cTest Data: 0x ", indent, ' ');
+	display_printf("%*cTest Data: 0x ", indent, ' ');
 
 	while (frame->size > 1) {
 		if (!l2cap_frame_get_u8(frame, &data))
 			return false;
-		printf("%2.2x ", data);
+		display_printf("%2.2x ", data);
 	}
 
-	printf("\n");
+	display_printf("\n");
 	return true;
 }
 
diff --git a/tools/l2test.c b/tools/l2test.c
index 08d2269936b9..2e2606db13b9 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -16,6 +16,7 @@
 
 #define _GNU_SOURCE
 #include <stdio.h>
+#include <stdarg.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <ctype.h>
@@ -334,6 +335,15 @@ bool use_color(void)
 	return false;
 }
 
+void display_printf(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vprintf(fmt, ap);
+	va_end(ap);
+}
+
 static const struct bitfield_data phy_table[] = {
 	{  0, "BR1M1SLOT" },
 	{  1, "BR1M3SLOT" },
-- 
2.55.0


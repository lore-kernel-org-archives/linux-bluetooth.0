Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997F2D3ED9
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533015; cv=none; b=jP0jhJkFGaLt6O4iZy4/vbMi/XCrQwEgHF5tKjitX6eNlKt6/uowUEMuC+pFMPboH7CRQJv3HTSRYZ18AGzypeCtPx3qH5QiTtxN6gt7p7YMBhoRksMc2mwX+2LKn3N2bSRKUahZuS+HZ3o8++zEoBZhEqp/rPrLzFCSNKTcbB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533015; c=relaxed/simple;
	bh=qOHzU+5RcHHpZ5U2OijXc9k2/gxdN/Ll1dwbeby6VR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwoycOYctQf0LKbw3NDInfXvMEd3C90JMfHzV96J+78nSrIZOfmZL+83ts5oGkWyXaXkYWHfzCkBQK9JD4tJr8TANBeg19GaikcUQu6TyYZI37S9QAygiAlhEc/cX+AwbeAWjNuI0IzXZppBzIDzrPjdDlF81m/p7MMRf4tZP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B7804318D;
	Thu,  3 Jul 2025 08:56:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 10/19] monitor: Fix typos
Date: Thu,  3 Jul 2025 10:53:18 +0200
Message-ID: <20250703085630.935452-11-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Found using codespell.
---
 monitor/analyze.c |  4 ++--
 monitor/att.c     |  8 ++++----
 monitor/avctp.c   |  6 +++---
 monitor/btmon.rst |  6 +++---
 monitor/l2cap.c   |  2 +-
 monitor/ll.c      | 10 +++++-----
 monitor/msft.c    |  2 +-
 monitor/packet.c  | 10 +++++-----
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 3cc482cd9227..c466ff3ca85d 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -112,7 +112,7 @@ static void tmp_write(void *data, void *user_data)
 	fprintf(tmp, "%lld %zu\n", plot->x_msec, plot->y_count);
 }
 
-static void plot_draw(struct queue *queue, const char *tittle)
+static void plot_draw(struct queue *queue, const char *title)
 {
 	FILE *gplot;
 
@@ -132,7 +132,7 @@ static void plot_draw(struct queue *queue, const char *tittle)
 	fprintf(gplot, "set tics out nomirror\n");
 	fprintf(gplot, "set log y\n");
 	fprintf(gplot, "set yrange [0.5:*]\n");
-	fprintf(gplot, "plot $data using 1:2 t '%s' w impulses\n", tittle);
+	fprintf(gplot, "plot $data using 1:2 t '%s' w impulses\n", title);
 	fflush(gplot);
 
 	pclose(gplot);
diff --git a/monitor/att.c b/monitor/att.c
index e5630f0e7d32..33d45e960bec 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1133,9 +1133,9 @@ static bool print_prefer_framing(const struct l2cap_frame *frame)
 }
 
 static const struct bitfield_data prefer_phy_table[] = {
-	{  0, "LE 1M PHY preffered (0x01)"		},
-	{  1, "LE 2M PHY preffered (0x02)"		},
-	{  2, "LE Codec PHY preffered (0x04)"		},
+	{  0, "LE 1M PHY preferred (0x01)"		},
+	{  1, "LE 2M PHY preferred (0x02)"		},
+	{  2, "LE Codec PHY preferred (0x04)"		},
 	{ }
 };
 
@@ -2293,7 +2293,7 @@ static void print_vcs_flag(const struct l2cap_frame *frame)
 		print_text(COLOR_ERROR, "Volume Flag: invalid size");
 		goto done;
 	}
-	print_field("    Volume Falg: %u", vol_flag);
+	print_field("    Volume Flag: %u", vol_flag);
 
 done:
 	if (frame->size)
diff --git a/monitor/avctp.c b/monitor/avctp.c
index 4da448750be5..fda7ff1ffef6 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1317,13 +1317,13 @@ static bool avrcp_get_play_status(struct avctp_frame *avctp_frame,
 	if (!l2cap_frame_get_be32(frame, &interval))
 		return false;
 
-	print_field("%*cSongLength: 0x%08x (%u miliseconds)",
+	print_field("%*cSongLength: 0x%08x (%u milliseconds)",
 					(indent - 8), ' ', interval, interval);
 
 	if (!l2cap_frame_get_be32(frame, &interval))
 		return false;
 
-	print_field("%*cSongPosition: 0x%08x (%u miliseconds)",
+	print_field("%*cSongPosition: 0x%08x (%u milliseconds)",
 					(indent - 8), ' ', interval, interval);
 
 	if (!l2cap_frame_get_u8(frame, &status))
@@ -1388,7 +1388,7 @@ response:
 		if (!l2cap_frame_get_be32(frame, &interval))
 			return false;
 
-		print_field("%*cPosition: 0x%08x (%u miliseconds)",
+		print_field("%*cPosition: 0x%08x (%u milliseconds)",
 					(indent - 8), ' ', interval, interval);
 		break;
 	case AVRCP_EVENT_BATT_STATUS_CHANGED:
diff --git a/monitor/btmon.rst b/monitor/btmon.rst
index 31970d4fba95..eb5e25182f0f 100644
--- a/monitor/btmon.rst
+++ b/monitor/btmon.rst
@@ -15,7 +15,7 @@ Bluetooth monitor
 :Manual section: 1
 :Manual group: Linux System Administration
 
-SYNOPSYS
+SYNOPSIS
 ========
 
 **btmon** [*OPTIONS* ...]
@@ -91,7 +91,7 @@ OPTIONS
 -P, --no-pager              Disable pager usage while reading the log file.
 
 -J OPTIONS, --jlink OPTIONS     Read data from RTT.  Each options are comma(,)
-                                seprated without spaces.
+                                separated without spaces.
 
 .. list-table::
    :header-rows: 1
@@ -114,7 +114,7 @@ OPTIONS
      - (Optional) Set target interface speed in kHz. Default is **1000**.
 
 -R OPTIONS, --rtt OPTIONS   RTT control block parameters. Each options are
-                            comma(,) seprated without spaces.
+                            comma(,) separated without spaces.
 
 .. list-table::
    :header-rows: 1
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index dff183bd0972..8c47f8c89674 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2283,7 +2283,7 @@ static void smp_pairing_confirm(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_smp_pairing_confirm *pdu = frame->data;
 
-	print_hex_field("Confim value", pdu->value, 16);
+	print_hex_field("Confirm value", pdu->value, 16);
 }
 
 static void smp_pairing_random(const struct l2cap_frame *frame)
diff --git a/monitor/ll.c b/monitor/ll.c
index feeb13e9282a..34dddcb0bb74 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -144,7 +144,7 @@ static void advertising_packet(const void *data, uint8_t size)
 		}
 
 		packet_print_addr("Advertiser address", data + 2, tx_add);
-		packet_print_addr("Inititator address", data + 8, rx_add);
+		packet_print_addr("Initiator address", data + 8, rx_add);
 		break;
 
 	case 0x03:	/* SCAN_REQ */
@@ -165,7 +165,7 @@ static void advertising_packet(const void *data, uint8_t size)
 			return;
 		}
 
-		packet_print_addr("Inititator address", data + 2, tx_add);
+		packet_print_addr("Initiator address", data + 2, tx_add);
 		packet_print_addr("Advertiser address", data + 8, rx_add);
 
 		access_addr = ptr[14] | ptr[15] << 8 |
@@ -256,7 +256,7 @@ static void data_packet(const void *data, uint8_t size, bool padded)
 	switch (llid) {
 	case 0x01:
 		if (length > 0)
-			str = "Continuation fragement of L2CAP message";
+			str = "Continuation fragment of L2CAP message";
 		else
 			str = "Empty message";
 		break;
@@ -469,7 +469,7 @@ static void conn_param_req(const void *data, uint8_t size)
 	print_field("Latency: %d (0x%4.4x)", pdu->latency, pdu->latency);
 	print_field("Timeout: %d msec (0x%4.4x)", pdu->timeout * 10,
 								pdu->timeout);
-	print_field("Preffered periodicity: %.2f (0x%2.2x)",
+	print_field("Preferred periodicity: %.2f (0x%2.2x)",
 				pdu->pref_period * 1.25, pdu->pref_period);
 	print_field("Reference connection event count: %d (0x%2.2x)",
 			pdu->pref_conn_evt_count, pdu->pref_conn_evt_count);
@@ -498,7 +498,7 @@ static void conn_param_rsp(const void *data, uint8_t size)
 	print_field("Latency: %d (0x%4.4x)", pdu->latency, pdu->latency);
 	print_field("Timeout: %d msec (0x%4.4x)", pdu->timeout * 10,
 								pdu->timeout);
-	print_field("Preffered periodicity: %.2f (0x%2.2x)",
+	print_field("Preferred periodicity: %.2f (0x%2.2x)",
 				pdu->pref_period * 1.25, pdu->pref_period);
 	print_field("Reference connection event count: %d (0x%2.2x)",
 			pdu->pref_conn_evt_count, pdu->pref_conn_evt_count);
diff --git a/monitor/msft.c b/monitor/msft.c
index 096fedd59317..24b7bd55444c 100644
--- a/monitor/msft.c
+++ b/monitor/msft.c
@@ -147,7 +147,7 @@ static void le_monitor_advertisement_cmd(const void *data, uint16_t size)
 		packet_hexdump(irk->irk, size - sizeof(*cmd));
 		break;
 	case MSFT_LE_MONITOR_ADV_ADDR:
-		print_field("Type: Adderss (0x%2.2x)", cmd->type);
+		print_field("Type: Address (0x%2.2x)", cmd->type);
 		addr = (void *)cmd->data;
 		packet_print_addr(NULL, addr->addr, addr->type);
 		break;
diff --git a/monitor/packet.c b/monitor/packet.c
index f4981730ac4a..21df067b19ce 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3184,7 +3184,7 @@ static const struct bitfield_data events_le_table[] = {
 	{ 25, "LE CIS Request"				},
 	{ 26, "LE Create BIG Complete"			},
 	{ 27, "LE Terminate BIG Complete"		},
-	{ 28, "LE BIG Sync Estabilished Complete"	},
+	{ 28, "LE BIG Sync Established Complete"	},
 	{ 29, "LE BIG Sync Lost"			},
 	{ 30, "LE Request Peer SCA Complete"},
 	{ 31, "LE Path Loss Threshold"		},
@@ -3486,7 +3486,7 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 		goto done;
 
 	/* Level 1 - BASE */
-	print_field("  Presetation Delay: %u", get_le24(base_data->pd));
+	print_field("  Presentation Delay: %u", get_le24(base_data->pd));
 	print_field("  Number of Subgroups: %u", base_data->num_subgroups);
 
 	/* Level 2 - Subgroups*/
@@ -9776,7 +9776,7 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x043b, 174, "Logical Link Cancel",
 				logic_link_cancel_cmd, 2, true,
 				logic_link_cancel_rsp, 3, true },
-	{ 0x043c, 175, "Flow Specifcation Modify",
+	{ 0x043c, 175, "Flow Specification Modify",
 				flow_spec_modify_cmd, 34, true },
 	{ 0x043d, 235, "Enhanced Setup Synchronous Connection",
 				enhanced_setup_sync_conn_cmd, 59, true },
@@ -11599,7 +11599,7 @@ static void keypress_notify_evt(struct timeval *tv, uint16_t index,
 		str = "Passkey digit erased";
 		break;
 	case 0x03:
-		str = "Passkey clared";
+		str = "Passkey cleared";
 		break;
 	case 0x04:
 		str = "Passkey entry completed";
@@ -13290,7 +13290,7 @@ static const struct subevent_data le_meta_event_table[] = {
 				sizeof(struct bt_hci_evt_le_big_terminate) },
 	{ BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
 				"LE Broadcast Isochronous Group Sync "
-				"Estabilished", le_big_sync_estabilished_evt,
+				"Established", le_big_sync_estabilished_evt,
 				sizeof(struct bt_hci_evt_le_big_sync_lost) },
 	{ BT_HCI_EVT_LE_BIG_SYNC_LOST,
 				"LE Broadcast Isochronous Group Sync Lost",
-- 
2.50.0


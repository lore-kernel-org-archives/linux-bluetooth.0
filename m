Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F839BFF1
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978535; cv=none; b=IcLHFKyxT4aLacIgbguogY1HWE9gZXR0bPLiBMJ3DKUmPqVqSITx+BcD8iUfjFPurMtoLhZd0bNx49tzNvcUuexyU581m7MGFN4PpKIdiEWE0/QCQ6SGO0FBM/l0p9o+OY5k8e+ANUilj5X1vIwtnlQ6NJ1E2RZBxtfxNkp013U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978535; c=relaxed/simple;
	bh=loVr2GqN8okSvbtm9rafvQBXLYO6UGOmXyPhwcbOgb8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7Uh/y2vuxoC9MthkUOQ+Bx/4unCrK3tvKMPW72WhCXNZDssTlWS7yKijZVXXhi0s7wYlORy77YcSuU9Lx1IywZMLpjPiIRTZGerfs3EH0ldHBTpx1NdczQUkBUwuE1iV0yFGlL0K5Y66S67drw/S9Kc4lmXqZ5mU5ORHrFLCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv3ujncq; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv3ujncq"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5292fdso507438e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978532; x=1789583332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iq6ZNELDPa4/88Wb9ltXpcSKlDox+M1CjSwNB4AjsQY=;
        b=hv3ujncqdPtEm/D2hjpdS0Zg5SCmmwZLtKLgEJFUaVcUcvDQxts6IAq4ikWgB3zG2a
         FfQv28yUWbzBBPRzlHRF2LwOu5qKV8wdNXWLGiig6CSSLvM4J5u92HFst7DOlMc8WP4j
         QEWAlmd7UmzPDpD18oTjYHiWLFzSrXJRLG2TrscsW3wPOTWVaMSY0aVN05tQYH3KnCeR
         OSsTy7t+3yu83OQ3Pc4ufjzWyqEgNDbw2MK/fjofDaLyvBBAysxX5C2lp/jQ/Ta9X+KZ
         /MJWZpf3dLE/uyMcExd9Eeyv80TPWnTMCuPcYf5T3rai6h5hE1bSXsqqX/ctYHVqscnC
         3Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978532; x=1789583332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iq6ZNELDPa4/88Wb9ltXpcSKlDox+M1CjSwNB4AjsQY=;
        b=QNh3Qt8UtZmuKE5nwBW5eSS2U1oCrU8SauWed1HBkt2EC1MToqjffQzv+f6T66TyxR
         osYdr/L2k6l2lL2Apbb7JfrkoTWoZjwaWm9h7YArLN5sQR/XqfYpQ4UVl4qhB5+fTZ5I
         aQyNhQi3HinW8qz8ahhiDhXrHSip8fFNBVVURlWYex1jMG19axrCRyoU1bEaIr41qoCA
         IjU4Ig/hhsOD/dDVUQMsUse0Qa1Gdr0PjKGsGsmCKAihZoXWu9vJepiyDyO8gwbkobT6
         HgUhcxQ80mEoEAoeFSBmcdmx8HxvtDBEOxvqP0jsZ6DEdxvDNtCRY0WkJHFvZgRRgHzz
         C5kg==
X-Gm-Message-State: AFuF++my0Boh2jViqi2gtxjS64Ybx/oEuerkszi1/v92BqsbYwZVjaC5
	zZ3lGuuw8xteBNb+6XKbOvUkD+zaJDw7TKfpb58mEWjpINVPTo8PFf8z2FQUa4ab
X-Gm-Gg: AYBFou21Me7fF1N4H2Wh9MCfzqYGpAGLB1oZACwLd3sv9kgBEHVC7DBTL0POnMXLFIt
	IvzoOz4JUJF8Uv+KmwzCA6ta3Rv0PMYVIqkVchjLOfChPlVcXJLGdPYE1zTEGKS1ONeIhjJwRNb
	wUid3Oi6Gc6kaE+547+o0HjibJWvO8R3GiUtPoGx3kt+7sKjysYKBJ1FL5DgOlO6qB/YxDbTVU4
	0+ESFXGHarcq6pjmBjzNV5zbxrwsnkH68YrhZnaZ0Whc1ZOcdTJ1GLneVF4fPCf/BLRid8Cm+Gl
	mBWGwhPUx1jFeYiCM9iE2rsUMEEJ7VFBoEwJX8tmm6BKXXN/3azKPstoEL3VEGHq0g7uxql7nyd
	qa0y2k5JFtrNCTUlZEq5NDZ/j4dA0yvnuu5UiEyvWVCHrfQZFiKhW62zSxYwvzmxbObOOYGIm/4
	tjkiy6q9XHWEw2mSa0rdDM64OrtKlb/4tCGgKAX5U25P2XCEASjnY7S+WeEWI/sqviz869tLlzD
	mGFlb+BXV+YYqFIUMpfLKtXsQ6APlhtm8A1d9qZhXR1VJ3sGlOFh/kP1HRa5tB/Ew==
X-Received: by 2002:a05:6122:218d:b0:5c1:781:7122 with SMTP id 71dfb90a1353d-5c828781f00mr4030101e0c.3.1788978531914;
        Wed, 09 Sep 2026 11:28:51 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 01/10] monitor: Reference the request frame on command responses
Date: Wed,  9 Sep 2026 14:28:31 -0400
Message-ID: <20260909182840.1289776-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909182840.1289776-1-luiz.dentz@gmail.com>
References: <20260909182840.1289776-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Correlating a Command Complete or a Command Status with the command it
responds to means scrolling back through the trace to find the matching
opcode, and the time the controller took to respond is not visible at all
without comparing timestamps by hand.

Keep the frame number and the timestamp of each command that has not been
answered yet, and append both to the opcode line of the response, so that
a slow command is obvious at the point where it completes:

  < HCI Command: LE Set Random Address (0x08|0x0005) plen 6 #76 [hci0] 3.175055
          Address: 00:11:22:33:44:55 (Non-Resolvable)
  > HCI Event: Command Complete (0x0e) plen 4               #77 [hci0] 3.175394
        LE Set Random Address (0x08|0x0005) ncmd 1 #76 (0.339 msec)
          Status: Success (0x00)

Several commands may be outstanding at once and they need not complete in
order, so entries are matched on the opcode and the oldest one is taken.
Nothing is printed when the request was not captured, which is the normal
case when attaching to a system that is already running. The queue is
bounded so commands that never get a response cannot pile up, and it is
released when the index goes away.

The model wrote the tracking and the matching, which the author reviewed
and verified against traces covering out of order completion, a response
without a request and sub-millisecond deltas.

Assisted-by: opencode:claude-opus-5
---
 monitor/packet.c | 108 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index db52eb789629..2b238e550b58 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -147,6 +147,7 @@ struct index_data {
 	uint8_t  msft_evt_prefix[8];
 	uint8_t  msft_evt_len;
 	size_t   frame;
+	struct queue *cmd_q;
 	struct index_buf_pool acl;
 	struct index_buf_pool sco;
 	struct index_buf_pool le;
@@ -155,6 +156,85 @@ struct index_data {
 
 static struct index_data index_list[MAX_INDEX];
 
+/*
+ * Commands awaiting a Command Complete or a Command Status, so that the
+ * response can point back at the frame that carried the request.
+ */
+struct pending_cmd {
+	uint16_t opcode;
+	size_t frame;
+	struct timeval tv;
+};
+
+/* Bound the queue so commands that never get a response cannot pile up */
+#define PENDING_CMD_MAX 64
+
+static bool match_pending_cmd(const void *data, const void *user_data)
+{
+	const struct pending_cmd *cmd = data;
+
+	return cmd->opcode == PTR_TO_UINT(user_data);
+}
+
+static void pending_cmd_enqueue(uint16_t index, uint16_t opcode,
+						struct timeval *tv)
+{
+	struct index_data *ctrl = &index_list[index];
+	struct pending_cmd *cmd;
+
+	if (!ctrl->cmd_q)
+		ctrl->cmd_q = queue_new();
+
+	if (queue_length(ctrl->cmd_q) >= PENDING_CMD_MAX)
+		free(queue_pop_head(ctrl->cmd_q));
+
+	cmd = new0(struct pending_cmd, 1);
+	cmd->opcode = opcode;
+	cmd->frame = ctrl->frame;
+	if (tv)
+		cmd->tv = *tv;
+
+	queue_push_tail(ctrl->cmd_q, cmd);
+}
+
+/*
+ * Format the request reference for a response, as the frame number of the
+ * command and the time elapsed since it was sent. Leaves the string empty
+ * when the request was not seen, which is the normal case for a capture
+ * started while commands were already in flight.
+ */
+static void pending_cmd_str(uint16_t index, uint16_t opcode,
+				struct timeval *tv, char *str, size_t len)
+{
+	struct pending_cmd *cmd;
+	struct timeval delta;
+
+	str[0] = '\0';
+
+	if (index >= MAX_INDEX)
+		return;
+
+	/*
+	 * Several commands may be outstanding at once and they need not
+	 * complete in order, so match on the opcode and take the oldest.
+	 */
+	cmd = queue_remove_if(index_list[index].cmd_q, match_pending_cmd,
+							UINT_TO_PTR(opcode));
+	if (!cmd)
+		return;
+
+	if (tv && timerisset(&cmd->tv)) {
+		timersub(tv, &cmd->tv, &delta);
+		snprintf(str, len, " #%zu (%lld.%03lld msec)", cmd->frame,
+				(long long)delta.tv_sec * 1000 +
+						delta.tv_usec / 1000,
+				(long long)delta.tv_usec % 1000);
+	} else
+		snprintf(str, len, " #%zu", cmd->frame);
+
+	free(cmd);
+}
+
 static void assign_ctrl(uint32_t cookie, uint16_t format, const char *name)
 {
 	int i;
@@ -11357,9 +11437,11 @@ static void cmd_complete_evt(struct timeval *tv, uint16_t index,
 	struct opcode_data vendor_data;
 	const struct opcode_data *opcode_data = NULL;
 	const char *opcode_color, *opcode_str;
-	char vendor_str[150];
+	char vendor_str[150], req_str[32];
 	int i;
 
+	pending_cmd_str(index, opcode, tv, req_str, sizeof(req_str));
+
 	for (i = 0; opcode_table[i].str; i++) {
 		if (opcode_table[i].opcode == opcode) {
 			opcode_data = &opcode_table[i];
@@ -11408,7 +11490,8 @@ static void cmd_complete_evt(struct timeval *tv, uint16_t index,
 	}
 
 	print_indent(6, opcode_color, "", opcode_str, COLOR_OFF,
-			" (0x%2.2x|0x%4.4x) ncmd %d", ogf, ocf, evt->ncmd);
+			" (0x%2.2x|0x%4.4x) ncmd %d%s", ogf, ocf, evt->ncmd,
+			req_str);
 
 	if (!opcode_data || !opcode_data->rsp_func) {
 		if (size > 3) {
@@ -11453,9 +11536,11 @@ static void cmd_status_evt(struct timeval *tv, uint16_t index,
 	uint16_t ocf = cmd_opcode_ocf(opcode);
 	const struct opcode_data *opcode_data = NULL;
 	const char *opcode_color, *opcode_str;
-	char vendor_str[150];
+	char vendor_str[150], req_str[32];
 	int i;
 
+	pending_cmd_str(index, opcode, tv, req_str, sizeof(req_str));
+
 	for (i = 0; opcode_table[i].str; i++) {
 		if (opcode_table[i].opcode == opcode) {
 			opcode_data = &opcode_table[i];
@@ -11492,7 +11577,8 @@ static void cmd_status_evt(struct timeval *tv, uint16_t index,
 	}
 
 	print_indent(6, opcode_color, "", opcode_str, COLOR_OFF,
-			" (0x%2.2x|0x%4.4x) ncmd %d", ogf, ocf, evt->ncmd);
+			" (0x%2.2x|0x%4.4x) ncmd %d%s", ogf, ocf, evt->ncmd,
+			req_str);
 
 	print_status(evt->status);
 }
@@ -14086,6 +14172,11 @@ void packet_del_index(struct timeval *tv, uint16_t index, const char *label)
 {
 	print_packet(tv, NULL, '=', index, NULL, COLOR_DEL_INDEX,
 					"Delete Index", label, NULL);
+
+	if (index < MAX_INDEX) {
+		queue_destroy(index_list[index].cmd_q, free);
+		index_list[index].cmd_q = NULL;
+	}
 }
 
 void packet_open_index(struct timeval *tv, uint16_t index, const char *label)
@@ -14098,6 +14189,11 @@ void packet_close_index(struct timeval *tv, uint16_t index, const char *label)
 {
 	print_packet(tv, NULL, '=', index, NULL, COLOR_CLOSE_INDEX,
 					"Close Index", label, NULL);
+
+	if (index < MAX_INDEX) {
+		queue_destroy(index_list[index].cmd_q, free);
+		index_list[index].cmd_q = NULL;
+	}
 }
 
 void packet_index_info(struct timeval *tv, uint16_t index, const char *label,
@@ -14249,6 +14345,10 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 	data += HCI_COMMAND_HDR_SIZE;
 	size -= HCI_COMMAND_HDR_SIZE;
 
+	/* NOP carries no request and is only used to update ncmd */
+	if (opcode != BT_HCI_CMD_NOP)
+		pending_cmd_enqueue(index, opcode, tv);
+
 	for (i = 0; opcode_table[i].str; i++) {
 		if (opcode_table[i].opcode == opcode) {
 			opcode_data = &opcode_table[i];
-- 
2.55.0


Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8B37F33E
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978537; cv=none; b=BnGJdhw+c6rL6LrCr8fxyEB65gqhIewR2wOEY5zHD3DAoxNlfU9eKMUuRwUSe5Aby7+NR4nuumbSaSnlDMmTbx1q0trpdnV4qR/bDe8CEj5l+GLprqtbyVImvLrrYoDSzek/d+MpKchXGvY/TQuomhETJBRkznHbL37WD1hIMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978537; c=relaxed/simple;
	bh=zKjPDS7+NPVPm52IaABCfomnoEl5tT11Yw5M6Yd1YN4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWhZAg5F5LupX+GoGkWFoUsQwHykHllqMCHjGtFmq6VA5LeTlu/PTJfrqsk0P7NXJ2WwqtUWTaHVrwIDKHuZmLtD8R1UdNNBaxhjRKCv7lGUPY7HeQxkrMxjhXHQslARrDd+zKZdOEQ48iCdJM+hY3+L5grlUtMuaIl3X7kc+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2UYa+7u; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2UYa+7u"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c83364233eso445353e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978534; x=1789583334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k8WEMNAEmvvav3SAmsACOxE+yLgq/Xm4QY8SjF/LcHs=;
        b=j2UYa+7ulzKekp5XxKHcU7UBgR33Z4BT3rQHrgjL9jrb0WEj+jYRCgozSaJhrMxO/n
         fgcHrBanucLi0bZb7P81Z6BiZbgTGIlNZV3iqzXdA26NS+klDVl2VDP2TRMX2p316Fi3
         HU3TaTHQvDmx0cmY6Nwj+ncacHkNvzsRFibMfLz8ObZPNcN4ZgTIdNqd5jLj/xDFfmvT
         UAOvW3rkExWq7YqZDhvn0jRGenTavzhWkApe18aG1dnJaws32Af13K8eJwI0dywtXUp7
         seb67Et85rS6pIuPJYNj84XiBpeaIWMemHs49ZR35nPVdp3ifdKell+WwZwH4RbToY/m
         j/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978534; x=1789583334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k8WEMNAEmvvav3SAmsACOxE+yLgq/Xm4QY8SjF/LcHs=;
        b=sCPM6jal6sEuRhFJQ3gHBHBnnb+iIakqkX5mnkGqSlYFVPhcEScZIi+9FYmbHRgrfN
         xW6eJo+Zn7+b2RDI3b7A07dQjDIA1ObKsMMLYY5LXJSPVgQwR3vogE66X2cfchazOR9S
         Ex14gVCZZcOwfcrdZqH4yo4Y9q3MOb7NaQQxPD8MauTd2huq12dN4ACD3okitIyuRiRR
         v+rJHbQFyVki4jlpVu+3Bdb1cntS2cfHiO6kus3EfKoHu/2UYiiGaAPNMKkPf6VCI/GY
         geWwNXK4RbpCUw+g1gnelFIuwTU5ec/Nm7VQYuit2h6Ql3DZv1Hq/g0gIFMV5XLySetj
         5aXg==
X-Gm-Message-State: AFuF++nnImA75wlSQgEosr6jDRCHRDNNkQ0Gpad2pQe4tgl6pR+KND4F
	fWU9zFoW+nCsuTInbD1AmB/gYdtOCPJfYZ0C575I3noC7jar5VxBU/kLpVM5rOba
X-Gm-Gg: AYBFou2ZjCOA8ff775tEKUAHx0WGnx/sR3uI1JNyIrBMqduClMSOAZVdpCn1cP1H30T
	djUhYxwUe+f/5abCBm9pN91lSTD+DyjdVE1iFcuHGALi+hSDy+p8hwpdn3mnxo/RrcAq1qhosyh
	lrJ3EAEVR9W9kGkP+Y8REY4lhXsb2rYXbARGcpQQlkxkMCis3T6F0XtFQQmqnO8I6dvRPShAaF6
	RBXS/fb8YCeBHbgzERos/g8YgkUvS43lEbL5UURclakD+1GYAU+3KwZaUrswNsrC7QUhp7GnY+P
	jGMk4ZblbNiDYAqgC71KQk+LcLDcuuuxpC1eqdzoLJ4n8dovnYEiVZKGO9bcxpTMvMFNH7OEECl
	kKpCQQnnl+NTG5DT+i4944pkbiy8mR2a4jhrBdsw18m8HIToj+QSoUyf0oylOcBJfQv4Gl9ihPp
	UCnQN4fMEVwJ5B9qh2L5zLQoBZP4ZWJJy8VWn04hF8TwiqRvU20NawEYK1Q4v4F34w5GQ39TY8g
	pfkKQSkRnQtSRDWFTepCkfIAUii4YSzKMEK0zGL2j0y2NG/rgeIfaIJPnXlKfh9TQ==
X-Received: by 2002:a05:6122:2187:b0:5bf:8c77:e89a with SMTP id 71dfb90a1353d-5c7ed474726mr19704135e0c.2.1788978533428;
        Wed, 09 Sep 2026 11:28:53 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/10] monitor: Resolve commands completed by a later event
Date: Wed,  9 Sep 2026 14:28:33 -0400
Message-ID: <20260909182840.1289776-4-luiz.dentz@gmail.com>
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

Some commands are only acknowledged by a Command Status and complete much
later through a separate event. Create Connection, Remote Name Request and
LE Create Connection are the common ones, and the delay is often seconds,
so this is exactly where the request reference is worth having. Until now
the completing event carried no hint of which command caused it:

  > HCI Event: Connect Complete (0x03) plen 11              #27 [hci0] 6.178055
          Request: #12 (3003.000 msec)
          Status: Success (0x00)
          Handle: 12
          Address: 00:11:22:33:44:55 (CIMSYS Inc)

Keep such commands queued past their Command Status and resolve them when
the completing event arrives, using a table that maps the opcode to the
event and to the value the two are matched on. Several may be outstanding
towards different devices at once and need not complete in order, so the
match is on the connection handle or the remote address, not on the opcode
alone. Inquiry and the LE connection commands are matched on the opcode
only, since the specification allows a single one to be outstanding and
the address in the command is ignored when the accept list is in use.

A Command Status reporting an error means the completing event will never
arrive, so the command is dropped instead of being left to match a later
unrelated event.

Setup Synchronous Connection and LE Create CIS are deliberately left out.
The former reports the ACL handle in the command but the new synchronous
handle in the event, and the latter produces one event per CIS, so neither
can be matched this way without being wrong.

The model wrote the table and the matching, which the author reviewed and
verified against traces covering out of order completion of two commands
with the same opcode, handle and address keyed matching, a failing Command
Status and truncated events.

Assisted-by: opencode:claude-opus-5
---
 monitor/packet.c | 303 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 266 insertions(+), 37 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 2b238e550b58..053c1165bf99 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -156,6 +156,13 @@ struct index_data {
 
 static struct index_data index_list[MAX_INDEX];
 
+/* How a deferred command is tied to the event that completes it */
+enum pending_key {
+	PENDING_KEY_NONE,	/* Only one may be outstanding at a time */
+	PENDING_KEY_HANDLE,
+	PENDING_KEY_BDADDR,
+};
+
 /*
  * Commands awaiting a Command Complete or a Command Status, so that the
  * response can point back at the frame that carried the request.
@@ -164,23 +171,190 @@ struct pending_cmd {
 	uint16_t opcode;
 	size_t frame;
 	struct timeval tv;
+	bool deferred;		/* Completed by an event, not by the status */
+	bool acked;		/* A Command Status has been seen already */
+	uint8_t key_type;
+	uint8_t key[6];
 };
 
 /* Bound the queue so commands that never get a response cannot pile up */
 #define PENDING_CMD_MAX 64
 
+/*
+ * Commands that are only acknowledged by a Command Status and complete
+ * later through a separate event. The key ties a pending command to its
+ * event when more than one may be outstanding, and the offsets are into
+ * the command and the event parameters respectively.
+ */
+struct deferred_data {
+	uint16_t opcode;
+	uint8_t evt;
+	uint8_t subevt;		/* Only used when evt is LE Meta Event */
+	uint8_t key_type;
+	uint8_t cmd_off;
+	uint8_t evt_off;
+};
+
+static const struct deferred_data deferred_table[] = {
+	/* Keyed on the connection handle */
+	{ BT_HCI_CMD_DISCONNECT, 0x05, 0x00, PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_AUTH_REQUESTED, 0x06, 0x00, PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_SET_CONN_ENCRYPT, 0x08, 0x00, PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_SET_CONN_ENCRYPT, 0x59, 0x00, PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_READ_REMOTE_FEATURES, 0x0b, 0x00,
+					PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_READ_REMOTE_EXT_FEATURES, 0x23, 0x00,
+					PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_READ_REMOTE_VERSION, 0x0c, 0x00,
+					PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_READ_CLOCK_OFFSET, 0x1c, 0x00,
+					PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_LE_READ_REMOTE_FEATURES, 0x3e, 0x04,
+					PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_LE_START_ENCRYPT, 0x08, 0x00, PENDING_KEY_HANDLE, 0, 1 },
+	{ BT_HCI_CMD_LE_START_ENCRYPT, 0x59, 0x00, PENDING_KEY_HANDLE, 0, 1 },
+	/* Keyed on the remote address */
+	{ BT_HCI_CMD_CREATE_CONN, 0x03, 0x00, PENDING_KEY_BDADDR, 0, 3 },
+	{ BT_HCI_CMD_ACCEPT_CONN_REQUEST, 0x03, 0x00,
+					PENDING_KEY_BDADDR, 0, 3 },
+	{ BT_HCI_CMD_REMOTE_NAME_REQUEST, 0x07, 0x00,
+					PENDING_KEY_BDADDR, 0, 1 },
+	/*
+	 * Not keyed, as the specification only allows one of these to be
+	 * outstanding at a time. The address in the command cannot be used
+	 * because it is ignored when the accept list is in use.
+	 */
+	{ BT_HCI_CMD_INQUIRY, 0x01, 0x00, PENDING_KEY_NONE, 0, 0 },
+	{ BT_HCI_CMD_LE_CREATE_CONN, 0x3e, 0x01, PENDING_KEY_NONE, 0, 0 },
+	{ BT_HCI_CMD_LE_CREATE_CONN, 0x3e, 0x0a, PENDING_KEY_NONE, 0, 0 },
+	{ BT_HCI_CMD_LE_EXT_CREATE_CONN, 0x3e, 0x01, PENDING_KEY_NONE, 0, 0 },
+	{ BT_HCI_CMD_LE_EXT_CREATE_CONN, 0x3e, 0x0a, PENDING_KEY_NONE, 0, 0 },
+	{ }
+};
+
+static const struct deferred_data *deferred_lookup_opcode(uint16_t opcode)
+{
+	int i;
+
+	for (i = 0; deferred_table[i].opcode; i++) {
+		if (deferred_table[i].opcode == opcode)
+			return &deferred_table[i];
+	}
+
+	return NULL;
+}
+
+/*
+ * Extract the value a pending command is matched on. Handles are masked
+ * since the event carries them without the data flags.
+ */
+static bool deferred_key(uint8_t key_type, const void *data, uint8_t size,
+						uint8_t off, uint8_t *key)
+{
+	switch (key_type) {
+	case PENDING_KEY_NONE:
+		return true;
+	case PENDING_KEY_HANDLE:
+		if (size < off + 2U)
+			return false;
+		put_le16(get_le16(data + off) & 0x0fff, key);
+		return true;
+	case PENDING_KEY_BDADDR:
+		if (size < off + 6U)
+			return false;
+		memcpy(key, data + off, 6);
+		return true;
+	}
+
+	return false;
+}
+
 static bool match_pending_cmd(const void *data, const void *user_data)
 {
 	const struct pending_cmd *cmd = data;
 
-	return cmd->opcode == PTR_TO_UINT(user_data);
+	/*
+	 * A deferred command stays queued after its Command Status, so skip
+	 * the ones already acknowledged or a second command with the same
+	 * opcode would match the first one again.
+	 */
+	return cmd->opcode == PTR_TO_UINT(user_data) && !cmd->acked;
+}
+
+struct pending_match {
+	uint16_t opcode;
+	const uint8_t *key;
+};
+
+static bool match_deferred_cmd(const void *data, const void *user_data)
+{
+	const struct pending_cmd *cmd = data;
+	const struct pending_match *match = user_data;
+
+	return cmd->opcode == match->opcode && cmd->deferred &&
+			!memcmp(cmd->key, match->key, sizeof(cmd->key));
+}
+
+static struct pending_cmd *pending_cmd_find(uint16_t index, uint16_t opcode)
+{
+	if (index >= MAX_INDEX)
+		return NULL;
+
+	/*
+	 * Several commands may be outstanding at once and they need not
+	 * complete in order, so match on the opcode and take the oldest.
+	 */
+	return queue_find(index_list[index].cmd_q, match_pending_cmd,
+							UINT_TO_PTR(opcode));
+}
+
+static void pending_cmd_remove(uint16_t index, struct pending_cmd *cmd)
+{
+	if (index >= MAX_INDEX)
+		return;
+
+	queue_remove(index_list[index].cmd_q, cmd);
+	free(cmd);
+}
+
+/*
+ * Format the request reference for a response, as the frame number of the
+ * command and the time elapsed since it was sent. Leaves the string empty
+ * when the request was not seen, which is the normal case for a capture
+ * started while commands were already in flight.
+ */
+static void pending_cmd_str(struct pending_cmd *cmd, struct timeval *tv,
+						char *str, size_t len)
+{
+	struct timeval delta;
+
+	if (!cmd) {
+		str[0] = '\0';
+		return;
+	}
+
+	if (tv && timerisset(&cmd->tv)) {
+		timersub(tv, &cmd->tv, &delta);
+		snprintf(str, len, "#%zu (%lld.%03lld msec)", cmd->frame,
+				(long long)delta.tv_sec * 1000 +
+						delta.tv_usec / 1000,
+				(long long)delta.tv_usec % 1000);
+	} else
+		snprintf(str, len, "#%zu", cmd->frame);
 }
 
 static void pending_cmd_enqueue(uint16_t index, uint16_t opcode,
-						struct timeval *tv)
+			struct timeval *tv, const void *data, uint8_t size)
 {
 	struct index_data *ctrl = &index_list[index];
+	const struct deferred_data *deferred;
 	struct pending_cmd *cmd;
+	uint8_t key[6] = {};
+
+	deferred = deferred_lookup_opcode(opcode);
+	if (deferred && !deferred_key(deferred->key_type, data, size,
+						deferred->cmd_off, key))
+		deferred = NULL;
 
 	if (!ctrl->cmd_q)
 		ctrl->cmd_q = queue_new();
@@ -194,45 +368,61 @@ static void pending_cmd_enqueue(uint16_t index, uint16_t opcode,
 	if (tv)
 		cmd->tv = *tv;
 
+	if (deferred) {
+		cmd->deferred = true;
+		cmd->key_type = deferred->key_type;
+		memcpy(cmd->key, key, sizeof(key));
+	}
+
 	queue_push_tail(ctrl->cmd_q, cmd);
 }
 
 /*
- * Format the request reference for a response, as the frame number of the
- * command and the time elapsed since it was sent. Leaves the string empty
- * when the request was not seen, which is the normal case for a capture
- * started while commands were already in flight.
+ * Resolve the command that an event completes, for the commands that are
+ * only acknowledged by a Command Status and finish later through a
+ * separate event.
  */
-static void pending_cmd_str(uint16_t index, uint16_t opcode,
+static void deferred_cmd_str(uint16_t index, uint8_t evt, uint8_t subevt,
+				const void *data, uint8_t size,
 				struct timeval *tv, char *str, size_t len)
 {
-	struct pending_cmd *cmd;
-	struct timeval delta;
+	int i;
 
 	str[0] = '\0';
 
 	if (index >= MAX_INDEX)
 		return;
 
-	/*
-	 * Several commands may be outstanding at once and they need not
-	 * complete in order, so match on the opcode and take the oldest.
-	 */
-	cmd = queue_remove_if(index_list[index].cmd_q, match_pending_cmd,
-							UINT_TO_PTR(opcode));
-	if (!cmd)
+	for (i = 0; deferred_table[i].opcode; i++) {
+		const struct deferred_data *deferred = &deferred_table[i];
+		struct pending_match match;
+		struct pending_cmd *cmd;
+		uint8_t key[6] = {};
+
+		if (deferred->evt != evt || deferred->subevt != subevt)
+			continue;
+
+		if (!deferred_key(deferred->key_type, data, size,
+						deferred->evt_off, key))
+			continue;
+
+		/*
+		 * Match on the key as well as the opcode, since several of
+		 * these may be outstanding towards different devices and
+		 * they need not complete in order.
+		 */
+		match.opcode = deferred->opcode;
+		match.key = key;
+
+		cmd = queue_find(index_list[index].cmd_q, match_deferred_cmd,
+									&match);
+		if (!cmd)
+			continue;
+
+		pending_cmd_str(cmd, tv, str, len);
+		pending_cmd_remove(index, cmd);
 		return;
-
-	if (tv && timerisset(&cmd->tv)) {
-		timersub(tv, &cmd->tv, &delta);
-		snprintf(str, len, " #%zu (%lld.%03lld msec)", cmd->frame,
-				(long long)delta.tv_sec * 1000 +
-						delta.tv_usec / 1000,
-				(long long)delta.tv_usec % 1000);
-	} else
-		snprintf(str, len, " #%zu", cmd->frame);
-
-	free(cmd);
+	}
 }
 
 static void assign_ctrl(uint32_t cookie, uint16_t format, const char *name)
@@ -11438,9 +11628,14 @@ static void cmd_complete_evt(struct timeval *tv, uint16_t index,
 	const struct opcode_data *opcode_data = NULL;
 	const char *opcode_color, *opcode_str;
 	char vendor_str[150], req_str[32];
+	struct pending_cmd *cmd;
 	int i;
 
-	pending_cmd_str(index, opcode, tv, req_str, sizeof(req_str));
+	cmd = pending_cmd_find(index, opcode);
+	pending_cmd_str(cmd, tv, req_str, sizeof(req_str));
+	/* A Command Complete always terminates the command */
+	if (cmd)
+		pending_cmd_remove(index, cmd);
 
 	for (i = 0; opcode_table[i].str; i++) {
 		if (opcode_table[i].opcode == opcode) {
@@ -11490,8 +11685,8 @@ static void cmd_complete_evt(struct timeval *tv, uint16_t index,
 	}
 
 	print_indent(6, opcode_color, "", opcode_str, COLOR_OFF,
-			" (0x%2.2x|0x%4.4x) ncmd %d%s", ogf, ocf, evt->ncmd,
-			req_str);
+			" (0x%2.2x|0x%4.4x) ncmd %d%s%s", ogf, ocf, evt->ncmd,
+			req_str[0] ? " " : "", req_str);
 
 	if (!opcode_data || !opcode_data->rsp_func) {
 		if (size > 3) {
@@ -11537,9 +11732,22 @@ static void cmd_status_evt(struct timeval *tv, uint16_t index,
 	const struct opcode_data *opcode_data = NULL;
 	const char *opcode_color, *opcode_str;
 	char vendor_str[150], req_str[32];
+	struct pending_cmd *cmd;
 	int i;
 
-	pending_cmd_str(index, opcode, tv, req_str, sizeof(req_str));
+	cmd = pending_cmd_find(index, opcode);
+	pending_cmd_str(cmd, tv, req_str, sizeof(req_str));
+	/*
+	 * A deferred command is only acknowledged here and completes later
+	 * through an event, so keep it queued. A failed status means that
+	 * event will never arrive.
+	 */
+	if (cmd) {
+		if (cmd->deferred && !evt->status)
+			cmd->acked = true;
+		else
+			pending_cmd_remove(index, cmd);
+	}
 
 	for (i = 0; opcode_table[i].str; i++) {
 		if (opcode_table[i].opcode == opcode) {
@@ -11577,8 +11785,8 @@ static void cmd_status_evt(struct timeval *tv, uint16_t index,
 	}
 
 	print_indent(6, opcode_color, "", opcode_str, COLOR_OFF,
-			" (0x%2.2x|0x%4.4x) ncmd %d%s", ogf, ocf, evt->ncmd,
-			req_str);
+			" (0x%2.2x|0x%4.4x) ncmd %d%s%s", ogf, ocf, evt->ncmd,
+			req_str[0] ? " " : "", req_str);
 
 	print_status(evt->status);
 }
@@ -13764,7 +13972,8 @@ struct subevent_data {
 
 static void print_subevent(struct timeval *tv, uint16_t index,
 				const struct subevent_data *subevent_data,
-				const void *data, uint8_t size)
+				const void *data, uint8_t size,
+				const char *req_str)
 {
 	const char *subevent_color;
 
@@ -13776,6 +13985,9 @@ static void print_subevent(struct timeval *tv, uint16_t index,
 	print_indent(6, subevent_color, "", subevent_data->str, COLOR_OFF,
 					" (0x%2.2x)", subevent_data->subevent);
 
+	if (req_str && req_str[0])
+		print_field("Request: %s", req_str);
+
 	if (!subevent_data->func) {
 		packet_hexdump(data, size);
 		return;
@@ -13932,6 +14144,7 @@ static void le_meta_event_evt(struct timeval *tv, uint16_t index,
 	uint8_t subevent = *((const uint8_t *) data);
 	struct subevent_data unknown;
 	const struct subevent_data *subevent_data = &unknown;
+	char req_str[32];
 	int i;
 
 	unknown.subevent = subevent;
@@ -13947,7 +14160,10 @@ static void le_meta_event_evt(struct timeval *tv, uint16_t index,
 		}
 	}
 
-	print_subevent(tv, index, subevent_data, data + 1, size - 1);
+	deferred_cmd_str(index, BT_HCI_EVT_LE_META_EVENT, subevent, data + 1,
+					size - 1, tv, req_str, sizeof(req_str));
+
+	print_subevent(tv, index, subevent_data, data + 1, size - 1, req_str);
 }
 
 static void vendor_evt(struct timeval *tv, uint16_t index,
@@ -13976,7 +14192,7 @@ static void vendor_evt(struct timeval *tv, uint16_t index,
 		vendor_data.fixed = vnd->evt_fixed;
 
 		print_subevent(tv, index, &vendor_data, data + consumed_size,
-							size - consumed_size);
+					size - consumed_size, NULL);
 	} else {
 		uint16_t manufacturer;
 
@@ -14347,7 +14563,7 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 
 	/* NOP carries no request and is only used to update ncmd */
 	if (opcode != BT_HCI_CMD_NOP)
-		pending_cmd_enqueue(index, opcode, tv);
+		pending_cmd_enqueue(index, opcode, tv, data, hdr->plen);
 
 	for (i = 0; opcode_table[i].str; i++) {
 		if (opcode_table[i].opcode == opcode) {
@@ -14507,6 +14723,19 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 		}
 	}
 
+	/*
+	 * LE Meta Events are resolved once the subevent is known, so that
+	 * the reference can be printed under it.
+	 */
+	if (hdr->evt != BT_HCI_EVT_LE_META_EVENT) {
+		char req_str[32];
+
+		deferred_cmd_str(index, hdr->evt, 0x00, data, hdr->plen, tv,
+						req_str, sizeof(req_str));
+		if (req_str[0])
+			print_field("Request: %s", req_str);
+	}
+
 	event_data->func(tv, index, data, hdr->plen);
 }
 
-- 
2.55.0


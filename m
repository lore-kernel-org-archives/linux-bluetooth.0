Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452D7C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 20:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjEEUcF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjEEUcD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 16:32:03 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300E844B2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 13:32:01 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-769036b48b0so168787939f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 May 2023 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683318719; x=1685910719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q0ivE7lTBv6rV0dGOw+yINa/34GCbveuXgb/FHJoZ8=;
        b=Nf8IdQsLC8O/Ne1+6t02947Yo6XyjRiBavDnktGxM+WAfjYPixeb/s3E/B21hf+YAM
         OfzQ4eZ9h5ltTEctoawtOlid8h+Yt67aOdckaj1fzkc4n+UG1UjS0L2oQw4MkZ4yLfA2
         WsImTF0THoD3eMs0vDcohy12r7B2Qpebkc0CFE+OOYTEDGanXlkxRu3aLAxvkjVifyGX
         3L8eiBXyF1ev0VXm8Kikl86LIIyrAFE0Jq0DWehXyJMwDH083O4zMNE1wUqkMN0CFC84
         E5P0p/Yb/2frlAasPtJuvF8/y+xuIP55f/bY1MbzOi8T3Xobp5mlDNutqU8QnZ4hT6lk
         GPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683318719; x=1685910719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q0ivE7lTBv6rV0dGOw+yINa/34GCbveuXgb/FHJoZ8=;
        b=lON/aBKy5KV15IF7RSRXTEKHKf3xC6m61D6iJKTYLzhB5hJdjgadf26dmBM0f2XVOD
         YyYwGvCH01PRD+UQibVuvfJ4ZiLHBaf4ylSe5lc7Yv0zXaBpEF+MVUhjrKJ3ij7ocnBo
         396Ietzvxq11Pd1tXJsScegEtdJUfAd4EnND2DAhDV+GgEJhFOfagsLmsykWngg7dgzf
         U6f0DSGiG2wAwWgRZVsdUDh36Q6cGXmbq6W4Wt2rDTzp3AgxQBxzUqWo/nGniyTQzvPS
         fl8rZwEe+CEHf9ohPQ9Rua7+YZNucjw/Trz+yWYrGNwM7BtJvHQ+XkRdIikARcIj7WYD
         w3+Q==
X-Gm-Message-State: AC+VfDxTzfuSuiB0CA4VKSpgrfmbP6gcwcpbx4TCLtYuYEwpr+HDS8tg
        0ks+iryB+69ZvauVNmfywsfXDmsTol8=
X-Google-Smtp-Source: ACHHUZ5xu4NLVSl4W8bO+0aH6PQ3oz2I3uo+UYT6faq2RjTuXRB9xX5x+cdynMC8T7tBgx+eV27CVg==
X-Received: by 2002:a5d:9942:0:b0:769:756a:92c1 with SMTP id v2-20020a5d9942000000b00769756a92c1mr1344907ios.10.1683318719056;
        Fri, 05 May 2023 13:31:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id s187-20020a0251c4000000b0040f9c31784csm190678jaa.87.2023.05.05.13.31.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 13:31:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor/att: Attempt to insert discovered attributes
Date:   Fri,  5 May 2023 13:31:55 -0700
Message-Id: <20230505203156.2561265-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to insert discovered attributes into monitor gatt_db
instance if their respective discover procedures are used which enables
decoding traces injected by user via unit testing:

> sudo unit/test-bap -m -s "34

= test-bap: BAP/UCL/SCC/BV-034-C [UCL SNK Config Codec, VS] - run
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003 Type: Sink PAC (0x2bc9)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 8
        Handle: 0x0003 Type: Sink PAC (0x2bc9)
        Value: 01ff010001000000
          Number of PAC(s): 1
          PAC #0:
            Codec: Vendor specific (0xff)
            Codec Company ID: Nokia Mobile Phones (0x0001)
            Codec Vendor ID: 0x0001
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0006 Type: Sink Audio Locations (0x2bca)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 4
        Handle: 0x0006 Type: Sink Audio Locations (0x2bca)
        Value: 03000000
           Location: 0x00000003
              Front Left (0x00000001)
              Front Right (0x00000002)
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0009 Type: Source PAC (0x2bcb)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 8
        Handle: 0x0009 Type: Source PAC (0x2bcb)
        Value: 01ff010001000000
          Number of PAC(s): 1
          PAC #0:
            Codec: Vendor specific (0xff)
            Codec Company ID: Nokia Mobile Phones (0x0001)
            Codec Vendor ID: 0x0001
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x000c Type: Source Audio Locations (0x2bcc)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 4
        Handle: 0x000c Type: Source Audio Locations (0x2bcc)
        Value: 03000000
           Location: 0x00000003
              Front Left (0x00000001)
              Front Right (0x00000002)
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 4
        Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
        Value: ff0f0e00
          Sink Context: 0x0fff
            Unspecified (0x0001)
            Conversational (0x0002)
            Media (0x0004)
            Game (0x0008)
            Instructional (0x0010)
            Voice Assistants (0x0020)
            Live (0x0040)
            Sound Effects (0x0080)
            Notifications (0x0100)
            Ringtone (0x0200)
            Alerts (0x0400)
            Emergency alarm (0x0800)
          Source Context: 0x000e
            Conversational (0x0002)
            Media (0x0004)
            Game (0x0008)
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 4
        Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
        Value: ff0f0e00
          Sink Context: 0x0fff
            Unspecified (0x0001)
            Conversational (0x0002)
            Media (0x0004)
            Game (0x0008)
            Instructional (0x0010)
            Voice Assistants (0x0020)
            Live (0x0040)
            Sound Effects (0x0080)
            Notifications (0x0100)
            Ringtone (0x0200)
            Alerts (0x0400)
            Emergency alarm (0x0800)
          Source Context: 0x000e
            Conversational (0x0002)
            Media (0x0004)
            Game (0x0008)
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0016 Type: Sink ASE (0x2bc4)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 2
        Handle: 0x0016 Type: Sink ASE (0x2bc4)
        Value: 0100
            ASE ID: 1
            State: Idle (0x00)
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x0017
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0019 Type: Sink ASE (0x2bc4)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 2
        Handle: 0x0019 Type: Sink ASE (0x2bc4)
        Value: 0200
            ASE ID: 2
            State: Idle (0x00)
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x001a
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x001c Type: Source ASE (0x2bc5)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 2
        Handle: 0x001c Type: Source ASE (0x2bc5)
        Value: 0300
            ASE ID: 3
            State: Idle (0x00)
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x001d
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x001f Type: Source ASE (0x2bc5)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 2
        Handle: 0x001f Type: Source ASE (0x2bc5)
        Value: 0400
            ASE ID: 4
            State: Idle (0x00)
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x0020
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x0023
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Write Command (0x52) len 13
        Handle: 0x0022 Type: ASE Control Point (0x2bc6)
          Data: 0101030202ff0100010000
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: Vendor specific (0xff)
            Codec Company ID: Nokia Mobile Phones (0x0001)
            Codec Vendor ID: 0x0001
< test-bap: User Data TX
      ATT: Handle Value Notification (0x1b) len 7
        Handle: 0x0022 Type: ASE Control Point (0x2bc6)
          Data: 0101030000
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
< test-bap: User Data TX
      ATT: Handle Value Notification (0x1b) len 27
        Handle: 0x001c Type: Source ASE (0x2bc5)
          Data: 03010102010a00204e00409c00204e00409c00ff0100010000
            ASE ID: 3
            State: Codec Configured (0x01)
            Framing: Unframed PDUs not supported (0x01)
            PHY: 0x02
            LE 2M PHY preffered (0x02)
            RTN: 1
            Max Transport Latency: 10
            Presentation Delay Min: 20000 us
            Presentation Delay Max: 40000 us
            Preferred Presentation Delay Min: 20000 us
            Preferred Presentation Delay Max: 40000 us
            Codec: Vendor specific (0xff)
            Codec Company ID: Nokia Mobile Phones (0x0001)
            Codec Vendor ID: 0x0001
---
 monitor/att.c | 538 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 345 insertions(+), 193 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index e67887861448..0e12ee352078 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -365,10 +365,11 @@ static void att_error_response(const struct l2cap_frame *frame)
 	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
 	print_field("Error: %s (0x%2.2x)", str, pdu->error);
 
-	/* Read/Read By Type may create a read object which needs to be dequeued
-	 * and freed in case the operation fails.
+	/* Read/Read By Type/Read By Group Type may create a read object which
+	 * needs to be dequeued and freed in case the operation fails.
 	 */
-	if (pdu->request == 0x08 || pdu->request == 0x0a)
+	if (pdu->request == 0x08 || pdu->request == 0x0a ||
+					pdu->request == 0x10)
 		free(att_get_read(frame));
 }
 
@@ -384,10 +385,202 @@ static const struct bitfield_data chrc_prop_table[] = {
 	{ }
 };
 
+static void att_conn_data_free(void *data)
+{
+	struct att_conn_data *att_data = data;
+
+	gatt_db_unref(att_data->rdb);
+	gatt_db_unref(att_data->ldb);
+	queue_destroy(att_data->reads, free);
+	free(att_data);
+}
+
+static struct att_conn_data *att_get_conn_data(struct packet_conn_data *conn)
+{
+	struct att_conn_data *data;
+
+	if (!conn)
+		return NULL;
+
+	data = conn->data;
+
+	if (data)
+		return data;
+
+	data = new0(struct att_conn_data, 1);
+	data->rdb = gatt_db_new();
+	data->ldb = gatt_db_new();
+	conn->data = data;
+	conn->destroy = att_conn_data_free;
+
+	return data;
+}
+
+static void gatt_load_db(struct gatt_db *db, const char *filename,
+						struct timespec *mtim)
+{
+	struct stat st;
+
+	if (lstat(filename, &st))
+		return;
+
+	if (!gatt_db_isempty(db)) {
+		/* Check if file has been modified since last time */
+		if (st.st_mtim.tv_sec == mtim->tv_sec &&
+				    st.st_mtim.tv_nsec == mtim->tv_nsec)
+			return;
+		/* Clear db before reloading */
+		gatt_db_clear(db);
+	}
+
+	*mtim = st.st_mtim;
+
+	btd_settings_gatt_db_load(db, filename);
+}
+
+static void load_gatt_db(struct packet_conn_data *conn)
+{
+	struct att_conn_data *data = att_get_conn_data(conn);
+	char filename[PATH_MAX];
+	char local[18];
+	char peer[18];
+	uint8_t id[6], id_type;
+
+	ba2str((bdaddr_t *)conn->src, local);
+
+	if (keys_resolve_identity(conn->dst, id, &id_type))
+		ba2str((bdaddr_t *)id, peer);
+	else
+		ba2str((bdaddr_t *)conn->dst, peer);
+
+	create_filename(filename, PATH_MAX, "/%s/attributes", local);
+	gatt_load_db(data->ldb, filename, &data->ldb_mtim);
+
+	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
+	gatt_load_db(data->rdb, filename, &data->rdb_mtim);
+}
+
+static struct gatt_db *get_db(const struct l2cap_frame *frame, bool rsp)
+{
+	struct packet_conn_data *conn;
+	struct att_conn_data *data;
+	struct gatt_db *db;
+
+	conn = packet_get_conn_data(frame->handle);
+	if (!conn)
+		return NULL;
+
+	/* Try loading local and remote gatt_db if not loaded yet */
+	load_gatt_db(conn);
+
+	data = conn->data;
+	if (!data)
+		return NULL;
+
+	if (frame->in) {
+		if (rsp)
+			db = data->rdb;
+		else
+			db = data->ldb;
+	} else {
+		if (rsp)
+			db = data->ldb;
+		else
+			db = data->rdb;
+	}
+
+	return db;
+}
+
+static struct gatt_db_attribute *insert_chrc(const struct l2cap_frame *frame,
+						uint16_t handle,
+						bt_uuid_t *uuid, uint8_t prop,
+						bool rsp)
+{
+	struct gatt_db *db;
+
+	db = get_db(frame, rsp);
+	if (!db)
+		return NULL;
+
+	return gatt_db_insert_characteristic(db, handle, uuid, 0, prop, NULL,
+							NULL, NULL);
+}
+
+static int bt_uuid_from_data(bt_uuid_t *uuid, const void *data, uint16_t size)
+{
+	uint128_t u128;
+
+	if (!uuid)
+		return -EINVAL;
+
+	switch (size) {
+	case 2:
+		return bt_uuid16_create(uuid, get_le16(data));
+	case 4:
+		return bt_uuid32_create(uuid, get_le32(data));
+	case 16:
+		memcpy(u128.data, data, sizeof(u128.data));
+		return bt_uuid128_create(uuid, u128);
+	}
+
+	return -EINVAL;
+}
+
+static bool svc_read(const struct l2cap_frame *frame, uint16_t *start,
+			uint16_t *end, bt_uuid_t *uuid)
+{
+	if (!l2cap_frame_get_le16((void *)frame, start))
+		return false;
+
+	if (!l2cap_frame_get_le16((void *)frame, end))
+		return false;
+
+	return !bt_uuid_from_data(uuid, frame->data, frame->size);
+}
+
+static struct gatt_db_attribute *insert_svc(const struct l2cap_frame *frame,
+						uint16_t handle,
+						bt_uuid_t *uuid, bool primary,
+						bool rsp, uint16_t num_handles)
+{
+	struct gatt_db *db;
+
+	db = get_db(frame, rsp);
+	if (!db)
+		return NULL;
+
+	return gatt_db_insert_service(db, handle, uuid, primary, num_handles);
+}
+
+static void pri_svc_read(const struct l2cap_frame *frame)
+{
+	uint16_t start, end;
+	bt_uuid_t uuid;
+
+	if (!svc_read(frame, &start, &end, &uuid))
+		return;
+
+	insert_svc(frame, start, &uuid, true, true, end - start + 1);
+}
+
+static void sec_svc_read(const struct l2cap_frame *frame)
+{
+	uint16_t start, end;
+	bt_uuid_t uuid;
+
+	if (!svc_read(frame, &start, &end, &uuid))
+		return;
+
+	insert_svc(frame, start, &uuid, true, false, end - start + 1);
+}
+
 static void print_chrc(const struct l2cap_frame *frame)
 {
 	uint8_t prop;
 	uint8_t mask;
+	uint16_t handle;
+	bt_uuid_t uuid;
 
 	if (!l2cap_frame_get_u8((void *)frame, &prop)) {
 		print_text(COLOR_ERROR, "Property: invalid size");
@@ -401,10 +594,16 @@ static void print_chrc(const struct l2cap_frame *frame)
 		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
 								mask);
 
-	if (!l2cap_frame_print_le16((void *)frame, "    Value Handle"))
+	if (!l2cap_frame_get_le16((void *)frame, &handle)) {
+		print_text(COLOR_ERROR, "    Value Handle: invalid size");
 		return;
+	}
 
+	print_field("    Value Handle: 0x%4.4x", handle);
 	print_uuid("    Value UUID", frame->data, frame->size);
+	bt_uuid_from_data(&uuid, frame->data, frame->size);
+
+	insert_chrc(frame, handle, &uuid, prop, true);
 }
 
 static void chrc_read(const struct l2cap_frame *frame)
@@ -2988,6 +3187,8 @@ struct gatt_handler {
 	void (*write)(const struct l2cap_frame *frame);
 	void (*notify)(const struct l2cap_frame *frame);
 } gatt_handlers[] = {
+	GATT_HANDLER(0x2800, pri_svc_read, NULL, NULL),
+	GATT_HANDLER(0x2801, sec_svc_read, NULL, NULL),
 	GATT_HANDLER(0x2803, chrc_read, NULL, NULL),
 	GATT_HANDLER(0x2902, ccc_read, ccc_write, NULL),
 	GATT_HANDLER(0x2bc4, ase_read, NULL, ase_notify),
@@ -3035,6 +3236,9 @@ static struct gatt_handler *get_handler_uuid(const bt_uuid_t *uuid)
 {
 	size_t i;
 
+	if (!uuid)
+		return NULL;
+
 	for (i = 0; i < ARRAY_SIZE(gatt_handlers); i++) {
 		struct gatt_handler *handler = &gatt_handlers[i];
 
@@ -3081,45 +3285,96 @@ static const char *att_format_str(uint8_t format)
 	}
 }
 
-static uint16_t print_info_data_16(const void *data, uint16_t len)
+static struct gatt_db_attribute *insert_desc(const struct l2cap_frame *frame,
+						uint16_t handle,
+						bt_uuid_t *uuid, bool rsp)
 {
-	while (len >= 4) {
-		print_field("Handle: 0x%4.4x", get_le16(data));
-		print_uuid("UUID", data + 2, 2);
-		data += 4;
-		len -= 4;
-	}
+	struct gatt_db *db;
 
-	return len;
+	db = get_db(frame, rsp);
+	if (!db)
+		return NULL;
+
+	return gatt_db_insert_descriptor(db, handle, uuid, 0, NULL, NULL, NULL);
 }
 
-static uint16_t print_info_data_128(const void *data, uint16_t len)
+static void att_find_info_rsp_16(const struct l2cap_frame *frame)
 {
-	while (len >= 18) {
-		print_field("Handle: 0x%4.4x", get_le16(data));
-		print_uuid("UUID", data + 2, 16);
-		data += 18;
-		len -= 18;
-	}
+	while (frame->size >= 4) {
+		uint16_t handle;
+		uint16_t u16;
+		bt_uuid_t uuid;
 
-	return len;
+		if (!l2cap_frame_get_le16((void *)frame, &handle)) {
+			print_text(COLOR_ERROR, "    Handle: invalid size");
+			return;
+		}
+
+		if (!l2cap_frame_get_le16((void *)frame, &u16)) {
+			print_text(COLOR_ERROR, "    UUID: invalid size");
+			return;
+		}
+
+		print_field("Handle: 0x%4.4x", handle);
+		print_uuid("UUID", &u16, 2);
+
+		bt_uuid16_create(&uuid, u16);
+
+		insert_desc(frame, handle, &uuid, true);
+	}
+}
+
+static void att_find_info_rsp_128(const struct l2cap_frame *frame)
+{
+	while (frame->size >= 18) {
+		uint16_t handle;
+		bt_uuid_t uuid;
+
+		if (!l2cap_frame_get_le16((void *)frame, &handle)) {
+			print_text(COLOR_ERROR, "    Handle: invalid size");
+			return;
+		}
+
+		if (frame->size < 16) {
+			print_text(COLOR_ERROR, "    UUID: invalid size");
+			return;
+		}
+
+		print_field("Handle: 0x%4.4x", handle);
+		print_uuid("UUID", frame->data, 16);
+
+		bt_uuid_from_data(&uuid, frame->data, 16);
+
+		if (!l2cap_frame_pull((void *)frame, frame, 16))
+			return;
+
+		insert_desc(frame, handle, &uuid, true);
+	}
 }
 
 static void att_find_info_rsp(const struct l2cap_frame *frame)
 {
-	const uint8_t *format = frame->data;
-	uint16_t len;
+	uint8_t format;
 
-	print_field("Format: %s (0x%2.2x)", att_format_str(*format), *format);
+	if (!l2cap_frame_get_u8((void *)frame, &format)) {
+		print_text(COLOR_ERROR, "    Format: invalid size");
+		goto done;
+	}
 
-	if (*format == 0x01)
-		len = print_info_data_16(frame->data + 1, frame->size - 1);
-	else if (*format == 0x02)
-		len = print_info_data_128(frame->data + 1, frame->size - 1);
-	else
-		len = frame->size - 1;
+	print_field("Format: %s (0x%2.2x)", att_format_str(format), format);
 
-	packet_hexdump(frame->data + (frame->size - len), len);
+	switch (format) {
+	case 0x01:
+		att_find_info_rsp_16(frame);
+		break;
+	case 0x02:
+		att_find_info_rsp_128(frame);
+		break;
+	}
+
+done:
+	if (frame->size)
+		packet_hexdump(frame->data, frame->size);
 }
 
 static void att_find_by_type_val_req(const struct l2cap_frame *frame)
@@ -3146,69 +3401,34 @@ static void att_find_by_type_val_rsp(const struct l2cap_frame *frame)
 	packet_hexdump(ptr, len);
 }
 
-static int bt_uuid_from_data(bt_uuid_t *uuid, const void *data, uint16_t size)
+static struct gatt_db_attribute *get_attribute(const struct l2cap_frame *frame,
+						uint16_t handle, bool rsp)
 {
-	uint128_t u128;
+	struct gatt_db *db;
 
-	switch (size) {
-	case 2:
-		return bt_uuid16_create(uuid, get_le16(data));
-	case 4:
-		return bt_uuid32_create(uuid, get_le32(data));
-	case 16:
-		memcpy(u128.data, data, sizeof(u128.data));
-		return bt_uuid128_create(uuid, u128);
-	}
-
-	return -EINVAL;
-}
-
-static void att_conn_data_free(void *data)
-{
-	struct att_conn_data *att_data = data;
-
-	gatt_db_unref(att_data->rdb);
-	gatt_db_unref(att_data->ldb);
-	queue_destroy(att_data->reads, free);
-	free(att_data);
-}
-
-static struct att_conn_data *att_get_conn_data(struct packet_conn_data *conn)
-{
-	struct att_conn_data *data;
-
-	if (!conn)
+	db = get_db(frame, rsp);
+	if (!db)
 		return NULL;
 
-	data = conn->data;
-
-	if (data)
-		return data;
-
-	data = new0(struct att_conn_data, 1);
-	data->rdb = gatt_db_new();
-	data->ldb = gatt_db_new();
-	conn->data = data;
-	conn->destroy = att_conn_data_free;
-
-	return data;
+	return gatt_db_get_attribute(db, handle);
 }
 
-static void att_read_type_req(const struct l2cap_frame *frame)
+static void queue_read(const struct l2cap_frame *frame, bt_uuid_t *uuid,
+					uint16_t handle)
 {
-	bt_uuid_t uuid;
 	struct packet_conn_data *conn;
 	struct att_conn_data *data;
 	struct att_read *read;
+	struct gatt_db_attribute *attr = NULL;
 	struct gatt_handler *handler;
 
-	print_handle_range("Handle range", frame->data);
-	print_uuid("Attribute type", frame->data + 4, frame->size - 4);
+	if (handle) {
+		attr = get_attribute(frame, handle, false);
+		if (!attr)
+			return;
+	}
 
-	if (bt_uuid_from_data(&uuid, frame->data + 4, frame->size - 4))
-		return;
-
-	handler = get_handler_uuid(&uuid);
+	handler = attr ? get_handler(attr) : get_handler_uuid(uuid);
 	if (!handler || !handler->read)
 		return;
 
@@ -3221,6 +3441,7 @@ static void att_read_type_req(const struct l2cap_frame *frame)
 		data->reads = queue_new();
 
 	read = new0(struct att_read, 1);
+	read->attr = attr;
 	read->in = frame->in;
 	read->chan = frame->chan;
 	read->func = handler->read;
@@ -3228,6 +3449,19 @@ static void att_read_type_req(const struct l2cap_frame *frame)
 	queue_push_tail(data->reads, read);
 }
 
+static void att_read_type_req(const struct l2cap_frame *frame)
+{
+	bt_uuid_t uuid;
+
+	print_handle_range("Handle range", frame->data);
+	print_uuid("Attribute type", frame->data + 4, frame->size - 4);
+
+	if (bt_uuid_from_data(&uuid, frame->data + 4, frame->size - 4))
+		return;
+
+	queue_read(frame, &uuid, 0x0000);
+}
+
 static void att_read_type_rsp(const struct l2cap_frame *frame)
 {
 	uint8_t len;
@@ -3241,83 +3475,6 @@ static void att_read_type_rsp(const struct l2cap_frame *frame)
 	print_data_list("Attribute data list", len, frame);
 }
 
-static void gatt_load_db(struct gatt_db *db, const char *filename,
-						struct timespec *mtim)
-{
-	struct stat st;
-
-	if (lstat(filename, &st))
-		return;
-
-	if (!gatt_db_isempty(db)) {
-		/* Check if file has been modified since last time */
-		if (st.st_mtim.tv_sec == mtim->tv_sec &&
-				    st.st_mtim.tv_nsec == mtim->tv_nsec)
-			return;
-		/* Clear db before reloading */
-		gatt_db_clear(db);
-	}
-
-	*mtim = st.st_mtim;
-
-	btd_settings_gatt_db_load(db, filename);
-}
-
-static void load_gatt_db(struct packet_conn_data *conn)
-{
-	struct att_conn_data *data = att_get_conn_data(conn);
-	char filename[PATH_MAX];
-	char local[18];
-	char peer[18];
-	uint8_t id[6], id_type;
-
-	ba2str((bdaddr_t *)conn->src, local);
-
-	if (keys_resolve_identity(conn->dst, id, &id_type))
-		ba2str((bdaddr_t *)id, peer);
-	else
-		ba2str((bdaddr_t *)conn->dst, peer);
-
-	create_filename(filename, PATH_MAX, "/%s/attributes", local);
-	gatt_load_db(data->ldb, filename, &data->ldb_mtim);
-
-	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
-	gatt_load_db(data->rdb, filename, &data->rdb_mtim);
-}
-
-static struct gatt_db_attribute *get_attribute(const struct l2cap_frame *frame,
-						uint16_t handle, bool rsp)
-{
-	struct packet_conn_data *conn;
-	struct att_conn_data *data;
-	struct gatt_db *db;
-
-	conn = packet_get_conn_data(frame->handle);
-	if (!conn)
-		return NULL;
-
-	/* Try loading local and remote gatt_db if not loaded yet */
-	load_gatt_db(conn);
-
-	data = conn->data;
-	if (!data)
-		return NULL;
-
-	if (frame->in) {
-		if (rsp)
-			db = data->rdb;
-		else
-			db = data->ldb;
-	} else {
-		if (rsp)
-			db = data->ldb;
-		else
-			db = data->rdb;
-	}
-
-	return gatt_db_get_attribute(db, handle);
-}
-
 static void print_handle(const struct l2cap_frame *frame, uint16_t handle,
 								bool rsp)
 {
@@ -3336,38 +3493,13 @@ static void att_read_req(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_read_req *pdu = frame->data;
 	uint16_t handle;
-	struct packet_conn_data *conn;
-	struct att_conn_data *data;
-	struct att_read *read;
-	struct gatt_db_attribute *attr;
-	struct gatt_handler *handler;
 
 	l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
 
 	handle = le16_to_cpu(pdu->handle);
 	print_handle(frame, handle, false);
 
-	attr = get_attribute(frame, handle, false);
-	if (!attr)
-		return;
-
-	handler = get_handler(attr);
-	if (!handler || !handler->read)
-		return;
-
-	conn = packet_get_conn_data(frame->handle);
-	data = conn->data;
-
-	if (!data->reads)
-		data->reads = queue_new();
-
-	read = new0(struct att_read, 1);
-	read->attr = attr;
-	read->in = frame->in;
-	read->chan = frame->chan;
-	read->func = handler->read;
-
-	queue_push_tail(data->reads, read);
+	queue_read(frame, NULL, handle);
 }
 
 static void att_read_rsp(const struct l2cap_frame *frame)
@@ -3409,40 +3541,60 @@ static void att_read_multiple_req(const struct l2cap_frame *frame)
 
 static void att_read_group_type_req(const struct l2cap_frame *frame)
 {
+	bt_uuid_t uuid;
+
 	print_handle_range("Handle range", frame->data);
 	print_uuid("Attribute group type", frame->data + 4, frame->size - 4);
+
+	if (bt_uuid_from_data(&uuid, frame->data + 4, frame->size - 4))
+		return;
+
+	queue_read(frame, &uuid, 0x0000);
 }
 
 static void print_group_list(const char *label, uint8_t length,
-					const void *data, uint16_t size)
+					const struct l2cap_frame *frame)
 {
+	struct att_read *read;
 	uint8_t count;
 
 	if (length == 0)
 		return;
 
-	count = size / length;
+	read = att_get_read(frame);
+
+	count = frame->size / length;
 
 	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
 
-	while (size >= length) {
-		print_handle_range("Handle range", data);
-		print_uuid("UUID", data + 4, length - 4);
+	while (frame->size >= length) {
+		print_handle_range("Handle range", frame->data);
+		print_uuid("UUID", frame->data + 4, length - 4);
 
-		data += length;
-		size -= length;
+		if (read) {
+			struct l2cap_frame f;
+
+			l2cap_frame_clone_size(&f, frame, length);
+
+			read->func(&f);
+		}
+
+		if (!l2cap_frame_pull((void *)frame, frame, length))
+			break;
 	}
 
-	packet_hexdump(data, size);
+	packet_hexdump(frame->data, frame->size);
+	free(read);
 }
 
 static void att_read_group_type_rsp(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_read_group_type_rsp *pdu = frame->data;
 
+	l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
+
 	print_field("Attribute data length: %d", pdu->length);
-	print_group_list("Attribute group list", pdu->length,
-					frame->data + 1, frame->size - 1);
+	print_group_list("Attribute group list", pdu->length, frame);
 }
 
 static void print_write(const struct l2cap_frame *frame, uint16_t handle,
-- 
2.40.0


Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC4E56A
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775481332; cv=pass; b=XQ298CSYLQM6xF132sbcxLTySffjGEkntIaWKz9ry6ewmTUnhAK7wjdjoBWAiechkJoTVarNoSCvazzU/QScOQ/vhxDV+Pt1Tr8Z+NF2hpT7T/50AgO9vxHistn3Nx9gKdYy3AoKNs44SOfQ6BcoB643Ed35lda24p47UMrLDus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775481332; c=relaxed/simple;
	bh=tc6KZO5/UsdqniNtqdiNOqzm0GSZ3xstEquBTztX2Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjY/rlNrguLmzahlRIIkiiplCBAzqqLoGCpgPI6w7zR1WoVjRlit1BfLGyhdwyBg5aRwHiYOJmDmCYR291oZd+31QPh9jDT+4TpoazR/ZXQRK0dmzK6VsTVDKMCG7LhJ0f2BCU90m/r81FtCPoJWfGjZmHI2rGLSqdYz2UI0NmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=YqBJTmjW; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="YqBJTmjW"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq8vb2Vnyzyvg;
	Mon, 06 Apr 2026 16:15:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775481323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+n/5O+IcNZmZEGimlxOHXJ8MVtB8VL+T2a458SbUG/g=;
	b=YqBJTmjWtkSELPpIWxIz3UqXT42Fv6fgk4NOqTK9qBpubL1L+CHgIiwg3ErW7+u0P8dTv5
	lvsub+UNu8wf1bUqTnMs1UKeTaSG3HsgnrjT9MkccxUGZHrpiACB42SKa15Lt/2HdYA6x1
	R73Y4Kb8xIb5iBw1OReH5j1kmsq82Mw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775481323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+n/5O+IcNZmZEGimlxOHXJ8MVtB8VL+T2a458SbUG/g=;
	b=nTao1jrSJ+VzKUuOBgx+k31FLz2oRjtEr4T1b+wRlMipjibg2H6lIthgp/e7lLn9C3FfyH
	9YYAPdiXbpQDhafVQdZbxkVO+z41AuP2DPC9L6p79GMHeLEGQsDR21QunaA59Y93Va66Gv
	Rm0koEZ08md2Oi45BusAmATIEdd3tdc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775481323;
	b=cs7fXSROMC6Ckg8Qh8T67M6nvTm/aQpCDqiOWwNQ7DvTksE7KW2gm/QTtnQs+MxdstQ9U0
	CVBLkQp2rnTkpVnZnYKyAfjNrHz0MndOr8EiwllCzCx1a+uh27vDdb/7AhgU8ZOnYGW5l7
	3Tb/YRjLPcyTR9G0pm6mUJVPeAwTwz8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] shared/mcp: fix parsing of control point arguments
Date: Mon,  6 Apr 2026 16:15:20 +0300
Message-ID: <3cda5993d78d31ca136ff2c568b8c86baa380f32.1775481285.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775481285.git.pav@iki.fi>
References: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775481285.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix parsing of control point argument lost in rebases.

Add tests for Move Relative command that need it:

MCS/SR/MCP/BV-12-C [Move Relative from Playing]
MCS/SR/MCP/BV-13-C [Move Relative from Paused]
MCS/SR/MCP/BV-14-C [Move Relative from Seeking]
MCS/SR/MCP/BV-75-C [Move Relative from Inactive]
---

Notes:
    v2: fix test data for MCS/SR/MCP/BV-75-C [Move Relative from Inactive]

 src/shared/mcp.c |   5 +++
 unit/test-mcp.c  | 100 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index 0dd175c6d..a954869b0 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -343,6 +343,11 @@ static void write_media_cp(struct gatt_db_attribute *attrib,
 		rsp.result = BT_MCS_RESULT_OP_NOT_SUPPORTED;
 		goto respond;
 	}
+	if (cmd->int32_arg && !util_iov_pull_le32(&iov, (uint32_t *)&arg)) {
+		ret = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		rsp.op = 0;
+		goto respond;
+	}
 
 	DBG_MCS(mcs, "Command %s", cmd->name);
 
diff --git a/unit/test-mcp.c b/unit/test-mcp.c
index 7d922bb83..6331c6c99 100644
--- a/unit/test-mcp.c
+++ b/unit/test-mcp.c
@@ -1812,17 +1812,48 @@ static int32_t sr_mcp_track_position(void *user_data)
 {
 	struct test_data *data = user_data;
 
-	return 71 - data->id;
+	return data->id;
 }
 
 static bool sr_mcp_set_track_position(void *user_data, int32_t value)
 {
 	struct test_data *data = user_data;
 
-	data->id = 71 - value;
+	data->id = value;
 	return true;
 }
 
+static bool sr_mcp_move_relative(void *user_data, int32_t offset)
+{
+	struct test_data *data = user_data;
+	int pos = data->id;
+
+	tester_debug("Move Relative %d (pos %d)", (int)offset, pos);
+
+	if (!data->step)
+		FAIL_TEST();
+	data->step--;
+
+	if (bt_mcs_get_media_state(data->mcs) == BT_MCS_STATE_INACTIVE)
+		return false;
+
+	pos += offset;
+	if (pos < 0)
+		pos = 0;
+	if (pos > 71)
+		pos = 71;
+
+	data->id = pos;
+
+	bt_mcs_changed(data->mcs, MCS_TRACK_POSITION_CHRC_UUID);
+	return true;
+}
+
+static int32_t sr_mcp_track_duration(void *user_data)
+{
+	return 71;
+}
+
 const struct bt_mcs_callback sr_mcp_mcs = {
 	.media_cp_op_supported = sr_mcp_media_cp_op_supported,
 	.play = sr_mcp_op_success,
@@ -1832,6 +1863,8 @@ const struct bt_mcs_callback sr_mcp_mcs = {
 	.stop = sr_mcp_op_success_inactive,
 	.track_position = sr_mcp_track_position,
 	.set_track_position = sr_mcp_set_track_position,
+	.track_duration = sr_mcp_track_duration,
+	.move_relative = sr_mcp_move_relative,
 	.debug = mcs_debug,
 };
 
@@ -1908,15 +1941,64 @@ MCS_SR_MCP_CFG(bv_11_c, BT_MCS_STATE_SEEKING);
 MCS_SR_MCP_CFG(bv_74_c, BT_MCS_STATE_INACTIVE);
 #define MCS_SR_MCP_BV_74_C SR_MCP_STOP_INACTIVE
 
+#define SR_MCP_MOVE_RELATIVE(initial) \
+	NOTIFY_CHRC(STATE, initial), \
+	READ_CHRC(TRACK_DUR, 0x47, 0x00, 0x00, 0x00), \
+	WRITE_NORESP_CHRC(CP, BT_MCS_CMD_MOVE_RELATIVE, 0xaf, 0xff, 0xff, \
+									0xff), \
+	NOTIFY_CHRC(TRACK_POS, 0x00, 0x00, 0x00, 0x00), \
+	NOTIFY_CHRC(CP, BT_MCS_CMD_MOVE_RELATIVE, 0x01), \
+	WRITE_NORESP_CHRC(CP, BT_MCS_CMD_MOVE_RELATIVE, 0x17, 0x00, 0x00, \
+									0x00), \
+	NOTIFY_CHRC(TRACK_POS, 0x17, 0x00, 0x00, 0x00), \
+	NOTIFY_CHRC(CP, BT_MCS_CMD_MOVE_RELATIVE, 0x01), \
+	WRITE_NORESP_CHRC(CP, BT_MCS_CMD_MOVE_RELATIVE, 0x30, 0x00, 0x00, \
+									0x00), \
+	NOTIFY_CHRC(TRACK_POS, 0x47, 0x00, 0x00, 0x00), \
+	NOTIFY_CHRC(CP, BT_MCS_CMD_MOVE_RELATIVE, 0x01)
+
+#define SR_MCP_MOVE_RELATIVE_INACTIVE \
+	READ_CHRC(TRACK_DUR, 0x47, 0x00, 0x00, 0x00), \
+	WRITE_NORESP_CHRC(CP, BT_MCS_CMD_MOVE_RELATIVE, 0xaf, 0xff, 0xff, \
+									0xff), \
+	NOTIFY_CHRC(CP, BT_MCS_CMD_MOVE_RELATIVE, 0x03)
+
+MCS_SR_MCP_CFG(bv_12_c, BT_MCS_STATE_PLAYING);
+#define MCS_SR_MCP_BV_12_C SR_MCP_MOVE_RELATIVE(BT_MCS_STATE_PLAYING)
+
+MCS_SR_MCP_CFG(bv_13_c, BT_MCS_STATE_PAUSED);
+#define MCS_SR_MCP_BV_13_C SR_MCP_MOVE_RELATIVE(BT_MCS_STATE_PAUSED)
+
+MCS_SR_MCP_CFG(bv_14_c, BT_MCS_STATE_SEEKING);
+#define MCS_SR_MCP_BV_14_C SR_MCP_MOVE_RELATIVE(BT_MCS_STATE_SEEKING)
+
+MCS_SR_MCP_CFG(bv_75_c, BT_MCS_STATE_INACTIVE);
+#define MCS_SR_MCP_BV_75_C SR_MCP_MOVE_RELATIVE_INACTIVE
+
 static void test_sr_mcp(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
 
+	data->id = 13;
+
 	bt_mcs_set_media_state(data->mcs, data->cfg->state);
 	data->step++;
 	test_server(data);
 }
 
+static void test_sr_mcp_move_relative(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	data->id = 13;
+
+	bt_mcs_set_media_state(data->mcs, data->cfg->state);
+	data->step++;
+	if (data->cfg->state != BT_MCS_STATE_INACTIVE)
+		data->step += 2;
+	test_server(data);
+}
+
 static void testgroup_sr_mcp(void)
 {
 	/* Only the MCS tests. No point in GMCS as only svc uuid changes */
@@ -1955,6 +2037,20 @@ static void testgroup_sr_mcp(void)
 		test_setup_server, test_sr_mcp,
 		&cfg_mcs_sr_mcp_bv_74_c, MCS_SR_MCP_BV_74_C);
 
+	/* MCS.TS Sec 4.4.4 Move Relative */
+	define_test("MCS/SR/MCP/BV-12-C [Move Relative from Playing]",
+		test_setup_server, test_sr_mcp_move_relative,
+		&cfg_mcs_sr_mcp_bv_12_c, MCS_SR_MCP_BV_12_C);
+	define_test("MCS/SR/MCP/BV-13-C [Move Relative from Paused]",
+		test_setup_server, test_sr_mcp_move_relative,
+		&cfg_mcs_sr_mcp_bv_13_c, MCS_SR_MCP_BV_13_C);
+	define_test("MCS/SR/MCP/BV-14-C [Move Relative from Seeking]",
+		test_setup_server, test_sr_mcp_move_relative,
+		&cfg_mcs_sr_mcp_bv_14_c, MCS_SR_MCP_BV_14_C);
+	define_test("MCS/SR/MCP/BV-75-C [Move Relative from Inactive]",
+		test_setup_server, test_sr_mcp_move_relative,
+		&cfg_mcs_sr_mcp_bv_75_c, MCS_SR_MCP_BV_75_C);
+
 	/* TODO: other state transition tests. They largely test the profile
 	 * upper layer, so do not add much here.
 	 */
-- 
2.53.0


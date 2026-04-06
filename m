Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A13332608
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478417; cv=pass; b=mH4B4QFVsdYTSeIY5o1COEmXjmsKZOHgkx0FaIr+PGzVvnwTqgmenQCZW24FJ6gIc20Jn10gcciFb808bL2PJCQvc9vsXd83YjCEZmbwpO7x5fXKjbYfXggP2biAmnkLNpOR5vVceOB/JTxSqfZfxUxyJh538k6zJk78kwXXDDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478417; c=relaxed/simple;
	bh=fQc7J4cyJ4IXu7JFi7/vmFF2DzSEzWnhEibG1EX31Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=et002TGjtSL9FrSOP4unLrokjRQedcfTH3Dybwhu/+gUOTZyDmUny9KmtE0S8cDZ4wdVcB47uO6X9+xRjNg5YVUW5MHO6xL3W0y7y4LrFiE/3T2OJy2ijrhkPQKmzhVvSXLT7QH0/26qcgkbMPG/qb+XKP/WC22DL2CTmxMVfLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=IOerfNdY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="IOerfNdY"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq7qf0cFSzyx1;
	Mon, 06 Apr 2026 15:26:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775478414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Soq4nZQuu/AqsBXGF1fvny+O0YOWfF8C+MvS1YKb4xc=;
	b=IOerfNdYArLXidNnHAbualuZ9PwV2YcHneiqBoCMD6JSRa1PkZxeOaVtPUKs/piPyVV6xe
	2KEjpLXYT2m/s/WaA8ntl8eTggWrTbJuEDA2XQ7T+XMgbF6fBOiz4S5XfYzxnWBDKwBw5Q
	skWZJh1ntXgTK4kZB+IvPzT+FNRQDj0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775478414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Soq4nZQuu/AqsBXGF1fvny+O0YOWfF8C+MvS1YKb4xc=;
	b=ZS+gB8RnB3I6wLEjlRMfatiUau0S09XF+6dTnLf0H6w5Qi248w6tBGEyuidZeCYEgBteBQ
	xmLFtPbG5pWfiYiGQUmfuWQJIkKzQZDJGyjboPpyOazLjBNvkinSeke5nlRyFcFU3p/zSc
	szTlvVag+cpR/2VxBzgt9rZ4ElCf+ac=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775478414;
	b=lWzWiT5Z5C7XvOOb6FMiDbJHpe3IeL9dv5B06ffarTopGRL8H/M0nQJtSVI8Cul2y+Dcci
	SBvHcax5e5b8Axis4g8Ik9ZH17x3atVEobMv+E5YeRAlm2l6M2I4OWIIOe2fQAbWR2IzFr
	IsgwNqsfAsrQxb7xJF6+VOSfOu/+O1E=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] shared/mcp: fix parsing of control point arguments
Date: Mon,  6 Apr 2026 15:26:51 +0300
Message-ID: <d0b4f16997ce1311df2a02fa79739ab21e13341c.1775477981.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775477981.git.pav@iki.fi>
References: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775477981.git.pav@iki.fi>
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
 src/shared/mcp.c |   5 +++
 unit/test-mcp.c  | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 2 deletions(-)

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
index 7d922bb83..f98e7e72b 100644
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
+	if (!data->step)
+		FAIL_TEST();
+	data->step--;
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
 
@@ -1908,15 +1941,65 @@ MCS_SR_MCP_CFG(bv_11_c, BT_MCS_STATE_SEEKING);
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
+	NOTIFY_CHRC(STATE, initial), \
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
@@ -1955,6 +2038,20 @@ static void testgroup_sr_mcp(void)
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
+		&cfg_mcs_sr_mcp_bv_75_c, MCS_SR_MCP_BV_74_C);
+
 	/* TODO: other state transition tests. They largely test the profile
 	 * upper layer, so do not add much here.
 	 */
-- 
2.53.0


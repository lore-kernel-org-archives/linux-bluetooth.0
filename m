Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A713B8D47
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572372; cv=pass; b=YXM4TPEdW0efIhgFtqKxsjIANChRuKBWkJ058Zk/DvL9sqoWQrE3a9cadjqHJTSGg3536dJrfhxGugBLh6yTCFrJlYixw+NwE0s6SWnzUEEg4J0LXB+1aEp5LiERNrWBR/EioKnKOiOFE+JtAD14k/UHnWPwVfqMDDqZ0WVU1t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572372; c=relaxed/simple;
	bh=FoMsDD38TwJD1Gi1nPO/soiNpv9ywEAXq77+Pjun6xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLTSsX6E9QTHPm5t3VSoSxsq1/u/OaFj1SFqtmew5X1TNht7qEk1b056ZEgWJ71ZNL5A08iO8pSEpe4NmIoPmWBYIZXQJOI5fnpUKMOfI9ZiJdL21jzjlOODCvgWu87nSREgYSZ5paUxrcWOis74s7WJvgcel0bqjZjLW0F+icA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VPe3RTuA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VPe3RTuA"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dShLl60zcz10Cm;
	Fri, 12 Dec 2025 22:46:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765572368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/9vNOPO1IOvBdanSYt+dCH7fFi27EF6pvwj4k0Z8wU=;
	b=VPe3RTuA2aJ6BKlpg9gmQWzX/bsPgD3R/kG0yMMzc8rImO1y9PwUnffHGJY/ioiJg6l7fc
	ciW8jPB/bv6uMRf8BxvGiZ00ZpPqSPKp1aW62EuN/Wpzq05YMyQxiAIkCPxqVdhzoXCVNO
	7cNrac5dkLtbJiNtFTUKNoSs4x648Ro=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765572368;
	b=cMm2klaNO3+I+qg+YoACK2Z5zzFlzW6aYYKZpxvszBxQHvNXODmWXRsskzEddN4pNIkkwz
	0pOCvDhQVZSKQ8okz/TeaEDvvo75nQeGEMHOCFBSqDhqSt/lbICC8S8SDPb5UyT/9eqcZJ
	/UB3f2JHBh64A9VKoo21Pdru/bB0V8c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765572368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/9vNOPO1IOvBdanSYt+dCH7fFi27EF6pvwj4k0Z8wU=;
	b=gzH9dFfKjc96rJhcPWtnCJMnWG2DthwKIrvOLkPCVKuj+hWDWBHvE25Bi8EXKxxk3bARQL
	HV0G8B6dr4otEy+gUDkFAI7Q3sfm1m67aU0L4Cy2Rjtj+oDWu8TDFOIyi8NvRHZrrOA4ys
	x13AxkUvvct7MW1bN3VLTzrrdX471Wc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 8/9] test-mcp: check attributes are reread on track change if no notify
Date: Fri, 12 Dec 2025 22:45:53 +0200
Message-ID: <44991a6c123dbf18cb9cb04ba293037d7cbd1126.1765572338.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765572338.git.pav@iki.fi>
References: <cover.1765572338.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test we reread attributes on track change if remote does not have
optional notify features.
---
 unit/test-mcp.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/unit/test-mcp.c b/unit/test-mcp.c
index 0100df1ab..b05630185 100644
--- a/unit/test-mcp.c
+++ b/unit/test-mcp.c
@@ -1325,6 +1325,57 @@ static void testgroup_cl_mccp(void)
 		test_setup, test_client, &cfg_mccp_bv_21_c, MCCP_BV_21_C);
 }
 
+#define CL_BLUEZ_1_REREAD \
+	NOTIFY_CHRC(TRACK_CHG), \
+	READ_CHRC(TRACK_TITLE, 'N', 'e', 'w'), \
+	READ_CHRC(TRACK_DUR, 0xff, 0xff, 0xff, 0xff), \
+	READ_CHRC(TRACK_POS, 0xff, 0xff, 0xff, 0xff), \
+	READ_CHRC(PLAY_SPEED, 0x00), \
+	READ_CHRC(SEEK_SPEED, 0x00), \
+	READ_CHRC(PLAY_ORDER, 0x04), \
+	READ_CHRC(PLAY_ORDER_SUPP, 0x18, 0x00), \
+	READ_CHRC(CP_SUPP, SPLIT_INT32(0x01))
+
+static void cl_reread_complete_cb(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	if (data->step == 2)
+		tester_test_passed();
+}
+
+static void cl_reread_track_title(void *user_data, const uint8_t *value,
+								uint16_t length)
+{
+	struct test_data *data = user_data;
+
+	if (strncmp((void *)value, "Title", length) == 0 && data->step == 0) {
+		data->step++;
+	} else if (strncmp((void *)value, "New", length) == 0 &&
+							data->step == 1) {
+		data->step++;
+		tester_io_set_complete_func(cl_reread_complete_cb);
+	} else {
+		FAIL_TEST();
+	}
+}
+
+const struct test_config cfg_cl_bluez_1_reread = {
+	.listener_cb = &(struct bt_mcp_listener_callback) {
+		.track_title = cl_reread_track_title,
+	},
+	.setup_data = setup_data_mcs,
+	.setup_data_len = ARRAY_SIZE(setup_data_mcs),
+	.gmcs = false,
+};
+
+static void testgroup_cl_extra(void)
+{
+	define_test("MCP/CL/BLUEZ-1 [Reread On Track Change, No Notify]",
+		test_setup, test_client,
+		&cfg_cl_bluez_1_reread, CL_BLUEZ_1_REREAD);
+}
+
 /*
  * Server tests
  */
@@ -1800,6 +1851,7 @@ int main(int argc, char *argv[])
 	tester_init(&argc, &argv);
 	testgroup_cl_cggit();
 	testgroup_cl_mccp();
+	testgroup_cl_extra();
 	testgroup_sr_sggit();
 	testgroup_sr_mcp();
 
-- 
2.51.1


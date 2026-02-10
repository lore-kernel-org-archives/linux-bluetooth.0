Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64533344D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757151; cv=none; b=favuXkF2gCGubshBUtESsjL5wNZXwC7dvWQrYI/bjL7371+9rcnJz2Yb3+JLMKZ4fcyK+val6la6LAB8lFJYT+hlwkPAVEbjf7OzJgUa4BoHD9JIfNpSveIWrelxA6RiT8PZav36saLb6/6Tzz8MvX4U/EKBxykIII5Pxgmx56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757151; c=relaxed/simple;
	bh=XrqoF4ein+uWQmK7TwvWK+dG0C04EwqPo7SnlsmoOY8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U6Gzg5uN3roPcXc7YjCj/OURp6R3L3VtspeB52ZeTUWXqVkg8YCgx46jsm2vm0ulF+tiEyoAOkxaxX0H0dY5Q7+b2M65l30pn+mBSAoYfwW431h0PxZtWfI2CiC1CNFwygCz/V4D2IReFLpQMFmPWnB1u29cRPGuMSAyckgrPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy3mUSh5; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy3mUSh5"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5673804da95so512047e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770757149; x=1771361949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kusL26LPbMr5Rw9lnPWQ7dyRdI23xbuWq0ePAxcLlsI=;
        b=Iy3mUSh5m+8CktpTTpIhx74z3jhEQKR8FIMo2f7YHOCBUs5zWLL40YEWkhu5P5OjfD
         BbamIk6UvXrv3a7szPoNK3I6q2ZMbbtOLlFXzyQFo/EArUqS8nc2bl9DZn60XC/d5+if
         f+tfI0P3IbQzWd4DXkWHxK9ClmlHIU1cV5/T6Fzgpt4OiAE0cBvbnMyk1As6vAW3Pic3
         XUVfZ/C8grTNYXBbsEXqDl+HUbpDT6o0VtCg0O/MqsmB+lLV2zTKzvkA3FVCGjfToW9x
         4aJPTR+Iycm4DSzU6Kflgy9qFHNofcQWta0muf2grd05F2aiSmJPoMUlrccuzeoe0S1G
         Pq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757149; x=1771361949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kusL26LPbMr5Rw9lnPWQ7dyRdI23xbuWq0ePAxcLlsI=;
        b=D8tLbc0+pPRYnqgGDORokwm2jsLKJYoUhqUrENYB2kzIryhJT6IW6sXZgGxFGlbXL0
         AgFf7gQ7zeWubr954uHibnNIUwEbzCy7eKbJV50EldLZTLKE6ODT2WrxrNxPwfbHw/wn
         V2QUZ3QOWimMKJ/G6uw8erpY1LkJ4FJqWVgrLortfPpxHkQPQoNn366wzPSInc2QjzRY
         cpXaWbzlu5xGezt5U3cpUEcoH+hRgiBaHG1JFwCzZCxpyn0OAWrf0p+GT5jDit5dyNmw
         YXMrsCsQU95UBy61N3LFGaIvUQbXMT9TAu1K/cDpNY5r3GllmV3Etv9CPsNts86eI9Lu
         sTlA==
X-Gm-Message-State: AOJu0Yx5JQ7QTwmhr7iDHobtJrbBE1gtU+4DJwIJkAd/6aCFMPL5UjqJ
	al251ZV9BWF8qdGtkgq35h5AgW3I3xgJn3oxR9AuNCSiTFoiuTxpXtskztoPGg==
X-Gm-Gg: AZuq6aK++lnQZX9CLip5uofBKq6A4au5FfmFALNUJhIa1D0fz2DHJ4XZKfc2CSgieMc
	4T+Mpg+w+lrO8qobQs88m1Kn4FNfiqANGqKT3d9/gm/7uSQUOWnNC2waO5aCBfKBHFNwUaKg8gq
	miZEdipmaOD9Quz6CczMjJiAlfUpJS1apmryR3M0RyRl4OoaWGO8eZkaigsrtpnWsidOGTbbs9C
	SnpSNSKUoK71dOix1HrHNJW/KnORoycbINkLnASgtItoXOu+ridaEY4QYjlseKebncAOxFygznH
	vNF7tpTf5Rm5alsGtv2L/Xhx90H86ztRE4PTr7TOax7Xx8m9krypJwdFK+AMB7m6OeGCaIFVtSZ
	61l/amQo990BKtt4sjq72VHopvJy3sbsXtWlthZm+xcWkZd+wH5IQ7dwHYvIo4DHRlAh/n0F09o
	7eb0Ex/YG13Y/RgcTld0rreutelb1Q+qsqtGB4Ycy6+aLgjjnn/bRisZjFSsy7S3y4Zg1Nw0zaD
	3NTInbH2MPFVms0Lw==
X-Received: by 2002:a05:6122:a19:b0:563:8339:6201 with SMTP id 71dfb90a1353d-5670602e0fbmr3951672e0c.17.1770757149038;
        Tue, 10 Feb 2026 12:59:09 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-567072e9586sm5080768e0c.1.2026.02.10.12.59.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:59:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] client: Add mgmt.exp-iso command
Date: Tue, 10 Feb 2026 15:58:58 -0500
Message-ID: <20260210205859.1240075-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds mgmt.exp-iso command which can be used to toggle ISO socket
support:

@ MGMT Command: Set Experimental Feature (0x004a) plen 17
        UUID: BlueZ Experimental ISO Socket
        Action: Enabled (0x01)
@ MGMT Event: Command Complete (0x0001) plen 23
      Set Experimental Feature (0x004a) plen 20
        Status: Success (0x00)
        UUID: BlueZ Experimental ISO Socket
        Flags: 0x00000001
          Active
@ MGMT Event: Experimental Feature Changed (0x0027) plen 20
        UUID: BlueZ Experimental ISO Socket
        Flags: 0x00000001
          Active
---
 client/mgmt.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index 968efdbca5b0..4e68547ed33c 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -2751,6 +2751,42 @@ static void cmd_exp_offload_codecs(int argc, char **argv)
 	}
 }
 
+static void exp_iso_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0)
+		error("Set ISO Socket failed with status 0x%02x (%s)", status,
+					mgmt_errstr(status));
+	else
+		print("ISO Socket successfully set");
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_exp_iso(int argc, char **argv)
+{
+	/* 6fbaf188-05e0-496a-9885-d6ddfdb4e03e */
+	static const uint8_t uuid[16] = {
+		0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6, 0x85, 0x98,
+		0x6a, 0x49, 0xe0, 0x05, 0x88, 0xf1, 0xba, 0x6f
+	};
+	struct mgmt_cp_set_exp_feature cp;
+	uint8_t val;
+
+	if (parse_setting(argc, argv, &val) == false)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, uuid, 16);
+	cp.action = val;
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
+			sizeof(cp), &cp, exp_iso_rsp, NULL, NULL) == 0) {
+		error("Unable to set ISO Socket experimental feature");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void class_rsp(uint16_t op, uint16_t id, uint8_t status, uint16_t len,
 							const void *param)
 {
@@ -6166,6 +6202,8 @@ static const struct bt_shell_menu mgmt_menu = {
 		"Set bluetooth quality report feature"			},
 	{ "exp-offload",		"<on/off>",
 		cmd_exp_offload_codecs,	"Toggle codec support"		},
+	{ "exp-iso",		"<on/off>",
+		cmd_exp_iso,	"Toggle ISO support"		},
 	{ "read-sysconfig",	NULL,
 		cmd_read_sysconfig,	"Read System Configuration"	},
 	{ "set-sysconfig",	"<-v|-h> [options...]",
-- 
2.52.0


Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB81D041B
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716444; cv=none; b=YbPRJcGS1b0cq1LKcYAV9sKTvFrX665zEm7+UnFw/Du9CDf2rNi5eX2Sr/SDbN3fsNs0+LHCUMtWRlb2CBFQWXCPwUIqdSIfqt9KThs8kVFEtlC6AC5GpwY1ElQPFsC6l+N7DfY4jfAhmKgM9X9BypnJTrFDETwMaPeYEXhStVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716444; c=relaxed/simple;
	bh=rRjSjYzmSlQoRZv6OFJRwoa2rYMglZ4crQnGyMkT7eY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RekcBw+SKcvX2JK0XH19QfdBpWp7ph2u80qq5b7RaC6/9PjIHBrG1VW7vrS7EF3iXbriFCmbSLBDwG+dujvVOvw1vkgh357Aw1Mdd1cVAag9tsc0qG5J6bTdqoDsv/PZBghihOAYHuC2WKLdKXFm6Xjgm/ZZr5rGIOcswmXJ5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieodzwY1; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieodzwY1"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50d399891d6so47711e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 13:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729716441; x=1730321241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OirxWHKjdKpWRDBbeAPd2l1jC+J3Pjl0j2pDjl1Tywg=;
        b=ieodzwY1KjSFrt3dVuNputJF9yWkWzj2HzYnbcae/L+Ey78Moo09ZaG/z+S7uFFADr
         Ld0UPCIvXtBWLpNOkx5xPaC4geZkDhjc+nCb7O32iK8mIj+Sg+Ru3NWcb5QP0F2xUeDu
         oh7ckMpTTLdi7VVSJJq1SKq/77YI2l32c/TtfyG4eKkM0wmT4hZdnzibHCFxOBOVyySO
         vXNkVeqRS+FQ6ObbD9WvM2hT/lL5K6yB/j1E5PPX/5HRs0vpLHD5+/KJFJs/Gxm9XKO9
         NpAmbjTPBODa5PEmJ8letNCbQSme0TwNwE6l6T36PyKCUFzGj3r6WU6v2Ij3h57OcVGR
         d3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716441; x=1730321241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OirxWHKjdKpWRDBbeAPd2l1jC+J3Pjl0j2pDjl1Tywg=;
        b=ULpMW2YV3PxXbYmfr0BMORTZ7sfi8br8HALQu/Rdk2nr2ifcI0BCN9cJuTAwfQsnAz
         qwOs6F1tuMgAQn/eTKWt5+kiig6DgHa4NsullNJiHMkCQ+ZIv/5ji82wcQg1PTYEB+wQ
         diohrIaQQUWBCVlLxNfJ42nqA2rJROrbo+xBjpSHFbyl6B4Bjp3P4Iu6IGapStj/ZXQt
         mBeAKDtGvnYhvZFTqUUFt78C1yUZTLs9pN426omSUsPKXkMqvUHMGYVufndh/OR/pWsU
         StUlG2TAXHp3C5cu2UC1974vTTU+XVqJE+5uxZpn5/2W4fueJJfOxZNpupBjVMdJDTf3
         aG2Q==
X-Gm-Message-State: AOJu0YxCOPPfxv5KIcWEXCoteyl89WfR2/sioI8RgDLYeU2/ph9Psvhc
	P4yNjwW7/ED2nzMDscnEMP6VqxPcixGLKmzEzBYGQEzWPh4nWKvZV9r8xg==
X-Google-Smtp-Source: AGHT+IGOliKWi6GAERLF3PWIDI6JLJSX6BqWes7SE2U8JxsgcdYYMzyC1ZDrhH7y0x6TUbPil0eyFA==
X-Received: by 2002:a05:6122:3bcc:b0:50c:55f4:b529 with SMTP id 71dfb90a1353d-50fd0313353mr4543894e0c.8.1729716440639;
        Wed, 23 Oct 2024 13:47:20 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19e0dbe9sm1168436e0c.3.2024.10.23.13.47.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:47:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1 5/5] client/mgmt: Add hci-cmd command
Date: Wed, 23 Oct 2024 16:47:05 -0400
Message-ID: <20241023204705.2422998-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023204705.2422998-1-luiz.dentz@gmail.com>
References: <20241023204705.2422998-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds hci-cmd command which uses the MGMT_OP_HCI_CMD_SYNC:

bluetoothctl> mgmt.hci-send 0xffff
bluetoothctl[44]: @ MGMT Com..nd (0x005b) plen 6  {0x0002}
        Opcode: 0xffff
        Event: 0x00
        Timeout: 0 seconds
        Parameters Length: 0
        Parameters[0]:
< HCI Command: Vendor (0x3f|0x03ff) plen 0
> HCI Event: Command Status (0x0f) plen 4
      Vendor (0x3f|0x03ff) ncmd 1
        Status: Unknown HCI Command (0x01)
@ MGMT Event: Command Status (0x0002) plen 3    {0x0002}
      Send HCI command and wait for event (0x005b)
        Status: Failed (0x03)
---
 client/mgmt.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index 602b92228ab8..59dcb3135344 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -2338,6 +2338,115 @@ static void cmd_set_flags(int argc, char **argv)
 
 }
 
+static uint8_t *str2bytearray(char *arg, uint8_t *val, long *val_len)
+{
+	char *entry;
+	unsigned int i;
+
+	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
+		long v;
+		char *endptr = NULL;
+
+		if (*entry == '\0')
+			continue;
+
+		if (i >= *val_len) {
+			bt_shell_printf("Too much data\n");
+			return NULL;
+		}
+
+		v = strtol(entry, &endptr, 0);
+		if (!endptr || *endptr != '\0' || v > UINT8_MAX) {
+			bt_shell_printf("Invalid value at index %d\n", i);
+			return NULL;
+		}
+
+		val[i] = v;
+	}
+
+	*val_len = i;
+
+	return val;
+}
+
+static void hci_cmd_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0) {
+		error("HCI command failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len > 0) {
+		bt_shell_printf("Response: ");
+		bt_shell_hexdump(param, len);
+	}
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_hci_cmd(int argc, char **argv)
+{
+	struct {
+		struct mgmt_cp_hci_cmd_sync cp;
+		uint8_t data[UINT8_MAX];
+	} pkt;
+	char *endptr = NULL;
+	long value;
+	uint16_t index;
+
+	value = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
+		bt_shell_printf("Invalid opcode: %s", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	memset(&pkt, 0, sizeof(pkt));
+	pkt.cp.opcode = cpu_to_le16(value);
+
+	if (argc > 2) {
+		endptr = NULL;
+		value = strtoul(argv[2], &endptr, 0);
+		if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+			bt_shell_printf("Invalid event: %s", argv[2]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		pkt.cp.event = value;
+	}
+
+	if (argc > 3) {
+		endptr = NULL;
+		value = strtoul(argv[3], &endptr, 0);
+		if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+			bt_shell_printf("Invalid timeout: %s", argv[2]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		pkt.cp.timeout = value;
+	}
+
+	if (argc > 4) {
+		value = sizeof(pkt.data);
+		if (!str2bytearray(argv[4], pkt.data, &value))
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+		pkt.cp.params_len = value;
+	}
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (mgmt_send(mgmt, MGMT_OP_HCI_CMD_SYNC, index,
+			sizeof(pkt.cp) + pkt.cp.params_len, &pkt,
+			hci_cmd_rsp, NULL, NULL) == 0) {
+		error("Unable to send HCI command");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 /* Wrapper to get the index and opcode to the response callback */
 struct command_data {
 	uint16_t id;
@@ -6016,6 +6125,8 @@ static const struct bt_shell_menu mgmt_menu = {
 		cmd_get_flags,		"Get device flags"		},
 	{ "set-flags",		"[-f flags] [-t type] <address>",
 		cmd_set_flags,		"Set device flags"		},
+	{ "hci-cmd",		"<opcode> [event] [timeout] [param...]",
+		cmd_hci_cmd,	"Send HCI Command and wait for Event"	},
 	{} },
 };
 
-- 
2.47.0


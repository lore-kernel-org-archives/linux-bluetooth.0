Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE01991CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612343; cv=none; b=aWIUVO5k7f/l3JYlxq0ktFytd886qdr0UeASU/iIFUbtHyXjoCCjYxt309Jz9VjVxEQtDdB1Oe6497wH3AK4R/5d/KnunzM4/0c8xzXpNgx9xVE+Gv5pDdi5a992sTbmKPgNAUEHT9ILv5k3ONWHN3xW9zjTKjK7o44lnmIMfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612343; c=relaxed/simple;
	bh=rRjSjYzmSlQoRZv6OFJRwoa2rYMglZ4crQnGyMkT7eY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0A/fTOS093JpiMKSfvyvbddWEK5E8F5WHsgkZytcvqOMGIpWF8532nXOltoDBVseiRtGDePb6OAUyNNzNismKCodbCOGJ0SO8TFq+z4rAaEg4Iz05uieni8RgcqqPEm6QBT6i8L1CvRAubwoF0e4GBTXgleU6dIfzUITfWHJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4hxr/Sv; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4hxr/Sv"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-856dd6862bfso51291241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 11:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731612340; x=1732217140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OirxWHKjdKpWRDBbeAPd2l1jC+J3Pjl0j2pDjl1Tywg=;
        b=g4hxr/SvhgC4u+6M94CD55ZsYaUQ3a8LOGp6oHTMjy0lX/TQd+AHHvoEODi7mOJMeM
         +uPponPjKNWH3PqAy6Hnx4hjN7lXgf6N1IZMcZYIc7MfGUU7bGEcutAVhyD6P1LO5Bka
         mfN5E8wfuUH7IhL3KsxHBdbJWqcs84WdeDIf6whFzlHaRLEvaQLBvswnZda9/qP98bTQ
         /2wLxgFj/CPWA7goK+ZTBYvPmmqWRMxS06U/wfSNe/4HC7CeZJc2FL56/WBPEhIsKBp/
         37q8yX7uUdeccvIB1Ld0QUtDKFstYDnsGbAWXXQ6U+NT9f7G7O3YI796AsjlOH3cMpjy
         3/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731612340; x=1732217140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OirxWHKjdKpWRDBbeAPd2l1jC+J3Pjl0j2pDjl1Tywg=;
        b=oVynQ0opu2C5U/sf9m7773tltHvxZS2GkUfJPOJjOgTaZzdGe5Cwb3SrzHNx3rgZL5
         9csfGOMaF23XEws95kxpBEDiwx8DOeB+q4QgggVd7x0CHDeVql47fDpc8Zwiih78Qzwq
         BkUUnO48douQHYa70reBOlMhQg1EveZxevTw896srizE/B2HhQh45VIDZuNGYAvF1CrP
         3iMiRWQzRfSSx4OG8k0nxS4okL+jVdKUVZ9kwJEG2MXbzEG2VLl55upgddCtib3lHRoc
         KRoJIpXfMr+L9Z/I9U4t65K7xHhtcA2wflx8x/bbwXGiOgmY7qk2F62Cn7qIDtCkyERQ
         IcuA==
X-Gm-Message-State: AOJu0Yy3OXK5r85uZGQf5OHrM20XHxMsaMju/OocUUYMKR9D7TGCxD/G
	AseZR7DjRC50oAQcrdZ1N5h7kTbGY+RBvJx9BSZ8OYKbnX7+jwDUgqQraw==
X-Google-Smtp-Source: AGHT+IHWTSt4ASa1Ina5jE/Qalob/o0zWUtsDa59FdW+Rbm0WZCutBJQja+A1Wi8W7CmvREFNTETXg==
X-Received: by 2002:a05:6102:b04:b0:4a3:d215:427f with SMTP id ada2fe7eead31-4ad62d4b61cmr219751137.23.1731612340437;
        Thu, 14 Nov 2024 11:25:40 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856ce622853sm213911241.18.2024.11.14.11.25.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:25:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] client/mgmt: Add hci-cmd command
Date: Thu, 14 Nov 2024 14:25:24 -0500
Message-ID: <20241114192524.1856334-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114192524.1856334-1-luiz.dentz@gmail.com>
References: <20241114192524.1856334-1-luiz.dentz@gmail.com>
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


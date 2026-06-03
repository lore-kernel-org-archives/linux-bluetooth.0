Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153963290D0
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513450; cv=none; b=ZVcCA8nGDLnkuYHYXEME2v3bkZ5+gyWNKJapwgcw0slFicYgs1oNlGdARALgT82a9qmMNW65Bo3v8uUoVixBjHR/Tzz9h5LeECjEe9FyQoD5zcBVPxga3ROHQQMnjIGoUS5/HgL2zjFAZTZPydHdJ5OmjxnqKr8IBWSDb8lF2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513450; c=relaxed/simple;
	bh=DdToZNjTlICi0tPV6IJNdXKo1ZVvsEn43pjDWikNRdo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dZ97JAaGex0ZpM5sG/VQOAG4NQP9pvJGSUtVOmT7hrBkEMIgzzY6hIWvj9RHlWjX73N9v4EBKWcYvHR4W2AMm5CBQWTuK8Xcn9i0MuB8L6z1ea0r2ctbxgbs86L4KkmmCyzJ3ro99p/htq8uH4U0evsm9V9S5mYah8Tfh3Uq8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btepiHer; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btepiHer"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-59f967189e7so1498309e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780513448; x=1781118248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6fSGHyk41lx0zxh2MGEQDHk2KV7KNSLtNId+EGvbGA=;
        b=btepiHerD7D+eeOzCT1yEuYr49VyvNAaAmSylXibk0k7nv2ywF2euJV2heVX3yyPPu
         +e5yc6qKbsZWTqyfmXSZHqEKzhIhX+alZjUpP7fClOHHJGZsdVYxdjOQ1rYRCeeKAOzB
         58L5k+e3itWA7o/kerPRf63VufaXyVw8zUSMCYIAsVDnO31tDQPA1T/UBCo4rPfeS/pQ
         +0k0QqlGsESwpt5pCLd+biNrQ0Fig67gt+vf96mYV/O3rnkLmdm83EyXAO8v/Gic7Cyq
         scQj4WXPgd06HjKQH6fWcL5EQNoGN0XVKeCPuT/+J7NfYiZ8K6IoMLY010oA46DkGOsD
         HZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513448; x=1781118248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6fSGHyk41lx0zxh2MGEQDHk2KV7KNSLtNId+EGvbGA=;
        b=gSH56REoi9geUAboU5qy5lWPsrdmrs7g/EMLGVE9ZdOk+gXxvKXmYkxwPfa3n9IvWY
         YL0zGvp+StYbned524CmeFFb1i3D0XHCUIX2N/hqncYuGDZjFZW6hwm8w5k0xUw+qOXw
         P6DkH0N2AEYDAb/ugW8bvwsnpF2nusX3wZavpnpL/8OilKmPRLRtWqIm1BuU0R49C2g4
         KbPxCP0ygdLQxlPw8ALsacPy7hSJ66mvl0FkBjtIyEYcZN4K13P2GbRpE2IsKOz0XbWC
         TXtsQewY18rNhs5ErB8S6BxIy3t1T2e7X3+x89JerG1gP+3PBHbXjkBTnICZgNdObGLL
         dELA==
X-Gm-Message-State: AOJu0Yznu9HeLGj5+nFmUlZt23cK+u+93E8aZrP1mYVxezcBH6V/pS9g
	UUnVD0+oKtj20V/oeK/ey+2W/fmNDOTKtOptAdKCZVB/yMcisKBLw/8/bOOdZK90
X-Gm-Gg: Acq92OEmD6ipWrOjIij2lJ+r7qEhp9yJhSKXBAbmKW0n75+RR9T7eCuNwp3Xf/VBV4O
	CyZpJg+SGYeZLZmdinPfZzP9im76X97cqgPrvaTYo1ZNbsh8DX2So9yC9CWJ0X7WRsaVz5ZL92J
	UzGTW2KXrCE4zXGoFIXpYdTzj7oeHi1L2t+0/mNPO/cZg2JF/zwv3S8d9xjbPI65P9+yeP7lP24
	J08nMw192CHAEB6dy056E9jnIXX4kzdPf4eFkwwC6uFOdbCs/4R1DAOnCbUAF2DTLUGYrIE9c+X
	+pQMLCrLa6FHewpogGemfU7wNKAQfouJYuN74oWZDACK4OBpGTcnS8SXkLPYHrUVSTTayydqeTb
	7mFGK01/BYwQT5FGibgjVxiQyENKhMFXtupsfvkfJjKHAlpoOW0ZyNcHDV7Tk5pS/x+mYJFjumw
	clkUGMLEZg3Kn3CoSOcLaKscj2oY1XAcXJ3TTINRcGGocIrm2/WAxnXdyBptIvtcxKj5oB5bgb7
	X08Ljt5UeZTfWKS510ZSBIVhsRWx6jLkDV5f6A=
X-Received: by 2002:a05:6122:7ca:b0:56e:f876:5626 with SMTP id 71dfb90a1353d-5a6e34d3da6mr3308604e0c.5.1780513447694;
        Wed, 03 Jun 2026 12:04:07 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d777996csm3181483e0c.7.2026.06.03.12.04.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:04:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] client/mgmt: Add options to ltks command for loading entries
Date: Wed,  3 Jun 2026 15:03:57 -0400
Message-ID: <20260603190358.425835-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for optionally specifying a single LTK entry when using
the ltks command. When called without arguments it clears all LTKs
(existing behavior). When called with an address and key parameters
it loads exactly one LTK entry, useful for testing.

Options:
  -a addr_type  Address type (1=LE Public, 2=LE Random)
  -t key_type   Key type (0=Unauthenticated, 1=Authenticated)
  -c central    Central flag (0 or 1)
  -e enc_size   Encryption key size (7-16)
  -d ediv       Encrypted Diversifier
  -r rand       Random number (64-bit)
  -k key        128-bit key as 32 hex characters
---
 client/mgmt.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 6 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 50558a313866..6d6ada95f43d 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -3535,21 +3535,107 @@ static void ltks_rsp(uint8_t status, uint16_t len, const void *param,
 	bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static const struct option ltks_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "address-type", 1, 0, 'a' },
+	{ "type",	1, 0, 't' },
+	{ "central",	1, 0, 'c' },
+	{ "enc-size",	1, 0, 'e' },
+	{ "ediv",	1, 0, 'd' },
+	{ "rand",	1, 0, 'r' },
+	{ "key",	1, 0, 'k' },
+	{ 0, 0, 0, 0 }
+};
+
 static void cmd_ltks(int argc, char **argv)
 {
-	struct mgmt_cp_load_long_term_keys cp;
+	struct mgmt_cp_load_long_term_keys *cp;
+	uint8_t buf[sizeof(*cp) + sizeof(struct mgmt_ltk_info)];
+	uint16_t count = 0;
+	struct mgmt_ltk_info *ltk;
+	uint8_t addr_type = BDADDR_LE_PUBLIC;
+	int opt;
 	uint16_t index;
 
 	index = mgmt_index;
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
 
-	memset(&cp, 0, sizeof(cp));
+	cp = (void *) buf;
+	memset(buf, 0, sizeof(buf));
+	ltk = &cp->keys[0];
 
-	if (mgmt_send(mgmt, MGMT_OP_LOAD_LONG_TERM_KEYS, index, sizeof(cp), &cp,
-						ltks_rsp, NULL, NULL) == 0) {
+	while ((opt = getopt_long(argc, argv, "+a:t:c:e:d:r:k:h",
+					ltks_options, NULL)) != -1) {
+		switch (opt) {
+		case 'a':
+			addr_type = strtol(optarg, NULL, 0);
+			if (addr_type != BDADDR_LE_PUBLIC &&
+					addr_type != BDADDR_LE_RANDOM) {
+				error("Invalid address type (expected 1=LE "
+							"Public, 2=LE Random)");
+				optind = 0;
+				return bt_shell_noninteractive_quit(
+								EXIT_FAILURE);
+			}
+			break;
+		case 't':
+			ltk->type = strtol(optarg, NULL, 0);
+			break;
+		case 'c':
+			ltk->central = strtol(optarg, NULL, 0);
+			break;
+		case 'e':
+			ltk->enc_size = strtol(optarg, NULL, 0);
+			break;
+		case 'd':
+			ltk->ediv = strtol(optarg, NULL, 0);
+			break;
+		case 'r':
+			ltk->rand = strtoull(optarg, NULL, 0);
+			break;
+		case 'k':
+			if (strlen(optarg) != 32) {
+				error("Invalid key length (expected 32 hex "
+								"chars)");
+				optind = 0;
+				return bt_shell_noninteractive_quit(
+								EXIT_FAILURE);
+			}
+			for (int i = 0; i < 16; i++) {
+				char byte[3] = { optarg[i * 2],
+						optarg[i * 2 + 1], 0 };
+				ltk->val[i] = strtol(byte, NULL, 16);
+			}
+			break;
+		case 'h':
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		default:
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc > 0) {
+		str2ba(argv[0], &ltk->addr.bdaddr);
+		ltk->addr.type = addr_type;
+		count = 1;
+	}
+
+	cp->key_count = cpu_to_le16(count);
+
+	if (mgmt_send(mgmt, MGMT_OP_LOAD_LONG_TERM_KEYS, index,
+				sizeof(*cp) + count * sizeof(*ltk), cp,
+				ltks_rsp, NULL, NULL) == 0) {
 		error("Unable to send load_ltks cmd");
-		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
 
@@ -6136,7 +6222,9 @@ static const struct bt_shell_menu mgmt_menu = {
 		cmd_unpair,		"Unpair device"			},
 	{ "keys",		NULL,
 		cmd_keys,		"Load Link Keys"		},
-	{ "ltks",		NULL,
+	{ "ltks",		"[-a addr_type] [-t key_type] [-c central] "
+				"[-e enc_size] [-d ediv] [-r rand] [-k key] "
+				"[address]",
 		cmd_ltks,		"Load Long Term Keys"		},
 	{ "irks",		"[--local index] [--file file path]",
 		cmd_irks,		"Load Identity Resolving Keys"	},
-- 
2.54.0


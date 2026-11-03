Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744405;
	b=TQbK9k2ZB3ZvV1TT/X3ILsjWyluNESXLKW2+snS8AlsIReiQ4F7t0xsCOfTTwmNbnLn2
	 plKfu5VJDPG+B6/QMrXGM5gNoJPrSoMm3/zpdK2lzezx4yc9Epl98wtBr7wpAibURreki
	 Lmz0gbTuwrgt/H5avyvf3COTVuZaWBOq2YNWbcevhteNQMtbwwGA9RNVdIDZ3LHJfCgiv
	 PPH2ZAp+wJGEE8g/Un4M11U5ZRuYyQcWlXzNT0ZXVLf2k3tjmorNHnCjZ9wK4pvCfYduQ
	 taTfI3hhpKnxlpO6w0GCEMDI+lLOxfZq6nUKczM7ZagJ+osiNYi9FMM/aaovGC5qAaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0WFrMss1zN36BDxO6eR4LeTIvk/0N0GrAKrmTkkq3zY=;
	b=C5PkLroM17FryRtuGN0e4dXOqjg+JQYDsCpAlslC56a43mNmnLZN8sLlJGS8x23TWUTc
	 oPFTfljK+U9giiYwKCojDenzkIH3PNOpjIkM7ZfKkKJPg76t1fw62Qu2z+aK4A9HsArjS
	 b/rkwtsS5DZhJVxQuBucql6AwbsJVvjJEvjTPooEQeaHhJtNaqB9lzyvuZZQby2q2DJLY
	 ILL9Uul+8vyBvo3Eez4s6ecn9uwETJIW4n3BP5a6HtwHRbao9K6ue09VXeCUACkxvsgdU
	 cX13fyNKHuWCCOAP42Qa+zLfA0RmdZOB6HscCKvmWNsIzMxHUDp2orLBAsvywFKhJxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWi+rTTa;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8521606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8521606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWi+rTTa
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so31073241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744404; x=1794349204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0WFrMss1zN36BDxO6eR4LeTIvk/0N0GrAKrmTkkq3zY=;
        b=uWi+rTTaW7uD2tJbw9yXZJsDC8IBIM1ez2TaR1G0KjBZnxRV9Qq5HHR5SHqCwVi17O
         OO5tQWx6VF30id7acdUc/q1WjwYbv69ARJnGUaK6Wm5ucXAkOXljk2KczfVRCMn1yB7z
         vtPj3ItVO3e3a3NTvIVi3uaGkhaZSsrZawEKOrA97aeYPd7a28kh0SmYc79h9wNpV7id
         zuD4PxRKut5TdqVEVQhiLY6u7ud+IThjuyAw2Iv78fQJX8ce7uNCsT246nO5GQ1hTodl
         oBe275kTHfpIqUK+pwa2My4F0scra2qcO7No1RC2OUebG9LDXwUeaVH50wC5YJQKhIar
         HF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744404; x=1794349204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0WFrMss1zN36BDxO6eR4LeTIvk/0N0GrAKrmTkkq3zY=;
        b=nQg7ZhobcPbM9aJeZBy2z8YBnDmquuCAmPeJWSLDWQ1lljwQXWOaaDFn6HS+4aMEmg
         oR/AKcOmSmi/T04drR+2HzglC/dEGIHMBlH7YEti0C5CqpPsxQjn6cwGlpPQxUhR2iob
         hI2WERMRdU4rIdUQ7QerWWMwiqZ6jaoIgeDajWwe37maiLW61i3V+07ubs4fTDTceZZZ
         i9OaHbm872R2wbiDqCdMFF7CzHQ4qiYhVpjZ5kRkIGtXhAWK2VsXlfzxw4hb8u5+GUvz
         K9RX5bNGDOZnjEmlYsHY+prKDa8VWsoxHSsGVoRsdvdpIj6JGN3nddMYsAk7Rh38TtiG
         WseQ==
X-Gm-Message-State: APuU4Z/1j3QsYQVcnJBmTKHUSvnRVOPJtoR0YDJQPyrsli43SES7DAEC
	sfrxoacGGD46Q72Y/1gNP7kDCnT/8kZS88jOOX+nDV0JkoYNNJe7HCJL5R5pBw==
X-Gm-Gg: AYBFou21NApdIum7G15yK1AtTXjOoB3/ysjSGhPNSqbwTzLCwVp1VlDH4cICv8U8BkQ
	ps1yZcM7odQYxNkQnGYXcrAOiItZ0D0kPKcSsvh9l4WQOdJTJ29WDt3etPh5v0SKjJnjSWqZ+sx
	yYeMcKNRZm228F3z/mgT+cpcLtCJqlE6vqIKFk0lR78J+pE6VUf9ahjWiYBuZwYslXrpwR1+mJr
	iizYemHZPl0Aq/ORsGy20HHpOLb29EsD2eQ+ENvgjuDKxwDW6UnDpXd/Y25IUHDL50MppkRrghj
	F8GSjcN3rjsg+qwInfrC/ymrCb1F6YGgae1DF5VaH5RuK7nDqZK/mWzkAjx16Pa3H7Q1LWv4jIL
	AFM9BlYI6SmFDMkX3lFng+6R/bU72ya37v5qJkNVt5A2F3KwoYavpuT8YwPa9a6lpuFqFrrn1jI
	mU6d6DRrp4i9Bf3nIp3SR+nnLriDIdPXzVrnH+12CRik/MWVo9Gvsxn/K0T35NegCCHXPo9tey1
	4znSWN0g70j7KnWhyNDoVzPEqnf3NphCbPmm9uVvPydGYOFzFuBXSlkEmxrkyY361IBUzYKiGA4
	Om7eFRf8gmVnDCuFsn1JMUjHWLfnbMtiMkzVt6X8eaEzGmpbz4yHtjSs+PKUktIjWPtEPcCJDS6
	g0GoxuVLd0zR9jgHxoKuRVW1XxuLlHqQ2ZwfGJ+ERj9XXfP5pNQmrLRG3JT8kIZK9QGoQN27st+
	MR1gI=
X-Received: by 2002:a05:6102:4413:b0:7ca:e2c1:9a09 with SMTP id ada2fe7eead31-7d0726d358amr4034693137.20.1793744403601;
        Tue, 03 Nov 2026 14:20:03 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm356591241.4.2026.11.03.14.20.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:20:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 9/9] l2test: Add HDT options
Date: Tue,  3 Nov 2026 17:19:43 -0500
Message-ID: <20261103221944.4072041-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221944.4072041-1-luiz.dentz@gmail.com>
References: <20261103221944.4072041-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add options to select the PHY, including the HDT rates, and to request a
MIC length through BT_SECURITY, documented in l2cap-protocol.rst.
---
 doc/l2cap-protocol.rst |  42 +++++++++++--
 tools/l2test.c         | 139 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 154 insertions(+), 27 deletions(-)

diff --git a/doc/l2cap-protocol.rst b/doc/l2cap-protocol.rst
index d53438924448..821de0d1beea 100644
--- a/doc/l2cap-protocol.rst
+++ b/doc/l2cap-protocol.rst
@@ -76,7 +76,17 @@ with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH.
 BT_SECURITY (since Linux 2.6.30)
 --------------------------------
 
-Channel security level, possible values:
+Channel security level, set via ``struct bt_security``:
+
+.. code-block::
+
+    struct bt_security {
+        uint8_t level;
+        uint8_t key_size;
+        uint8_t mic_len;
+    };
+
+Possible values for ``level``:
 
 .. csv-table::
     :header: "Value", "Security Level", "Link Key Type", "Encryption"
@@ -88,13 +98,37 @@ Channel security level, possible values:
     **BT_SECURITY_HIGH**, 3 (High), Authenticated, Required
     **BT_SECURITY_FIPS** (since Linux 3.15), 4 (Secure Only), Authenticated (P-256 based Secure Simple Pairing and Secure Authentication), Required
 
+Possible values for ``mic_len`` (LE only):
+
+.. csv-table::
+    :header: "Value", "MIC Length", "Description"
+    :widths: auto
+
+    0x00, 32 bits, Don't care (default; initiator requests 128 bits)
+    0x01, 64 bits, Require at least 64-bit MIC
+    0x02, 128 bits, Require 128-bit MIC
+
+When set on a **server** (listening) socket, incoming LE Credit Based or
+Enhanced Credit Based connection requests are rejected with result
+``MIC Length Too Short`` (0x000D) if the connection's MIC length is shorter
+than the required value.
+
+When set on a **client** (initiating) socket, the value is used in the
+``LE Enable Encryption V2`` HCI command to request the specified MIC length
+from the controller. A value of 0x00 is treated as "don't care" and defaults
+to requesting 128 bits.
+
 Example:
 
 .. code-block::
 
-    int level = BT_SECURITY_HIGH;
-    int err = setsockopt(l2cap_socket, SOL_BLUETOOTH, BT_SECURITY, &level,
-                         sizeof(level));
+    struct bt_security sec = {0};
+
+    sec.level = BT_SECURITY_MEDIUM;
+    sec.mic_len = 0x02; /* Require 128-bit MIC */
+
+    int err = setsockopt(l2cap_socket, SOL_BLUETOOTH, BT_SECURITY, &sec,
+                         sizeof(sec));
     if (err == -1) {
         perror("setsockopt");
         return 1;
diff --git a/tools/l2test.c b/tools/l2test.c
index 2e2606db13b9..5a7e5c71b10a 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -122,8 +122,9 @@ static int timestamp = 0;
 static int defer_setup = 0;
 static int priority = -1;
 static int rcvbuf = 0;
-static int chan_policy = -1;
+static int32_t phy = -1;
 static int bdaddr_type = 0;
+static int mic_len = 0;
 
 struct lookup_table {
 	const char *name;
@@ -142,11 +143,33 @@ static struct lookup_table l2cap_modes[] = {
 	{ 0 }
 };
 
-static struct lookup_table chan_policies[] = {
-	{ "bredr",	BT_CHANNEL_POLICY_BREDR_ONLY		},
-	{ "bredr_pref",	BT_CHANNEL_POLICY_BREDR_PREFERRED	},
-	{ "amp_pref",	BT_CHANNEL_POLICY_AMP_PREFERRED		},
-	{ NULL,		0					},
+static struct lookup_table phys[] = {
+	{ "BR1M1SLOT", BT_PHY_BR_1M_1SLOT },
+	{ "BR1M3SLOT", BT_PHY_BR_1M_3SLOT },
+	{ "BR1M5SLOT", BT_PHY_BR_1M_5SLOT },
+	{ "EDR2M1SLOT",	BT_PHY_EDR_2M_1SLOT },
+	{ "EDR2M3SLOT",	BT_PHY_EDR_2M_3SLOT },
+	{ "EDR2M5SLOT",	BT_PHY_EDR_2M_5SLOT },
+	{ "EDR3M1SLOT", BT_PHY_EDR_3M_1SLOT },
+	{ "EDR3M3SLOT", BT_PHY_EDR_3M_3SLOT },
+	{ "EDR3M5SLOT", BT_PHY_EDR_3M_5SLOT },
+	{ "LE1MTX", BT_PHY_LE_1M_TX },
+	{ "LE1MRX", BT_PHY_LE_1M_RX },
+	{ "LE2MTX", BT_PHY_LE_2M_TX },
+	{ "LE2MRX", BT_PHY_LE_2M_RX },
+	{ "LECODEDTX", BT_PHY_LE_CODED_TX },
+	{ "LECODEDRX", BT_PHY_LE_CODED_RX },
+	{ "HDT2MTX", BT_PHY_HDT_2M_TX },
+	{ "HDT2MRX", BT_PHY_HDT_2M_RX },
+	{ "HDT3MTX", BT_PHY_HDT_3M_TX },
+	{ "HDT3MRX", BT_PHY_HDT_3M_RX },
+	{ "HDT4MTX", BT_PHY_HDT_4M_TX },
+	{ "HDT4MRX", BT_PHY_HDT_4M_RX },
+	{ "HDT6MTX", BT_PHY_HDT_6M_TX },
+	{ "HDT6MRX", BT_PHY_HDT_6M_RX },
+	{ "HDT75MTX", BT_PHY_HDT_7_5M_TX },
+	{ "HDT75MRX", BT_PHY_HDT_7_5M_RX },
+	{ NULL,		0},
 };
 
 static struct lookup_table bdaddr_types[] = {
@@ -360,16 +383,44 @@ static const struct bitfield_data phy_table[] = {
 	{ 12, "LE2MRX" },
 	{ 13, "LECODEDTX" },
 	{ 14, "LECODEDRX" },
+	{ 15, "HDT2MTX" },
+	{ 16, "HDT2MRX" },
+	{ 17, "HDT3MTX" },
+	{ 18, "HDT3MRX" },
+	{ 19, "HDT4MTX" },
+	{ 20, "HDT4MRX" },
+	{ 21, "HDT6MTX" },
+	{ 22, "HDT6MRX" },
+	{ 23, "HDT75MTX" },
+	{ 24, "HDT75MRX" },
 	{},
 };
 
+static void print_security(int sk)
+{
+	struct bt_security sec;
+	socklen_t optlen = sizeof(sec);
+
+	memset(&sec, 0, sizeof(sec));
+
+	if (!getsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec, &optlen)) {
+		if (optlen < sizeof(sec))
+			syslog(LOG_INFO, "Security [level %d, key_size %d, "
+				"mic_len not available]", sec.level,
+				sec.key_size);
+		else
+			syslog(LOG_INFO, "Security [level %d, key_size %d, "
+				"mic_len %d]", sec.level, sec.key_size,
+					sec.mic_len);
+	}
+}
+
 static int print_info(int sk, struct l2cap_options *opts)
 {
 	struct sockaddr_l2 addr;
 	socklen_t optlen;
 	struct l2cap_conninfo conn;
 	int prio;
-	uint32_t phy;
 	char ba[18];
 
 	/* Get connection information */
@@ -427,11 +478,23 @@ static int print_info(int sk, struct l2cap_options *opts)
 
 	optlen = sizeof(phy);
 
+	if (phy != -1) {
+		syslog(LOG_INFO, "Setting PHY: 0x%08x", phy);
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy,
+				sizeof(phy)) < 0) {
+			syslog(LOG_ERR, "setsockopt(BT_PHY): %s (%d)",
+							strerror(errno), errno);
+			return -errno;
+		}
+	}
+
 	if (!getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy, &optlen)) {
 		syslog(LOG_INFO, "Supported PHY: 0x%08x", phy);
 		print_bitfield(2, phy, phy_table);
 	}
 
+	print_security(sk);
+
 	return 0;
 }
 
@@ -499,15 +562,6 @@ static int do_connect(char *svr)
 	}
 #endif
 
-	if (chan_policy != -1) {
-		if (setsockopt(sk, SOL_BLUETOOTH, BT_CHANNEL_POLICY,
-				&chan_policy, sizeof(chan_policy)) < 0) {
-			syslog(LOG_ERR, "Can't enable chan policy : %s (%d)",
-							strerror(errno), errno);
-			goto error;
-		}
-	}
-
 	/* Enable SO_LINGER */
 	if (linger) {
 		struct linger l = { .l_onoff = 1, .l_linger = linger };
@@ -538,6 +592,22 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
+	/* Set BT_SECURITY with mic_len */
+	if (mic_len) {
+		struct bt_security sec;
+
+		memset(&sec, 0, sizeof(sec));
+		sec.level = BT_SECURITY_MEDIUM;
+		sec.mic_len = mic_len;
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) < 0) {
+			syslog(LOG_ERR, "Can't set security: %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+	}
+
 	/* Set receive buffer size */
 	if (rcvbuf && setsockopt(sk, SOL_SOCKET, SO_RCVBUF,
 						&rcvbuf, sizeof(rcvbuf)) < 0) {
@@ -641,6 +711,22 @@ static void do_listen(void (*handler)(int sk))
 		goto error;
 	}
 
+	/* Set BT_SECURITY with mic_len */
+	if (mic_len) {
+		struct bt_security sec;
+
+		memset(&sec, 0, sizeof(sec));
+		sec.level = BT_SECURITY_MEDIUM;
+		sec.mic_len = mic_len;
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) < 0) {
+			syslog(LOG_ERR, "Can't set security: %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+	}
+
 	/* Get default options */
 	if (getopts(sk, &opts, false) < 0) {
 		syslog(LOG_ERR, "Can't get default L2CAP options: %s (%d)",
@@ -1355,7 +1441,7 @@ static void usage(void)
 		"\t[-K milliseconds] delay before receiving (default = 0)\n"
 		"\t[-g milliseconds] delay before disconnecting (default = 0)\n"
 		"\t[-X mode] l2cap mode (help for list, default = basic)\n"
-		"\t[-a policy] chan policy (help for list, default = bredr)\n"
+		"\t[-a phy] select PHY (help for list, default = all)\n"
 		"\t[-F fcs] use CRC16 check (default = 1, affects BR/EDR only)\n"
 		"\t[-Q num] Max Transmit value (default = 3)\n"
 		"\t[-Z size] Transmission Window size (default = 63)\n"
@@ -1370,7 +1456,8 @@ static void usage(void)
 		"\t[-M] become central\n"
 		"\t[-T] enable timestamps\n"
 		"\t[-V type] address type (help for list, default = bredr)\n"
-		"\t[-e seq] initial sequence value (default = 0)\n");
+		"\t[-e seq] initial sequence value (default = 0)\n"
+		"\t[-f mic_len] required MIC length (0=32bit, 1=64bit, 2=128bit)\n");
 }
 
 int main(int argc, char *argv[])
@@ -1380,7 +1467,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt(argc, argv, "a:b:cde:g:i:mnpqrstuwxyz"
+	while ((opt = getopt(argc, argv, "a:b:cde:f:g:i:mnpqrstuwxyz"
 		"AB:C:D:EF:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
 		switch (opt) {
 		case 'r':
@@ -1510,11 +1597,13 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'a':
-			chan_policy = get_lookup_flag(chan_policies, optarg);
+			if (phy == -1)
+				phy = get_lookup_flag(phys, optarg);
+			else
+				phy |= get_lookup_flag(phys, optarg);
 
-			if (chan_policy == -1) {
-				print_lookup_values(chan_policies,
-						"List L2CAP chan policies:");
+			if (phy == -1) {
+				print_lookup_values(phys, "List L2CAP phys:");
 				exit(1);
 			}
 
@@ -1591,6 +1680,10 @@ int main(int argc, char *argv[])
 			seq_start = atoi(optarg);
 			break;
 
+		case 'f':
+			mic_len = atoi(optarg);
+			break;
+
 		case 'g':
 			disc_delay = atoi(optarg) * 1000;
 			break;
-- 
2.56.0


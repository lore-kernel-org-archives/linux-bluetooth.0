Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349527;
	b=NOiLcqRLnZk3PTajuHSAep16ym7b140h4EWrTw93vuTVWRpV4NpxwCKI0g7xnl9I0JOU
	 yJ+HZijgO8zB3JMK+LkTQl6cI/hcLcLquTb3Ay8jv6IkuiaGurcQk5hZOtzNjD/SNPczX
	 1QI6E3faRJi8xdP10NrjM6ygGpisI3h9IuA1h8k88T3m5x5acuZ+0m8Yvq4wCsXGCKMYi
	 oDqiEdkW4v8K6OWS60eOPmOdcKlfdSFHNWxWO1p+O6bUgsIFARKga3jtydDFyEuMa57Fv
	 kMKCqSs4pS2RaEWwxrKwmL9+Zn7uIgLrPK+Qyf7SlBkDvaAKfKzr0AFaHx/IckyFqjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fSdA6H3IUtpUsjU2Pe3SBFdeVZwew8l6kDfhKEJFNRg=;
	b=bboPtCiqQkHpSBAp8YGQJQ6q47m2dsL7RNXRpNlC+kYGUujIQ5myxOVtRqXaRf23tRIL
	 Lc/u8u5apesPGYheMD7xLK0+luBL32Kkry0pmS8folgANgoSH/6hskZcvMcpUiHOVwn4b
	 CrKFqjG+tS+7BxxKhc7aHace9GMBMa26BwpC+8U8Ov1D3WK4IVf5mkh9Ma1Kd1fm7q2cr
	 XkIDrI5URRhO6IKkvMqNl7+bqGrCA1C6865pgl8T/0Oq6vBcORDRaaKLfD2Xv5R3XMb3t
	 eNR2cOlqbpAcGNA91Lj8x8mGBf3m8XKPstgkWDNAhkgONAMGtFM1aXkcSiTM7H+J3HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1hjs558;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7E606A335
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE7E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1hjs558
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9903fde8db8so700295241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349526; x=1794954326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fSdA6H3IUtpUsjU2Pe3SBFdeVZwew8l6kDfhKEJFNRg=;
        b=A1hjs558wHW9FfHSjUdaYOqToJPnjmKzZed8HpProZ6hoR4+QjQcpC39fnXbF7r1aR
         dLEFZCiWZlFSIAdKQehJ6ruR+EfE5/HwNqliRre7UJ6rG3unPnzq+e7t93VtNtB0Ih4B
         Hhf18zonAy59lYMHrAVWsKcyXZKACSGoKnJvsf1Qokbh0UHJ26diDF348bsSuC1dLaQG
         5wifARQPirzf3WFhMWVPIdlo2+UM3WIhjL8pJcGHXKZ3SrdpGp6qlKYfq++20aJyg+3B
         qkNaW8IB6sgXcULjlcYnAvHg+LS0P/p5xyHvEHAZTUKJGky/bg33ndtK53NrJ0XJz9Wh
         5jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349526; x=1794954326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fSdA6H3IUtpUsjU2Pe3SBFdeVZwew8l6kDfhKEJFNRg=;
        b=Gt2sOJwsvPjCjCaEk5mzypv3Rc121yH031YQ/chql0tKNCTpd88SHJRUmgTzvHJrQe
         9ttkXRfW1YsUaFz1bKjPiuxaYekWJW6Ty/jSo7hDseyUE0JyUzbT7qauLubVR6IbcZIR
         +HoweIdn5ewZWWALlDHO45DpMw0HKGtm7akPAifBCE20u7/vZ2PwUsoIe9kUaWyF0jnK
         a3IU2+UxbNYUrBT+bcn9l2jZ3Ad9utoon2sZ37umv9dgr+Y59OF9T1lJJ91J+9etIEVB
         AO27yXoQUEav+A/O4w7014yQHQsiEDPlLCHEC41ZrithQUgkMC8eH2edI0tuSYe4RYFe
         6blw==
X-Gm-Message-State: APuU4Z913brgRXx9BugrTnWv+noV2c5GiwO+2uLbo4ZF+bmfWoiltI2/
	O4Dw3w2arLtS0S6FeM1Q/kq/JSpvc8DEGIXyCrTlHvptoTXjkY0MzgEAfGOyPQ==
X-Gm-Gg: AYBFou2j5q0IofacRgXe+JiNFdUlBqdUdIl0G9wxoyzTZh6oirrszGd/N6H6OmoWRa3
	gsPJ5fXr/Zok6r6KuwlP3q4c9u0Y4PxLvTBGoDlHD1Evz7gSwkHbVF8wE5Lax7OSnCp5YAJ7BKW
	XKl4lQz5tzZjfyNOSZpIbSAraoLEQblmv/jfLLmZWSDOkeWUPQwpT9JcWvrDNUtPoplbmB0ssIC
	dfrFlc2LowG+PybHMu9AexNusqTBeSX82onZYgfUIY5Accwbnm2MviA1UAzHLhXiYDIJWx8iDEy
	BMnJ3zdbGR1SPQavE73mMfb+0h2Npd6UUC/F+6nzdmW0MfuWK28Hb9VA6pOi2EhuMkk9SjxkUbS
	aLo8T5MteDKLz0iYpK6nyqcIJ7GMj3lU7/4UR9bs5IRblYp5YCKAlr49llgGnZGLdKjvnblSjJk
	8cOyuLnu6OjwTfaPI5VJoBnKoPAfvhEfQG9DVVYoAZIrBsS1Uaoi0ndQCQfj/099lzq0xhIvylv
	3gGwdHW5xPHih/2wR+gbrdY7AE9SpM/jFmrW8P+2j+yAjXFNy+7ouc/B8KDV4R3EXbS+6bioEKY
	l0qb5dNIDcsaORu0cdRnuzlbPHrtCQf2Wcccc+1HffSFZjm+ncBKAu0ABlxinZvuomlyqRfUquG
	AbGgdxEDtzvuzxaKKxMpl1R3lAzhrRUQTdqe9yNZfrfKy9c8c69Sfef0UQW7pw/dCQ7O2Hml+9Q
	PQe/LsZIjaFu7o38YVB/XaR3e+og==
X-Received: by 2002:a05:6102:5086:b0:7cc:2946:7f69 with SMTP id ada2fe7eead31-7d4fb2577dfmr130128137.8.1794349525988;
        Tue, 10 Nov 2026 14:25:25 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30223977dsm2609190137.1.2026.11.10.14.25.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:25:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 11/11] l2test: Add HDT options
Date: Tue, 10 Nov 2026 17:25:10 -0500
Message-ID: <20261110222511.3011494-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110222511.3011494-1-luiz.dentz@gmail.com>
References: <20261110222511.3011494-1-luiz.dentz@gmail.com>
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
 doc/l2cap-protocol.rst |  50 +++++++++++-
 tools/l2test.c         | 169 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 187 insertions(+), 32 deletions(-)

diff --git a/doc/l2cap-protocol.rst b/doc/l2cap-protocol.rst
index d53438924448..c93e2f67abe0 100644
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
@@ -88,13 +98,45 @@ Channel security level, possible values:
     **BT_SECURITY_HIGH**, 3 (High), Authenticated, Required
     **BT_SECURITY_FIPS** (since Linux 3.15), 4 (Secure Only), Authenticated (P-256 based Secure Simple Pairing and Secure Authentication), Required
 
+Possible values for ``mic_len`` (LE only):
+
+.. csv-table::
+    :header: "Value", "MIC Length", "Description"
+    :widths: auto
+
+    0x00, 32 bits, "Don't care (default; initiator requests the default MIC
+    length)"
+    0x01, 64 bits, Require at least 64-bit MIC
+    0x02, 128 bits, Require 128-bit MIC
+
+When set on a **server** (listening) socket, incoming connection requests on
+the LE HDT PHY are rejected if the connection's MIC length is shorter than the
+required value, with the ``MIC Length Too Short`` result of each mode:
+
+.. csv-table::
+    :header: "Mode", "Result"
+    :widths: auto
+
+    LE Credit Based, 0x000C
+    Enhanced Credit Based, 0x0010
+
+When set on a **client** (initiating) socket, the value is used in the
+``LE Enable Encryption V2`` HCI command to request the specified MIC length
+from the controller. A value of 0x00 is treated as "don't care" and requests
+the default MIC length, 128 bits unless configured otherwise (see
+``DefaultMICLength`` in the ``[HDT]`` section of main.conf).
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
index 2e2606db13b9..d7a52fe0dc41 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -122,8 +122,10 @@ static int timestamp = 0;
 static int defer_setup = 0;
 static int priority = -1;
 static int rcvbuf = 0;
-static int chan_policy = -1;
+static int32_t phy = -1;
 static int bdaddr_type = 0;
+/* Required MIC length, -1 if not set */
+static int mic_len = -1;
 
 struct lookup_table {
 	const char *name;
@@ -142,11 +144,33 @@ static struct lookup_table l2cap_modes[] = {
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
@@ -283,6 +307,36 @@ static void hexdump(unsigned char *s, unsigned long l)
 	}
 }
 
+/* Require the MIC length, keeping the security level already set with
+ * -A, -E or -S and only raising it to what encryption needs.
+ */
+static int set_mic_len(int sk)
+{
+	struct bt_security sec;
+	socklen_t optlen = sizeof(sec);
+
+	memset(&sec, 0, sizeof(sec));
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec, &optlen) < 0) {
+		syslog(LOG_ERR, "Can't get security: %s (%d)",
+						strerror(errno), errno);
+		return -errno;
+	}
+
+	if (sec.level < BT_SECURITY_MEDIUM)
+		sec.level = BT_SECURITY_MEDIUM;
+
+	sec.mic_len = mic_len;
+
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) < 0) {
+		syslog(LOG_ERR, "Can't set security: %s (%d)",
+						strerror(errno), errno);
+		return -errno;
+	}
+
+	return 0;
+}
+
 static int getopts(int sk, struct l2cap_options *opts, bool connected)
 {
 	socklen_t optlen;
@@ -360,16 +414,45 @@ static const struct bitfield_data phy_table[] = {
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
+	uint32_t cur_phy;
 	struct l2cap_conninfo conn;
 	int prio;
-	uint32_t phy;
 	char ba[18];
 
 	/* Get connection information */
@@ -425,13 +508,24 @@ static int print_info(int sk, struct l2cap_options *opts)
 		conn.dev_class[0], prio, rcvbuf);
 
 
-	optlen = sizeof(phy);
-
-	if (!getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy, &optlen)) {
-		syslog(LOG_INFO, "Supported PHY: 0x%08x", phy);
-		print_bitfield(2, phy, phy_table);
+	if (phy != -1) {
+		syslog(LOG_INFO, "Setting PHY: 0x%08x", phy);
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy,
+				sizeof(phy)) < 0) {
+			syslog(LOG_ERR, "setsockopt(BT_PHY): %s (%d)",
+							strerror(errno), errno);
+			return -errno;
+		}
 	}
 
+	optlen = sizeof(cur_phy);
+	if (!getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &cur_phy, &optlen)) {
+		syslog(LOG_INFO, "Supported PHY: 0x%08x", cur_phy);
+		print_bitfield(2, cur_phy, phy_table);
+	}
+
+	print_security(sk);
+
 	return 0;
 }
 
@@ -499,15 +593,6 @@ static int do_connect(char *svr)
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
@@ -538,6 +623,10 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
+	/* Set BT_SECURITY with mic_len */
+	if (mic_len >= 0 && set_mic_len(sk) < 0)
+		goto error;
+
 	/* Set receive buffer size */
 	if (rcvbuf && setsockopt(sk, SOL_SOCKET, SO_RCVBUF,
 						&rcvbuf, sizeof(rcvbuf)) < 0) {
@@ -641,6 +730,10 @@ static void do_listen(void (*handler)(int sk))
 		goto error;
 	}
 
+	/* Set BT_SECURITY with mic_len */
+	if (mic_len >= 0 && set_mic_len(sk) < 0)
+		goto error;
+
 	/* Get default options */
 	if (getopts(sk, &opts, false) < 0) {
 		syslog(LOG_ERR, "Can't get default L2CAP options: %s (%d)",
@@ -1355,7 +1448,7 @@ static void usage(void)
 		"\t[-K milliseconds] delay before receiving (default = 0)\n"
 		"\t[-g milliseconds] delay before disconnecting (default = 0)\n"
 		"\t[-X mode] l2cap mode (help for list, default = basic)\n"
-		"\t[-a policy] chan policy (help for list, default = bredr)\n"
+		"\t[-a phy] select PHY (help for list, default = all)\n"
 		"\t[-F fcs] use CRC16 check (default = 1, affects BR/EDR only)\n"
 		"\t[-Q num] Max Transmit value (default = 3)\n"
 		"\t[-Z size] Transmission Window size (default = 63)\n"
@@ -1370,7 +1463,8 @@ static void usage(void)
 		"\t[-M] become central\n"
 		"\t[-T] enable timestamps\n"
 		"\t[-V type] address type (help for list, default = bredr)\n"
-		"\t[-e seq] initial sequence value (default = 0)\n");
+		"\t[-e seq] initial sequence value (default = 0)\n"
+		"\t[-f mic_len] required MIC length (0=32bit, 1=64bit, 2=128bit)\n");
 }
 
 int main(int argc, char *argv[])
@@ -1380,7 +1474,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt(argc, argv, "a:b:cde:g:i:mnpqrstuwxyz"
+	while ((opt = getopt(argc, argv, "a:b:cde:f:g:i:mnpqrstuwxyz"
 		"AB:C:D:EF:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
 		switch (opt) {
 		case 'r':
@@ -1510,11 +1604,13 @@ int main(int argc, char *argv[])
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
 
@@ -1591,6 +1687,23 @@ int main(int argc, char *argv[])
 			seq_start = atoi(optarg);
 			break;
 
+		case 'f': {
+			char *end;
+			long val = strtol(optarg, &end, 0);
+
+			/* 0 is 32 bits, 1 is 64 bits and 2 is 128 bits */
+			if (*optarg == '\0' || *end != '\0' || val < 0 ||
+								val > 2) {
+				fprintf(stderr, "Invalid MIC length: %s\n",
+								optarg);
+				usage();
+				exit(1);
+			}
+
+			mic_len = val;
+			break;
+		}
+
 		case 'g':
 			disc_delay = atoi(optarg) * 1000;
 			break;
-- 
2.56.0


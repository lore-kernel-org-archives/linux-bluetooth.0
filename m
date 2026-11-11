Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414493;
	b=p50iNnFCGMJ/npyq2Q6pxJWtdfjGZc9j/VrypAdSDuQ2/rsa8YjxfW1nBg6+tbsDxk9Y
	 dK+Cif6g2mlKjGMZMtVq8VN2WKy65ht//4s0ZKEYKidn9RpdrTKypf+rb8ig991/D1ljN
	 3fRh76soPZcqEuf95aFDTb/GydTjAGVolrjZNQJVt/mLXIcPsBQk4cVG6ipSXRzRNZbmN
	 T+40K1MkWol7EYZ7WtgQvYhaDc/Ne8EZ1W2jmnB8S1XgUIaTpNcvilrAs56neevyGiIaM
	 FcvW4AtwB89qEVaXPGLFNqSJUTnu0NwEfZTT2j1iXiMBN2O6CM/FOXi9ZSZcFpNebYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fSdA6H3IUtpUsjU2Pe3SBFdeVZwew8l6kDfhKEJFNRg=;
	b=nU47a/xk5lR8zb7dDv9I3xTVqUEvW2AlEf8XPaC2ZYSOlLx3J790VYnuKoI+fQqHpX4r
	 CBHPHVpvIJ+ucqnua4o4I/k7lBLYQch2xMZ6TTSnY+Ly5zrWlnogspzh8gSjPpjBcdxty
	 5lffsbz8TYewA7qh0U0V7xBt3g5bzRqxf9L3bGMAqeOMOMGl84IxEwJtPCSSKyqK6221m
	 TlnfOQqqq9MfH1gvB526S11iSJIaC9UQ1das1AzPkLcLRnd8a97mFRmb0V0Nw4AWYRi7e
	 wfzn5agKP8O8nxf7hAfJTv2jN2kRJCXzqWmxVxTJFv+wn7jyUH639CvkRwYPduO7cEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HcvVC2xN;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB596606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB596606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HcvVC2xN
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9905d61449cso960326241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414492; x=1795019292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fSdA6H3IUtpUsjU2Pe3SBFdeVZwew8l6kDfhKEJFNRg=;
        b=HcvVC2xN/y6QK3Nt8QEdYMvuC8kW7rRKoandY8EgdobdXb2Drr/9UsR1lIeewWzz4e
         VW5lIcFOL+Ft8Tj0D8fXw/f3TmPLXUZqr657cBREvjTB6JZ+I4wHlHLRZoFgbHoPZ6/f
         fN6mXbE00utQMXkdoi3aC4umRrAnP0SJ/oJNdIbpjXwxBIjEjTfXZKPFhhNIcfV1uf83
         hsJMPtvxmgKgPvEu3MGiaC7E71eEaBLMepKOaw/XI1oq0ckghbhgXtxklvGr9Qz3P1iB
         1/QK7fO0WT6HyuyTrmbzJ2iEr6DCfkTp6LuHyLdc/pWvCXtMJGDpIvm9SgdXzXnqADlf
         vJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414492; x=1795019292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fSdA6H3IUtpUsjU2Pe3SBFdeVZwew8l6kDfhKEJFNRg=;
        b=c9WWNFqs7nK7Hw2Vjo4EH/wjmeGgUd95g9oour8IttNtrOStbM2qa92YDC2PsYSGFb
         6OLsK4pa34aWBxwhxehdi0+is39QP/ucA9KE1dkTBlN+hccLgOTMgfTW1aB9VTKxk+UA
         miQ/B5XrIqnmGYfgS+50Ms0Gw2UFjdh8mY70C7xWZ6n3O8glYhauv9/mEkkHyLscP+Lj
         En/ZbpMofSR14CyJ1l9ao4lq1Er5pTLKYGDAoIkiFnbsSxydKaFGCUmEwxXta9rdA6oU
         +Qw6wm5LZ8+wq+WJhnhaDESwO6pOW5P1PbyGBj0hy1kpLk1s4CWSoCF8b/wZhk2c7Rl+
         BKlQ==
X-Gm-Message-State: APuU4Z+gM/guOXdVyi8ugD724FqplC9d4cpcfIQA3lETd1YUVGJ4CYyh
	hzy+7QlahiKC3laKt/KXNfViL/PNGXW196VH/9TzWWEwjmyp7D6zj5F0Nsa8ig==
X-Gm-Gg: AYBFou3L6YvEQs4Vl8Dw6UJvks8MdcjhZYDDL4+h+4MBCgiUe8CiXABZiJtSkZuj39N
	F1HJwWBPs/go/PYPJFKUTNt9k4LRqk1N8h11KWUzzUCnVTTdhKS5BdQVvOgCYQGG7MmIERpljk2
	Cq2spKN9pCsUNYHTxdkE2dvZaQ4UFTLV0XCSCeuyi5CUX1ekkfSGGlfT43J+5CshiSodnnEN8eI
	Y59mwjckMwMQVqbs758L+r+KneWeLRqXFTcjqq6JA+7/FpD1+Ox/4kEjWbAR301eDfCM4JajLeP
	LzmolqXiUFD0XCsTmBZ+137wbeDJX03DkYBIcWdKA3Sa/+LZqAZNsBs/IcemA4viaWPYExD2ACh
	LCaKAiPmcHLZ1gaq64UM6vhtkMC6H+7FFcuD2JnO+rVcp2PwfiPF2f0TNrim4eK/TVgDLYjHYbx
	UHoMTfLN7wF8ufDFXkxorWymlDam3AUCgXvEochFHwPJoMxpsJU82VpTfnZvia0dWioanFsIinB
	OTR5AmteIHuv4rqXoFUlwjWc0epYSRix0oKVCiXb89XxD/vVERIeyHfkuVuyv10dgeukFvFhTVD
	AHerdLUX054f9alzfHmjaWgS/hE+NjczKE4b5720RP3z2rqVhF0vwCXlNb9tVRsaptE2L4QT2LK
	K4wK9X4e4uoDZ026AoLomxLoRFZh85y6pBTqmdUplUTEYurRvf/2l/g5EXJUn26I1/BRBkcQkk/
	HGunhvL6Hp/eXGSdUucJ11xb6S
X-Received: by 2002:a05:6102:148f:b0:7a8:2a34:432e with SMTP id ada2fe7eead31-7d4fb256de4mr954560137.9.1794414491317;
        Wed, 11 Nov 2026 08:28:11 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5ab918sm4007081e0c.7.2026.11.11.08.28.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:28:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 11/11] l2test: Add HDT options
Date: Wed, 11 Nov 2026 11:27:54 -0500
Message-ID: <20261111162755.3506226-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162755.3506226-1-luiz.dentz@gmail.com>
References: <20261111162755.3506226-1-luiz.dentz@gmail.com>
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


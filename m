Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240978;
	b=Z19IHddajztudCfMXaj6PJD5KeSsnO7uKnRI0DooSMbgZeXFsGP1kaVY8juLybGRhfYf
	 Bh9rlXm1DdShQLYc3Rx5T9JxVmjxcXYqksLFeBB1XIsQUYvvFD8phSASGyclvMnFuv/Q/
	 ywdtKqdkvevFJplk0c9UfwQwqTdKSV1i+Zgsx4gGObvg4dntZYZkir2cEvn+ibTwZwnQc
	 PFLL/j0hQL0P3fEjU84yeLUQNggx/ePbkca5uS+768/3PxU1Ch2bKc0TYLX8HyHZ5BW4p
	 lRPYD17/YY6XP0vV5YAn1J1nelvHnbyBUepJ253+VPQ9fa1QlzCVGDQ2xsDNaTFauag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fSdA6H3IUtpUsjU2Pe3SBFdeVZwew8l6kDfhKEJFNRg=;
	b=IqOOQI+XTADkcMARt6c2+aVkAkDxSra1JBXictY15pEsyM79aybszzVOav78A8tg7YyS
	 BaViZiRKJ1Ss7zJPpx0acvEU/zMYA76ErRuYjoJyapSfZHSp8cjkzeR1aPMQRpGozYSHB
	 Um2NLocR0R70Qyfy8TxFZQXnkLGqGLVa/ed6Q2tVCsyDL7F9H4OsbO9eM1/Zmkp72djta
	 yz5qIV0Do7mjUw1LvgK9urczIuUC9GjYOLbQvuRasR6nG741qD8gbVWGVPwtyEHwRKaqO
	 fkwUPkPlHRJ4C7//1a5iKNSribOQOXiSF/2XO1nr/LYKPU1q8zjgQA5WXywZqq8ZB8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vVdUWtxh;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8C606A33D
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 16:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07D8C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vVdUWtxh
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so716382e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 08:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240977; x=1794845777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fSdA6H3IUtpUsjU2Pe3SBFdeVZwew8l6kDfhKEJFNRg=;
        b=vVdUWtxheXZ/IOTRP09cukc4TEqi+HSXCS5UYgt8eVJC03xY6NLVgVCuw0tuZ7UBV3
         kQ4KgC84XE2Z3NlMftGD9iZTvt/M3lyIGw+wbsfGgFWAXQVnMmuVW9JlSWuOzmg4rzsI
         7OMSV64U6Uxr6wrnxFfM6sPBwoNn8DnyTvgFV/E2gpAblFAGU97x3yXao5tQIcKLt2SE
         WRohaw1eZKfX/3w4KaR8PBSQTV5+RK/6OmF64yoYBKVyHZmGGtTt5eoTTjzKCedTBXwY
         YT1aUP3eEkAbOXjSVXqCcRq/oh+jLBkP4dSyAeSh/JPSFpEgK8/czZbkkuvZjCzqs8/2
         FnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240977; x=1794845777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fSdA6H3IUtpUsjU2Pe3SBFdeVZwew8l6kDfhKEJFNRg=;
        b=ar+UJ5GOugv5+P6lZZcFnuDu59gkI+XvGv0ApvnFeYAqO5mVbfom1V2eSIrEfRhRT6
         jG/S9iRvEt58gRNgEYgAYEd4wVl4SMINyD+gouA4O/TDcLXz+QTlOecxcHyeVxROQBRF
         82OIrjjuhM8AD/jwYwry95XZ58JxZ1CyyzAEuQCjMvy+CNA2VTfW5Eaik3RmF15sGurj
         u5MB2AwvfVAmsE4kiVFX8IZ1nOdMD4Lq7ettt0tW3F6IHneXDpufdRoKo/cyWwAa4VRs
         CTxbmxArP4GQsbDSrATzbf/EhYQvjbTfdiKrLcX/ZOJJhJDGVDeTdRI8Insr+sUCmql5
         we3w==
X-Gm-Message-State: APuU4Z/C+I7rptlUw7n5uthUoeSpFAOQ8w70IQFYYh8K/wSOyJCa5f0J
	MF4kfB65yXhNKtAt03dzX8d0ZYbkud2/LBqEIYPWd/ydJswSVOWQYtPIoSaUDw==
X-Gm-Gg: AYBFou3qmfF6slDDao4wcS0FeSI6ebxk+/flYvxtq5moXEynsQ21vTTZuMU5IK55Ulw
	M058sPKzUaukzAJmLD++ndGZXRhMcApPg0kgy6pmDXNXKaoVTnnSAcbFiVfBuMR2G5yw5MeNE+F
	keJuPhjMIGARbn5pvjcL20iRMuQgh+VOJIyTY87KoqBm0H+rOG+d0h+wDu0+Bgk2o4QFAMjDzwk
	4EBOo0s0hjDThp7rxyt0F9GKGgKMYRf4IvmGZnyjoAjwYFNB8Ah5NqbW3ThnpLACQ2O3fX29aeh
	4J2MG/gQem7qlDpklwH7/OxfoOW/GyQ9uXYGlJL09GYmKiZMPLzV8Y02mYsYVYxmwdPzmL7mr7Y
	3pbIcfAwbuNLpjBZMDN8vC2tkQOwuiXTqeJGopsgDhy4JIyatudX60I0zaPqHSlcnlpOd1fxzVu
	T/6S/JNFAj/wK99E8JIVNG6BX5GPsGc8wxn49gaq7nhgNTd8vqxHKW9CCLkdtvZn4elL+y4hb/j
	YiUBYQVgGSdH7TZxyGOrCqpbJGNg4LeXLEz+2TOPsBvq/sXrsDUdVp5tfMmrgVX6VdgOli10VD0
	aWCRLapux7rtz5Pu4ZDWXPuLzWi0KmWTURcgIWZf3Yjsv7bzMEonKnyqTjH57K+UvxdK9VGua+q
	Z/KB9oP6tR0Hi9dXpfb6EUDEzSa68LFUAPBt/QI53AmTI4W1M+nboXFv2uEpzRbNRgtANyLgfcV
	YsYAw=
X-Received: by 2002:a05:6122:786:b0:5ea:dc36:245b with SMTP id 71dfb90a1353d-5ece735529amr1709118e0c.18.1794240976593;
        Mon, 09 Nov 2026 08:16:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece66b77a7sm4562733e0c.17.2026.11.09.08.16.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:16:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 11/11] l2test: Add HDT options
Date: Mon,  9 Nov 2026 11:15:51 -0500
Message-ID: <20261109161553.1506041-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109161553.1506041-1-luiz.dentz@gmail.com>
References: <20261109161553.1506041-1-luiz.dentz@gmail.com>
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


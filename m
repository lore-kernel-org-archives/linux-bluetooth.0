Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817419;
	b=OFnB3jSPV3arztwAV6H7u58/iVMXZX6FqLmK/mrPLHgp1eZfu6sZPaQzDwuQNuAnc9i0
	 yVOjcKn/oOACEu8L+qY7qbn1YAqwFWQnh0dq7fnmWsalZgpvT9FUGPREzFCemwvsxS3k1
	 k8ntPwsoA9ZzetPgN5bUSmf76jUdJnRlvxGfj7peKS7kiDYJoaR5WYRQzVqwtkkkjYXA6
	 Frc+GrEfEZUPbZdtOJjlr5sswjAiHnnLjTjn9uxBnkjFnKvONWQ1AVCymAhR9B4bGriPV
	 jGjY5DExqyRlM07W2jR/7ZUiZwFz/ZvTBryR40fnmXtpao4OMNbbOighth1dszOayRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MJL1mjkD5gVx7J+wANnzzKiNBlToKyks262olnNYcxA=;
	b=kYX/wVTkIYsSnAQ9pnM3RYkApgcNYcHi3946vQusYyeozx4w4Wj80jTrj08RDf6rk4d6
	 Br0S6+eSzkOdTrjaG2kKpND/T695XsHmG7muWdQ9KyycL+k4gWgw0jijjMcnHIQSyi+Qk
	 abeyPM1A6YwnH+SmeNfuXvZiotkweHg+4eTI8fiUTUn2mJGKYJl5KsUa70EVty8Y1zj9m
	 rtJwF4SJxuqxSXTs1wnnJ9pRsk2ExkyN0J/ntwxtcPlMy4DVsDPw86G/FPA0umzJYEPTz
	 o0/l5Oj0z0BxAxrAhI32hGNhW75KOdVawmyOYu/5W8RD4VkF3T1miqK5iFR/FSHHOPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pEFxwXZu;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C382606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 18:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C382606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pEFxwXZu
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-998749fe872so593829241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 10:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817417; x=1794422217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MJL1mjkD5gVx7J+wANnzzKiNBlToKyks262olnNYcxA=;
        b=pEFxwXZuAHql0KBFHcQnCszob62k/U6+pxIsRypCfzGT3GqMZEMqA5qxZg1x/1jwxE
         6Y+aOkjOmeNM2PcvR2MfC3yOon4OgYIjpBegLcWPJFhlPjuBruA7ppCLX4w2S2qiwCyH
         AjULdvPaDkv30LjX/TH+tJCk8Uh89JvVtPpT8M+UaD4/RXVluc9c4akpFc+uWY4o8RRs
         gmtDvIkdeYA9cLoHaZMqMSQuPBVCj987vsfISr8RatLcMsINTYVdOpM5m+doDUpYlakH
         MC3eBqS8i6N0oOkhJc1ffnO01D4KgTn7N/ZMnJaGaU+MIZ6Y0PpLsHw7dWoZaF0GVKke
         EbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817417; x=1794422217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MJL1mjkD5gVx7J+wANnzzKiNBlToKyks262olnNYcxA=;
        b=y2qDo21nvqA9BbT8PPX/2XTueWn9t1q/SUAockUOMcb9NJhmRndfYcaMgZ2QnSjlHH
         3oTDJe8oEtchsVRXh33CRd8c3sN8YJnFvCZ/foJR3/fLn2k901yJ9XKRGFsH72Xw2I4H
         Nvz5mOctCe5Bodmic0595a1KgQad8FnWihYkNTyhYovDT6MbQx3IR5ME8hwKtdK2pX7F
         kSRHHcbwhdBBNon5vTWlS9Q/YKddwcx1XPHTS1ybAQHATSVY24aU4iERx1nQja+24lN/
         zymJsKBqmxqgYGO0bXqJVCSwlAGrr+4SaQf9gerMoPTvqeFylzX30eg45k3ZBt5Ehb2u
         JiZg==
X-Gm-Message-State: APuU4Z88Uj5QujFeUz3xvI2+8m0BnJOWgj2EpSWz/3WKDId2ALytruCj
	yWgppQxxZQWmBFIqxjBnrbzVPCzDRDwH1mCYEz4ODOG312fxIoVR5DBDGd/a4Q==
X-Gm-Gg: AYBFou06vZEhbSy3zLR6ToNIS4gT2OmuI49qWSwlaa4auIrV8c2gr8kt2IPyWnUMg4N
	SiA6nvNMjB21gcnGh/75sXX9f7lG8bpZYbMDvkGsOlbFaOPvJqSf9wklufIGnQvL04St2UsFVMr
	Gv8M33G6Fl0ufRCCtaASQ+EX+gNvUKvVdLXqHqbckiNQrW32NwbjjDGMGP5iyGHkXAh8L74Z++G
	Dd+GxYXFal8ez2Y1fjng7Xx2TlXcAWu3M90zzj/AwXrNTWXUuL0Xt/13FDeL6OuFK+/6Suvxi/F
	bJ3EmXsNeJ5wkVo2StkGquw+EmGn7h5VSyvcMW6e61f0lhe5WIFT6k9uT9CB1HxMMgUQNGBivjp
	pwynAI2ivtS8kjK2vqzHGwF5omeiZViA8iOTtkFWJlXPE06WlbJs3/x9CrwwRrwun3X/GeRRy8T
	91XNBKAz/HNkLHHCKvSdj2GGME9EqlB2a3K8lA7d/BqDYDvwK3G0gOWb3e7ZRv0XGTDfkei1VL/
	npscIFzDDgz55kUlP6FnTVIEwmAjwk+ifqfbs9DijykZ+EOillNi+pthqZzoL8Z5OjZ406emLft
	kazEi0iUALlxicfa0uAf8i1+TapjXYyekbSzNn+cRePJXvHMvYnhw0eGtVJrn8F7EbXttNU0GSt
	8cCT3APyBkeQHGqHGQ62clFmI/tDzDgv0Z2CH6HnEDsEGhVIAZUhDCwxDL3IaU63PcmPiI4xa3R
	+BkWk=
X-Received: by 2002:a05:6102:3e85:b0:7cc:306:d3ab with SMTP id ada2fe7eead31-7d07277bbc5mr7626407137.5.1793817417460;
        Wed, 04 Nov 2026 10:36:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm696605241.9.2026.11.04.10.36.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:36:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 9/9] l2test: Add HDT options
Date: Wed,  4 Nov 2026 13:36:44 -0500
Message-ID: <20261104183647.839090-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104183647.839090-1-luiz.dentz@gmail.com>
References: <20261104183647.839090-1-luiz.dentz@gmail.com>
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
 doc/l2cap-protocol.rst |  42 +++++++++--
 tools/l2test.c         | 153 +++++++++++++++++++++++++++++++++--------
 2 files changed, 164 insertions(+), 31 deletions(-)

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
index 2e2606db13b9..86749ff39d62 100644
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
@@ -283,6 +306,36 @@ static void hexdump(unsigned char *s, unsigned long l)
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
@@ -360,16 +413,45 @@ static const struct bitfield_data phy_table[] = {
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
@@ -425,13 +507,24 @@ static int print_info(int sk, struct l2cap_options *opts)
 		conn.dev_class[0], prio, rcvbuf);
 
 
-	optlen = sizeof(phy);
+	if (phy != -1) {
+		syslog(LOG_INFO, "Setting PHY: 0x%08x", phy);
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy,
+				sizeof(phy)) < 0) {
+			syslog(LOG_ERR, "setsockopt(BT_PHY): %s (%d)",
+							strerror(errno), errno);
+			return -errno;
+		}
+	}
 
-	if (!getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy, &optlen)) {
-		syslog(LOG_INFO, "Supported PHY: 0x%08x", phy);
-		print_bitfield(2, phy, phy_table);
+	optlen = sizeof(cur_phy);
+	if (!getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &cur_phy, &optlen)) {
+		syslog(LOG_INFO, "Supported PHY: 0x%08x", cur_phy);
+		print_bitfield(2, cur_phy, phy_table);
 	}
 
+	print_security(sk);
+
 	return 0;
 }
 
@@ -499,15 +592,6 @@ static int do_connect(char *svr)
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
@@ -538,6 +622,10 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
+	/* Set BT_SECURITY with mic_len */
+	if (mic_len && set_mic_len(sk) < 0)
+		goto error;
+
 	/* Set receive buffer size */
 	if (rcvbuf && setsockopt(sk, SOL_SOCKET, SO_RCVBUF,
 						&rcvbuf, sizeof(rcvbuf)) < 0) {
@@ -641,6 +729,10 @@ static void do_listen(void (*handler)(int sk))
 		goto error;
 	}
 
+	/* Set BT_SECURITY with mic_len */
+	if (mic_len && set_mic_len(sk) < 0)
+		goto error;
+
 	/* Get default options */
 	if (getopts(sk, &opts, false) < 0) {
 		syslog(LOG_ERR, "Can't get default L2CAP options: %s (%d)",
@@ -1355,7 +1447,7 @@ static void usage(void)
 		"\t[-K milliseconds] delay before receiving (default = 0)\n"
 		"\t[-g milliseconds] delay before disconnecting (default = 0)\n"
 		"\t[-X mode] l2cap mode (help for list, default = basic)\n"
-		"\t[-a policy] chan policy (help for list, default = bredr)\n"
+		"\t[-a phy] select PHY (help for list, default = all)\n"
 		"\t[-F fcs] use CRC16 check (default = 1, affects BR/EDR only)\n"
 		"\t[-Q num] Max Transmit value (default = 3)\n"
 		"\t[-Z size] Transmission Window size (default = 63)\n"
@@ -1370,7 +1462,8 @@ static void usage(void)
 		"\t[-M] become central\n"
 		"\t[-T] enable timestamps\n"
 		"\t[-V type] address type (help for list, default = bredr)\n"
-		"\t[-e seq] initial sequence value (default = 0)\n");
+		"\t[-e seq] initial sequence value (default = 0)\n"
+		"\t[-f mic_len] required MIC length (0=32bit, 1=64bit, 2=128bit)\n");
 }
 
 int main(int argc, char *argv[])
@@ -1380,7 +1473,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt(argc, argv, "a:b:cde:g:i:mnpqrstuwxyz"
+	while ((opt = getopt(argc, argv, "a:b:cde:f:g:i:mnpqrstuwxyz"
 		"AB:C:D:EF:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
 		switch (opt) {
 		case 'r':
@@ -1510,11 +1603,13 @@ int main(int argc, char *argv[])
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
 
@@ -1591,6 +1686,10 @@ int main(int argc, char *argv[])
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


Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938A29D265
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784403783; cv=none; b=tBpnsSqTZRND0dJPXSE5en1vrnCnHd3MSjPdmYCYE0puq5aRmq4MngG9Va2q6mqG9CyEiBwCERJ2qUUkPzrX6ngUSAiENwXVpyLnPNS4qxGC+T4x+8274DrTr+xGZoQ+g5vJ6VVsDKMgtHWwZqinxwhq0Sl0p0ElLyLZDgZqfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784403783; c=relaxed/simple;
	bh=qhL2QjWaBDKVKS/dIu9U4/yR53loh/DcsR8cVRZnhk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHcnfgmF6gBcDWaovu90+L2bUFcIkQRc8XzoHRLlVQWjGZp5exVTPxQnP4LzJIFmrBs8pG5ST4OQti0Dyssr7gSGheR17xkmoNchJGED5lLaaMIXfV72rN+OhWxeVg4aC/NzwsPr1tYC4Uy3NSzeQy7gowK5gVisITQkYb7HGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com; spf=pass smtp.mailfrom=pipobscure.com; dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b=Q1eOh6jA; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b="Q1eOh6jA"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h2cdG0Q4tzKmxW;
	Sat, 18 Jul 2026 21:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pipobscure.com;
	s=MBO0001; t=1784403778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naoH6S2iGrMIudH/LnyWct0IkDh1YN1YziB8IZ1SF74=;
	b=Q1eOh6jABej35BGBEkp/FoAWMqVeZJsPPVe0X7+Mpux7/w6rr5C4CLwgCbbwzdrV09DRzN
	O1ap1LjH2kViQDuKE2mkjaKb03PuT6LOzkbXNoud2ggyzCEIts6+sF3SQiuC8CQvy570on
	qqM1dSwX4X1YyR30LLt6PSI0n6envlxbnGFXZjMjxceY4I2W3L91ffVvFh3WHIxWr9RTs/
	9LyEg+tO7JD29g4+6KodSh8X+SsZ38Ts2WMnNMSy7REnkWHucd2Arw7x6LhbMzNr0h0JQN
	H+Ap+0p2r0zPrWtI6fqbWSmP+mfyjm438duQ93Do1/DGyS7y5nB4KRcszCqSSQ==
From: Philipp Dunkel <pip@pipobscure.com>
To: linux-bluetooth@vger.kernel.org
Cc: Philipp Dunkel <pip@pipobscure.com>
Subject: [PATCH BlueZ 1/2] shared/att: don't auto-bond on reactive elevation
Date: Sat, 18 Jul 2026 21:42:29 +0200
Message-ID: <20260718194230.35959-2-pip@pipobscure.com>
In-Reply-To: <20260718194230.35959-1-pip@pipobscure.com>
References: <20260718194230.35959-1-pip@pipobscure.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bluetoothd connects to a freshly discovered LE peer it probes it as
a GATT client through its built-in profiles (battery, mcp, ...). If one
of those reads a characteristic the peer has protected, the peer answers
with Insufficient Authentication (0x05). change_security() reacts to that
error by raising BT_SECURITY on the ATT socket, and on an unbonded LE
link raising security starts SMP pairing.

The result is a bond that nobody asked for: no user, no agent, and no
application requested it. It logs as a device_bonding_complete() bond
with a (nil) requestor, and the user is shown a pairing prompt for a
device that merely came into range and connected. On phones and laptops
that expose authentication-gated GATT characteristics this fires on
essentially every connection.

The existing opt-out cannot prevent it. change_security() only returns
early when chan->sec_level != BT_ATT_SECURITY_AUTO, but
bt_att_chan_set_security() records sec_level solely for BT_ATT_LOCAL
channels. An L2CAP/LE channel keeps its zero-initialised value (AUTO)
for its entire lifetime, so the guard never triggers and the link
always elevates.

Add bt_att_set_no_auto_sec(), a per-bt_att flag that makes
change_security() refuse to elevate. Set it from gatt_client_init() for
any connection that is neither bonded nor in a requested bonding, so a
speculative profile probe that hits an authentication-protected
characteristic fails on the auth error instead of silently pairing.

Devices being bonded via Pair() are unaffected: device->bonding is set
before the connection is established, so gatt_client_init() takes the
existing elevate-for-bonding branch and never sets the flag. Already
bonded devices are unaffected too: they are elevated proactively at
attach time when their LTK is available, and reconnections see
device_is_bonded() and skip the flag.

Tested against Android (Galaxy Z Flip 4), iOS (iPhone) and macOS
(MacBook): each connects and is probed by the built-in profiles with no
unsolicited pairing prompt, while explicit pairing continues to work.

Assisted-by: Claude:Opus-4.8
AI disclosure: this change was developed with the assistance of an AI
model (Claude Opus 4.8). The author reviewed every line. The fix was
built and exercised on real hardware -- against Android (Galaxy Z Flip
4), iOS (iPhone) and macOS (MacBook) peers -- and its behaviour was
observed directly, not inferred.
---
 src/device.c     | 13 +++++++++++++
 src/shared/att.c | 20 ++++++++++++++++++++
 src/shared/att.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/src/device.c b/src/device.c
index 65d84be..821a834 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6301,6 +6301,7 @@ static void gatt_debug(const char *str, void *user_data)
 static void gatt_client_init(struct btd_device *device)
 {
 	uint8_t features;
+	bool unbonded;
 
 	gatt_client_cleanup(device);
 
@@ -6319,9 +6320,21 @@ static void gatt_client_init(struct btd_device *device)
 	if (btd_opts.gatt_channels > 1)
 		features |= BT_GATT_CHRC_CLI_FEAT_EATT;
 
+	unbonded = !device_is_bonded(device, device->bdaddr_type);
+
 	if (!btd_opts.gatt_seclevel && device->bonding) {
 		DBG("Elevating security level since bonding is in progress");
 		bt_att_set_security(device->att, BT_ATT_SECURITY_MEDIUM);
+	} else if (!btd_opts.gatt_seclevel && unbonded) {
+		/* No bond exists and none is being requested, so no
+		 * user or agent has consented to pairing. Forbid a
+		 * reactive security elevation: a speculative GATT
+		 * profile probe (battery, MCP, ...) that reads an
+		 * auth-protected characteristic must fail rather than
+		 * silently initiating SMP bonding nobody asked for.
+		 */
+		DBG("Unbonded link: no reactive GATT elevation");
+		bt_att_set_no_auto_sec(device->att, true);
 	}
 
 	device->client = bt_gatt_client_new(device->db, device->att,
diff --git a/src/shared/att.c b/src/shared/att.c
index 3d3c8cf..c42a521 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -92,6 +92,10 @@ struct bt_att {
 
 	struct sign_info *local_sign;
 	struct sign_info *remote_sign;
+
+	bool no_auto_sec;		/* Never reactively elevate security
+					 * (would initiate an unrequested bond)
+					 */
 };
 
 struct sign_info {
@@ -766,6 +770,14 @@ static bool change_security(struct bt_att_chan *chan, uint8_t ecode)
 {
 	int security;
 
+	/* A reactive elevation on an unbonded link starts SMP bonding.
+	 * When the owner has forbidden auto-elevation (no_auto_sec), a
+	 * speculative GATT profile probe that reads an auth-protected
+	 * characteristic must fail here rather than silently pair.
+	 */
+	if (chan->att->no_auto_sec)
+		return false;
+
 	if (chan->sec_level != BT_ATT_SECURITY_AUTO)
 		return false;
 
@@ -2103,6 +2115,14 @@ bool bt_att_set_security(struct bt_att *att, int level)
 	return bt_att_chan_set_security(chan, level);
 }
 
+void bt_att_set_no_auto_sec(struct bt_att *att, bool value)
+{
+	if (!att)
+		return;
+
+	att->no_auto_sec = value;
+}
+
 void bt_att_set_enc_key_size(struct bt_att *att, uint8_t enc_size)
 {
 	if (!att)
diff --git a/src/shared/att.h b/src/shared/att.h
index ba1f846..3dbfe86 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -112,6 +112,7 @@ bool bt_att_unregister_all(struct bt_att *att);
 
 int bt_att_get_security(struct bt_att *att, uint8_t *enc_size);
 bool bt_att_set_security(struct bt_att *att, int level);
+void bt_att_set_no_auto_sec(struct bt_att *att, bool value);
 void bt_att_set_enc_key_size(struct bt_att *att, uint8_t enc_size);
 
 bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
-- 
2.55.0


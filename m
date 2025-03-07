Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CFC18FC92
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370533; cv=pass; b=sYiWxAMdb++BVURO38rzZpS7cUEGajawb6pNiixGbVt42Z/3qawEOM8+ZJ4BTIjhMl82QMXqqwO0Umo3qC5qtGuJXuLLYmnxXh1REd0h0wiS21UiV7+BvuZFXNEdoDVkISxt4c/5EbOFO3BWBaRa9gMRp2MH1Wf1a8VHD38KB4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370533; c=relaxed/simple;
	bh=/Fzo39/9ZhDV+TUywjW2DcXfTejoY24HKWvQ2F7Oqq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdsWUP8d10yNOFeCavYqmMsSpdxvEoKy4au/ywUYKnXBwEHyl3k3U1MBNX5/9fnqXxJyg1NzfNPlkdZl9bh0u1mipNAkzfEvLEV7OZUAUuCQBO1HwQKZRytXqcLnJUDVEdjkBDyn71giVwauncs2BwqBGzUIfgDiePX3pdL2Er8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=g4Qw1t3f; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="g4Qw1t3f"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Z8Yyc3fCxz103y;
	Fri,  7 Mar 2025 20:02:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1741370521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MREFb4djRsFP6R9QpHE8kACwNcT2YwjPF7/0t4b9oQA=;
	b=g4Qw1t3fOSJhooYDHF22F61ysOQ8ny3Y12MDp2O0Q3eFYx2x9uyVwIGr2gQ56GbIuusx/W
	VpmeuHWvT7zHBncis/136CyGV6F/gUX3LGab2s1CWH+YWPtoYMaZ/XXsFchso5avqT9vxO
	/7VIvP8bCWenNocouo0h7CFyj68Vwpw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1741370521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MREFb4djRsFP6R9QpHE8kACwNcT2YwjPF7/0t4b9oQA=;
	b=qXWgnERfDyUyTefG0fzQJcUpIDLZshvXwckbI7r1AyUZykZiD2YLsFUfB/MOJ4luqF+Xjf
	zJj6ytXTNThbYWRMtMjHBapuha/8yyYrvSYlWUpXl/EQ4fNbKq477XAzEzlQwVj/vThSdv
	lQy6kNAYGxFdoLnBS0BsPug1BWfVvxo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1741370521; a=rsa-sha256; cv=none;
	b=SaFn053VJsBfI6IHQ0gc6Rg9rFivHJDyNx7/aZaeicersYnxV0eS5/9P544muKg/4tPPGH
	y/HianpbkFn8ChJx0KcxEwkHwOIPSiRQoMGjd+vRADVrIlYiUcbf8WzB9pZdLnQVOfVe5R
	fYscjZIO7KXwwRaRMpB+gITePkqXrT0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 6/6] sco-tester: add tests for different SCO flow control modes
Date: Fri,  7 Mar 2025 20:00:59 +0200
Message-ID: <29543241771689ab8c93d941615ad62d3b70cf60.1741370367.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
References: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "SCO CVSD Send - Success" to send multiple packets.
Add tests

SCO CVSD Send No Flowctl - Success
SCO CVSD 1.1 Send - Success
SCO CVSD 1.1 Send No Flowctl - Success
---
 tools/sco-tester.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 9886481ff..e6888348b 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -44,6 +44,7 @@ struct test_data {
 	int sk;
 	bool disable_esco;
 	bool enable_codecs;
+	bool disable_sco_flowctl;
 	int step;
 	uint16_t handle;
 	struct tx_tstamp_data tx_ts;
@@ -196,6 +197,16 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 		if (features)
 			features[3] &= ~0x80;
 	}
+
+	if (data->disable_sco_flowctl) {
+		uint8_t *commands;
+
+		tester_print("Disabling SCO flow control");
+
+		commands = hciemu_get_commands(data->hciemu);
+		if (commands)
+			commands[10] &= ~(BIT(3) | BIT(4));
+	}
 }
 
 static void test_pre_setup(const void *test_data)
@@ -240,7 +251,8 @@ static void test_data_free(void *test_data)
 	free(data);
 }
 
-#define test_sco_full(name, data, setup, func, _disable_esco, _enable_codecs) \
+#define test_sco_full(name, data, setup, func, _disable_esco, _enable_codecs, \
+							_disable_sco_flowctl) \
 	do { \
 		struct test_data *user; \
 		user = malloc(sizeof(struct test_data)); \
@@ -254,19 +266,26 @@ static void test_data_free(void *test_data)
 		user->step = 0; \
 		user->disable_esco = _disable_esco; \
 		user->enable_codecs = _enable_codecs; \
+		user->disable_sco_flowctl = _disable_sco_flowctl; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
 				test_post_teardown, 2, user, test_data_free); \
 	} while (0)
 
 #define test_sco(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, false, false)
+	test_sco_full(name, data, setup, func, false, false, false)
+
+#define test_sco_no_flowctl(name, data, setup, func) \
+	test_sco_full(name, data, setup, func, false, false, true)
 
 #define test_sco_11(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, true, false)
+	test_sco_full(name, data, setup, func, true, false, false)
+
+#define test_sco_11_no_flowctl(name, data, setup, func) \
+	test_sco_full(name, data, setup, func, true, false, true)
 
 #define test_offload_sco(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, false, true)
+	test_sco_full(name, data, setup, func, false, true, false)
 
 static const struct sco_client_data connect_success = {
 	.expect_err = 0
@@ -290,7 +309,8 @@ const uint8_t data[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
 static const struct sco_client_data connect_send_success = {
 	.expect_err = 0,
 	.data_len = sizeof(data),
-	.send_data = data
+	.send_data = data,
+	.repeat_send = 3
 };
 
 static const struct sco_client_data connect_send_tx_timestamping = {
@@ -1112,10 +1132,19 @@ int main(int argc, char *argv[])
 	test_sco("SCO CVSD Send - Success", &connect_send_success,
 					setup_powered, test_connect);
 
+	test_sco_no_flowctl("SCO CVSD Send No Flowctl - Success",
+			&connect_send_success, setup_powered, test_connect);
+
 	test_sco("SCO CVSD Send - TX Timestamping",
 					&connect_send_tx_timestamping,
 					setup_powered, test_connect);
 
+	test_sco_11("SCO CVSD 1.1 Send - Success", &connect_send_success,
+					setup_powered, test_connect);
+
+	test_sco_11_no_flowctl("SCO CVSD 1.1 Send No Flowctl - Success",
+			&connect_send_success, setup_powered, test_connect);
+
 	test_offload_sco("Basic SCO Get Socket Option - Offload - Success",
 				NULL, setup_powered, test_codecs_getsockopt);
 
-- 
2.48.1


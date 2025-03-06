Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F7270EBC
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289024; cv=pass; b=UFPHagQVu5ysPExvTAhDncKGB7Vs9StQ06DmH/1QTmI6cfdmkf3edar1FSQfAOu3BOpNiw9TVYb9CeqoummF3L4/qIvjlXw0XoqitGOL3w6LamK9d9LyTSwcpZtj7C/ZiarI3eHLkFByCqXjm6qBZomdZmtkInl0WvHVmagSNZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289024; c=relaxed/simple;
	bh=/Fzo39/9ZhDV+TUywjW2DcXfTejoY24HKWvQ2F7Oqq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJZBKOisV9hATKyrVNe/u+8EUkBWMoyo3nygY+t58KwYsKcqpBRvN7rc8FQywa+pVIgOSrtpK2knnX4GemgSlyUDHPTmomPYbhkJDZmPMpRsfAF5MfauMxt87MJsKSOjQ7oBN0nO0XcCutcjC0WJBIsswplmjM56Lb8W68oLQ7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=NGif01bU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="NGif01bU"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z7zqF2rH9z49Q4b;
	Thu,  6 Mar 2025 21:23:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741289017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MREFb4djRsFP6R9QpHE8kACwNcT2YwjPF7/0t4b9oQA=;
	b=NGif01bU2yN0c2B9Sty2urgp9xr/vkgo4lfkI9Q62WxowWNl4TJPEg/P4ZIWX2b+rJJu5g
	MUwVqjXGYIXjfDDEnTo5DSnwQi3Xb9R+yt6nZ2ydWZNFky6odcM5pItH5Tz218aAB1FjCs
	WxbslyDDmCVTMFnvBXjyPAFAdTW66iyPkhFr8zX4dRSm/7a7a9yFTC9seC7vqnhtUGkUS4
	bJg6e/OuYRRdDswv+eko8hwVAsjIET6/bA2sP9C1FWQE0iqws8DqryDmrrDVKX1Cd6At8O
	dkTKfyK7cDrG+iGFyA7b5Cz5b5OIG/KfZ1rjw3nLg9NLFyWdcSKXW+dmISpefA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741289017; a=rsa-sha256;
	cv=none;
	b=n/2v5YSnGS/V6cAMLq/IH9a14rq4rGYhgWShkEFOicqPsIBiYabHE+H/AOOr13GtaNQwFo
	MV1uc+jNhQ36LPBw9OOPS0YeCskA7Ai7+ozdl1mRykoN8AGA2fxuVC5cC0Qv3zkAq+/wsv
	9nJIQ7wpFp7fubub6611lmJsxvafVYh/HNC0RukD+OGQ5On6ktC9n+7odF9k8tHaNVnSzh
	6SMWEbXbOJ/qMSVo+6j3XTZGH3/xesJ02yjkbK39E1MUqTzeAjUqo+4wdxLfWNQ4JGABEo
	KMfPrzgPC2dt74CbFjIToT2czEhbFrAlt7Q/dJqhNCGM/Xb6etZt93cUU4tFgQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741289017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MREFb4djRsFP6R9QpHE8kACwNcT2YwjPF7/0t4b9oQA=;
	b=WfylOtE8URlGPgjSGpg4Swea/aNr23qiJ1aFPthj+UD3qd2HV1REF/7Q49wc/bF6iJgYuN
	rhTVl+6D132u7a9iXMmjsvqYWdQgoA7QhFKdk1azihOiaZwM23bMZ89aaBTuJgqC9YBKmX
	KdDSTM8ln9AeR/i17QwgwpwIs9gbQFZBUIWGYIaP3uRQV/A2dVl4sWy8fMzok6cgT654e0
	IGR/Lm47XpfGdA3tzNw+58aNV9ic/9txDeB+m+zpTFp3x2GGTLNafDtlLEDsOevg2bkQ76
	cKkF1nFxn5ZLFIHDRyd5qKnpfNBkYEdwLnY74+IZ0Ptk++/NEkPXgqeQoNV+wA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 6/6] sco-tester: add tests for different SCO flow control modes
Date: Thu,  6 Mar 2025 21:23:18 +0200
Message-ID: <15c4330b0e1c1b7677fa5a184354b615c86e9395.1741288951.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ab105eb0ca4c2e91218ff76a9040e46fe5f64a2d.1741288951.git.pav@iki.fi>
References: <ab105eb0ca4c2e91218ff76a9040e46fe5f64a2d.1741288951.git.pav@iki.fi>
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


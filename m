Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7DA217670
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370528; cv=pass; b=pQo98qbQU7SzBcIQ26A/6XAqgIwwasGTHtYxysq9WbRsmxNtddg50rhwHnXDoDnEftAg7rEnHU506XVsa1oRj9IAlIOUpfXB8DnUt/0b+SFc7GZGQGpDQE1I/Mmy3HKNUTn51h6KvEYYCsA0r7OC1uLcQUAMGJ/FpuKCHUirPuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370528; c=relaxed/simple;
	bh=c+9YHb+Y5QPv7Vrdwrl5MMvdX+TbvrCwyQcrVyClB2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fogt84bvW2mk59ZPcQgF1lCMPyUReyqG1HFE7AcR8/RoiqTuigHMdCLFj99ltDIcGZ2J7mV6wE03ghBL6ZlK8fVerFsfzN4uNuQgbJVC98MHJu9DITlLrwJ+LwjR/+xIY6jkOpt/J7wY/8BpxcXSGU2hU92biIKmkL7NOuzANwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=sb58LVFf; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="sb58LVFf"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Z8YyZ0YY7zyyf;
	Fri,  7 Mar 2025 20:01:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1741370518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSr0gtHfZEF48CpGo6uRjVwXU5NXO8qweUla6SKHKpk=;
	b=sb58LVFfWAVjzPpGu0QgHdW8uEolcqieZ+A/+wExaHTBrRy81ev764TIAlWHV9Yr8iIoYE
	F6k0D8P3TAm03nHEqkkKK+xkMVDhl/puL/jeJXQWvDxm0icPI/KO/spw1j181U2LPR86HE
	Tctd4BWYZdPQN0Ef/FaBK4dmDBkSb0k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1741370518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSr0gtHfZEF48CpGo6uRjVwXU5NXO8qweUla6SKHKpk=;
	b=wAs5sYDPkeKXlcN5zmioQjuDo0AMZJCrZUDe8C+SBxkeIcLmxxoCRuxOwqz/sYq/6E2PBl
	atmQgcl3A78c7YRYCkVw0ms0Dopvs7dYWoRoK1OEq8qHx9co+SQy4Om5oNocgS00vWuA88
	au+p/F/b1Z5umaxvnm/NENPzdQJH5ZI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1741370518; a=rsa-sha256; cv=none;
	b=b3M9YayElGAIqGyomD4DZRCwFlRsDsHb0qTsFQ/yaKZJ3suO4k5IulpfHgWTulK1XP7688
	uzXwCLuAHaB0rDFvHTc5dBYWdKesYltKXPop1xVF3r7cOMJzzw3xxXb/tQwbO2rZSt/V0y
	zLz2cK+iXATDnzvrKy4E3Wvspur9qCg=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 4/6] sco-tester: check sent SCO data is received at bthost
Date: Fri,  7 Mar 2025 20:00:57 +0200
Message-ID: <82eb32fd199ab8d80dd4d5a02e3f6aa9926968bd.1741370367.git.pav@iki.fi>
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

When sending data, also check that the data is received by bthost.
---
 tools/sco-tester.c | 47 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 7f37ca5cf..9886481ff 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -318,10 +318,51 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 		tester_setup_complete();
 }
 
+static void bthost_recv_data(const void *buf, uint16_t len, uint8_t status,
+								void *user_data)
+{
+	struct test_data *data = user_data;
+	const struct sco_client_data *scodata = data->test_data;
+
+	--data->step;
+
+	tester_print("Client received %u bytes of data", len);
+
+	if (scodata->send_data && (scodata->data_len != len ||
+			memcmp(scodata->send_data, buf, len)))
+		tester_test_failed();
+	else if (!data->step)
+		tester_test_passed();
+}
+
+static void bthost_sco_disconnected(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	tester_print("SCO handle 0x%04x disconnected", data->handle);
+
+	data->handle = 0x0000;
+}
+
+static void sco_new_conn(uint16_t handle, void *user_data)
+{
+	struct test_data *data = user_data;
+	struct bthost *host;
+
+	tester_print("New client connection with handle 0x%04x", handle);
+
+	data->handle = handle;
+
+	host = hciemu_client_get_host(data->hciemu);
+	bthost_add_sco_hook(host, data->handle, bthost_recv_data, data,
+				bthost_sco_disconnected);
+}
+
 static void setup_powered_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct sco_client_data *scodata = data->test_data;
 	struct bthost *bthost;
 
 	if (status != MGMT_STATUS_SUCCESS) {
@@ -334,6 +375,9 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_connectable_complete, data);
 	bthost_write_scan_enable(bthost, 0x03);
+
+	if (scodata && scodata->send_data)
+		bthost_set_sco_cb(bthost, sco_new_conn, data);
 }
 
 static void setup_powered(const void *test_data)
@@ -740,8 +784,6 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 		ssize_t ret = 0;
 		unsigned int count;
 
-		data->step = 0;
-
 		sco_tx_timestamping(data, io);
 
 		tester_print("Writing %u*%u bytes of data",
@@ -751,6 +793,7 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 			ret = write(sk, scodata->send_data, scodata->data_len);
 			if (scodata->data_len != ret)
 				break;
+			data->step++;
 		}
 		if (scodata->data_len != ret) {
 			tester_warn("Failed to write %u bytes: %zu %s (%d)",
-- 
2.48.1


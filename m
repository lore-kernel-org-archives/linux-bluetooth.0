Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDD2505C4
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190321; cv=pass; b=lOQFpeeYmAZ0BHTDxNabGTAaNaubzbLxvy8mNguyGMdjkfZeyETfI9qo5ez2CtcPh190yGjLsvb+58g8UDMkodGn7rR/q3NcOuiZv2Oj5aDHIgNj2hB0h7lHSIhzcYLgoogy4gsvDusM4Su2qqjh7KYfCTJKSPPfHbbK+ZWUVD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190321; c=relaxed/simple;
	bh=c+9YHb+Y5QPv7Vrdwrl5MMvdX+TbvrCwyQcrVyClB2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHNxyhtcIED3vW/PbrfYeZsSiIKI/0HVnAU86zbJ4+g8ke6zi8L33Ns7hCCxPVNr7tR9aNgQs6Ssa23+r2tsNm1dA3zYwd4uVbups0v9xu/o+THY3ky7+qI36Q87IvwH1sf+FAYwvjoNUqNE3F8sHeQZACMuZJLP1X9Y8Pd58cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nVJXjJP3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nVJXjJP3"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Z7HK333hlz103S;
	Wed,  5 Mar 2025 17:58:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1741190312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSr0gtHfZEF48CpGo6uRjVwXU5NXO8qweUla6SKHKpk=;
	b=nVJXjJP3phHMZ2PgBPpp4WNHM6cfmVVgooANl1hVxjW/p7X9hBlK08SL4+1Zxj0uz2DXfU
	W28nf/Z4aHUfi9EifnN0V2k06qqV1mEu+gtrHtw1eBIJBx0JSMDNJq28Ky6Oj+qVUFjkS0
	EucptRQm8k5YYcr2utl+kxJvIm2oeiU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1741190311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSr0gtHfZEF48CpGo6uRjVwXU5NXO8qweUla6SKHKpk=;
	b=gQBP3RU8upilCoEqui/Zp75wz3JaZLkdwo3QufzF5XcifyEdK5yRLHjIuTnQxojbNSWv79
	MOewmoCM0wjb/HhFXQ67NNFqkGmq7RazBkEZ3Yel6k9zPSs9vUqpGs0WELlReb+4MbMkB9
	AkSpvik8lVj5Dehq/o3YV36wAuvHvAw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1741190312; a=rsa-sha256; cv=none;
	b=jea7RFHYw26ncKtdiZSDAo155BrZze8qEkOl36w1NkdXy7A6HqAEC+ZKIHbGhphCKOlfi8
	tZSOvcXRc+7Bd2H+SvG6z4MyzwXlHQjrUOboHeWyY4w2T4wc0NUST74OzXKhDp0BKuwMkB
	RPUitjVPCBM7YHgtbIt2NKN/W/Mrn7c=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] sco-tester: check sent SCO data is received at bthost
Date: Wed,  5 Mar 2025 17:58:26 +0200
Message-ID: <7cc0c544b498337e6591610be16e9361687e0196.1741190102.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
References: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
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


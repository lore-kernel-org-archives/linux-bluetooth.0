Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A226F479
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289020; cv=pass; b=o/h+kQrY1W1SoC77NHKybI+wCMlxKQJswop0Tn7sTzl/ycGLKlNC2M2joQvUa04bVzJR2rUJhmUoi8xGYont5BAOzRV8C24N/1+6laAJVE1bczkJ7t8o0ROeJy5uuaJbWfzJIlEqd1Orqh9rxRIcxzAw7wtJ66kH2qci0kyApBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289020; c=relaxed/simple;
	bh=c+9YHb+Y5QPv7Vrdwrl5MMvdX+TbvrCwyQcrVyClB2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/3MJD2TlTV5gx5O3DI6pm2fwh6tZy8XZbEHJU0WggICnVVHOyOhaX+WidI+yikjlyylF2HFfR1B+8DmXrUavjQ+EtHd9tCTXRHCscUN2JnEGJhy66I/+/1ngk2xFyUZM7r7MAHzbUP6eSTE6ChiNu+p/9wISZdZK7aucavUeWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=XSUqwUPi; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="XSUqwUPi"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z7zqD52Ycz49Q5J;
	Thu,  6 Mar 2025 21:23:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741289016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSr0gtHfZEF48CpGo6uRjVwXU5NXO8qweUla6SKHKpk=;
	b=XSUqwUPi0hatfOsl7v9jHM3OSfKieMNoZRs8j6Sro0jBlykFv6wUlN+WG64FZrGf+cPpwr
	q2q6/RRhkAnyASa1qlMspgwu/hgNF78WIaFwbKvhx9QEqC8sWqLEF/CDYkR9V0C7P+aPEH
	r+qlo8wPxniuMc06ajK4Hvl9/7FdUvd2wbZa8QtpGS0oFdvDLvX/1vTkC0trl3UEw4eDAj
	/CrXa5opor/VPgQrK2ivzpcX+T3QiDzWgj0OK12t886UymdcNvJva+9/jDOhqG+JW3VUNU
	CPi76o3R5Mg6SQ7syEqKUeTZs/XzrItcPEqsvl1xSWRichNt5848wVBXx4K80w==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741289016; a=rsa-sha256;
	cv=none;
	b=qhhJC11A0PHIi5wIxFXUG/gUAjZjSn66ywFcxKTS1Uljsm3KBQ1jv8PWDtqTGd1JxmnpY1
	9JtknQ3z0IkbIVW4wi+fgmFKezKJ68D1DtZKmT35hCTMb+rO9GHfqxaleDK0UCXs74ZsiC
	t/cQrtAsMGNMWCn+0NH5rENpN1dIQxTt+8jRIlusp/xx/9Xpv6Rkp0ZM+9fHs9suMXRwT7
	1YOqEFTOxfdbKuh5YSOoGIlY/8jcZ881e293BOl/m5O3g/3ltjLwgZ70ZHLZ8fRXWAENDZ
	/WwkBHj4WAIakedYN/0SBT+4Z2nhS0UpjfeVFrSDhzcXBAr3cqnmV0Go9rPcyg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741289016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSr0gtHfZEF48CpGo6uRjVwXU5NXO8qweUla6SKHKpk=;
	b=kjDT+AihQf6jUdzhGVKCzElUsZO7L4p6zKdj+tz9jlIB7jrfImwMtGsgPYIP4ux52Kg25b
	YEEcpbd8CwimD0y08+EBPnuTRcjWaiWE4FEX8oQ45nHprZpCntu3W6frN0iXL+Wr9+wgiK
	GLdyA2vussWdeDx4ARypq/xBms9ZBpX/A6/Xm75tAEwB2QmV1CYyjVDHDtHAv9dCQv9C6r
	C+qZDCSWg9PRhBxl/MgON0KmymnkrFBc5t2ZKy36e9orQEoZ44E7+gllZdaFA/+1miInee
	3OU1cZJaWSsR3JzOMv5n7evvHrmfA/w7UxhDjMhPpcVhE7SagIUN+4IQLyLIGA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/6] sco-tester: check sent SCO data is received at bthost
Date: Thu,  6 Mar 2025 21:23:16 +0200
Message-ID: <f0d0f617fd25c0a9eee1b54747e6b976fbc3e325.1741288951.git.pav@iki.fi>
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


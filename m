Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24121ABA0
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685019; cv=pass; b=idvLZfKtVhX/uVV108QkiHUjo3cyXfwXqVu2SRmlm0vN89BK85n2UdnxnXQkzVXhzWbJQg/7YkwYwylujhvNvq/IwmvTKGPpMuRYOA6pM58hJiUlwAgpLrDPRS6XB51q/X2ZmU0Ht1dhtQWqr35pmVlPVJWXzjNJyxC9AjrWqeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685019; c=relaxed/simple;
	bh=C5oGAHvYHeO7aB4G46jLdYndfYzS/GR6i1VJOIOzA5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKr7I97koaAxQmGhkwG5Oia8TOI7tGzAFWqdFoShUWe1JsMAjgmr7WraYYYIvKg3DxsbBSsuMnOm6wcWBTGYmipVVF31SMZ/SvRnV/jV3oO6F4ciI8e/XqpVSA9JJiVOEVnve2MplVh/nVByC8g6x+d6ogENqMBx86xO9sww18c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=FgcKnbAp; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="FgcKnbAp"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z3hRg06W3z4BKJH;
	Thu, 27 Feb 2025 21:36:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740685008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4rcUswnrmL+szkfc/27Z7b9Kn/yCqYzT22KbLFSXzKA=;
	b=FgcKnbApRPSnMdUOc6dgb+woQM87Jo/R3cbiPDCdYFMgGx1Q5TFWHVgBS8mGmk9An1ieXM
	Mybe9XOcorKj1usROzrmRkLrE8ItffzYg8lJwUTxSbWy0wGhXx4PxM8Qjbg9CCjLS2B4Gf
	CUijG+Iy8AZ+LB7mbS0fdSGwzU/40nxbEZE9HNP9qF7OpoqgZBiOnI72UsF4ibcm7cBb//
	jMU58vgKiNGDGGzrVI+jM8ArA4WSFXLmqKZYMa9kQrDgCueqa+oC1RL4+wsoakrWdpalj1
	qNGB5L96Swx4vo7CqCFPeXZBGr0m4D6mbppRWcF6LwSQXOvbuPgUpbignkwOeg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740685008; a=rsa-sha256;
	cv=none;
	b=RLY+ERWOsZuHxXQ1PwH5Tj/6/OS1E0kh2qmf8nFHh8lZDTbY+1EWXnnhK1gBScjrqa80op
	Nev6+EaH8q/kUqqkOPVd/nLyid5/dv8iaB5ecF/3MS7b6jx4HSURdHfg8RaVxtcfn7VGR6
	W76a0bcxx5T7r6bGLpfPEAVT/hEmft2pIxaV74LSjXkSQ34Jshl0a5vRUB/r45ly8r5vbA
	yadUvddTPUCr6fUcCWeJ3HukXM3vS4pjK6+2Jp6tJvGVcFsX3Zu6YX/wcOphfQ6TJ4MY8Q
	u8qhD9kIVwFDG5I7+3mhwRixWLhO37X/labmiQFY8E38wtMXyXig71WvosvbmA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740685008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4rcUswnrmL+szkfc/27Z7b9Kn/yCqYzT22KbLFSXzKA=;
	b=Tmd5XcyaU/VJsioqX11wqvNWXsoHkRk/+UzMkeQvrYBM4MpKtg0BHUZ7g5ck264fHkqOaQ
	ypa18rOBWgMGujF/zaORTcbt+kao7FH7bcrNfCwFmzg92Sp7L+C3BncWcgsiECr92XDHaL
	8wjPdt9C3xa1ZPyPtftTbe58txajkUOu0f2iyJ/9KCFzXOXpPcK6fljgLpF8Q+67k37rFo
	AmT+mZI4HNg3e17CXy7CHvNfUH/S8GjWvXbWjnN6Snqt+jTUgWz0WlwdyJx7+mcA7z18lb
	L3Wpy8nN6REUE7wHVBDjlkOIUAUWmvaDYZzEboOab0nmtqoffZvS7acyzfYXtA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	eadavis@qq.com,
	luiz.von.dentz@intel.com
Subject: [PATCH BlueZ] sco-tester: add test for disconnecting SCO
Date: Thu, 27 Feb 2025 21:36:42 +0200
Message-ID: <b3bf384b8e710156dd2a0f7ee2c21b98da9f4c79.1740684902.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test that checks that shutdown(sk) results to
HCI_Disconnection_Complete for the SCO handle:

SCO Disconnect - Success
---

Notes:
    It seems after the following commit closing SCO connections no longer
    works, as kernel does not seem to be sending HCI Disconnect after the
    SCO socket is shutdown & closed:
    
    commit ed9588554943 ("Bluetooth: SCO: remove the redundant sco_conn_put")
    
    The test added here passes with that commit reverted.

 tools/sco-tester.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 6fc26b7af..7f37ca5cf 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -45,6 +45,7 @@ struct test_data {
 	bool disable_esco;
 	bool enable_codecs;
 	int step;
+	uint16_t handle;
 	struct tx_tstamp_data tx_ts;
 };
 
@@ -53,6 +54,9 @@ struct sco_client_data {
 	const uint8_t *send_data;
 	uint16_t data_len;
 
+	/* Shutdown socket after connect */
+	bool shutdown;
+
 	/* Enable SO_TIMESTAMPING with these flags */
 	uint32_t so_timestamping;
 
@@ -268,6 +272,11 @@ static const struct sco_client_data connect_success = {
 	.expect_err = 0
 };
 
+static const struct sco_client_data disconnect_success = {
+	.expect_err = 0,
+	.shutdown = true,
+};
+
 static const struct sco_client_data connect_failure = {
 	.expect_err = EOPNOTSUPP
 };
@@ -751,6 +760,11 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
+	if (scodata->shutdown) {
+		tester_print("Disconnecting...");
+		shutdown(sk, SHUT_RDWR);
+	}
+
 	if (-err != scodata->expect_err)
 		tester_test_failed();
 	else if (!data->step)
@@ -875,6 +889,69 @@ end:
 	close(sk);
 }
 
+static bool hook_setup_sync_evt(const void *buf, uint16_t len, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct bt_hci_evt_sync_conn_complete *evt = buf;
+
+	if (len < sizeof(*evt)) {
+		tester_warn("Bad event size");
+		tester_test_failed();
+		return true;
+	}
+
+	data->handle = le16_to_cpu(evt->handle);
+	tester_print("SCO Handle %u", data->handle);
+	return true;
+}
+
+static bool hook_disconnect_evt(const void *buf, uint16_t len, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct bt_hci_evt_disconnect_complete *evt = buf;
+	uint16_t handle;
+
+	if (len < sizeof(*evt)) {
+		tester_warn("Bad event size");
+		tester_test_failed();
+		return true;
+	}
+
+	handle = le16_to_cpu(evt->handle);
+	tester_print("Disconnected Handle %u", handle);
+
+	if (handle != data->handle)
+		return true;
+
+	if (evt->status) {
+		tester_test_failed();
+		return true;
+	}
+
+	data->step--;
+	if (!data->step)
+		tester_test_passed();
+
+	return true;
+}
+
+static void test_disconnect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->step++;
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_SYNC_CONN_COMPLETE,
+					hook_setup_sync_evt, NULL);
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_DISCONNECT_COMPLETE,
+					hook_disconnect_evt, NULL);
+
+	test_connect(test_data);
+}
+
 static bool hook_simult_disc(const void *msg, uint16_t len, void *user_data)
 {
 	const struct bt_hci_evt_sync_conn_complete *ev = msg;
@@ -972,6 +1049,9 @@ int main(int argc, char *argv[])
 	test_sco("eSCO mSBC - Success", &connect_success, setup_powered,
 							test_connect_transp);
 
+	test_sco("SCO Disconnect - Success", &disconnect_success, setup_powered,
+							test_disconnect);
+
 	test_sco("eSCO Simultaneous Disconnect - Failure",
 					&connect_failure_reset, setup_powered,
 					test_connect_simult_disc);
-- 
2.48.1


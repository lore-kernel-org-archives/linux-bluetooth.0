Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684035;
	b=Jr+tXBcCypGmSRPiQe5YfsSTvVOi4awdiwUWj+zlcInPKwWVZl+BhMhMzAQJyai/YPdS
	 vja5BqYBjgiMwTyYVoPb2LmiraGcJ7nC2GIpboLMi5d45BzHqKf4aD2fSFx1vr23/o6yR
	 h6n/OmTTEmySRsA/kHz7Yg/Du3hbGgvq2/CAv9tKTcHYCy5TRrcOqUQIvd4yaAPnYzyDF
	 hHJ7S81UFnVKbzIM6hnjOw4wK59rY8ZCYp+aHMxQZMghCdeoSU0Sy5fU9iFPKyLT2RuET
	 KmGGQJECZnSGagrNKyDV6yQL06FcbPqM+rYUtBFY7XuOkJ/nqDQtZq3PBWsKJDNOozg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xUprW19aHkNe0Y9kzkTK3cboTLGppSIy+CvC3McyxbE=;
	b=zJjRnEPtV/K7aGv/Vew7BERoznJkWTEU0qx0bXNaUjzr9M1Xtxq53smgtYhAaw1kBdug
	 NilyToHEIeXBwbNeeAcRXNntCCMvUIKM3XJE1pA+1WwdL393Wt/kC2flJsn+Z4e7JLw6a
	 PWE/o+xhpUjAAjfDJGOwBX1uVwltF+y2E+NGdOj//xzmdUGDwmw7KsnEIC4xs5Igo9XFS
	 y4pPx4ASyHwNhl6iyrCMfhGLgRECGnBY8u+DMgInKg/fdmVRBygKkrcoW1WgKquAjC4TB
	 CGhJdmAebmrvNtZqL572hwLpl75B8lGoK0xf5iQfCwwlqH+P1Y7u6SFLi35cd9ov4YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ieNF3WCs;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E85606A332
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E85606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ieNF3WCs
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso350241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684034; x=1793288834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xUprW19aHkNe0Y9kzkTK3cboTLGppSIy+CvC3McyxbE=;
        b=ieNF3WCsW72hfERSWp4qQzhc2wNrksyzabxAebjVDzXZ5Zv0fHczhCC88r8y9rj3U8
         0C8zg0brMgDFXZ7pR+sd+tl9ejU1j6VU50N9T2FOGEEfkC5nROOdG0pWM1Y0ZZDtAfge
         zrs1tBT8BczX1liIFLYjaGX0vFTfefEAr+jvD/+Dco1es9whVR3O/XYIR2BdeXtJ/Qwf
         +TovxCiyaBckhR56uaT0ZjQGAxTb9XWtW8nV3GjzCzXQEKatNfz5tUYHon0hVx2Ra7iF
         VHouFVwKv5YeNsqwn2O+aljpC0xXD7WgKe1PdewwLMqbC1mES/UYZO6Q8XMaE2+QsvXu
         rlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684034; x=1793288834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xUprW19aHkNe0Y9kzkTK3cboTLGppSIy+CvC3McyxbE=;
        b=08QA+bZskZ2Nwn+tw+5t+bPcxjp8wPWj3SHLor7p4787MUGmM0p/UmYuAC4oAxTr0V
         mxk50qAtOn/+VcJhLye96S6W24N6VHn+o7RUpJJkOztT+ye2QOwLRBcBRnRXgbwl09lY
         MzHW7rd6yPXiV8DRtjeEe7bihrMglsYC9SUQsDgAZ+ElGoWevaM148+n1zre9/NV81He
         uf6ZssG2DZDvF40dwFpY0kP64q18bMxUA7Dtk9RDM5AuWcHUDkfaWgQvhQvJVG3piHDm
         RL07meDck1S6JUJU44pvA30UBkRZblEjwPmRfyCrmW5j+Gq1fzwE8P7QNR/05ajpbIwd
         TEhw==
X-Gm-Message-State: AFq9FYL+mzVfllVnUeOsBsQy6jwwm+b8iQSxB2HMaNjZpU3IKCLPhyVS
	qib1uqF0gqlSUPMkaJpYNoDGDkYKNbchKIiZS2FD7etb1DGPfeWuCi9L3Cs82KTszmw=
X-Gm-Gg: AYBFou24iqhh95oXK5ezxa8KdJI1/JWZl4hvu4kaco/rM7DbeTAN5Ds0K6u5VxRwBm7
	kIboWrVXM+z88sXGjWjM28Ab8ZPwRGnLAcwsQ/4RH6RL5xykGe3qarjh5vNpNBkVt0HJ2jAJt9Y
	jhuN2QNuQ+QvYXLN59g55k7iRSC1q3N+ppfXdJZ47lYt8zNKrmcdlWVX1Y48OI5D6bXF4l3hFQ/
	UCnKe+2I+bB8P6b//u5tw68tqSAY+VX0emANh4qZTbNsZqOSKqMmSKXtxE+TdKH/aCiw+bXM9LV
	Qg3je7qpUPedJUsdxEA6auuj8SlWzcejJLhus/oKxKj/kk4aQETJV+XGiLa3OXRSrmDDOHqSJwE
	JC7D1JboPkBFg3L6tpRQfCbS0SFzDnmj7i9XjoDWtRvfEW9CdjMhEOriar7nS4Ldj/B579XFP6r
	YdZxZSw5K5UI0ZQBEZpbnMHDqB7dDIKoLhwVvu/tdGMGGF4gilODvtoeJO+DCUXuE/p6+iZMi9V
	NUafRXh45SVBetVY60L0K+h91KVpMv61OkEUsq4fgxoh+fswPUsrsyY+NOciLd1telLAwfOv4o+
	eY21gj/lHK4pk3sj70h9M3voPkZfyxwsMoEbSmPL7eGYlA==
X-Received: by 2002:a05:6122:130a:b0:5ce:d56f:efac with SMTP id 71dfb90a1353d-5eaebee0e89mr2597417e0c.21.1792684033430;
        Thu, 22 Oct 2026 08:47:13 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/27] mgmt-tester: Wait for LL Privacy setup to complete
Date: Thu, 22 Oct 2026 11:46:36 -0400
Message-ID: <20261022154701.3959500-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
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

The LL Privacy setups send Power On, Add Device, Set Device Flags and Add
Advertising without waiting for their replies, so setup may complete
while they are still pending, even twice, and the test then gets their
events, e.g. the Device Flags Changed of Add Device instead of the one
of Set Device Flags.

Make each of them a setup condition, and once all are met wait for the
controller to settle, i.e. no HCI command for 100 ms, as the kernel
keeps programming the accept and resolving lists after replying, which
a test may otherwise take for its own commands.

This shows with time travel, where computing takes no time:

  LL Privacy, before: 13/27 passed
  LL Privacy, after:  27/27 passed

Assisted-by: Claude:claude-opus-5-5
---
 tools/mgmt-tester.c | 201 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 190 insertions(+), 11 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 631c906f3aa8..abfe57dad0c8 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -76,6 +76,8 @@ struct test_data {
 	struct queue *expect_hci_q;
 	int unmet_conditions;
 	int unmet_setup_conditions;
+	bool setup_settle;
+	unsigned int settle_id;
 	int sk;
 	struct simult_discovery simult;
 };
@@ -119,6 +121,11 @@ static void test_post_teardown(const void *test_data)
 
 	simult_discovery_cleanup(data);
 
+	if (data->settle_id) {
+		timeout_remove(data->settle_id);
+		data->settle_id = 0;
+	}
+
 	if (data->sk >= 0)
 		close(data->sk);
 
@@ -554,6 +561,50 @@ static void test_add_setup_condition(struct test_data *data)
 		     data->unmet_setup_conditions);
 }
 
+/* Time without HCI commands after which the controller is considered
+ * settled, see test_setup_settle().
+ */
+#define SETTLE_TIMEOUT	100
+
+static bool settle_timeout(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->settle_id = 0;
+	hciemu_clear_central_post_command_hooks(data->hciemu);
+
+	tester_print("Controller settled");
+	tester_setup_complete();
+
+	return false;
+}
+
+static void settle_command(uint16_t opcode, const void *param,
+					uint8_t length, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	if (data->settle_id)
+		timeout_remove(data->settle_id);
+
+	data->settle_id = timeout_add(SETTLE_TIMEOUT, settle_timeout, data,
+									NULL);
+}
+
+/* The kernel may still program the controller, e.g. its accept and
+ * resolving lists, after replying to the setup commands, so wait for the
+ * controller to be idle for a while, or a test may see the setup commands
+ * instead of its own.
+ */
+static void test_setup_settle(struct test_data *data)
+{
+	tester_print("Waiting for the controller to settle");
+
+	hciemu_add_central_post_command_hook(data->hciemu, settle_command,
+									data);
+	settle_command(0, NULL, 0, data);
+}
+
 static void test_setup_condition_complete(struct test_data *data)
 {
 	data->unmet_setup_conditions--;
@@ -564,6 +615,11 @@ static void test_setup_condition_complete(struct test_data *data)
 	if (data->unmet_setup_conditions > 0)
 		return;
 
+	if (data->setup_settle) {
+		test_setup_settle(data);
+		return;
+	}
+
 	tester_setup_complete();
 }
 
@@ -6624,6 +6680,18 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 	setup_bthost();
 }
 
+/* Powered on as one of several setup commands, which completes once all
+ * of them are, not just the client setup started from here.
+ */
+static void setup_powered_condition_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	setup_powered_callback(status, length, param, user_data);
+
+	if (status == MGMT_STATUS_SUCCESS)
+		test_setup_condition_complete(tester_get_data());
+}
+
 static void setup_class(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -11526,6 +11594,8 @@ static void setup_add_device_callback(uint8_t status, uint16_t length,
 	}
 
 	tester_print("New Device is Added");
+
+	test_setup_condition_complete(tester_get_data());
 }
 
 static void setup_remove_device_callback(uint8_t status, uint16_t length,
@@ -11559,6 +11629,17 @@ static void setup_add_adv_callback(uint8_t status, uint16_t length,
 								rp->instance);
 }
 
+/* Last of several setup commands, see setup_powered_condition_callback() */
+static void setup_add_advertising_condition_callback(uint8_t status,
+					uint16_t length, const void *param,
+					void *user_data)
+{
+	setup_add_advertising_callback(status, length, param, user_data);
+
+	if (status == MGMT_STATUS_SUCCESS)
+		test_setup_condition_complete(tester_get_data());
+}
+
 static void setup_add_adv_callback_adv(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -11582,7 +11663,7 @@ static void setup_add_adv_callback_adv(uint8_t status, uint16_t length,
 
 	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
 					sizeof(adv_param), adv_param,
-					setup_add_advertising_callback,
+				setup_add_advertising_condition_callback,
 					NULL, NULL);
 }
 
@@ -11591,17 +11672,22 @@ static void setup_ll_privacy_set_flags_1(const void *test_data)
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
 
+	data->setup_settle = true;
+
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
 					sizeof(load_irks_le_public_param_1),
 					load_irks_le_public_param_1,
 					setup_load_irks_callback, NULL, NULL);
 
 	/* Set Powered On */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
@@ -11617,6 +11703,8 @@ static void setup_set_device_flags_callback(uint8_t status, uint16_t length,
 	}
 
 	tester_print("Device Flags are set");
+
+	test_setup_condition_complete(tester_get_data());
 }
 
 static void setup_ll_privacy_add_2(const void *test_data)
@@ -11624,6 +11712,8 @@ static void setup_ll_privacy_add_2(const void *test_data)
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
 
+	data->setup_settle = true;
+
 	/* Add IRKs of Device1 and Device2 */
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
 					sizeof(load_irks_2_devices_param),
@@ -11631,16 +11721,20 @@ static void setup_ll_privacy_add_2(const void *test_data)
 					setup_load_irks_callback, NULL, NULL);
 
 	/* Set Powered On */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 	/* Device 1 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_1),
 					set_device_flags_param_1,
@@ -11653,6 +11747,8 @@ static void setup_ll_privacy_set_flags_3(const void *test_data)
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
 
+	data->setup_settle = true;
+
 	/* Add IRKs of Device1 and Device2 */
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
 					sizeof(load_irks_2_devices_param),
@@ -11660,17 +11756,21 @@ static void setup_ll_privacy_set_flags_3(const void *test_data)
 					setup_load_irks_callback, NULL, NULL);
 
 	/* Set Powered On */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 1 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_1),
 					set_device_flags_param_1,
@@ -11678,6 +11778,7 @@ static void setup_ll_privacy_set_flags_3(const void *test_data)
 					NULL);
 
 	/* Add Device 2 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
@@ -11698,6 +11799,8 @@ static void setup_ll_privacy_3_devices(const void *test_data)
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
 
+	data->setup_settle = true;
+
 	/* Add IRKs of 4 Devices */
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
 					sizeof(load_irks_4_devices_param),
@@ -11705,12 +11808,14 @@ static void setup_ll_privacy_3_devices(const void *test_data)
 					setup_load_irks_callback, NULL, NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 1 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_1),
 					set_device_flags_param_1,
@@ -11718,12 +11823,14 @@ static void setup_ll_privacy_3_devices(const void *test_data)
 					NULL);
 
 	/* Add Device 2 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 2 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_2),
 					set_device_flags_param_2,
@@ -11731,21 +11838,25 @@ static void setup_ll_privacy_3_devices(const void *test_data)
 					NULL);
 
 	/* Add Device 3 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_3),
 					add_device_le_public_param_3,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 3 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_3),
 					set_device_flags_param_3,
 					setup_set_device_flags_callback, NULL,
 					NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 }
 
 static void setup_ll_privacy_set_flags_4(const void *test_data)
@@ -11753,6 +11864,8 @@ static void setup_ll_privacy_set_flags_4(const void *test_data)
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
 
+	data->setup_settle = true;
+
 	hciemu_set_central_le_rl_len(data->hciemu, 4);
 
 	/* Add IRKs of 4 Devices */
@@ -11762,12 +11875,14 @@ static void setup_ll_privacy_set_flags_4(const void *test_data)
 					setup_load_irks_callback, NULL, NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 1 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_1),
 					set_device_flags_param_1,
@@ -11775,12 +11890,14 @@ static void setup_ll_privacy_set_flags_4(const void *test_data)
 					NULL);
 
 	/* Add Device 2 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 2 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_2),
 					set_device_flags_param_2,
@@ -11788,12 +11905,14 @@ static void setup_ll_privacy_set_flags_4(const void *test_data)
 					NULL);
 
 	/* Add Device 3 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_3),
 					add_device_le_public_param_3,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 3 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_3),
 					set_device_flags_param_3,
@@ -11801,14 +11920,17 @@ static void setup_ll_privacy_set_flags_4(const void *test_data)
 					NULL);
 
 	/* Add Device 4 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_4),
 					add_device_le_public_param_4,
 					setup_add_device_callback, NULL, NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 }
 
 static void setup_ll_privacy_add_3(const void *test_data)
@@ -11816,6 +11938,8 @@ static void setup_ll_privacy_add_3(const void *test_data)
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
 
+	data->setup_settle = true;
+
 	hciemu_set_central_le_al_len(data->hciemu, 2);
 
 	/* Add IRKs of 3 Devices */
@@ -11825,17 +11949,21 @@ static void setup_ll_privacy_add_3(const void *test_data)
 					setup_load_irks_callback, NULL, NULL);
 
 	/* Set Powered On */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 1 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_1),
 					set_device_flags_param_1,
@@ -11843,12 +11971,14 @@ static void setup_ll_privacy_add_3(const void *test_data)
 					NULL);
 
 	/* Add Device 2 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 2 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_2),
 					set_device_flags_param_2,
@@ -11863,9 +11993,13 @@ static void setup_ll_privacy_device2_discovry(const void *test_data)
 	unsigned char param[] = { 0x01 };
 	uint8_t disc_param[] = { 0x06 };
 
+	data->setup_settle = true;
+
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 	/* Load IRKs */
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
 					sizeof(load_irks_2_devices_param),
@@ -11873,11 +12007,13 @@ static void setup_ll_privacy_device2_discovry(const void *test_data)
 					setup_load_irks_callback, NULL, NULL);
 
 	/* Load Device1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
@@ -11906,6 +12042,8 @@ static void setup_ll_privacy_add_4(const void *test_data)
 	unsigned char param[] = { 0x01 };
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 
+	data->setup_settle = true;
+
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
 
@@ -11926,6 +12064,8 @@ static void setup_ll_privacy_set_flags_5(const void *test_data)
 	unsigned char param[] = { 0x01 };
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 
+	data->setup_settle = true;
+
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
 
@@ -11941,11 +12081,13 @@ static void setup_ll_privacy_set_flags_5(const void *test_data)
 					NULL, NULL, NULL);
 
 	/* Add Advertising Instance */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
 					sizeof(adv_param), adv_param,
 					setup_add_adv_callback_adv, NULL, NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
@@ -11959,6 +12101,8 @@ static void setup_ll_privacy_set_flags_6(const void *test_data)
 	unsigned char param[] = { 0x01 };
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 
+	data->setup_settle = true;
+
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
 
@@ -11974,17 +12118,20 @@ static void setup_ll_privacy_set_flags_6(const void *test_data)
 					NULL, NULL, NULL);
 
 	/* Add Advertising Instance 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
 					sizeof(adv_param), adv_param,
 					setup_add_adv_callback_adv, NULL, NULL);
 
 	/* Add Device 2 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 2 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_2),
 					set_device_flags_param_2,
@@ -11992,6 +12139,7 @@ static void setup_ll_privacy_set_flags_6(const void *test_data)
 					NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
@@ -12005,6 +12153,8 @@ static void setup_ll_privacy_adv_3_devices(const void *test_data)
 	unsigned char param[] = { 0x01 };
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 
+	data->setup_settle = true;
+
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
 
@@ -12019,12 +12169,14 @@ static void setup_ll_privacy_adv_3_devices(const void *test_data)
 					setup_load_irks_callback, NULL, NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 1 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_1),
 					set_device_flags_param_1,
@@ -12032,12 +12184,14 @@ static void setup_ll_privacy_adv_3_devices(const void *test_data)
 					NULL);
 
 	/* Add Device 2 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 2 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_2),
 					set_device_flags_param_2,
@@ -12045,21 +12199,25 @@ static void setup_ll_privacy_adv_3_devices(const void *test_data)
 					NULL);
 
 	/* Add Device 3 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_3),
 					add_device_le_public_param_3,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 3 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_3),
 					set_device_flags_param_3,
 					setup_set_device_flags_callback, NULL,
 					NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 }
 
 static void setup_ll_privacy_adv_1_device_2_advs(const void *test_data)
@@ -12069,6 +12227,8 @@ static void setup_ll_privacy_adv_1_device_2_advs(const void *test_data)
 	unsigned char param[] = { 0x01 };
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 
+	data->setup_settle = true;
+
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
 
@@ -12083,12 +12243,14 @@ static void setup_ll_privacy_adv_1_device_2_advs(const void *test_data)
 					NULL, NULL, NULL);
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 1 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_1),
 					set_device_flags_param_1,
@@ -12096,18 +12258,21 @@ static void setup_ll_privacy_adv_1_device_2_advs(const void *test_data)
 					NULL);
 
 	/* Add Device 2 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_2),
 					add_device_le_public_param_2,
 					setup_add_device_callback, NULL, NULL);
 
 	/* Device 2 Flags */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEVICE_FLAGS, data->mgmt_index,
 					sizeof(set_device_flags_param_2),
 					set_device_flags_param_2,
 					setup_set_device_flags_callback, NULL,
 					NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
 					sizeof(adv_param), adv_param,
 					setup_add_adv_callback_adv, NULL, NULL);
@@ -12133,6 +12298,7 @@ static void setup_add_2_advertisings(const void *test_data)
 					sizeof(param), param,
 					NULL, NULL, NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
 						sizeof(adv_param), adv_param,
 						setup_add_adv_callback_adv,
@@ -12155,6 +12321,7 @@ static void setup_add_2_advertisings_no_power(const void *test_data)
 						sizeof(param), &param,
 						NULL, NULL, NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
 						sizeof(adv_param), adv_param,
 						setup_add_adv_callback_adv,
@@ -12167,6 +12334,8 @@ static void setup_ll_privacy_enable_powered(const void *test_data)
 	unsigned char param[] = { 0x01 };
 	struct bthost *bthost;
 
+	data->setup_settle = true;
+
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_scan_params(bthost, 0x01, 0x00, 0x00);
 	bthost_set_scan_enable(bthost, 0x01);
@@ -12184,6 +12353,8 @@ static void setup_ll_privacy_add_adv(const void *test_data)
 	unsigned char set_adv_param[] = { 0x02 };
 	struct bthost *bthost;
 
+	data->setup_settle = true;
+
 	/* Setup bthost to enable the scan */
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_scan_params(bthost, 0x01, 0x00, 0x00);
@@ -12216,15 +12387,20 @@ static void setup_ll_privacy_add_device(const void *test_data)
 	struct test_data *data = tester_get_data();
 	unsigned char param[] = { 0x01 };
 
+	data->setup_settle = true;
+
 	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
 					sizeof(load_irks_le_public_param_1),
 					load_irks_le_public_param_1,
 					setup_load_irks_callback, NULL, NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_le_public_param_1),
 					add_device_le_public_param_1,
@@ -13583,15 +13759,18 @@ static void setup_suspend_resume_success_3(const void *test_data)
 	unsigned char param[] = { 0x01 };
 
 	/* Add Device 1 */
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
 					sizeof(add_device_success_param_3),
 					add_device_success_param_3,
 					setup_add_device_callback,
 					NULL, NULL);
 
+	test_add_setup_condition(data);
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_powered_condition_callback,
+					NULL, NULL);
 }
 
 static void test_suspend_resume_success_3(const void *test_data)
-- 
2.56.0


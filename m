Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641129;
	b=HGa5ssLHavdOF192Wdjdt9fx+i45jbb56uhVRCFLspJo1ef4PN1g8VJdYHmGHsP4Xn5U
	 o/ZM37O4i70vaNJzcXjmTfMyjS2Sr1UEVy5KqD5ckYPHrRDW9d1pr5tRnaeawJy99RYJm
	 VQ5XJ6ipdk6nW/I6Bq9/nXmkci5m9kGv15t9phbfbq48THnXYQqcYNd/D29vxU2QCHGfH
	 ycLuJoDXmEWD5qD0dQYbsmlffBg2ZHZrHE53LV0dWXhjibFJLILA21NiWPQwlxNpIODSD
	 iGoZp+zO/5lKXwN2i8cEvynFl4Cz9KYBZfKVBhUKxtz7bCRWfDjd8F4mcnXe6o+GB/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ulioZ4D22H3PsdoWrHS41jWOUqIiGwb2xi4lOvWdXq8=;
	b=PYeOKK06Wf0WGIcltFbEeV+KWNWlLnXDBKJyztAeRqAblOWQlOAfjTfZNDSlHDthH9yK
	 27R/hhjUe97nbQ0q0iUCQ34e1PnE4Mc1cz8xGvY1jzHpUozw8+GQ89v1i55oMk34hhTaz
	 Q2Xb/vAVtBxDw+D3jO6uVPKklwtWf661GwWnyYeTpIFy4sDaZhSCaHcBG8j25VvCJxlCH
	 iJMbJSVYjk/GFLBqESim4jcvC2B4yyCQLFMlgydOGMM24FQbxvlSFhqZtd8Hr/h++/YRy
	 wK6kqNOzi7aSb04zdsdbsPFDLmxG+yntd7w5hwcmY8UzIwM5eU/w1iDkkQbYQ97dTbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JmrRajQV;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67907606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67907606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JmrRajQV
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9906870a9baso3189121241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641128; x=1796245928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ulioZ4D22H3PsdoWrHS41jWOUqIiGwb2xi4lOvWdXq8=;
        b=JmrRajQVdIKaG0ssr2UqIu0/aKKxl4ULupG5c95fUatOX3WR1hnJElb9PvrLrVKR/f
         +kszuHHlAtLV+1uOnliQCZuDst4Jlcz1YRgWGHnVFkgZmwhzRyGfokS0E8K0vp97kn6c
         w6pmhlxvdCjyBe6b20I/BEBB40vzQ1tRr5HQkUNoYeFIrJ4rGiCR5NjnW9brRVFM2Lts
         25rvoLsBtL14tw9kSrtvQniqc1LvhMGPeFtbpbo/0QA+wFAd07w1avzxF9XEIIfJyBXd
         PolhSeBU2XwMHiiCZUXI4q1EWgc/j8aNaTpca84HUIU6TKWWj8F299J5HfplDXPoqIpf
         zurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641128; x=1796245928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ulioZ4D22H3PsdoWrHS41jWOUqIiGwb2xi4lOvWdXq8=;
        b=C5KWzRukBq5/B8/IgGEuoC3xO2o7bZhz/Z2TA2u1y6f8f47NBneYtKPp68tG2Uryl/
         uvGeOMcV+RpT/sUBu+otKtMH5fc73AbVWtgQrS4vk1OeztRzc3PWeKdBLePXDwA4wGFP
         pbWQC6wTbpqAVXTrm1/chdG6wKNrhGTtZPMAjON0r8jZoi+UGoPrSBP6gNRM5H6oYe9x
         1BZp9Skhy3PSssMm62fjDxIVKiKaoQRLCWhkIrO8YprYCyEnc8GKuWzC9fuSNY9WBBE5
         +FzoL2yKfhdXzVQMqXsZ+0QiUib947TnNhVyIHXNdYwvpGQJmCBTQZDkphuoWS05ECV9
         hYeg==
X-Gm-Message-State: APuU4Z9zdrZ+okIobeUqzKWNcuBGSz7Dr2wQ8qwz62pkBNw9CwP0KUQn
	MvWbg2uQ0IQiOiRjtfvhnMvYE4xSCHDOTOJkMZSfZKMUc5Ix/DjtfIlUg7FGsQ==
X-Gm-Gg: AZFdTZekR94b39mPAM5WZIda+y1ooeASmMHcAzSLaDAfaFtXYciRPtORCghaqrpE73i
	Ug42w83uvL26FAISSXKfptXZNIeG7W+irD/yZeuT/g8wZ5PJubJk7RkyoT7xwnqurQMxVOw0myY
	Eo/Z1DYElghUBiML2Oz4WsKpZsw8YZRoZOTFWmZUULjCjtAHWbNVi1QJhF1NaXL//fzcxlHmVE6
	Qg58cMtDr3xCi7UGUQrAeUyd78BZHPJG/dIpWsh+CdCXBuKj8rrsXRgR56vR2CkFV4ONBKvCODg
	GbsNsgGdTObbQFBTgZmDN1QrRKKEIjrXPbo29tABzBBUidY3sqJgN2RkC7SIr7TIg6BS8rN7Fgi
	tlu2aS0thil6wOenN+p41RfAdM3tc+ZP1uUKAZ93QAekAaQQayZ63gEZVLJMhufVuCuwGApkC45
	jGues8rbbyFD6g9aE71PdVCIblnITG+ye8ae/uNlAqSY/5vD1ZVvFZGS+jAgDqEmV8f7yuZ5Qls
	EElNSYJ3tbKcsL2Ay0lBN9DD+RuLd7I1E0AQSpvoY8/rqFMak0YXtlh4fxHLP+fWzTwuSv+7cG6
	WCyDLL4bk6OUq5jDE0u9v5hse7k/SsHPrJ3TevfUTCBTvzywoRq2vJT0KJ/BDZScXf8WP0f6jbj
	4xERMxYHASzIpXxz3bt6e+1AT87yZ8b50CuUnKEUNMkxDhC933CLIChtYgl29F7R/pBIAP2ZHpW
	oyEQA=
X-Received: by 2002:a05:6102:14a3:b0:7d2:c903:515d with SMTP id ada2fe7eead31-7d7393ae1e1mr13055532137.7.1795641128331;
        Wed, 25 Nov 2026 13:12:08 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e0686b1sm20199653241.10.2026.11.25.13.12.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 6/6] l2cap-tester: Add tests for partially accepting Ext-Flowctl requests
Date: Wed, 25 Nov 2026 16:12:00 -0500
Message-ID: <20261125211200.1955466-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125211200.1955466-1-luiz.dentz@gmail.com>
References: <20261125211200.1955466-1-luiz.dentz@gmail.com>
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

Add the following tests:

L2CAP Ext-Flowctl Server - Accept 1 Refuse 1
L2CAP Ext-Flowctl Server - Refuse 1 Accept 1

A listener using deferred setup may accept only some of the channels of
an Enhanced Credit Based Connection Request, e.g. because it limits the
number of channels, and refuse the rest, so the response is expected to
be successful for the ones accepted, with their destination CID, and to
have a destination CID of 0 for the ones refused, with a result telling
that only some of the connections were refused.

The tests send a request with 2 channels and have the listener authorize
one and close the other, in both orders.

Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 tools/l2cap-tester.c | 115 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 58fd77a3ec79..ca868e9d72ec 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -144,6 +144,8 @@ struct l2cap_data {
 	bool pending_rsp;
 	/* Link key type the controller reports instead of the actual one */
 	uint8_t link_key_type;
+	/* Bitmask of the incoming connections the listener refuses */
+	uint8_t refuse_mask;
 
 	bool shut_sock_wr;
 
@@ -1657,6 +1659,54 @@ static const uint8_t ecred_connect_req_2[] = {
 						0x42, 0x00, /* SCID #2 */
 };
 
+/* Only some of the channels of the request are refused: the response is
+ * successful for the others, with their destination CID, and has none for
+ * the refused ones.
+ */
+static const uint8_t ecred_connect_rsp_refuse_2[] = {
+						0xa0, 0x02, /* MTU */
+						0xbc, 0x00, /* MPS */
+						0x04, 0x00, /* Credits */
+						0x04, 0x00, /* Result */
+						0x40, 0x00, /* DCID #1 */
+						0x00, 0x00, /* DCID #2 */
+};
+
+static const uint8_t ecred_connect_rsp_refuse_1[] = {
+						0xa0, 0x02, /* MTU */
+						0xbc, 0x00, /* MPS */
+						0x04, 0x00, /* Credits */
+						0x04, 0x00, /* Result */
+						0x00, 0x00, /* DCID #1 */
+						0x41, 0x00, /* DCID #2 */
+};
+
+static const struct l2cap_data ext_flowctl_server_accept_1_refuse_2_test = {
+	.server_psm = 0x0080,
+	.defer = true,
+	.refuse_mask = 0x02,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req_2,
+	.send_cmd_len = ARRAY_SIZE(ecred_connect_req_2),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp_refuse_2,
+	.expect_cmd_len = sizeof(ecred_connect_rsp_refuse_2),
+};
+
+static const struct l2cap_data ext_flowctl_server_refuse_1_accept_2_test = {
+	.server_psm = 0x0080,
+	.defer = true,
+	.refuse_mask = 0x01,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req_2,
+	.send_cmd_len = ARRAY_SIZE(ecred_connect_req_2),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp_refuse_1,
+	.expect_cmd_len = sizeof(ecred_connect_rsp_refuse_1),
+};
+
 static const struct l2cap_data ext_flowctl_server_accept_2_close_1_test = {
 	.server_psm = 0x0080,
 	.defer = true,
@@ -4561,6 +4611,63 @@ fail:
 	return false;
 }
 
+/* Accept the connections of the request in order, authorizing the ones the
+ * listener doesn't refuse, which are kept open, and closing without
+ * authorizing the ones it does.
+ */
+static bool ext_flowctl_accept_refuse_listen_cb(struct tester_io *io,
+					uint32_t cond, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	struct tester_io *new_io;
+	int sk, new_sk;
+	int idx = data->step++;
+
+	sk = tester_io_get_fd(io);
+
+	new_sk = accept(sk, NULL, NULL);
+	if (new_sk < 0) {
+		tester_warn("accept failed: %s (%u)", strerror(errno), errno);
+		tester_test_failed();
+		return false;
+	}
+
+	if (l2data->refuse_mask & (1 << idx)) {
+		tester_print("Refuse sk = %d", new_sk);
+		close(new_sk);
+	} else {
+		tester_print("Authorize sk = %d", new_sk);
+
+		new_io = tester_io_new(new_sk);
+		tester_io_set_close_on_unref(new_io, true);
+
+		if (!data->io_channels)
+			data->io_channels = queue_new();
+		queue_push_tail(data->io_channels, new_io);
+
+		if (!defer_accept(data, tester_io_ref(new_io), NULL)) {
+			tester_io_unref(new_io);
+			tester_warn("Unable to accept deferred setup");
+			tester_test_failed();
+			return false;
+		}
+	}
+
+	/* The request has two channels */
+	if (data->step < 2)
+		return true;
+
+	data->io_id = 0;
+	return false;
+}
+
+static void test_ext_flowctl_server_accept_refuse(const void *test_data)
+{
+	start_test_server(test_data, send_req_new_conn,
+					ext_flowctl_accept_refuse_listen_cb);
+}
+
 static void test_ext_flowctl_server_accept_2_close_1(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -5173,6 +5280,14 @@ int main(int argc, char *argv[])
 				&ext_flowctl_server_accept_2_close_1_test,
 				setup_powered_server,
 				test_ext_flowctl_server_accept_2_close_1);
+	test_l2cap_le("L2CAP Ext-Flowctl Server - Accept 1 Refuse 1",
+				&ext_flowctl_server_accept_1_refuse_2_test,
+				setup_powered_server,
+				test_ext_flowctl_server_accept_refuse);
+	test_l2cap_le("L2CAP Ext-Flowctl Server - Refuse 1 Accept 1",
+				&ext_flowctl_server_refuse_1_accept_2_test,
+				setup_powered_server,
+				test_ext_flowctl_server_accept_refuse);
 	test_l2cap_le("L2CAP Ext-Flowctl Server - PHY",
 				&ext_flowctl_server_phy_test,
 				setup_powered_server, test_server);
-- 
2.56.0


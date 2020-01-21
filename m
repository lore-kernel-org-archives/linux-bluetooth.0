Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3018C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 09:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E7124653
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 09:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rn2jvH7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAUJPS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:15:18 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:44526 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUJPS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 04:15:18 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200121091515epoutp02a7b8407fcab6800b53c9b4ee8bb2e19d~r3B31bGKT1504715047epoutp02a
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 09:15:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200121091515epoutp02a7b8407fcab6800b53c9b4ee8bb2e19d~r3B31bGKT1504715047epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579598115;
        bh=0TUnpqS3RPRR4v9xdHshp7oK1wzAZbFlyETQUvWe5ro=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Rn2jvH7DGfEgjdpb/4l/ydZniRUTIXud0mCyGX8QO582HtRYlRHlI0FPo6s64ioU2
         WRtNo7NnFShY0++rXZ20AXKwPfDJScbkqD/uXzwlFyCKt3mL7T+viwtxe+yevmOE9f
         dPBEdNiBOKrkQaumJ9fvy7tj23imgu3mJPP+PRkk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200121091515epcas5p1d88e7de7171b27e4817076f94fb65f6e~r3B3i6cd32398223982epcas5p1R;
        Tue, 21 Jan 2020 09:15:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.192]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4822tn3Xh8zMqYkW; Tue, 21 Jan
        2020 09:15:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.74.20197.021C62E5; Tue, 21 Jan 2020 18:15:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200121091512epcas5p3fd399b595da13bbd57edcac6c97ad8be~r3B1LpEB-2474224742epcas5p3O;
        Tue, 21 Jan 2020 09:15:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200121091512epsmtrp262aa5f177b6faad4f38340f47356e48f~r3B1LGeov0608806088epsmtrp29;
        Tue, 21 Jan 2020 09:15:12 +0000 (GMT)
X-AuditID: b6c32a4a-781ff70000014ee5-e4-5e26c1201083
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.A9.10238.021C62E5; Tue, 21 Jan 2020 18:15:12 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200121091512epsmtip18802d31547fa2a0b3adca20f3ec7296a~r3B0oWO0M0826108261epsmtip1W;
        Tue, 21 Jan 2020 09:15:11 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH v1 1/1] mesh: Handle publickey exchange phase for initiator
Date:   Tue, 21 Jan 2020 14:44:58 +0530
Message-Id: <1579598098-27136-1-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7bCmlq7iQbU4g9mxFnOu9TFb/F96i92B
        yaNvyypGj8+b5AKYonJsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4CmKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKDI0K9IoTc4tL89L1
        kvNzrQwNDIxMgSoTcjLOH1vLXLDRvWLzryusDYwLLbsYOTkkBEwkNrevZe1i5OIQEtjNKHG5
        5S0zSEJI4BOjxNJZfhCJb4wSP3onMHUxcoB1XL7CCRHfyygxZ/JxFging0li49xlrCDdbALG
        EudvvmICsUUElCWe7TsMZjMLaEtMejMTzBYW8JY4vWA9I4jNIqAqsWLeDzaQBbwCHhLTbhVA
        XCcncfNcJzOEfZJV4v9+UQjbRaLnxUeouLDEq+Nb2CFsKYnP7/ayQdjdjBK737iC3CYhMIVR
        4t4LiBskBOwlnm6ayw6yi1lAU2L9Ln2I0/gken8/gfqRV6KjTQiiWkFi1dSJUJ1iEuumf4Fa
        5SGxeuVndkhYxUqc3HaMZQKjzCyEoQsYGVcxSqYWFOempxabFhjlpZYjx8wmRnAy0fLawbjs
        nM8hRgEORiUeXodpqnFCrIllxZW5hxglOJiVRHgXNAGFeFMSK6tSi/Lji0pzUosPMZoCg2wi
        s5Rocj4w0eWVxBuaGpmZGVgamBpbmBkqifNOYr0aIySQnliSmp2aWpBaBNPHxMEp1cCYP9Fk
        a+o/FqbgMDe9m0vf7gxSXfb2waHH0b/N5uS5OhRcLuRgT9s+4cLNvzMWRcxoa3Hel9w90WNq
        +N/Pc6Rac4M6Pp96clfrxpMNXJ3Xg4oURLImyqVe3yLP5d9yOV4kN736mJPDeatDGWbdle9f
        HjlbcUfIV9ggNrFa/c6hTsFpXmtOBEkrsRRnJBpqMRcVJwIAcZiKGjwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJMWRmVeSWpSXmKPExsWy7bCSnK7CQbU4g9YpShZzrvUxW/xfeovd
        gcmjb8sqRo/Pm+QCmKK4bFJSczLLUov07RK4Ms4fW8tcsNG9YvOvK6wNjAstuxg5OCQETCQu
        X+HsYuTiEBLYzShx+Ec3cxcjJ1BcTOLNihPsELawxMp/z9khitqYJG6fewBWxCZgLHH+5ism
        EFtEQFni2b7DYDazgLbEpDczwWxhAW+J0wvWM4LYLAKqEivm/WADWcwr4CEx7VYBxHw5iZvn
        OpknMPIsYGRYxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kR7HMtzR2Ml5fEH2IU4GBU
        4uF1mKYaJ8SaWFZcmXuIUYKDWUmEd0ETUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC
        6YklqdmpqQWpRTBZJg5OqQbGrgY3i8M6Liz8O10OfD9buO6MX15e6u/Xdvt/MXsLF928L2OV
        wTn1vpBUSBiDNI+nI3vv5DwrjaC/ipeWXFvRZvg/0OATp6+wM8+GU93n5/TnCi16obj8QN81
        g57LzRPWbU8SW7J7G9s+v9PXJr9SMRdzdLB1/SrnzDfjv+fLy2vtilbptf1XYinOSDTUYi4q
        TgQAe2zmd/UBAAA=
X-CMS-MailID: 20200121091512epcas5p3fd399b595da13bbd57edcac6c97ad8be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200121091512epcas5p3fd399b595da13bbd57edcac6c97ad8be
References: <CGME20200121091512epcas5p3fd399b595da13bbd57edcac6c97ad8be@epcas5p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

In Public Key OOB case, when provisioner receives public key via
OOB, provisioner has to send it's public key to remote node and
and then proceed for authentication.

Handle invalid keys case.
---
 mesh/prov-initiator.c | 231 +++++++++++++++++++++++++-----------------
 1 file changed, 136 insertions(+), 95 deletions(-)

diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 7efd5b349..21f686264 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -186,7 +186,7 @@ static void int_prov_open(void *user_data, prov_trans_tx_t trans_tx,
 	return;
 }
 
-static void prov_calc_secret(const uint8_t *pub, const uint8_t *priv,
+static bool prov_calc_secret(const uint8_t *pub, const uint8_t *priv,
 							uint8_t *secret)
 {
 	uint8_t tmp[64];
@@ -196,22 +196,27 @@ static void prov_calc_secret(const uint8_t *pub, const uint8_t *priv,
 	swap_u256_bytes(tmp);
 	swap_u256_bytes(tmp + 32);
 
-	ecdh_shared_secret(tmp, priv, secret);
+	if (!ecdh_shared_secret(tmp, priv, secret))
+		return false;
 
 	/* Convert to Mesh byte order */
 	swap_u256_bytes(secret);
+	return true;
 }
 
-static void int_credentials(struct mesh_prov_initiator *prov)
+static bool int_credentials(struct mesh_prov_initiator *prov)
 {
-	prov_calc_secret(prov->conf_inputs.dev_pub_key,
-			prov->private_key, prov->secret);
+	if (!prov_calc_secret(prov->conf_inputs.dev_pub_key,
+				prov->private_key, prov->secret))
+		goto failure;
 
-	mesh_crypto_s1(&prov->conf_inputs,
-			sizeof(prov->conf_inputs), prov->salt);
+	if (!mesh_crypto_s1(&prov->conf_inputs,
+				sizeof(prov->conf_inputs), prov->salt))
+		goto failure;
 
-	mesh_crypto_prov_conf_key(prov->secret, prov->salt,
-			prov->calc_key);
+	if (!mesh_crypto_prov_conf_key(prov->secret, prov->salt,
+				prov->calc_key))
+		goto failure;
 
 	l_getrandom(prov->rand_auth_workspace, 16);
 
@@ -224,6 +229,11 @@ static void int_credentials(struct mesh_prov_initiator *prov)
 	print_packet("LocalRandom", prov->rand_auth_workspace, 16);
 	print_packet("ConfirmationSalt", prov->salt, 16);
 	print_packet("ConfirmationKey", prov->calc_key, 16);
+
+	return true;
+
+failure:
+	return false;
 }
 
 static uint8_t u16_high_bit(uint16_t mask)
@@ -320,10 +330,21 @@ static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 	send_confirm(prov);
 }
 
+static void send_pub_key(struct mesh_prov_initiator *prov)
+{
+	struct prov_pub_key_msg msg;
+
+	msg.opcode = PROV_PUB_KEY;
+	memcpy(msg.pub_key, prov->conf_inputs.prv_pub_key, 64);
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+	prov->state = INT_PROV_KEY_SENT;
+}
+
 static void pub_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
 	struct prov_fail_msg msg;
+	uint8_t fail_code[2];
 
 	if (prov != rx_prov)
 		return;
@@ -338,20 +359,17 @@ static void pub_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 	memcpy(prov->conf_inputs.dev_pub_key, key, 64);
 	prov->material |= MAT_REMOTE_PUBLIC;
 
-	if ((prov->material & MAT_SECRET) == MAT_SECRET)
-		int_credentials(prov);
-
-	send_confirm(prov);
-}
-
-static void send_pub_key(struct mesh_prov_initiator *prov)
-{
-	struct prov_pub_key_msg msg;
+	if ((prov->material & MAT_SECRET) == MAT_SECRET) {
+		if (!int_credentials(prov)) {
+			fail_code[0] = PROV_FAILED;
+			fail_code[1] = PROV_ERR_UNEXPECTED_ERR;
+			prov->trans_tx(prov->trans_data, fail_code, 2);
+			int_prov_close(prov, fail_code[1]);
+			return;
+		}
+	}
 
-	msg.opcode = PROV_PUB_KEY;
-	memcpy(msg.pub_key, prov->conf_inputs.prv_pub_key, 64);
-	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
-	prov->state = INT_PROV_KEY_SENT;
+	send_pub_key(prov);
 }
 
 static void send_random(struct mesh_prov_initiator *prov)
@@ -482,13 +500,99 @@ static void get_random_key(struct mesh_prov_initiator *prov, uint8_t action,
 	l_put_be32(oob_key, prov->rand_auth_workspace + 44);
 }
 
+static void int_prov_auth(void)
+{
+	uint8_t fail_code[2];
+	uint32_t oob_key;
+
+	prov->state = INT_PROV_KEY_ACKED;
+
+	l_debug("auth_method: %d", prov->conf_inputs.start.auth_method);
+	memset(prov->rand_auth_workspace + 16, 0, 32);
+
+	switch (prov->conf_inputs.start.auth_method) {
+	default:
+	case 0:
+		/* Auth Type 3c - No OOB */
+		prov->material |= MAT_RAND_AUTH;
+		break;
+	case 1:
+		/* Auth Type 3c - Static OOB */
+		/* Prompt Agent for Static OOB */
+		fail_code[1] = mesh_agent_request_static(prov->agent,
+				static_cb, prov);
+
+		if (fail_code[1])
+			goto failure;
+
+		break;
+	case 2:
+		/* Auth Type 3a - Output OOB */
+		/* Prompt Agent for Output OOB */
+		if (prov->conf_inputs.start.auth_action ==
+						PROV_ACTION_OUT_ALPHA) {
+			fail_code[1] = mesh_agent_prompt_alpha(
+				prov->agent, true,
+				static_cb, prov);
+		} else {
+			fail_code[1] = mesh_agent_prompt_number(
+				prov->agent, true,
+				prov->conf_inputs.start.auth_action,
+				number_cb, prov);
+		}
+
+		if (fail_code[1])
+			goto failure;
+
+		break;
+
+	case 3:
+		/* Auth Type 3b - input OOB */
+		get_random_key(prov,
+				prov->conf_inputs.start.auth_action,
+				prov->conf_inputs.start.auth_size);
+		oob_key = l_get_be32(prov->rand_auth_workspace + 28);
+
+		/* Ask Agent to Display random key */
+		if (prov->conf_inputs.start.auth_action ==
+						PROV_ACTION_IN_ALPHA) {
+
+			fail_code[1] = mesh_agent_display_string(
+				prov->agent,
+				(char *) prov->rand_auth_workspace + 16,
+				NULL, prov);
+		} else {
+			fail_code[1] = mesh_agent_display_number(
+				prov->agent, true,
+				prov->conf_inputs.start.auth_action,
+				oob_key, NULL, prov);
+		}
+
+		if (fail_code[1])
+			goto failure;
+
+		break;
+
+	}
+
+	if (prov->material & MAT_RAND_AUTH)
+		send_confirm(prov);
+
+	return;
+
+failure:
+	l_debug("Failing... %d", fail_code[1]);
+	fail_code[0] = PROV_FAILED;
+	prov->trans_tx(prov->trans_data, fail_code, 2);
+	int_prov_close(prov, fail_code[1]);
+}
+
 static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
 	uint8_t *out;
 	uint8_t type = *data++;
 	uint8_t fail_code[2];
-	uint32_t oob_key;
 
 	if (rx_prov != prov || !prov->trans_tx)
 		return;
@@ -596,79 +700,12 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		if ((prov->material & MAT_SECRET) != MAT_SECRET)
 			return;
 
-		int_credentials(prov);
-		prov->state = INT_PROV_KEY_ACKED;
-
-		l_debug("auth_method: %d", prov->conf_inputs.start.auth_method);
-		memset(prov->rand_auth_workspace + 16, 0, 32);
-		switch (prov->conf_inputs.start.auth_method) {
-		default:
-		case 0:
-			/* Auth Type 3c - No OOB */
-			prov->material |= MAT_RAND_AUTH;
-			break;
-		case 1:
-			/* Auth Type 3c - Static OOB */
-			/* Prompt Agent for Static OOB */
-			fail_code[1] = mesh_agent_request_static(prov->agent,
-					static_cb, prov);
-
-			if (fail_code[1])
-				goto failure;
-
-			break;
-		case 2:
-			/* Auth Type 3a - Output OOB */
-			/* Prompt Agent for Output OOB */
-			if (prov->conf_inputs.start.auth_action ==
-							PROV_ACTION_OUT_ALPHA) {
-				fail_code[1] = mesh_agent_prompt_alpha(
-					prov->agent, true,
-					static_cb, prov);
-			} else {
-				fail_code[1] = mesh_agent_prompt_number(
-					prov->agent, true,
-					prov->conf_inputs.start.auth_action,
-					number_cb, prov);
-			}
-
-			if (fail_code[1])
-				goto failure;
-
-			break;
-
-		case 3:
-			/* Auth Type 3b - input OOB */
-			get_random_key(prov,
-					prov->conf_inputs.start.auth_action,
-					prov->conf_inputs.start.auth_size);
-			oob_key = l_get_be32(prov->rand_auth_workspace + 28);
-
-			/* Ask Agent to Display random key */
-			if (prov->conf_inputs.start.auth_action ==
-							PROV_ACTION_IN_ALPHA) {
-
-				fail_code[1] = mesh_agent_display_string(
-					prov->agent,
-					(char *) prov->rand_auth_workspace + 16,
-					NULL, prov);
-			} else {
-				fail_code[1] = mesh_agent_display_number(
-					prov->agent, true,
-					prov->conf_inputs.start.auth_action,
-					oob_key, NULL, prov);
-			}
-
-			if (fail_code[1])
-				goto failure;
-
-			break;
-
+		if (!int_credentials(prov)) {
+			fail_code[1] = PROV_ERR_UNEXPECTED_ERR;
+			goto failure;
 		}
 
-		if (prov->material & MAT_RAND_AUTH)
-			send_confirm(prov);
-
+		int_prov_auth();
 		break;
 
 	case PROV_INP_CMPLT: /* Provisioning Input Complete */
@@ -760,11 +797,15 @@ static void int_prov_ack(void *user_data, uint8_t msg_num)
 		prov->state = INT_PROV_DATA_ACKED;
 		break;
 
+	case INT_PROV_KEY_SENT:
+		if (prov->conf_inputs.caps.pub_type == 1)
+			int_prov_auth();
+		break;
+
 	case INT_PROV_IDLE:
 	case INT_PROV_INVITE_SENT:
 	case INT_PROV_INVITE_ACKED:
 	case INT_PROV_START_ACKED:
-	case INT_PROV_KEY_SENT:
 	case INT_PROV_KEY_ACKED:
 	case INT_PROV_CONF_SENT:
 	case INT_PROV_CONF_ACKED:
-- 
2.17.1


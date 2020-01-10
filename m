Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D295C33CA2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0B62072E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 09:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QiI9UyBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgAJJyu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:54:50 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:57786 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgAJJyu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 04:54:50 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200110095447epoutp02fc3e0902bc4a88788f68c423d1a03e5a~ofePpAvbE0066500665epoutp02o
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 09:54:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200110095447epoutp02fc3e0902bc4a88788f68c423d1a03e5a~ofePpAvbE0066500665epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578650087;
        bh=qUO9yfRwpmRSEIJUiXTH8DB75pDj7AFZ9QheRP3L0xc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QiI9UyBzeGNlV7iXVUlQi7O7KbN8CvAovlV/XYs4vsY2TvE2tb6BoJE42G92ri0y/
         jejLJiT5CaJlk5ZdfFl7dNyORVhDXm4x9Yr0rKWg4gPTkkdCXxNhrW9GDV2w/ZQ/cr
         H5XIbVuoKbaOiJGCNvzBfp96u5Wuwx1wG32YPd3Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200110095446epcas5p1dbcaa48459b6828cf413cde2365af114~ofeO96wHY0250002500epcas5p1l;
        Fri, 10 Jan 2020 09:54:46 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.196]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47vJHS1zNzzMqYkV; Fri, 10 Jan
        2020 09:54:44 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.67.20197.3E9481E5; Fri, 10 Jan 2020 18:54:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200110095441epcas5p4fcf5071a95b6d213419f8abf9dbdb86f~ofeKmFTqi3127231272epcas5p4-;
        Fri, 10 Jan 2020 09:54:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200110095441epsmtrp1e601cce8232a263c6966cf107ea6d969~ofeKle26J0276702767epsmtrp1s;
        Fri, 10 Jan 2020 09:54:41 +0000 (GMT)
X-AuditID: b6c32a4a-769ff70000014ee5-04-5e1849e34162
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.A6.10238.1E9481E5; Fri, 10 Jan 2020 18:54:41 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200110095441epsmtip27a932d14986be111cc33c6ad73e9bc55~ofeKGb3Mv2908829088epsmtip2v;
        Fri, 10 Jan 2020 09:54:41 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Handle publickey exchange phase for initiator
Date:   Fri, 10 Jan 2020 15:24:30 +0530
Message-Id: <1578650070-8530-1-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmlu5jT4k4g89/BSzmXOtjtvi/9Ba7
        A5NH35ZVjB6fN8kFMEXl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
        Krn4BOi6ZeYAjVdSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFegVJ+YWl+al
        6yXn51oZGhgYmQJVJuRkzJ4wnaWg362i+dNd1gbGVRZdjBwcEgImEq33/boYuTiEBHYzSize
        e4ENwvnEKPHtyHZWCOcbo8SevsvsXYycYB27p3RAVe1llNj16CsjhNPBJLF04nNWkCo2AWOJ
        8zdfMYHYIgLKEs/2HQazmQW0JSa9mQlmCwt4SJw//Y0ZxGYRUJX4tPMf2AZeAXeJKRu+MEFs
        k5O4ea6TGWSBhMBJVoktZ/sYIRIuEtd+voCyhSVeHd8CdZ6UxMv+Nii7m1Fi9xtXiOYpjBL3
        XhyGmmov8XTTXHZQCDALaEqs36UPcRyfRO/vJ0yQgOGV6GgTgqhWkFg1dSJUp5jEuulfoMZ7
        SJxZMRXsBCGBWImnu9ayT2CUmYUwdAEj4ypGydSC4tz01GLTAqO81HLkyNnECE4qWl47GJed
        8znEKMDBqMTDmyEsHifEmlhWXJl7iFGCg1lJhPfoDbE4Id6UxMqq1KL8+KLSnNTiQ4ymwECb
        yCwlmpwPTHh5JfGGpkZmZgaWBqbGFmaGSuK8k1ivxggJpCeWpGanphakFsH0MXFwSjUw5s+u
        Ltg6u/zYVtXp02yybjRM3G60g48vvU9RiM1UoebC3Ted21P9BTft4d82lfeYdIb0HLY/LdP1
        CxUPLtzwoeyD74rNj9/XcHkXC0424L6n4Rh0vjl9fuyzuReK07ti2S1XHlg19a//c+5zzcId
        1Qe/f+SwMPpzNOPt7fnM21e5tk/YW27/U4mlOCPRUIu5qDgRAIZwpmtAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJMWRmVeSWpSXmKPExsWy7bCSvO5DT4k4gznvdCzmXOtjtvi/9Ba7
        A5NH35ZVjB6fN8kFMEVx2aSk5mSWpRbp2yVwZcyeMJ2loN+tovnTXdYGxlUWXYycHBICJhK7
        p3SwdTFycQgJ7GaUuPr5JitEQkzizYoT7BC2sMTKf8/ZIYramCQWPVvEBpJgEzCWOH/zFROI
        LSKgLPFs32Ewm1lAW2LSm5lgtrCAh8T509+YQWwWAVWJTzv/gQ3lFXCXmLLhCxPEAjmJm+c6
        mScw8ixgZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iRHsdy3NHYyXl8QfYhTgYFTi
        4c0QFo8TYk0sK67MPcQowcGsJMJ79IZYnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE
        0hNLUrNTUwtSi2CyTBycUg2Msr0m9xn8T5vefqKZnS/8e4WeyMz9S5akqRi/+7yKabMPv9iB
        PMHnzz7+CJ+cdTh0Z4tJ31ThHcZ37d5s5zg0K7rlSMw91cYHP4/GufOVOeS3njnvs+bXlYtZ
        e+7yvHxzO7HJMslxt95Ki/pQNb3C7GkKnb6dGlzHc0ROGkn9yhE/ubw15P10JZbijERDLeai
        4kQAxa8zkvcBAAA=
X-CMS-MailID: 20200110095441epcas5p4fcf5071a95b6d213419f8abf9dbdb86f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200110095441epcas5p4fcf5071a95b6d213419f8abf9dbdb86f
References: <CGME20200110095441epcas5p4fcf5071a95b6d213419f8abf9dbdb86f@epcas5p4.samsung.com>
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
 mesh/prov-initiator.c | 229 +++++++++++++++++++++++++-----------------
 1 file changed, 135 insertions(+), 94 deletions(-)

diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 7efd5b349..cd6be95b0 100644
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
@@ -338,20 +359,16 @@ static void pub_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 	memcpy(prov->conf_inputs.dev_pub_key, key, 64);
 	prov->material |= MAT_REMOTE_PUBLIC;
 
-	if ((prov->material & MAT_SECRET) == MAT_SECRET)
-		int_credentials(prov);
+	send_pub_key(prov);
 
-	send_confirm(prov);
-}
-
-static void send_pub_key(struct mesh_prov_initiator *prov)
-{
-	struct prov_pub_key_msg msg;
-
-	msg.opcode = PROV_PUB_KEY;
-	memcpy(msg.pub_key, prov->conf_inputs.prv_pub_key, 64);
-	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
-	prov->state = INT_PROV_KEY_SENT;
+	if ((prov->material & MAT_SECRET) == MAT_SECRET) {
+		if (!int_credentials(prov)) {
+			fail_code[0] = PROV_FAILED;
+			fail_code[1] = PROV_ERR_UNEXPECTED_ERR;
+			prov->trans_tx(prov->trans_data, fail_code, 2);
+			int_prov_close(prov, fail_code[1]);
+		}
+	}
 }
 
 static void send_random(struct mesh_prov_initiator *prov)
@@ -482,6 +499,93 @@ static void get_random_key(struct mesh_prov_initiator *prov, uint8_t action,
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


Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EEBC2BAEE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079CD2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="moh0mevq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCXT21 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15024 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgCXT21 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:27 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200324192825epoutp030f0c6d93702fb542c3e507fe81870371~-VCOHnk7F0350603506epoutp03u
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200324192825epoutp030f0c6d93702fb542c3e507fe81870371~-VCOHnk7F0350603506epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078105;
        bh=Bdfw3v6Cs3LjLKuRZVmjPNIxAIm2cNlxjjgJgficcc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moh0mevquWTq70CmI+Isx+0zWSqEXGNQBHg25ArI2c86V7SlbO9nK68Vi2duGobmg
         kYuKmVGJtjPn1+kOoKY0uif/DMUv9BwxT+dLOZSR8iWN02WhTHPdhDi3impJRR36kY
         rcsTzh8w4mCCZ7qB0UH348NmmL24kPO7gH0OV9Ug=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200324192824epcas5p23047e84439302eee4d88abd00fcc46e7~-VCNobLN71207312073epcas5p22;
        Tue, 24 Mar 2020 19:28:24 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.193]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48n1WC4zpfzMqYkY; Tue, 24 Mar
        2020 19:28:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.DD.04778.75F5A7E5; Wed, 25 Mar 2020 04:28:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200324192822epcas5p2986c35616c596051bb7826457439c893~-VCLYfZcL0057600576epcas5p2V;
        Tue, 24 Mar 2020 19:28:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324192822epsmtrp1859f428419eb7969a73eaabb8c79c8db~-VCLXutTp3078230782epsmtrp1K;
        Tue, 24 Mar 2020 19:28:22 +0000 (GMT)
X-AuditID: b6c32a4a-33bff700000012aa-bc-5e7a5f5752f8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.2A.04158.65F5A7E5; Wed, 25 Mar 2020 04:28:22 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192821epsmtip154351565a46babb88b6385c5511b4ab6~-VCKwpm3I0279802798epsmtip1Q;
        Tue, 24 Mar 2020 19:28:21 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Handle invalid public keys
Date:   Wed, 25 Mar 2020 00:57:18 +0530
Message-Id: <1585078044-14974-4-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7bCmhm54fFWcwdY1UhZzrvUxW/xfeovd
        YtK+DywOzB59W1YxenzeJBfAFJVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhUoFec
        mFtcmpeul5yfa2VoYGBkClSZkJOxc+Mc9oJH4hXrzk1jamB8KdzFyMkhIWAi8XvdQ6YuRi4O
        IYHdjBKTtm9ng3A+MUpcmvOXHcL5xihx5NAVNpiWbyfPsUIk9jJKXLjYzQjhdDBJbHu/kR2k
        ik3AWOL8zVdMILaIgLLEs32HwWxmAXuJIz++s4DYwgKmEhNv3wSrZxFQlXh04x3YBl4BD4lv
        5zuZILbJSdw818kMYnMKeEqsvXIMbJmEwEtWiY758xkhilwk5s66xgphC0u8Or6FHcKWknjZ
        3wZldzNK7H7jCtE8hVHi3guQiziAHHuJCS/4QUxmAU2J9bv0Ie7kk+j9/QSqgleio00IYoqC
        xKqpE6FOE5NYN/0L1HQPiTeH1kEDZQ6jxPNrM1gmMMrOQpi6gJFxFaNkakFxbnpqsWmBUV5q
        OXJMbWIEJx4trx2My875HGIU4GBU4uHVeFgZJ8SaWFZcmXuIUYKDWUmEd3NqRZwQb0piZVVq
        UX58UWlOavEhRlNgAE5klhJNzgcmxbySeENTIzMzA0sDU2MLM0Mlcd5JrFdjhATSE0tSs1NT
        C1KLYPqYODilGhgF2L2jwtoPHnnMdmfFVrdz+syyFj9Ms5YbtO3m+Ph44tqmD3/vGDxfwB2y
        l3HeN4+08zr8fIn8M144rxVKOaqVZc4sWC9vFzWx85TAG+O9EidOWU2UP331gL/BrSYrO/94
        oRWadwQXfl8eNj1uiuKkay010Y+mdPeZODMpbYpfa3xezH+FU5QSS3FGoqEWc1FxIgB7wZJb
        UgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42LZdlhJTjcsvirOoHuhhMWca33MFv+X3mK3
        mLTvA4sDs0ffllWMHp83yQUwRXHZpKTmZJalFunbJXBl7Nw4h73gkXjFunPTmBoYXwp3MXJy
        SAiYSHw7eY61i5GLQ0hgN6PEwad72SASYhJvVpxgh7CFJVb+e84OUdTGJNGw4B5YEZuAscT5
        m6+YQGwRAWWJZ/sOg9nMAo4Sn67MA6sRFjCVmHj7JtggFgFViUc33oHFeQU8JL6d72SCWCAn
        cfNcJzOIzSngKbH2yjFGEFsIqOZP50y2CYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al
        6yXn525iBAeMltYOxhMn4g8xCnAwKvHwajysjBNiTSwrrsw9xCjBwawkwrs5tSJOiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA6PwdhHrXbXnnSrjt38q
        uOj8ZKHdg/dHFP57pyo3rzPe+XqboRm3XoxBh+q+SbLrsvl3rXxqM/PH6s0TH2kZrmyYHpDH
        t0tB8Xj6m369ewZr9AU2fCzpz2Xxs2qwdH8rEJFjqbOHWSuW8Zexu83tPT0fp5ecfp16T+ba
        AY9r78Lu9B1WZfCL+arEUpyRaKjFXFScCAALGdWoFAIAAA==
X-CMS-MailID: 20200324192822epcas5p2986c35616c596051bb7826457439c893
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192822epcas5p2986c35616c596051bb7826457439c893
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20200324192822epcas5p2986c35616c596051bb7826457439c893@epcas5p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Check for invalid public keys received and send provision failed.
---
 mesh/prov-acceptor.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 03972c227..d395bc5f2 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -180,7 +180,7 @@ static void swap_u256_bytes(uint8_t *u256)
 	}
 }
 
-static void prov_calc_secret(const uint8_t *pub, const uint8_t *priv,
+static bool prov_calc_secret(const uint8_t *pub, const uint8_t *priv,
 							uint8_t *secret)
 {
 	uint8_t tmp[64];
@@ -190,22 +190,27 @@ static void prov_calc_secret(const uint8_t *pub, const uint8_t *priv,
 	swap_u256_bytes(tmp);
 	swap_u256_bytes(tmp + 32);
 
-	ecdh_shared_secret(tmp, priv, secret);
+	if (!ecdh_shared_secret(tmp, priv, secret))
+		return false;
 
 	/* Convert to Mesh byte order */
 	swap_u256_bytes(secret);
+	return true;
 }
 
-static void acp_credentials(struct mesh_prov_acceptor *prov)
+static bool acp_credentials(struct mesh_prov_acceptor *prov)
 {
-	prov_calc_secret(prov->conf_inputs.prv_pub_key,
-			prov->private_key, prov->secret);
+	if (!prov_calc_secret(prov->conf_inputs.prv_pub_key,
+			prov->private_key, prov->secret))
+		return false;
 
-	mesh_crypto_s1(&prov->conf_inputs,
-			sizeof(prov->conf_inputs), prov->salt);
+	if (!mesh_crypto_s1(&prov->conf_inputs,
+			sizeof(prov->conf_inputs), prov->salt))
+		return false;
 
-	mesh_crypto_prov_conf_key(prov->secret, prov->salt,
-			prov->calc_key);
+	if (!mesh_crypto_prov_conf_key(prov->secret, prov->salt,
+			prov->calc_key))
+		return false;
 
 	l_getrandom(prov->rand_auth_workspace, 16);
 
@@ -218,6 +223,7 @@ static void acp_credentials(struct mesh_prov_acceptor *prov)
 	print_packet("LocalRandom", prov->rand_auth_workspace, 16);
 	print_packet("ConfirmationSalt", prov->salt, 16);
 	print_packet("ConfirmationKey", prov->calc_key, 16);
+	return true;
 }
 
 static uint32_t digit_mod(uint8_t power)
@@ -298,8 +304,13 @@ static void priv_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 	swap_u256_bytes(prov->conf_inputs.dev_pub_key + 32);
 
 	prov->material |= MAT_LOCAL_PRIVATE;
-	if ((prov->material & MAT_SECRET) == MAT_SECRET)
-		acp_credentials(prov);
+	if ((prov->material & MAT_SECRET) == MAT_SECRET) {
+		if (!acp_credentials(prov)) {
+			msg.opcode = PROV_FAILED;
+			msg.reason = PROV_ERR_UNEXPECTED_ERR;
+			prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+		}
+	}
 }
 
 static void send_caps(struct mesh_prov_acceptor *prov)
@@ -423,7 +434,10 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		if ((prov->material & MAT_SECRET) != MAT_SECRET)
 			return;
 
-		acp_credentials(prov);
+		if (!acp_credentials(prov)) {
+			fail.reason = PROV_ERR_UNEXPECTED_ERR;
+			goto failure;
+		}
 
 		if (!prov->conf_inputs.start.pub_key)
 			send_pub_key(prov);
-- 
2.17.1


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28600C678D4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 01:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCCB1x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCCB1v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 20:27:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641FD55519
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 17:27:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p6so1246094plf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 17:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQ7sv22ULGj99ITd+yshAiGuwxfr6k3MEwP/5i6IzAg=;
        b=UUaKEqqrdxEOJ94SpeKpKaVyLfCDVr+JD4k0EyyDWUqUsXUjJewcgqV2Re7E2XtM4u
         honblxMaVro01VQSJuHlUxG0Z3kPbruLuKURy4jVXWWLyYvr96k8NZgLIlOrNeyuSG0m
         ojGc4HC4v7IugnUPP85b4zjyRjsYhuUc0IsIXxBk2nqxvLTmQwqIVe+psjs4tjW3do3O
         VUTuDs+EcLcrSNjC3vtlGNxR3LZ5iHqWU+5iGl/uFu3gEo9ZKBQopSVuLalTuY+gFkbq
         ly87ahQQ4//oCT0fDE+cwNyKdSRclswm40D4jJTLSqICO9eZJKorU/b9c6jJZ65Uujut
         H2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ7sv22ULGj99ITd+yshAiGuwxfr6k3MEwP/5i6IzAg=;
        b=Rmnovkwy8/z6Ai0USh6eyQFPmHdy7OE7TDSNLwQOpEwg4VPEfSq8WuNN4knx4rjqlP
         XOOoij5tnDkB1x/nR+Y9/Ykzoi8+hSwayNP+rqD5EcKmlVoVzc7kNq5yDPO+s0QbSuPD
         okNy2QcDtn8haFjwAyTL7+r4DkAeJKE3HsgeBlSZWDDkVLYQVXnIlKv5XJCtRD0HJVg4
         VXHBcpKkOilg70j3YV6fmJ+uNyZAWk0K5On2oEK0Ta7avwoa6uGu5wIlxt8POZEhe414
         sExs+0dci3qNP200xyPncuYovrAFcyHnBQnIN49vfMtQay6Jf4oV87IuBi6Jyl9DoybF
         sOCg==
X-Gm-Message-State: AO0yUKV36xcWCpMCagq/eglmM9GVs5HROhv/8k3/GrHBva9YJXrXkoD0
        EMXbfOXTcBzVc/kcH0kLYgWah7bK6c4=
X-Google-Smtp-Source: AK7set+znY+NcyO2wqa2XqJ/UbDXPBrNskbsR/Pb69eAYoFaL2QXYr6btIAMZbrINj6yr/W6U6uZbA==
X-Received: by 2002:a17:902:ea02:b0:19d:2a3:f017 with SMTP id s2-20020a170902ea0200b0019d02a3f017mr189772plg.62.1677806868320;
        Thu, 02 Mar 2023 17:27:48 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019a6d3851afsm284622plb.141.2023.03.02.17.27.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:27:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 5/9] core: Check if device has RSI
Date:   Thu,  2 Mar 2023 17:27:38 -0800
Message-Id: <20230303012742.1386291-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303012742.1386291-1-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if device is advertising an RSI and if so disregards if it
is not discoverable since other members can be.
---
 src/adapter.c | 4 ++--
 src/eir.c     | 3 +++
 src/eir.h     | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ae0eb364bad5..7947160a6c5c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7122,7 +7122,7 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 
 	dev = btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
 	if (!dev) {
-		if (!discoverable && !monitoring) {
+		if (!discoverable && !monitoring && !eir_data.rsi) {
 			eir_data_free(&eir_data);
 			return;
 		}
@@ -7169,7 +7169,7 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 	/* If there is no matched Adv monitors, don't continue if not
 	 * discoverable or if active discovery filter don't match.
 	 */
-	if (!monitoring && (!discoverable ||
+	if (!eir_data.rsi && !monitoring && (!discoverable ||
 		(adapter->filtered_discovery && !is_filter_match(
 				adapter->discovery_list, &eir_data, rssi)))) {
 		eir_data_free(&eir_data);
diff --git a/src/eir.c b/src/eir.c
index 2f9ee036ffd5..52152c0d7f52 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -236,6 +236,9 @@ static void eir_parse_data(struct eir_data *eir, uint8_t type,
 	memcpy(ad->data, data, len);
 
 	eir->data_list = g_slist_append(eir->data_list, ad);
+
+	if (type == EIR_CSIP_RSI)
+		eir->rsi = true;
 }
 
 void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
diff --git a/src/eir.h b/src/eir.h
index 6154e23ec266..a4bf5fbd33f3 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -37,6 +37,7 @@
 #define EIR_SVC_DATA32              0x20  /* LE: Service data, 32-bit UUID */
 #define EIR_SVC_DATA128             0x21  /* LE: Service data, 128-bit UUID */
 #define EIR_TRANSPORT_DISCOVERY     0x26  /* Transport Discovery Service */
+#define EIR_CSIP_RSI                0x2e  /* Resolvable Set Identifier */
 #define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
 
 /* Flags Descriptions */
@@ -76,6 +77,7 @@ struct eir_data {
 	uint32_t class;
 	uint16_t appearance;
 	bool name_complete;
+	bool rsi;
 	int8_t tx_power;
 	uint8_t *hash;
 	uint8_t *randomizer;
-- 
2.39.2


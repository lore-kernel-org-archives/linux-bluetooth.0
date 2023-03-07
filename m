Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F58C6FA99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCGWZk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCGWZW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1AAF74A
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:24:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id i10so15734075plr.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQ7sv22ULGj99ITd+yshAiGuwxfr6k3MEwP/5i6IzAg=;
        b=kQrLZ/lQp9Md+q0W9iS3hfKu6Q4lA2g4cGWrlOda9Y73iKAfND6yPtQst1dQU8BKYQ
         os4vREv70Sg3cqsdoCivGb/INR7Ux0kziyUh+v5OdjPFq3ZLEcwwSpEh0Zpi/djSUeiq
         894yEjbMUpaqIDeDeTFcQ4ksZ6UI7fci+xm1Bh2g2yeXhBFQtAjmxcOtsM66BU65m2M7
         R8g4w9E/u568Zb668oHI9jFlpf9OndFoplJNA4XSYMK2HH12lmz8L/EZtYD8jscx/27G
         ZJZM5AFkBY7syDcXnVZ74Y3/PFj/V4PKi5klcke2AhjWFTqPbfhxc9fGep/JJ0BvVOVV
         aPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ7sv22ULGj99ITd+yshAiGuwxfr6k3MEwP/5i6IzAg=;
        b=r8voeF1frogeMM2JuqqtDuavhwULA0UxcsK+er5SHkJKZE4qGduPQ7eaT+OEVw5u3k
         N9JFH9XV4RkAG8yeb48rolHNLJdKGE0GHivZWE9jwtzD/QyZsmsKoavcutNaRmkLim5l
         /oVGhSghZRyd3AlINFLaiLfYxGWt9BmJWqgq9NRQsDkQ414DcItn8hmpl+k3ZBOyWJLY
         1HCg5BqyzYZJAbvXN/xmYhEEekyiwqDgiiQCQejW+5Ndc4ZtTCmdTm9YqVbsrdtIhGeo
         WksgcOmYkchUD2ue8KpZDqKeuXj49W5sNBcfJZwITvWY/YY/IAvgC+029NX00bIFlkrm
         4FJA==
X-Gm-Message-State: AO0yUKXzVqkrxpjrxGFMyD2jV7CaHcJwotBHb7A0gkSrGjiLXzsECIxj
        7XhFmtZmOf56mzbCik9HEGoyJrHA0g8=
X-Google-Smtp-Source: AK7set92i1SkvM35OSRTEE5k0T9e+j52ROfTY0BGdznq+IqEenCjmSNdBIMQ9Qv8nCsgkMpS5qYfWQ==
X-Received: by 2002:a17:902:ebc4:b0:19d:461:9628 with SMTP id p4-20020a170902ebc400b0019d04619628mr18142252plg.34.1678227871131;
        Tue, 07 Mar 2023 14:24:31 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 06/12] core: Check if device has RSI
Date:   Tue,  7 Mar 2023 14:24:16 -0800
Message-Id: <20230307222422.2608483-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
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


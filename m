Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B26C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 18:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiFNS7x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358646AbiFNS6x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 14:58:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B84F9C2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 11:51:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so1788075pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Q1N78wXK6VeQvuFqHV04oSLduDhagxgaApeNLrNFM8=;
        b=ZtXgYY2qcByC0Nv7Ctm+QXlMFWiI27Q8IoBVpeHUGNGRFT0nipzSZOfcKpEsfAEDvI
         tZiA8SYOwaVjE7IjuX1gQ+KOSakHk3JDCS0zc4u6y65U+ISsPkraYl1i1B50NClvMQoQ
         wY6857V9FRwVOvIoooYCd3W1LYL8VDWbnqbkf64PtFQR7Fiz1uOs0+EPeZGdnodV6RWo
         4HTeDGEhdgYuoqqakONnBNz9fnF1SiGrVRjw6Clo/TeVwmQ3MnL/qcHkfQqrlpviMMq1
         vgSth8P2KEL2SY0qUmLItq9nzSy1ihaOSSVwGYKZMp1RXDpJuoZAh4wdbuerbNsQnFGK
         KRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Q1N78wXK6VeQvuFqHV04oSLduDhagxgaApeNLrNFM8=;
        b=xL4brjOFWwaIhRtkoUiCYgRkqXRb3cYiA3fW4dAOnFASb1SvZ+/Y15ziQjqYQ1HG0u
         FOReSS8t0aa/KOJu5W0yb4GF59ZVKdD9b2PXBlk3gFK06rcaB113I60vKhYSjYyTKHZi
         +FXp9P2P1khiy4dc4nskJ53L3YNNlejlePq1dTJ6FPKPh8mjGxN7Hut7PyuM2PfhcLqN
         IB7KhmU8HvRKD5pa7O4WqId8VV2LD7tgydTAk8cqSRfu1Lr1PmZ/FDqYmrOm17LDjoe+
         QffML7DOOmtb3tTmvcK9C65PsxnxVTd3L2ZSFt7UvNcrIDW/rKLp9Ti2Q3tDIKWGJY6m
         rjhA==
X-Gm-Message-State: AJIora/Tb3YYeH6uVfSWQNupruFMvV1zr0vbjeA+hSHr0lwSHERv3lyh
        tvMtTVK6SgD//Mg8bIyByNG0JCFPO4w=
X-Google-Smtp-Source: AGRyM1tNybYRJdqxjM4GfJOAk9VxjyMmbotVgBSE9Bc6d+MKefBGXZZ5GYmF3esx6IKl7eyu6C5rUQ==
X-Received: by 2002:a17:903:494:b0:168:bac4:bb3 with SMTP id jj20-20020a170903049400b00168bac40bb3mr5597583plb.44.1655232702456;
        Tue, 14 Jun 2022 11:51:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w62-20020a628241000000b0051bfd13809fsm8001682pfd.119.2022.06.14.11.51.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:51:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] advertising: Fix attempting to set scan_rsp
Date:   Tue, 14 Jun 2022 11:51:40 -0700
Message-Id: <20220614185140.535390-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2450

  • If extended advertising PDU types are being used (bit 4 = 0) then:
  The advertisement shall not be both connectable and scannable.

So instead this attempts to set name as part of Advertising Data rather
then setting it as Scan Response:

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x01
        Properties: 0x0001
          Connectable
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Public (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: Host has no preference (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 2M (0x02)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 5
      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
        Status: Success (0x00)
        TX power (selected): 7 dbm (0x07)
< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 4
        Handle: 0x01
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x00
@ MGMT Event: Command Complete (0x0001) plen 7
      Add Extended Advertising Parameters (0x0054) plen 4
        Status: Success (0x00)
        Instance: 1
        TX power: 7 dbm (0x07)
        Available adv data len: 31
        Available scan rsp data len: 31
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Advertising Data (0x08|0x0037) ncmd 1
        Status: Success (0x00)
@ MGMT Command: Add Extended Advertising Data (0x0055) plen 23
        Instance: 1
        Advertising data length: 12
        Name (complete): Intel-3
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Scan response length: 0
< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 16
        Handle: 0x01
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x0c
        Name (complete): Intel-3
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Advertising Data (0x08|0x0037) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 4
        Handle: 0x01
        Operation: Complete scan response data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x00
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6
        Extended advertising: Enabled (0x01)
        Number of sets: 1 (0x01)
        Entry 0
          Handle: 0x01
          Duration: 0 ms (0x00)
          Max ext adv events: 0
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4
      Add Extended Advertising Data (0x0055) plen 1
        Status: Success (0x00)
        Instance: 1
---
 lib/mgmt.h        |  3 +++
 src/advertising.c | 35 +++++++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 922a24367..430bd0ef6 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -511,6 +511,9 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_PARAM_TX_POWER		(1 << 15)
 #define MGMT_ADV_PARAM_SCAN_RSP		(1 << 16)
 
+#define MGMT_ADV_FLAG_SEC_MASK	(MGMT_ADV_FLAG_SEC_1M | MGMT_ADV_FLAG_SEC_2M | \
+				 MGMT_ADV_FLAG_SEC_CODED)
+
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
 	uint8_t instance;
diff --git a/src/advertising.c b/src/advertising.c
index ca23774ba..fea6ac00b 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -776,6 +776,18 @@ static uint8_t *generate_adv_data(struct btd_adv_client *client,
 		bt_ad_add_appearance(client->data, appearance);
 	}
 
+	/* Scan response shall not be used when connectable and setting a
+	 * secondary PHY since that would end up using EA types instead of
+	 * legacy which doesn't support being connectable and scannable
+	 * simultaneously.
+	 */
+	if ((*flags & MGMT_ADV_FLAG_CONNECTABLE) &&
+				(*flags & MGMT_ADV_FLAG_SEC_MASK) &&
+				client->name) {
+		*flags &= ~MGMT_ADV_FLAG_LOCAL_NAME;
+		bt_ad_add_name(client->data, client->name);
+	}
+
 	return bt_ad_generate(client->data, len);
 }
 
@@ -807,6 +819,15 @@ static bool adv_client_has_scan_response(struct btd_adv_client *client,
 		return false;
 	}
 
+	/* Scan response shall not be used when connectable and setting a
+	 * secondary PHY since that would end up using EA types instead of
+	 * legacy which doesn't support being connectable and scannable
+	 * simultaneously.
+	 */
+	if (flags & MGMT_ADV_FLAG_CONNECTABLE &&
+				flags & MGMT_ADV_FLAG_SEC_MASK)
+		return false;
+
 	return true;
 }
 
@@ -1250,7 +1271,7 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 	uint8_t *adv_data = NULL;
 	size_t adv_data_len;
 	uint8_t *scan_rsp = NULL;
-	size_t scan_rsp_len = -1;
+	size_t scan_rsp_len = 0;
 	uint32_t flags = 0;
 	unsigned int mgmt_ret;
 	dbus_int16_t tx_power;
@@ -1281,11 +1302,13 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 		goto fail;
 	}
 
-	scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
-	if ((!scan_rsp && scan_rsp_len) ||
-			scan_rsp_len > rp->max_scan_rsp_len) {
-		error("Scan data couldn't be generated.");
-		goto fail;
+	if (adv_client_has_scan_response(client, flags)) {
+		scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
+		if ((!scan_rsp && scan_rsp_len) ||
+				scan_rsp_len > rp->max_scan_rsp_len) {
+			error("Scan data couldn't be generated.");
+			goto fail;
+		}
 	}
 
 	param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len +
-- 
2.35.3


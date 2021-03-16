Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A00C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3617E64F41
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhCPWul (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 18:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhCPWuK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 18:50:10 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3408C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:50:09 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t18so26354453qva.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=efLCMjkKf1ryDZhayJKHJtwrDG6048kUA5gI8JizjBY=;
        b=EuEY5OYJs/FJ7PNFoAWmkjeKSbT4GrNO1Sl3W4A5U+EgAYavBPiUbmAmeqTIXLiUHs
         5d/7kwCctt+mb0MjSx/M+RxodeXT1Ru2dbixgBwHxkkkJ8oMCqEIpUOnih/An/wjvbCs
         Jjcj2V6ptvqZN1g51A2FWbcJE7J/FCd45S9NZAowf9onOiqmxKRSdz0TwvRAslzxRu08
         h3LcUKt7N4LqC9/7iGfXN8bnU8TtJouvgwysA45B0Na9TbAcz3GxnY9wAXA7ItkKnWxu
         ZxHVKvydfBoPY5OqqZrc/0CGNeMjvAgBXASdnCR2jnd4oNAR1aNWGmljjTzNfTSJDpKQ
         g1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=efLCMjkKf1ryDZhayJKHJtwrDG6048kUA5gI8JizjBY=;
        b=bvRhW0GvhuFU1DjKSsGiC7aXXA81FjHJ4MdcFsQKml5ChGgrIVidnSCcDHKkD8MFhd
         pTdEnXbn3TLzyz3oUXIscregENhWT6vBXFmjOLtK4NMNt3Z+ymNS8fc8IfmQTWolMfY8
         VliTRsiyivJzwire6WjszqG5irt5lsPKRbVbHnerXcbjcngltAT7dw0/2xUvKqHDKmrN
         uRmsAswEoWWMFcVQH5U4TwGr1PdJCjto5bmkKOhuMJZE31W/Lmz3dnl3aDVOswkkUtZA
         v8ZoLget3KOGZ+wzQ54oKR6Z4QPsk0iayjeNR61lEhts+tEjHVoCJqe22d2JKnC87RXa
         F73A==
X-Gm-Message-State: AOAM532jvNALoBzrn0Z0+btveSDbUFuPd6Q5UcPDzHcFhck8LcAspRmo
        A4VgssoNSKIaicPYtFlg/AOZwGRdKGE/PvOx6cT3GCSMIRGEv3OShEACKGHvdBJLttsN55m91C/
        /AvLXHasl7oZcrujynDY/gotBbLrNkQzTXZaVv5e2pQWnI+RaJDkuiP0R4ay3dWBeSw5X6rpqB7
        PxoQclr8aQYwjI084W
X-Google-Smtp-Source: ABdhPJy6G4xCm/m1oOzudLrJ3IPGvPpMVAMx3XrTzNS1s3lgYjzyJ5r8HJN5+8MtrwL1IqcWFWubpS/ft+3T9VxbxF4Y
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:8543:90a8:2e5c:1402])
 (user=danielwinkler job=sendgmr) by 2002:ad4:472d:: with SMTP id
 l13mr1937168qvz.17.1615935008858; Tue, 16 Mar 2021 15:50:08 -0700 (PDT)
Date:   Tue, 16 Mar 2021 15:49:56 -0700
In-Reply-To: <20210316224957.3294962-1-danielwinkler@google.com>
Message-Id: <20210316154901.Bluez.v3.1.I45b896f4512038309cbeab7a01f51e503141edab@changeid>
Mime-Version: 1.0
References: <20210316224957.3294962-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH v3 1/2] advertising: Create and use scannable adv param flag
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In order for the advertising parameters hci request to indicate that an
advertising set uses a scannable PDU, we pass a scannable flag along
with the initial parameters MGMT request. This flag is populated based
on the existence of any scan response data requested by the client.

Without this patch, a broadcast advertisement with a scan response will
either be rejected by the controller, or will ignore the requested scan
response. The patch is tested by performing the above and confirming
that the scan response is retrievable from a peer as expected.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

Changes in v3:
    - Use helpers to determine scannable rather than generating earlier

Changes in v2:
    - Check kernel supports flag before setting it

 lib/mgmt.h        |  1 +
 src/advertising.c | 24 +++++++++++++++++++++++-
 src/shared/ad.c   | 17 +++++++++++++++++
 src/shared/ad.h   |  2 ++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 76a03c9c2..7b1b9ab54 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -507,6 +507,7 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_PARAM_TIMEOUT		(1 << 13)
 #define MGMT_ADV_PARAM_INTERVALS	(1 << 14)
 #define MGMT_ADV_PARAM_TX_POWER		(1 << 15)
+#define MGMT_ADV_PARAM_SCAN_RSP		(1 << 16)
 
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
diff --git a/src/advertising.c b/src/advertising.c
index d76e97a74..4ea0e60ee 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -793,6 +793,22 @@ static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
 	return bt_ad_generate(client->scan, len);
 }
 
+static bool adv_client_has_scan_response(struct btd_adv_client *client,
+						uint32_t flags)
+{
+	/* The local name isn't added into the bt_ad structure until
+	 * generate_scan_rsp is called, so we must check these conditions as
+	 * well.
+	 */
+	if (!(flags & MGMT_ADV_FLAG_LOCAL_NAME) &&
+			!client->name &&
+			bt_ad_is_empty(client->scan)) {
+		return false;
+	}
+
+	return true;
+}
+
 static int get_adv_flags(struct btd_adv_client *client)
 {
 	uint32_t flags = 0;
@@ -917,7 +933,13 @@ static int refresh_extended_adv(struct btd_adv_client *client,
 		flags |= MGMT_ADV_PARAM_TX_POWER;
 	}
 
-	cp.flags = htobl(flags);
+	/* Indicate that this instance will be configured as scannable */
+	if (adv_client_has_scan_response(client, flags) &&
+		client->manager->supported_flags & MGMT_ADV_PARAM_SCAN_RSP) {
+		flags |= MGMT_ADV_PARAM_SCAN_RSP;
+	}
+
+	cp.flags = cpu_to_le32(flags);
 
 	mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS,
 			client->manager->mgmt_index, sizeof(cp), &cp,
diff --git a/src/shared/ad.c b/src/shared/ad.c
index 23c8c34f4..d40d15331 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -552,6 +552,23 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 	return adv_data;
 }
 
+bool bt_ad_is_empty(struct bt_ad *ad)
+{
+	/* If any of the bt_ad fields are non-empty or don't have the default
+	 * value, then bt_ad_generate will return a non-empty buffer
+	 */
+	if (!ad->name &&
+		ad->appearance == UINT16_MAX &&
+		queue_isempty(ad->service_uuids) &&
+		queue_isempty(ad->manufacturer_data) &&
+		queue_isempty(ad->solicit_uuids) &&
+		queue_isempty(ad->service_data) &&
+		queue_isempty(ad->data)) {
+		return true;
+	}
+	return false;
+}
+
 static bool queue_add_uuid(struct queue *queue, const bt_uuid_t *uuid)
 {
 	bt_uuid_t *new_uuid;
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 13adcb406..84ef9dee9 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -105,6 +105,8 @@ void bt_ad_unref(struct bt_ad *ad);
 
 uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length);
 
+bool bt_ad_is_empty(struct bt_ad *ad);
+
 bool bt_ad_add_service_uuid(struct bt_ad *ad, const bt_uuid_t *uuid);
 
 bool bt_ad_remove_service_uuid(struct bt_ad *ad, bt_uuid_t *uuid);
-- 
2.31.0.rc2.261.g7f71774620-goog


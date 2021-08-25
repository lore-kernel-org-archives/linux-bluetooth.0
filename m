Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F606C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B88960FE7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 16:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhHYQws (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:52:48 -0400
Received: from vern.gendns.com ([98.142.107.122]:36504 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhHYQwr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 12:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Okqha9zGYw7gOum05FTweoMx0bZinn0Ns29etpuXzUI=; b=zIw/i2GdRi12fDTZYRo0gf/53x
        CkkWUV1EFwOOa/6A0cWrGByoV3jQ332xPwkQfWcp0+WJ/d7vVfqss6AHh2rwoJW9BOg0vMLisOnpT
        YUFQbvMvblCqZSEbpzph7iolGwXHzaPwwwgv8XHXvcyLA7O9Ajvk7Rbm8wnfscKvOoQRayDWZybGw
        GgbK0XHS5vWteh7VqsF1NfosAXQB9OAQAIzNcr/T4yO4jMzI5Bbh9nKBLAuRHxJDaqlvfvsBxA0Lm
        9mvgb+/fnonhmsKejLX/ZApvru2KAl7hr71dJTxMXggfAGXydwU/besg7Qf+ZUF23/PMNcDnegUJ5
        fnh3G7wg==;
Received: from [2600:1700:4830:1658::fb2] (port=60238 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mIw7y-0006LP-Gd; Wed, 25 Aug 2021 12:51:58 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>
Subject: [PATCH BlueZ v2 1/2] device: clear eir_uuids list on disconnect
Date:   Wed, 25 Aug 2021 11:51:24 -0500
Message-Id: <20210825165125.2675544-2-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825165125.2675544-1-david@lechnology.com>
References: <20210825165125.2675544-1-david@lechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The eir_uuids list contains GATT service UUIDs from advertising data.
The device may advertise different UUIDs each time it is scanned and
connected, so the list needs to be cleared when the device disconnects.

This partially fixes an issue where the UUIDs D-Bus property is empty
after scanning, connecting, disconnecting and scanning again when
[GATT] Cache = yes is set in main.conf.

Issue: https://github.com/bluez/bluez/issues/192
Signed-off-by: David Lechner <david@lechnology.com>
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 807106812..53ef3e9a1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3129,6 +3129,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 
 	device_update_last_seen(device, bdaddr_type);
 
+	g_slist_free_full(device->eir_uuids, g_free);
+	device->eir_uuids = NULL;
+
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
 
-- 
2.25.1


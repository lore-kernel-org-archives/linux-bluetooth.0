Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F3CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D8E61374
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 18:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhHXS6c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:58:32 -0400
Received: from vern.gendns.com ([98.142.107.122]:41640 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233900AbhHXS6b (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Aug 2021 14:58:31 -0400
X-Greylist: delayed 1681 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 14:58:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e6ufJBSn3puSdYEoIT/EdR1q9QdphIDzoeBgZI/x6I0=; b=pvPw8kUeWOvfPwikSCpq/x8BEa
        E1jg3dUsytQnHj6TyUSFJEanuTNCrmxqwOqWR+nOENIbPCP6qd3+ZpLMBKhNJ4l2vRx6M3YwqmiPA
        G/+M2RNekZnH4MNSZzOYjuW07sqNMhsxZE0XeE3jFGJc6Fq5E1M48P954pOp31uVQtLScce1Gncwz
        39yrMvpodw//lph2IDBNXkha0RjzgJZY37bZxOJd84pacMWF2XdZTi9SNT6AiVVvazn7q+PVzUKvL
        ULKiMKtqCnxDtVEOipfCroRs5Cb3YH/gss5gkws3S6Yk1SEtjugoWq0udCyTEAiaU19hAES9N7V3d
        o+LUeqIw==;
Received: from [2600:1700:4830:1658::fb2] (port=59938 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mIbB4-0004ZD-Lt; Tue, 24 Aug 2021 14:29:44 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>
Subject: [PATCH BlueZ] device: fix advertising data UUIDs ignored when Cache = yes
Date:   Tue, 24 Aug 2021 13:29:16 -0500
Message-Id: <20210824182916.2569317-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
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

When [GATT] Cache = yes is set in configuration BlueZ does not use
cached UUIDs for the list of service UUIDs. However, it doesn't clear
the in-memory list of UUIDs received from advertising data, so when
a device is scanned, connected and disconnected, the internal state
still reflects that the UUIDs from the advertising data have already
been handled. device_add_eir_uuids() ignored the UUIDs from the
advertising data because both dev->le_state.svc_resolved == true and
dev->eir_uuids still contains the UUIDs from the previous scan session.

This fixes the issue by resetting both le_state.svc_resolved and
eir_uuids when the device is disconnected.

Issue: https://github.com/bluez/bluez/issues/192
Signed-off-by: David Lechner <david@lechnology.com>
---
 src/device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index 807106812..48b9bd8d6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3129,6 +3129,12 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 
 	device_update_last_seen(device, bdaddr_type);
 
+	if (!gatt_cache_is_enabled(device)) {
+		device->le_state.svc_resolved = false;
+		g_slist_free_full(device->eir_uuids, g_free);
+		device->eir_uuids = NULL;
+	}
+
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
 
-- 
2.25.1


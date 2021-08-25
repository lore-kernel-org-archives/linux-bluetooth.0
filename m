Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9247AC4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB4961058
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 16:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhHYQws (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:52:48 -0400
Received: from vern.gendns.com ([98.142.107.122]:36506 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhHYQwr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 12:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i2sewKx1DejS4NgnSR4JcbA3dG8ziSGJVQAwDkdnnQc=; b=CTE1HsPt53sZZUAtSrKLLre+Ia
        diXyjU/1GJe6fpH1AX4EeQWiTGIpYtELuR36q6p+yHrv7eDIvU0HA3RPqw2kfZUYnpzSKjJNi47RP
        x0/FQZXdJzWnrC5Znw2e8nZLFifMuKvUqDQTbkpZn8L2SHnAuF/pLbhRhVhoouIBuESrpnrgNMgip
        mY6HTw0V61p9NfewDbGJVtBF3d39f0fEct1W9A9+qoF3gBx80LXnDv4IONxFbasNldBKWKBAJzlub
        vnfSuU1Y0zD60MRoIChRiCc4/78ohrZBvIi1HICqf/wcJkocnn2STsgEuTUxPvI6ZfpvQDnNb/QO3
        9MtU4C3g==;
Received: from [2600:1700:4830:1658::fb2] (port=60238 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mIw7z-0006LP-5N; Wed, 25 Aug 2021 12:51:59 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2 2/2] device: set le_state.svc_resolved = false in gatt_cache_cleanup()
Date:   Wed, 25 Aug 2021 11:51:25 -0500
Message-Id: <20210825165125.2675544-3-david@lechnology.com>
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

When the GATT cache is cleared, there is no longer a list of GATT
services, so we need to set le_state.svc_resolved = false so that
the next time the device connects, it will enumerate the services
again.

This partially fixes an issue where the UUIDs D-Bus property was empty
after scanning, connecting, disconnecting and scanning again when
[GATT] Cache = yes is set in main.conf.

Issue: https://github.com/bluez/bluez/issues/192
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: David Lechner <david@lechnology.com>
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index 53ef3e9a1..6d534c488 100644
--- a/src/device.c
+++ b/src/device.c
@@ -580,6 +580,7 @@ static void gatt_cache_cleanup(struct btd_device *device)
 
 	bt_gatt_client_cancel_all(device->client);
 	gatt_db_clear(device->db);
+	device->le_state.svc_resolved = false;
 }
 
 static void gatt_client_cleanup(struct btd_device *device)
-- 
2.25.1


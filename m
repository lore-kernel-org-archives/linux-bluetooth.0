Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1253C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729DD610E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 17:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbhHYRag (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:30:36 -0400
Received: from vern.gendns.com ([98.142.107.122]:39500 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242365AbhHYRad (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 13:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9dptu7W/g9bPkr6x5sg00sXal0FdoGMP5EdB1jNJw2U=; b=RHfTlja73D6jvP5LtoOizaHycF
        lhfb0yky9M59BSUgQ5353HJvjNh190tazrp/EtomZEWLSvVGk3fdyWoQ3eTS3d2PlA647lw7NzrQU
        /1I5JX8Z/sMqH+VU9NbjIXfZYoFqZQbWEk9a4UQsHbMUSCHHQ6rivNJLqi1P01xQfIitM6Ea9jr9/
        tLamJPc0F8S+134dV/FmOkjSUA64T0pF0lBN5nz9zQMhIMcGgtyEYYulmjnDDhkQsJYWreR9K0ANj
        tWC0x5dgVvs0p+1Ol6jxpCNWsIfCd5iL+QrJaaAh67FX9sI6fW9Yy9VKYwwkwP0tLLm6DMkZQNnfs
        2Hg/7NRQ==;
Received: from [2600:1700:4830:1658::fb2] (port=33116 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mIwiX-0004gs-AM; Wed, 25 Aug 2021 13:29:45 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>
Subject: [PATCH BlueZ] device: delete cache file when device is removed
Date:   Wed, 25 Aug 2021 12:29:36 -0500
Message-Id: <20210825172936.2691027-1-david@lechnology.com>
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

When a device is removed from BlueZ, it should be completely forgotten
so that when it is seen again, it behaves exactly the same as if this
was the first time the device was ever seen.

So instead of just deleting one section of the cache file, we delete
the entire file.

This fixes issues with the GATT cache being retained and used for
devices that don't have ServicesChanged or Database Hash characteristics
to indicate that the attributes on the device have changed.

Issue: https://github.com/bluez/bluez/issues/191
Signed-off-by: David Lechner <david@lechnology.com>
---
 src/device.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6d534c488..b51d9df4d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4485,9 +4485,6 @@ static void device_remove_stored(struct btd_device *device)
 {
 	char device_addr[18];
 	char filename[PATH_MAX];
-	GKeyFile *key_file;
-	char *data;
-	gsize length = 0;
 
 	if (device->bredr_state.bonded)
 		device_remove_bonding(device, BDADDR_BREDR);
@@ -4511,19 +4508,7 @@ static void device_remove_stored(struct btd_device *device)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
 				btd_adapter_get_storage_dir(device->adapter),
 				device_addr);
-
-	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
-	g_key_file_remove_group(key_file, "ServiceRecords", NULL);
-
-	data = g_key_file_to_data(key_file, &length, NULL);
-	if (length > 0) {
-		create_file(filename, 0600);
-		g_file_set_contents(filename, data, length, NULL);
-	}
-
-	g_free(data);
-	g_key_file_free(key_file);
+	unlink(filename);
 }
 
 void device_remove(struct btd_device *device, gboolean remove_stored)
-- 
2.25.1


Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949EC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 13:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4AF2084E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 13:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfKLNKo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:10:44 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:11296 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfKLNKn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 08:10:43 -0500
Received: from [10.2.7.65] (81.89.61.168.host.vnet.sk [81.89.61.168])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47C7Qp1kJnz5tlK
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 14:10:42 +0100 (CET)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] core/advertising: Fix crash when client is added
 after unregistration
To:     linux-bluetooth@vger.kernel.org
References: <157250771818414>
 <1572862862-8536-1-git-send-email-simon.mikuda@streamunlimited.com>
Organization: StreamUnlimited
Message-ID: <cf1babd6-9953-7841-d9a4-59565368a896@streamunlimited.com>
Date:   Tue, 12 Nov 2019 14:10:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572862862-8536-1-git-send-email-simon.mikuda@streamunlimited.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After "register_advertisement()" callback "client_proxy_added()" was yet
called but it was actually called after: "unregister_advertisement()" which
caused segmentation fault because client was removed twice.

Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
src/advertising.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index f53c14c..45ff19f 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -190,6 +190,8 @@ static void client_remove(void *data)
struct btd_adv_client *client = data;
struct mgmt_cp_remove_advertising cp;
+ g_dbus_client_set_proxy_handlers(client->client, NULL, NULL, NULL,
+ client);
g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
cp.instance = client->instance;

-- 
2.7.4


Return-Path: <SRS0=cJ+v=UN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9510BC31E4B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736FE2175B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 15:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfFNPbb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:31:31 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46375 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNPbb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jun 2019 11:31:31 -0400
X-Originating-IP: 83.155.44.161
Received: from classic.redhat.com (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BAED7240009;
        Fri, 14 Jun 2019 15:31:26 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] input/hog: Remove HID device after HoG device disconnects
Date:   Fri, 14 Jun 2019 17:31:25 +0200
Message-Id: <20190614153125.2605-1-hadess@hadess.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

When the Bluetooth LE device disconnects, make sure to also destroy the
uHID device so that we don't have a lingering HID device accessible from
user-space.

This also fixes the input subsystem never seeing the device reattaching,
causing settings that should be applied on connection not to be applied.

https://bugzilla.kernel.org/show_bug.cgi?id=202909

Tested-by: Bastien Nocera <hadess@hadess.net>
---
 profiles/input/hog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 23c9c1529..83c017dcb 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -199,6 +199,8 @@ static int hog_disconnect(struct btd_service *service)
 	struct hog_device *dev = btd_service_get_user_data(service);
 
 	bt_hog_detach(dev->hog);
+	bt_hog_unref(dev->hog);
+	dev->hog = NULL;
 
 	btd_service_disconnecting_complete(service, 0);
 
-- 
2.21.0


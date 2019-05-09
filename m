Return-Path: <SRS0=Q31N=TJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D03C04AB3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 12:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5875821479
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 12:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEIMhz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 May 2019 08:37:55 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:46373 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfEIMhx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 May 2019 08:37:53 -0400
Received: from classic.redhat.com (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0E3BC10001C;
        Thu,  9 May 2019 12:37:50 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 7/8] android/hal-bluetooth: Fix unaligned struct access
Date:   Thu,  9 May 2019 14:37:45 +0200
Message-Id: <20190509123746.8396-7-hadess@hadess.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509123746.8396-1-hadess@hadess.net>
References: <20190509123746.8396-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

android/hal-bluetooth.c: In function ‘set_adapter_property’:
android/hal-bluetooth.c:659:46: error: taking address of packed member of ‘struct hal_cmd_set_adapter_prop’ may result in an unaligned pointer value [-Werror=address-of-packed-member]
  659 |  adapter_prop_from_hal(property, &cmd->type, &cmd->len, cmd->val);
      |                                              ^~~~~~~~~
---
 android/hal-bluetooth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index f22801b04..ee3a5e054 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -649,6 +649,7 @@ static int set_adapter_property(const bt_property_t *property)
 {
 	char buf[IPC_MTU];
 	struct hal_cmd_set_adapter_prop *cmd = (void *) buf;
+	uint16_t len_ret;
 	size_t len;
 
 	DBG("prop: %s", btproperty2str(property));
@@ -656,8 +657,9 @@ static int set_adapter_property(const bt_property_t *property)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	adapter_prop_from_hal(property, &cmd->type, &cmd->len, cmd->val);
+	adapter_prop_from_hal(property, &cmd->type, &len_ret, cmd->val);
 
+	cmd->len = len_ret;
 	len = sizeof(*cmd) + cmd->len;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_ADAPTER_PROP,
-- 
2.21.0


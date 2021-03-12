Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383EAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F166365022
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 10:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhCLKwj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:52:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52586 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhCLKwP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Mar 2021 05:52:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 8AC521F46C2A
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapter: Fix discovery trigger for 0 second delay
Date:   Fri, 12 Mar 2021 11:52:06 +0100
Message-Id: <20210312105206.22534-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When calling `StartDiscovery` the effective start can take around 10 ms or
up to 700 ms.
g_timeout_add_seconds() call doesn't ensure the time for the first call of
the timer if the delay is less or equal to 1 second.
---
 src/adapter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index cc0849f99..daa4c18b7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1797,6 +1797,12 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
 	if (!btd_adapter_get_powered(adapter))
 		return;
 
+	if (!delay) {
+		adapter->discovery_idle_timeout = g_idle_add(start_discovery_timeout,
+						adapter);
+		return;
+	}
+
 	adapter->discovery_idle_timeout = g_timeout_add_seconds(delay,
 					start_discovery_timeout, adapter);
 }
-- 
2.18.0


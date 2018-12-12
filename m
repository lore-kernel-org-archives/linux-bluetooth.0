Return-Path: <SRS0=UWae=OV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09F7C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 06:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A1520851
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 06:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A1520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeLLGGm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:06:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbeLLGGm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Dec 2018 01:06:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 980CF7F6BB
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Dec 2018 06:06:42 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-87.bne.redhat.com [10.64.54.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFCC960C44;
        Wed, 12 Dec 2018 06:06:40 +0000 (UTC)
From:   Gopal Tiwari <gtiwari@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     gtiwari@redhat.com
Subject: [PATCH BlueZ] Fixing typo.
Date:   Wed, 12 Dec 2018 11:36:36 +0530
Message-Id: <20181212060636.8569-1-gtiwari@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 12 Dec 2018 06:06:42 +0000 (UTC)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Found in advertise submenu of bluetoothctl help listing.
---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 6e6648cfa..f866aa5f7 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -259,7 +259,7 @@ static const struct bt_shell_menu_entry default_menu[] = {
 	{ "help",         NULL,       cmd_help,
 					"Display help about this program" },
 	{ "export",       NULL,       cmd_export,
-						"Print evironment variables" },
+						"Print environment variables" },
 	{ }
 };
 
-- 
2.17.1


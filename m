Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC105C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 07:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiEaHmS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244563AbiEaHmI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 03:42:08 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C37B1A1A1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 00:42:07 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-vheDCN5XMACcpq9-KRT4Bg-1; Tue, 31 May 2022 03:42:03 -0400
X-MC-Unique: vheDCN5XMACcpq9-KRT4Bg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32F28101A54E;
        Tue, 31 May 2022 07:42:03 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 032ED1410DDB;
        Tue, 31 May 2022 07:42:00 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez V2 12/13] Fixing possible use_after_free in meshctl.c
Date:   Tue, 31 May 2022 13:11:16 +0530
Message-Id: <20220531074117.610321-13-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
References: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

Reported by coverity tool as follows :

bluez-5.64/tools/meshctl.c:1968: freed_arg: "g_free" frees "mesh_dir".

bluez-5.64/tools/meshctl.c:2018: double_free: Calling "g_free" frees 
pointer "mesh_dir" which has already been freed.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 tools/meshctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/meshctl.c b/tools/meshctl.c
index 18e20c40d..38ffd35f3 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -2015,7 +2015,6 @@ int main(int argc, char *argv[])
 
 fail:
 	bt_shell_cleanup();
-	g_free(mesh_dir);
 
 	return EXIT_FAILURE;
 }
-- 
2.26.2


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 08:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiE3INC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiE3INA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 04:13:00 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 217AB37017
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 01:12:58 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-9DxRYK9bOJSSAFICN6qNxA-1; Mon, 30 May 2022 04:12:55 -0400
X-MC-Unique: 9DxRYK9bOJSSAFICN6qNxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7CEB29ABA25;
        Mon, 30 May 2022 08:12:54 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30DE91410F36;
        Mon, 30 May 2022 08:12:51 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez 12/13] Fixing possible use_after_free in meshctl.c
Date:   Mon, 30 May 2022 13:42:08 +0530
Message-Id: <20220530081209.560465-13-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220530081209.560465-1-gopalkrishna.tiwari@gmail.com>
References: <20220530081209.560465-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

Reported by coverity tool as follows :

bluez-5.64/tools/meshctl.c:1968: freed_arg: "g_free" frees "mesh_dir".
bluez-5.64/tools/meshctl.c:2018: double_free: Calling "g_free" frees pointer "mesh_dir" which has already been freed.

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


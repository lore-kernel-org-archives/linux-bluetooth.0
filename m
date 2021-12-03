Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F5C43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 16:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382062AbhLCQMm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:12:42 -0500
Received: from smtp202-pc.aruba.it ([62.149.157.202]:35500 "EHLO
        smtp200-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1382016AbhLCQMl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 11:12:41 -0500
Received: from danbia2MBL ([188.217.48.39])
        by Aruba Outgoing Smtp  with ESMTPSA
        id tB0imxNzZrBxFtB0qmsYLi; Fri, 03 Dec 2021 17:02:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638547336; bh=QQf3mmmEVxULFSu7xO7pOvWLUPxBOy5sWo4RhksAeFM=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=kH/1y2qP22J6XrfSr1nPD/bXzQ0HWmeZqO44N+RtJKD4PJp72TTQe4Ky8MspD+PdF
         hdqVcZDjKHiNtE2YpdBmJOve28sQYIRC1hMqEes+ykf5NbqUXS9Gs+g9iQTAgQ9f0M
         wIxVPO6kB40nHaR89fHuCkkQ5rswwZof+4j4g+av6so7/cVpfIbdSKVQOYNtbWcEqV
         WYSl0uy+pM90OTiHdbcfBT0NbtoeU9l3WPtMtEgIFyjA/oJv+Sd5itQDg4jUOFFWfP
         /gRRlAEoH5+o0I12l/+NO8yHcO2iq3SE/Rvi7IGpVz8AmeOg0CBiTyHiFl2p7+N6hX
         +mWLAgw/YWGfA==
From:   <daniele.biagetti@cblelectronics.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 3/6] tools/mesh-gatt: Fix unwanted return in onoff client model
Date:   Fri, 3 Dec 2021 17:02:15 +0100
Message-ID: <000701d7e85f$23f6c130$6be44390$@cblelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfoXs1TBdJlpgZAQ+uVHl48Q+AG6w==
Content-Language: it
X-CMAE-Envelope: MS4xfOTdNVBBY3FYM0zajEmZBxntIuyi2WEJd+u9piumjIoUedNdIy/Yq9ztZWLSpOg8ifv8Rh6dskOT9F7ZyPUs+cfvqkvP851yJs+1mp4jjD8z5Hatxi9T
 HSLgSyzmgoj38IXO37D/Hbp/78Vnb/6iXnY4TFHnNABxFDRwTRnVW47KpmqeozY22tiv1yvQasAPMyO/jxoy9v9zc9Aw2ygm6xB0drVqoCnv1Ks3i6059ysN
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Replaced the return statement with a warning message in case of
transmission or reception of messages coming from unknown addresses
(such as group addresses)
---
 tools/mesh-gatt/onoff-model.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
index 1c9676e03..9a4ef6d97 100644
--- a/tools/mesh-gatt/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -209,8 +209,9 @@ static void cmd_get_status(int argc, char *argv[])
 
 	node = node_find_by_addr(target);
 
-	if (!node)
-		return;
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in
database\n",target);
+	}
 
 	n = mesh_opcode_set(OP_GENERIC_ONOFF_GET, msg);
 
@@ -237,8 +238,9 @@ static void cmd_set(int argc, char *argv[])
 
 	node = node_find_by_addr(target);
 
-	if (!node)
-		return;
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in
database\n",target);
+	}
 
 	np = read_input_parameters(argc, argv);
 	if ((np != 1) && (np != 2) &&
-- 
2.25.1



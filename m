Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24211C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C56D60F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbhHMMVh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbhHMMVg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:36 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B3C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:09 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f10-20020a0ccc8a0000b02903521ac3b9d7so6898503qvl.15
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TSakmXxYNz60sRpGrBjFC3E27vaNVe7RhhaeT4jEkoc=;
        b=HNwtj4+4syuqQMJXsuEuLkWABTDE2kRfvyRenn0wZft0V5YmuXDuLvm+NdxrT/4M9v
         2iw3Uld6pApONbbv3+gr4OawRsSb00NHG/38dYI1H1HUeL+Dttgd4Ej7pKpcr6pPN2v8
         X3X0EfB1oEnIsL+1kE+Cj9HbvfZi+C8MPc1qbOI/tQogoSd2NSbzB3ClqhUocaFJJ5KZ
         IWhPHcKTSAehLzh4WUJVdip8FxiUU5JEArdLOC/e3ANYlhwfPBbWFbTib1rHCIQvWZF8
         mVS0Q8NC1x1Wj6h1qNF7RMnqmcKQwq2KGH56Di8Pc6s8xjeBFXD+xeDOfswYXMx4B22a
         rq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TSakmXxYNz60sRpGrBjFC3E27vaNVe7RhhaeT4jEkoc=;
        b=AfPIUrV3Ougx3u6R0i2POpnvKVYlqVbmZotSp/KRICSJLlLUdrvtV1mBpEOm2Ykmsw
         CDVLlniqt/nmTOTtrY6oV3pEuaY7hjdb1XBu+PbJkTorp3d2blE7Wmmh1xLxDnTEMMXj
         1Antp5iowOmMP4/wiMm95KyvE+oKQ/Bgujr4lzGBUnNsztCle9Pr1CANqxohno28NBvu
         X/5WH2ZJCotf+O0sJJMoeiRtuBsRyyP/csGw150AGkP51XHhEbduNYxA2/KaD9zOVQ4x
         8aKTKg4dl5qfdvBezt6tOem/SJJyjHZrtpOnMnAmcm0a5EbEwY1VmyX3rHEYLrLuYQFW
         jeLQ==
X-Gm-Message-State: AOAM530+ILZmhbouoMI2f9X6K+r/wryaAAGHOoadDxcaaJ2Bvo1s0Aji
        zHNBHXmhgH/UiRPCobbg80Xfk4+e2zMxjvAWS6G7tHSEVBzj3VndPCACQqD7ls5R8w7TOkC+kk5
        iw7hLwREuFKx8lLrSpRKlsxBa7HlRfZ02rzbwzZ1DFGgWJbZ23NrswD3qYh6r6bGcuYK3dXi/F9
        VN
X-Google-Smtp-Source: ABdhPJwDJprs+CeJS9yvlJWvABe9bFqjh2bM2ddy9cisGj28BFPagoGABaeSwLNMwu0vNzd74WHLiieJje1f
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:19e9:: with SMTP id
 q9mr2256110qvc.28.1628857268363; Fri, 13 Aug 2021 05:21:08 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:10 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.25.I9a93140745548fed5a09fba82cabb27b2a3d4d02@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 25/62] tools/parser/hci: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central", "peripheral", "accept list", and "temporary link key",
are the preferred terms, as reflected in the BT core spec 5.3.
---

 tools/parser/hci.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 02ebcfc442..7b3ffa6cb9 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -45,7 +45,7 @@ static char *event_str[EVENT_NUM + 1] = {
 	"Remote Name Req Complete",
 	"Encrypt Change",
 	"Change Connection Link Key Complete",
-	"Master Link Key Complete",
+	"Temporary Link Key Complete",
 	"Read Remote Supported Features",
 	"Read Remote Ver Info Complete",
 	"QoS Setup Complete",
@@ -150,7 +150,7 @@ static char *cmd_linkctl_str[CMD_LINKCTL_NUM + 1] = {
 	"Unknown",
 	"Change Connection Link Key",
 	"Unknown",
-	"Master Link Key",
+	"Temporary Link Key",
 	"Unknown",
 	"Remote Name Request",
 	"Remote Name Request Cancel",
@@ -383,10 +383,10 @@ static char *cmd_le_str[CMD_LE_NUM + 1] = {
 	"LE Set Scan Enable",
 	"LE Create Connection",
 	"LE Create Connection Cancel",
-	"LE Read White List Size",
-	"LE Clear White List",
-	"LE Add Device To White List",
-	"LE Remove Device From White List",
+	"LE Read Accept List Size",
+	"LE Clear Accept List",
+	"LE Add Device To Accept List",
+	"LE Remove Device From Accept List",
 	"LE Connection Update",
 	"LE Set Host Channel Classification",
 	"LE Read Channel Map",
@@ -568,9 +568,9 @@ static char *role2str(uint8_t role)
 {
 	switch (role) {
 	case 0x00:
-		return "Master";
+		return "Central";
 	case 0x01:
-		return "Slave";
+		return "Peripheral";
 	default:
 		return "Unknown";
 	}
@@ -739,11 +739,11 @@ static char *filterpolicy2str(uint8_t policy)
 	case 0x00:
 		return "Allow scan from any, connection from any";
 	case 0x01:
-		return "Allow scan from white list, connection from any";
+		return "Allow scan from accept list, connection from any";
 	case 0x02:
-		return "Allow scan from any, connection from white list";
+		return "Allow scan from any, connection from accept list";
 	case 0x03:
-		return "Allow scan and connection from white list";
+		return "Allow scan and connection from accept list";
 	default:
 		return "Reserved";
 	}
@@ -1082,7 +1082,7 @@ static inline void remote_name_req_dump(int level, struct frame *frm)
 		clkoffset & 0x7fff, clkoffset & 0x8000 ? " (valid)" : "");
 }
 
-static inline void master_link_key_dump(int level, struct frame *frm)
+static inline void temporary_link_key_dump(int level, struct frame *frm)
 {
 	central_link_key_cp *cp = frm->ptr;
 
@@ -1640,7 +1640,7 @@ static inline void le_set_scan_parameters_dump(int level, struct frame *frm)
 	printf("own address: 0x%02x (%s) policy: %s\n", cp->own_bdaddr_type,
 			bdaddrtype2str(cp->own_bdaddr_type),
 		(cp->filter == 0x00 ? "All" :
-			(cp->filter == 0x01 ? "white list only" : "reserved")));
+			(cp->filter == 0x01 ? "accept list only" : "reserved")));
 }
 
 static inline void le_set_scan_enable_dump(int level, struct frame *frm)
@@ -1772,7 +1772,7 @@ static inline void command_dump(int level, struct frame *frm)
 			generic_command_dump(level + 1, frm);
 			return;
 		case OCF_CENTRAL_LINK_KEY:
-			master_link_key_dump(level + 1, frm);
+			temporary_link_key_dump(level + 1, frm);
 			return;
 		case OCF_READ_REMOTE_EXT_FEATURES:
 			read_remote_ext_features_dump(level + 1, frm);
@@ -3114,7 +3114,8 @@ static inline void remote_name_req_complete_dump(int level, struct frame *frm)
 	}
 }
 
-static inline void master_link_key_complete_dump(int level, struct frame *frm)
+static inline void temporary_link_key_complete_dump(int level,
+							struct frame *frm)
 {
 	evt_central_link_key_complete *evt = frm->ptr;
 
@@ -3565,7 +3566,7 @@ static inline void evt_le_conn_complete_dump(int level, struct frame *frm)
 	p_indent(level, frm);
 	printf("status 0x%2.2x handle %d, role %s\n",
 					evt->status, btohs(evt->handle),
-					evt->role ? "slave" : "master");
+					evt->role ? "peripheral" : "central");
 
 	p_indent(level, frm);
 	p_ba2str(&evt->peer_bdaddr, addr);
@@ -3875,7 +3876,7 @@ static inline void event_dump(int level, struct frame *frm)
 		generic_response_dump(level + 1, frm);
 		break;
 	case EVT_CENTRAL_LINK_KEY_COMPLETE:
-		master_link_key_complete_dump(level + 1, frm);
+		temporary_link_key_complete_dump(level + 1, frm);
 		break;
 	case EVT_REMOTE_NAME_REQ_COMPLETE:
 		remote_name_req_complete_dump(level + 1, frm);
-- 
2.33.0.rc1.237.g0d66db33f3-goog


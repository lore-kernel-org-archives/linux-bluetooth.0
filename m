Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 22:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbhLGW7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhLGW7l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 17:59:41 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E8CC061746
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 14:56:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r25so1868881edq.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 14:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMhEOw0YdYVet9Z96+RsKHt4qzb6riidkXliwvhchQg=;
        b=EOWfKICnIN5GRuJOvOchuroxDdVyHB3K6lIE5XMKHXspoUDHFI3qjxgBhe9ITbYiUQ
         UwhXTwZfJB5ai2UM1jBbHVizB7a41TQne4JkvLHtof353tHybQNssFYPIQffz284DUzc
         Fwc2OrXcOqBQUrF/6rpjBelnEQaHDf8u1HXZgpALYdLoBA/Duchfi/GrpRjkCMCCfjzg
         2iMZ/qDrRoZqYcI8eX15sxS2iL7CpbMhkrsF772oD3ouG4KBmA1NX5qt8FL637OHphHB
         v7UnkcI426Y6FmPqtBwgRZf3waXTTdAyHah3UGHOnPLfqN0iGjnHcR9OSwrA1+IOFDCt
         A6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMhEOw0YdYVet9Z96+RsKHt4qzb6riidkXliwvhchQg=;
        b=64ammtkryrxuETZsXpSu43tfrOIqXpIa0V7WN9GHRDYII1v+yQm58H8fWBgXKWwnpP
         YLJOAD8J3+q/C9S6Ar9hoGaq1xJW6JRPLz0IgnJqzYtpAWRllUj7q2zxr59Iv+vvtNId
         2D+sqSWX4LhnrTQfQM6KtJgluGXOFP6S3j9gNTH/4cmP1TdmYNigt3E8UQBJ4dw1p6vH
         94VaVvtMJeGXh9bWEv9d5gks/SL003pUx+50bywhniy0Vm0VBQRBOnPEMnQx0rqW2Iy8
         dBO+8tCoc//05VL2YZ/uwbm10drzAJ5/utr8cYXb93XCVRp3+Co+vHKNy1V6gXW2gg+z
         r7vw==
X-Gm-Message-State: AOAM531lahB5vSChM23DjE70rc8fdgoPCIIB49lDE6Mqix5iTlLCrfJr
        +onfmMI2Q15zXfAVa0oC8cJtANCnEOo=
X-Google-Smtp-Source: ABdhPJy6heo16+68KbeTWtWrFgTk/c8iX4AOEP8td1cxEX2XtZxtY24jsf4e3dwlfOWivw5/+CvB9Q==
X-Received: by 2002:a17:906:58c8:: with SMTP id e8mr2839217ejs.444.1638917768922;
        Tue, 07 Dec 2021 14:56:08 -0800 (PST)
Received: from aspire.cbl.vpn (net-188-217-49-100.cust.vodafonedsl.it. [188.217.49.100])
        by smtp.gmail.com with ESMTPSA id ho30sm489468ejc.30.2021.12.07.14.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:56:08 -0800 (PST)
From:   Daniele Biagetti <dbiagio79@gmail.com>
X-Google-Original-From: Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele Biagetti <daniele.biagetti@cblelectronics.com>
Subject: [PATCH BlueZ 1/6] tools/mesh-gatt: Add onoff set unack message to onoff client model
Date:   Tue,  7 Dec 2021 23:55:59 +0100
Message-Id: <20211207225604.35156-2-daniele.biagetti@cblelectronics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
References: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh-gatt/onoff-model.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
index 9dfedd85a..13ff4bbe3 100644
--- a/tools/mesh-gatt/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -226,6 +226,8 @@ static void cmd_set(int argc, char *argv[])
 	uint16_t n;
 	uint8_t msg[32];
 	struct mesh_node *node;
+	int np;
+	uint32_t opcode;
 
 	if (IS_UNASSIGNED(target)) {
 		bt_shell_printf("Destination not set\n");
@@ -237,13 +239,22 @@ static void cmd_set(int argc, char *argv[])
 	if (!node)
 		return;
 
-	if ((read_input_parameters(argc, argv) != 1) &&
-					parms[0] != 0 && parms[0] != 1) {
-		bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\"\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	np = read_input_parameters(argc, argv);
+	if ((np != 1) && (np != 2) &&
+		parms[0] != 0 && parms[0] != 1 &&
+		parms[1] != 0 && parms[1] != 1) {
+	bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" "
+		"and an optional \"0\" or \"1\" as unack\n");
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if( (np==2) && parms[1] ){
+		opcode = OP_GENERIC_ONOFF_SET_UNACK;
+	}else{
+		opcode = OP_GENERIC_ONOFF_SET;
 	}
 
-	n = mesh_opcode_set(OP_GENERIC_ONOFF_SET, msg);
+	n = mesh_opcode_set(opcode, msg);
 	msg[n++] = parms[0];
 	msg[n++] = trans_id++;
 
@@ -263,7 +274,7 @@ static const struct bt_shell_menu onoff_menu = {
 						"Set node to configure"},
 	{"get",			NULL,				cmd_get_status,
 						"Get ON/OFF status"},
-	{"onoff",		"<0/1>",			cmd_set,
+	{"onoff",		"<0/1> [unack]",		cmd_set,
 						"Send \"SET ON/OFF\" command"},
 	{} },
 };
-- 
2.25.1


Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE26C3F2CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D8024658
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m09/nHuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCDRc4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:32:56 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44396 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgCDRc4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 12:32:56 -0500
Received: by mail-ua1-f67.google.com with SMTP id a33so986306uad.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2020 09:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+GlLeICOoog9hpYa28LAEI9g8apurBfdeSCfAM8f2Y=;
        b=m09/nHuhRtmoMbLwJaboi8/OERWImxBZlIf+Dj9Tql10G2ECtQJNIfNZPnhteK2D60
         ZCeapEOb2WbRNKmgOv2uFYBnn730RA5mpVC26LHo8liRV54rD4HuCZK81JJcZENlYGkS
         kxFF+5kosShZA3HQjOhsSgPHmhYpKMNx3Qg8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+GlLeICOoog9hpYa28LAEI9g8apurBfdeSCfAM8f2Y=;
        b=qiQMbSl+1Z2fgC1TjQ0qVfdzIEigtECV1hiMeLAkalC1zqjREqTk7BRI5KAp5nZjYW
         qd6gUTDorK9kCyMY5N0jyZiXIXfDvo3Sei6yFw0nfKcg8DpbbCPqzEdr6KITfQi1Ysk1
         ggZ/ae4s4EVTgGaC6ObtmrcQlU1dSxS4ni/cOgQ4wrkGEFADQOBZYrpQm5GaLjltG88l
         /VUk5Ss86/HwDapzrlptd4zpz4BO+Wkb6L8GSUxrT8wxlnBk1qCnlI4M/+LeSX6mwJlS
         I9u/Zu/GtTEucmASZkidSiDzsROE8HEaM+QVWTgz/AVtmnhS4NLOuUpB+oL5lmraYCR9
         VDCw==
X-Gm-Message-State: ANhLgQ3kojqZTBO96N/5mqQcnAsUC/qG20FKtkNWs9+7E2TC0CYJqzUC
        Qra3eD7RIdrWWq7N0IvHhJmS963+KrY=
X-Google-Smtp-Source: ADFU+vvuF+VgC1gxvk3IGENngUTqsgbawKWNA3MnTlR7UbGk02PwgDMHZCmyrrNJxp5wSly9uzAa0Q==
X-Received: by 2002:ab0:4753:: with SMTP id i19mr2081161uac.70.1583343175544;
        Wed, 04 Mar 2020 09:32:55 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id w1sm4673953vso.22.2020.03.04.09.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:32:54 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v1] Adding definitions for Wide Band Speech configuration
Date:   Wed,  4 Mar 2020 17:32:49 +0000
Message-Id: <20200304173249.66324-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the corresponding user space definition for wide band
speech.

---

 doc/mgmt-api.txt | 30 ++++++++++++++++++++++++++++++
 lib/mgmt.h       |  5 ++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5c23268a1..ecdfd9b95 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3052,6 +3052,36 @@ Load Blocked Keys Command
 	Possible errors:	Invalid Parameters
 				Invalid Index
 
+Set Wide Band Speech Command
+======================
+
+	Command Code:		0x0047
+	Controller Index:	<controller id>
+	Command Parameters:	wide_band_speech_enabled (1 Octet)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command is used to enable/disable Wide Band Speech support for a
+	controller. The allowed values of the wide_band_speech_enabled command
+	parameter are 0x00 and 0x01. All other values will return
+	Invalid Parameters.
+
+	This command is only available for Wide Band Speech capable controllers and
+	will yield in a Not Supported error otherwise.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	In case the kernel subsystem does not support Wide Band Speech or the
+	controller does not either, the command will fail regardless.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Busy
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
 
 Command Complete Event
 ======================
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 101cf5f95..d1f0a6053 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -101,7 +101,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_PRIVACY		0x00002000
 #define MGMT_SETTING_CONFIGURATION	0x00004000
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
-#define MGMT_SETTING_PHY_CONFIGURATION 0x00010000
+#define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
+#define MGMT_SETTING_WIDE_BAND_SPEECH	0x00020000
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -599,6 +600,8 @@ struct mgmt_cp_set_blocked_keys {
 	struct mgmt_blocked_key_info keys[0];
 } __packed;
 
+#define MGMT_OP_SET_WIDE_BAND_SPEECH	0x0047
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
-- 
2.25.1.481.gfbce0eb801-goog


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CBEC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 18:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCPSJF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 14:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCPSJC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 14:09:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D35CBBB03
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 11:09:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j13so2481247pjd.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678990140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csyHtbmv3B6fRpTZjS5Iu22tgwlPlwtuJTzvRjWon20=;
        b=htM87hJGnjrYabIr38CAcMDhZ4aEdExcg3JBSp4nAbml68xpZ4JP5XyZcxenVVSJKi
         vhC0lN9Am8VHEXodC7ubQTn9UoFSDiluV/opL0CRsm78zT5AYXo8X4nkja74UZcjrBjo
         PxPOT1WEPJxFZsEfqVkgyYObKDjNliA0++7eYCNhTHFbzJfYXzGsM+08gyIKEsdrH8KO
         XcffomHzOjOhlddx+Wm6u2zkYcUT1WFgmX86nk/5D/3mvtw8u5sAgSzuut8C9aCQcD8e
         b6ybwV0BtZOnNU3uDFC62hAjyzH/sNnheZmwwYcFI2vitbiBvqjCvoKfFtlSsgEFwJk7
         F77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csyHtbmv3B6fRpTZjS5Iu22tgwlPlwtuJTzvRjWon20=;
        b=ZuuxypWQgG1TPPmRPXJLQiqfiXK4dWEUHjwBqkCuLfY+FG9ZU6nTFs0E+VDlIgG9KJ
         WmPkQ67B6ICIL9b1vTsRD7eiVDdIdGRyxAXrzdfFYbfeXG/ghZHzfV+6c4yU06t+SCRi
         hvj69oWOiFEjI4XmXx3iiUqSTteOpoJA1VeShP8FoxtA7IOfjBbrSxUoC+FZXGtp87d4
         A4o8CMWMDcrr95vhg0uCIbOvtQbP0aVCOa76sid2X72Pw7UxeWf8DyVGSHwJCDggks6T
         c4gOwB3S+BTky2R35uBK3Qq+//6RfW/LegReqlh69LHUaCdl76ftX46qjq2KypVXXl9N
         kcEg==
X-Gm-Message-State: AO0yUKU059Jv5hHObgOHh+VrovFpB7poQ3UEDdFuWUpNaHNqIUu7t9Of
        WuYFWnFURCHZH5mVaYwLZJGFAa2JsyC2IIra
X-Google-Smtp-Source: AK7set92PPrEVIM/PN2rhOX3ZlLbo1t+FBqJSJyefH+ZzQZRlu1NOpWCOK9xsYc1+5I7Hr6S43imUQ==
X-Received: by 2002:a05:6a20:1d58:b0:d3:aba7:807c with SMTP id cs24-20020a056a201d5800b000d3aba7807cmr3502455pzb.34.1678990140478;
        Thu, 16 Mar 2023 11:09:00 -0700 (PDT)
Received: from fedora.. (c-67-170-58-107.hsd1.wa.comcast.net. [67.170.58.107])
        by smtp.googlemail.com with ESMTPSA id p18-20020a634f52000000b0049f5da82b12sm5295119pgl.93.2023.03.16.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:09:00 -0700 (PDT)
From:   Inga Stotland <inga.stotland@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@gmail.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@gmail.com>
Subject: [PATCH BlueZ 2/2] tools/mesh-cfgclient: Auto request own composition data
Date:   Thu, 16 Mar 2023 11:07:59 -0700
Message-Id: <20230316180759.147486-2-inga.stotland@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316180759.147486-1-inga.stotland@gmail.com>
References: <20230316180759.147486-1-inga.stotland@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When attaching a local provisioner node, always request own
composition data to accommodate functional consolidation of
regular and remote provisioning mechanisms.
The knowledge of the own node composition is necessary for
provisioning initiation and self configuration.
---
 tools/mesh-cfgclient.c |  9 +++++++--
 tools/mesh/cfgcli.c    | 15 +++++++++++++++
 tools/mesh/cfgcli.h    |  2 ++
 tools/mesh/util.c      |  2 ++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 50be82bcf..6d2d34409 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -43,7 +43,8 @@
 
 #define CFG_SRV_MODEL	0x0000
 #define CFG_CLI_MODEL	0x0001
-#define RPR_SVR_MODEL	0xFFFF0004
+#define RPR_SVR_MODEL	0x0004
+#define RPR_CLI_MODEL	0x0005
 #define PRV_BEACON_SVR	0x0008
 #define PRV_BEACON_CLI	0x0009
 
@@ -775,6 +776,10 @@ static void attach_node_reply(struct l_dbus_proxy *proxy,
 		remote_clear_rejected_addresses(ivi);
 	}
 
+	/* Read own node composition */
+	if (!cfgcli_get_comp(0x0001, 128))
+		l_error("Failed to read own composition");
+
 	return;
 
 fail:
@@ -863,7 +868,7 @@ static void scan_start(void *user_data, uint16_t dst, uint32_t model)
 {
 	struct scan_data *data;
 
-	if (model != RPR_SVR_MODEL)
+	if (model != (0xffff0000 | RPR_SVR_MODEL))
 		return;
 
 	data = l_malloc(sizeof(struct scan_data));
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 4f6248e48..1a404af38 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -1081,6 +1081,21 @@ static void cmd_default(uint32_t opcode)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+
+bool cfgcli_get_comp(uint16_t unicast, uint8_t page)
+{
+	uint16_t n;
+	uint8_t msg[32];
+
+	n = mesh_opcode_set(OP_DEV_COMP_GET, msg);
+
+	msg[n++] = page;
+
+	target = unicast;
+
+	return config_send(msg, n, OP_DEV_COMP_GET);
+}
+
 static void cmd_composition_get(int argc, char *argv[])
 {
 	uint16_t n;
diff --git a/tools/mesh/cfgcli.h b/tools/mesh/cfgcli.h
index 7281caa46..621dd0259 100644
--- a/tools/mesh/cfgcli.h
+++ b/tools/mesh/cfgcli.h
@@ -19,4 +19,6 @@ typedef void (*delete_remote_func_t) (uint16_t primary, uint8_t ele_cnt);
 
 struct model_info *cfgcli_init(key_send_func_t key_func,
 				delete_remote_func_t del_node, void *user_data);
+
+bool cfgcli_get_comp(uint16_t unicast, uint8_t page);
 void cfgcli_cleanup(void);
diff --git a/tools/mesh/util.c b/tools/mesh/util.c
index d8c47c0e9..dea496dbe 100644
--- a/tools/mesh/util.c
+++ b/tools/mesh/util.c
@@ -138,6 +138,8 @@ const char *sig_model_string(uint16_t sig_model_id)
 	case 0x0001: return "Configuration Client";
 	case 0x0002: return "Health Server";
 	case 0x0003: return "Health Client";
+	case 0x0004: return "Remote Provisioning Server";
+	case 0x0005: return "Remote Provisioning Client";
 	case 0x0008: return "Private Beacon Server";
 	case 0x0009: return "Private Beacon Client";
 	case 0x1000: return "Generic OnOff Server";
-- 
2.39.2


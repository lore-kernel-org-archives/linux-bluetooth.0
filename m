Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBE6C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 23:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbjEYXq1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEYXq0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 19:46:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A92134
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 16:46:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-255401f977dso224285a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685058384; x=1687650384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv3+9h2lVSiuHdkggdtIDHwDCe3yb3IHg4Jg3yIUd48=;
        b=YsZplhjJemigEa+/0dQ94vZnYBv6k6+frTubTXMCcTb7Rcu0NoILdUg//ymqNLSOhP
         Y2GHabYiaId2O/4iMurRfpcu9yEUTIO06ZaJnfn+aJxWnL4Acder2WlDhAfpJvcjOWKD
         ehYyxO3PgtdLhcxCAB1DurTTly6NDv70+L+ozd0uBRIJDoLw3CAD6w+/8M0o4PENGccy
         JU5XRSX57sj3H4FMt0yrxXKRCkK8p7LYKbnRMqSJzjex6AWCTd0fdDYaBbGOmTbZcDNn
         5arslI6T3RT52vj+yXh2IYlEAa0jvyhJ6IV6JyFXd0VHEECmD2go0JL2DaIHtAjzyd37
         Nv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685058384; x=1687650384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv3+9h2lVSiuHdkggdtIDHwDCe3yb3IHg4Jg3yIUd48=;
        b=d4NK+H9JvE0Fo3GXwgltv3JQb+GGq0cavlY97pDC2cJ2BQNr/qesO6MvPpunxj/UFk
         vpUP3VuEbVQ1jhaXFRuCc4FsLpoknHu0g913DmSVhpi/xW0EYvYXXLGNxXpJKnAwHti9
         NAZBjFCBiNXC4u+nddy7AS5lsHLNNX6WxjfSt1/nLy7mXt8S8yMAgPaExYG0q5Cd6qKr
         pAac65eMHpWn6fER2quh4Zq9H7ZU2jAQxzVJjonIeTVaMbJl/wgpQTWbKIYN2nsPk/lc
         fAYojp/KoMuHSS0snEm3CsFsD4XL2J2c57lWtDl60NSPcBgbf0FsrR3E0uawf9LuMRVo
         Gogg==
X-Gm-Message-State: AC+VfDyPHOJwVMzOywCvioMJChMLYY5Ni+gkHbb4gbSl3GvAwNxzXxXf
        uu0eO7ukdTmV1js8aGc1JYMzK6SbWDE=
X-Google-Smtp-Source: ACHHUZ70Xo/TlrbC6md8XM77Q7c9ZP8BMuMHjcOppfi0ONW4/fjm1lgamvPP6sifC04G6n7zcZgQ+A==
X-Received: by 2002:a17:90a:cf85:b0:247:2152:6391 with SMTP id i5-20020a17090acf8500b0024721526391mr444613pju.17.1685058383785;
        Thu, 25 May 2023 16:46:23 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r2-20020a654982000000b0050bc4ca9024sm1479473pgs.65.2023.05.25.16.46.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 16:46:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Print process information
Date:   Thu, 25 May 2023 16:46:21 -0700
Message-Id: <20230525234621.3597759-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the process information when available:

bluetoothd[35]: @ MGMT Command: Rea.. (0x0001) plen 0  {0x0001}
@ MGMT Event: Command Complete (0x0001) plen 6         {0x0001}
    Read Management Version Information (0x0001) plen 3
---
 monitor/packet.c | 56 +++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index b492b8a757a5..04eb70141e68 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -315,13 +315,33 @@ void packet_set_msft_evt_prefix(const uint8_t *prefix, uint8_t len)
 		memcpy(index_list[index_current].msft_evt_prefix, prefix, len);
 }
 
+static void cred_pid(struct ucred *cred, char *str, size_t len)
+{
+	char *path = alloca(24);
+	char line[128];
+	FILE *fp;
+
+	snprintf(path, 23, "/proc/%u/comm", cred->pid);
+
+	fp = fopen(path, "re");
+	if (fp) {
+		if (fgets(line, sizeof(line), fp)) {
+			line[strcspn(line, "\r\n")] = '\0';
+			snprintf(str, len, "%s[%u]", line, cred->pid);
+		} else
+			snprintf(str, len, "[%u]", cred->pid);
+		fclose(fp);
+	} else
+		snprintf(str, len, "[%u]", cred->pid);
+}
+
 static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 					uint16_t index, const char *channel,
 					const char *color, const char *label,
 					const char *text, const char *extra)
 {
 	int col = num_columns();
-	char line[256], ts_str[96];
+	char line[256], ts_str[96], pid_str[140];
 	int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
 	static size_t last_frame;
 
@@ -418,7 +438,13 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 			pos += n;
 	}
 
-	n = sprintf(line + pos, "%c %s", ident, label ? label : "");
+	if (cred) {
+		cred_pid(cred, pid_str, sizeof(pid_str));
+		n = sprintf(line + pos, "%s: %c %s", pid_str, ident,
+						label ? label : "");
+	} else
+		n = sprintf(line + pos, "%c %s", ident, label ? label : "");
+
 	if (n > 0) {
 		pos += n;
 		len += n;
@@ -12091,7 +12117,6 @@ void packet_user_logging(struct timeval *tv, struct ucred *cred,
 					const char *ident, const void *data,
 					uint16_t size)
 {
-	char pid_str[140];
 	const char *label;
 	const char *color;
 
@@ -12117,26 +12142,7 @@ void packet_user_logging(struct timeval *tv, struct ucred *cred,
 	}
 
 	if (cred) {
-		char *path = alloca(24);
-		char line[128];
-		FILE *fp;
-
-		snprintf(path, 23, "/proc/%u/comm", cred->pid);
-
-		fp = fopen(path, "re");
-		if (fp) {
-			if (fgets(line, sizeof(line), fp)) {
-				line[strcspn(line, "\r\n")] = '\0';
-				snprintf(pid_str, sizeof(pid_str), "%s[%u]",
-							line, cred->pid);
-			} else
-				snprintf(pid_str, sizeof(pid_str), "%u",
-								cred->pid);
-			fclose(fp);
-		} else
-			snprintf(pid_str, sizeof(pid_str), "%u", cred->pid);
-
-		label = pid_str;
+		label = NULL;
         } else {
 		if (ident)
 			label = ident;
@@ -12146,8 +12152,8 @@ void packet_user_logging(struct timeval *tv, struct ucred *cred,
 
 	if (ident && (ident[0] == '<' || ident[0] == '>')) {
 		packet_decode(tv, cred, ident[0], index, color,
-				label == ident ? &ident[2] : label,
-				data, size);
+			      label == ident ? &ident[2] : label,
+			      data, size);
 		return;
 	}
 
-- 
2.40.1


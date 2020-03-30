Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2792C2D0EB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 17:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA17720776
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 17:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfYF+W+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgC3RaL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:30:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36950 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgC3RaK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 13:30:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so6999593plm.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4n4/N6eg5m0/HzcUvfDCOrcEQ9mI7VAnsyffspU6ggI=;
        b=bfYF+W+V0FYH7HEpcbNhc7TCnAATElSHDNDUruvfOatWenBiJuDjOtrusRSSw3kliu
         5wqhY6+bs3oHZw/SiM5Wc6QnZvRjDZY4ZIhO0cz3Ga/I5nUR3MWTVa2i0T/9wwmXZi6T
         z+RW9nOobhSuoCOICeT6N7Pvz5rrEokUTMQEzWOgzGVEvQZVIBILlQ9mH9+Yisj5Eipw
         NeHGMwYanFthxE31YxwGJZ1395uFI7WBgvCGZAQ0ee/Y20f1sYidQxtZYOhDsgA54D9g
         KKvAgCDKQNsGpz6UL1gxUDN5xFd5XOvKaqtpD8tVY/3HFU+qIcILRQpiqJVNgQpw/9eG
         BoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4n4/N6eg5m0/HzcUvfDCOrcEQ9mI7VAnsyffspU6ggI=;
        b=C2PJWZlkpVjqyZq82iz3W5EluYZ0AOE78s0UxeaBI83eD41WlsPi6xwb/Uv4g7SXbq
         Efx433jY+kOJBYaNqTrtniCanOdvfvvP5gstoeaQtvzKrwXugRqv2MYa7fs+z7TtUxKb
         ngttfDEKxYOeAg3TA0bDv3PoFXxDQkWr54/r+Xo/dS7avs4VWBet0cvwl6pSeThMDlPK
         hV3toQjoBt8BjzHpW7ABIBl8ad9NVKJyYEge4iTZLN74J9tNFz6WpL2Xy7mXK1uiv1YQ
         GLRIbL5kAe5ineJ7mBbQhlw7nq8j34T6dax7agfKYaCVjZFDygmP/suFpihCRMu6K343
         WVSg==
X-Gm-Message-State: ANhLgQ3VCeWR7nz4nO8NQfSrgygrCYzHgAXsau7b/6WnMuqilWlJQY/b
        +E9k91xM9cgmkvQarn8zrjLnldtfdwg=
X-Google-Smtp-Source: ADFU+vsPwqGLmPT5f9VyrJcmI52tQhjrompNJ5k8SjSGeEpWm9TS6TPshWEIXmPAjWld9PB0xBq3vw==
X-Received: by 2002:a17:902:a603:: with SMTP id u3mr13832522plq.105.1585589409107;
        Mon, 30 Mar 2020 10:30:09 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r8sm115571pjo.22.2020.03.30.10.30.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:30:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] btmgmt: Rename version command to revision
Date:   Mon, 30 Mar 2020 10:30:06 -0700
Message-Id: <20200330173006.12785-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200330173006.12785-1-luiz.dentz@gmail.com>
References: <20200330173006.12785-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

version is already handled by btshell and always refer to BlueZ version
rather than MGMT version, so this renames the command to revision to
avoid having the clash of command names.
---
 tools/btmgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 37c1c1c9e..09d6e4272 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1025,7 +1025,7 @@ done:
 	bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_version(int argc, char **argv)
+static void cmd_revision(int argc, char **argv)
 {
 	if (mgmt_send(mgmt, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE,
 				0, NULL, version_rsp, NULL, NULL) == 0) {
@@ -4391,8 +4391,8 @@ static const struct bt_shell_menu main_menu = {
 	.entries = {
 	{ "select",		"<index>",
 		cmd_select,		"Select a different index"	},
-	{ "version",		NULL,
-		cmd_version,		"Get the MGMT Version"		},
+	{ "revision",		NULL,
+		cmd_revision,		"Get the MGMT Revision"		},
 	{ "commands",		NULL,
 		cmd_commands,		"List supported commands"	},
 	{ "config",		NULL,
-- 
2.21.1


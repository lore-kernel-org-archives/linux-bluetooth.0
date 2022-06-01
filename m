Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537ACC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jun 2022 21:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiFAVMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiFAVMc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jun 2022 17:12:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BE5BD23
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jun 2022 14:12:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u18so2879719plb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jun 2022 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIxGrmNBg/91TDmPlkpGK2bw1iCjCrFVedNSq1scBaI=;
        b=LFXdACnqMruRzM00aJcydRM7c63GV9bT16zujKOZmXNWTtolLTkIayq9UebFPVOUTV
         t2jU0GBoZ66k9OfwcsK9RPHjXiTeT+XlFVjArjSX6pDnRudLVJnZISOoEukRHLkK775h
         6jP2rE+bgix2lWrP5/44plgSCgr0wURmJ41BLxas60jTEaC2zlnqhyx2vnUFQKHmdrqf
         GAVDDPYS8CeJcIsa6P7BRu2U30f/Q6e7C3OZkqCbsO8BY70RRnrJRNMcBqh9IX0xuR0J
         7lnI92MY0TGyzlY2Zv8wZ08PNy/BMDsRRrEvhs1n2DmKHsPzpPOT89/WMCXeFwqx50A0
         +nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIxGrmNBg/91TDmPlkpGK2bw1iCjCrFVedNSq1scBaI=;
        b=NPMBhcdiDBnUQ2RTLF2NL58Cjj1BVOWYUx5yvSiBQxCFkUyd1JHtMSy4JjjMA5N8SO
         r7lMWi3bLkINZAQL8wn7AAY9NvNoSJbkMc731cPACocHQmDarlyh5L49FSGPFzQRLc31
         /aD7h05ROZDSC+Je9ZmtfA3Sa9FzrIQ+Drp9TnuSGv8gyC/2BooaMb86nkDk+2Z9PnNb
         o6i/7xBLFhFAmVucF8322347lvNWJ/pL6H6V+RreH/K4xUSncH35rEoiS4vlx7ibcj/p
         oFeFDBD1RTekvhTyesfAwEBsM+W7rEVyEj/6mZEVarhCJv7fRsqO/zViK7n8z572yvKu
         K5YA==
X-Gm-Message-State: AOAM5314HYmDdrEIc0yIZWQvUsgwm+zynLKYuhb/DNG/yhakpb0Coa7V
        het4rZRQ0na3zctksWobVeGUMgnsCVI=
X-Google-Smtp-Source: ABdhPJzBMEOBCvK1Ys05MgsfgCJE6o2JVGNiy08AQVKuY0Io4qnEEllciw/ix1hFj50n1sNqLoHLdw==
X-Received: by 2002:a17:903:1252:b0:154:ca85:59a0 with SMTP id u18-20020a170903125200b00154ca8559a0mr1308138plh.169.1654117951199;
        Wed, 01 Jun 2022 14:12:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id iq18-20020a17090afb5200b001e31f4cc977sm1740065pjb.56.2022.06.01.14.12.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:12:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test-runner: Fix not waiting for system_bus_socket
Date:   Wed,  1 Jun 2022 14:12:30 -0700
Message-Id: <20220601211230.1355268-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes test-runner wait for system_bus_socket to be available before
continuing otherwise the likes of bluetoothd would likely fail to start.
---
 tools/test-runner.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1f1a8c36f..945a16a77 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -452,13 +452,13 @@ static pid_t start_dbus_daemon(void)
 
 		if (!stat("/run/dbus/system_bus_socket", &st)) {
 			printf("Found D-Bus daemon socket\n");
-			break;
+			return pid;
 		}
 
-		usleep(25 * 1000);
+		sleep(1);
 	}
 
-	return pid;
+	return -1;
 }
 
 static const char *daemon_table[] = {
-- 
2.35.1


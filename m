Return-Path: <SRS0=zUy1=6C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAF8C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Apr 2020 03:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDD6221F7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Apr 2020 03:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NlLNGOSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDRDJb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgDRDJb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 23:09:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1FC061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 20:09:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a22so1842747pjk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 20:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7epjNujTEWtV2z+kYZ+rP7ZeTkhIS5HfNwOqOHLAvB4=;
        b=NlLNGOSRtbqhRdny0x6DiQs8TgZ4o5msZZCAQXcb6XJUHM5rCTldLVql79ZCXqQkbO
         LGqu4ITNVmUumx/UTfgyb3wzo5Z5JQCMnWie81lX5wXNI20lCYo+BqtFKih0aBqpT5zg
         GbXEJKLcL+Arf6hhaeDszwQ2QwdYFEcYwkUDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7epjNujTEWtV2z+kYZ+rP7ZeTkhIS5HfNwOqOHLAvB4=;
        b=PMS+b3SYiCPRXnxJ1lvWYEH+MZWNLdWk+8rEZUgE1HB+bje4VvqU2Nv/JmBicpyLji
         fv5JsXvAyx01tzjK2hw6iV5t1BLmavTFF8Xg89vIm+slacyB+q/hwrEDlUFD39uNYIcn
         2r91oTZwxsrrtOrLyNxfpQoh6dPSYnw/MbSUZJm1vqE/G1BI5l8iMvH9W5eUS0evz1D4
         aT7li7pJMxRUVmkhqij/0+XwJRwBzFnIAqIOTVFzpmp6dOdsQThoSgyQCql0D1SMNO5O
         PhSJMzX1drJvFJQMBESJ7yl5TaRUBydmG7DgUASbt5FqldCit1xNtn1IKWbIcqNSODA3
         tgsg==
X-Gm-Message-State: AGi0PubtDrPmmwKCLCnKxnuWP0us8JgE3Vszb31Pc+l9MsP0GyiTmJ+/
        WXUpFzT9Z9MVJ4yfRlRHUeNVj8EHrb4=
X-Google-Smtp-Source: APiQypI1KGNdLK9MPrQanbgdxO7TI6V3uXn0O30S7fYuyHhK4ma4bnshRIjI/Fptzpf6nuzZ2N6IpQ==
X-Received: by 2002:a17:902:b108:: with SMTP id q8mr6841773plr.214.1587179368978;
        Fri, 17 Apr 2020 20:09:28 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id g2sm20885794pfh.193.2020.04.17.20.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 20:09:28 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1] doc: Describe the new Advertisement Monitor support
Date:   Fri, 17 Apr 2020 20:09:24 -0700
Message-Id: <20200417200903.BlueZ.v1.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This describes the following commands.
- Add Advertisement Patterns Monitor
- Remove Advertisement Monitor
- Remove All Advertisement Monitors
Note that the content of a monitor can differ based on its type. For now we
introduce only pattern-based monitor, so you may find that unlike commands
for removing monitor(s), the Add command is tied to a specific type.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

 doc/mgmt-api.txt | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 39f23c456..fcd281a35 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3138,6 +3138,74 @@ Read Security Information Command
 				Invalid Index
 
 
+Add Advertisement Patterns Monitor Command
+=========================================
+
+	Command Code:		0x0049
+	Controller Index:	<controller id>
+	Command Parameters:	Pattern_count (1 Octets)
+				Pattern1 {
+					AD_Data_Type (1 Octet)
+					Index (1 Octet)
+					Length (1 Octet)
+					Value (variable length)
+				}
+				Pattern2 { }
+				...
+	Return Parameters:	Monitor_Index (8 Octets)
+
+	This command is used to add an advertisement monitor whose filtering
+	conditions are patterns. The kernel would track the number of registered
+	monitors to determine whether to perform LE scanning while there is
+	ongoing LE scanning for other intentions, such as auto-reconnection and
+	discovery session. If the controller supports Microsoft HCI extension,
+	the kernel would offload the content filtering to the controller in
+	order to reduce power consumption; otherwise the kernel ignore the
+	content of the monitor.
+
+	Possible errors:	Failed
+				Busy
+				Invalid Parameters
+
+
+Remove Advertisement Monitor Command
+====================================
+
+	Command Code:		0x004A
+	Controller Index:	<controller id>
+	Command Parameters:	Monitor_Index (8 Octets)
+	Return Parameters:	Monitor_Index (8 Octets)
+
+	This command is used to remove an advertisement monitor. The kernel
+	would remove the monitor with Monitor_Index and update the LE scanning.
+	If the controller supports Microsoft HCI extension and the monitor has
+	been offloaded, the kernel would cancel the offloading; otherwise the
+	kernel takes no further actions other than removing it from the list.
+
+	Possible errors:	Failed
+				Busy
+				Invalid Index
+
+
+Remove All Advertisement Monitors Command
+=========================================
+
+	Command Code:		0x004B
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Num_removed_Monitors (2 Octets)
+				Monitor_Index[i] (2 Octets)
+
+	This command is used to remove all advertisement monitors. The kernel
+	would remove all monitors and update the LE scanning if needed. If the
+	controller supports Microsoft HCI extension the monitors have been
+	offloaded, the kernel would cancel all offloadings; otherwise the kernel
+	takes no further actions other than removing all monitors from the list.
+
+	Possible errors:	Failed
+				Busy
+
+
 Command Complete Event
 ======================
 
-- 
2.24.1


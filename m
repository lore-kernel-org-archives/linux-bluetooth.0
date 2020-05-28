Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C07C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 13:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8582F20814
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 13:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NIqZYzzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbgE1NzJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390526AbgE1NzH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 09:55:07 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB6CC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 06:55:07 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id g14so3976585uaq.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtmNB5XHwV62OWA3C0r4begVZY0ngC9mgL5dmH4ioLg=;
        b=NIqZYzzfiIvq0B37JPl5B4/7KQsPsVoRMsumn9wMzQuyWXA97kDW1Kf0E6rbOYrNhK
         gpM34Dwv5C8fHht+pECch5SBBluyNx2+uaxnwYL+Q/9w+y8ayIoPKVK0xwe8seB/0prJ
         Ty97bmCtoeGURwAbLWXnZ8UT+Rj0F8VXEnCm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtmNB5XHwV62OWA3C0r4begVZY0ngC9mgL5dmH4ioLg=;
        b=HBSe0kaQTv20WqZJUGFt15Vux1gd8oAbWE+ObHKZwT6FOVpj/q8vZ/XNvZYXP+0Lnf
         MkXGGn6YvHIS/Nf9+0OqqVHERW/pkqmFYSbyOTD9Ny0RaypLqJi7Sb/809z7hjujpXPe
         5d+RYoKCeE6s8+gf5Y/avCuZ9m5cqfQbj8VeBbXUcdjXdHXmQHRVTqAN6h8MJXJ9z5V9
         Sxim/TZlAktnObymNt7GU5/L7tPNIC7LQ1JlpOHpJE3zoCswcrWQxieCuCWZkr1yCw6b
         UECDRn3XNsG5WiMWdx4Aaic9w8RvzIZSGHhw+nVbBPT9z4bniGxBH7bs76NM8umk4pdN
         +RtQ==
X-Gm-Message-State: AOAM532Kb4d9DFY6ifWcKttHC5PHAIOoUylI4yiQv/RZCZNpd/C7PUoR
        iCfOeG9VbcQz7eKamkp1jb2YiQsaZc0=
X-Google-Smtp-Source: ABdhPJw1ZjCy0s3RXASKGyPJVsvFFyD5XDsuc4ALl33TbC0Gp2rMYFo9vLnwukRc+JmU5BA5qQGPew==
X-Received: by 2002:ab0:e17:: with SMTP id g23mr2005593uak.31.1590674105959;
        Thu, 28 May 2020 06:55:05 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id k5sm601575vke.0.2020.05.28.06.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:55:04 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v6] doc:adding definitions for load default params mgmt op
Date:   Thu, 28 May 2020 13:54:59 +0000
Message-Id: <20200528135459.18496-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the definition for the read/set default parameter
commands.

In particular, these commands are used to read and set the system
default parameters.  The use of a TLV format also ensures that
parameters are expandable in the future.

This will allow bluetoothd to load parameters from a conf file that may
be customized for the specific requirements of each platforms.

---

 doc/mgmt-api.txt | 113 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 6ee01fed8..cbe6422a5 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3223,6 +3223,119 @@ Set Experimental Feature Command
 				Invalid Index
 
 
+Read Default System Configuration Command
+=============================
+
+	Command Code:		0x004b
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Parameter1 {
+					Parameter_Type (2 Octet)
+					Value_Length (1 Octet)
+					Value (0-255 Octets)
+				}
+				Parameter2 { }
+				...
+
+	This command is used to read a list of default controller parameters.
+
+	Currently defined Parameter_Type values are:
+
+		0x0000	BR/EDR Page Scan Type
+		0x0001	BR/EDR Page Scan Interval
+		0x0002	BR/EDR Page Scan Window
+		0x0003	BR/EDR Inquiry Scan Type
+		0x0004	BR/EDR Inquiry Scan Interval
+		0x0005	BR/EDR Inquiry Scan Window
+		0x0006	BR/EDR Link Supervision Timeout
+		0x0007	BR/EDR Page Timeout
+		0x0008	BR/EDR Min Sniff Interval
+		0x0009	BR/EDR Max Sniff Interval
+		0x000a	LE Advertisement Min Interval
+		0x000b	LE Advertisement Max Interval
+		0x000c	LE Multi Advertisement Rotation Interval
+		0x000d	LE Scanning Interval for auto connect
+		0x000e	LE Scanning Window for auto connect
+		0x000f	LE Scanning Interval for wake scenarios
+		0x0010	LE Scanning Window for wake scenarios
+		0x0011	LE Scanning Interval for discovery
+		0x0012	LE Scanning Window for discovery
+		0x0013	LE Scanning Interval for adv monitoring
+		0x0014	LE Scanning Window for adv monitoring
+		0x0015	LE Scanning Interval for connect
+		0x0016	LE Scanning Window for connect
+		0x0017	LE Min Connection Interval
+		0x0018	LE Max Connection Interval
+		0x0019	LE Connection Latency
+		0x001a	LE Connection Supervision Timeout
+
+	This command can be used at any time and will return a list of supported
+	parameters as well as their current default value.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+Set Default System Configuration Command
+=============================
+
+	Command Code:		0x004c
+	Controller Index:	<controller id>
+	Command Parameters:	Parameter1 {
+					Parameter_Type (2 Octet)
+					Value_Length (1 Octet)
+					Value (0-255 Octets)
+				}
+				Parameter2 { }
+				...
+	Return Parameters:
+
+	This command is used to set a list of default controller parameters.
+
+	Currently defined Parameter_Type values are:
+
+		0x0000	BR/EDR Page Scan Type
+		0x0001	BR/EDR Page Scan Interval
+		0x0002	BR/EDR Page Scan Window
+		0x0003	BR/EDR Inquiry Scan Type
+		0x0004	BR/EDR Inquiry Scan Interval
+		0x0005	BR/EDR Inquiry Scan Window
+		0x0006	BR/EDR Link Supervision Timeout
+		0x0007	BR/EDR Page Timeout
+		0x0008	BR/EDR Min Sniff Interval
+		0x0009	BR/EDR Max Sniff Interval
+		0x000a	LE Advertisement Min Interval
+		0x000b	LE Advertisement Max Interval
+		0x000c	LE Multi Advertisement Rotation Interval
+		0x000d	LE Scanning Interval for auto connect
+		0x000e	LE Scanning Window for auto connect
+		0x000f	LE Scanning Interval for wake scenarios
+		0x0010	LE Scanning Window for wake scenarios
+		0x0011	LE Scanning Interval for discovery
+		0x0012	LE Scanning Window for discovery
+		0x0013	LE Scanning Interval for adv monitoring
+		0x0014	LE Scanning Window for adv monitoring
+		0x0015	LE Scanning Interval for connect
+		0x0016	LE Scanning Window for connect
+		0x0017	LE Min Connection Interval
+		0x0018	LE Max Connection Interval
+		0x0019	LE Connection Latency
+		0x001a	LE Connection Supervision Timeout
+
+	This command can be used when the controller is not powered and
+	all supported parameters will be programmed once powered. Non supported
+	parameters will be ignored.  Note that these only control the default
+	parameters.  Higher level Apis may influence the effective value used.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
2.27.0.rc0.183.gde8f92d652-goog


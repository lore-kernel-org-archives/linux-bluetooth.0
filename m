Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147F4C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 10:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4321207CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgLOKLk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 05:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgLOKL1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 05:11:27 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76639C0617A6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 02:10:47 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id bp20so5379185qvb.20
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 02:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ZcNqNYDWKbKZ8hzaS0DvLFpFlWUMcdBsaXEATtGfxlM=;
        b=G8oo5Ki7Uk2glVHJ1ZyKcjRa0W0eVdeQKZd6I159XluyiAZPPI4ql7yl9L5meODszN
         BKUy7O2znPeKX+xhxrr3m6UK8798BJcH830swI5Ms8rC4XUkeVPbP2jQrX/ydGUyN3RA
         T6dG02XbMbbjOAIzk+/NBa6KAEu/VEk4rp0PKKqEEBQB4638Xyy2Q1oOdod3PyZ4fimQ
         staosPz6KIN8XJzw9+Y6XDscIcR1ZVh5BwTSCgQFKI0G8VnEGr0u0PfevLg+b7/b6OXT
         CWzulXQKAj14g8hV0M+Va5ylqUJQCbVAK7ExMqiHmQw8BDM0EAwks3F5fPCR2JPSYuPa
         FvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ZcNqNYDWKbKZ8hzaS0DvLFpFlWUMcdBsaXEATtGfxlM=;
        b=fjQay8iPONTY+mzK1qlCLloe+XGAuliNABjZKk3pxzh0P8n07zOexCELEU1m/hyniR
         e4IAJMfMG7dn7jqLOHdUWgzHLzPGZKHa34aUxcfLFYEVWX0w1ezInf4XbSKQLfuSV+kz
         N77jqkal7q/SoL4nRQPUwuKKS91lc0M30r2n0417E4G+glo7Rj+i5jt+5tNix1JIrSqb
         8cibUH8IeocRl1MzKqi4UdHAsTkF0D1DEwl7qv8/dt6WopFx0tA3vAAp4Ll6GnHCrTZ0
         5wFC4PwAKe9BjbwVSbCwusF1xegb7WSQu4GqA1TVUTk3zmTFvZacUGhTFsXoBI0SwJ+2
         t/Kw==
X-Gm-Message-State: AOAM530TCB8td20c1LiVAWmtaU9hpfgnx41cdIWnv+GOhgH5QyPpiz3U
        Cxj6R4B194BXVWqA+RTSPqt5nQh8YlsEPnNUrZbEEz3DbuDbV1LevzC7px2Gk3hG+/qicSwDRBC
        9AWBxV5xCiLHKeR6BLM99W99sR/0eNrj8NlV4jaeiIEjZsnyV1+eHNFcccKuJojd1HpcjHQ8EUQ
        6m
X-Google-Smtp-Source: ABdhPJykGbGD0bHSVK+3FtU3cxxyeWFlstcDBixD1uAFwYkjh/zF3q8SnU34ZQ7iN1MVba5EgKWD7haYyeDs
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:8b60:: with SMTP id
 d32mr17896955qvc.60.1608027046492; Tue, 15 Dec 2020 02:10:46 -0800 (PST)
Date:   Tue, 15 Dec 2020 18:10:36 +0800
Message-Id: <20201215181024.Bluez.v2.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [Bluez PATCH v2 1/2] doc/mgmt-api: Add opcode for adding
 advertisement monitor with RSSI
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This is to leverage the filtering by RSSI feature on those controllers
which supports advertisement packet filtering. To avoid changing the
existing API and breaking it, a new opcode is required.

Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@google.com>
---

(no changes since v1)

 doc/mgmt-api.txt | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1aa43d6c3c..d5c7169630 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3800,6 +3800,58 @@ Add Extended Advertising Data Command
 				Busy
 
 
+Add Advertisement Patterns Monitor With RSSI Threshold Command
+==============================================================
+
+	Command Code:		0x0056
+	Controller Index:	<controller id>
+	Command Parameters:	Pattern_Count (1 Octet)
+				RSSI_Data {
+					High_Threshold (1 Octet)
+					High_Threshold_Timer (2 Octets)
+					Low_Threshold (1 Octet)
+					Low_Threshold_Timer (2 Octets)
+					Sampling_Period (1 Octet)
+				}
+				Pattern1 {
+					AD_Type (1 Octet)
+					Offset (1 Octet)
+					Length (1 Octet)
+					Value (31 Octets)
+				}
+				Pattern2 { }
+				...
+	Return Parameters:	Monitor_Handle (2 Octets)
+
+	This command is essentially the same as Add Advertisement Patterns
+	Monitor Command (0x0052), but with an additional RSSI parameters.
+	As such, if the kernel supports advertisement filtering, then the
+	advertisement data will be filtered in accordance with the set
+	RSSI parameters. Otherwise, it would behave exactly the same as the
+	Add Advertisement Patterns Monitor Command.
+
+	Devices would be considered "in-range" if the RSSI of the received adv
+	packets are greater than High_Threshold dBm for High_Threshold_Timer
+	seconds. Similarly, devices would be considered lost if no received
+	adv have RSSI greater than Low_Threshold dBm for Low_Threshold_Timer
+	seconds. Only adv packets of "in-range" device would be propagated.
+
+	The meaning of Sampling_Period is as follows:
+		0x00	All adv packets from "in-range" devices would be
+			propagated.
+		0xFF	Only the first adv data of "in-range" devices would be
+			propagated. If the device becomes lost, then the first
+			data when it is found again will also be propagated.
+		other	Advertisement data would be grouped into 100ms * N
+			time period. Data in the same group will only be
+			reported once, with the RSSI value being averaged out.
+
+	Possible errors:	Failed
+				Busy
+				No Resources
+				Invalid Parameters
+
+
 Command Complete Event
 ======================
 
-- 
2.29.2.684.gfbc64c5ab5-goog


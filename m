Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73E6C2BB48
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A4D223D6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgLOIeO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgLOIeI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 03:34:08 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B830CC06179C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:33:52 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id t12so5970083qvj.19
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ysLBobFr8GxqKLoEfZPdZgTcru3jgCHsWlSFO8OjU38=;
        b=N5VR7MbfJxCNGCNogcgMTpn6CzyKMwtvlCKGrrtM019WQeadJVs+vP/tV29M5YPkTc
         XuUzL+youhQcFysYnUarIi/M2wwXZhD/y3vLKURw8yJBEUBObMbZMl5VjLzajhsZlG65
         tLvOywB4NwxXr4DPa0Ffn3NPmzH4MkT8zwaO7pduq6DX8qnKLQwAfsrJ2g9mR0E9ZfJg
         /3VAWa981wRQ8DYwUdb7BjiiuqPk6bwUhatCedBedLu7eCmsMi6X6SBvLcmvlbWkSaFK
         OoS9tgDKVw4U2ITC5EzBpK4a1GnYkEmrWwSzKIYFB6B3SYV13UYi0MuNqdUu1b+FXP0C
         UoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ysLBobFr8GxqKLoEfZPdZgTcru3jgCHsWlSFO8OjU38=;
        b=M60TcpiSYtK572ilKwJFXLTgArV23WtwxI9J/Lmjre6fKgY8Zehvkc8Xs5HJTM0LGV
         GyzdTbj+0q9T+C4ZkiaGQZBxTnBTiYCubeDerJ/70NX/XNe7ZEKR3gThmwjouhFg2bHy
         KNgfYwbskBe0DykAvGIA4PnDjDRZde3zITL9EAqT9A3XGJO79Hr4+g3ObhBAxGjzq+1m
         kHw+eOlVTobGoYEPdPj1oH9eY45zlGypGfbgnedX/rao4bLTcsNJ2j775CHuC1w6qWPX
         W6aJx4PRXW4/2pY6+UhAVzNgbs19LvNtESHpbO/GjsJX0Se1U4sFIMJfcMv/Tpw+93hY
         3/lA==
X-Gm-Message-State: AOAM533VJsbLKjzhqp3gMdBt41vhg6sX5hFUCFeEQLaOwskQxrpOkQ1n
        izWhykGfgGr36zg3ZFaslAQSV/K0UjoDulmrSuptLLdkPofmY2TKcBD97qb97leZJ1Fb876s0Zs
        S557zDb5NUkrHvmZLnbdo8nUoCfsNcCKBAVHiqLxKouPYJ2yCiOeCFbR/oR8u4UzGn2bqKXHMwZ
        oT
X-Google-Smtp-Source: ABdhPJxz94/yx2ndeHogN1gv4manFFqseEhHcX7N3lhfGikMLNoT8qK3xl8wAOI574TIk0C18sh5JAOXTm5e
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:e6c6:: with SMTP id
 l6mr36464380qvn.2.1608021231770; Tue, 15 Dec 2020 00:33:51 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:33:44 +0800
Message-Id: <20201215163328.Bluez.v1.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [Bluez PATCH v1 1/2] doc/mgmt-api: Add opcode for adding
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

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
---

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


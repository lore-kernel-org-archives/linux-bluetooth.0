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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4A9C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 03:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF81F23139
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 03:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgLPDnz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 22:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPDnz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 22:43:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B44C061793
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 19:43:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b123so11739778ybh.17
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 19:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=pWI4LIsyBGd3o3E/FH7vJMe4v8uJev1Bxi956bCFK2o=;
        b=eR21wfdUWoWDWr+GBt2oWkTrreEHc017qH9YfMRA/cCKEtQYloYuAe/Lk5ZpsDBt9j
         fo+ArqQbkovwHwbm4XusbmD9Lcld+4yDksKoy9BkEd37n2rUXrHQApC/8GO/DQXUzir7
         MAj2ZK1r/NhowkVRglMSfJ+Jwx4aRIelTrBoHtOA9g4Q0ep5A0GYN3gldjahlzig3XT1
         4wf39oT8Se8kpX2dm0wJeSL467AiMySyyeE5CgQPbSBybQowG6mPRDWTinhAopuemCAW
         SiseCssPJvDCjzqM9rICdh7mtIvMG4xVk6ujZrR34wso2Ugn3x++KBw6mC+sGTwufZHQ
         0a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=pWI4LIsyBGd3o3E/FH7vJMe4v8uJev1Bxi956bCFK2o=;
        b=B1gyKIMnnMK0AquVPu3/oRgA+cQ0D3QFGj95EjI6Tr9NVdk7FcItiICeHAagRzN22V
         SADajMBEIXVsvQU6a3vlsqTKP84YwOc6+g70EN6Pvn+Cm7LLFdt3mIE54eZzJjf7W0Cu
         0WrqxcVX+a309sz6ltQ+dEynmggVMU7rMPz7y1IPfXnRGqPb75aVbPpqRI7Cc1gOhRKO
         utV6dYgrLIOCYWT676mMNqyimd1SrZr5m6H9vYJTN01NgKsvikLo0fRwysRKVtHNi9eJ
         0zLbJj1F7VIbtb2EgnE3WIiVPr+bLDMOWawuMJyQXmRfEcEMIZZ232WEb6JZIM+hUBtt
         7c6g==
X-Gm-Message-State: AOAM530lUHnWj/c9KNJwlL/yt92IGXGrDzVCG4ayWP5Va4v/e+vvvMTP
        cpnSEFiCnOKVZDQAzd8k94GVc6l37Y9Cy2hxmQqNfrbbBz9BLc7pQmud7Dwt1R/HCwhb79FdFVd
        BUqquptrSDiM8/4NJFRJoZuZObNoPhO5JVj33ETrPKPu0BKHj6S4OX+KbknxfVjIVwB0Hi831SA
        fT
X-Google-Smtp-Source: ABdhPJwRwXIg1f6srZNqMXBK+xko4BpUalEvhlUrsotlcYBlJ44aBsmC/ob74jjjYE0bwT+N+pYYlctNmqV9
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:cc92:: with SMTP id
 l140mr49829609ybf.252.1608090193951; Tue, 15 Dec 2020 19:43:13 -0800 (PST)
Date:   Wed, 16 Dec 2020 11:42:56 +0800
Message-Id: <20201216114231.Bluez.v3.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [Bluez PATCH v3 1/2] doc/mgmt-api: Add opcode for adding
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

Changes in v3:
* Flip the order of rssi data and pattern count

 doc/mgmt-api.txt | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1aa43d6c3c..1736ef009e 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3800,6 +3800,58 @@ Add Extended Advertising Data Command
 				Busy
 
 
+Add Advertisement Patterns Monitor With RSSI Threshold Command
+==============================================================
+
+	Command Code:		0x0056
+	Controller Index:	<controller id>
+	Command Parameters:	RSSI_Data {
+					High_Threshold (1 Octet)
+					High_Threshold_Timer (2 Octets)
+					Low_Threshold (1 Octet)
+					Low_Threshold_Timer (2 Octets)
+					Sampling_Period (1 Octet)
+				}
+				Pattern_Count (1 Octet)
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


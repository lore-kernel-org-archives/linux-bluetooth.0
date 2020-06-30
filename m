Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A1DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 07:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0812073E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 07:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgF3HTj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:19:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:22972 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgF3HTi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 03:19:38 -0400
IronPort-SDR: PCUva+ChqwvKwLZxJIfA/y3pJue23KbZR8Y7qoQQySn9sCOMdGPUMV7l5uTEBuclS7GKCBrjk+
 CmUliHyslYjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133613600"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="133613600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:19:38 -0700
IronPort-SDR: jbDsrz4VkK7LuNbGdpzqJm5OOFDZdpVIg+or/QHeOukAsjtEGJVAiQWzTHOfS3hPdK03Ip21St
 eJA7Gu8x258A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="355698463"
Received: from sdkini-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.110.226])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2020 00:19:38 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/4] doc/mesh-api: Add dictionary to model properties
Date:   Tue, 30 Jun 2020 00:19:33 -0700
Message-Id: <20200630071936.40437-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630071936.40437-1-inga.stotland@intel.com>
References: <20200630071936.40437-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes the signature of "Models" and "VendorModels" properties
on org.bluez.mesh.Element1 interface to contain a dictionary with
model options.

Models: signature change "aq" -> "a(qa{sv})"
VendorModels: signature change "a(qq)" -> "a(qqa{sv})"

Currently, the defined keywords for the options dictionary are
"Publish" - indicates whether the model supports publication mechanism.
            If not present, publication is enabled.
"Subscribe" - indicates whether the model supports subscription mechanism.
            If not present, subscriptions are enabled.

The dictionary allowed to be empty.
---
 doc/mesh-api.txt | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 3be11e342..495f95b0b 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -888,15 +888,43 @@ Properties:
 		Element index. It is required that the application follows
 		sequential numbering scheme for the elements, starting with 0.
 
-	array{uint16} Models [read-only]
+	array{(uint16 id, dict caps)} Models [read-only]
 
-		An array of SIG Model Identifiers. The array may be empty.
+		An array of SIG Models:
 
-	array{(uint16, uint16)} VendorModels [read-only]
+			id - SIG Model Identifier
 
-		An array of pairs (vendor, model ID): vendor is a 16-bit
-		Bluetooth-assigned Company ID as defined by Bluetooth SIG.
-		model ID is a 16-bit vendor-assigned Model Identifier
+			options - a dictionary that may contain additional model
+			info. The following keys are defined:
+
+				boolean Publish - indicates whether the model
+					supports publication mechanism. If not
+					present, publication is enabled.
+
+				boolean Subscribe - indicates whether the model
+					supports subscription mechanism. If not
+					present, subscriptons are enabled.
+
+		The array may be empty.
+
+
+	array{(uint16 vendor, uint16 id, dict options)} VendorModels [read-only]
+
+		An array of Vendor Models:
+
+			vendor - a 16-bit Bluetooth-assigned Company ID as
+			defined by Bluetooth SIG.
+
+			id - a 16-bit vendor-assigned Model Identifier
+
+			options - a dictionary that may contain additional model
+			info. The following keys are defined:
+
+				boolean Publish - indicates whether the model
+					supports publication mechanism
+
+				boolean Subscribe - indicates whether the model
+					supports subscription mechanism
 
 		The array may be empty.
 
-- 
2.26.2


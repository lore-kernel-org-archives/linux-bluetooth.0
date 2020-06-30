Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A099C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710162067D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgF3S4U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:56:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:57132 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgF3S4U (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 14:56:20 -0400
IronPort-SDR: lSjb/vKyQfKfsiquppXIKvMymr3s/C6MqKMLtL4gOUKEigS4S5FfQX4vm5K5tIgj4ZkxQ41Wxx
 IePXfJPIJmnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="231222955"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="231222955"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 11:56:20 -0700
IronPort-SDR: L6rWgbEQzsSc2Y9vgiJc4OFQLTySxJd3KnZ2/HVDDGdQNaAUkOSSbOPDCpBGRDdcWLsgetYQ1f
 EtsSxNCbL9Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="355864252"
Received: from mlindstr-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.108.27])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2020 11:56:20 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 1/4] doc/mesh-api: Add dictionary to model properties
Date:   Tue, 30 Jun 2020 11:56:14 -0700
Message-Id: <20200630185617.14755-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630185617.14755-1-inga.stotland@intel.com>
References: <20200630185617.14755-1-inga.stotland@intel.com>
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


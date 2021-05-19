Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0739EC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEB6611BF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhESSXc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:23:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:32191 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231367AbhESSXb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:23:31 -0400
IronPort-SDR: tq3uyetoQbDlIM0z6OifqnopVg0I3RAO91QAZPmrKWpaAmE3KZQ4icWhWoiIVCCp9nHhqJ4wFR
 DbIfQEKfPflQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188175126"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188175126"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:10 -0700
IronPort-SDR: QLx7tLkIRlkoE8K8uHL7J6APZRIdiP2owKUjV2vKDvXvQZ6dPE8I9Um7lJFKcujo9ouZjj8frL
 YpxOt1TPmpUA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="439838657"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.229.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:09 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 4/5] test/mesh: Add support for testing more OOB auth
Date:   Wed, 19 May 2021 11:21:49 -0700
Message-Id: <20210519182150.1680987-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210519182150.1680987-1-brian.gix@intel.com>
References: <20210519182150.1680987-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To pass IOP testing, we need to be able to support Input OOB and Out of
band Public Key exchange,  This patch adds agent methods to support
those capabilities, but are turned off because the test code uses
insecure fixed values instead of randomized values.
---
 test/agent.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/test/agent.py b/test/agent.py
index b46cd95f4..57a74183d 100755
--- a/test/agent.py
+++ b/test/agent.py
@@ -35,7 +35,9 @@ class Agent(dbus.service.Object):
 		caps = []
 		oob = []
 		caps.append('out-numeric')
+		#caps.append('in-numeric') -- Do not use well known in-oob
 		caps.append('static-oob')
+		#caps.append('public-oob') -- Do not use well known key pairs
 		oob.append('other')
 		return {
 			AGENT_IFACE: {
@@ -56,6 +58,27 @@ class Agent(dbus.service.Object):
 		print(set_cyan('DisplayNumeric ('), type,
 				set_cyan(') number ='), set_green(value))
 
+	@dbus.service.method(AGENT_IFACE, in_signature="s", out_signature="u")
+	def PromptNumeric(self, type):
+		# Sample in-oob -- DO-NOT-USE
+		value = 12345
+		print(set_cyan('PromptNumeric ('), type,
+				set_cyan(') number ='), set_green(value))
+		return dbus.UInt32(value)
+
+	@dbus.service.method(AGENT_IFACE, in_signature="", out_signature="ay")
+	def PrivateKey(self):
+		# Sample Public/Private pair from Mesh Profile Spec DO-NOT-USE
+		private_key_str = '6872b109ea0574adcf88bf6da64996a4624fe018191d9322a4958837341284bc'
+		public_key_str = 'ce9027b5375fe5d3ed3ac89cef6a8370f699a2d3130db02b87e7a632f15b0002e5b72c775127dc0ce686002ecbe057e3d6a8000d4fbf2cdfffe0d38a1c55a043'
+		print(set_cyan('PrivateKey ()'))
+		print(set_cyan('Enter Public key on remote device: '),
+										set_green(public_key_str));
+		private_key = bytearray.fromhex(private_key_str)
+
+		return dbus.Array(private_key, signature='y')
+
+
 	@dbus.service.method(AGENT_IFACE, in_signature="s", out_signature="ay")
 	def PromptStatic(self, type):
 		static_key = numpy.random.randint(0, 255, 16)
-- 
2.25.4


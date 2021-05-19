Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7A7C43462
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 19:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3504613AD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 19:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhESTLD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 15:11:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:6666 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231916AbhESTLA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 15:11:00 -0400
IronPort-SDR: +3rjVoc2yAoKRWGPVVz0IxD5loLKGbGITM7YLkqHp4Ck3bgy+f+hUgwSRAxsl+787oIC+HqNTm
 8sm0lRij6HZQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="262284401"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262284401"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 12:09:37 -0700
IronPort-SDR: wkYeBk1EtFJHN0eFblwU2Jn6CCBA20ct5H52GUK/54WjjmGBpb5IYOX1ZoktVNXbwo3GKS3aQq
 AGkq+q9BbsPQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="439855270"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.229.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 12:09:37 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 4/6] test/mesh: Add support for testing more OOB auth
Date:   Wed, 19 May 2021 12:09:23 -0700
Message-Id: <20210519190925.1723012-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210519190925.1723012-1-brian.gix@intel.com>
References: <20210519190925.1723012-1-brian.gix@intel.com>
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


Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D90C0044D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 22:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8080920749
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 22:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgCKWhP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:37:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:15609 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbgCKWhO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 18:37:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="415722331"
Received: from ingas-nuc1.sea.intel.com ([10.251.157.250])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2020 15:37:14 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] test/test-mesh: Add support for static OOB in the agent
Date:   Wed, 11 Mar 2020 15:37:12 -0700
Message-Id: <20200311223712.31784-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows to display a 16-octet key to be entered on the remote
device during provisioning.
---
 test/agent.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/test/agent.py b/test/agent.py
index 778dbe092..af9edd35c 100755
--- a/test/agent.py
+++ b/test/agent.py
@@ -3,6 +3,7 @@
 import sys
 import dbus
 import dbus.service
+import numpy
 
 try:
   from termcolor import colored, cprint
@@ -17,6 +18,12 @@ AGENT_PATH = "/mesh/test/agent"
 
 bus = None
 
+def array_to_string(b_array):
+	str_value = ""
+	for b in b_array:
+		str_value += "%02x" % b
+	return str_value
+
 class Agent(dbus.service.Object):
 	def __init__(self, bus):
 		self.path = AGENT_PATH
@@ -27,6 +34,7 @@ class Agent(dbus.service.Object):
 		caps = []
 		oob = []
 		caps.append('out-numeric')
+		#caps.append('static-oob')
 		oob.append('other')
 		return {
 			AGENT_IFACE: {
@@ -46,3 +54,14 @@ class Agent(dbus.service.Object):
 	def DisplayNumeric(self, type, value):
 		print(set_cyan('DisplayNumeric ('), type,
 				set_cyan(') number ='), set_green(value))
+
+	@dbus.service.method(AGENT_IFACE, in_signature="s", out_signature="ay")
+	def PromptStatic(self, type):
+		static_key = numpy.random.randint(0, 255, 16)
+		key_str = array_to_string(static_key)
+
+		print(set_cyan('PromptStatic ('), type, set_cyan(')'))
+		print(set_cyan('Enter 16 octet key on remote device: '),
+							set_green(key_str));
+
+		return dbus.Array(static_key, signature='y')
-- 
2.21.1


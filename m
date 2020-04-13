Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C578C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AEF2063A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgDMRpy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:45:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:34746 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbgDMRpy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 13:45:54 -0400
IronPort-SDR: TjQZtp3mkjKwWeBak/n0J5c7iGVqgO9neJK/H4V2EOh0sbhHXhs1a+7eCulwXCPIrxUh7zkBVF
 No5bl4KCgS9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 10:45:51 -0700
IronPort-SDR: 8w/5K/JM9pOmoUGafBsU/e7SXny4q7T94w+sdyZmWIALG9YaM2FvDHfi6ZJqaeWi6Fj4zw6rWT
 e1kuhy0/NaVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399679935"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.135.23.176])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 10:45:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com, przemyslaw.fierek@silvair.com
Subject: [PATCH BlueZ v4 1/4] doc/mesh: Change API to deliver tokens via JoinComplete
Date:   Mon, 13 Apr 2020 10:45:32 -0700
Message-Id: <20200413174535.21488-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413174535.21488-1-brian.gix@intel.com>
References: <20200413174535.21488-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>

If Application is not be able to reliably store the token, the daemon
will end up with a uncontrollable node in its database.

Let's fix the issue by always delivering tokens using JoinComplete call,
and expecting a reply - if the application return an error, daemon will
get rid of the node.
---
 doc/mesh-api.txt | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 6ecb81650..0522d97dc 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -29,6 +29,10 @@ Methods:
 		therefore attempting to call this function using already
 		registered UUID results in an error.
 
+		When provisioning finishes, the daemon will call either
+		JoinComplete or JoinFailed method on object implementing
+		org.bluez.mesh.Application1 interface.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists,
@@ -123,7 +127,7 @@ Methods:
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 
-	uint64 token CreateNetwork(object app_root, array{byte}[16] uuid)
+	void CreateNetwork(object app_root, array{byte}[16] uuid)
 
 		This is the first method that an application calls to become
 		a Provisioner node, and a Configuration Client on a newly
@@ -155,11 +159,14 @@ Methods:
 		unicast address (0x0001), and create and assign a net_key as the
 		primary network net_index (0x000).
 
+		When creation finishes, the daemon will call JoinComplete method
+		on object implementing org.bluez.mesh.Application1 interface.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists,
 
-	uint64 token Import(object app_root, array{byte}[16] uuid,
+	void Import(object app_root, array{byte}[16] uuid,
 				array{byte}[16] dev_key,
 				array{byte}[16] net_key, uint16 net_index,
 				dict flags, uint32 iv_index, uint16 unicast)
@@ -204,11 +211,8 @@ Methods:
 		The unicast parameter is the primary unicast address of the
 		imported node.
 
-		The returned token must be preserved by the application in
-		order to authenticate itself to the mesh daemon and attach to
-		the network as a mesh node by calling Attach() method or
-		permanently remove the identity of the mesh node by calling
-		Leave() method.
+		When import finishes, the daemon will call JoinComplete method
+		on object implementing org.bluez.mesh.Application1 interface.
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments,
@@ -758,6 +762,10 @@ Methods:
 		permanently remove the identity of the mesh node by calling
 		Leave() method.
 
+		If this method returns an error, the daemon will assume that the
+		application failed to preserve the token, and will remove the
+		freshly created node.
+
 	void JoinFailed(string reason)
 
 		This method is called when the node provisioning initiated by
-- 
2.21.1


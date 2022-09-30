Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92D8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 11:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiI3LJs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiI3LJX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 07:09:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11251BE780
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664534758; x=1696070758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=weArQEE1+BAZ7Td37iXcT7Dn5h69cCu0jphqGbByJuE=;
  b=BO/HRZ17QILiFFylylVzQ49lF6AquSFRstmdA83xXTnehCbbkzM48Wyi
   nmSBSXjapGqPqH8IFNY8SOnRuimYMTNGaAkAhiIrsYE2frudKE4omNGol
   VroT1z80rEajgjGDKsfrRLd1Koezs4SNpoEoOlyIB3mwnX2XbpPEQ/vCL
   BYva3UHGFRThIA+XNhRcc8ivOtCw6yRVKAkDwP9KjkqMw08in16PujctW
   SU9pToe9DCjfGsh7Z169T44OKTJEv7Nbyv01CpKJQ3K/PfiY3BofagQTX
   +qFivfXI1c2r2pHHdqoBtQmgx8oPtEOrBv4eqzYDxm7l81XpjGeBot36m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="364005050"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="364005050"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="573825050"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="573825050"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2022 03:44:44 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 3/3] profiles: Register callback function to update volume
Date:   Fri, 30 Sep 2022 16:15:23 +0530
Message-Id: <20220930104523.2572-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220930104523.2572-1-sathish.narasimman@intel.com>
References: <20220930104523.2572-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Callback function has to be registered to call
media_transport_update_device_volume to change transport volume.
---
 profiles/audio/vcp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index b42b0a4f79dd..4b790b03c032 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -50,6 +50,7 @@
 #include "src/service.h"
 #include "src/log.h"
 #include "src/error.h"
+#include "transport.h"
 
 #define VCS_UUID_STR "00001844-0000-1000-8000-00805f9b34fb"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
@@ -83,6 +84,20 @@ static struct vcp_data *vcp_data_new(struct btd_device *device)
 	return data;
 }
 
+static void vr_set_volume(struct bt_vcp *vcp, int8_t volume, void *data)
+{
+	struct vcp_data *user_data = data;
+	struct btd_device *device = user_data->device;
+
+	DBG("set volume");
+
+	media_transport_update_device_volume(device, volume);
+}
+
+static struct bt_vcp_vr_ops vcp_vr_ops = {
+	.set_volume	= vr_set_volume,
+};
+
 static void vcp_data_add(struct vcp_data *data)
 {
 	DBG("data %p", data);
@@ -94,6 +109,7 @@ static void vcp_data_add(struct vcp_data *data)
 
 	bt_vcp_set_debug(data->vcp, vcp_debug, NULL, NULL);
 
+	bt_vcp_vr_set_ops(data->vcp, &vcp_vr_ops, data);
 	if (!sessions)
 		sessions = queue_new();
 
@@ -178,6 +194,7 @@ static void vcp_attached(struct bt_vcp *vcp, void *user_data)
 	data->vcp = vcp;
 
 	vcp_data_add(data);
+
 }
 
 static int vcp_probe(struct btd_service *service)
-- 
2.25.1


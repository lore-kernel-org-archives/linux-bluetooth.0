Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D5CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 09:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiI3J7D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiI3J65 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 05:58:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EB187354
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664531937; x=1696067937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=weArQEE1+BAZ7Td37iXcT7Dn5h69cCu0jphqGbByJuE=;
  b=QIbXcoGuP7BNOPMzlsSk+MtAdIzlCVni0SCDUlMhx2ImXyxDObXQvB9s
   J1yuJQTwPC/S4z/M5/FNgNCinnH5ugB46FX0hrItB7/nPWDbY7tUNrGjh
   iuwx9w+79/cbhON8yQSmsP1wN5DW6z+D04vn6Jj2fTlOGtKnoorOqnBiM
   c9moCiuSEPMkWNyQKw5ISbURDc5Nxs6lZvvyRl+aGzCO8e/olc9xeB+v3
   KzqFdQ6RtUxRi1DFfdHwhFdogfSJ6X86YSDVZW/nPTxaO+8dOVPauRX9B
   ajOB6+goUiNApm3ySGkGj2kVj3x5MEB4cQQGllccq/YZHQ9nqE702tmLK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="299756640"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="299756640"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 02:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="711743764"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="711743764"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Sep 2022 02:58:55 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 3/3] profiles: Register callback function to update volume
Date:   Sat,  1 Oct 2022 00:19:54 +0530
Message-Id: <20220930184954.108937-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220930184954.108937-1-sathish.narasimman@intel.com>
References: <20220930184954.108937-1-sathish.narasimman@intel.com>
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


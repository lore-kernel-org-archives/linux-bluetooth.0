Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67313C00A98
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 14:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377529AbjJTONo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 10:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377419AbjJTONn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 10:13:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955EA1A8
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697811221; x=1729347221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iUOfA+abYciVODA+PW1TPL5pUtyOvPBYkEvwRJEFPvY=;
  b=PuN3nbvZpPwPlIhpjIpWvJLxtSw0FNRTlq/hWSgTGrEKKwamLvhbcuoe
   KZwxEC7kSQ5hHYCWoT0eSXRYBniQWZ0yRbTaEPXs5wSmTv967COIqzOhG
   MqYPBWwxVG0dc2joSenxJDXXmjvfLwSV/oGIFzEkPMrlhk8iKtfwQnQDL
   0SWCvbrcRSg9Z/EbyALStwEEWIbkgOZy44p0TOy4fTWAzBf+SUE+cHkHg
   MHWZ2nFEVuxZxrSxS1S73Y+5fYFzqSVc7x0XYxYR3URAxOZlg+7NrsQnq
   IfDJBPpvM7gX3oyGFHhcwgu1XwHMsaR42gWTbsC5T41pwl/eOR3l8datj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="365840850"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="365840850"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 07:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088756470"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088756470"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2023 07:13:40 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/5] media: Populate location to qos structure
Date:   Fri, 20 Oct 2023 19:55:50 +0530
Message-Id: <20231020142554.486629-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow clients to register Location for endpoint.
---
 profiles/audio/media.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 1d98ac5a1a70..d0520d3216c9 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1609,6 +1609,10 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			if (var != DBUS_TYPE_UINT16)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, &qos->ppd_max);
+		} else if (strcasecmp(key, "Location") == 0) {
+			if (var != DBUS_TYPE_UINT32)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, &qos->location);
 		}
 
 		dbus_message_iter_next(props);
@@ -2799,6 +2803,13 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_basic(&iter, &qos.ppd_min);
 	}
 
+	if (g_dbus_proxy_get_property(proxy, "Location", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &qos.location);
+	}
+
 	endpoint = media_endpoint_create(app->adapter, app->sender, path, uuid,
 						delay_reporting, codec,
 						vendor.cid, vendor.vid, &qos,
-- 
2.34.1

